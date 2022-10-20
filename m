Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E61060661A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiJTQq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJTQqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:46:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539A91DB273
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:46:13 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2C848660247C;
        Thu, 20 Oct 2022 17:46:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666284371;
        bh=2MohZhSUGqmwuDliCCivOWpeD5bO3MbYBpcUQ98ps4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Me/Q6NQuidzZgGKz+QB89yUsmqD1HwCytpLajWWi/83SHoUMmxSFEMShEF9wlu16f
         cMmF7zdrGD2HlcRAyvyyi0PYChB/Y0fxufARemPw4b80YPkE5eW1S0CXlUrp8Hjd/M
         ZQbw6cOKjNg2qtszDjPKdot87NRhF/NwqpOcFCRbFyLddnyE8I8D4+q4sJH/+Sg6kB
         JXMaFOWbMKegjcpwj/w6uXO48ENIJKZRDPHe8ujmd/7VrD51vULICJ2gI8GrJfvUTE
         CoVUNKiGjYTfDP32vXnJcW11SN3sAzcZRjV4z7sCSzN6CTsTqAuQT+LYiRL+YCTRdg
         1OH/jpJ2vSRKw==
Date:   Thu, 20 Oct 2022 12:46:07 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     xinlei.lee@mediatek.com
Cc:     matthias.bgg@gmail.com, rex-bc.chen@mediatek.com,
        angelogioacchino.delregno@collabora.com, jason-jh.lin@mediatek.com,
        chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v12,3/3] drm: mediatek: Add mt8186 dpi compatibles and
 platform data
Message-ID: <20221020164607.3ysaptgpgn5gfwqj@notapiano>
References: <1666147936-27368-1-git-send-email-xinlei.lee@mediatek.com>
 <1666147936-27368-4-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1666147936-27368-4-git-send-email-xinlei.lee@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 10:52:16AM +0800, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Add the compatible because use edge_cfg_in_mmsys in mt8186.

I think the commit message could be improved:

Add support for mt8186. It needs its own mtk_dpi_conf data since
edge_cfg_in_mmsys is set to true for this platform.

> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

> ---
[..]
