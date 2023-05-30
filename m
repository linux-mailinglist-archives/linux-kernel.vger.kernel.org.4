Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1177156C8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjE3Ha5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjE3HaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:30:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8B7113
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:29:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30ae61354fbso1541257f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685431784; x=1688023784;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XHy/LfOj6uTyno9ClqD5FZ00I/Rkz/Xjmgux3hflxTk=;
        b=ym+oY4CXyrSgaCceabymeYOlBGvNxreXMNA6azegNUVvk2uLxP5llY7KADbBoF+j9C
         xglV/ILfwZuXjx9Bh1QbRAnKpO0cqvYqIzYgmBsgpdZ8IuFsWqo6DD6PGY3ZBRYruM51
         XN05pkm+BRRdsyQLCUJqfLf14FqwM+2e+I2TGg5/Pu2X4+TSzqeCf0HzqRal2hw7b6cT
         OlkNNry+Dniq+WI7eNoWORS724ZZ/DkxyOZK327XU5cZO8x9nlUIvSSCHQgdy3iqH3iO
         RGMVzff9WoYord9vpMS5ECfTXk2f+nLCD9KzrlScxXo9S9ZPaBZmQrJrYlNEXICQP0xI
         USZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685431784; x=1688023784;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHy/LfOj6uTyno9ClqD5FZ00I/Rkz/Xjmgux3hflxTk=;
        b=cIs2cTsNclgfJmBo8E7eBOpohUtCzAnccqtHq1Ud8MUR1aNpK12OuQMSp5DydxIbC/
         3ADPM0RJjHOGdundKwVQwDnl31o4Zlo6EE/Zg7UbEt4cwdlrCiDpgfjnRPAW5RDdstJk
         uk5JiObMiUsBoV8xXe43GpmqvNhy7fAbzpZWwvIitn8IxbT5IZVb5sIfNj4sBYecx4nh
         CXzY+LBxl3+JeZRn53r4HFv3LkKUdK3UyxHE8wPUeqUQ4tXr8Kd3Fm1G8LOjEIe3bK8V
         WsqfacFyxKndsFPDLxsS4OkICzVjVnpLGRAby1xw2o1pK2aMR+osiNFqBp6ypg169363
         upzg==
X-Gm-Message-State: AC+VfDxqIKJg98KeXr5ilmcNL6Q/cFyrSpwycVsC9toxnuvq7RCt0o8M
        A8Ks6W7EtRP33afCyfGuIAAXD6NZh1LGmWID3RmGdA==
X-Google-Smtp-Source: ACHHUZ6Oj80NsiNcsYRYMVVckEsOwSLWymbKsXeb+oj8fmPzK/Wkc65dHdjb3SIxn8GblysOHQNkhQ==
X-Received: by 2002:adf:f9cd:0:b0:307:41a1:a125 with SMTP id w13-20020adff9cd000000b0030741a1a125mr897548wrr.12.1685431784210;
        Tue, 30 May 2023 00:29:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4294:2221:d2df:9e87? ([2a01:e0a:982:cbb0:4294:2221:d2df:9e87])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d6e0c000000b002ca864b807csm2356099wrz.0.2023.05.30.00.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 00:29:43 -0700 (PDT)
Message-ID: <d76f1e0d-8747-91f7-63f1-9ad85dafef9c@linaro.org>
Date:   Tue, 30 May 2023 09:29:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sm8550: enable PMIC RTC on MTP &
 QRD boards
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v1-0-4d5d7602f290@linaro.org>
 <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v1-3-4d5d7602f290@linaro.org>
 <4806dbd8-4f9b-0a6f-adf0-4beab74b1ba1@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <4806dbd8-4f9b-0a6f-adf0-4beab74b1ba1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2023 21:51, Konrad Dybcio wrote:
> 
> 
> On 25.05.2023 17:47, Neil Armstrong wrote:
>> The PMK8550 RTC is functional on the SM8550 MTP & QRD boards,
>> let's enable them.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> WDYM "functional"? Is there a reason it shouldn't be enabled for
> everyone?

There's none, I'll enable it in the PMIC dtsi instead.

Neil

> 
> Konrad
>>   arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 4 ++++
>>   arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 4 ++++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
>> index e2b9bb6b1e27..6bf111e655f7 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
>> @@ -496,6 +496,10 @@ &pm8550b_eusb2_repeater {
>>   	vdd3-supply = <&vreg_l5b_3p1>;
>>   };
>>   
>> +&pmk8550_rtc {
>> +	status = "okay";
>> +};
>> +
>>   &qupv3_id_0 {
>>   	status = "okay";
>>   };
>> diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
>> index 4a8177f99523..b08a8201ad23 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
>> @@ -482,6 +482,10 @@ &pm8550b_eusb2_repeater {
>>   	vdd3-supply = <&vreg_l5b_3p1>;
>>   };
>>   
>> +&pmk8550_rtc {
>> +	status = "okay";
>> +};
>> +
>>   &qupv3_id_0 {
>>   	status = "okay";
>>   };
>>

