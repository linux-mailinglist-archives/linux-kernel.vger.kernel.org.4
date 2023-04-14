Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01066E2899
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjDNQoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjDNQog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:44:36 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D26C99
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:44:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w24so8552959wra.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681490673; x=1684082673;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ExngqUZl/pg1Kd6E34uU7m6iwz6q/2qwB8gBrD6lrQ=;
        b=GhkswUhAKDkCiKoc9t/eyiaF53+6JyxpB18rycr+qlp/lNeetlGLuu6GC3ZG8hfb3p
         fqfpoGQ1pqAOcdlI8Y+sJ72mfNnaJ4FPwqnqMuQ+izLObeSwa41gXQt8sJodv5jGa/0T
         DCHyxVmFTXoiZAJKFeYg2l3HyO7R7QqyznuMMRwhr31tpWeC+kKGYa4XZgae5wk9hU5v
         VC7eE6Gxz4FTNBR5+PHuTW33T3KogEu+IssYXh1wsleN/owJgoVClrGYWJ1UOi2BxTfn
         OAH2m6K62WkIgosirUt4RSz7l1iPN9jNIyueDp5i7cjxMfGJCzjb0B8HHgaz47wDrAyd
         iNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681490673; x=1684082673;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ExngqUZl/pg1Kd6E34uU7m6iwz6q/2qwB8gBrD6lrQ=;
        b=GnS0pWqeRXWnmPW5JWDVB115scIpYqX2KcBFMbFHPrtc/FXQWDQbR1lkMuGBkmjClS
         +c1ph1jMfMiBJsGLhcwBkMKM8rSFeZDYwSerNZpfNkN+Lbxmhs19ul/rlKTiTcVopS75
         lgGQtRd+6M4XUtM2226nLHLwgysaNHbRXIUywAkrgV9GJz0TtzifWnx6isgRzlCKEMWN
         e9bCO1fL7EXhz0V1vRoyDIsAr6c0tGjHS+eT29tK/jcVnIaNqjVVTcRrkabmUaOs3XQ1
         MnLVOVzSAKDyZd1dIwHtE3auAmCBzPwjO8SAhK6homSEo1OkCUwHyT5qdhrXW0824hML
         tt/Q==
X-Gm-Message-State: AAQBX9eaqML9YQFWY88r/7UvtARkcW+7f9dpOKJi2Cv17Xuyorl2yCMx
        NknKKt3aUS3fPOGm0qiyhEQ=
X-Google-Smtp-Source: AKy350bpkl/XH9EejX97SLMedFqNtcocLz0dofiURStn1ZlIYfmxrsXsRPyGC/UDwV0n9ZyuKK9coQ==
X-Received: by 2002:adf:ed45:0:b0:2f7:faa0:3f19 with SMTP id u5-20020adfed45000000b002f7faa03f19mr349951wro.28.1681490673410;
        Fri, 14 Apr 2023 09:44:33 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id r16-20020a056000015000b002f21a96c161sm3936139wrx.70.2023.04.14.09.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 09:44:32 -0700 (PDT)
Message-ID: <8e40e46a-edf4-96c5-7248-21f39a93a410@gmail.com>
Date:   Fri, 14 Apr 2023 18:44:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/2] phy: mediatek: hdmi: mt8195: fix uninitialized
 variable usage in pll_calc
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20230413-fixes-for-mt8195-hdmi-phy-v2-0-bbad62e64321@baylibre.com>
 <20230413-fixes-for-mt8195-hdmi-phy-v2-1-bbad62e64321@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230413-fixes-for-mt8195-hdmi-phy-v2-1-bbad62e64321@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/04/2023 18:07, Guillaume Ranquet wrote:
> The ret variable in mtk_hdmi_pll_calc() was used unitialized as reported
> by the kernel test robot.
> 
> Fix the issue by removing the variable altogether and testing out the
> return value of mtk_hdmi_pll_set_hw()
> 
> Fixes: 45810d486bb44 ("phy: mediatek: add support for phy-mtk-hdmi-mt8195")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

Looks good, but got unfortunately already fixed 4 hours ago with
20230414122253.3171524-1-trix@redhat.com

:)

Regards,
Matthias

> ---
>   drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> index abfc077fb0a8..054b73cb31ee 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> @@ -213,7 +213,7 @@ static int mtk_hdmi_pll_calc(struct mtk_hdmi_phy *hdmi_phy, struct clk_hw *hw,
>   	u64 tmds_clk, pixel_clk, da_hdmitx21_ref_ck, ns_hdmipll_ck, pcw;
>   	u8 txpredivs[4] = { 2, 4, 6, 12 };
>   	u32 fbkdiv_low;
> -	int i, ret;
> +	int i;
>   
>   	pixel_clk = rate;
>   	tmds_clk = pixel_clk;
> @@ -292,13 +292,9 @@ static int mtk_hdmi_pll_calc(struct mtk_hdmi_phy *hdmi_phy, struct clk_hw *hw,
>   	if (!(digital_div <= 32 && digital_div >= 1))
>   		return -EINVAL;
>   
> -	mtk_hdmi_pll_set_hw(hw, PLL_PREDIV, fbkdiv_high, fbkdiv_low,
> +	return mtk_hdmi_pll_set_hw(hw, PLL_PREDIV, fbkdiv_high, fbkdiv_low,
>   			    PLL_FBKDIV_HS3, posdiv1, posdiv2, txprediv,
>   			    txposdiv, digital_div);
> -	if (ret)
> -		return -EINVAL;
> -
> -	return 0;
>   }
>   
>   static int mtk_hdmi_pll_drv_setting(struct clk_hw *hw)
> 
