Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E984E66C2A4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjAPOtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjAPOrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:47:37 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6679828871
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:30:52 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id f34so42952881lfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FfL1rVHDvcSxq21lIwQ1cVLhrZd9L/JhJuc4PCIC8nU=;
        b=CchHai/iJRYFn4LKvm3pW4qreXW+SBnXT3kIfvtg3kVhjJ5YtyHVANMeRUTFP0gDrd
         Vq7vrVwPahBmOOf8N7i9XIvFcZqelr5/SvXZFMEIOxxH1U92dxJlmaLn2INXiOtB2gFW
         FlTJPOSp/vxGj0P+es8Pf6ElxmpLVFUaOE1ZKMnPB1zCcI1WtYFHG70KHbPMoo47nEfL
         hI80jNweqN1yLYd8sowB5132UttoPRk7TrOcPh3+hcQ41guPoF/dseMy1kn9FuiVR/N+
         wTFwjqSy6MkUuGvMuZ4OSd5Prx/r92lll2modapw34qtFUhqiLJV5LUydkDWdn9NbrNW
         LFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FfL1rVHDvcSxq21lIwQ1cVLhrZd9L/JhJuc4PCIC8nU=;
        b=GG5hOiV2JXQuBtSVa2enCgGRlSY7KRiwftH66sUYxaHyOP9fVhf1fs1kLnCF+TkguW
         HO00WAwYrxVGtg42sU2KNuY4HF8B74dEXRzHBw75v3pzPKONt1BbPkF/ppYQIdUjazzL
         FNZPXJKBGimLqncF52uWsQ0QR1rgGve55wJCbQKX3yT6DRwsP+1U8oDVZTiDYYEDK+fW
         w/9JtfNx0fboyKeONQaKRszeh5rHa6k9GQovlPWgYXvK3nclPP1lw7Z5WdBwJ0sB6ufa
         2r19XrJLOgi8gevL3qxbJjQm4grJ5DmeBY6wdXIjGDjiJ47cuCqZfYMX8nd8zg0mi2YL
         /PMA==
X-Gm-Message-State: AFqh2krnky2ReboiSLdz6tLbhDC0bl5cr3wKNEe9uwZYZI60/tVXxAjY
        xC5EU7jQuF5NXVqkzdXKP0O+2/mkkfJAWPaq
X-Google-Smtp-Source: AMrXdXu8DclfWAJXndWel0CtWy44QcgmXIgzXCYr54I9YAIGmYNHxg/3tnjFyeZKYk9PncF5IJw9AQ==
X-Received: by 2002:a19:6514:0:b0:4d0:a746:5c6d with SMTP id z20-20020a196514000000b004d0a7465c6dmr2921041lfb.14.1673879450655;
        Mon, 16 Jan 2023 06:30:50 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id r16-20020ac252b0000000b004cc716da978sm4959959lfm.209.2023.01.16.06.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 06:30:50 -0800 (PST)
