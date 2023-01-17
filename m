Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DB766DC81
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbjAQLdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbjAQLcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:32:51 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774911D911
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:32:34 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso5165573wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GO2eKjxO1iedMdXK50/d7P4tpciSJOhld+mYv0gRRXc=;
        b=T4JaPbx5Qg4+WbL7GJMmSfpAFUnxdXuOeTRQgZhAauo/QmncDkQ1Doe9cV/ZIWX18z
         Nma4y8iNmrkm64rsnZmbtiA9AVPzK729a4uhrGfYFmr5TGOgGfaQNX66zrXvP46bdCHh
         cme4SVs/Dt1RGYCT9nJ2y0HWLZDyk0yrjztC+aDoCSy7N2pRLvdvu7Ml3Cc0DmrkjFcs
         8GkGGyU3+1kcBpCkVZKQYtBr2rOe7tFiNWiOl4gb2ZZ8bEsM2V4gIYKDvVrge3k0UB+i
         BEGHCNBix3AE0Pr1ockO2EoadlIDlJy7BfEz11Q6z/8Ni8XVZQwnLlPDNv+hP2IZb5hb
         SQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GO2eKjxO1iedMdXK50/d7P4tpciSJOhld+mYv0gRRXc=;
        b=XkcJf80nV+9FV5VuxmpXhCY2g6pmadp6DUG72CMW4YihS3RbNvAyUyJ2EvAb+9v/SU
         kPd7ghJaO3HWUCTYygPVAEopZitf4Ad4G/Xf+0lrPwn2bz8VFtY+40VK8rME4uW/Vtyx
         aL1/HZnUjAME3Id+URU4XoA6gbwg73P4VyqwBwzc30hVMfycOx+njP2TnPyelnC3RWIS
         OZvEG/cQtdv13yyoa7yiP7k844RrjyvYkfrDHu7dfNBzZAEyjDwR0AAtR8C6g/9OMP0J
         w6Ki6Vw8/U8DO6zI9r73WvRQ7Y8vVBN+tFdw1kqbxKY/snIu1upi85KMzM56tgPYe4Dm
         rzIg==
X-Gm-Message-State: AFqh2kqqYWUOZjCKSY/pS0WtRPJYQkaZ9s0jiXJcXKndvGk9lhrehDeo
        +UmUIQn0++G5tk08W/xIEqcs8w==
X-Google-Smtp-Source: AMrXdXsGd5j2tSvSR09VtVGdaTSDX2UTM7mcUyv1SW5KP7xJAX77Ip6jhrpihEqLCIfvpX8xfJMZvw==
X-Received: by 2002:a05:600c:538c:b0:3cf:6f4d:c259 with SMTP id hg12-20020a05600c538c00b003cf6f4dc259mr2655123wmb.39.1673955153043;
        Tue, 17 Jan 2023 03:32:33 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id he12-20020a05600c540c00b003d9ddc82450sm35745300wmb.45.2023.01.17.03.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 03:32:32 -0800 (PST)
Message-ID: <c3746492-b943-9bb8-9c5f-10c0bbd219c8@linaro.org>
Date:   Tue, 17 Jan 2023 12:32:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 08/10] dt-bindings: sound: Add support for QMC audio
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230113103759.327698-1-herve.codina@bootlin.com>
 <20230113103759.327698-9-herve.codina@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230113103759.327698-9-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2023 11:37, Herve Codina wrote:
> The QMC (QUICC mutichannel controller) is a controller
> present in some PowerQUICC SoC such as MPC885.
> The QMC audio is an ASoC component that uses the QMC
> controller to transfer the audio data.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

