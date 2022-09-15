Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756D35B966D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiIOIeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiIOIdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:33:40 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A5D95E56;
        Thu, 15 Sep 2022 01:33:39 -0700 (PDT)
X-UUID: e351d00115f24bf6a508f74911a78e51-20220915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=+VzMpAhkDeuqCaOFZo9E99GwTzm37KqLKnhL2XdlWf8=;
        b=GxL0aYkDjZMLA7fhW6vIZnmZ96hSg1AnyFlHFe/cqKbCb8k/VSrAITYg10ZEyRGL8eugIwvCuVeaO452YJwCaVtTNEqo0f8/y5SfyHxqNqEN86nyD7bX5f5/y0axO14ZwNn/ALgEmqvT+qTSyFge8hfAVXgwDLN/v0IrDqiB0V4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:70194f9e-b879-4a8d-a868-0e89ecba5c94,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:4eedbf5d-5ed4-4e28-8b00-66ed9f042fbd,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e351d00115f24bf6a508f74911a78e51-20220915
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1208655419; Thu, 15 Sep 2022 16:33:34 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 15 Sep 2022 16:33:32 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 15 Sep 2022 16:33:32 +0800
Message-ID: <cc8dc51e9b0815843ef11957903f4867274ce63b.camel@mediatek.com>
Subject: Re: [PATCH 4/4] arm64: dts: mediatek: cherry: Add edptx and dptx
 support
From:   Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 15 Sep 2022 16:33:32 +0800
In-Reply-To: <9e0bc249-73cf-90d8-02d4-e9bdf8f34056@collabora.com>
References: <20220915075849.1920-1-rex-bc.chen@mediatek.com>
         <20220915075849.1920-5-rex-bc.chen@mediatek.com>
         <9e0bc249-73cf-90d8-02d4-e9bdf8f34056@collabora.com>
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

On Thu, 2022-09-15 at 16:13 +0800, AngeloGioacchino Del Regno wrote:
> Il 15/09/22 09:58, Bo-Chen Chen ha scritto:
> > - Add pinctrl for edptx and dptx.
> > - Add port for edptx and dptx.
> > 
> 
> The commit description is not great: explain why this board needs
> eDP/DP
> (so, explain that eDP is connected to internal panel, DP for external
> display)
> 
> Thanks,
> Angelo
> 

Hello Angelo,

OK, I will improve the commit message in next version.

BRs,
Bo-Chen

> > Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> 
> 

