Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD555FE28D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 21:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJMTRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 15:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJMTRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 15:17:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03195DFE2;
        Thu, 13 Oct 2022 12:17:22 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A375A6602368;
        Thu, 13 Oct 2022 20:17:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665688640;
        bh=XPnR4eQV28aEp36A+Rnv4iyGHE4Pd9SCoAN03pw58P0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nzWBMXxdFMBv5H+c45VXabjDnKOzjvHL4QRrFhyXiy5wnTgM+9+VM9ZWIWwPcWT8h
         VrENFQyS4lyQEmPUZIPBgxi/UAQZJFLamwPugjkTDfja/5l/5U5q9RNKxcp0CiZ7Ej
         R+Cv/uaCmYaUDtiPk7Q3FW/5QhWxSyfpCw+hrXbeCzTnOZ46FXH3mSwHSreSR4nl0O
         KbNY653iWHEmxX6hAT1Suk/TYvW61gyRaAdCcZkaPSGw4cXp6uu/k/NZlC7xC5e7wx
         Xr0dLwJqzHCBh4H8NkRClQOukrcs20LpwVJPuc4iWH4rz2Ft/LbD2F3vcnU6u12AWS
         h9o6glcq2689w==
Date:   Thu, 13 Oct 2022 15:17:15 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 4/5] arm64: dts: mediatek: asurada: Enable audio
 support
Message-ID: <20221013191715.5dyqunog2qj4z3fh@notapiano>
References: <20221006212528.103790-1-nfraprado@collabora.com>
 <20221006212528.103790-5-nfraprado@collabora.com>
 <CAGXv+5F684=hFa42vSuN24eBTGjj7LEQNzog9U8dEQffz0JZMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5F684=hFa42vSuN24eBTGjj7LEQNzog9U8dEQffz0JZMw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 02:53:24PM +0800, Chen-Yu Tsai wrote:
> On Fri, Oct 7, 2022 at 5:25 AM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > Enable audio support for the Asurada platform. This consists of the
> > machine sound card, the rt1015p codec for the speakers, the rt5682 codec
> > for the headset, and the dmic codec for the internal microphone.
> >
> > HDMI audio support is left out for now since the DisplayPort chip
> > required isn't enabled yet.
> >
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> 
> However the UCM you linked to in the cover letter didn't seem to work
> correctly.

Did you comment out the HDMI section in the UCM? This series doesn't add support
for HDMI but the UCM already configures it.

I sent the UCM with HDMI support since I have it working locally and was hoping
that the HDMI support would be merged shortly on the kernel side, but on second
thought it makes more sense to have a working though incomplete UCM merged for
now and add the HDMI support later when it's ready on the kernel side, so I'll
update the UCM to go this route.

Thanks,
Nícolas
