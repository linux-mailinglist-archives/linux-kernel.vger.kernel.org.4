Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55CE60FA7F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbiJ0Ogk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbiJ0Ogg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:36:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5887217F98E;
        Thu, 27 Oct 2022 07:36:35 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9232166028E8;
        Thu, 27 Oct 2022 15:36:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666881393;
        bh=YX3+dAZyM+hPoq4NUY7Nf//cJ/p1JRqJiGGTie6F7GI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OpxeoDGDZGKCCzDEz8rBV+Oi97nVmRZA8hazKDB2IPC4iFaSvMu7s8ZaM7Jk8OD1N
         dRorTKNdfoiJNBTTFffh3b6ey51VoOyU+r5qO/8xwlUOfqfsBOTghOSOvHRx6W0mAh
         cqXI5xjC5tuDkv85nExx5COO0c9FMtEa7/bab54vSlFwXlzv6NF832RvFLfnymtiuP
         diXs+sWLXuCT8ee4fAAdHdLRIvjHbfH+qZDx4QVJzbLkDi3Cf+i4o3x5uGAYCpxq9U
         sWgMH/AAgGLl71lJkJaFOmr/zAEcr00DH7uxuNaeklkhMyU5PEr0P/H3X5baleAjLl
         ky0sWIhlmuJwg==
Date:   Thu, 27 Oct 2022 10:36:27 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Derek Fang <derek.fang@realtek.com>,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 2/4] ASoC: dt-bindings: realtek, rt5682s: Add AVDD and
 MICVDD supplies
Message-ID: <20221027143627.nbbketezqunkclxh@notapiano>
References: <20221024220015.1759428-1-nfraprado@collabora.com>
 <20221024220015.1759428-3-nfraprado@collabora.com>
 <CAGXv+5HJo5x2ieOegmv5vkfh+rTevdR_fri-7PeK+Gd+GXVjNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5HJo5x2ieOegmv5vkfh+rTevdR_fri-7PeK+Gd+GXVjNw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 01:12:49PM -0700, Chen-Yu Tsai wrote:
> On Mon, Oct 24, 2022 at 3:01 PM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > The rt5682s codec can have two supplies: AVDD and MICVDD. They are
> 
> The actual chip also has LDO1_IN (for digital core and charge pump)
> and DBVDD (for I/O). However in the Chromebook designs these two
> and AVDD are all provided from the same power rail, through separate
> filter banks.

What about rt5682 (no s), does that chip also have these same supplies?

Also, since you already gave the purpose of these other supplies, could you also
tell the purpose of AVDD, MICVDD and (for rt5682) VBAT? That way I could add
some description for them in the binding.

Thanks,
Nícolas

> 
> Neither does the datasheet specify the ordering of AVDD, DBVDD, and
> LDO1_IN for power sequencing, just that three should be toggled together.
> 
> Should we model these? Or wait until some design actually splits these?
[..]
