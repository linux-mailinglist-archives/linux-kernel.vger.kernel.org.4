Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72BD6EFDEB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 01:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjDZXMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 19:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjDZXMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 19:12:49 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855EE358E;
        Wed, 26 Apr 2023 16:12:45 -0700 (PDT)
Date:   Thu, 27 Apr 2023 01:12:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1682550763;
        bh=PZpGk7rRCt4ehhsgRDpHyzzOzPQu1DqqumRtK7iBeaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o6cohrkryZuf2TEO3R1+ptwvr0tzx/Eruz4XzqF+/nOK+tLgT1+RZvdRwByxTaHkg
         xdfNIY8ols2G3HgPepKW+dphh6lUzcS9zAhjx/0jaddQsgOXXyy7/EMLSRu9hHpFKd
         jy1+G6JiX8uVeZlt6NUjISZTkOZK+dCIPUyo36ys=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 0/3] blk-integrity: drop integrity_kobj from gendisk
Message-ID: <862c1901-ee6e-44e5-8906-4bb1c3893372@t-8ch.de>
References: <20230309-kobj_release-gendisk_integrity-v3-0-ceccb4493c46@weissschuh.net>
 <yq1v8ivtzrn.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1v8ivtzrn.fsf@ca-mkp.ca.oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin, Christoph, Jens,

On 2023-03-20 07:56:58-0400, Martin K. Petersen wrote:
> > The embedded member integrity_kobj member of struct gendisk violates
> > the assumption of the driver core that only one struct kobject should
> > be embedded into another object and then manages its lifetime.
> >
> > As the integrity_kobj is only used to hold a few sysfs attributes it
> > can be replaced by direct device_attributes and removed.
> 
> Looks good to me and passed a quick test on a couple of systems. Thanks
> for cleaning this up!
> 
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

Am I getting some part of the process for block/ wrong?

It seems my patches for the block subsystem are having a hard time
getting merged.

* https://lore.kernel.org/all/20221110052438.2188-1-linux@weissschuh.net/
* this series
* https://lore.kernel.org/all/20230419-const-partition-v2-0-817b58f85cd1@weissschuh.net/

Thanks for any pointers,
Thomas
