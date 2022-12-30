Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AC6659692
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 10:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbiL3JM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 04:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbiL3JMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 04:12:55 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F411A383
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 01:12:52 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b3so31004713lfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 01:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U8m08wd2vDX8ay+lo65k2BbC5GMWrcKUp9ctsSVUIqs=;
        b=s7pMjuIQWKB4M+Qnch9uGyog9Va5JvOv1kgRUeKdRjfoHEmvfcknx/2UfRSwdMDGUX
         MrRfu8gptKD7+lacqMrIGQW29LABOBEpEyX7yC4tmrQ0wnYHqno+zSl1jHx/Z2kXJn1/
         0LVghMFx+Qvlq5ZuGjYlR+SMvPDnm/tzMATlzoJ5LGmh6XcM15yyu8au+7dnNOX1MoQH
         /YiuMn5OlrIGiQV0C104cMUOTW9A6EIBhojoEW1kFFFvXz7T8euAxFr0yyBnf5viUebV
         DChwn+lBDtyrjhyURSoggd5vbDmZR6r0DJxkZF3eUdT85t+ktHSPd5ZYROSUaCGV3acK
         yxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U8m08wd2vDX8ay+lo65k2BbC5GMWrcKUp9ctsSVUIqs=;
        b=IH1XnONp1fMo6VbYTU/8p4AexTaPytUhXEyO7BAzvEe7mudw+ab2JjBYyc8jwoSlNU
         /ShBcGFuWes7Ao0emMX3MbWXUPaAaaIamIm0eD4FzpTwzTrQsmCpes5z+FQ6vRZf30kA
         hSs4OT6rHaQtDB32gGky1AE3XJ5UbpmRChfCn/avUllhr+ejysf+k01Ke9lyXAy5jkDU
         ic7hJSh8MsCIlEuhcc/8Gby3PjHjP31K4JRk96qEgJ5l+7kLpAgFat3hIecatD6lVPmI
         f0ACBcNhVqV1Ox296ktAwwQuJqx6fg8I0IktfmamKP1XveLB9rVMrqMjOj/WRSOWDyWT
         IwsQ==
X-Gm-Message-State: AFqh2krqQGzV9rr/s7CpYyWOCWx4SEQmTOIgnxJQF6b/Jt75u6QkaS5i
        rUHaMRXM2V6vO1CeXxwLukpH6Z8SNZ3REN8c
X-Google-Smtp-Source: AMrXdXs9oq+R0PbV1NHmE5MAQN80YkxJP/ew/rTsagiQaX9yzC/vjPqitxm4OOz4jLi31y45Spuvxw==
X-Received: by 2002:ac2:5dfa:0:b0:4b5:41fa:69d8 with SMTP id z26-20020ac25dfa000000b004b541fa69d8mr9169080lfq.16.1672391570694;
        Fri, 30 Dec 2022 01:12:50 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id u12-20020ac258cc000000b0049fff3f645esm3379965lfo.70.2022.12.30.01.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Dec 2022 01:12:50 -0800 (PST)
Message-ID: <61cb9bab-aefb-cd45-acb0-ef846a411d76@linaro.org>
Date:   Fri, 30 Dec 2022 10:12:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: sm6115: Add missing reg-names
 property for UFS
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <me@iskren.info>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20221209-dt-binding-ufs-v2-0-dc7a04699579@fairphone.com>
 <20221209-dt-binding-ufs-v2-1-dc7a04699579@fairphone.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221209-dt-binding-ufs-v2-1-dc7a04699579@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.12.2022 08:42, Luca Weiss wrote:
> The UFS driver expects the second reg to be named "ice" otherwise the
> Inline Crypto Engine won't get enabled.
> 
> Fixes: 97e563bf5ba1 ("arm64: dts: qcom: sm6115: Add basic soc dtsi")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?h=for-next&id=01b6041454e8bc4f5feb76e6bcdc83a48cea21f2

Konrad
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 572bf04adf90..85673d562723 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -704,6 +704,7 @@ opp-202000000 {
>  		ufs_mem_hc: ufs@4804000 {
>  			compatible = "qcom,sm6115-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
>  			reg = <0x04804000 0x3000>, <0x04810000 0x8000>;
> +			reg-names = "std", "ice";
>  			interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
>  			phys = <&ufs_mem_phy_lanes>;
>  			phy-names = "ufsphy";
> 
