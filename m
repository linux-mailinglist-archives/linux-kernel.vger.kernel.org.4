Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46953749D0D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjGFNIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjGFNI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:08:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31691BDB;
        Thu,  6 Jul 2023 06:08:27 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 67E7968AFE; Thu,  6 Jul 2023 15:08:25 +0200 (CEST)
Date:   Thu, 6 Jul 2023 15:08:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de, tj@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v2 3/4] blk-flush: reuse rq queuelist in flush state
 machine
Message-ID: <20230706130825.GC13089@lst.de>
References: <20230629110359.1111832-1-chengming.zhou@linux.dev> <20230629110359.1111832-4-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629110359.1111832-4-chengming.zhou@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

