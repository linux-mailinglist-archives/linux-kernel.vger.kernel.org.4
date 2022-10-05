Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55945F57FD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiJEQGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiJEQGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:06:19 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D963D7B7AE
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 09:06:16 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a12so9246120ljr.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 09:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ZERdQhbDaczv0NU+A7eG7s+5FSgBpXxPUoSQA8lbTHU=;
        b=FAq/yy0vyfShg8VUiTgEhCo5u+QOkCp1Kva7RTp3z31hiGpLzW9YdJPaTLQ6DhL/gm
         tUvb9YN5jGFenVCT/Kk2sCnpNUR8CSo23Yf5fBzYZdoqok4qOf+IGCjLmZH6JFjN+kEf
         ZkkvyWX4FYcIHSrVNVqAyv09PEsqbx8ifO9DmVuJBsPrESh7TBeQvHQNKHlyjxLQczyq
         BiEMz3/W/iwte9XZhdtCwXEuUMx9pCgs0n+3AWyF1juzWZ5qpelHhG/XPDxA5ioWZk35
         plinV9zxeg9LkiShuXurgCzCYcoR9oEcdfGcHLNu67aPV3ubttklLuEqUiL8umDJGpc9
         Z6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ZERdQhbDaczv0NU+A7eG7s+5FSgBpXxPUoSQA8lbTHU=;
        b=X0IKBa0baGJTtbuj7fk+z+Pfqqxz0Hqjk0pqFlLOeTPtkydaykCi2SaPGot3GQt+4R
         tNGSNykVxRO6PBSxEspWmkTbaFM5m09VVV1Z3hE028Jx1SH0/DD8blWj7EWfAxw3bNns
         V1RRodKyhE/4CNOfFydFeCNi4LWZuRQdWOrk3PHVbNECJ9XJ3Y0siwSuJuAKDonG7Uo8
         ktDkxEWQ5kTEATpHvYhD2g/V94CqSMhTjvlWnSS+0ojq+vN+yk9lq+0C04wFR1QU75qP
         S2/BWkpaW7bvPRgzl0TZF2gSLPnDxvpjcvqBKito8lNnxFF6GLrQIvkO9/ll1oD9aFSf
         bMQA==
X-Gm-Message-State: ACrzQf07Y9w/76N8DVGTi/jBsTirPaKt9j6npW9e3ah5ecUtBWumRAvP
        u+YSiBjJPnYCCxeFGjhOtOl5pQ==
X-Google-Smtp-Source: AMsMyM60n0F+taJnxZ8SXzF/fswONKQciihMIO8DZjGfogCLT4EOzDmvfLuPvGPb5MDf4kMPMEKwFw==
X-Received: by 2002:a05:651c:2107:b0:26c:504f:6de4 with SMTP id a7-20020a05651c210700b0026c504f6de4mr129707ljq.414.1664985975207;
        Wed, 05 Oct 2022 09:06:15 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i2-20020a2ea362000000b0026c2fec2f8esm1653243ljn.84.2022.10.05.09.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 09:06:14 -0700 (PDT)
Message-ID: <365e37ca-1c70-93ae-8507-35f08639088f@linaro.org>
Date:   Wed, 5 Oct 2022 18:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: add pin-switches to
 audio-graph-card2.yaml
Content-Language: en-US
To:     Claudio Cabral <CLCA@bang-olufsen.dk>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     =?UTF-8?Q?Alvin_=c5=a0ipraga?= <ALSI@bang-olufsen.dk>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221005142734.2724537-1-clca@bang-olufsen.dk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221005142734.2724537-1-clca@bang-olufsen.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2022 16:27, Claudio Cabral wrote:
> Document support for pin-switches in audio-graph-card2

Full stop?

> this devicetree property behaves the same way as its homonym in
> simple-card

Missing capital letter and full stop?

Instead please describe why do you need pin-switches in this binding...

> 
> Reviewed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>

Authorship or contributions (SoB) usually means someone reviewed it and
there is no need for both tags. The combination of both tags above is a
bit surprising.

> Signed-off-by: Claudio Cabral <clca@bang-olufsen.dk>
> ---
>  Documentation/devicetree/bindings/sound/audio-graph-card2.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Best regards,
Krzysztof

