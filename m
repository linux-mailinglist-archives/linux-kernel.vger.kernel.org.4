Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DD0661997
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbjAHUyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbjAHUyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:54:41 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FC710B5F;
        Sun,  8 Jan 2023 12:54:41 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id fy8so15470698ejc.13;
        Sun, 08 Jan 2023 12:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQj67zpDv0H9yJYRa8oUtp0MLfg/jFk0jkz9ie85Sp4=;
        b=Q/YQaKFGRMmoIjjrAVitQfWgLD6nUYHd3jPGMrsaIR83LO7EoYrqfRWgRZILFpOz0C
         oixFPlQ441ZdIwmfQ1pd1HXMceADZynnmSAhqrB2RjdLz0+6yb8hEv56VhAUYIXCIla4
         pKkxHsKVKwbqe85IdMVZkuj9ELVkhDRwfMeuTcqirpv3vguhXPQY7xXpeDKI6ieWXLZs
         CZAUv/K9vhkrzFrReSUFXdlNA3F1cU+PvJS7hTlnTq56M7gNz6OUNgUaGjfT6E14BuUq
         JUdMrADSJM8ZrsotJGSkrtG4/HdD5nBaqUzIp0PUdrbQOGIlJS3cG2sbo8tYnYiRa7+A
         QjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQj67zpDv0H9yJYRa8oUtp0MLfg/jFk0jkz9ie85Sp4=;
        b=nuolacIByjcgqzEjrHV1S1Si/3PgDpS9OseN0htc3E52NYI633MW+1S26Hy+R4pk1B
         OuQRO9kQhtvX88ZFEPru/8Q2nkHnDrkhI8M7/z5Toovg9M+CKq0pTUZTXE3PMcg+xi+m
         ELw1cdxKx2ycLlsYXvGh2upQ7u41aRuw+9dHqA4QvR7haI1TWLJwE1jgCI36IyBgN4Zx
         /cuqFFnECU4tHe6eWnnRh7VBdHkFRO+Asc1IFrdL+gyYSnaB2/GlTxmMyAFwb72fvb2n
         MM82CXXGCeBUPFlTAGIoqTOyG4fcewzp1cbfNzthYj+qsOrg2p9N1/rcZE3oUIm9gQcm
         bCaA==
X-Gm-Message-State: AFqh2kqupiRa4/0C+E/nQCyykqkSzxY9UEVJi1jWwsVasDYyEQ4AF+E/
        RdwKTIQkBBL9kqeeKe9WeM8=
X-Google-Smtp-Source: AMrXdXsIsv1gmrDL00g74IjFR9tyZ8Cu7d+50pp2FQqi8lWzNq2P1DpX/WxOEKfep0LHNfahlTGZng==
X-Received: by 2002:a17:906:68e:b0:7e2:ca68:6715 with SMTP id u14-20020a170906068e00b007e2ca686715mr53242941ejb.63.1673211279702;
        Sun, 08 Jan 2023 12:54:39 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709060cd200b0084c723a626csm2871248ejh.209.2023.01.08.12.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 12:54:39 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] clk: sunxi-ng: h3/h5: Model H3 CLK_DRAM as a fixed clock
Date:   Sun, 08 Jan 2023 21:54:38 +0100
Message-ID: <8241808.NyiUUSuA9g@jernej-laptop>
In-Reply-To: <20221229042230.24532-1-samuel@sholland.org>
References: <20221229042230.24532-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Dne =C4=8Detrtek, 29. december 2022 ob 05:22:30 CET je Samuel Holland napis=
al(a):
> The DRAM controller clock is only allowed to change frequency while the
> DRAM chips are in self-refresh. To support this, changes to the CLK_DRAM
> mux and divider have no effect until acknowledged by the memory dynamic
> frequency scaling (MDFS) hardware inside the DRAM controller. (There is
> a SDRCLK_UPD bit in DRAM_CFG_REG which should serve a similar purpose,
> but this bit actually does nothing.)
>=20
> However, the MDFS hardware in H3 appears to be broken. Triggering a
> frequency change using the procedure from similar SoCs (A64/H5) hangs
> the hardware. Additionally, the vendor BSP specifically avoids using the
> MDFS hardware on H3, instead performing all DRAM PHY parameter updates
> and resets in software.
>=20
> Thus, it is effectively impossible to change the CLK_DRAM mux/divider,
> so those features should not be modeled. Add CLK_SET_RATE_PARENT so
> frequency changes apply to PLL_DDR instead.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied, thanks!

Best regards,
Jernej


