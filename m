Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE76A64C1FE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 02:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbiLNBtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 20:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236960AbiLNBtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 20:49:11 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A1E2250D;
        Tue, 13 Dec 2022 17:49:11 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id j206so19875950ybj.1;
        Tue, 13 Dec 2022 17:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xExdyQDhYTgV1IdxIuGP7o71ehB3CFKVoLy9PDmyibI=;
        b=CpQZevHLxrKv/1hgs+V2M6cSkSoV06F4lrYnaOXQP0TPCfiOv3a3XN/FUVsGLczONc
         Xoat0JVF6aWTnCtcoy0u8DaFnXLbOjr0GHowLyZMrkgrzMTSZuQb7jBkg29up3JFdnwb
         z1xpRhcvLh6rCbteub8Jcjve+YrOKZGEMD7u0Lze3jmBJXrFTkMX5NNiAeXpg7USuUsU
         H40QWeWHAWUskJKHXI/uEl0ZGO7h/DpvUk2CvRbW29DwT9GxFM07swURLZpZdI4fbjpV
         Hlq89BIEjgQzeMI9bDbAYiB6D/gX0qGIS3aqm628+LMHVQ3l5rrxI4O+dCFluPi5Hu0T
         Q+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xExdyQDhYTgV1IdxIuGP7o71ehB3CFKVoLy9PDmyibI=;
        b=cwuv0Nf/p/uJONpAcA45/3uH2+4a4TdlD8rz9leCiXuDfghCFEsIGb5nyS4JbHdYQi
         4PVR5mQOk139lRT32JBbalVg1+HLd39qRkhD41Vv555po3LmmHO4SqqF0VcNucD+rKcD
         3A+bbCHJiUoyMhmPUVhNuVtOKLYX5YeV2Qi6JzF2kUxyTx6MD3Dz5GawvhHCCBVUs68p
         tRUkTrLbKtF1lLH9o2CJHCSvQCOGuVmHqafVNKarOV1khHlcUqAIT47rxYNvXFTaxjNr
         3UIX2//xwkoCgszNhRX8ULeGsRJckejfIa4SKOgACY0d5scfTqQ7+Ki9bL2mV4fOpCbZ
         qiGw==
X-Gm-Message-State: ANoB5pm/sC5m0EP5Vq/1/90W1qRzAMXFphxWitQh68p4etb8kb5C0Ic7
        nAOcBt1O3u0q3SQy6DMeMBtAUM3n49CkM78R/LrYtuBh
X-Google-Smtp-Source: AA0mqf6aVToRrr31IEWqBS+HG0H/EHpXHAs4dR9uyadBVst6sowJPiHa9e2nz4BE/XZPJEaRMOKC5NsyelGKuryt+Ws=
X-Received: by 2002:a25:6b4e:0:b0:6f9:91bd:c5de with SMTP id
 o14-20020a256b4e000000b006f991bdc5demr41309865ybm.497.1670982550268; Tue, 13
 Dec 2022 17:49:10 -0800 (PST)
MIME-Version: 1.0
References: <b2ada465-8eec-a7e3-0265-df9d0e8492d2@gmail.com>
In-Reply-To: <b2ada465-8eec-a7e3-0265-df9d0e8492d2@gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 13 Dec 2022 17:48:59 -0800
Message-ID: <CAMo8Bf+8Bn7pNNbBbXgphfe41Kxx7cHb9LTtBexy15mpL8hKuw@mail.gmail.com>
Subject: Re: [PATCH] arch: change variable types to match those of what is
 assigned to them
To:     Seija Kijin <doremylover123@gmail.com>
Cc:     sstabellini@kernel.org, tsbogend@alpha.franken.de,
        chris@zankel.net, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Seija,

On Tue, Dec 13, 2022 at 4:51 PM Seija Kijin <doremylover123@gmail.com> wrote:
>
> There are many places where "int len = strlen(foo);" is written, just for len to be passed as a parameter of size_t.

[...]

> diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
> index 10b79d3c74e0..3159917ffd2f 100644
> --- a/arch/xtensa/platforms/iss/console.c
> +++ b/arch/xtensa/platforms/iss/console.c
> @@ -64,7 +64,7 @@ static int rs_write(struct tty_struct * tty,
>   static void rs_poll(struct timer_list *unused)
>   {
>       struct tty_port *port = &serial_port;
> -    int i = 0;
> +    size_t i = 0;

This is not what happens here at all.

-- 
Thanks.
-- Max
