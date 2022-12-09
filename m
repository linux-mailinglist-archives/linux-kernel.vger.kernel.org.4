Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB2064801F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 10:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiLIJbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 04:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiLIJbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 04:31:34 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDD9554F0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 01:31:33 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso7554998pjt.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 01:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FnCXrrIbp7jPgWc1kp96LfASpdYMLa403vqSppawnNo=;
        b=mFq5sb5mJpP5bHmwdYC+vWEPnlhNMXm1xU/q4p6bgHoHBfopVu00xljT5Nrrmhlio0
         702CHzUHXiJu2RXzgBD/C65kDPDgZKCawbXmhTRQYVUyV5+T4ItLqmCriCdeKbAdZPO0
         XF80NWWTM8QY68P3HjnS4C1p/OfJ17KPdMHw3IchAp+/H7p9e0gWHhh131DWenIRMhaX
         RM+6yg3eybX8LCEnx1ugt+y4PcJNHskWxcisrg0M0p05nqAOkxdIx3xc7oPRqjGyEnXY
         ufpquj++vwoYVxbJkg4LMlWqQQugm/98XhsvvoBfUxP7ISH09KP4ZTWXUoEb6XYO9mZm
         MyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FnCXrrIbp7jPgWc1kp96LfASpdYMLa403vqSppawnNo=;
        b=jO4jDMPXFMjUcbhM8E0t8v8GGsOid6/A8bgZYGtv1+v7IIYKDjQVbiQbkZkWlUIJbT
         znKsTmMukn5TeVaxR6/rYdfvbkXqYhZ8YjnrEgr9U2x1FXTmqbxuG56nkgjzPB3LXLSL
         eFekz99R+Wr6IuJcdcjMUQfA/01qcAdlma1pvNFpDYYKEdI4pDT5FuzeV7TxYxERgP8q
         m4vUHkN083bMsN102mcVl6CMDUy4I4jyjNwjhF4sGc480X1+8eDXvmzDA78cn0IMAu+A
         lU8fPhCVd/n5IGpYMDvXBAZiBdugQDZnYWSRk4jfXySMeH7HUA7Hj+ah+lSsy6kH/c7R
         0dkQ==
X-Gm-Message-State: ANoB5plzcQ1vf13+vXcDnUjDO9EQbuwhC9NgW0D6Va689QgajW1TWZ+u
        CU3zKfu0PhaNobC2W9xNWCbXBN5bhzjVp7a/F0/brw==
X-Google-Smtp-Source: AA0mqf7H9hjPq6c0t0+6RxhdrNLF+NbMazljfHFsFnfFrWRbagm2uO+4AVR/HnNIMJ2i0V4+T5ysJUEr981Gvqvu0gY=
X-Received: by 2002:a17:90a:43a4:b0:219:1d0a:34a6 with SMTP id
 r33-20020a17090a43a400b002191d0a34a6mr5804202pjg.1.1670578292579; Fri, 09 Dec
 2022 01:31:32 -0800 (PST)
MIME-Version: 1.0
References: <20221209034134.38477-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20221209034134.38477-1-jiapeng.chong@linux.alibaba.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Dec 2022 10:30:55 +0100
Message-ID: <CAPDyKFqtfnbx0vTVtiD7sbG0tOh8L0U0vOMjOvm_ERPNNBGYDg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: Modify mismatched function name
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Dec 2022 at 04:41, Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> No functional modification involved.
>
> drivers/mmc/host/sdhci-of-esdhc.c:243: warning: expecting prototype for _fixup(). Prototype was for esdhc_writel_fixup() instead.
> drivers/mmc/host/sdhci-of-esdhc.c:117: warning: expecting prototype for _fixup(). Prototype was for esdhc_readl_fixup() instead.
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3397
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 9d875bb531a8..4712adac7f7c 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -98,7 +98,7 @@ struct sdhci_esdhc {
>  };
>
>  /**
> - * esdhc_read*_fixup - Fixup the value read from incompatible eSDHC register
> + * esdhc_readl_fixup - Fixup the value read from incompatible eSDHC register
>   *                    to make it compatible with SD spec.
>   *
>   * @host: pointer to sdhci_host
> @@ -223,7 +223,7 @@ static u8 esdhc_readb_fixup(struct sdhci_host *host,
>  }
>
>  /**
> - * esdhc_write*_fixup - Fixup the SD spec register value so that it could be
> + * esdhc_writel_fixup - Fixup the SD spec register value so that it could be
>   *                     written into eSDHC register.
>   *
>   * @host: pointer to sdhci_host
> --
> 2.20.1.7.g153144c
>
