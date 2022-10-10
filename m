Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDBF5F9B0E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 10:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiJJIa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 04:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiJJIaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 04:30:52 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77CE63FE6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 01:30:51 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A2B5968AA6; Mon, 10 Oct 2022 10:30:48 +0200 (CEST)
Date:   Mon, 10 Oct 2022 10:30:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ning Wang <ningwang35@outlook.com>,
        Chang Feng <flukehn@gmail.com>
Subject: Re: [PATCH] nvme-pci: avoid the deepest sleep state on ZHITAI
 TiPro5000 SSDs
Message-ID: <20221010083048.GB24401@lst.de>
References: <20220928093913.45905-1-xry111@xry111.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928093913.45905-1-xry111@xry111.site>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-6.1.
