Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43F962C3EA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbiKPQSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiKPQST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:18:19 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA0957B58
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:18:18 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so2738709pjc.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3vuu78aZaHK7VJ8++7/BN17PpF7VX0jC0oheW36hmIs=;
        b=uuC6XXHVG9Amxc061f3zNUOSdEnIEF4TjDWOnctoTMuFscut4Itv7mLnBGqCfgs0al
         L+c/6HzzyuYppun8NsFwkMKhAp5vuR0lJkvjp0Yz5s3NOtHEoezqavVS9o1XoDOkXRp2
         nqljq8Xzfl5NVYp/FgHWjOUh+fYjzcJCl7moBfmRkCKQLPemXAavMLERLsUbzejrOh3g
         sGecALTxxhB0T3feWWlLZDsacHgB4UyWhkhOqkh529nWjGvMUHJ+j4rmzbEUntYWrui9
         +lVi3b7o7oneBIJGhYCYDGHbBxGQ56+iebIAoJY2gK5JwDxBEF9X3O2nublK5wBYf97X
         8/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vuu78aZaHK7VJ8++7/BN17PpF7VX0jC0oheW36hmIs=;
        b=DYQnTqilftyk+l0lL7ZU8pt0F68efg3tjOPJi74H+GqpgQqpg933afCqJ8Ur9o7UE8
         kxHtqT3zl7JfTtQ6TrvNBD1ojfXmb3VgtTCSitAulSqR9WuCd67oagfVo27mqRVsNy6u
         cBdqS57FJ6w0bO6Dty5kUsu6jj8K2I/2ErnTI5EM4bSzOp+5FecQaTp676j3EPRgVM9j
         UB2tLb/23elEszVtrDFSpBpBi5lrcgJCixvpxcTsWIGhMq468UTp0xVY2/P8MSGZom0h
         WYEJkDlZtutzWJcGWWXgCO2u6WQ1gRclcSJRho002LQMq2UfzQtaQnb3dmpb7fOvukGE
         7bEg==
X-Gm-Message-State: ANoB5pkwAdyAeoecRNQvtEW+Nzq1kM+dpSGTRItKOoVrfb5BoiAMc0DC
        lNf3PbcfTMJ6cMMoAxbYWup/8WuVNxaQl1evSQa2AA==
X-Google-Smtp-Source: AA0mqf4Wa1H27TGFSnM/a1m63gk9/L+t2q1xko8YOBEh2/dkruP1K3xLmmg6L38tevF4sFxaktwBmh2GNWgpZ2zVkB4=
X-Received: by 2002:a17:902:d48a:b0:188:6baf:2011 with SMTP id
 c10-20020a170902d48a00b001886baf2011mr9115763plg.165.1668615498412; Wed, 16
 Nov 2022 08:18:18 -0800 (PST)
MIME-Version: 1.0
References: <20221110072819.11530-1-yuzhe@nfschina.com>
In-Reply-To: <20221110072819.11530-1-yuzhe@nfschina.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Nov 2022 17:17:41 +0100
Message-ID: <CAPDyKFrW+FaDNc+YPjrR1eAYhjPc6BHj4zqghBRnMC0P+A_jKA@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: fix two spelling mistakes in comment
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     chaotian.jing@mediatek.com, matthias.bgg@gmail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 at 08:29, Yu Zhe <yuzhe@nfschina.com> wrote:
>
> spelling mistake fix : "alreay" -> "already"
>                        "checksume" -> "checksum"
>
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index df941438aef5..a10aca76dfb3 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -735,7 +735,7 @@ static inline void msdc_dma_setup(struct msdc_host *host, struct msdc_dma *dma,
>                 else
>                         bd[j].bd_info &= ~BDMA_DESC_EOL;
>
> -               /* checksume need to clear first */
> +               /* checksum need to clear first */
>                 bd[j].bd_info &= ~BDMA_DESC_CHECKSUM;
>                 bd[j].bd_info |= msdc_dma_calcs((u8 *)(&bd[j]), 16) << 8;
>         }
> @@ -1212,7 +1212,7 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
>                      !host->hs400_tuning))
>                         /*
>                          * should not clear fifo/interrupt as the tune data
> -                        * may have alreay come when cmd19/cmd21 gets response
> +                        * may have already come when cmd19/cmd21 gets response
>                          * CRC error.
>                          */
>                         msdc_reset_hw(host);
> --
> 2.11.0
>
