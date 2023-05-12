Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC474700980
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241325AbjELNwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241310AbjELNw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:52:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25E835A9;
        Fri, 12 May 2023 06:52:27 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 307E268AFE; Fri, 12 May 2023 15:52:25 +0200 (CEST)
Date:   Fri, 12 May 2023 15:52:24 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Jinyoung CHOI <j-young.choi@samsung.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/14] scsi: add scsi_alloc_integrity_sgtables() for
 integrity process
Message-ID: <20230512135224.GE32242@lst.de>
References: <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1> <CGME20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p3> <20230510085607epcms2p3d2b2dfc5db42f77c41f570c361a41c6a@epcms2p3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510085607epcms2p3d2b2dfc5db42f77c41f570c361a41c6a@epcms2p3>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 05:56:07PM +0900, Jinyoung CHOI wrote:
> +	if (WARN_ON_ONCE(!prot_sdb)) {
> +		/*
> +		 * This can happen if someone (e.g. multipath)
> +		 * queues a command to a device on an adapter
> +		 * that does not support DIX.
> +		 */
> +		return BLK_STS_IOERR;

Nit: expand the comment to take up all 80 characters now that you've
unindented it.
