Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F209D71277E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243436AbjEZN2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbjEZN2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:28:14 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E0612C
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:28:13 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f4e71a09a7so586563e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685107691; x=1687699691;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/qbnqfIGPie7oqC4HDbeJQDj333SMb559OfkHoAzXR4=;
        b=KndLD42GaKMyXUblrSbC+42CEZDPHf8oFipzpDcw1w/cKU3c57tgba99dSQk0P8mA/
         mbOIMLj97w9qgErftyaO7tvTTgJmIZOUcKO92K1Miut3Vxxw92eE1S6V0i/ROZLX4Ozr
         8EzfN5b1fE+p7l7GRUdE6oZ/r/+xUJNjYLXoDKBmyYcHyQUu6ZuzZWDgPtRkJ23DJ9ug
         nE+DXRm3afCuX2//BQufzRQ5vV8QGtXzTb9M8BumFgUrUEUAgqe7VjCXXY1Iga7AgYhN
         RlRYJIxt+Qji5NEcK8XMyqU91QaoxGtqdPKS4OuqlTuz2tYpeAKGc2UWSXb0TiSjk2el
         MJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685107691; x=1687699691;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/qbnqfIGPie7oqC4HDbeJQDj333SMb559OfkHoAzXR4=;
        b=aZ2WsF5Ji9YcdZ2V5Gsmkh0XW24tpABV9Cf1PUGF1L3yufFBrN6gQ4KOuRYeIm4sXf
         JFwFgUiwYDO5b/hiHBk1ZXvfnuGMb8SWuIWBXrmcSjexeb+eWsvKv5ox+d8TypJh3Oeu
         z2gCiR97EVDn5F8DgHAIQynnAl6E96BvWH64bTMSpDV0Kca0KkG2rNXfd1yKAIpCK3vT
         nFA+TTJSomzfXr28t1PdqHjqLvBDT17u36PV4YhG75MPCRtSf3zxPaln3Q22E5mC8q2s
         MdFEJgD1AijW5w8daEkZe+Mx46O926ZBtnqKm15pjXdI7DMWe2kBH9QhSEpplBLjYcq2
         bwkg==
X-Gm-Message-State: AC+VfDxkHp0iW6C9vDt/+wO1H+L8oxi7shcrg9GGITx56J/hLpdAksD6
        iEDaDOn4+T03AwdA4F+8pvmbtQ==
X-Google-Smtp-Source: ACHHUZ4xOQZRCUOitaNPco2TiscJGSYZnvLq7jAVqgmV194XJF1jip9t1zFNhRJ10USr0WelxYSWNw==
X-Received: by 2002:a05:6512:318e:b0:4f4:b497:25ed with SMTP id i14-20020a056512318e00b004f4b49725edmr1955514lfe.27.1685107691375;
        Fri, 26 May 2023 06:28:11 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id t9-20020ac243a9000000b004f13634da05sm621531lfl.180.2023.05.26.06.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 06:28:11 -0700 (PDT)
Message-ID: <a6a69233-1a59-b775-9679-bdd7a95ce468@linaro.org>
Date:   Fri, 26 May 2023 15:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 3/4] arm64: dts: qcom: ipq6018: add QFPROM node
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kathiravan T <quic_kathirav@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230526125305.19626-1-quic_kathirav@quicinc.com>
 <20230526125305.19626-4-quic_kathirav@quicinc.com>
 <CAA8EJpqSsTxpafOQZBBSZts2ZvxR1Wb6LMdcwnTxZvmyN=OSQA@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJpqSsTxpafOQZBBSZts2ZvxR1Wb6LMdcwnTxZvmyN=OSQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.05.2023 15:22, Dmitry Baryshkov wrote:
> On Fri, 26 May 2023 at 15:54, Kathiravan T <quic_kathirav@quicinc.com> wrote:
>>
>> IPQ6018 has efuse region to determine the various HW quirks. Lets
>> add the initial support and the individual fuses will be added as they
>> are required.
>>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
>> Changes in V2:
>>         - Reorder the node based on node address
>>
>>  arch/arm64/boot/dts/qcom/ipq6018.dtsi | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> index f531797f2619..0f6d6c6daed2 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> @@ -302,6 +302,13 @@
>>                         status = "disabled";
>>                 };
>>
>> +               qfprom: efuse@a4000 {
>> +                       compatible = "qcom,ipq6018-qfprom", "qcom,qfprom";
>> +                       reg = <0x0 0x000a4000 0x0 0x2000>;
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
>> +               };
>> +
>>                 prng: qrng@e1000 {
>>                         compatible = "qcom,prng-ee";
>>                         reg = <0x0 0x000e3000 0x0 0x1000>;
> 
> It looks like the prng node name is incorrect. It should be qrng@e3000
> instead of qrng@e1000. Could you please send a followup to fix it?
In case that wasn't clear, since I think this series will go in as-is,
that fix would be sent separately, on top of this.

Konrad
> 
> For this patch:
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
>> --
>> 2.17.1
>>
> 
> 
