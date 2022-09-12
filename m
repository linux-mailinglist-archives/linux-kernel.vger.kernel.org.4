Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884E05B52B5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 04:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiILCwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 22:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiILCws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 22:52:48 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975BD24F01;
        Sun, 11 Sep 2022 19:52:46 -0700 (PDT)
X-UUID: c5330deb367146d3bf4327e8d57c20ab-20220912
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=9iQvNSCdIGu6UTVgz7Ig2p0RKCQGqQ3bI7wc8ozG05w=;
        b=eS14lgERbfazx0EJ/IX03eKDpG/nbcEiqebhl6SJ0nXpVeVk0wUjynSkBEPT30UyRpMh7PPAvPGn3L7Vb+Z5XTI3kFVCfaEFUgETW8QOu93VC9H5aT4ZWR5qW4zg7zVgEcGhevqbG6ttaTTXtkGuLvmscO/ix2FW1eoGvShTwRM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:42fd265f-293b-4e61-9a9e-641637606e13,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:51
X-CID-INFO: VERSION:1.1.10,REQID:42fd265f-293b-4e61-9a9e-641637606e13,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:51
X-CID-META: VersionHash:84eae18,CLOUDID:672309f6-6e85-48d9-afd8-0504bbfe04cb,C
        OID:affc5e72d426,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c5330deb367146d3bf4327e8d57c20ab-20220912
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <nathan.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 791623106; Mon, 12 Sep 2022 10:52:39 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 12 Sep 2022 10:52:38 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 12 Sep 2022 10:52:38 +0800
Message-ID: <3b0dd4bf01400641a6b622f2c5344c9ded8b5995.camel@mediatek.com>
Subject: Re: [PATCH v2 0/6] Add first version mt8188 vdosys0 driver
From:   Nathan Lu <nathan.lu@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Rex-BC Chen" <rex-bc.chen@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <lancelot.wu@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 12 Sep 2022 10:52:37 +0800
In-Reply-To: <cd896ff3-47b7-43eb-c821-8c5fb53c6ae6@linaro.org>
References: <20220906084449.20124-1-nathan.lu@mediatek.com>
         <cd896ff3-47b7-43eb-c821-8c5fb53c6ae6@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Apologize for the incovenience.
I will remove it.

Best regards,

On Thu, 2022-09-08 at 15:14 +0200, Krzysztof Kozlowski wrote:
> On 06/09/2022 10:44, nathan.lu wrote:
> > From: Nathan Lu <nathan.lu@mediatek.com>
> > 
> > This path is based on [1] and [2]
> > [1] Add MediaTek SoC(vdosys1) support for mt8195
> >     - 
> > https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/list/?series=658416__;!!CTRNKA9wMg0ARbw!zuOwDY1dopRZLeZe36Ate1lspoWzDaM06Gj2x8zf9OprwhIMON5dJOlixUGivOIU$
> >  
> > [2] Add MediaTek SoC DRM (vdosys1) support for mt8195
> >     - 
> > https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/list/?series=665269__;!!CTRNKA9wMg0ARbw!zuOwDY1dopRZLeZe36Ate1lspoWzDaM06Gj2x8zf9OprwhIMON5dJOlixX9HBrk2$
> >  
> > 
> 
> Can you stop ccing internal/fake/non-existing email addresses?
> 
> Your message couldn't be delivered to wsd_upstream@mediatek.com
> because
> the remote server is misconfigured. See the technical details below
> for
> more information.
> 
> 
> Best regards,
> Krzysztof

