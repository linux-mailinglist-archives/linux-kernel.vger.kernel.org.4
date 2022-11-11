Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A415B625B7F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbiKKNwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiKKNwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:52:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8668BB4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 05:52:02 -0800 (PST)
Received: from notapiano (unknown [169.150.201.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 62C6D6602A3F;
        Fri, 11 Nov 2022 13:51:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668174721;
        bh=Y1n4/TLE/T+5dOKYdmwLPQmqxJho0aneBZSccErw/7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oZILSQkdxpFMjDb/MJ/wWC7M04kSNciX3vN3xRaktfYoBobjh9KRI7uPdKI9Q0khh
         aKFPkeyrt2LdN0Km5iawFuaBqAVxZN+OJRh+CwHc9JRpvwFCRm60ic3u6DL9sNZ/iA
         e4tTIYCSjAPoa1oWyE/XUO6OZ9ZEJxcdqj/fHWxn2vYXWl/hSKWVi/drJpq/qzNxO9
         Sf7+JIJHgmRV1i5qoQbun3f189MXCmEUe6MeVgj2nZ/brIBEViesZej+Vv4iJYcWxv
         2NK/dOj7D6WemQm/9A8h/p0hbVOjSQi3ITk07a2FJkjS65sdaiVsml98r1zy6Bpo0g
         S75ALSGUGgU1Q==
Date:   Fri, 11 Nov 2022 08:51:51 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: defconfig: Enable missing configs for
 mt8183-jacuzzi-juniper
Message-ID: <20221111135151.2fzkzfnzjwp35e3l@notapiano>
References: <20221109195012.1231059-1-nfraprado@collabora.com>
 <b4d674a1-228b-4ab5-45e1-42a02ab2339d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4d674a1-228b-4ab5-45e1-42a02ab2339d@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 09:42:07AM +0100, Matthias Brugger wrote:
> 
> 
> On 09/11/2022 20:50, Nícolas F. R. A. Prado wrote:
> > Enable missing configs in the arm64 defconfig to get all devices probing
> > on the mt8183-kukui-jacuzzi-juniper machine.
> > 
> > The devices enabled are: ATH10K SDIO wireless adapter, Elan touchscreen,
> > cr50 TPM, MediaTek SPI controller, JPEG video decoder, ANX7625 DSI/DPI
> > to DP bridge (used for the internal display), MT8183 sound cards, SCP
> > co-processor, MediaTek Global Command Engine (controlled by CMDQ
> > driver), MediaTek Smart Voltage Scaling (SVS) engine, CCI frequency
> > and voltage scaling, AUXADC thermal sensors.
> > 
> > All symbols are enabled as modules with the exception of SPI, which is
> > enabled as builtin since on some platforms like mt8195-cherry, the
> > ChromeOS Embedded Controller is connected through SPI and it is
> > responsible for the regulators powering the MMC controller used for the
> > SD card, and thus SPI support is required for booting.
> > 
> > By enabling the support for all of this machine's devices on the
> > defconfig we make it effortless to test the relevant hardware both by
> > developers as well as CI systems like KernelCI.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > 
> 
> Applied! Next time please make sure to add the linux mediatek mailinglist.

Argh, didn't realize it was missing, I just went with what get_maintainer
listed. Thanks for the heads up, will keep it in mind for next time!

Thanks,
Nícolas
