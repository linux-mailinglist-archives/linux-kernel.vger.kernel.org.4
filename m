Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F1C693388
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 21:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjBKUIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 15:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjBKUIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 15:08:51 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF87E93F8;
        Sat, 11 Feb 2023 12:08:50 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id fi26so8282608edb.7;
        Sat, 11 Feb 2023 12:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vl7Fip7qfenkA+vATjGMmHQ+RoCFOUMthhj1X9/haL4=;
        b=Xq9fSKYaofUSG3Rs3LVizGAxYaVyD6xzFiW58Jxqw8LSsVNoC1xf8LiFLANVbMTFq6
         FU6NbBkztx717hafbCwGLnYQxvMMosEvGNLJVL5C2Y9x4r02uBbP7Qt7xs/IpYr+IkSz
         MKH67ux9+SmiiLCbybhFR86nqJGJNCmcatcS+GK/pXaFifzPvslO4FsZrCAd32xXDsvb
         hCqKe90RLn/yfini10WzS6Pq5WewTk+Y7hJzFsmzTx7OdiLspms2m9gQaYYI/anIpcjg
         9cnl+Ffb6t/RWasGlaXNHP0pOtO91yMvTEc3nuHrY3kOaUvuILn1LH1CnhJ80ygYrUkR
         1Yeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vl7Fip7qfenkA+vATjGMmHQ+RoCFOUMthhj1X9/haL4=;
        b=pA9bK9B35YzoVC9o6tX/uhook3+tDEgyhwvyY04/bBatiUQh9iOhUP2jfOv4lPx/lQ
         mfDC18zQDtamM1qGCasNFsyKyOjlYI8Vn7B1mK/73nb3CrGZ1ijdl64gEQ+A2sXxIuK2
         KmCvDB1THap5t7cf8R0h1pjYUYffTW30RdesmecGrOvK/xp2CUvHhJ55Sh2cGF8t2c9Q
         1Di7po/2Vk0CjnRacJwsRgOPixKH7r/GaLd0JnE91br2c6ICiivKvYQSQhg6R8Naz3bE
         Lkq2rl6wtZOu/JIEsRUPFqhDyYXisSpYukFl8ZreEz0EqQHTons+qVttdA81mxnyi9uL
         0AAg==
X-Gm-Message-State: AO0yUKVSD7wSWVq68rRhccCNqZ1YMhMCE7ANKSLRoYSEt43kqDTTKMvm
        NPYLlmFzGg4DDnU2gu53EWo7qHg66vz2xZzImR8=
X-Google-Smtp-Source: AK7set9pdHfv5lT0LgHnjGKDGQxMVRx6KxGQ2hvJg2a0pjXrwtlZdQMXfqCUFkQAFD1/Jn4xPLTQ7cGC/Dlo+1dEt1w=
X-Received: by 2002:a50:9ecb:0:b0:49d:ec5d:28b4 with SMTP id
 a69-20020a509ecb000000b0049dec5d28b4mr4811038edf.6.1676146129273; Sat, 11 Feb
 2023 12:08:49 -0800 (PST)
MIME-Version: 1.0
References: <20230210170721.1285914-1-christianshewitt@gmail.com> <20230210170721.1285914-4-christianshewitt@gmail.com>
In-Reply-To: <20230210170721.1285914-4-christianshewitt@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 Feb 2023 21:08:38 +0100
Message-ID: <CAFBinCB-AgJ6aOYns1SBL4P-VkCCnmrmRoPbQz2qUppghHzs3A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: meson: gxbb-kii-pro: add initial audio support
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ferass El Hafidi <vitali64pmemail@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 6:07 PM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> Add initial support for HDMI and S/PDIF audio output.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> Tested-by: Ferass El Hafidi <vitali64pmemail@protonmail.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
