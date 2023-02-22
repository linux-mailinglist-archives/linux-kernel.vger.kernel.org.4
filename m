Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FFB69ED92
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 04:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjBVDiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 22:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjBVDiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 22:38:05 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F78170F;
        Tue, 21 Feb 2023 19:37:59 -0800 (PST)
X-UUID: 4add3896b26211eda06fc9ecc4dadd91-20230222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=LVJ+MOKpfbG3MQ+icsHJ+2fAEsTjRFnL15ooEJk+oSc=;
        b=Flkq7wFKRBw3RR6mMBONH++2h5HYoVHWMb+TR+b+5NlPNDlvwrUfKJMwMoSFG1EU5Wa6jsY/akrWxjOqNZb5A6PrshSzJDgKWp4y7hfupfQZz7NPXpe5J6dJXOX4Qo0ygkXqfK5oD+deur9HpXpaSj9rrsCzP5oUSCHp+yb4SjE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:bd4bb221-eaa0-450d-b706-c9965d95591c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:25b5999,CLOUDID:73f64f26-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 1,FCT
X-UUID: 4add3896b26211eda06fc9ecc4dadd91-20230222
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 271544970; Wed, 22 Feb 2023 11:37:55 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 22 Feb 2023 11:37:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 22 Feb 2023 11:37:53 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <angelogioacchino.delregno@collabora.com>
CC:     <chen.zhong@mediatek.com>, <chun-jie.chen@mediatek.com>,
        <daniel@makrotopia.org>, <edward-jw.yang@mediatek.com>,
        <fparent@baylibre.com>, <granquet@baylibre.com>,
        <johnson.wang@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <msp@baylibre.com>,
        <mturquette@baylibre.com>, <nfraprado@collabora.com>,
        <pablo.sun@mediatek.com>, <rex-bc.chen@mediatek.com>,
        <sam.shih@mediatek.com>, <sboyd@kernel.org>,
        <sean.wang@mediatek.com>, <wenst@chromium.org>,
        <yangyingliang@huawei.com>, <zhaojh329@gmail.com>
Subject: Re: [PATCH v4 00/54] MediaTek clocks: full module build and cleanups
Date:   Wed, 22 Feb 2023 11:37:53 +0800
Message-ID: <20230222033753.4128-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230221115549.360132-1-angelogioacchino.delregno@collabora.com>
References: <20230221115549.360132-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Algele,

>Changes in v4:
> - Rebased over clk-next branch as of 21/02/2023
> - MT8135: Squashed removal of __initconst annotation with conversion
>   to platform drivers as suggested by Chen-Yu
> - MT8135: Added mention of the introduction of the dummy clock in
>   the commit description of patch [54/54]
> - Fixed Kconfig ordering issue for MT8195 IMGSYS dependant option
>
...snip
>
>NOTE: Applies on top of [1] and [2].
>
>
...snip
>This series was build-tested for all (both module and built-in build)
>and was manually tested on MT6795, MT8173, MT8192, MT8195.
>
>[1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=719067
>[2]: https://patchwork.kernel.org/project/linux-mediatek/patch/20230207014800.7619-2-moudy.ho@mediatek.com/

I tested this series with linux-next and only [1] on MT6779 and MT8192.

For this series:
Tested-by: Miles Chen <miles.chen@mediatek.com> 

thanks,
Miles
