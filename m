Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6326643653
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiLEVEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbiLEVEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:04:06 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF4629C95;
        Mon,  5 Dec 2022 13:03:07 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id f7so17572683edc.6;
        Mon, 05 Dec 2022 13:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCQoc7/NxGqKBDfT+WfjkpUJQ/xoL2wQ4YZBUAZFWuU=;
        b=RDP4U2hGWGIherQLPcDCfBZG/x0iCUDVVWDn88Xro1j88fh7rYsKfpjVwdcT9byep0
         5XkzMzPTCPJiuGgO0OcjXlSLG93YzivyaTCszaTH8HLk0qZgVVGNN/NC5qHYJw8Fn6MX
         ekhtndYjON+iSqUjdY0WGEUulNPDtPPTBB3IQH/b3v1aSktNRFi7z1GvrpEWBvvD7MIL
         vB/t2YtbtOnNfTBGfjYe0L5rTAxtt2ziGlfsjZhI0yrI4fCwIaaMGkhNDyLYqpj+WI6B
         LECl9UgywBF4yT+5S1iML4JC9wiB8egDIjP94FZx6y2xHzbyZabsY622GufsE1O+l5/V
         yjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCQoc7/NxGqKBDfT+WfjkpUJQ/xoL2wQ4YZBUAZFWuU=;
        b=mgNRrUpKeR0sreV/kM/5R5/6m7HBRyIHT9UEJ+IxlzVwfS0Iss5InMObEV7+fBcLxr
         Ltt47gVh0+Q1E0uFkCRF8ey03VqCJogUFKmiHSIskYTlPt9Ji1MN0jSue7TQLd2CmmT3
         t63ldP5EFmvH11eLvt87DpVQ7R0TgzNcuxZNPCVARpHgu5M6oBR0b+XpEsIm+t0vrvtw
         sd+3a8kK2jbVLF6TRumYG/vjllS43yCoPVKyaFhZSxGP0PNJtA3o+TreqYH5/7ktcKnE
         AKq8LRRA0nEdaTNaGOzTnEUb3OKngPeJ8+eEPs6t3e5SD+411V0dKXgN4Qh+hK8YrW1m
         OErg==
X-Gm-Message-State: ANoB5pm1OuGK4EqyFhTfFBqLX/kzaZgq6pYCEQTjCn6JPxX19IASiPlZ
        KLmw+u83jafCNVoXlwKiI68=
X-Google-Smtp-Source: AA0mqf5yVPJ21S6Vev4b+Aug4s525FY1CRRcm+sACWW63sZiP2EXM+F//2ZkwE35V6dGcnlQqsZ56Q==
X-Received: by 2002:aa7:d314:0:b0:46c:fc3f:cf8a with SMTP id p20-20020aa7d314000000b0046cfc3fcf8amr1810061edq.386.1670274185672;
        Mon, 05 Dec 2022 13:03:05 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id b9-20020a17090630c900b007add1c4dadbsm6499020ejb.153.2022.12.05.13.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 13:03:05 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Karl Palsson <karlp@tweak.net.au>,
        Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH 2/2] ARM: dts: sun8i: nanopi-duo2: Fix regulator GPIO reference
Date:   Mon, 05 Dec 2022 22:03:04 +0100
Message-ID: <111352924.nniJfEyVGO@kista>
In-Reply-To: <20221125195401.61642-2-samuel@sholland.org>
References: <20221125195401.61642-1-samuel@sholland.org> <20221125195401.61642-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 25. november 2022 ob 20:54:01 CET je Samuel Holland napisal(a):
> The property named in the schema is 'enable-gpios', not 'enable-gpio'.
> This makes no difference at runtime, because the regulator is marked as
> always-on, but it breaks validation.
> 
> Fixes: 4701fc6e5dd9 ("ARM: dts: sun8i: add FriendlyARM NanoPi Duo2")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


