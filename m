Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F356A222E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 20:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjBXTPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 14:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjBXTPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 14:15:01 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDBC4DBD3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:15:00 -0800 (PST)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 538826602FCE;
        Fri, 24 Feb 2023 19:14:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677266099;
        bh=7MIYugRF4OeYSBU4bCpar84Hqz7+bV4a7/GjaOqhtPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PRETDL9/iBhS4S+FVHo+zY5QuY+M9m2bXMnVfviqogi+YSixjFekYZfWjzicgF2C8
         evXIeXfGn5rGA865YJ1ltShN3utyNoVc1gwimcsbF4sj6QUcs11XxQ7BYFOX5p6rz5
         8bpYdSqxODRW2ya/9tfUSgreE6/4c5itaX1lY3cluKjFXht9SfiFT+l82ZEbtp+jLv
         K5NXKQ4pUHjGn9FxG2I88ET+/cJhbvjuDUzefKXrIxRalXmCmLUK/9sH7TJTBhicGf
         3nANM21h+f3gaBg7bC/yv4B84hTAaTzCoM15LT3l6TAwVeAu5cNwgncIIyttp0qMLB
         zFzCp9XepqKsQ==
Date:   Fri, 24 Feb 2023 14:14:54 -0500
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
Subject: Re: [PATCH 2/4] ASoC: mt8192: Fix event generation for controls
Message-ID: <20230224191454.pklri23677z6lae4@notapiano>
References: <20230223-asoc-mt8192-quick-fixes-v1-0-9a85f90368e1@kernel.org>
 <20230223-asoc-mt8192-quick-fixes-v1-2-9a85f90368e1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230223-asoc-mt8192-quick-fixes-v1-2-9a85f90368e1@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 02:03:56PM +0000, Mark Brown wrote:
> ALSA controls put() operations should return 1 if the value changed and 0
> if it remains the same, fix the mt8192 driver to do so.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
