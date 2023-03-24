Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9046C7EEA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjCXNfl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Mar 2023 09:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjCXNf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:35:28 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE71219104
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:35:25 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id x3so7955896edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679664924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZB6DZFd6qnXYBDsKXCDDwgJlp/iQM/qFc6nOODmrOiA=;
        b=x7iuXiwAQW1sw/aEyv8TqfgVMdB3FkOzv5V5H99ersws9oOlaF1tJYhikJCCx3/pbZ
         X+T+n9KBEaJOdL1S25ILqaADEBllKI1ZWHLqtNolYbescvigG3/hMk0pYv6SHVV5504Y
         5kOq7QVKLZ9EkHAaP94qAWPt/yDFNLTiXpEjcxqvuSTOyTWJAxIa0eDTviqXE/5rHZ/J
         PKHw+Cr38QI7vEiFkdbYcTQwHlUcc+ThOaQgJ9AVyD87WGAUn9u/2qnpVJ08rj8TOb8F
         1+of9C3LPz7li/oPsN22vFp9Gvk8Dx8xXDsA5AMSR1viKTyEWs4K5Ivmh4SFreEl67lX
         p4Cg==
X-Gm-Message-State: AAQBX9chQtjXQieOx3N6YelyGJ+GKAtdNaU3R/KJf2/mI1PsnbuEwFNB
        uH1uGSvfCOlpD3tv2UqJ7YT+nIPLC6SXcwf/dIufUdszqis=
X-Google-Smtp-Source: AKy350ZKOG2/yEOeWQbacpe2hm/Uj/d3tH3DIB5ji3GPeZiGztQok1qWJgZ3chq3ktdRUEv+TGIM65OG+opVz5uhCTs=
X-Received: by 2002:a17:906:9f0b:b0:8b1:38d6:9853 with SMTP id
 fy11-20020a1709069f0b00b008b138d69853mr1316350ejc.2.1679664924178; Fri, 24
 Mar 2023 06:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230324122711.2664537-1-gregkh@linuxfoundation.org>
In-Reply-To: <20230324122711.2664537-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Mar 2023 14:35:12 +0100
Message-ID: <CAJZ5v0gPL9Zk65tXvc7hxySNdJgCj-si84mBq0iiHTHv7dmuXA@mail.gmail.com>
Subject: Re: [PATCH 1/6] driver core: device.h: remove extern from function prototypes
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 1:27 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> The kernel coding style does not require 'extern' in function prototypes
> in .h files, so remove them from include/linux/device.h as they are not
> needed.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

for this one and the rest of the series.

> ---
>  include/linux/device.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 3b23772d3bbb..472dd24d4823 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1088,8 +1088,7 @@ void device_link_remove(void *consumer, struct device *supplier);
>  void device_links_supplier_sync_state_pause(void);
>  void device_links_supplier_sync_state_resume(void);
>
> -extern __printf(3, 4)
> -int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
> +__printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
>
>  /* Create alias, so I can be autoloaded. */
>  #define MODULE_ALIAS_CHARDEV(major,minor) \
> --
> 2.40.0
>
