Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935CE5F4677
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJDPTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiJDPTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:19:22 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D3465242;
        Tue,  4 Oct 2022 08:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1664896748; x=1696432748;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=omAFcdMgbGlbSBSuocNjCy6I8nE3wuP/HRnNBjIcC/k=;
  b=pUbCSi5dowJ04e/2QGFiYuKLTUbeLgs/FDcmYLsVT9+pJug/jHfUEyAv
   dxcRAsafojKaHg11+0AU0Zdt7Mrxe3JzYYy7c+RqIicvmL5Y5Zf6QnDjd
   vF340DjmBtVX5mPRJFM4047xKPB1Aad4v7rtTdXBlCTQvce4mKLKR/4wp
   k=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 04 Oct 2022 08:19:07 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 08:19:07 -0700
Received: from [10.110.73.50] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 08:19:06 -0700
Message-ID: <fe85df46-7368-caf7-fec0-657d596ab893@quicinc.com>
Date:   Tue, 4 Oct 2022 10:19:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/5] dt-bindings: power: rpmpd: Add QDU1000/QRU1000 to
 rpmpd binding
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221001030641.29354-1-quic_molvera@quicinc.com>
 <20221001030641.29354-4-quic_molvera@quicinc.com>
 <d43c954a-8b3e-779c-85b1-07d46a5f7fb3@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <d43c954a-8b3e-779c-85b1-07d46a5f7fb3@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/1/2022 4:27 AM, Krzysztof Kozlowski wrote:
> On 01/10/2022 05:06, Melody Olvera wrote:
>> Add compatible and constants for the power domains exposed by the RPMH
>> in the Qualcomm QDU1000 and QRU1000 platforms.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 2 ++
>>  include/dt-bindings/power/qcom-rpmpd.h                  | 6 ++++++
>>  2 files changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
>> index 3934a2b44894..7343cfc91262 100644
>> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
>> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
>> @@ -44,6 +44,8 @@ properties:
>>        - qcom,sm8250-rpmhpd
>>        - qcom,sm8350-rpmhpd
>>        - qcom,sm8450-rpmhpd
>> +      - qcom,qdu1000-rpmhpd
>> +      - qcom,qru1000-rpmhpd
> Wrong order.
Will fix.
>
>
> Best regards,
> Krzysztof

Thanks,

Melody

