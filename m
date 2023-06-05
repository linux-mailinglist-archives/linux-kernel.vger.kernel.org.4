Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E41E722D53
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbjFERIQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Jun 2023 13:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235358AbjFERIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:08:06 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9359118;
        Mon,  5 Jun 2023 10:07:57 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-977fae250easo12103366b.1;
        Mon, 05 Jun 2023 10:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685984876; x=1688576876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZGakePAKwplYG/llAo4FkXZmbuykUNqGGuE67aJlhQ=;
        b=KTpptja4t1+u8XTBddwp9PinJ+O4rVQoO5vWUOVOR1abYPyI4G7uHQ0SVxLKFXB+E2
         kRoDK9UemuyRf5MMhvlSTeJ/prK51BR7IbaDWmbErgXSl0BKGz1lLqgAlcwIO1hHcVAd
         gZuKQO+XTGt0M4fOA8WkCgdJhHB9wWX/gms4XyB2NgzPSgwC/fuo02GQOuZ851BPOLwQ
         ZI2CmPBHkAaCr9A4e7/s8zoSc+Z7ukn0GNSleM6UsuBCqMWYM2m+sZ9qPWzzlTGn/18s
         WuQtKbhwgWYuUpdCBVvTviTk3eFlwfRmD46Ob/7WHw1iY4sfuLC9le3IZfg3uNiBxuRI
         VzCg==
X-Gm-Message-State: AC+VfDx6AQ4dnDDFs5EIfkdCpaU1+GvPDOZiLsoUkFHFhzO9Bts76CqW
        FhtLK3/BN4cWJXsOiL2VXwYbYg6tsZw3C8i+IxA=
X-Google-Smtp-Source: ACHHUZ4y6QX2tq8E27by6YkCxR3PmJMiktMABs4n4JVAUpCSd+lhY388IXN+mErboDW/wtCtUakJxEJ57qmSY1TQ/Zc=
X-Received: by 2002:a17:906:778a:b0:977:ead3:c91 with SMTP id
 s10-20020a170906778a00b00977ead30c91mr1215071ejm.1.1685984875965; Mon, 05 Jun
 2023 10:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230516201415.556858-1-arnd@kernel.org> <780579b5-3900-da14-3acd-a4d24e02e4ba@intel.com>
In-Reply-To: <780579b5-3900-da14-3acd-a4d24e02e4ba@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Jun 2023 19:07:44 +0200
Message-ID: <CAJZ5v0hPLnFmWiv2DHh=U0FHkeu0A8yTwz7Mn8=jfenrP6wFGA@mail.gmail.com>
Subject: Re: [PATCH 1/3] acpi: nfit: add declaration in a local header
To:     Dave Jiang <dave.jiang@intel.com>, Arnd Bergmann <arnd@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>,
        nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 5:22 PM Dave Jiang <dave.jiang@intel.com> wrote:
>
>
>
> On 5/16/23 1:14 PM, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The nfit_intel_shutdown_status() function has a __weak defintion
> > in nfit.c and an override in acpi_nfit_test.c for testing
> > purposes. This works without an extern declaration, but causes
> > a W=1 build warning:
> >
> > drivers/acpi/nfit/core.c:1717:13: error: no previous prototype for 'nfit_intel_shutdown_status' [-Werror=missing-prototypes]
> >
> > Add a declaration in a header that gets included from both
> > sides to shut up the warning and ensure that the prototypes
> > actually match.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Applied as 6.5 material, thanks!

> > ---
> >   drivers/acpi/nfit/nfit.h | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
> > index 6023ad61831a..573bc0de2990 100644
> > --- a/drivers/acpi/nfit/nfit.h
> > +++ b/drivers/acpi/nfit/nfit.h
> > @@ -347,4 +347,6 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
> >   void acpi_nfit_desc_init(struct acpi_nfit_desc *acpi_desc, struct device *dev);
> >   bool intel_fwa_supported(struct nvdimm_bus *nvdimm_bus);
> >   extern struct device_attribute dev_attr_firmware_activate_noidle;
> > +void nfit_intel_shutdown_status(struct nfit_mem *nfit_mem);
> > +
> >   #endif /* __NFIT_H__ */
