Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF66653D13
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 09:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiLVIlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 03:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiLVIk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 03:40:59 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1F723BCE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 00:40:58 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1BBED67373; Thu, 22 Dec 2022 09:40:56 +0100 (CET)
Date:   Thu, 22 Dec 2022 09:40:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     zhangyanjun@cestc.cn
Cc:     hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3] nvme: fix multipath crash caused by flush request
 when blktrace is enabled
Message-ID: <20221222084055.GA12963@lst.de>
References: <20221222015721.76241-1-zhangyanjun@cestc.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222015721.76241-1-zhangyanjun@cestc.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-6.2.
