Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEA66A224A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 20:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjBXTUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 14:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBXTUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 14:20:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E668365308
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:20:02 -0800 (PST)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1F2056602FCE;
        Fri, 24 Feb 2023 19:20:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677266401;
        bh=93WOmXt3Of9KXOA1+0JJLvM2QcA/MehDyh1OEKDHA+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OusYABMC/GMZI+VunNJn3PdsgJr6AbABf3RI19Z1F5wcqComEwcdMt3gCFzU+VeML
         6AxCeO8L3MXcza4//XqoCgfkw0BS6i3wFu7D/X0JdzOZ6+paNaY7TqOwIWWJDmtjmI
         1SbSHD3oFMbBCS0BQdEZN4bIkyXnui+7nTUSVBjtGOR+gp2ijk6NOu15oIksRJqT5A
         cqcvCvUYNWL/TcK/jbaVSE5cEHPmJfR0da9XXJRaZopq6z0K24GUTQEpJeaqAOo9gP
         RDCe7n/j6Ig7Mna3GMw8pvbRqx5e53yUV/4pAPY+3ucozGAdr2F4Thmgo427LOW2SK
         5QN6mVPjtIW3Q==
Date:   Fri, 24 Feb 2023 14:19:55 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ASoC: mt8192: Fix range for sidetone positive gain
Message-ID: <20230224191955.h74h3fcsj6w3k5al@notapiano>
References: <20230223-asoc-mt8192-quick-fixes-v1-0-9a85f90368e1@kernel.org>
 <20230223-asoc-mt8192-quick-fixes-v1-4-9a85f90368e1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230223-asoc-mt8192-quick-fixes-v1-4-9a85f90368e1@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 02:03:58PM +0000, Mark Brown wrote:
> The Sidetone_Positive_Gain_dB control reports a range of 0..100 as valid
> but the put() function rejects anything larger than 24. Fix this.
> 
> There are numerous other problems with this control, the name is very non
> idiomatic and it should be a TLV, but it's ABI so probably we should leave
> those alone.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
