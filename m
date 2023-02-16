Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133F1699FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 23:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjBPWct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 17:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBPWcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 17:32:42 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFD150355
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 14:32:35 -0800 (PST)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2CDAD66021BB;
        Thu, 16 Feb 2023 22:32:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676586753;
        bh=BzIGU+CnzDqDmo4i4mfAIbOxauz9KQjP4bPTNMrSrjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GudBLn5ToXmtRjopanrmapzvk2T2D6ZQq2px1IOPZWgx5PCDNY4iQ6fRgAsdSfevB
         5z+v9eArMJPhnTIOKRGkWNzYZpi3WJn8DjEI1mrcQs2TXaRERCMeYlpXmCyllIWiOS
         t9xf/J3K8m8NUEs7XtAmEG1pDLjEh4rC/g6Y2Vkyshs4mEtEKhAfQzPM7qeTCBfkCX
         NyUGXjwwP2zLqTOZOs5vRfhQGr3zolvFFFFKKiyo4Io+Au6u3Z9vkDbVPQtgWl3kdk
         BxOp2klhZqZTPSh/bnL51zVyfU1sKbxyy58GPFQCJwN7Sa8vx3cgOxJQm3J0qk50YM
         YNqDDWsH34J3Q==
Date:   Thu, 16 Feb 2023 17:32:27 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Xin Ji <xji@analogixsemi.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: anx7625: Use common macros for DP power
 sequencing commands
Message-ID: <20230216223227.sysy3mo4yhnsb42a@notapiano>
References: <20230116072406.3971025-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230116072406.3971025-1-wenst@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 03:24:06PM +0800, Chen-Yu Tsai wrote:
> The DRM DP code has macros for the DP power sequencing commands. Use
> them in the anx7625 driver instead of raw numbers.
> 
> Fixes: 548b512e144f ("drm/bridge: anx7625: send DPCD command to downstream")
> Fixes: 27f26359de9b ("drm/bridge: anx7625: Set downstream sink into normal status")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

In the same way, 0x68028 should be switched for DP_AUX_HDCP_BCAPS and 0x01 for
DP_BCAPS_HDCP_CAPABLE, though those aren't part of power sequencing, so are
actually better off in a separate commit.

Thanks,
Nícolas
