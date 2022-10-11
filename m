Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21F75FAA71
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJKCDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJKCDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:03:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880D162AB1;
        Mon, 10 Oct 2022 19:02:59 -0700 (PDT)
X-UUID: ed00fb0f73234a5e9d254a875e3b097b-20221011
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=yzZMTZnWRT6Z2eNvdPaZmSr5b+GMs7+C7GPXCnnqRyo=;
        b=frgcPBDtR4Eu5FOVXYULoALR1Wyy5QkEmNbkSX3hdJ1xrsw7qEo4DH1Pz66076g0x3ewb2Rx162duWNSIgx/7hyv2IFSwK8rLDtqKUh2CP5kGIGNSpiZy8LiLwWSOwGZIfl9SZG8d6WVQTgvl8LRP+mZjVw3bo4BEyzfv4ykT+g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:1e629bd1-f6ca-4b07-bdb9-4519f3377df8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:-32768,SF:-32768,FILE:0,BULK:-32768,RULE:Rele
        ase_Ham,ACTION:release,TS:0
X-CID-INFO: VERSION:1.1.11,REQID:1e629bd1-f6ca-4b07-bdb9-4519f3377df8,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:-32768,SF:-32768,FILE:0,BULK:-32768,RULE:Releas
        e_Ham,ACTION:release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:71d50901-cdeb-479d-93af-53f947adce9d,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: ed00fb0f73234a5e9d254a875e3b097b-20221011
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 158050263; Tue, 11 Oct 2022 10:02:45 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 11 Oct 2022 10:02:44 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 11 Oct 2022 10:02:44 +0800
Message-ID: <1da5fa8c9b22dcc8ada4e4e32a910dd552cc17d4.camel@mediatek.com>
Subject: Re: [PATCH v1 1/6] media: platform: mtk-mdp3: add chip
 configuration header file
From:   moudy ho <moudy.ho@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 11 Oct 2022 10:02:43 +0800
In-Reply-To: <9e14ae09-6100-a55f-7aa7-6ed9edb49e09@collabora.com>
References: <20221007031737.5125-1-moudy.ho@mediatek.com>
         <20221007031737.5125-2-moudy.ho@mediatek.com>
         <9e14ae09-6100-a55f-7aa7-6ed9edb49e09@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-10-07 at 11:07 +0200, AngeloGioacchino Del Regno wrote:
> Il 07/10/22 05:17, Moudy Ho ha scritto:
> > In order to be compatible with more MDP3 chip settings in the
> > future,
> > move the chip-related configuration to a separate header file.
> > 
> > Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> > ---
> >   .../media/platform/mediatek/mdp3/mt8183_mdp.h | 35
> > +++++++++++++++++++
> 
> What if we choose a better name format for the chip header?
> Would mdp3-plat-mt8183.h work for you?
> 
> Aside from that, the changes look good... but anyway, what this
> driver
> really needs is an abstraction of `mtk-img-ipi.h` since, as you know,
> new
> SoCs are using a different firmware and even a different architecture
> for
> the MCU.
> 
> Is that planned?
> 
> I think that such change would perfectly fit inside of this series.
> 
> Regards,
> Angelo
> 

Hi Angelo,

Thanks for all your advice, I will add another patch for SCP shared
memory header separation by chip, and integrate the following series
with the same purpose here.
[1] 
https://patchwork.kernel.org/project/linux-mediatek/list/?series=683671

Sincerely,
Moudy
> >   .../platform/mediatek/mdp3/mtk-mdp3-core.c    | 27 ++------------
> >   2 files changed, 37 insertions(+), 25 deletions(-)
> >   create mode 100644
> > drivers/media/platform/mediatek/mdp3/mt8183_mdp.h
> > 
> 
> 

