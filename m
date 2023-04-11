Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD846DD268
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjDKGIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjDKGIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:08:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340FF199D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:08:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 405BE68D05; Tue, 11 Apr 2023 08:08:31 +0200 (CEST)
Date:   Tue, 11 Apr 2023 08:08:30 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Lei Lei2 Yin <yinlei2@lenovo.com>
Cc:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cybeyond@foxmail.com" <cybeyond@foxmail.com>
Subject: Re: [PATCH] nvme: fix double blk_mq_complete_request for timeout
 request with low probability
Message-ID: <20230411060830.GB18527@lst.de>
References: <PS1PR03MB4939C825BD5D9A135AA0EB9188919@PS1PR03MB4939.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS1PR03MB4939C825BD5D9A135AA0EB9188919@PS1PR03MB4939.apcprd03.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-6.4.
