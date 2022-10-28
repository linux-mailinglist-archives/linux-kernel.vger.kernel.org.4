Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCFF610AD9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJ1G7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJ1G7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:59:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A731863C5;
        Thu, 27 Oct 2022 23:59:14 -0700 (PDT)
X-UUID: d3bea96e79d54aaf922f9cb260ba74ea-20221028
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0VYCNGu5up7oXK9iByzpPm+c/SezPGc55UX86NGHyoQ=;
        b=mSPEaNogr8FD3RF1QwodsxmV51YaONLGGP3pm4J7D7FlPj+I4hvu612hd4OG/vb8iUZs7jvjQXcKJqMud1DjkMA4PX/KkvSQ7lUuOAzrh8V4pXpYWTGN7P3NSRNzAT5FHGihjpmTJsnQio+PPlaXQSpxJxRM8+96/zZSZl7oJLg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:233c8d5a-d8f1-4e7e-baad-6510913e37fa,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:e720f2e4-e572-4957-be22-d8f73f3158f9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:-5,EDM:-3,IP:nil,
        URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: d3bea96e79d54aaf922f9cb260ba74ea-20221028
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 783513712; Fri, 28 Oct 2022 14:59:08 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 28 Oct 2022 14:59:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 28 Oct 2022 14:59:07 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <bagasdotme@gmail.com>
CC:     <Brian.Starkey@arm.com>, <benjamin.gaignard@collabora.com>,
        <christian.koenig@amd.com>, <dri-devel@lists.freedesktop.org>,
        <jstultz@google.com>, <labbott@redhat.com>,
        <linaro-mm-sig@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <lmark@codeaurora.org>,
        <mark-pk.tsai@mediatek.com>, <matthias.bgg@gmail.com>,
        <sumit.semwal@linaro.org>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH v2] dma-buf: cma_heap: Fix typo in comment
Date:   Fri, 28 Oct 2022 14:59:06 +0800
Message-ID: <20221028065907.23954-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <Y1tSWo+eRvkVofbv@debian.me>
References: <Y1tSWo+eRvkVofbv@debian.me>
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

> [-- Attachment #1: Type: text/plain, Size: 349 bytes --]
> 
> On Fri, Oct 28, 2022 at 09:44:17AM +0800, Mark-PK Tsai wrote:
> > Remove duplicated "by" from comment in cma_heap_allocate().
> > 
> 
> This patch isn't typofix but duplicate word stripping, right? If so, the
> patch subject should be "dma-buf: cma_heap: Remove duplicated 'by'".

Okay, I've update the title in v3.
Sorry for the horrible commit description.
Thanks.

> 
> Thanks.
> 
> -- 
