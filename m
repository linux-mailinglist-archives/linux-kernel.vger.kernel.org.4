Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AF2615C6C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 07:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiKBGr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 02:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiKBGrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 02:47:52 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9F425EA7;
        Tue,  1 Nov 2022 23:47:51 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 997646732D; Wed,  2 Nov 2022 07:47:47 +0100 (CET)
Date:   Wed, 2 Nov 2022 07:47:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 06/30] nvme: Use kstrtobool() instead of strtobool()
Message-ID: <20221102064747.GA8903@lst.de>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr> <2e8d7f2f3cb754982f5fe99f2e13cf72db9d6dba.1667336095.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e8d7f2f3cb754982f5fe99f2e13cf72db9d6dba.1667336095.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What are th other 29 patches doing in this series?  Due to the lack of
context individual patches from series have to through /dev/null here,
sorry.
