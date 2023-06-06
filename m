Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D475A724088
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjFFLKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjFFLJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:09:34 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D7B18E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:09:11 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-514859f3ffbso8422839a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 04:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686049749; x=1688641749;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHk4lqJIMcJBU3trXI4CY2TRCxArO5+ul5qmG1V8eqo=;
        b=G15eD3KJMo3aFVqvegLN3NDwVxTxKL++spzhKVfGJ83neywWRLBRRNVPJZhl291VRQ
         svnJLFZalIbHpcw47QVCUjguT3fC9zvyAW7UGl6b5hzg/8ZpftPlg/TjY1wVjqg3kRaK
         uKVqnsiw3aDHP3h8PZaARSp9hJe5zQwNbn5/txstfPi1TiZYSk/CwZyk9MdIjIqy3Qso
         iO7J4tcc4fBPTHTMSPMmC89gepIeWJ3bL245t4L78Z0cWx3ozw+eHO5jiJteKTRuBn9X
         pQ/IJDwrEcM4B9Iv7+taNYv0pxpJUm+5IGE6P00CatGu+9jiI+8yOvXTSyoz5auwaYd/
         kfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686049749; x=1688641749;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHk4lqJIMcJBU3trXI4CY2TRCxArO5+ul5qmG1V8eqo=;
        b=MsSgdOHk0BsBPRRd8l3U68pt+mqiq754DhfvFVdsF0OHFu8HDjA/+jeLvLAm1GcirT
         ZVL354QJ6D7Kx5pDOIx1/JqNBbQHyJbTHndN8aNbKuc6TkuwiDaxJX+HU2Uu8yP2OR09
         djbNQepOmYBmqWs+B9sHaYYykp4jNtBYZ5nOilDL5W5iwPsDhwtiXdIe5JZxffDJmPmz
         DzyUYmYt/A61S+bn6K8CwmtyapAPN0aAMMxAP3Ij9DNexxzEcBVKXJB9ROcbhnRuWg7C
         THQjYEeHnCcDPY5qoa3rwJrD7fFk4ZjYtTNRFxqTNHwVeY8oL7hYyzTUxjtTT3js/S88
         p7fQ==
X-Gm-Message-State: AC+VfDzu7ghMB9G51U9z7r7NIByUeJTA36s9DZD02TjRZCnDL41WuAQg
        C3c6Z8voVI8gIqHJ1169CGJNkA==
X-Google-Smtp-Source: ACHHUZ6Td/Zq2iecy9zyqO0qmTu5v5uoKcssxEATLV/trUubfg0NXZMg4drbubb11J+fBRgW9tHqwA==
X-Received: by 2002:a17:907:60d5:b0:962:582d:89d7 with SMTP id hv21-20020a17090760d500b00962582d89d7mr1784234ejc.38.1686049749621;
        Tue, 06 Jun 2023 04:09:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id d21-20020a056402517500b0050bc6c04a66sm4952793ede.40.2023.06.06.04.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 04:09:09 -0700 (PDT)
Message-ID: <5bfb5573-2de4-887b-0f10-e4dd6f084c39@linaro.org>
Date:   Tue, 6 Jun 2023 13:09:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v8 3/3] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "conor@kernel.org" <conor@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "enachman@marvell.com" <enachman@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>
References: <20230531234923.2307013-1-chris.packham@alliedtelesis.co.nz>
 <20230531234923.2307013-4-chris.packham@alliedtelesis.co.nz>
 <a23dd485-a3d9-e31f-be3e-0ab293fcfc4a@linaro.org>
 <785368df-1881-e62e-6172-d902cee814a8@alliedtelesis.co.nz>
 <eaf9d7cf-c9f5-a5d5-67af-c43761c3c6cf@linaro.org>
 <4ea0b16e-0cec-00db-c598-e0364a7edef8@alliedtelesis.co.nz>
 <9fc57052-5049-ed50-ca95-cfd1d0420dd9@alliedtelesis.co.nz>
 <20230606094855.1ab005eb@xps-13>
 <845924ba-d9bf-d0ec-e1f2-f721366f43c0@linaro.org>
 <20230606122812.411b223a@xps-13>
 <e0d14527-8147-5e8b-6a43-ee043e0d0f8b@linaro.org>
 <d0b2cdc5-12fd-9a19-b38c-0653b4147c2b@linaro.org>
 <20230606125724.126a4685@xps-13>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230606125724.126a4685@xps-13>
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

On 06/06/2023 12:57, Miquel Raynal wrote:
> 
>>
>> Now for actual paragraph:
>>
>> "If yes, then it means we would need to list *all* the nand chip
>> properties in each schema,"
>>
>> No, why? I don't understand. Use the same pattern as all other bindings,
>> this is not special. Absolutely all have the same behavior, e.g.
>> mentioned leds. You finish with unevaluatedProps and you're done, which
>> is what I wrote here long, long time ago.
> 
> Maybe because so far we did not bother referencing another schema in
> the NAND chip nodes? For your hint to work I guess we should have, in
> each controller binding, something along:
> 
>  patternProperties:
>    "^nand@[a-f0-9]$":
>      type: object
> +    $ref: nand-chip.yaml#
>      properties:
> 
> If yes, please ignore the series sent aside, I will work on it again
> and send a v2.

nand-controller.yaml has it, so ideally each device binding should not
need it, because it already references nand-controller.yaml. However if
it doesn't work, then you need nand-chip in each device binding.

Best regards,
Krzysztof

