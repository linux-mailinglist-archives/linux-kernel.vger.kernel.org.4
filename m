Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A7B613725
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiJaM5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiJaM5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:57:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F557FD15;
        Mon, 31 Oct 2022 05:57:01 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9E5336602387;
        Mon, 31 Oct 2022 12:56:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667221020;
        bh=qUMc+7j+1tBRezz89d7ayJZy1Z0iXhHJQcr9IuHgvBI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PBV+TEZ4Tf6RzSZfbnD6LD13qW50nJpafAra+k9BQPUBPQOuOXs8nank8YVH8BUBA
         EYmMTU0+tl/xgvyN9YSKe7VYAfg4WbRfJnppgkomKaakhXV9hn0LLUgvFJFFAO32Si
         Cm3fXx/6HYpu9OxKWhWQ8+6E8KnuNwCvg3H1sEi2mLs5pdK1c7HKzoRLIN53R9GOzv
         qVlvdUA0IgJTq3sMh3jR2whXpQ1mhUPGtGimQSlxELmAUMBuZ0EAlktFUlavK4X2XH
         y199cnJi4axyL0cDtg1xfxezsPskgORKzsOOUAMWL+Oq468LMkGFUVDVFfyGmpYfEN
         y3SDpkVdx/Hhg==
Message-ID: <30e04ec6-3702-0b56-d475-365974fa04a6@collabora.com>
Date:   Mon, 31 Oct 2022 13:56:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 8/8] arm64: dts: qcom: sc7180-trogdor: Remove VBAT supply
 from rt5682s
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     kernel@collabora.com, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221028205540.3197304-1-nfraprado@collabora.com>
 <20221028205540.3197304-9-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221028205540.3197304-9-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/10/22 22:55, Nícolas F. R. A. Prado ha scritto:
> These devicetrees override a rt5682 node to use the rt5682s compatible,
> however, unlike rt5682, rt5682s doesn't have a VBAT supply. Remove the
> inexistent supply in the rt5682s nodes.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> 
>   arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi          | 1 +
>   .../dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts     | 1 +
>   .../dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts     | 1 +
>   3 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi
> index 74f0e07ea5cf..e0fb83a9a0b1 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi
> @@ -11,6 +11,7 @@
>   
>   &alc5682 {
>   	compatible = "realtek,rt5682s";
> +	/delete-property/ VBAT-supply;

I really dislike seeing /delete-property/ but I don't know if changing all of the
non-kingoftown and non-wormdingler devicetrees is worth the noise...

Any strong opinions on that?

Regards,
Angelo

