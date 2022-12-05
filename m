Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3FF642D74
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiLEQqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbiLEQpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:45:38 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8718C35
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:44:46 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b3so19494875lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 08:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lskTxKH+t6SUryPNvJXQQ0pZb/SpXRtbjFLLir4Ar4M=;
        b=LrR7ogg+ecgNfv1NCRwIL0j22WGHuhcG25cwmQFRPBpxTt7GT1X8BSFy4xxV/STO12
         7lMN1Dtzoec/2ZTkSMvM+r6L/dsboolQ62y4E5R+bYicqEwqeAXJLfaLMh7D66QIiBoI
         YDWOY9V0fdyYFUFwPWkgZOsn+4q1trEEVM5Ee4VFOhF1wpF6w40KriZxX7zMOyOD1680
         7s/9l78J9AJQBOuDcs2T/OKoO8SkLYzW79dX7J4/3uyu1k7Ot8D5MBmgL0Guv4xNkus/
         +HwStbmSSY97hppUcr7wXWbQPdcJVxGKpF+YtRt/o5LIEiaqtxUPUgWhMjQUnmU+wl3h
         kU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lskTxKH+t6SUryPNvJXQQ0pZb/SpXRtbjFLLir4Ar4M=;
        b=1tcWrFKxwrUtFyhfz6iTIcrG2wQzJ3+pJvu9Bfzhvz+FqkMPvhKw7cDd6bA9Pym839
         JSQk/gcFKo/XiK5RK3eFP3LQOuK4BEqYr9atSRsW+Gm6EW6Z/fdiZbsrPaZpYp5ioz0d
         rcdQTDY/FZ5JWIIXE83fz3zK/5pSBhZWOIrE1MXEEnRTnBlkh68VfuDlSAjJDZQnQo+a
         wTLN/qE8gmqYgaz5zqBq2Byv0VyaDt/XZlOA3H6H8NFjEjuFDiFPACfm5ATUOH6IoB/e
         BtqWc3eadn3mUugBF0/+8W7odTUlxwWC5VeZkp7dA4KKlI24HPJmWm9k2mc7PS3ZXJKY
         s5dw==
X-Gm-Message-State: ANoB5plYVXcUFy6nhEB2CDf1XeO+Cj+GArHmqv4EI/mkaH4GGjso6OyX
        ATyQTCV/sZonSEWXzgXkHlyoeQ==
X-Google-Smtp-Source: AA0mqf7aaa+iyHbN5guJ5DZaq0bWlf+dyX+2CkS4vLp8/0MczFDO+EraDsfZeovoeMOqgX49Tf8E6g==
X-Received: by 2002:a05:6512:2382:b0:4a2:70de:3546 with SMTP id c2-20020a056512238200b004a270de3546mr21326771lfv.420.1670258685066;
        Mon, 05 Dec 2022 08:44:45 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bu31-20020a056512169f00b00499b27a329esm1328342lfb.300.2022.12.05.08.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 08:44:44 -0800 (PST)
Message-ID: <853d49f9-cd97-e8a0-53fd-9f673c2720a1@linaro.org>
Date:   Mon, 5 Dec 2022 18:44:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 10/11] arm64: dts: qcom: sm8350-hdk: Enable display &
 dsi nodes
Content-Language: en-GB
To:     Robert Foss <robert.foss@linaro.org>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        quic_kalyant@quicinc.com, angelogioacchino.delregno@somainline.org,
        loic.poulain@linaro.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, vkoul@kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        vinod.koul@linaro.org, quic_jesszhan@quicinc.com,
        andersson@kernel.org
References: <20221205163754.221139-1-robert.foss@linaro.org>
 <20221205163754.221139-11-robert.foss@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221205163754.221139-11-robert.foss@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2022 18:37, Robert Foss wrote:
> Enable the display subsystem and the dsi0 output for
> the sm8350-hdk board.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> index e6deb08c6da0..39462c659c58 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> @@ -213,10 +213,32 @@ &cdsp {
>   	firmware-name = "qcom/sm8350/cdsp.mbn";
>   };
>   
> +&dispcc {
> +	status = "okay";
> +};
> +
> +&dsi0 {

Bjorn suggested using mdss_dsi0 / mdss_dsi0_phy labels for DSI host and 
PHY, as it allows us to group them nicely. WDYT?

> +	vdda-supply = <&vreg_l6b_1p2>;
> +	status = "okay";
> +};
> +
> +&dsi0_phy  {
> +	vdds-supply = <&vreg_l5b_0p88>;
> +	status = "okay";
> +};
> +
>   &gpi_dma1 {
>   	status = "okay";
>   };
>   
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_mdp {
> +	status = "okay";
> +};
> +
>   &mpss {
>   	status = "okay";
>   	firmware-name = "qcom/sm8350/modem.mbn";

-- 
With best wishes
Dmitry

