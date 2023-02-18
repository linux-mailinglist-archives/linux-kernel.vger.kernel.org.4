Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B190D69B941
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 11:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjBRKLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 05:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjBRKLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 05:11:40 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28FD37577
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 02:11:38 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id t19so1098460edi.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 02:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dTrZlM/1j34PmNemq7d5HYpo1rmgNzw7BezUEBROqsY=;
        b=GV1pVXEHTU3KwzBKiZmlxiL54Wv26ipKjZ7O0pei0QV8W/TvzR5zSbbvM8TQzq6p+9
         uo+R/o+KLvFeygL4CC8eLWB2Y6wKqfzg6mdHaAYMsF3Y78+MBJiwae8qos+Iz+U5ReTw
         i0hqLEngqwYwvnrpgipCN/g3VsT0Ocbb6aaFqMwICxo7oOq+TgkWVWvRXaueMSSmWQtm
         XCgbjdkXPQkmPx0/bdblYUi3AyobQ6gfRoPFEy12lTJr4HKOg0iKyHI1tvBtVduSulYM
         Tf2FLhyxnmgjU9X5dIX8RXeMLtxudEt/Ou/JqO2vs0LECEt9+faLxnJKjmlPXc0R7WP9
         fdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTrZlM/1j34PmNemq7d5HYpo1rmgNzw7BezUEBROqsY=;
        b=jvpktIfuZJnBuoSxhnVWJsfiOjmF3OxhVuo7un23c1kD9EQZhb/w3nH5MgYQTYNZ3z
         pAEqWV6Dd6w2Fsp2EDamuRM0abWnOHCgYzs4Vs4M19sz0mwBmluqwNo2Ac0jDHecgBC5
         kF5nSDBYee1w0Avymn/PC3iqYaiM0iSXJchKkzuk9VILFljqQa7+0KFvjb0XhMDfzbE2
         Eu2Mx3iPYb7/a5XNDxAQN0KiwMREGOJP+kjT0Mx7f7WHEkHNXmaEjgd8XHx95ioQOJL7
         XHkCET1iigpkQ62tG4C/juA0jCpiSBbtq+LbjXInB7UY67Yzj7Jopy2JFExDjjO0mUL+
         wCxg==
X-Gm-Message-State: AO0yUKXP6CT14herUiaBMvUtWDHP4OypKEs3dF4NlNAY6XYJeGf+2GiY
        ny4jxEoOB+m5XuOOoZjhkEwQLHYp5UMclaww
X-Google-Smtp-Source: AK7set9DV1fZtUekvagyuUQrTVveo/fbiaq0+hMrloLoKRYw7+NmcQbHmPPzdZcK10xee5YHOtLL9A==
X-Received: by 2002:a17:906:5a42:b0:8b1:7ac6:3186 with SMTP id my2-20020a1709065a4200b008b17ac63186mr6106770ejc.68.1676715097203;
        Sat, 18 Feb 2023 02:11:37 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id sa14-20020a170906edae00b008b176df2899sm2638876ejb.160.2023.02.18.02.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Feb 2023 02:11:36 -0800 (PST)
Message-ID: <0771a2db-53b8-20c0-eb28-f254f2eb6b25@linaro.org>
Date:   Sat, 18 Feb 2023 11:11:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: renesas,rz-ssi: Update interrupts
 and interrupt-names properties
Content-Language: en-US
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230217185225.43310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230217185225.43310-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230217185225.43310-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2023 19:52, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> From R01UH0914EJ0120 Rev.1.20 HW manual, for full duplex channels
> (SSI0/1/3) dma_rt interrupt has now being marked as reserved and similarly
> for half duplex channel (SSI2) dma_rx and dma_tx interrupts have now being
> marked as reserved (this applies to RZ/G2L and alike SoC's). This patch
> updates the binding doc to match the same.

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

