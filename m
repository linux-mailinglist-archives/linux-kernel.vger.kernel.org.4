Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35F868A9C9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 13:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjBDMp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 07:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjBDMpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 07:45:22 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD121F5EF;
        Sat,  4 Feb 2023 04:45:19 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h12so6748883wrv.10;
        Sat, 04 Feb 2023 04:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5o4VrqO+lpoBcJhRS/ry6wtaBgkv6sRhf4TTq3fFYGU=;
        b=if6dR3Riu9dfFRElqlkoiExFSN0oFvJdPijCKvWRhIw7/N1luihtf9E54Gb10bPGCF
         qdrtERUJk83SYzAD+ZXbs7vpNHfsO4xqEOq6d2ggamTLYvQ9A5RTMPAlhkFYQlUW32mQ
         KUijL9VtQFAl6V2lKdBob1gcLSkoXLD8zFJjyGwpBJUxhMmVHzFNSEXFN/ieC3zk83JZ
         eNcaRBvgSMj998qCGaAbdDCnjjz2dTlm2gEh/ihiX6McHR8gN9L5fAWx/TKX2f0Q3pmJ
         kkJGLLNAJCT+FSSQaPcYhykgGlC9lag7wvXZMmPxCEQZnrMBIVOjwMLzXh+acZ4FicVF
         ChJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5o4VrqO+lpoBcJhRS/ry6wtaBgkv6sRhf4TTq3fFYGU=;
        b=zsV66TKBFZkm5NN4ZL5gtcx0envFm6eLWHf5fFCcxGGy5YdzX2DWLUMf0ylIz7EbBP
         LHoURYuyCvylhfVl6rjYeGtOTb+SG5vQSMruOQT8AiU0gg5PmukBm78q/hJ4F/RFtqMn
         zIhNlbPmKcWcaIPjHYWRaSNVXI2vZKg18PBR99t7luw6h1ZdUpzC64riUjxGNWJZ0UJW
         OCVfPlSi6hR1d2nBdOmAaUqOm1k2aVdiYVifPBSaJg36aPLCYd627atm5xq7i1jPpDPV
         LPTXBROBnjDVetVZlsR/xEXr6fh5LhEO1sxUrVectpBdRNpXRKhcwa6bqORgDuQLr84Q
         aZhQ==
X-Gm-Message-State: AO0yUKUm9BMVzUEXKQYZGKXIN7S7gGfS5lqESEFOx0cefiyGXIYbb1Ts
        kmFKG4YqXm94SHUZUGTVezU=
X-Google-Smtp-Source: AK7set8wk4C6Ekf8Xwfo2NAOz7nxHbT8manxu13zfaDYG04nPGjvzYBFJ/I9KmIPHqdVwiTl6JSaBQ==
X-Received: by 2002:a5d:4452:0:b0:2bf:e9fb:f1d4 with SMTP id x18-20020a5d4452000000b002bfe9fbf1d4mr12038787wrr.38.1675514718189;
        Sat, 04 Feb 2023 04:45:18 -0800 (PST)
Received: from ?IPv6:2a02:ab88:368f:2080:d12e:7ef:c89a:f600? ([2a02:ab88:368f:2080:d12e:7ef:c89a:f600])
        by smtp.gmail.com with ESMTPSA id t6-20020adfa2c6000000b002be063f6820sm4482827wra.81.2023.02.04.04.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 04:45:17 -0800 (PST)
Message-ID: <6c528b24aa94751d568d3b43bd00a4795964b3ae.camel@gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: exynos: drop mshc aliases
From:   David Virag <virag.david003@gmail.com>
To:     Henrik Grimler <henrik@grimler.se>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        m.szyprowski@samsung.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Date:   Sat, 04 Feb 2023 13:45:15 +0100
In-Reply-To: <398401ce6a1e37b42f895b86fa2ed90c2676e15a.camel@gmail.com>
References: <20230203204000.14410-1-henrik@grimler.se>
         <20230203204000.14410-2-henrik@grimler.se>
         <398401ce6a1e37b42f895b86fa2ed90c2676e15a.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-02-04 at 12:43 +0100, David Virag wrote:
> On Fri, 2023-02-03 at 21:39 +0100, Henrik Grimler wrote:
> > They are no longer needed after commit a13e8ef6008d ("mmc: dw_mmc:
> > exynos: use common_caps").
> >=20
> > Signed-off-by: Henrik Grimler <henrik@grimler.se>
> > ---
> > =C2=A0arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 2 --
> > =C2=A0arch/arm64/boot/dts/exynos/exynos7-espresso.dts=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 2 --
> > =C2=A02 files changed, 4 deletions(-)
[...]
> In dw_mmc-exynos.c, there's a caps array specified like this:
>=20
> /* Common capabilities of Exynos4/Exynos5 SoC */
> static unsigned long exynos_dwmmc_caps[4] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0MMC_CAP_1_8V_DDR | MMC_CA=
P_8_BIT_DATA,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00,
> };
>=20
> As I understand these capabilities are added to the mmc controllers
> based on mshc alias id. Shouldn't these capabilities be moved to
> device-tree before removing these aliases? This also applies to the
> 32bit arm patch. If I understand correctly, removing these aliases
> without adding the capabilities to dt removes the capability
> "MMC_CAP_1_8V_DDR" and "MMC_CAP_8_BIT_DATA" from mshc_0/mmc_0.

Actually, it defaults to 0, so these capabilities will be added to all
mmc nodes, not just those with mshc0 alias. That may cause problems.


Best regards,
David
