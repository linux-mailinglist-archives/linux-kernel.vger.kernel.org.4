Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152BB66E50D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjAQRet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbjAQRaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:30:08 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3054C6D0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:27:51 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id q8so11051208wmo.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HMhRj55+FlBV8AnEx7lPTuRrB6YXNSp4LjzY65UiMzU=;
        b=mMRyB04Cs5nsYPURjKXknVEbmfwBu1pMQ3q0mVHsOjMBjki2X4Cnh1jViKjn8OYG2H
         hkBvdKEx2dBEwk/qtCbyfmpD6J61K1UCZoM78V/fhrx4sCflEflNbysG6VKu2uf8RSNg
         20UDbgpiEni0HETWgXvUhyGmbIvzfVCeQEl9vDbVz0ritOMcmBI8cv40R1yCYEKY1bo8
         Ow+LUaTS9UN6LFkI3j/59rnyXVoYBIpJB0oQyIM8GDIaXW8I7qkWDPDHXrwv2sKUp6tK
         +FyDnMGTYD11ELbAjaR4FxELuso6ubFAExB+Yc1gEMZB4IrA+RLFbDbCoolGds54jwnI
         T0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HMhRj55+FlBV8AnEx7lPTuRrB6YXNSp4LjzY65UiMzU=;
        b=N059LcKKufqJnj9b4rxgHIGvKvn1VmEqvx+dAgsQxgXvTiE0S3mWwSr4kxm93G++h8
         sa+y49CtTL1Af6q7h9VLzCiSmGt0foWlGTiJaHboyMjuZa/YCLru3Jxyls84tqRGszYl
         xJLPDKDCcoq/oGgU3W6zWK+lUOKkmxlc/8ySnaLhiWmdpcgiUIWB0JKHl6x5nUPiQ/jD
         YU99ke3RwYn7t4ZexIRWfOW4IChzyhn+l5FuMF1lAc8IjV5DgpQV0tRuNO3XUUXsxE/l
         NdxeOIPEubupHQaYmHbpLPa/IRXwUtsAFlHghg2/Y3jDCZEUIqVt1zu8mXyNFxBnHlKf
         ukFg==
X-Gm-Message-State: AFqh2krJCUNQkT8t0raYutynq06rYuoNBO4aSJwRebLfe64q3x3sfv4h
        x3RFLynFR+2unLywIAQcF8vP184BedLp+gnQ
X-Google-Smtp-Source: AMrXdXsZ5M/PaT4jLZnhd+vgeUw9SWN7Q+bjPS15BrBTwpini9J/Q0h5CT6wJmyRi25J8KtuhryzDQ==
X-Received: by 2002:a1c:7312:0:b0:3d2:3eda:dd1 with SMTP id d18-20020a1c7312000000b003d23eda0dd1mr3746943wmb.17.1673976470471;
        Tue, 17 Jan 2023 09:27:50 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u21-20020a7bc055000000b003d9aa76dc6asm49440264wmc.0.2023.01.17.09.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 09:27:48 -0800 (PST)
Message-ID: <6b62b95d-c8e9-527b-934e-b458d2e70d5e@linaro.org>
Date:   Tue, 17 Jan 2023 18:27:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 2/2] dt-bindings: mailbox: add Marvell MHU
Content-Language: en-US
To:     Wojciech Zmuda <wzmuda@marvell.com>, linux-kernel@vger.kernel.org
Cc:     jassisinghbrar@gmail.com, robh+dt@kernel.org, sgoutham@marvell.com,
        devicetree@vger.kernel.org
References: <20230117171635.16739-1-wzmuda@marvell.com>
 <20230117171635.16739-3-wzmuda@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230117171635.16739-3-wzmuda@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 18:16, Wojciech Zmuda wrote:
> Marvell Message Handling Unit is a mailbox controller present in
> Marvell OcteonTx and OcteonTX2 SoC family.
> 
> Signed-off-by: Wojciech Zmuda <wzmuda@marvell.com>
> ---
>  .../bindings/mailbox/marvell,mhu.yaml         | 62 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/marvell,mhu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/marvell,mhu.yaml b/Documentation/devicetree/bindings/mailbox/marvell,mhu.yaml
> new file mode 100644
> index 000000000000..ace32a437af6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/marvell,mhu.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/marvell,mhu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell Message Handling Unit
> +
> +maintainers:
> +  - Sujeet Baranwal <sbaranwal@marvell.com>
> +  - Sunil Goutham <sgoutham@marvell.com>
> +  - Wojciech Bartczak <wbartczak@marvell.com>
> +
> +description:
> +  The Control-Processors Cluster (CPC) provides Arm-platform specification
> +  entities for managing the system. One of the CPC processors is the System
> +  Control Processor (SCP). The SCP is responsible, among others, for booting
> +  the chip, clock and power initialization, controlling power consumption
> +  through DVFS, monitoring temperature sensors and controlling AVS. The SCP,
> +  as each XCP, contains mailboxes for software-to-software communications.
> +  Mailbox writes cause an interrupt to the local XCP core or to the AP.
> +  This driver exposes AP-SCP Message Handling Unit to the system, providing
> +  the mailbox communication mechanism to the system, with the intention
> +  of plugging into the SCMI framework. It is designed to work with Marvell
> +  OcteonTX and OcteonTX2-based platforms.
> +  Mailbox has no other usage than SCMI communication. In case of
> +  configurations running without SCMI support it should be disabled.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.


Best regards,
Krzysztof

