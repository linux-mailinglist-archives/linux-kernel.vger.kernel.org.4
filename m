Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C292D6989D2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 02:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBPB1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 20:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPB1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 20:27:37 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD4C3A851;
        Wed, 15 Feb 2023 17:27:35 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 12A1783623;
        Thu, 16 Feb 2023 02:27:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1676510853;
        bh=+5uh659jRk20xdyjABEXrzLlKYQCsRAUPaeAVAAPj2E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RzpFQJn34bJboFL2/q3XNRKx0Sb0W3nUwNl5pdiq5dWGEUT0tCXJr1HK1yir+AhD5
         eHu789Dy1gCJMZAW6fH4nw61Q/D2cBceWYZL9r2YfDnlKpAxZYXluFDtSczoDAxX9d
         VQ9bYqCb7uADIHE1b/xL9/E6UKqaBmBow21LU/L7/6pYNuxEibnAlmUHNEgZI6wCt2
         5yZw9gwr3aZWaRgixDXDzUkq8fBJKyoT731EBhFLWNWRG+xWbYxmGQOBDJ+NbwmiSL
         Zuxzc8uHif+OdJlg6hmWpaA+Lh9FlJgbXwgHzQ41GFbeR1EYE9g+/lU/hh/t3M+BHB
         xpBmzj9sPDKNQ==
Message-ID: <a32979ac-d272-0865-f453-c65d405814c8@denx.de>
Date:   Thu, 16 Feb 2023 02:27:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/6] dt-bindings: regulator: pca9450: Document new usage
 of sd-vsel-gpios
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Frieder Schrempf <frieder@fris.de>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Robin Gong <yibin.gong@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Per-Daniel Olsson <perdo@axis.com>,
        Rickard x Andersson <rickaran@axis.com>
References: <20230213155833.1644366-1-frieder@fris.de>
 <20230213155833.1644366-2-frieder@fris.de>
 <20230215200213.GA467386-robh@kernel.org>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230215200213.GA467386-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/23 21:02, Rob Herring wrote:
> On Mon, Feb 13, 2023 at 04:58:19PM +0100, Frieder Schrempf wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> The sd-vsel-gpios property is abandoned in its current meaning as an
>> output. We now use it to specify an optional signal that can be
>> evaluated by the driver in order to retrieve the current status
>> of the SD_VSEL signal that is used to select the control register
>> of LDO5.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>>   .../regulator/nxp,pca9450-regulator.yaml      | 23 ++++++++++++++-----
>>   1 file changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
>> index 835b53302db8..c86534538a4e 100644
>> --- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
>> +++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
>> @@ -40,8 +40,24 @@ properties:
>>       description: |
>>         list of regulators provided by this controller
>>   
>> +    properties:
>> +      LDO5:
>> +        type: object
>> +        $ref: regulator.yaml#
>> +        description:
>> +          Properties for single LDO5 regulator.
>> +
>> +        properties:
>> +          sd-vsel-gpios:
> 
> It is a pin on the device, right? Then it belongs in the device node as
> it was.
> 
> Can't the direction of the signal tell you how it is used? Assuming the
> pin is bidirectional?

The pin is input to the PMIC, it is unidirection, i.e.

SoC(output)---->(input)PMIC

> The binding should support any possible way the device is wired, not
> just what's been seen so far on some boards.

The usage is always the above as far as I can tell.
