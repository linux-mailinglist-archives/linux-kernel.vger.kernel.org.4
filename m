Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AB874D4FD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjGJMLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 08:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjGJMLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:11:41 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E8D123;
        Mon, 10 Jul 2023 05:11:40 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3FA226732D; Mon, 10 Jul 2023 14:11:36 +0200 (CEST)
Date:   Mon, 10 Jul 2023 14:11:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, hch@lst.de, tj@kernel.org, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: Re: [PATCH v5] blk-mq: fix start_time_ns and alloc_time_ns for
 pre-allocated rq
Message-ID: <20230710121136.GA17422@lst.de>
References: <20230710105516.2053478-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710105516.2053478-1-chengming.zhou@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a personal preference I kinda hate the empty ?:, but otherwise this
looks good;

Reviewed-by: Christoph Hellwig <hch@lst.de>
