Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44646E19B0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjDNB1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjDNB12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:27:28 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D20D10CE;
        Thu, 13 Apr 2023 18:27:24 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id i8so7951916plt.10;
        Thu, 13 Apr 2023 18:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681435643; x=1684027643;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7e1K5KUM1sKV7u8vE+m892s6VxEgbsGTd2a1+XmX1kY=;
        b=BCUaQg3bRLKlpdQpoCIsj/I1tUa3DYnsvXcaRf2vSR/VNeq9P/xBCM0pwajs5mHwZa
         npO5Uvg6WXMU+Wh6YapT4asYmDC3w57EWuG1hMVWbViThPU/xjGU59ooMYA+aqQa+1uJ
         xma8UWEBF9g9sIlCasiRrQ/rpVgcY7u6m3UrD2GAUOLL2ZrNn5x32M76EU9/Kx7odn4Q
         i2QX0qH7Af2ukVO/2fc9y+X5D4urhFRjVkeJ53o8GuMRcZRBNBBbKRNT4KfSJRXN8pMi
         tzCQ1Mo6oPlvXdIM0N0Homm3t0P6UcRdR6H8eS4MSL3+z+v9XCNczkUwdxMCIn42pwj6
         3xNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681435643; x=1684027643;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7e1K5KUM1sKV7u8vE+m892s6VxEgbsGTd2a1+XmX1kY=;
        b=MMwktiVydJtEnqoiwCltfGruxtGuh4m7HipGLpXMC9Kf1NIMrKYssc/5rKMJ/H6CZ1
         eHsz3mRgQJ3GAUfQUNbzxAOrAJE7dvAlVZ4B7e5gULHiPUIoCqMhF7iH5yZJ8p+bWpy9
         BkJrFpsg77t2mHStdSPvXGesHLjal5aMfCRkEs/Gb+UPvo4ljBi8xB4cwG9XxrOjQUXt
         QauLdtK9I1eS97ws6bqhsRhznjjmUxFQluVovmrYXSnfH6YasRe4irQrfhr7RYERwiiM
         0u05pLWIgDM6cvk8XbFIhvMJHGt34a2XtzPSShypac293/sqFmAVzbh7To00gC+Z/EiG
         Nrbw==
X-Gm-Message-State: AAQBX9emh9x5IGs+h5e2TNKydj2P96o5C1fzyFCtcv7usuIxnO0Wns5n
        IL4wrUif4AZFBWxd1BzZd9g=
X-Google-Smtp-Source: AKy350bbpqogNkI3jhwOrZ0bvzVKFROO1sDvhHDTxJlpUDPNpqBbARjRCXlDribYq1WaiC4OxdYUHA==
X-Received: by 2002:a17:902:f690:b0:1a6:6b30:2b3b with SMTP id l16-20020a170902f69000b001a66b302b3bmr982287plg.64.1681435643536;
        Thu, 13 Apr 2023 18:27:23 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id g21-20020a170902869500b001a5260a6e6csm2040787plo.206.2023.04.13.18.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 18:27:22 -0700 (PDT)
Message-ID: <8dc47b4b-0b96-1679-1132-50699e57e999@gmail.com>
Date:   Fri, 14 Apr 2023 09:27:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 06/12] dt-bindings: arm: Add initial bindings for
 Nuvoton platform
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
 <20230412053824.106-7-ychuang570808@gmail.com>
 <e759426e-6c2c-91fa-99d7-712339624adb@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <e759426e-6c2c-91fa-99d7-712339624adb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Krzysztof,


On 2023/4/14 上午 01:01, Krzysztof Kozlowski wrote:
> On 12/04/2023 07:38, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Move 'nuvoton,npcm-gcr.yaml' from 'arm/npcm' to 'soc/nuvoton'.
>> Rename the '/arm/npcm' directory to 'arm/nuvoton'. Additionally, add
>> bindings for ARMv8-based Nuvoton SoCs and platform boards, and include
>> the initial bindings for ma35d1 series development boards.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  | 30 +++++++++++++++++++
>>   .../npcm.yaml => nuvoton/nuvoton,npcm.yaml}   |  2 +-
>>   .../nuvoton/nuvoton,npcm-gcr.yaml}            |  2 +-
>>   3 files changed, 32 insertions(+), 2 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml
>>   rename Documentation/devicetree/bindings/arm/{npcm/npcm.yaml => nuvoton/nuvoton,npcm.yaml} (93%)
>>   rename Documentation/devicetree/bindings/{arm/npcm/nuvoton,gcr.yaml => soc/nuvoton/nuvoton,npcm-gcr.yaml} (93%)
> I don't think you fixed the failure it was reported. Your changelog also
> does not mention it.
>
> Fix all comments and reports given. Path(s) in maintainers is/are broken.
>
>
>
> Best regards,
> Krzysztof
>

Okay, I will add an explanation to the v7 changelog.
The path issue will be fixed in the next version.

Thank you,
Jacky Huang

