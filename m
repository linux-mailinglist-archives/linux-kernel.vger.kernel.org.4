Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C3E65C373
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbjACP67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238216AbjACP6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:58:19 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEC712751
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 07:58:18 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id y25so46204557lfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 07:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72mA5ojFgMLVEqAkQaCbUqv8L54FnJT6kWDdtZXnH8k=;
        b=ZR6CuU0SVs+2fa7ImRzShQIqdD+s1t0zPg6gcMOo9oHiESgjcB/fqQwwvjLmsiAFSA
         68WEpQLvxRlO+gvNY4TGr1Rs5BUkah8JeZg2NLNTYz9vWVEUA3rJvu0kbgJ2ffRNgi6+
         rqd4bp/32Ruz3UYGXfhr70gI7+QRLHKnlATtgvZs0x+TxiXBzysWZNrbdHYsTydJA3aI
         lJWPx3igM7XnBHuZlt//8E9xsZWZAbRcjYyLqCBTbdl5oo40SBxRV4i4JZIffKKvxBxX
         4m1cQxPZ99KEjBINdOjdqXU5d5X/r2nq9qJvoiJCtsYSJNEtcShPVU5LjM0ggcW/DHZ4
         AyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72mA5ojFgMLVEqAkQaCbUqv8L54FnJT6kWDdtZXnH8k=;
        b=jictosWnt8Rm3g9wOSvYtHB+8GwvtQIikx03+/IdaM6cLIixnmzCiiFBjiu+2NgNLV
         w3ivHeQEHNhNsSJ1yD+snrsnHCpda9kUkfHWuMAJ1yQv9Tutgbfl25u8McujxxXYIgYb
         P1SBCz8cMzMrozxKzo+qkHnQz+uzBetB/gUhJv9bkdVjTkj2B1hjuxz6gWbYcbvV8lUm
         Po8HCZQ4x7nzReUsTnVTQgv2IHpqhxz75WTvrh7+d8VsRigTy44Aw6bW8P47H+otXVj6
         lEghoPclMA2zPJZ0mc61MbUcOdZIZ/iOrxuM2N7RfSzQUNiojBc6C3mBVs3wtyNhlM/b
         m7Wg==
X-Gm-Message-State: AFqh2kpGGvrBVWFThVgLJkE2yhFokoALm1XnQlNpaFVpgFA+5IIZKyeV
        WYdlak8rTQj1CTdTSpzSanTk8quFrqLrITfC
X-Google-Smtp-Source: AMrXdXsJRJFmNGcdrpCX4Ew7dswqjffLVmIQHsolgx3asO447k2As8kQ4rSPO3cW12SocgcHpv/l2A==
X-Received: by 2002:a05:6512:1597:b0:4b6:f4bb:e53f with SMTP id bp23-20020a056512159700b004b6f4bbe53fmr13398291lfb.60.1672761496628;
        Tue, 03 Jan 2023 07:58:16 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s4-20020a056512202400b004b5979f9ba8sm4853215lfs.210.2023.01.03.07.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 07:58:16 -0800 (PST)
Message-ID: <6e347f3f-1dd0-3c84-8156-d6d891b25b00@linaro.org>
Date:   Tue, 3 Jan 2023 16:58:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/2] Add support for Marvell MHU on CN9x and CN10x SoC
Content-Language: en-US
To:     Wojciech Zmuda <wzmuda@marvell.com>, linux-kernel@vger.kernel.org
Cc:     jassisinghbrar@gmail.com, robh+dt@kernel.org, sgoutham@marvell.com,
        devicetree@vger.kernel.org
References: <20230103155612.6217-1-wzmuda@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103155612.6217-1-wzmuda@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 16:56, Wojciech Zmuda wrote:
> In order to support ARM SCMI for the Marvell CN9x, CN10x SoC, add a
> generic platform MHU driver based loosely on arm_mhu.c and pcc.c.
> 
> v1->v2:
> - Clean up
> - Rebase on 6.1
> - Remove PCI interrupts

Where is the v1?

https://lore.kernel.org/all/?q=%22mailbox%3A+mvl-mhu%3A+add+OcteonTX2+MHU+mailbox+driver%22

Best regards,
Krzysztof

