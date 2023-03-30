Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996E96D075C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjC3Nyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjC3Nyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:54:38 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF735266
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:54:36 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id br6so24583419lfb.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680184475;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3bDS+NZkCHNjcglyIFTFfiCpIuz6atTUwaUlX4EZFO0=;
        b=ErhbzUuJagPIYLAc87qPWesX4OphTqSHbJlUJVBxYSuQj1F7by1TnBjfmXPMkVWe/a
         Iu3m3k0LswZfbS3vZSMywRkPsQYArihDnUmFaAlH9Mb5bDzCTXzj65gkKQEv8OjR0RaW
         tk2xX9+JDRLkNBdGasPWY23zteZ+ErxBVxkMgmShPfqCN4VTvlxDrfVRhfkIxXHpvln6
         H9nocYvLcFCWlp5ljTC3t37lWhVXndOUFUgZlKgZtImqwfm4Lyh6vXhHz85Xpc9D8Mp2
         HMrch5hd8A5/8XdkknaU0barZxVPKTAysNeuqgUcUpAqqj0ns4VD7Y0p7AhEIYB9G8Or
         uJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680184475;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bDS+NZkCHNjcglyIFTFfiCpIuz6atTUwaUlX4EZFO0=;
        b=TztVcA0OHFdhKCbczJBuOJ/OQQNISzB3A+Zs+fbzdZroYvUxpUcp6Fa5OpHpRkJn4X
         vy4LyIkYUeKYiq/8+0VVUt/9VJJKQgQtHXBaId3u9o37lAwlKNew8h4RDWac+xJey8Ve
         Igp6dav2GuS33CH9KFBgg3k5vBe04/RLUvM1Fgw18NnCvoD/d8KZ7LSA29X9s7zAgxe2
         7OswAWfkzmbThjCRu4yK5Es7rNY//ctShT2OR793BZSChvthnot/VnmJMIUevXUKlmze
         ybT73YsyrpGhJS4tYLqvTvRDcoB+nZTsqmJFHgnLGBoHmLB3Kt3Lfx/cOiBTsVf9uXkA
         OgDw==
X-Gm-Message-State: AAQBX9fDwDeumyjP+Eiw4NRg5K4br4r8LiAS+XvqLSTWhjj6WLrk6XFN
        /8mJjHdThn3fiQ1PL45VS6Vq3g==
X-Google-Smtp-Source: AKy350bscyofmdfis+7MYVvAX6/F+FXHo4829Gg5E4cWInBN+17SyFn1NzTYtImeQD2Xg1dAOF4b9w==
X-Received: by 2002:a05:6512:985:b0:4e9:605e:b470 with SMTP id w5-20020a056512098500b004e9605eb470mr1821024lft.26.1680184474901;
        Thu, 30 Mar 2023 06:54:34 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q28-20020ac2529c000000b004eaf8613bc3sm3525907lfm.284.2023.03.30.06.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 06:54:34 -0700 (PDT)
Message-ID: <7c4af740-1cf5-6b20-4642-8657ef31c9d8@linaro.org>
Date:   Thu, 30 Mar 2023 15:54:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 2/8] dt-bindings: phy: qcom,qmp-usb: Add IPQ9574 USB3
 PHY
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1679909245.git.quic_varada@quicinc.com>
 <4a21defe3320eb11d0e43bc7f02b3168ecefd458.1679909245.git.quic_varada@quicinc.com>
 <3d49b4b0-587c-f7e5-4122-65b3e9f11583@linaro.org>
 <20230330071016.GB13508@varda-linux.qualcomm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230330071016.GB13508@varda-linux.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2023 09:10, Varadarajan Narayanan wrote:
> On Mon, Mar 27, 2023 at 01:02:52PM +0300, Dmitry Baryshkov wrote:
>> On 27/03/2023 12:30, Varadarajan Narayanan wrote:
>>> Add dt-bindings for USB3 PHY found on Qualcomm IPQ9574
>>>
>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>> ---
>>>  Changes in v4:
>>> 	- Remove constraints not applicable to IPQ9574
>>>  Changes in v3:
>>> 	- Update other mandatory fields to accomodate IPQ9574
>>>  Changes in v2:
>>> 	- Updated sections missed in previous patch
>>> ---
>>>  .../bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml    | 25 ++++++++++++++++++++--
>>>  1 file changed, 23 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
>>> index e81a382..aa5b58c 100644
>>> --- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
>>> +++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
>>> @@ -21,6 +21,7 @@ properties:
>>>      enum:
>>>        - qcom,ipq6018-qmp-usb3-phy
>>>        - qcom,ipq8074-qmp-usb3-phy
>>> +      - qcom,ipq9574-qmp-usb3-phy
>>>        - qcom,msm8996-qmp-usb3-phy
>>>        - qcom,msm8998-qmp-usb3-phy
>>>        - qcom,qcm2290-qmp-usb3-phy
>>> @@ -122,8 +123,6 @@ required:
>>>    - clock-names
>>>    - resets
>>>    - reset-names
>>> -  - vdda-phy-supply
>>> -  - vdda-pll-supply
>>
>> Same questions as for the qusb2 PHY. How is the PHY powered?
> 
> It is powered by always on regulators. Will create fixed
> regulators and assign them to these.

always-on where? in DTS? Then it is not really related to this patch...
or you meant always-on power domains? Yet still device has power supplies.

Best regards,
Krzysztof

