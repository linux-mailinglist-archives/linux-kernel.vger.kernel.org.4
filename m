Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BEE5F7D52
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 20:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJGS0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 14:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJGS0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 14:26:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A38AC7050;
        Fri,  7 Oct 2022 11:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IudIrA3q3WpPWuZzZUKujefONUnAfceTWjlveYaPvio=; b=y3TnHRe5LU2pfTWpYrKhFoSYbh
        jboFN1RMi5CjIniehZGNTOJpkF2sr617jJ4vb6Ib6lSQpyC0ek2+SlWngTW1ubM41ZOvqG9t87RGe
        LZXDSjCQvYJpbTl+VRQpi8LkTLFVyXqr+kFALUeMkSNjyvXp3VTfiu6Hin9S6c12kBhwJdLbNbYn4
        4szHif4ftpjkLWks7RWt2NtkOf4pQQWV+FmMEugetSNijqYdLE8QwTu09Ycl6RznABM1+qPym5ADr
        Od764RzqJQFgxId6v9nZqSWYrZBx/EX1oe/ZXXPNJJb8O2jtIyGdk61SSE07/zRW76XLArhkeRZ+1
        ZC4+w/vg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogs33-00A41Z-Ot; Fri, 07 Oct 2022 18:26:13 +0000
Date:   Fri, 7 Oct 2022 11:26:13 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, axboe@kernel.dk, efremov@linux.com,
        josef@toxicpanda.com, idryomov@gmail.com,
        dongsheng.yang@easystack.cn, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, mst@redhat.com, jasowang@redhat.com,
        pbonzini@redhat.com, stefanha@redhat.com, ohad@wizery.com,
        andersson@kernel.org, baolin.wang@linux.alibaba.com,
        ulf.hansson@linaro.org, richard@nod.at, miquel.raynal@bootlin.com,
        vigneshr@ti.com, marcan@marcan.st, sven@svenpeter.dev,
        alyssa@rosenzweig.io, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, sth@linux.ibm.com, hoeppner@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, bhelgaas@google.com,
        john.garry@huawei.com, christophe.jaillet@wanadoo.fr,
        vaibhavgupta40@gmail.com, wsa+renesas@sang-engineering.com,
        damien.lemoal@opensource.wdc.com, johannes.thumshirn@wdc.com,
        bvanassche@acm.org, ming.lei@redhat.com,
        shinichiro.kawasaki@wdc.com, vincent.fu@samsung.com,
        christoph.boehmwalder@linbit.com, joel@jms.id.au,
        vincent.whitchurch@axis.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, asahi@lists.linux.dev
Subject: Re: [RFC PATCH 00/21] block: add and use init tagset helper
Message-ID: <Y0BvRaVO0iUVmHgB@bombadil.infradead.org>
References: <20221005032257.80681-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005032257.80681-1-kch@nvidia.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 08:22:36PM -0700, Chaitanya Kulkarni wrote:
> Hi,
> 
> Add and use the helper to initialize the common fields of the tag_set
> such as blk_mq_ops, number of h/w queues, queue depth, command size,
> numa_node, timeout, BLK_MQ_F_XXX flags, driver data. This initialization
> is spread all over the block drivers. This avoids repetation of
> inialization code of the tag set in current block drivers and any future
> ones.
> 
> P.S. I'm aware of the EXPORT_SYMBOL_GPL() checkpatch warn just to make
> get some feedback to so I can remove the RFC tag.
> 

*If* there were commonalities at init and these could be broken up into
common groups, each having their own set of calls, then we simplify and
can abstract these. I say this without doing a complete review of the
removals, but if there really isn't much of commonalities I tend to
agree with Bart that open coding this is better.

  Luis
