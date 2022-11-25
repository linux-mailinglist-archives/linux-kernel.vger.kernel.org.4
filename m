Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8899F638516
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiKYISq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiKYISo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:18:44 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF1E20345
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:18:43 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id z4so5633620wrr.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qDmdqp6SW6HdFWgspk0DWIhPAU8t3Np9ZdtMMl7oOME=;
        b=CCHdYELQT1M8w4EtFrJ2Y7fmtaPgnfa+7fnzY6yF6NSfwsfqUC9hhrJeb4T1FthHx2
         2/0T9VRuj7VXQTIvdJBg+2ccKz5yGMVHx8GhXfVL2HOav+QIsXQqWj21E7hY+jj88/Ng
         KxxPkjnETI7qmhspWN5cMT8LjeN7YgayYM5DmSjXbLQvOCWJ/y+1bwZ9JRNOAwQymafn
         8q4cDH0G54vCv8jvCoxYSDVU9r7cMMWIjztu2J4uw4MprSXynW1B4nCRMXULy78a8tUm
         H0HP2SBOIUmWm5o/iemOrpAev5DeOheYhzfW1Iu9UV1iOYEE/ZBbrpVOZM5CP8+eE0sR
         tyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDmdqp6SW6HdFWgspk0DWIhPAU8t3Np9ZdtMMl7oOME=;
        b=gBTVrRUEC9a7DO7rUxIFjnuWrYq3wloz09yNnJWzKHoMqinChTVvYyfyPR1bai++C2
         OmvXn6YpoPVjnhmCELq0L8/htZ1xZvAPtfZgUXcZB3Ilp6ZZ4I1ivnkqyaT+h0Yt/kVF
         3/k/+jUr01EJXgwFcuT7+6gI9DGhzrcVk6kpprdVhcCT6jpdprd/THUxfSph48UVWPVw
         s9AWVTiR6XeQ+FovrVDO2yYVjFxWVcKpmTmCIdNXVqdxx7yTfemrABfbPZzLpl6T+O3V
         5HT9jTOHtBQLxRtA53lSVeeQpssdjyYnKyeUhfR9R5UOaPjmXFSiBEABfqYiQ5BQ72W8
         MD1g==
X-Gm-Message-State: ANoB5pkJ1nPmbtzlp3hPleVS2KoUk4Uew+sIIjdwWixrf324fvhAgp7r
        ITDFqWxv5WRGH8syJul8tZ2cJw==
X-Google-Smtp-Source: AA0mqf5XuJU+9BN9OybWW9e8Vo2SZBCkORxZk42hiu7opuMRYNfY4D/Qh2JkoX4RRScVpiBDsEVCdQ==
X-Received: by 2002:adf:e5c6:0:b0:236:7921:e10e with SMTP id a6-20020adfe5c6000000b002367921e10emr22040365wrn.61.1669364321538;
        Fri, 25 Nov 2022 00:18:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:84a5:7e09:b15:f1fe? ([2a01:e0a:982:cbb0:84a5:7e09:b15:f1fe])
        by smtp.gmail.com with ESMTPSA id m24-20020a05600c3b1800b003cf47556f21sm9683549wms.2.2022.11.25.00.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 00:18:41 -0800 (PST)
Message-ID: <e4ea8291-f733-775e-e2d1-79c5f887fa5b@linaro.org>
Date:   Fri, 25 Nov 2022 09:18:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: qcom: msm8996-tone: Fix USB taking 6 minutes
 to wake up
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221124220147.102611-1-konrad.dybcio@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20221124220147.102611-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2022 23:01, Konrad Dybcio wrote:
> The hardware turns out to be pretty sluggish at assuming it can only
> do USB2 with just a USB2 phy assigned to it - before it needed about
> 6 minutes to acknowledge that.
> 
> Limit it to USB-HS explicitly to make USB come up about 720x faster.
> 
> Fixes: 9da65e441d4d ("arm64: dts: qcom: Add support for SONY Xperia X Performance / XZ / XZs (msm8996, Tone platform)")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> No words.
> 
>   arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
> index 12a7b6d91dbe..0ab9687f3406 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
> @@ -991,10 +991,6 @@ touch_int_sleep: touch-int-sleep-state {
>   	};
>   };
>   
> -/*
> - * For reasons that are currently unknown (but probably related to fusb301), USB takes about
> - * 6 minutes to wake up (nothing interesting in kernel logs), but then it works as it should.
> - */
>   &usb3 {
>   	status = "okay";
>   	qcom,select-utmi-as-pipe-clk;
> @@ -1003,6 +999,7 @@ &usb3 {
>   &usb3_dwc3 {
>   	extcon = <&usb3_id>;
>   	dr_mode = "peripheral";
> +	maximum-speed = "high-speed";
>   	phys = <&hsusb_phy1>;
>   	phy-names = "usb2-phy";
>   	snps,hird-threshold = /bits/ 8 <0>;


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
