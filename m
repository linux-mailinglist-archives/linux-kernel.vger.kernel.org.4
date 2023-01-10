Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C3F663998
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjAJG4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbjAJG41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:56:27 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47BE3726D;
        Mon,  9 Jan 2023 22:56:26 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2E03868C4E; Tue, 10 Jan 2023 07:56:24 +0100 (CET)
Date:   Tue, 10 Jan 2023 07:56:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     axboe@kernel.dk, kernel@pankajraghav.com,
        linux-kernel@vger.kernel.org, hare@suse.de, bvanassche@acm.org,
        snitzer@kernel.org, dm-devel@redhat.com,
        damien.lemoal@opensource.wdc.com, linux-nvme@lists.infradead.org,
        hch@lst.de, linux-block@vger.kernel.org, gost.dev@samsung.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 5/7] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Message-ID: <20230110065623.GD10289@lst.de>
References: <20230106083317.93938-1-p.raghav@samsung.com> <CGME20230106083322eucas1p2414f1f7f121fbbd7a0e5e1b1b622f5c0@eucas1p2.samsung.com> <20230106083317.93938-6-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106083317.93938-6-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given that we don't even support the non pow of 2 zones in the block
layer I don't see why this is needed.  But either way it doesn't really
seem to fit into this series.
