Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4AD6DEAEB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjDLFVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDLFVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:21:33 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF7F4225;
        Tue, 11 Apr 2023 22:21:32 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id h24so10369394plr.1;
        Tue, 11 Apr 2023 22:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681276892; x=1683868892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYmSw4M2zSpTHIuVL2VCqZClUYz7peu+YKffC8bhUuM=;
        b=OP0qz1nv8X3eJDsXpGpbCfRAl8ZpuUjgXe3XrpJB96Hw0MVetiRnvjeb/F96BbMO7O
         bV1CfCSMFBVUYbvHb3Zp1O9Dn3h+aH37EKieZKib+Vbi2VMQglBIcVHojIM5WeSdL6PC
         TgaqozIiyCvNPH861mQyyovpdq47Svu5kCopVwIV/rS9V0miQWHhE+NC/W/Tg/V2MQ3b
         WJTSECW2GR36aMOXDA/1ioTvfunpnuzFQ2+VDb342a2XsBLrGVd8y2iB4fv84jRRCJQS
         ooDPd+tw0Grwqo5GvcJMARn/YRgZeLdO6EpbUMgEz2kcCBfb6dpVS0E50iJUgDUk6bGU
         1uSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681276892; x=1683868892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYmSw4M2zSpTHIuVL2VCqZClUYz7peu+YKffC8bhUuM=;
        b=B69IuUkAxF+iDcI7a9Uw0jGBfj8dntmYrG4fW/sk/Zk857t2iPFnxFIfEObxgl1efp
         xTdfNGoZQ0lTHv5BzQRPsAxzHGwZesovPUN8yIEFv5IOroj3s/PpVtspNDyibjzqHBcC
         qPxoQpBsSaizABunrK02inxrpEskSjgbcPk+uBhv+MEJJ5DEZdNR70Ms0Fb3wMhwT1l1
         bLhDPoYKbORf+NVxXGEFZsa9r+YhNUDq6NCWCSQSNdwEPD+AV7XIqj0g/1egBWd8qDau
         6rgxFFDWs7CelY6saedcu7i/AydtYpJpd+1v1wnVAeuvlNeSaCDpUzB2bIGGkkCCabZI
         HT2w==
X-Gm-Message-State: AAQBX9d8YyAf8Yjr66Oeq/1A2s9sjsUAH+SHHHFerOf1bDX8H70vjazi
        9TLWDYqwIMh+IBxuolKqueS56M0A9kzETA==
X-Google-Smtp-Source: AKy350Y9MweMdSI7XakQOqVias4XTj4mCMW1++u0u7/TthH3sBNsst8tkfffQ3rzVeyEjyNlrn+UfQ==
X-Received: by 2002:a17:902:c942:b0:1a6:6177:5f4f with SMTP id i2-20020a170902c94200b001a661775f4fmr942241pla.53.1681276892239;
        Tue, 11 Apr 2023 22:21:32 -0700 (PDT)
Received: from ?IPV6:240b:12:500:6500:bd4f:1cf3:a969:fcfe? ([240b:12:500:6500:bd4f:1cf3:a969:fcfe])
        by smtp.gmail.com with ESMTPSA id a19-20020a1709027d9300b001a065d3ea3bsm10474558plm.295.2023.04.11.22.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 22:21:31 -0700 (PDT)
Message-ID: <231f9093-968b-e008-f2ff-899d8b24459c@gmail.com>
Date:   Wed, 12 Apr 2023 14:21:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 2/2] ARM: dts: mvebu: add device tree for IIJ SA-W2
 appliance
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        sebastian.hesselbarth@gmail.com, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20230223132502.2045-1-musashino.open@gmail.com>
 <20230223132502.2045-2-musashino.open@gmail.com> <Y/d7gjqQCKKXMHqj@lunn.ch>
 <7d4a218d-8b8a-5a1d-eff8-e154bfde69be@gmail.com> <87jzyn3dv9.fsf@BL-laptop>
 <64b5504d-c81d-f77e-da67-c6d9e76aedd6@gmail.com>
 <b153523b-45cf-4e2e-8d62-de15b01a158d@lunn.ch>
From:   INAGAKI Hiroshi <musashino.open@gmail.com>
In-Reply-To: <b153523b-45cf-4e2e-8d62-de15b01a158d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew Lunn,

thank you for your guidance, I'll do it.

Regards,
Hiroshi

On 2023/04/09 23:07, Andrew Lunn wrote:
> On Sun, Apr 09, 2023 at 02:13:11PM +0900, INAGAKI Hiroshi wrote:
>> Hello Gregory CLEMENT,
>>
>> On 2023/04/08 0:34, Gregory CLEMENT wrote:
>>> Hello INAGAKI Hiroshi,
>>>
>>> do you plan to send a v2 soon based on the reviews you got ?
>> Yes, I'm planning to send the next series.
>> But I don't know the details about "documenting the board compatibles"
>> suggested by Krzysztof Kozlowski and I don't know what to do for it, so I'm
>> pausing this contribution...
> Create Documentation/devicetree/bindings/arm/marvell/armada-380.yaml
>
> Put in it
>
> # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> %YAML 1.2
> ---
> $id: http://devicetree.org/schemas/arm/marvell/armada-380.yaml#
> $schema: http://devicetree.org/meta-schemas/core.yaml#
>
> title: Marvell Armada 380 SoC architecture
>
> maintainers:
>    - Andrew Lunn <andrew@lunn.ch>
>
> description:
>    Platforms based on Marvell Armada 380 SoC architecture.
>
> properties:
>    $nodename:
>      const: '/'
>    compatibnle:
>      oneOf:
>
>        - description: Marvell Armada 380 SoC based platforms
>          items:
>            - enum:
>                - phytec,pcm049   # Phytec OMAP 4460 SoM
>            - const: "marvell,armada380"
>
> additionalProperties: true
>
>
> But replace the phytex,pcm049 with the compatible for your board.
>
>      Andrew
