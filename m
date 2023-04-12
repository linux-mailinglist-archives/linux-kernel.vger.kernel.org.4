Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665326DFFF1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjDLUe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjDLUeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A619546B7;
        Wed, 12 Apr 2023 13:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EC5663072;
        Wed, 12 Apr 2023 20:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A303C433D2;
        Wed, 12 Apr 2023 20:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681331662;
        bh=Q76Of0pAllESEGyCSS4s6jcXwtDMwOcUfZRJ4hvZ/Do=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=i4VfUNhGY6jKbPCIDleGIDNQdHk0VxtsssFv94x2/xevrGWuAq3VmWrXZMlPAp5Vu
         ODpeAQwJBGVR8vNszEf40IqhFrgCJtxFF+drVFUZj3J4P9n5d/LKI2grKbRaVNF6/I
         D/dFEyL9u/DUcapT6OYhuaDH4EHiPLcwmIEMsmXQYCNTLjoj95w1c7ifLG1JNCrE91
         4cMI5CTwVZIq1bDjxqktyQYqMZcDumnnv9319Nq7CXE9YELcPcg+2Rs6UWH9ZcadyA
         uBKS91uwX9K4Yq4vIc7mBSuFYIB2S15jFllJmT8UB7UD3DnvN+Tv8847jlyFT6vZA2
         uYF1B9+t1ENwA==
Message-ID: <ed34eacdb1d35be8b9b2c44944f828e7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZDcC9JBidzfu94NW@probook>
References: <20221104161850.2889894-1-j.neuschaefer@gmx.net> <20221104161850.2889894-4-j.neuschaefer@gmx.net> <20221209202120.0AFACC433D2@smtp.kernel.org> <ZDcC9JBidzfu94NW@probook>
Subject: Re: [PATCH v5 3/6] dt-bindings: clock: Add Nuvoton WPCM450 clock/reset controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Date:   Wed, 12 Apr 2023 13:34:20 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Neusch=C3=A4fer (2023-04-12 12:13:56)
> Hi,
>=20
> On Fri, Dec 09, 2022 at 12:21:17PM -0800, Stephen Boyd wrote:
> > Quoting Jonathan Neusch=C3=A4fer (2022-11-04 09:18:47)
> > > The Nuvoton WPCM450 SoC has a combined clock and reset controller.
> > > Add a devicetree binding for it, as well as definitions for the bit
> > > numbers used by it.
> > >=20
> > > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > ---
> >=20
> > Applied to clk-next
>=20
> I don't see this patch in clk/linux.git's clk-next branch. Did it get
> lost somehow?
>=20

Must have gotten lost. I don't see it in my branch history locally.
Resend?
