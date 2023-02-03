Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0134568A147
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjBCSKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjBCSKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:10:33 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EB74B772;
        Fri,  3 Feb 2023 10:10:31 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1CEF41BF205;
        Fri,  3 Feb 2023 18:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675447830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NpgofewfeUpP0G2YrwylOH0ay6haU8cUq6WmPtCbgPA=;
        b=V4vJJUndyagh//+LFto4ZLaVa2r3WbhPnsUnG/KBL2Svgu87+kEUsAaXXDAy5l3tgHzjzB
        5QazFLOVLXrAbn3bqlnWw4bEDUqcGSHxrpUFcGQOhTvBD092K2wVNDOnNveMLbLmScW/q7
        hAdKXFEG4TXEZ+BThNYt9z9muxMnzfw320+pWS70FTRz8JJBi674kCRndvLs89is2HnGSq
        o5Ho+h5bn2S4bGVKPsHIpOcnKhtHaDgaTxbW4GkOnAcR15vVQGu5z6+/NqljC+LBE+7lWX
        BHCZgWY6LGGulpDhT7rQcj4dRwdxeKWfMy/3s5ostUh1rmH+ICWkNtvdtpIHiw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        benliang.zhao@mediatek.com, bin.zhang@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v6 5/5] mtd: nand: ecc-mtk: Add ECC support fot MT7986 IC
Date:   Fri,  3 Feb 2023 19:10:24 +0100
Message-Id: <20230203181024.436280-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230201021500.26769-6-xiangsheng.hou@mediatek.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'4d21176f48124e06c3251af38350b05a50ac4b01'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-02-01 at 02:15:00 UTC, Xiangsheng Hou wrote:
> Add ECC support fot MT7986 IC, and change err_mask value with
> GENMASK macro.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
