Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499F872A317
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 21:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjFIT37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 15:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjFIT34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:29:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613281BD6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 12:29:55 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-977d6aa3758so377797666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 12:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686338994; x=1688930994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HSPNaIF3oUc5Uqz1Lg3Wxlto0lgY12nQdg30SRNclSM=;
        b=Rm9plUYN65SWld6+2qVEkDkGqVAbSsEEM0dVKfXOoLo3QFWRBxakiFl2UfiaofHTXE
         Hd/9eEPgS5LQpK3zjcK043s3L0aJmmFB6GE7vqvqNktpUNibEdLBW11Hsye4LWmmG2ct
         zyzUXGha2Agz3PZg40I0GomuU1U0ah3ob0JUMOPOUnKam4bqxCOP7bN/VJt7B3s37MxP
         +MgC2ZwqL42K83JqYZ+IFvfTUiPGA/7ASKnoF3IbqNIRWeuMaBZOI0Kv0TGrxWN314fX
         LncDKaF/cH94/HWIHsWX4AGBiSifWkEK3DrEJLhmGsQ4/hwLDmp4jbNftqwtP34baFvZ
         2f6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686338994; x=1688930994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSPNaIF3oUc5Uqz1Lg3Wxlto0lgY12nQdg30SRNclSM=;
        b=e0pXIQaBl+Ko5ooEJw2UZN+mahggA3eia2altKyHGuWGZB62eaad9bxTzZ5FYed0vy
         4cKLsY9pLJP+C7sZrV1jFOIvy7cPl/x6V/LMVGELxZUfy5DHydc3Jzh23LGT7xICk8HP
         PP9CddylPOThOuZxQSY+6lQJVNCV/CzU98hLs5waXWW503b5e9qaCJZEtfrGwpcTvBox
         MBTCWZPaQsExewgSg6bSe+FaQRa9nevrQuixXFhfq8f5JoNNgFdi3iBCN2Q7RiqfgLzc
         7SEBIixfviAlq6CsM4pRJhcVGajb7IiUumWkiATgY2arygjTfVo4YvSqk5/WonrEVC5D
         OW+g==
X-Gm-Message-State: AC+VfDzR2wHNyUNKe356fqVQJXL7wBFp+ETUTT7veyYvA5BKtmuWNmqE
        Akd1WCEn0BfaIKVKyy9CvarKIQ==
X-Google-Smtp-Source: ACHHUZ4+9kU/2bNQpwz+FdxKMmXy5FOJRsmWaFg70DtCKGU3quLjnF9fRnTL0KRG0rEmnUBP51WY7w==
X-Received: by 2002:a17:907:2682:b0:978:6634:d05c with SMTP id bn2-20020a170907268200b009786634d05cmr3036248ejc.21.1686338993883;
        Fri, 09 Jun 2023 12:29:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id fy25-20020a170906b7d900b0096b55be592asm1611536ejb.92.2023.06.09.12.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 12:29:53 -0700 (PDT)
Message-ID: <7ad5d027-9b15-f59e-aa76-17e498cb7aba@linaro.org>
Date:   Fri, 9 Jun 2023 21:29:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/2] NFC: nxp-nci: Add pad supply voltage pvdd-supply
To:     Raymond Hackley <raymondhackley@protonmail.com>
Cc:     broonie@kernel.org, davem@davemloft.net,
        devicetree@vger.kernel.org, edumazet@google.com,
        jk@codeconstruct.com.au, kuba@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, michael@walle.cc,
        netdev@vger.kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        u.kleine-koenig@pengutronix.de
References: <20230609154033.3511-1-raymondhackley@protonmail.com>
 <20230609154200.3620-1-raymondhackley@protonmail.com>
 <e2bb439c-9b72-991b-00f6-0b5e7602efd9@linaro.org>
 <20230609173935.84424-1-raymondhackley@protonmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230609173935.84424-1-raymondhackley@protonmail.com>
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

On 09/06/2023 19:40, Raymond Hackley wrote:
> Hi Krzysztof,
> 
> On Friday, June 9th, 2023 at 3:46 PM, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> 
>> On 09/06/2023 17:42, Raymond Hackley wrote:
>>
>>> PN547/553, QN310/330 chips on some devices require a pad supply voltage
>>> (PVDD). Otherwise, the NFC won't power up.
>>>
>>> Implement support for pad supply voltage pvdd-supply that is enabled by
>>> the nxp-nci driver so that the regulator gets enabled when needed.
>>>
>>> Signed-off-by: Raymond Hackley raymondhackley@protonmail.com
>>> ---
>>> drivers/nfc/nxp-nci/i2c.c | 42 +++++++++++++++++++++++++++++++++++++++
>>> 1 file changed, 42 insertions(+)
>>>
>>> diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
>>> index d4c299be7949..1b8877757cee 100644
>>> --- a/drivers/nfc/nxp-nci/i2c.c
>>> +++ b/drivers/nfc/nxp-nci/i2c.c
>>> @@ -35,6 +35,7 @@ struct nxp_nci_i2c_phy {
>>>
>>> struct gpio_desc *gpiod_en;
>>> struct gpio_desc *gpiod_fw;
>>> + struct regulator *pvdd;
>>>
>>> int hard_fault; /*
>>> * < 0 if hardware error occurred (e.g. i2c err)
>>> @@ -263,6 +264,22 @@ static const struct acpi_gpio_mapping acpi_nxp_nci_gpios[] = {
>>> { }
>>> };
>>>
>>> +static void nxp_nci_i2c_poweroff(void *data)
>>> +{
>>> + struct nxp_nci_i2c_phy *phy = data;
>>> + struct device *dev = &phy->i2c_dev->dev;
>>> + struct regulator *pvdd = phy->pvdd;
>>> + int r;
>>> +
>>> + if (!IS_ERR(pvdd) && regulator_is_enabled(pvdd)) {
>>
>>
>> Why do you need these checks? This should be called in correct context,
>> so when regulator is valid and enabled. If you have such checks it
>> suggests that code is buggy and this is being called in wrong contexts.
>>
> 
> First condition !IS_ERR(pvdd) is to check if pvdd exists.
> Some devices, msm8916-samsung-serranove for example, doesn't need pvdd or
> have it bound in the device tree:

If regulator is missing you should get a dummy.

But anyway the code will not be executed if you don't get proper regulator.

> 
> https://github.com/torvalds/linux/commit/ab0f0987e035f908d670fed7d86efa6fac66c0bb
> 
> Without !IS_ERR(pvdd), checking it with regulator_is_enabled(pvdd):
> 
> [   50.161882] 8<--- cut here ---
> [   50.161906] Unable to handle kernel paging request at virtual address fffffff9 when read
> [   50.161916] [fffffff9] *pgd=affff841, *pte=00000000, *ppte=00000000
> [   50.161938] Internal error: Oops: 27 [#1] PREEMPT SMP ARM
> 
> Or disabling it directly with regulator_disable(pvdd):
> 
> [   69.439827] 8<--- cut here ---
> [   69.439841] Unable to handle kernel NULL pointer dereference at virtual address 00000045 when read
> [   69.439852] [00000045] *pgd=00000000
> [   69.439864] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> 
> Second condition regulator_is_enabled(pvdd) is to make sure that pvdd is
> disabled with balance.
> 

So you have buggy code and to hide the bug you add checks? No, make the
code correct so the check is not needed.


> Similar checks can be found here:
> 
> https://elixir.bootlin.com/linux/v6.4-rc5/source/drivers/staging/greybus/arche-apb-ctrl.c#L208

staging driver is not an example...

> 


Best regards,
Krzysztof

