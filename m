Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F88680B7A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbjA3LAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbjA3K7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:59:51 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AD13252F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:59:47 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t7so2300313wrp.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0Z8uT27zXqHP075WCZAzyrIHic+yDVlBHrlssAyuAUM=;
        b=NiIO4SMiQLbe67Fym5JRRoOy7y9Eq0YI0OXOIq9dv+wJ+FhtzztYafPE3m4gLc0g8V
         jl0w370sQGHOdgMP56aUovXP7Nn1yYy826UyZz00wqOP/5NYbJQGUKBStkeM+mu27Fej
         3oYdQjWFBzS2+3evX9bNsjNRpNH3s+zNS+v0OOCd5JiKe4lFMfyd3Ko3pLDd97MrYtA3
         WRCcG6S3ON09OEYH8XwPlwSOew/qfU8rn0eJJ73LR/Ahu8DVhSij4t+uO2ZG5LuDBMZA
         KUQXddk+da3QifkYeiRYbIAA2JO09WYizDIHTcXZH2h47vUr/tfWngIoaTDmom1bzY5n
         LBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Z8uT27zXqHP075WCZAzyrIHic+yDVlBHrlssAyuAUM=;
        b=W6i7hvyKl95vMZBqN/CVMyuoiqBjBEEVKkpuT9phFHe2Ka9Na3aArF9nJmoOVsPo8a
         PQj0AToTPNyj3N2aGOaV5zo/6Rwm7eNmXkyUwyhXdj71wHsQrCcknPbJGPmna2lj7EIf
         aGOzLxaN/fRx62qBXnpPh9PzwUzgr9Wp7KKSo8hUMrwerBBRc8VY/XJ6bgBuPCr7/y8b
         fXaHKLf5NRSGzl4tctJp2oP3XW0VwDeAYMoLnRhXu39pS29UBm5LocII+AfW0le2Ix3e
         1h+YgRrAE6TPi/xXiNB4dp0QuSf2fenGtRuasGxIdMgHHvKHXA2LuMx41q6n6P77RKFS
         mxGw==
X-Gm-Message-State: AO0yUKXRtvxSyXegINTceJoq4XfmXr6M1lTwbB9BFkEWCmsqkR2q70sk
        +KuH3qeHr+AGiHvzfmnHFerB6Q==
X-Google-Smtp-Source: AK7set/sYnO95MR4+0FT0/tcJvTb7fmizp1HJ+iffXGPWUEjMjzpfDRyiHJWbFvI9ZBar1MpSK8Yiw==
X-Received: by 2002:a5d:4050:0:b0:2bf:d683:135a with SMTP id w16-20020a5d4050000000b002bfd683135amr9133033wrp.37.1675076385832;
        Mon, 30 Jan 2023 02:59:45 -0800 (PST)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d67c9000000b00294176c2c01sm11465658wrw.86.2023.01.30.02.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 02:59:45 -0800 (PST)
Message-ID: <cc0bb62b-ff5f-941b-5aaf-e04223d33c4a@linaro.org>
Date:   Mon, 30 Jan 2023 11:59:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 6/7] arm64: dts: qcom: sm8550-mtp: add pmic glink node
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230130-topic-sm8450-upstream-pmic-glink-v1-0-0b0acfad301e@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v1-6-0b0acfad301e@linaro.org>
 <f178793c-5e73-65d0-0daf-72f99b201d4e@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <f178793c-5e73-65d0-0daf-72f99b201d4e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2023 11:41, Konrad Dybcio wrote:
> 
> 
> On 30.01.2023 10:54, Neil Armstrong wrote:
>> Add the pmic glink node linked with the DWC3 USB controller
>> switched to OTG mode and tagged with usb-role-switch.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 34 ++++++++++++++++++++++++++++++++-
>>   1 file changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
>> index 725d3bc3ee72..f054c11fe1f6 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
>> @@ -27,6 +27,31 @@ chosen {
>>   		stdout-path = "serial0:115200n8";
>>   	};
>>   
>> +	pmic-glink {
>> +		compatible = "qcom,sm8450-pmic-glink",
> 8550?
> 
> Otherwise same comments as for the previous patch

Oops bad copy-pasta even if it still works...

Thanks,
Neil

> 
> Konrad
> "qcom,pmic-glink";
>> +
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		connector@0 {
>> +			compatible = "usb-c-connector";
>> +			reg = <0>;
>> +			power-role = "dual";
>> +			data-role = "dual";
>> +
>> +			ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				port@0 {
>> +					reg = <0>;
>> +					pmic_glink_dwc3_in: endpoint {
>> +						remote-endpoint = <&usb_1_dwc3_out>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +	};
>> +
>>   	vph_pwr: vph-pwr-regulator {
>>   		compatible = "regulator-fixed";
>>   		regulator-name = "vph_pwr";
>> @@ -546,7 +571,14 @@ &usb_1 {
>>   };
>>   
>>   &usb_1_dwc3 {
>> -	dr_mode = "peripheral";
>> +	dr_mode = "otg";
>> +	usb-role-switch;
>> +
>> +	port {
>> +		usb_1_dwc3_out: endpoint {
>> +		      remote-endpoint = <&pmic_glink_dwc3_in>;
>> +	      };
>> +	};
>>   };
>>   
>>   &usb_1_hsphy {
>>

