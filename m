Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3B4631B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiKUI1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiKUI1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:27:03 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545406253
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:27:02 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id l8so13640408ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wYa6qiy8lMPys5blH9J/G1eMKnRjWk2O1ZKygOJRkTQ=;
        b=Cj2/VIzR/21o/tDbTWZPg8AGCS4nhfSg7B+uN9/AR/5LGg0FRaKRyalpThYZxC53mJ
         pnbm+WJ9fCqM1NC8ka3B5R0z2fGv7B3oc/AMH+IuYEistzWxn6NkPDevW0qDkJLQuXyZ
         bYo8jbLfTX6skcVDVIqtgCNxIT6bzhM3f/7GortQZEwVdTwtRwQF/6vEMDST+ioPEA0v
         kxFNTuOyCF++tItPtJImlhbwQy9qjFTkL4RnpKEPpzwir3xS3iBMNqf4BFRCi3tSOt+T
         CjEGYpiI5z3UAwO7fSltILV2sIZ0weSNBtrk2EW++azDJJtPkoBgb0OV6y5E0LEU+c3k
         qCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYa6qiy8lMPys5blH9J/G1eMKnRjWk2O1ZKygOJRkTQ=;
        b=Vg+mwksbaXIk5W0WL6aUIJ5Q4fZVW1dXFnSFBWpOAkWXr1YZaljTiSHvjsyoN0lxad
         lNLzhnXJ9WNWJR1hQGbkjaN02Vg9KBca/QgVviXCSskr/5VuMWHHJF2ekV7+qJidfQkw
         SU9lR8eRDmdUn8jZHEpFbzeKS1A20H8bc0PpVg2xan9LD3O+BGlspsN/LceYeIAus9zZ
         JEqjkaHyD8xKLeN4Z07BMLxQLOHLpFTPuKbt+Nd+jKjBuXg8rab7WxiedH9EDEECwbIP
         ilonAZcsciEm5DagU5Wo/7g0N6XpQWGgyGjKAChnjIISlkJf73jBQiyGt7zFSAl/mm3C
         esWg==
X-Gm-Message-State: ANoB5pnzV7bMKqpOvkIrcxYktTOyiS9jBwdNhLK5DN+vCmDI+7Lk0BtC
        lmRDBu2mx7blrATADNhIgEr9Aw==
X-Google-Smtp-Source: AA0mqf5RPWYa6p3CjzIW6ePaZSL0+GAKbQbFHq0c225RFkodYWsPwYzdEjwB8RTo/+JQghTXRFRFow==
X-Received: by 2002:a2e:b5ae:0:b0:277:3df:90d0 with SMTP id f14-20020a2eb5ae000000b0027703df90d0mr384156ljn.234.1669019220719;
        Mon, 21 Nov 2022 00:27:00 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 9-20020a2eb949000000b0026dcf0cbb97sm1379191ljs.137.2022.11.21.00.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 00:27:00 -0800 (PST)
Message-ID: <795deac4-71fe-d40b-a3b6-855eb3875ad1@linaro.org>
Date:   Mon, 21 Nov 2022 09:26:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/8] dt-bindings: power: supply: Add DT schema for
 Qualcomm SMBCHG
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alejandro Tafalla <atafalla@dnyon.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
References: <20221120154625.57095-1-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221120154625.57095-1-y.oudjana@protonmail.com>
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

On 20/11/2022 16:46, Yassine Oudjana wrote:
>>> +  interrupts:
>>> +    items:
>>> +      - description: Charger error
>>> +      - description: Charger inhibited
>>> +      - description: Charger precharge safety timer timeout
>>> +      - description: Charger charge safety timer timeout
>>> +      - description: Charger pre to fast charging switch threshold reached
>>> +      - description: Charger recharge threshold reached
>>> +      - description: Charger taper threshold reached
>>> +      - description: Charger charge termination threshold reached
>>> +      - description: Battery hot
>>> +      - description: Battery warm
>>> +      - description: Battery cold
>>> +      - description: Battery cool
>>> +      - description: Battery overvoltage
>>> +      - description: Battery low
>>> +      - description: Battery missing
>>> +      - description: Battery thermistor missing # unconfirmed
>>> +      - description: USB input undervolt
>>> +      - description: USB input overvolt
>>> +      - description: USB input source detected
>>> +      - description: OTG regulator failure
>>> +      - description: OTG regulator overcurrent
>>> +      - description: Automatic input current limiting done
>>> +      - description: USB ID pin changed
>>> +      - description: DC input undervolt
>>> +      - description: DC input overvolt
>>> +      - description: Power OK
>>> +      - description: Temperature shutdown
>>> +      - description: Watchdog timeout
>>> +      - description: Flash failure
>>> +      - description: OTST2 # unknown
>>> +      - description: OTST3 # unknown
>>
>> It seems you listed register interrupts, not physical pins. This should
>> be interrupt lines.
> 
> I'm not sure what I'm supposed to do here. I couldn't find an interrupt-lines
> property used anywhere so that's not what you meant, right?

Are these physical interrupt lines this device has, register offsets or
virtual interrupts (e.g. passed via irq_chip)? Definitely not the first
and rather offsets for qpnpint_irq_domain_translate. Devicetree is not
for describing register layout of devices. IOW, register layout does not
change on different boards, because the device is exactly the same, so
there is no point to put it into DTS.

Best regards,
Krzysztof

