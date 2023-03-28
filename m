Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E18E6CC079
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjC1NS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjC1NSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:18:55 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EB6A7EC9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:18:51 -0700 (PDT)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id ADE4B243E72;
        Tue, 28 Mar 2023 15:18:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1680009530;
        bh=DLtnJXx6M4haUdmi86w6QqevTK44QpcnHRXpjyULjLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2/LVvTDcJoy5hFvrgO7kUZ86PI5STEdCre33Tk1y1CtjX4K9ERu9dqm08D28uw/N0
         rWnKYxFxbAO2EWfzNToaV9c6vtIf6NGyk8O9sm3zLbo8KCpbLDRoDGSHs7J/x4G7ts
         5d5VWwUWg+jgAnnBOv4CMsedAs7FNJ4UIycClbgoqQLL3dhwG737khgCWk2k/DTSHv
         XW+lDt6soYXS6EvQjXIpdPjnnNBfwgnd3Tpe59KD3ag7e4XrO/KVazUQZDSpG83NjV
         8Qm7LA1jPU1wtrA2s7RxdiFOBkQH8/qraafre1AQNO/yEM1MHGLRLXpnY3E3OhmQYQ
         D4uhTSvDPD2xg==
Date:   Tue, 28 Mar 2023 15:18:49 +0200
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     Yong Wu =?utf-8?B?KOWQtOWLhyk=?= <Yong.Wu@mediatek.com>
Cc:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jianjiao Zeng =?utf-8?B?KOabvuWBpeWnoyk=?= 
        <Jianjiao.Zeng@mediatek.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Chengci Xu =?utf-8?B?KOiuuOaJv+i1kCk=?= 
        <Chengci.Xu@mediatek.com>,
        YF Wang =?utf-8?B?KOeOi+S6kemjnik=?= <YF.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v2] iommu/mediatek: Set dma_mask for PGTABLE_PA_35_EN
Message-ID: <ZCLpOWK90pnNNYxj@8bytes.org>
References: <20230316064251.7346-1-yong.wu@mediatek.com>
 <ZBsRlgJIaQieIbzU@8bytes.org>
 <5555473c3f3a49656d8e62479aa2c0b9d6d8d7e1.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5555473c3f3a49656d8e62479aa2c0b9d6d8d7e1.camel@mediatek.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 11:32:38AM +0000, Yong Wu (吴勇) wrote:
> Thanks very much for the applying. I'm sorry I had a typo in this
> version. Is it possible to use v3 instead?

Done. Thanks for the heads-up.
