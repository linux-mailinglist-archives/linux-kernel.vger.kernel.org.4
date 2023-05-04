Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F226F6561
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjEDG7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjEDG7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:59:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69AB2700
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 23:59:33 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc4ba28cbso131894a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 23:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683183572; x=1685775572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TiFB/UoH02QxMVuFsiqiYDIAM/HbqoK7MxIW7zPttsE=;
        b=QM6Dt7E6rCmr3jsyqwXltDs/OAG3ggAKlpynxcws+D4sxNkX2TLcQAjIJqePRzrSpz
         6stj0J1i5JYd1PVPDN35Te6TSMTrS6U0sA45l9b8YO+nLZyV7iom4NSR6GkC07C9b0oT
         M1CMXUQsep0L6fdybwLQ45h6LPAxZuvZ/pT+BTxu3eGIXL3uU81L/B5NDD/4ul3Yu93Y
         DACVaFz+lJnD+8q6hSa0/9tAcR2PFM1XleThiIiGbMq9k98Zouvaz4B/QkJg8dBXY+dH
         VroqlxwLmzy2e4dkrR2azI51Ur50zsRawI9ajoydHqzWZ6ARMzM3gzsT467Mf0UVGpVH
         AfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683183572; x=1685775572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TiFB/UoH02QxMVuFsiqiYDIAM/HbqoK7MxIW7zPttsE=;
        b=dnDX0lSL3kuftBJTL/Qu8gBADlmPpqdKN0iIebbDvmTrhjxnlYbMBkPH998SSLc+B2
         fuuTF+YWHrd1r+/efUBIDcau6B0ZnUiOk1gSd16tGT9JhGgYkEGiHBDctraYPaIGfxeb
         kwQrRiiBITUEQrdnUb/D+ZUXo13lmvCk2UEQ8EWW7ZcZPR7S2upC5r37eUGP3wFKNzM0
         9lQvIPXEQC3t2BFENtAiDfSUfZvXhyjEPailfgju7IyIHA+OvnbsXyaIlqjIYixVciH9
         xUMGQdf9PIaf/SCZgOhBlrYY3CnR5I81R9wcf7B8oNTwS15OXdrKXW1JYHcg242PPTMS
         WDoA==
X-Gm-Message-State: AC+VfDxJ4S442Ikqx2hK+KHor6H84zJNN+M0Z/aoku5hGlpELWPiQt9y
        8+YuB6LrmjZ2a+3HKm6AeCcr/Q==
X-Google-Smtp-Source: ACHHUZ6T8Ks115imDbUGYEXTNTNiGFw3TKZdatRyYj/VReFtB7asPkPBBKqhasHUTW+qL6Jb1VMb8A==
X-Received: by 2002:a17:907:2da9:b0:947:3d04:61dc with SMTP id gt41-20020a1709072da900b009473d0461dcmr6239846ejc.77.1683183572295;
        Wed, 03 May 2023 23:59:32 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id dn1-20020a17090794c100b00953381ea1b7sm18245488ejc.90.2023.05.03.23.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 23:59:31 -0700 (PDT)
Message-ID: <19bccb62-b7e0-855d-fb5f-4fd3dde4f6f0@linaro.org>
Date:   Thu, 4 May 2023 08:59:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 2/3] mfd: axp20x: Add support for AXP15060 PMIC
Content-Language: en-US
To:     Andre Przywara <andre.przywara@arm.com>, Lee Jones <lee@kernel.org>
Cc:     Shengyu Qu <wiagn233@outlook.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        conor.dooley@microchip.com,
        Martin Botka <martin.botka@somainline.org>
References: <20230421150816.10513-1-wiagn233@outlook.com>
 <TY3P286MB261162D57695AC8164ED50E298609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230426142740.GN50521@google.com>
 <20230503120759.6fd6a7a9@donnerap.cambridge.arm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230503120759.6fd6a7a9@donnerap.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2023 13:07, Andre Przywara wrote:
> On Wed, 26 Apr 2023 15:27:40 +0100
> Lee Jones <lee@kernel.org> wrote:
> 
> Hi Lee,
> 
> I see this patch in Linus' tree, but something must have gone wrong here,
> can you please check? See below ...
> 
>> On Fri, 21 Apr 2023, Shengyu Qu wrote:
>>
>>> The AXP15060 is a PMIC chip produced by X-Powers, and could be connected
>>> via an I2C bus.
>>>
>>> Describe the regmap and the MFD bits, along with the registers exposed
>>> via I2C. Eventually advertise the device using a new compatible string
>>> and add support for power off the system.
>>>
>>> The driver would disable PEK function if IRQ is not configured in device
>>> tree, since some boards (For example, Starfive Visionfive 2) didn't
>>> connect IRQ line of PMIC to SOC.
>>>
>>> GPIO function isn't enabled in this commit, since its configuration
>>> operation is different from any existing AXP PMICs and needs
>>> logic modification on existing driver. GPIO support might come in later
>>> patches.
>>>
>>> ---  
>>
>> You must not use these above the tags or Git will drop them.
>>
>>> Changes since v2:
>>>  - Rebase to AXP313a series v10 [1] + newest (20230420) -next branch
> 
> So this patch was based on the AXP313a series, but I don't see that in
> Linus' tree (or in any of your trees, if I have checked correctly).
> There must have been a conflict, as this [PATCH v3 2/3] diff actually lists
> the axp313a entry in the context lines.
> 
>>>  - Add axp_regulator_only_cells rather than directly using axp806_cells
>>>    for cases that IRQ line isn't connected.
>>>
>>> Changes since v1:
>>>  - Nothing
>>>
>>> [1] https://lore.kernel.org/linux-sunxi/20230401001850.4988-1-andre.przywara@arm.com/
>>>
>>> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
>>> ---  
>>
>> Put change-logs here instead.
>>
>>>  drivers/mfd/axp20x-i2c.c   |   2 +
>>>  drivers/mfd/axp20x.c       | 107 +++++++++++++++++++++++++++++++++++++
>>>  include/linux/mfd/axp20x.h |  85 +++++++++++++++++++++++++++++
>>>  3 files changed, 194 insertions(+)  
>>
>> I manually added the missing tags for this and the DT patch and applied.
> 
> So this patch doesn't list any tags aside from Shengyu's
> Signed-off-by. The patch in Linus' tree list a Reviewed-by: from
> Krzysztof, which I don't see anywhere in the thread, he just reviewed the
> binding patch, AFAICT. 

Yep, I never reviewed this.

> I see your tentative R-b: on v2, but with the
> request to rebase and resend, which he did with v3. The applied patch
> looks like v3, but not on the base commit this was send against.
> 
> So I am slightly confused, and am also wondering what happened to the
> AXP313a patches? I see the binding patch merged, but not the MFD part,
> even though you replied saying so.

Because the patch #1 was broken, see:
https://lore.kernel.org/all/TY3P286MB261177CF7AA2959BD9517DA998609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM/

The SoB and Reviewed-by were after --- and apparently b4 understood it
as cover letter and applied everywhere.

Lee,
Do you have the latest b4? If yes, this should be reported as b4 bug,
assuming you used it.

Best regards,
Krzysztof

