Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA8A602F89
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiJRPWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiJRPWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:22:19 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21919C90C0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:22:16 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id i9so9513719qvu.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lv8WBr1FNWwiPSantujB2q1YWU9vZjg1PUxZfiq8E+E=;
        b=Y4jkCbYLflIwRtB6tQSvzHC9hCTgoxtJ9qJiwbAx+1BFzveaeElyQQRStj1+sBjMUr
         95iwr/wsNZiECpU+Z0BtMlqxmtsPzdbArvYhUL891k1ejFLiOxwzH665e/lQMSU7EFmU
         uwYdOQRX7sB6SP3nTlXYSEvouHzmG3fqV5SJ5YLKMnXrPcm/E06pbYp0Ym+mnP7t2WJ4
         C+0fi+TvJhVKWk0K+8armXEBms1snrgCxDSlDgVneMJW3jqOEeUuXH8cTcmUii+Ig+jk
         2GGUsgo0LUP8EmC+bVY/4hDrdyiFFEZnKrPWTn/GtX6ZfQneyebYwMxSoEXtU9p64d71
         d6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lv8WBr1FNWwiPSantujB2q1YWU9vZjg1PUxZfiq8E+E=;
        b=yeshiClMPMFkYDxuiWTJkL9ZfHpAr+mWFvWmUsKiImTZ1AectjhHOHTX8NfydMFJUb
         zvyUTlzhlCPxhTN75si7CwacrafaRLSq3p17eJiv2Tl6pA6INo2AamJ8HCggNHmDCley
         oIpMTjv20ZTv5iHDdUFdLEXdIb5JX0qFmpCdavtDBA0rF/pYzn4khibwrHai87n0YpUh
         HIt64uWjhBvC/mbpiV4lsEqTkA05Ck5q8mZuOUh6NmUmbtMHsOZdav2uGFNyEqbCs4aV
         FQQwVESqBkLIDwd+7UWWb9uhFn+ZTRr00tlQ5adQVlcUle/sJEwp/ZvqCANQAfmiEnzs
         5v+w==
X-Gm-Message-State: ACrzQf0TLpiRM6f1ZXk9smiU4TUYec9Iu5+KmKi4UiykK6PahtHIgwXg
        5kaltM4ERiGj2849j6zX8Lc59A==
X-Google-Smtp-Source: AMsMyM44obpzH0jsTyh/TW1xASYKTSf82eL3jRxtnD2rspTO5E09JiUI1qoHppormvOcoXFYQ9LJQQ==
X-Received: by 2002:a05:6214:27c5:b0:4b1:7b3b:4098 with SMTP id ge5-20020a05621427c500b004b17b3b4098mr2568272qvb.27.1666106535182;
        Tue, 18 Oct 2022 08:22:15 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id p12-20020ae9f30c000000b006eec09eed39sm2524367qkg.40.2022.10.18.08.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 08:22:14 -0700 (PDT)
Message-ID: <7a2b1617-5e57-994e-a246-2e6f9fd69262@linaro.org>
Date:   Tue, 18 Oct 2022 11:22:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 10/15] dt-bindings: phy: qcom,qmp-pcie: add sc8280xp
 bindings
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221017145328.22090-1-johan+linaro@kernel.org>
 <20221017145328.22090-11-johan+linaro@kernel.org>
 <d6642028-3fb9-4e39-a349-666625dabb9d@linaro.org>
 <Y050nxCaFXIgczrA@hovoldconsulting.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y050nxCaFXIgczrA@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2022 05:40, Johan Hovold wrote:
> On Mon, Oct 17, 2022 at 01:20:49PM -0400, Krzysztof Kozlowski wrote:
>> On 17/10/2022 10:53, Johan Hovold wrote:
>>> Add bindings for the PCIe QMP PHYs found on SC8280XP.
>>>
>>> The PCIe2 and PCIe3 controllers and PHYs on SC8280XP can be used in
>>> 4-lane mode or as separate controllers and PHYs in 2-lane mode (e.g. as
>>> PCIe2A and PCIe2B).
>>>
>>> The configuration for a specific system can be read from a TCSR register.
>>>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>> ---
>>>  .../bindings/phy/qcom,qmp-pcie-phy.yaml       | 163 ++++++++++++++++++
>>>  1 file changed, 163 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
>>> new file mode 100644
>>> index 000000000000..82da95eaa9d6
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
>>
>> Filename based on compatible, so for example:
>>
>> qcom,sc8280xp-qmp-pcie-phy.yaml
> 
> Ok, but as I mentioned in my reply to the previous patch, this file is
> the one that is expected to be extended with new bindings.

I would still propose to use compatible of this series and treat it as a
family name of compatible or similar devices. What other choice we have?

If new (third) PHY bindings appear, then rename older to "-legacies" and
this one to "-legacy"?

> 
> I can't seem to find where this naming scheme is documented now even if
> I'm quite sure I've seen it before. Do you have a pointer?

If you need the source of authority, then:
https://lore.kernel.org/linux-devicetree/YlhkwvGdcf4ozTzG@robh.at.kernel.org/

If you need unofficial documentation, then slides here:
https://osseu2022.sched.com/event/15z0W

If you need something official, that's on TODO list. :)

> 
> And does this imply that the file name should also include the gen infix
> of one of the original compatibles (e.g.
> "qcom,sc8280xp-qmp-gen3x4-pcie-phy.yaml")?

Since you already have here three compatibles, you cannot have one
filename matching exactly all of them, so we already accept something
generic. Therefore I proposed the common part - matching SoC component.

Best regards,
Krzysztof

