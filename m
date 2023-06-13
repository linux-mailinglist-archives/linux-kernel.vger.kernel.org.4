Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D58B72E482
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbjFMNne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242474AbjFMNna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:43:30 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F144610E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:43:25 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30ae95c4e75so5473302f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686663804; x=1689255804;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GzQXlDHLRtYFXz6SgNSRR4StIWNnj8KrmIpcoKcJ1zQ=;
        b=oIv8P/hYeEA2OYCa0ZnKRFcNVjJ09UrvD8kE3ZGaxmR7VnCXYAwRDcwYF4xjuljD5e
         hJ0awvvtwmd4bl97i0/nplfyZs4BZaQV61W9iQAG3qg2K7zF9Pr/Inm02/FZsPqBQ5aG
         TqzKpVHbxHqTcAEQY0+TOY8Q2H0FYWGgGlUbflSUNDJhYziIU2dhoN3D/yw+EFhDMqGE
         V/IljPUl9YmVvyXd52ajDzZ92OJhgLV4cxkRWnIfbmhwFfQTMb3mnAXu4vxgvp6H+FjL
         cWY5GStQwNlwp3kO0Zpn21nGdWH7NwNhQjsUbYknImowdJKksK8u+4PpVVIHiPWS/t24
         Kydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686663804; x=1689255804;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GzQXlDHLRtYFXz6SgNSRR4StIWNnj8KrmIpcoKcJ1zQ=;
        b=RSG6MFPngIyiF4Hu+RuoSG0qht0UfWrR05WRcZog1P/gndpI846Mwy9KhFZF5hOUAk
         NaPI5d+CGD/3fSR8UilRjQ7AooNcqVpGtHay7z+qGhVwjwqaCpbPq64jC0gRmIAunlcA
         1Hjp/1UcGy65sK9/QVAasbF9ctJJ9GC97hsnsJ6qNV0lxb4tcKxeThlDhmGZhpAK9mRg
         yxTiWV+Gc/9pmrLJP5cnQurX12l8dTZwf5UsM3SS8h36Qrxp8NUMB0zJzHhQda7RRIas
         L+GGsgHbJLLa54uV71/doR53mfxD+j6ysiWVVqxB8+a32xSo0Xlo9YXPKVbKwWtMZNSf
         OsFg==
X-Gm-Message-State: AC+VfDzPA6EvXIi1bw439WeV20J1+Fxim1ATBSwDicxhBoqe4rl/mlQX
        5DJXKvbv7hFggPGgkeTrEYJ9gQ==
X-Google-Smtp-Source: ACHHUZ7H2fb9GHz/G51cRdvfLQ6nxUPvVSuWF46e3FT1GPqNUTe4bl7FcKJ9MD6OZGFdEqIitR+Qtw==
X-Received: by 2002:a05:6000:196e:b0:30e:5729:b5a5 with SMTP id da14-20020a056000196e00b0030e5729b5a5mr7324551wrb.38.1686663804450;
        Tue, 13 Jun 2023 06:43:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:48b:b939:c60e:e1ba? ([2a01:e0a:982:cbb0:48b:b939:c60e:e1ba])
        by smtp.gmail.com with ESMTPSA id t15-20020a1c770f000000b003f8d0308604sm1560415wmi.9.2023.06.13.06.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 06:43:23 -0700 (PDT)
Message-ID: <8f9c549a-e37b-2877-be74-f25304a476fd@linaro.org>
Date:   Tue, 13 Jun 2023 15:43:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 5/8] qcom: pmic_glink: enable altmode for SM8550
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230601-topic-sm8550-upstream-type-c-v3-0-22c9973012b6@linaro.org>
 <20230601-topic-sm8550-upstream-type-c-v3-5-22c9973012b6@linaro.org>
 <5851627e-2972-f860-e965-dc8e73b01225@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <5851627e-2972-f860-e965-dc8e73b01225@linaro.org>
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

On 13/06/2023 13:54, Krzysztof Kozlowski wrote:
> On 13/06/2023 09:55, Neil Armstrong wrote:
>> Altmode is also supported for SM8550, allow it.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/soc/qcom/pmic_glink.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
>> index c87056769ebd..8af06bdc6f5a 100644
>> --- a/drivers/soc/qcom/pmic_glink.c
>> +++ b/drivers/soc/qcom/pmic_glink.c
>> @@ -342,13 +342,9 @@ static const unsigned long pmic_glink_sm8450_client_mask = BIT(PMIC_GLINK_CLIENT
>>   							   BIT(PMIC_GLINK_CLIENT_ALTMODE) |
>>   							   BIT(PMIC_GLINK_CLIENT_UCSI);
>>   
>> -/* Do not handle altmode for now on those platforms */
>> -static const unsigned long pmic_glink_sm8550_client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
>> -							   BIT(PMIC_GLINK_CLIENT_UCSI);
>> -
>>   static const struct of_device_id pmic_glink_of_match[] = {
>>   	{ .compatible = "qcom,sm8450-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
> 
> Orientation and maybe all of the USB-related properties do not look like
> sm8450 specific, but PM8350B. That's where CC_OUT pin is. I don't think
> we represented this correctly, but rather copy-pasted downstream solution...

We do not interact directly with PM8350B or PM8550B but with pmic_glink who
does the work work for use, and this is platform specific.

Neil

> 
> Best regards,
> Krzysztof
> 

