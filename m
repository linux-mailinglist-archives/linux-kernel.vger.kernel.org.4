Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060EE62BD43
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbiKPML0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbiKPMLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:11:09 -0500
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358A245A00;
        Wed, 16 Nov 2022 04:04:21 -0800 (PST)
Received: by mail-qk1-f177.google.com with SMTP id v8so11402207qkg.12;
        Wed, 16 Nov 2022 04:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQdBkxqg5BqsUvdY+IvEe5QBnPb9zU/ugVGD23aN9Pc=;
        b=lA+a75CIx0a7kotuRQ0WHl9kLQ1WRRjlysJF3v7et1wK3rJPpQ64Gk6DnjW0BsEWKi
         riMopdW6/yGUwG4GMKv80fPNuNOBV40QQYPGSPILjC2qhXDBgTJkw7MCQEEiXMp6ymoG
         aMF7mbp3qhmjjoY/Ov1fenyeweAWlvJehESgx9Lo9VnI+fBzTTJc7s+U9qFdBdE1Csgz
         WrleRzFxcusuRIrb8XLF/5/MoGLmbp4PNnmRofN+S6RE35j8y9ll4Wd6ORQ22jMLSpDt
         NiZIh5S9SHg6BB4us5m2u7gOP69ScHABhj9X7WskzpcQN1lcUWzjdYkC6oXduyt6gXku
         0cGA==
X-Gm-Message-State: ANoB5pkevG5i1DgcdgqKfrTPJDujoo3OgJ4lA7N8HKk1UugS7D2nwt0p
        hkG0llLWKaXkCPor2xm6sfHlR/Qb1ZyYTCQBJXZ/rpNy
X-Google-Smtp-Source: AA0mqf6yT2vd1Aqocqi53J5J3FryjVqUIUHcxPUW5lEr/cSGo6jsIlR1imANAiZRmrxh3QOsZPojLDJpr14dvqZYtEg=
X-Received: by 2002:a37:638f:0:b0:6ec:fa04:d97c with SMTP id
 x137-20020a37638f000000b006ecfa04d97cmr18174937qkb.764.1668600260287; Wed, 16
 Nov 2022 04:04:20 -0800 (PST)
MIME-Version: 1.0
References: <20221116075736.1909690-1-vishal.l.verma@intel.com>
In-Reply-To: <20221116075736.1909690-1-vishal.l.verma@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Nov 2022 13:04:07 +0100
Message-ID: <CAJZ5v0hP9p+0gWNKaOD=3FW3SDrb3ZXWaUyqVGx_GVzkapeUSA@mail.gmail.com>
Subject: Re: [PATCH 0/2] ACPI: HMAT: fix single-initiator target registrations
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, liushixin2@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 8:57 AM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Patch 1 is an obvious cleanup found while fixing this problem.
>
> Patch 2 Fixes a bug with initiator registration for single-initiator
> systems. More details on this in its commit message.
>
>
> Vishal Verma (2):
>   ACPI: HMAT: remove unnecessary variable initialization
>   ACPI: HMAT: Fix initiator registration for single-initiator systems

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for both and please feel free to ask Dan to take them.

Alternatively, if you want me to apply them, please let me know.

>  drivers/acpi/numa/hmat.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
>
>
> base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
> --
