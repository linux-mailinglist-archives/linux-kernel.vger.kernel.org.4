Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3525FBBBB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJKUCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiJKUCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:02:04 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB9B9C2EB;
        Tue, 11 Oct 2022 13:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1665518513; x=1697054513;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Kt2dx5vb1uguIW3cXWvlJsELaaSwDUlU5C9LZNubLmg=;
  b=qa77PRmrelPLQ34g4hxgAnFTtGCPQushXGUPb/+0p3EW2tJkLRuuYOeu
   XyBozQI80K84mkW6WFYzbHzO9D/GaPsaLOo8+h66d9peJuPhNgmgaWzZe
   laSFBdsrpCyZB4P3ZOoPfw/uuNwyhH65JXzQ9OXnY/ewR8xCPtVcS/O4G
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Oct 2022 13:01:51 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 13:01:51 -0700
Received: from [10.110.3.66] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 11 Oct
 2022 13:01:51 -0700
Message-ID: <ed2363d5-1757-9eb9-ef79-ebc3574723ee@quicinc.com>
Date:   Tue, 11 Oct 2022 13:01:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 03/19] arm64: dts: qcom: qdru1000: Add tlmm nodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221001030656.29365-1-quic_molvera@quicinc.com>
 <20221001030656.29365-4-quic_molvera@quicinc.com>
 <ad743621-8e2d-23f9-8c44-53f6681aa134@linaro.org>
 <7674b756-75d5-6ca3-d4fe-c54bd92a3fd7@quicinc.com>
 <ddb4566f-b420-6ee8-b3f5-3eeb83ad2d8b@linaro.org>
 <3885c1d1-ab6f-2b30-2950-f4dc0ec54152@quicinc.com>
 <4912f46c-e990-a886-cc2a-8684d61eed38@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <4912f46c-e990-a886-cc2a-8684d61eed38@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2022 12:19 PM, Krzysztof Kozlowski wrote:
> On 11/10/2022 15:05, Melody Olvera wrote:
>>
>> On 10/11/2022 11:57 AM, Krzysztof Kozlowski wrote:
>>> On 11/10/2022 14:48, Melody Olvera wrote:
>>>> On 10/1/2022 2:14 AM, Krzysztof Kozlowski wrote:
>>>>> On 01/10/2022 05:06, Melody Olvera wrote:
>>>>>> Add tlmm node for the QDU1000 and QRU1000 SoCs and the uart pin
>>>>>> configuration.
>>>>> The patchset should be squashed with previous. There is no point in
>>>>> bringing support piece by piece. You can bring support in steps if you
>>>>> submissions are separate in time. But if you have everything ready -
>>>>> your patch must be complete and bisectable.
>>>> To be clear, does it make more sense to submit the base dt first, then submit each
>>>> driver with all the dt changes as one patchset?
>>> No, because you have DTS ready. There is no incremental work here.
>> Ah ok so just squash all these commits into one and submit.
> Except the board DTS. Other bigger, self-contained pieces of work can be
> also kept separate, but such work is not "add a DMA". Such work could be
> - add display (with clocks, DMA, GPU, power domains) or sound (again
> multiple separate devices added).
Understood. Yeah I figured leave the dts files as a separate commit, but do one big commit
for the dtsi file, and one for the dts files.
>
> Best regards,
> Krzysztof
>
Thanks,
Melody
