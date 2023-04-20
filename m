Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429A96E9510
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjDTMwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjDTMwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:52:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05816A4C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:52:02 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BA5AB68AFE; Thu, 20 Apr 2023 14:51:58 +0200 (CEST)
Date:   Thu, 20 Apr 2023 14:51:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Petr Tesarik <petrtesarik@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>, petr@tesarici.cz
Subject: Re: [PATCH v1 1/1] swiotlb: Omit total_used and used_hiwater if
 !CONFIG_DEBUG_FS
Message-ID: <20230420125158.GA1226@lst.de>
References: <cover.1681984708.git.petr.tesarik.ext@huawei.com> <f7bac7c24c00b0fde0505759af4cd200e7e62740.1681984708.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7bac7c24c00b0fde0505759af4cd200e7e62740.1681984708.git.petr.tesarik.ext@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied.
