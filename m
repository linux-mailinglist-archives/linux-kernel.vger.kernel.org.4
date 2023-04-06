Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30876D9EB5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbjDFRZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239917AbjDFRZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:25:38 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4FD9768
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:25:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id lj25so3127205ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680801869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JL0tcMswVOFBcZqE4ysEfWlvhjaRhWrngkh1Ruhoyo4=;
        b=MPnQBH6smOnFly3D5rRvEyKmiqswxLyP6gr0q283GTwxvlhz603IrS9F2/iq2f0NPn
         aKYKWU77mZQcOPlybykSjECnvL0fRAidu65ZbPR2GXBg7hl2FeNx2aVSGFzDbenDXfJL
         9S1vKwxSiNBGNJUgkUa1eCNZp4+SHY58amq+JWamL8UjzApvijwt+ikbQANg1+17nYd2
         9RgUl7CAU99JcmphuUYcGBhloboB/Qtwi2ytfZ2EktnW5Gv7RiVYxry8vbP7fcT8nDC9
         GFTNdOObFQR6uvbrzzR1kqhot3m4RblcY5k2iQTjGiUzTG5kExnUP1/c5SvV8sD5c+MW
         o3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680801869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JL0tcMswVOFBcZqE4ysEfWlvhjaRhWrngkh1Ruhoyo4=;
        b=jss8izzr6Lwz66QfSAfGlSHrg8zEVKmA4bHuVp6paa2wgoHt9l/362IOnywNXE3q2X
         O8ArCpKXngmBy5iyyt3847mOa+Nnt2za7r3BGyoP9g/Uzz1gTVaWxRJ68TVfZj0b8Sbp
         8q0L59JwEHmMWPZTTvzJk0i0g5kn1Y8LABv+2W6ud61mDJPaS5aBhQneo9iNEtC57Ea4
         8f7wDzMgrJTIXS59hHoH9gO6IXUA+9QYaOhsXoJMoovZzn/MqxAYnL5Yiz2MkTRmIT+I
         ktC8puuqVilXs6n+rnBGgAT7lqsU5qt2Mk5yMvey8vFp71izvov8Kfcpo3EfXBkCPaP5
         AcPQ==
X-Gm-Message-State: AAQBX9f3ch3EIGE6C44sAjh+EVTgcz6uSYJ9r8ua1I+7FyCCWHZ8/ijQ
        irfDlwSVGZokimaiOoryqyl28A==
X-Google-Smtp-Source: AKy350ZDUjvvTADIBKKgF4owoWF4Z6S7eh506PO079mECLi4kym9F7fYqfKxh7TctbTIQkCLAiJ3Cg==
X-Received: by 2002:a17:907:c201:b0:8b1:75a0:e5c6 with SMTP id ti1-20020a170907c20100b008b175a0e5c6mr6737603ejc.18.1680801868922;
        Thu, 06 Apr 2023 10:24:28 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id li16-20020a170906f99000b008d68d018153sm1059812ejb.23.2023.04.06.10.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 10:24:28 -0700 (PDT)
Message-ID: <63f14414-2054-d7d6-8cdd-82f8e034641f@linaro.org>
Date:   Thu, 6 Apr 2023 19:24:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/5] dt-bindings: clock: Add binding constants for
 BLZP1600
Content-Language: en-US
To:     Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "soc@kernel.org" <soc@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>
References: <20230406102149.729726-1-nikolaos.pasaloukos@blaize.com>
 <20230406102149.729726-5-nikolaos.pasaloukos@blaize.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406102149.729726-5-nikolaos.pasaloukos@blaize.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 12:22, Niko Pasaloukos wrote:
> Add SCMI clock IDs which are used on Blaize BLZP1600 SoC.
> 
> Co-developed-by: James Cowgill <james.cowgill@blaize.com>
> Signed-off-by: James Cowgill <james.cowgill@blaize.com>
> Co-developed-by: Matt Redfearn <matt.redfearn@blaize.com>
> Signed-off-by: Matt Redfearn <matt.redfearn@blaize.com>
> Co-developed-by: Neil Jones <neil.jones@blaize.com>
> Signed-off-by: Neil Jones <neil.jones@blaize.com>
> Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
> ---
>  .../dt-bindings/clock/blaize,blzp1600-clk.h   | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)

Missing device schema.

>  create mode 100644 include/dt-bindings/clock/blaize,blzp1600-clk.h
> 
> diff --git a/include/dt-bindings/clock/blaize,blzp1600-clk.h b/include/dt-bindings/clock/blaize,blzp1600-clk.h
> new file mode 100644
> index 000000000000..bcc8ff513b28
> --- /dev/null
> +++ b/include/dt-bindings/clock/blaize,blzp1600-clk.h
> @@ -0,0 +1,67 @@
> +/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */

Same question as for reset.

> +/*
> + * Copyright (C) 2022, Blaize, Inc.
> + */
> +
> +#ifndef DT_BINDING_CLK_BLZP1600_H
> +#define DT_BINDING_CLK_BLZP1600_H
> +
> +/* Simple clock-gates */
> +#define BLZP1600_CPU_CLK	0
> +#define BLZP1600_CRYPTO_CLK	7

Same problems as for reset.


Best regards,
Krzysztof

