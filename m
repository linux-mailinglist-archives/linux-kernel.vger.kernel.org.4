Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B58E65AF92
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjABKaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjABKaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:30:09 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D913101D
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 02:30:08 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d4so17938042wrw.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 02:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3pnp00fAFbCsjrwHeYydTcNOrlFzBbyWXdERp2QJas=;
        b=nDp7cO36WKjes1Izcci1OZT/KlGLELLQ9Al9dmcUPZK1X1kRSyE+4XNsVd+fPNdoo6
         Q2753XPoSR3z6VUXYvNp1a0u5NLVEQayrD4YTdAtQVE3iT9+VXEqV4/OUY5s515JHQlp
         IpFIZLQ4VSKcorsvXHH+dTvXyOHYHSRpzXwkuvZPpL071MfrczEg+55sFkN8o59Ico3J
         PAfoWUI60jYkusOv0KBtsrok/CgbzkUQ9zTXcYXjrfEilpy8+aqkc4fMfrBE237c9DVb
         g5rieZWGpAk3GUNI7momneQNCf54Vq67nrXds/J4B1QFHqd1b3wI2mSYUKEHAdfJGXlZ
         8JwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3pnp00fAFbCsjrwHeYydTcNOrlFzBbyWXdERp2QJas=;
        b=MfUE9CtHZA/bQolFZeXhkCbdsuHPxRgnqSiqkEB8xxhOPumyHbA5QQLJFRI9F1c1LT
         Yyoafn1zOKqgl6lPE4ZUMMjuGk3xlR9ieQ2xz5IrJeGhhcxRzsR867fupIRf+WqItWEX
         8ZKuPPyb9jhWc+PH6PfpjxSnCvwenRa7chFPdZA5MXACPstLl73W+QpTxS8sqdSYLRpI
         D6w64ORI1mptZQ9RpV/+5i34/sQvuDxFxRcsdtOuPMKdRLyiy0bKFpK1UcUN5uJ1tzDi
         ttxvSnEQDrIVkKwM7VHRf845EEsjOlYLXMEGpHN62s+0oyfNTxqxPZt/3Ude+4Bn4NAI
         kDzQ==
X-Gm-Message-State: AFqh2kpuJFaPQELPYe8e3UxdMqQUbzW8I9eNSRd+1nJjxAwAMQuXq86R
        Op2L55s100c/OQ10gaRe4zupVg==
X-Google-Smtp-Source: AMrXdXu3JhHyb5jnLxTpAVovV90esQPMUhxrIbYN2ov3dmss4CzYWAETVnJ3KJrM+Cv2iPnI6yfXUA==
X-Received: by 2002:a5d:624d:0:b0:242:4d70:7882 with SMTP id m13-20020a5d624d000000b002424d707882mr24814292wrv.15.1672655407012;
        Mon, 02 Jan 2023 02:30:07 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d594a000000b0028663fc8f4csm15263318wri.30.2023.01.02.02.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 02:30:06 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     "moderated list:DRM DRIVERS FOR VIVANTE GPU IP" 
        <etnaviv@lists.freedesktop.org>, David Airlie <airlied@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>, italonicola@collabora.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVERS FOR VIVANTE GPU IP" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Amlogic Meson SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Jerome Brunet <jbrunet@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20221202115223.39051-1-tomeu.vizoso@collabora.com>
References: <20221202115223.39051-1-tomeu.vizoso@collabora.com>
Subject: Re: (subset) [PATCH v6 0/8] Support for the NPU in Vim3
Message-Id: <167265540588.368935.8530142567394825177.b4-ty@linaro.org>
Date:   Mon, 02 Jan 2023 11:30:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2 Dec 2022 12:52:12 +0100, Tomeu Vizoso wrote:
> This series adds support for the Verisilicon VIPNano-QI NPU in the A311D
> as in the VIM3 board.
> 
> The IP is very closely based on previous Vivante GPUs, so the etnaviv
> kernel driver works basically unchanged.
> 
> The userspace part of the driver is being reviewed at:
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.3/bindings)

[1/8] dt-bindings: reset: meson-g12a: Add missing NNA reset
      https://git.kernel.org/amlogic/c/a439267609f9d57b15991c55550956d7cc5404d8
[2/8] dt-bindings: power: Add G12A NNA power domain
      https://git.kernel.org/amlogic/c/340ea839b4306335bd627fe0dd6789df803aef58

These changes has been applied on the intermediate git tree [1].

The v6.3/bindings branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil
