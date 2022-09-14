Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB5C5B7E28
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 03:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiINBOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 21:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiINBOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:14:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FDD1B7B0;
        Tue, 13 Sep 2022 18:14:48 -0700 (PDT)
X-UUID: a1d05655b2c9437faf9c91ee3ae31ced-20220914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=MTgosqH3cM6tRY7+7QUh5eeeP+fTxZK2M7/kAsRs8f0=;
        b=XJawyV19zGwUbbtryySQK2VxKzwFcQ7yQy9METokfPKhmKqUOM0kUMXXG6jUKBMy8iw3Jgpbnt0M51GwLxr3hcv6BTtTMSPnm6ynJIPJDoM85h5RN0na2jKg1HJkW0ZNmmutijoge0EtvQ3jE/9oNHF5T4be8bCNgWASNpZneb4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:2d24f105-f9d2-480b-9468-5eb690d214e2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:51
X-CID-INFO: VERSION:1.1.11,REQID:2d24f105-f9d2-480b-9468-5eb690d214e2,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:51
X-CID-META: VersionHash:39a5ff1,CLOUDID:575d53ec-2856-4fce-b125-09d4c7ebe045,B
        ulkID:220914091444LPUU8HT7,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: a1d05655b2c9437faf9c91ee3ae31ced-20220914
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 84696426; Wed, 14 Sep 2022 09:14:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 14 Sep 2022 09:14:39 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 14 Sep 2022 09:14:39 +0800
Message-ID: <01a973c24276ff2e2919919d67f89fbc58cd071b.camel@mediatek.com>
Subject: Re: [PATCH RESEND v3 4/9] drm/mediatek: Add gamma support different
 lut_size for other SoC
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 14 Sep 2022 09:14:39 +0800
In-Reply-To: <e1945785da7c56bbb7fe94926c39fc6c3593cdb0.camel@mediatek.com>
References: <20220912013006.27541-1-jason-jh.lin@mediatek.com>
         <20220912013006.27541-5-jason-jh.lin@mediatek.com>
         <e1945785da7c56bbb7fe94926c39fc6c3593cdb0.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi CK,

Thanks for the reviews.

On Mon, 2022-09-12 at 11:14 +0800, CK Hu wrote:
> Hi, Jason:
> 
> On Mon, 2022-09-12 at 09:30 +0800, Jason-JH.Lin wrote:
> > 1. Add mtk_drm_gamma_get_lut_size() and remove MTK_LUT_SIZE macro.
> > 2. Add lut_size to gamma driver data for different SoC.
> 
> Separate these two modification to two patches. In the patch of
> mtk_drm_gamma_get_lut_size(), consider the aal driver.
> 
> Regards,
> CK

OK, I'll separate them.

Regards,
Jason-JH.Lin


