Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD80560BFB3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiJYAgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiJYAfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:35:51 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D121EE1A;
        Mon, 24 Oct 2022 16:02:15 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l14so11044335wrw.2;
        Mon, 24 Oct 2022 16:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=KaoGSotGAFceXqyyQYu9XCTEP8cta6cn87AncWEkKJY=;
        b=IV2RWjSsTpxEczaXY2qgq5ATQ4pPYPFWTulRqg14h2wu3f4harvqBv1HOrabkiZ+0C
         6uqhrFrj6umwZTfzAtlLbL+oI2y7aydQdeBU1Tec9XtdwZshkL8s7FHKYJv6mpJgI/OC
         hOAg1uByJ1ku79XAe1A9ku/XwkitmNY39TeANEY6lcMm0oFzOuHaZvAu98RNcogZFv8m
         X3Gc/5TB3MOtiAiJjJZFd3S2iDCrSMF2+r3nINt1MjurFsaZSG2xsCZ+s+3M4tXEbOch
         7NgXLOLGU35Yo4tZfQN2b6wfGYlEBbrSOpYo5F0/gwiRNvb6OQvLoFm5ZU6LYXAWZq68
         vHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KaoGSotGAFceXqyyQYu9XCTEP8cta6cn87AncWEkKJY=;
        b=7ONuPf/eprJafoLG0su1MnXL4wAbfwRrREM/vEdM1X4pHJYJ2MPX6Z37irKLJaYtYo
         7UAFMTBIsh0cAHU1Vms/nqq11fvckmrOsFFbH0riGKZiOo8PTH9RhGqCRTytIFn9xjFY
         OgMDPGN5CuM6/fniw3QWCqkxMZFOAqEBgB/GhFjwXnriPWDz4YB+rVXt80aRdCsPdH8R
         Lvq08LOFYYF17Ek/anUvSZwtrdFv+Wbz7VsxjrJkXbAtBvoXCtuZ5cDpMBrbFayF/M6b
         zoo3eAFNkdK3fW++wAFI080yFluUBVL+SaFcn6B+duWqjNn47L4sRvZIXeA5vueRPAxR
         OAQw==
X-Gm-Message-State: ACrzQf2YLJYmeMPjDgjfcfAsA20cqW3Hecnuz6sM1NrdDxx3+EOK04AM
        fteZklXsAXltv4j4sJQ8A6o=
X-Google-Smtp-Source: AMsMyM7GyNXIsaHwAiWktSz5FIbnYUO2r4ym96pAz6HpvYe5hMahqSmSxp5DkSTuWtfbQhqNnjxFjg==
X-Received: by 2002:a5d:64e9:0:b0:22e:7631:bcab with SMTP id g9-20020a5d64e9000000b0022e7631bcabmr24146249wri.36.1666652534115;
        Mon, 24 Oct 2022 16:02:14 -0700 (PDT)
Received: from localhost (94.197.2.59.threembb.co.uk. [94.197.2.59])
        by smtp.gmail.com with ESMTPSA id t7-20020adfe107000000b0022da3977ec5sm742225wrz.113.2022.10.24.16.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 16:02:13 -0700 (PDT)
References: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
 <87fsfem6zd.wl-kuninori.morimoto.gx@renesas.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] ASoC: simple-card: Support custom DAI system
 clock IDs
Date:   Mon, 24 Oct 2022 10:18:15 +0100
In-reply-to: <87fsfem6zd.wl-kuninori.morimoto.gx@renesas.com>
Message-ID: <MXQXY4d7ZMjCu1ChI1EL7daeg1zENP5H@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> writes:

> Hi Aidan
>
> Thank you for your patch
>
>> Some DAIs have multiple system clock sources, which can be chosen
>> using the "clk_id" argument to snd_soc_dai_set_sysclk(). Currently
>> this is hardcoded to 0 when using simple cards, but that choice is
>> not always suitable.
>>
>> Add the "system-clock-id" property to allow selecting a different
>> clock ID on a per-DAI basis.
>>
>> To simplify the logic on DPCM cards, add a dummy "asoc_simple_dai"
>> instance and use that for the dummy components on DPCM links. This
>> ensures that when we're iterating over DAIs in the PCM runtime there
>> is always a matching "asoc_simple_dai" we can dereference.
>>
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> ---
>
> I think adding "system-clock-id" and adding "dummy asoc_simple_dai" are
> different topics. This patch should be separated into 2 patches.

Sounds good to me.

> And I couldn't understand the reason why we need to add dummy asoc_simple_dai.
> In my understanding, we don't parse DT for dummy connection.
> Which process are you talking about specifically here?
>
> 	This ensures that when we're iterating over DAIs in the PCM runtime there
> 	is always a matching "asoc_simple_dai" we can dereference.
> -
> Thank you for your help !!
>
> Best regards
> ---
> Kuninori Morimoto

DPCM DAI links have some real DAIs and one dummy DAI. Each real DAI has
an asoc_simple_dai associated with it to contain the information parsed
from the DT. The dummy DAI does not have an asoc_simple_dai. I'm adding
a dummy asoc_simple_dai for these dummy DAIs to make the mapping of
snd_soc_dai to asoc_simple_dai 1-to-1.

The non 1-to-1 mapping is problematic, because if I have a snd_soc_dai
and want to look up a simple-card property I would need to check if the
matching asoc_simple_dai exists first, and have a special case for DPCM
dummy DAIs. With a 1-to-1 mapping I can handle all DAIs the same way.

Regards,
Aidan
