Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368BC6C2B37
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCUHRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjCUHRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:17:05 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B053E0B8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:16:53 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id o12so55899458edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679383012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GD9sWoGachnVcnj7BiD284LKFFQ2JluoRM5HPqQ7YTQ=;
        b=XYOn21GvwINhYxCcRgPUmrD7vtp46gwQAWmpOq1R54xEtk8Y6GvWpfoUIoO2X+3nLz
         WNGrxF9rZi0xnIotOO3PStbgvqK0hQ62BOOKx2lgmJdGD70ay3riYFIIwHqZl15c/TR0
         dm7NM8MU1ap1yAITcZmEgYWXogP/FVrE0QoAmVGcW/9WvJMgHOK/lqkWeSI6g3mKLQCU
         cGDMO/ifAWqdAw+D0BjXFVTXF1fPlFQaNtbn9qS54U9fO/mtfnIClZYVoI6+gmeomW0Q
         oRZa+oMDVaCybu5hkz3mzc7X21MZpUzgRgfOZjetuFTT22nRk1SHRriN/Fs8kI2QhpnW
         iAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679383012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GD9sWoGachnVcnj7BiD284LKFFQ2JluoRM5HPqQ7YTQ=;
        b=TYUDbZ2dseZDElc/brPkPWtghd0OV+81qxD08tzwqlAt6YtxYRMVxeoQSJQE2Kbe7Y
         dLycMfQagpcXABoOWwqmfsnORKQV0KogvPQ7lokaKPBuXj4MP2mQS6a7zGyrOpDLMXsB
         zDBhM6c2lv4v5loku2fr3CpvYnodDN3jUn8Nx8yvz8dCzpe1CZfsBtUajoso1VaDTQq7
         A0zOuvQ7oUpDyONQFFGb+Fj20aHElAFY+2M4Ke6ALCzFtsMPk4dnWArHz/pGO7+QRCvV
         4Wn9qH3X7YoP6mPkxl78b9PvgbU9dYs3EgIf3hSTXbkNr/AoSZaejelCKDmRpFls/erT
         +p0Q==
X-Gm-Message-State: AO0yUKXzabEU03fMdVUJvVmVmhcuE/v/Z1kRocE7dlvpzEpB5BtU7y6H
        kD6tFtvNoSKf4FOX+9+ZP7Vd7FhX3aYUg0s69nQ=
X-Google-Smtp-Source: AK7set8Gbxjh1zagzPuehxDmVk/F28LJB4nNhEO+htLGAF1/Jf5T1CQyEoPitbT9G8mBMwfU8TMvgA==
X-Received: by 2002:a17:906:2286:b0:931:1ccb:7360 with SMTP id p6-20020a170906228600b009311ccb7360mr1894222eja.39.1679383011716;
        Tue, 21 Mar 2023 00:16:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:2142:d8da:5ae4:d817? ([2a02:810d:15c0:828:2142:d8da:5ae4:d817])
        by smtp.gmail.com with ESMTPSA id g20-20020a1709061e1400b00930f5ecbd8fsm5418454ejj.219.2023.03.21.00.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 00:16:51 -0700 (PDT)
Message-ID: <0ece990e-fd81-856a-bd0e-8a2572448aa3@linaro.org>
Date:   Tue, 21 Mar 2023 08:16:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/9] dt-bindings: clock: add mtmips SoCs system
 controller
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, arinc.unal@arinc9.com
References: <20230321050034.1431379-1-sergio.paracuellos@gmail.com>
 <20230321050034.1431379-2-sergio.paracuellos@gmail.com>
 <5f295438-8334-d374-2ae6-2a385ffb317d@linaro.org>
 <CAMhs-H_dSgcPNQVusHWVvztYHptOxSJ_o7G0eU9=M1C7RXdsVw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMhs-H_dSgcPNQVusHWVvztYHptOxSJ_o7G0eU9=M1C7RXdsVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 08:00, Sergio Paracuellos wrote:
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - ralink,mt7620-sysc
>>
>> Since you decided to send it before we finish discussion:
>> NAK - this is already used as mediatek
> 
> Sorry, there was too much stuff commented so I preferred to clean up
> all of them while maintaining the compatibles with the ralink prefix
> instead since that was where the current discussion was at that point.

You did not even wait for me to send feedback on this, in old thread.

> 
>>
>>> +          - ralink,mt7620a-sysc
> 
> As I have said, this one exists:
> 
> arch/mips/ralink/mt7620.c:      rt_sysc_membase =
> plat_of_remap_node("ralink,mt7620a-sysc");

And why do you ignore others which have mediatek?

> 
> 
>>> +          - ralink,mt7628-sysc
>>
>> Same here.

Same problem.

>>
>>> +          - ralink,mt7688-sysc
>>
>> I expect you to check the others.
> 
> I can change others to mediatek but that would be a bit weird, don't you think?

No, I expect to have mediatek where the model is already used with
mediatek prefix.



Best regards,
Krzysztof

