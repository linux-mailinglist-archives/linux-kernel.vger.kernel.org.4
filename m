Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E514B63EB4D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiLAIlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLAIlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:41:17 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5008567A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:41:16 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u12so547616wrr.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 00:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tj390YNXHrclTFputKDdp/2EzmVq492YRg9LH1oG+Bg=;
        b=tqha8Io9+MdBJBv4dq8nsAAXsY3Bwbvisj8hUvDQu1+XuwzC4CazCyU4fzCvN1Lakf
         3JtwxkNxWXGDHo68+k/4QL7V1PnqKlTGdtb1abt2NJshf+pWw1/6udK1sa4giyLzaCoR
         XKTcH/fhWjZgU/P/XyErRu6LrgDGv/jt8D2LoVdimrV2B18XG/5YkhlUrH/g/orp2DVU
         PSl6CRiSJkEpOfsVa+BbcKnXbyJOS9L1gIZIWmi3EEnt/FHwL6ppEBS0OtiqQ8/2tpaS
         BMVu2sd25L+K+SRm1sprA1ZWHsIVeBE2e8LH+IPb1dblrvUak0BMyGfUIYqg60wloqcu
         s54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tj390YNXHrclTFputKDdp/2EzmVq492YRg9LH1oG+Bg=;
        b=0MkB1xpq99zimxiohDsRr2RzmRjQ8Fm6g47zwDw+7ja7SLd1bbC4hkiaqfn+SMWh1R
         412FU90T/LgUL21ksHA2hylJhb04sf57jX6NVEmmzTqLiE0pRx7+LZ7SgD/kXdKrNNgK
         YAmD0W6TK0Y5aMrONqW5AHTBs/RrAw9gwSIQFE3H12TvHjm/CsOkjmf8QYEOxPB+ezpB
         q9fYp0IYVRvA5ra+C2Vx2N1GoAwSdEdeq5ZmmTbB0HWLOTZtnPYGCb60+aWrGl8P1Y9D
         U0CmLyMkMJYPUFwWAU6ioTZq/B7zdcD8cHpBrTC5WfXnLcd/J9A7h3OEAXgrEJUvaQIN
         fDKg==
X-Gm-Message-State: ANoB5pm+bmzwrKaq48q7L8/8zC2t+Gxqd5e/ou/Ue87h7zF6Zfx1LdrJ
        2zBupog0iAiBTUmKsFWRoPgBtg==
X-Google-Smtp-Source: AA0mqf4sOShSp/Ekl0Zx52j17akSaysCwnTBmBOchLMlhHGPZEbmMtxBFFAQQrs1Tgn94ff6d4zl+Q==
X-Received: by 2002:a5d:4890:0:b0:22a:f91f:674a with SMTP id g16-20020a5d4890000000b0022af91f674amr28955065wrq.214.1669884075457;
        Thu, 01 Dec 2022 00:41:15 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id n5-20020adff085000000b00236c1f2cecesm4592623wro.81.2022.12.01.00.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 00:41:15 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Robert Foss <robert.foss@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1669799805.git.mazziesaccount@gmail.com>
References: <cover.1669799805.git.mazziesaccount@gmail.com>
Subject: Re: [PATCH RESEND2 v4 0/2] Use devm helpers for regulator get and enable
Message-Id: <166988407457.1972715.14336374251085655546.b4-ty@linaro.org>
Date:   Thu, 01 Dec 2022 09:41:14 +0100
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

On Wed, 30 Nov 2022 11:21:51 +0200, Matti Vaittinen wrote:
> Simplify couple of drivers by using the new devm_regulator_*get_enable*()
> 
> These patches were previously part of the series:
> https://lore.kernel.org/lkml/cover.1660934107.git.mazziesaccount@gmail.com/
> "Devm helpers for regulator get and enable". I did keep the patch series
> versioning even though I changed the series name (subject of this mail)
> to "Use devm helpers for regulator get and enable". Name was changed
> because the devm helpers are already in 6.1-rc1.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/2] drm/bridge: sii902x: Use devm_regulator_bulk_get_enable()
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=ff1eae1201a46f997126297d2d3440baa2d1b9a9
[2/2] drm/meson: dw-hdmi: Use devm_regulator_*get_enable*()
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=429e8706366166494314a46c82a9a9929aedbb8c

-- 
Neil
