Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9197663996
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjAJG4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbjAJGzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:55:40 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B85BD9;
        Mon,  9 Jan 2023 22:55:39 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C6AFF68AFE; Tue, 10 Jan 2023 07:55:36 +0100 (CET)
Date:   Tue, 10 Jan 2023 07:55:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     axboe@kernel.dk, kernel@pankajraghav.com,
        linux-kernel@vger.kernel.org, hare@suse.de, bvanassche@acm.org,
        snitzer@kernel.org, dm-devel@redhat.com,
        damien.lemoal@opensource.wdc.com, linux-nvme@lists.infradead.org,
        hch@lst.de, linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH 3/7] nvmet: introduce bdev_zone_no helper
Message-ID: <20230110065536.GC10289@lst.de>
References: <20230106083317.93938-1-p.raghav@samsung.com> <CGME20230106083320eucas1p1d23de4ad21d0a7aecb74c549ebc7757c@eucas1p1.samsung.com> <20230106083317.93938-4-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106083317.93938-4-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/nvmet/block/ in the Subject.

Otherwise:

Reviewed-by: Christoph Hellwig <hch@lst.de>
