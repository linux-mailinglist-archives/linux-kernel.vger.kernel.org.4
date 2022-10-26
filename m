Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C34160E3B5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbiJZOsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiJZOsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:48:25 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AD111D9BD;
        Wed, 26 Oct 2022 07:48:23 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so1758491wmb.3;
        Wed, 26 Oct 2022 07:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=+0mLvxSPXOxhgnQzcFMi44GsxzESgWZ7ht0/PY/f89Q=;
        b=EizPam+fpHG85pFQytUCkvubWoOhztt1iDv7VIlV0p3BBuAKUvT9hosMERDmg/DVSX
         rGgPIUdwttDbqz65VTg+selFcbgULI2Ugxc4PXlZRe19qetJZFv0GbuGVRjxj6YB8Wkt
         olkVowxyzveNPp5DDAnfgIZXT1+1GTWoNsW6J6pLq8787yhJ4/tGI/syWZ3M95EUWw/I
         t3LwED8PUSp9hmsR30iIzkeLkgwgBWWJXqKq1TmYj/U2sui2cmX614eukMR8mLViyKe8
         mefhw2zImZlMn06SPxWgCKWJUWFbvaJQbJHChdLqJF+KWeQKyqFTg/bDxRZdukQVfduJ
         TsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0mLvxSPXOxhgnQzcFMi44GsxzESgWZ7ht0/PY/f89Q=;
        b=5xVWHEmSfxDZhJjfUP5FftjDBuP1ibeb2i/55WJ03K1an6yoeIcJS5NeZWF/W1lrep
         HsqY1LpkpGLfj53eqqDyiXKw7Pa27Gac8TzmDF/qR4WBYUzjijYQNXpv4hHb/eCjC4ze
         rBVXHF+6D6e2CMKXmbPfl7MXcmRot6lZjiSWAsVpuCGOwZYFOuQjil/3AOJ+9/12aTlK
         lHjI+6g1TVFXXmxzs8fJdYwaZABOmjaT43gRh1iKiBD7+u0TJT5+c0a0qltCsZ0W1rwg
         G8v44/hAXuYX8vVVaEEusmhwCUVptGMoUvekndbcTId8jqJ6h3ey7yejGE7ER0EyrDIq
         jY9g==
X-Gm-Message-State: ACrzQf3TbX7H8CzuUxx5bETKVIONa2PioPCMHihKYFAlRTuDOiWDAcuI
        Z1H6Ultrx2B0SHP7DcWaOWzbcL8TDoXOug==
X-Google-Smtp-Source: AMsMyM7/vD0TkY3/qBDwvfDXp6IepRYUm5MsPEZ2Jot0Pj+rXJATGYpR57v7l1I9iMk6NOBsUPoGMg==
X-Received: by 2002:a05:600c:35cf:b0:3c6:e957:b403 with SMTP id r15-20020a05600c35cf00b003c6e957b403mr2893717wmq.162.1666795702227;
        Wed, 26 Oct 2022 07:48:22 -0700 (PDT)
Received: from localhost (94.197.44.200.threembb.co.uk. [94.197.44.200])
        by smtp.gmail.com with ESMTPSA id l3-20020adfa383000000b002366eb01e07sm5455698wrb.114.2022.10.26.07.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:48:21 -0700 (PDT)
References: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
 <20221022162742.21671-2-aidanmacdonald.0x0@gmail.com>
 <ef6a326b-5c61-988b-2ec2-cd8e233e5d28@linaro.org>
 <GMvEU8xVTkjIoQ518XWAaLkhldSZHlk7@localhost>
 <4ef59d94-d045-55fc-d531-c84e7edb8333@linaro.org>
 <hXRpArckbrXUelDdaJ3Y2SErmKiuycXt@localhost>
 <66c1a100-922e-4a33-e80c-fc80866acf03@linaro.org>
 <jZCUALhj8PoqVkuWdtLf8LnPAj1wDakF@localhost>
 <38205667-d36f-e7a9-21b0-2e8597a662ff@linaro.org>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dt-bindings: ASoC: simple-card: Add
 system-clock-id property
In-reply-to: <38205667-d36f-e7a9-21b0-2e8597a662ff@linaro.org>
Date:   Wed, 26 Oct 2022 15:48:21 +0100
Message-ID: <qNdQQJRLFWJ6gNfwM73oJ8EH56Y5nWgd@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> And the remaining piece I don't get is that these are not bindings for
> codec, but for sound audio card. You want to set "system-clock-id"
> property for audio card, while putting clock from codec, which will be
> used to pass back to the codec... so it is a property of the codec, not
> of the audio card. IOW, NAU8821_CLK_* does not configure here the clock
> of the system, but only, only clock of the codec.

The system clock is controlled at the DAI level, it's specific to one
DAI on one component. The simple-card device node has sub-nodes for the
DAI links, and each DAI link node has sub-nodes for the DAIs within the
link. "system-clock-id" is a property on the DAI nodes, so it's not a
card-level property, just one part of the overall card definition.

Since the clock ID is something defined by the codec it would naturally
be a value defined by the codec, but the *configuration* of the codec is
part of the sound card because it depends on how everything is connected
together. If you used the same codec in a different machine it would
have a different configuration.

Regards,
Aidan
