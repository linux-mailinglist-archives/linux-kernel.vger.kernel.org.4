Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BBB67311F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjASFXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjASFXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:23:36 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A33FA8;
        Wed, 18 Jan 2023 21:23:33 -0800 (PST)
X-UUID: 67572b4497b911ed945fc101203acc17-20230119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/7Yi1/TMdF0ZsngPg/D7r3gCUq5DRgym11bWH2ZX2aA=;
        b=e8yyzlcpYUExm4xjS1jPrciM7zF7of3lvO0A9m89cCdt/A+oCRqfdRes2wYn/GIqi8kQzRvmupToiClFJmcfO/ebEnOxQ4vuLJhDvt9aRLdKrvxT3u6DA+N3nQ+S3+d7qDp1phPQ8WHQ+MIzZthEdABZSRFZo+8La2vG/9Dbd7g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:837c0451-4987-4a38-8722-aac40b04ee79,IP:0,U
        RL:0,TC:0,Content:14,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:14
X-CID-META: VersionHash:3ca2d6b,CLOUDID:8eb5af8c-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:3,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 67572b4497b911ed945fc101203acc17-20230119
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 185289891; Thu, 19 Jan 2023 13:23:27 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 19 Jan 2023 13:23:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 19 Jan 2023 13:23:26 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <angelogioacchino.delregno@collabora.com>
CC:     <chun-jie.chen@mediatek.com>, <daniel@makrotopia.org>,
        <devicetree@vger.kernel.org>, <fparent@baylibre.com>,
        <ikjn@chromium.org>, <johnson.wang@mediatek.com>,
        <jose.exposito89@gmail.com>, <kernel@collabora.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <msp@baylibre.com>,
        <mturquette@baylibre.com>, <nfraprado@collabora.com>,
        <pablo.sun@mediatek.com>, <rex-bc.chen@mediatek.com>,
        <robh+dt@kernel.org>, <ryder.lee@kernel.org>,
        <sam.shih@mediatek.com>, <sboyd@kernel.org>,
        <weiyi.lu@mediatek.com>, <wenst@chromium.org>,
        <y.oudjana@protonmail.com>, <yangyingliang@huawei.com>,
        <Mingming.Su@mediatek.com>
Subject: Re: [PATCH v3 00/23] MediaTek clocks cleanups and improvements
Date:   Thu, 19 Jan 2023 13:23:26 +0800
Message-ID: <20230119052326.15790-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230113110616.111001-1-angelogioacchino.delregno@collabora.com>
References: <20230113110616.111001-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc Mingming for mt2712.

I tested this v3 series on mt6779 and mt8192.

Tested-by: Miles Chen <miles.chen@mediatek.com> 

