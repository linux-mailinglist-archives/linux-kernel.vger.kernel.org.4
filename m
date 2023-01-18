Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CE967254F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjARRoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjARRnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:43:01 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B965925F;
        Wed, 18 Jan 2023 09:42:45 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 256FD67373; Wed, 18 Jan 2023 18:42:43 +0100 (CET)
Date:   Wed, 18 Jan 2023 18:42:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com, jack@suse.cz
Subject: Re: [PATCH v4 14/14] blk-mq: correct stale comment of .get_budget
Message-ID: <20230118174242.GJ12399@lst.de>
References: <20230118093726.3939160-1-shikemeng@huaweicloud.com> <20230118093726.3939160-14-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118093726.3939160-14-shikemeng@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
