Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8995EEDA2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbiI2GMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbiI2GMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:12:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E3D12CCB9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 23:12:33 -0700 (PDT)
X-UUID: fcf61d1dcaf44f87b4f7b61752013650-20220929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=YI1zZfxac4tCJibwnL4J9lXHvkx5ulDsGyMM0uD184w=;
        b=VOZOFACEsHI49YLjAmOycGSVcBmtYtMfj+FRNvZ+XHlPiDpqBvgcXSVdu9N6uKuBxtTho+zx+wQ2VxlkqyoCE/sbDTH699aYBnrVm8CN6t0VHD0zl/haAGzNNlgLHAQjNv768V3LcTIITQmS6vIGUvAL1l3KrGRcy7HtsP5dylE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:a04b9a00-5912-48fe-9975-f318b1c1109a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.11,REQID:a04b9a00-5912-48fe-9975-f318b1c1109a,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:39a5ff1,CLOUDID:41b89ce4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:220928213550HNK1D146,BulkQuantity:68,Recheck:0,SF:38|28|17|19|48|823
        |824|102,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,B
        EC:nil,COL:0
X-UUID: fcf61d1dcaf44f87b4f7b61752013650-20220929
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1635597330; Thu, 29 Sep 2022 14:12:25 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 29 Sep 2022 14:12:24 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 29 Sep 2022 14:12:24 +0800
Message-ID: <425623b6368ffb1193033cfbd6256d1eb77fec80.camel@mediatek.com>
Subject: Re: [PATCH 2/2] phy: mediatek: tphy: add debugfs files
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>
Date:   Thu, 29 Sep 2022 14:12:23 +0800
In-Reply-To: <6ae64f49-5ab9-0b37-ae2c-5519c21a5d73@collabora.com>
References: <20220928093041.31481-1-chunfeng.yun@mediatek.com>
         <20220928093041.31481-2-chunfeng.yun@mediatek.com>
         <6ae64f49-5ab9-0b37-ae2c-5519c21a5d73@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-09-28 at 15:35 +0200, AngeloGioacchino Del Regno wrote:
> Il 28/09/22 11:30, Chunfeng Yun ha scritto:
> > These debugfs files are mainly used to make eye diagram test
> > easier,
> > especially helpful to do HQA test for a new IC without efuse
> > enabled.
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> 
> Even though this won't be interesting for the vast majority of the
> people
> out there (the users!), it's still nice to have it for IC testing
> performed
> directly on upstream, as that opens new possibilities for you and
> ODMs/OEMs,
> so I agree on getting that code upstreamed.
> 
> For that reason, I think that the best approach for this one would be
> to
> enclose it in a configuration option like CONFIG_PHY_MTK_TPHY_DEBUGFS
> or
> CONFIG_PHY_MTK_TPHY_DEBUG, so that this very low level debugging code
> doesn't end up in end-user builds, as that may, in some cases, be
> even
> dangerous.
Yes, It seems better, I'll modify it, thanks a lot

> 
> Regards,
> Angelo
> 