Message-ID: <6145353d-0d33-7bca-c3eb-f635519a948e@linaro.org>
Date:   Mon, 16 Jan 2023 15:30:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 6/6] arm64: dts: qcom: msm8998: Configure CPRh
Content-Language: en-US
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230116093845.72621-1-konrad.dybcio@linaro.org>
 <20230116093845.72621-7-konrad.dybcio@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230116093845.72621-7-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.01.2023 10:38, Konrad Dybcio wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> Now that the CPR v3/v4/Hardened is ready, enable it on MSM8998.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> [Konrad: separate from adding cpufreq, sort nodes and use lowercase hex]
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
[...]
> +	cpu0_opp_table: opp-table-cpu0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-1900800000 {
> +			opp-hz = /bits/ 64 <1900800000>;
> +			required-opps = <&cprh_opp22>;

> +			qcom,pll-override = <0x094f004f>;
> +			qcom,spare-data = <3>;
As Dmitry pointed out to me in private, these properties belong
to the CPUFREQ patch and - with this series alone - are considered
undocumented.

Konrad
> +		};
> +
> +		opp-1824000000 {
> +			opp-hz = /bits/ 64 <1824000000>;
> +			required-opps = <&cprh_opp21>;
> +			qcom,pll-override = <0x084c004c>;
> +			qcom,spare-data = <3>;
> +		};
> +
> +		opp-1747200000 {
> +			opp-hz = /bits/ 64 <1747200000>;
> +			required-opps = <&cprh_opp20>;
> +			qcom,pll-override = <0x08490049>;
> +			qcom,spare-data = <2>;
> +		};
> +
> +		opp-1670400000 {
> +			opp-hz = /bits/ 64 <1670400000>;
> +			required-opps = <&cprh_opp19>;
> +			qcom,pll-override = <0x08460046>;
> +			qcom,spare-data = <2>;
> +		};
> +
> +		opp-1555200000 {
> +			opp-hz = /bits/ 64 <1555200000>;
> +			required-opps = <&cprh_opp18>;
> +			qcom,pll-override = <0x07410041>;
> +			qcom,spare-data = <2>;
> +		};
> +
> +		opp-1478400000 {
> +			opp-hz = /bits/ 64 <1478400000>;
> +			required-opps = <&cprh_opp17>;
> +			qcom,pll-override = <0x073e003e>;
> +			qcom,spare-data = <2>;
> +		};
> +
> +		opp-1401600000 {
> +			opp-hz = /bits/ 64 <1401600000>;
> +			required-opps = <&cprh_opp16>;
> +			qcom,pll-override = <0x063a003a>;
> +			qcom,spare-data = <2>;
> +		};
> +
> +		opp-1324800000 {
> +			opp-hz = /bits/ 64 <1324800000>;
> +			required-opps = <&cprh_opp15>;
> +			qcom,pll-override = <0x06370037>;
> +			qcom,spare-data = <2>;
> +		};
> +
> +		opp-1248000000 {
> +			opp-hz = /bits/ 64 <1248000000>;
> +			required-opps = <&cprh_opp14>;
> +			qcom,pll-override = <0x05340034>;
> +			qcom,spare-data = <2>;
> +		};
> +
> +		opp-1171200000 {
> +			opp-hz = /bits/ 64 <1171200000>;
> +			required-opps = <&cprh_opp13>;
> +			qcom,pll-override = <0x05310031>;
> +			qcom,spare-data = <2>;
> +		};
> +
> +		opp-1094400000 {
> +			opp-hz = /bits/ 64 <1094400000>;
> +			required-opps = <&cprh_opp12>;
> +			qcom,pll-override = <0x052e002e>;
> +			qcom,spare-data = <2>;
> +		};
> +
> +		opp-1036800000 {
> +			opp-hz = /bits/ 64 <1036800000>;
> +			required-opps = <&cprh_opp11>;
> +			qcom,pll-override = <0x042b002b>;
> +			qcom,spare-data = <1>;
> +		};
> +
> +		opp-960000000 {
> +			opp-hz = /bits/ 64 <960000000>;
> +			required-opps = <&cprh_opp10>;
> +			qcom,pll-override = <0x4280028>;
> +			qcom,spare-data = <1>;
> +		};
> +
> +		opp-883200000 {
> +			opp-hz = /bits/ 64 <883200000>;
> +			required-opps = <&cprh_opp9>;
> +			qcom,pll-override = <0x4250025>;
> +			qcom,spare-data = <1>;
> +		};
> +
> +		opp-825600000 {
> +			opp-hz = /bits/ 64 <825600000>;
> +			required-opps = <&cprh_opp8>;
> +			qcom,pll-override = <0x3200022>;
> +			qcom,spare-data = <1>;
> +		};
> +
> +		opp-748800000 {
> +			opp-hz = /bits/ 64 <748800000>;
> +			required-opps = <&cprh_opp7>;
> +			qcom,pll-override = <0x3200020>;
> +			qcom,spare-data = <1>;
> +			qcom,pll-div = <1>;
> +		};
> +
> +		opp-672000000 {
> +			opp-hz = /bits/ 64 <672000000>;
> +			required-opps = <&cprh_opp6>;
> +			qcom,pll-override = <0x3200020>;
> +			qcom,spare-data = <1>;
> +			qcom,pll-div = <1>;
> +		};
> +
> +		opp-595200000 {
> +			opp-hz = /bits/ 64 <595200000>;
> +			required-opps = <&cprh_opp5>;
> +			qcom,pll-override = <0x2200020>;
> +			qcom,spare-data = <1>;
> +			qcom,pll-div = <1>;
> +		};
> +
> +		opp-518400000 {
> +			opp-hz = /bits/ 64 <518400000>;
> +			required-opps = <&cprh_opp4>;
> +			qcom,pll-override = <0x2200020>;
> +			qcom,spare-data = <1>;
> +			qcom,pll-div = <1>;
> +		};
> +
> +		opp-441600000 {
> +			opp-hz = /bits/ 64 <441600000>;
> +			required-opps = <&cprh_opp3>;
> +			qcom,pll-override = <0x2200020>;
> +			qcom,spare-data = <1>;
> +			qcom,pll-div = <1>;
> +		};
> +
> +		opp-364800000 {
> +			opp-hz = /bits/ 64 <364800000>;
> +			required-opps = <&cprh_opp2>;
> +			qcom,pll-override = <0x1200020>;
> +			qcom,spare-data = <1>;
> +			qcom,pll-div = <1>;
> +		};
> +
> +		opp-300000000 {
> +			opp-hz = /bits/ 64 <300000000>;
> +			required-opps = <&cprh_opp1>;
> +			qcom,pll-override = <0x1200020>;
> +		};
> +	};
> +
> +	cpu4_opp_table: opp-table-cpu4 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-2361600000 {
> +			opp-hz = /bits/ 64 <2361600000>;
> +			required-opps = <&cprh_opp30>;
> +			qcom,pll-override = <0x0a620062>;
> +			qcom,spare-data = <3>;
> +		};
> +
> +		opp-2342400000 {
> +			opp-hz = /bits/ 64 <2342400000>;
> +			required-opps = <&cprh_opp29>;
> +			qcom,pll-override = <0x0a620062>;
> +			qcom,spare-data = <3>;
> +		};
> +
> +		opp-2323200000 {
> +			opp-hz = /bits/ 64 <2323200000>;
> +			required-opps = <&cprh_opp28>;
> +			qcom,pll-override = <0x0a610061>;
> +			qcom,spare-data = <3>;
> +		};
> +
> +		opp-2265600000 {
> +			opp-hz = /bits/ 64 <2265600000>;
> +			required-opps = <&cprh_opp27>;
> +			qcom,pll-override = <0x0a5e005e>;
> +			qcom,spare-data = <3>;
> +		};
> +
> +		opp-2208000000 {
> +			opp-hz = /bits/ 64 <2208000000>;
> +			required-opps = <&cprh_opp26>;
> +			qcom,pll-override = <0x0a5c005c>;
> +			qcom,spare-data = <3>;
> +		};
> +
> +		opp-2112000000 {
> +			opp-hz = /bits/ 64 <2112000000>;
> +			required-opps = <&cprh_opp25>;
> +			qcom,pll-override = <0x0a580058>;
> +			qcom,spare-data = <3>;
> +		};
> +
> +		opp-2035200000 {
> +			opp-hz = /bits/ 64 <2035200000>;
> +			required-opps = <&cprh_opp24>;
> +			qcom,pll-override = <0x09550055>;
> +			qcom,spare-data = <3>;
> +		};
> +
> +		opp-1958400000 {
> +			opp-hz = /bits/ 64 <1958400000>;
> +			required-opps = <&cprh_opp23>;
> +			qcom,pll-override = <0x09520052>;
> +			qcom,spare-data = <2>;
> +		};
> +
> +		opp-1881600000 {
> +			opp-hz = /bits/ 64 <1881600000>;
> +			required-opps = <&cprh_opp22>;
> +			qcom,pll-override = <0x094e004e>;
> +			qcom,spare-data = <2>;
> +		};
> +
> +		opp-1804800000 {
> +			opp-hz = /bits/ 64 <1804800000>;
> +			required-opps = <&cprh_opp21>;
> +			qcom,pll-override = <0x084b004b>;
> +			qcom,spare-data = <2>;
> +		};
> +
> +		opp-1728000000 {
> +			opp-hz = /bits/ 64 <1728000000>;
> +			required-opps = <&cprh_opp20>;
> +			qcom,pll-override = <0x08480048>;
> +			qcom,spare-data = <2>;
> +		};
> +
> +		opp-1651200000 {
> +			opp-hz = /bits/ 64 <1651200000>;
> +			required-opps = <&cprh_opp19>;
> +			qcom,pll-override = <0x07450045>;
> +			qcom,spare-data = <2>;
> +		};
> +
> +		opp-1574400000 {
> +			opp-hz = /bits/ 64 <1574400000>;
> +			required-opps = <&cprh_opp18>;
> +			qcom,pll-override = <0x07420042>;
> +			qcom,spare-data = <2>;
> +		};
> +
> +		opp-1497600000 {
> +			opp-hz = /bits/ 64 <1497600000>;
> +			required-opps = <&cprh_opp17>;
> +			qcom,pll-override = <0x073e003e>;
> +			qcom,spare-data = <2>;
> +		};
> +
> +		opp-1420800000 {
> +			opp-hz = /bits/ 64 <1420800000>;
> +			required-opps = <&cprh_opp16>;
> +			qcom,pll-override = <0x063b003b>;
> +			qcom,spare-data = <2>;
> +		};
> +
> +		opp-1344000000 {
> +			opp-hz = /bits/ 64 <1344000000>;
> +			required-opps = <&cprh_opp15>;
> +			qcom,pll-override = <0x06380038>;
> +			qcom,spare-data = <2>;
> +		};
> +
> +		opp-1267200000 {
> +			opp-hz = /bits/ 64 <1267200000>;
> +			required-opps = <&cprh_opp14>;
> +			qcom,pll-override = <0x06350035>;
> +			qcom,spare-data = <2>;
> +		};
> +
> +		opp-1190400000 {
> +			opp-hz = /bits/ 64 <1190400000>;
> +			required-opps = <&cprh_opp13>;
> +			qcom,pll-override = <0x05320032>;
> +			qcom,spare-data = <2>;
> +		};
> +
> +		opp-1132800000 {
> +			opp-hz = /bits/ 64 <1132800000>;
> +			required-opps = <&cprh_opp12>;
> +			qcom,pll-override = <0x052f002f>;
> +			qcom,spare-data = <1>;
> +		};
> +
> +		opp-1056000000 {
> +			opp-hz = /bits/ 64 <1056000000>;
> +			required-opps = <&cprh_opp11>;
> +			qcom,pll-override = <0x052c002c>;
> +			qcom,spare-data = <1>;
> +		};
> +
> +		opp-979200000 {
> +			opp-hz = /bits/ 64 <979200000>;
> +			required-opps = <&cprh_opp10>;
> +			qcom,pll-override = <0x4290029>;
> +			qcom,spare-data = <1>;
> +		};
> +
> +		opp-902400000 {
> +			opp-hz = /bits/ 64 <902400000>;
> +			required-opps = <&cprh_opp9>;
> +			qcom,pll-override = <0x4260026>;
> +			qcom,spare-data = <1>;
> +		};
> +
> +		opp-806400000 {
> +			opp-hz = /bits/ 64 <806400000>;
> +			required-opps = <&cprh_opp8>;
> +			qcom,pll-override = <0x3200022>;
> +			qcom,spare-data = <1>;
> +			qcom,pll-div = <1>;
> +		};
> +
> +		opp-729600000 {
> +			opp-hz = /bits/ 64 <729600000>;
> +			required-opps = <&cprh_opp7>;
> +			qcom,pll-override = <0x3200020>;
> +			qcom,spare-data = <1>;
> +			qcom,pll-div = <1>;
> +		};
> +
> +		opp-652800000 {
> +			opp-hz = /bits/ 64 <652800000>;
> +			required-opps = <&cprh_opp6>;
> +			qcom,pll-override = <0x3200020>;
> +			qcom,spare-data = <1>;
> +			qcom,pll-div = <1>;
> +		};
> +
> +		opp-576000000 {
> +			opp-hz = /bits/ 64 <576000000>;
> +			required-opps = <&cprh_opp5>;
> +			qcom,pll-override = <0x2200020>;
> +			qcom,spare-data = <1>;
> +			qcom,pll-div = <1>;
> +		};
> +
> +		opp-499200000 {
> +			opp-hz = /bits/ 64 <499200000>;
> +			required-opps = <&cprh_opp4>;
> +			qcom,pll-override = <0x2200020>;
> +			qcom,spare-data = <1>;
> +			qcom,pll-div = <1>;
> +		};
> +
> +		opp-422400000 {
> +			opp-hz = /bits/ 64 <422400000>;
> +			required-opps = <&cprh_opp3>;
> +			qcom,pll-override = <0x2200020>;
> +			qcom,spare-data = <1>;
> +			qcom,pll-div = <1>;
> +		};
> +
> +		opp-345600000 {
> +			opp-hz = /bits/ 64 <345600000>;
> +			required-opps = <&cprh_opp2>;
> +			qcom,pll-override = <0x1200020>;
> +			qcom,spare-data = <1>;
> +			qcom,pll-div = <1>;
> +		};
> +
> +		opp-300000000 {
> +			opp-hz = /bits/ 64 <300000000>;
> +			required-opps = <&cprh_opp1>;
> +			qcom,pll-override = <0x1200020>;
> +			qcom,spare-data = <1>;
> +		};
> +	};
> +
>  	psci {
>  		compatible = "arm,psci-1.0";
>  		method = "smc";
> @@ -839,6 +1463,174 @@ qfprom: qfprom@784000 {
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  
> +			cpr_efuse_speedbin: speedbin@133 {
> +				reg = <0x133 0x8>;
> +				bits = <5 3>;
> +			};
> +
> +			cpr_fuse_revision: cpr_fusing_rev@13e {
> +				reg = <0x13e 0x1>;
> +				bits = <3 3>;
> +			};
> +
> +			/* CPR Ring Oscillator: Power Cluster */
> +			cpr_ro_sel3_pwrcl: rosel3_pwrcl@218 {
> +				reg = <0x218 0x1>;
> +				bits = <0 4>;
> +			};
> +
> +			cpr_ro_sel2_pwrcl: rosel2_pwrcl@218 {
> +				reg = <0x218 0x1>;
> +				bits = <4 4>;
> +			};
> +
> +			cpr_ro_sel1_pwrcl: rosel1_pwrcl@219 {
> +				reg = <0x219 0x1>;
> +				bits = <0 4>;
> +			};
> +
> +			cpr_ro_sel0_pwrcl: rosel0_pwrcl@219 {
> +				reg = <0x219 0x1>;
> +				bits = <4 4>;
> +			};
> +
> +			/* CPR Init Voltage: Power Cluster */
> +			cpr_init_voltage3_pwrcl: ivolt3_pwrcl@21a {
> +				reg = <0x21a 0x1>;
> +				bits = <0 6>;
> +			};
> +
> +			cpr_init_voltage2_pwrcl: ivolt2_pwrcl@21a {
> +				reg = <0x21a 0x1>;
> +				bits = <6 6>;
> +			};
> +
> +			cpr_init_voltage1_pwrcl: ivolt1_pwrcl@21b {
> +				reg = <0x21b 0x1>;
> +				bits = <4 6>;
> +			};
> +
> +			cpr_init_voltage0_pwrcl: ivolt0_pwrcl@21c {
> +				reg = <0x21c 0x1>;
> +				bits = <2 6>;
> +			};
> +
> +			/* CPR Target Quotients: Power Cluster */
> +			cpr_quot3_pwrcl: quot3_pwrcl@21d {
> +				reg = <0x21d 0x2>;
> +				bits = <6 12>;
> +			};
> +
> +			cpr_quot2_pwrcl: quot2_pwrcl@21f {
> +				reg = <0x21f 0x2>;
> +				bits = <2 11>;
> +			};
> +
> +			cpr_quot1_pwrcl: quot1_pwrcl@220 {
> +				reg = <0x220 0x2>;
> +				bits = <6 12>;
> +			};
> +
> +			cpr_quot0_pwrcl: quot0_pwrcl@222 {
> +				reg = <0x222 0x2>;
> +				bits = <2 12>;
> +			};
> +
> +			/* CPR Quotient Offsets: Power Cluster */
> +			cpr_quot_offset3_pwrcl: qoff3_pwrcl@226 {
> +				reg = <0x226 0x1>;
> +				bits = <1 7>;
> +			};
> +
> +			cpr_quot_offset2_pwrcl: qoff2_pwrcl@227 {
> +				reg = <0x227 0x1>;
> +				bits = <0 7>;
> +			};
> +
> +			cpr_quot_offset1_pwrcl: qoff1_pwrcl@227 {
> +				reg = <0x227 0x1>;
> +				bits = <7 6>;
> +			};
> +
> +			/* CPR Ring Oscillator: Performance Cluster */
> +			cpr_ro_sel3_perfcl: rosel3_perfcl@229 {
> +				reg = <0x229 0x1>;
> +				bits = <6 4>;
> +			};
> +
> +			cpr_ro_sel2_perfcl: rosel2_perfcl@22a {
> +				reg = <0x22a 0x1>;
> +				bits = <2 4>;
> +			};
> +
> +			cpr_ro_sel1_perfcl: rosel1_perfcl@22a {
> +				reg = <0x22a 0x1>;
> +				bits = <6 4>;
> +			};
> +
> +			cpr_ro_sel0_perfcl: rosel0_perfcl@22b {
> +				reg = <0x22b 0x1>;
> +				bits = <2 4>;
> +			};
> +
> +			/* CPR Init Voltage: Performance Cluster */
> +			cpr_init_voltage3_perfcl: ivolt3_perfcl@22b {
> +				reg = <0x22b 0x1>;
> +				bits = <6 6>;
> +			};
> +
> +			cpr_init_voltage2_perfcl: ivolt2_perfcl@22c {
> +				reg = <0x22c 0x1>;
> +				bits = <4 6>;
> +			};
> +
> +			cpr_init_voltage1_perfcl: ivolt1_perfcl@22d {
> +				reg = <0x22d 0x1>;
> +				bits = <2 6>;
> +			};
> +
> +			cpr_init_voltage0_perfcl: ivolt0_perfcl@22e {
> +				reg = <0x22e 0x1>;
> +				bits = <0 6>;
> +			};
> +
> +			/* CPR Target Quotients: Performance Cluster */
> +			cpr_quot3_perfcl: quot3_perfcl@22f {
> +				reg = <0x22f 0x2>;
> +				bits = <4 11>;
> +			};
> +
> +			cpr_quot2_perfcl: quot2_perfcl@231 {
> +				reg = <0x231 0x2>;
> +				bits = <0 12>;
> +			};
> +
> +			cpr_quot1_perfcl: quot1_perfcl@232 {
> +				reg = <0x232 0x2>;
> +				bits = <4 12>;
> +			};
> +
> +			cpr_quot0_perfcl: quot0_perfcl@234 {
> +				reg = <0x234 0x2>;
> +				bits = <0 12>;
> +			};
> +
> +			/* CPR Quotient Offsets: Performance Cluster */
> +			cpr_quot_offset3_perfcl: qoff3_perfcl@237 {
> +				reg = <0x237 0x1>;
> +				bits = <7 6>;
> +			};
> +
> +			cpr_quot_offset2_perfcl: qoff2_perfcl@238 {
> +				reg = <0x238 0x1>;
> +				bits = <6 7>;
> +			};
> +
> +			cpr_quot_offset1_perfcl: qoff1_perfcl@239 {
> +				reg = <0x239 0x1>;
> +				bits = <5 3>;
> +			};
> +
>  			qusb2_hstx_trim: hstx-trim@23a {
>  				reg = <0x23a 0x1>;
>  				bits = <0 4>;
> @@ -2998,6 +3790,87 @@ frame@17928000 {
>  			};
>  		};
>  
> +		apc_cprh: power-controller@179c8000 {
> +			compatible = "qcom,msm8998-cprh", "qcom,cprh";
> +			reg = <0x179c8000 0x4000>, <0x179c4000 0x4000>;
> +
> +			clocks = <&gcc GCC_HMSS_RBCPR_CLK>;
> +			clock-names = "ref";
> +
> +			/* Set the CPR clock here, it needs to match XO */
> +			assigned-clocks = <&gcc GCC_HMSS_RBCPR_CLK>;
> +			assigned-clock-rates = <19200000>;
> +
> +			operating-points-v2 = <&cprh_opp_table>;
> +			power-domains = <&rpmpd MSM8998_VDDCX_AO>;
> +			#power-domain-cells = <1>;
> +
> +			nvmem-cells = <&cpr_efuse_speedbin>,
> +				      <&cpr_fuse_revision>,
> +				      <&cpr_quot0_pwrcl>,
> +				      <&cpr_quot1_pwrcl>,
> +				      <&cpr_quot2_pwrcl>,
> +				      <&cpr_quot3_pwrcl>,
> +				      <&cpr_quot_offset1_pwrcl>,
> +				      <&cpr_quot_offset2_pwrcl>,
> +				      <&cpr_quot_offset3_pwrcl>,
> +				      <&cpr_init_voltage0_pwrcl>,
> +				      <&cpr_init_voltage1_pwrcl>,
> +				      <&cpr_init_voltage2_pwrcl>,
> +				      <&cpr_init_voltage3_pwrcl>,
> +				      <&cpr_ro_sel0_pwrcl>,
> +				      <&cpr_ro_sel1_pwrcl>,
> +				      <&cpr_ro_sel2_pwrcl>,
> +				      <&cpr_ro_sel3_pwrcl>,
> +				      <&cpr_quot0_perfcl>,
> +				      <&cpr_quot1_perfcl>,
> +				      <&cpr_quot2_perfcl>,
> +				      <&cpr_quot3_perfcl>,
> +				      <&cpr_quot_offset1_perfcl>,
> +				      <&cpr_quot_offset2_perfcl>,
> +				      <&cpr_quot_offset3_perfcl>,
> +				      <&cpr_init_voltage0_perfcl>,
> +				      <&cpr_init_voltage1_perfcl>,
> +				      <&cpr_init_voltage2_perfcl>,
> +				      <&cpr_init_voltage3_perfcl>,
> +				      <&cpr_ro_sel0_perfcl>,
> +				      <&cpr_ro_sel1_perfcl>,
> +				      <&cpr_ro_sel2_perfcl>,
> +				      <&cpr_ro_sel3_perfcl>;
> +			nvmem-cell-names = "cpr_speed_bin",
> +					   "cpr_fuse_revision",
> +					   "cpr0_quotient1",
> +					   "cpr0_quotient2",
> +					   "cpr0_quotient3",
> +					   "cpr0_quotient4",
> +					   "cpr0_quotient_offset2",
> +					   "cpr0_quotient_offset3",
> +					   "cpr0_quotient_offset4",
> +					   "cpr0_init_voltage1",
> +					   "cpr0_init_voltage2",
> +					   "cpr0_init_voltage3",
> +					   "cpr0_init_voltage4",
> +					   "cpr0_ring_osc1",
> +					   "cpr0_ring_osc2",
> +					   "cpr0_ring_osc3",
> +					   "cpr0_ring_osc4",
> +					   "cpr1_quotient1",
> +					   "cpr1_quotient2",
> +					   "cpr1_quotient3",
> +					   "cpr1_quotient4",
> +					   "cpr1_quotient_offset2",
> +					   "cpr1_quotient_offset3",
> +					   "cpr1_quotient_offset4",
> +					   "cpr1_init_voltage1",
> +					   "cpr1_init_voltage2",
> +					   "cpr1_init_voltage3",
> +					   "cpr1_init_voltage4",
> +					   "cpr1_ring_osc1",
> +					   "cpr1_ring_osc2",
> +					   "cpr1_ring_osc3",
> +					   "cpr1_ring_osc4";
> +		};
> +
>  		intc: interrupt-controller@17a00000 {
>  			compatible = "arm,gic-v3";
>  			reg = <0x17a00000 0x10000>,       /* GICD */
