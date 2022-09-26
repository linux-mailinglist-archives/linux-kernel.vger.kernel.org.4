Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68AF5EB22D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiIZUgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIZUgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:36:20 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD416CD2F;
        Mon, 26 Sep 2022 13:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=JDRp4qDr97IzM04ueqqbM+oSnyDy0BzALtcY4EKIDWo=; b=CQ33+ur/wXAuMpk31a+d91z6f2
        O+rH4wfoBJhnCU1w4k+ofQRQkELKhmDZQZmV9pU93nbHvcVnNmPErmEp5d56WNpFgucZ89a+RzWdV
        zdFxRtR4OMryfGnQRMPPJDF7VVHWEDylxP2hel4zyrh7rgAdu5QCWbPX+LQKAqL9uGQxaWTSRDBJL
        4ioVAutyajsmTNQN+S4ls7x++DCGOAOdYH0Rd/9pT9x6modnLw5M/ySApOc+kTXh/q+Erwjrd7x78
        TYX5+lAWBY6fm9EzN4xYyEbqALZk0UpZ00lg7WYzc9upd5yIxIb0L+f9q/EWyvz83ZG/L3X3j4mYE
        wCG7IJkQ==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1ocupq-00BDUk-Bw; Mon, 26 Sep 2022 22:36:14 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1ocupp-0001J1-2k;
        Mon, 26 Sep 2022 22:36:13 +0200
Date:   Mon, 26 Sep 2022 22:36:13 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Add missing rockchip,pipe-grf to
 rk3568 PCIe v3 PHY
Message-ID: <YzINPR0htauYppWQ@aurel32.net>
Mail-Followup-To: Peter Geis <pgwipeout@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>
References: <20220926183533.1893371-1-aurelien@aurel32.net>
 <CAMdYzYoR2caD2ecN5vGTiHejoE5AhbyKxSgSeU1+SzU7nNVTwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdYzYoR2caD2ecN5vGTiHejoE5AhbyKxSgSeU1+SzU7nNVTwg@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-26 14:58, Peter Geis wrote:
> On Mon, Sep 26, 2022 at 2:35 PM Aurelien Jarno <aurelien@aurel32.net> wrote:
> >
> > This commit fixes the error message
> >
> >   rockchip-snps-pcie3-phy fe8c0000.phy: failed to find rockchip,pipe_grf regmap
> 
> The pipe grf only is used on the rk3588 device for this phy.
 
Ok, looking at the code in details, I confirm that. Does it mean the
change should be done at the phy driver level, to only look for
rockchip,pipe-grf on the rk3588 device?

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
