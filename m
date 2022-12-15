Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA87864E014
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiLOR4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiLOR4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:56:18 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549F637F98;
        Thu, 15 Dec 2022 09:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1671126973; x=1702662973;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YtQI8DU1s7jgszET07pgYEgG8XnSyrnxMzkxln6uvmQ=;
  b=xVMVxKBJ7QmjKvIpJEr8P8Sa44NrV/hOswcHKZPBgRRLY+t4hOspgNBq
   1/u4rrr0oPnv1gkUrKtdLBiE1pali6A1jyP3ND+iU3SfIBqC+5+MRDojQ
   rXKkxaOstFhfY9Ettc9g0vGeI3Q7r9Hzmo3gYrNlbkXIEiEcDtUWpulBf
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Dec 2022 09:56:12 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 09:56:11 -0800
Received: from [10.110.78.226] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 15 Dec
 2022 09:56:11 -0800
Message-ID: <82620abd-105a-6ebc-ae58-e77fa058852b@quicinc.com>
Date:   Thu, 15 Dec 2022 09:56:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221118192241.29384-1-quic_molvera@quicinc.com>
 <20221118192241.29384-3-quic_molvera@quicinc.com>
 <20221202033721.4slwz2utw5u6rv7b@builder.lan>
 <9e4e6149-bc24-b727-fff7-3fb7038fc066@quicinc.com>
 <5cd9e71c-8147-2ce1-b137-0342e271031b@linaro.org>
Content-Language: en-US
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <5cd9e71c-8147-2ce1-b137-0342e271031b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/15/2022 12:44 AM, Krzysztof Kozlowski wrote:
> On 14/12/2022 19:59, Melody Olvera wrote:
>>>> +			#clock-cells = <0>;
>>>> +		};
>>>> +
>>>> +		sleep_clk: sleep-clk {
>>>> +			compatible = "fixed-clock";
>>>> +			clock-frequency = <32000>;
>>>> +			#clock-cells = <0>;
>>>> +		};
>>>> +
>>>> +		pcie_0_pipe_clk: pcie-0-pipe-clk {
>>> Afaict these clocks are not referenced anywhere, so please skip them.
>> Yes, so I included them to be consistent with the bindings. They will be needed later;
>> should I still remove?
>>
> If they are not referenced anywhere, how is it consistent with bindings?
> Where do the bindings require defining such nodes?

These bindings here: https://lore.kernel.org/all/20221118181826.28269-2-quic_molvera@quicinc.com/
I believe you commented that we either have these clocks or we don't, correct? I added them to
the dt since these clocks exist and will be needed later when USB and PCIE nodes are added.
As Konrad noted, these technically belong in the PHYs, but I was told to put stub fixed
clocks instead here: https://lore.kernel.org/lkml/2c8c4642-8aee-3da3-7698-5e08b4c5894d@linaro.org/

How is this to be handled? Should I remove the clocks from the dt and the bindings and add them
later when we need them? Do I leave stub clocks here with frequency 0 until needed? I am
very confused right now.

Thanks,
Melody

>
> Best regards,
> Krzysztof
>

