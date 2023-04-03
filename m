Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACECC6D3D3A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 08:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjDCGU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 02:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjDCGU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 02:20:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D268EA0;
        Sun,  2 Apr 2023 23:20:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i5so112971359eda.0;
        Sun, 02 Apr 2023 23:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680502822;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JmR6Md0ANsS1Rhn/3c0zlg1qjIkICF02SS0b5ww0aPY=;
        b=NbPZBu3ee3v1D7NLap+rHSjmimzMhEtCNjhiSyM4O3a7CiyAzA/zRcabO8hEIbKQE9
         es7zEKI3TV2RtbAsOiIxtYAlBJquU+ZYyrx0LL2OkrpBZURAg7qOl1IXbCJotkyT9ntA
         R5/dPY+AUzNP7Lo9viTt6z1L0asX9gfiJBzL9Hpgug2DIGaTgnsg8U99PX6WF8HjGaxl
         oqgdMpvyo9nvFNTkHzfJV8LjtrigeDzmeUk1v6/MWLqbKDKtmI2FoT6n7ducGBbfRjeM
         xkIXZJ28YA4YXQERvMhGJDJKF70uTZxMiFO66IoeUuyoub2zBtTwMBimIkVESj0eU9sA
         /3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680502822;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JmR6Md0ANsS1Rhn/3c0zlg1qjIkICF02SS0b5ww0aPY=;
        b=TVDPL5N7vgLAX9N+R9UnQ1lyt8lDPzQAnRqvenFzgjRQgF0DF8hlz+I5FDyoWCS6Sq
         v6M/XL7jtC0QErMMSWXCnict0hdtHntSAVFHn0wCqS0M7Z4tWyIcWYBJXHTXzZbTiZSQ
         lY6t6EOqF8YLjIP5pwyV9eZ8IOMDqfBqQ+UwR8l0+nLuZbVmKHNIWIM7GHgI+uMNNKla
         9htIS7lKXQ9k9JQ5iOEHBMGRUKEI0SZeGUEVHODSi9v5FCVt2EfzCNpbY4jjY4qm8mLv
         Iev8uc4jmMijvQ35LzDFblLzEDGouhuaimtnFcv/0DOSFteWq5WSutyTL+iU451kBYMm
         1eIg==
X-Gm-Message-State: AAQBX9fLXk0isV//wtBniHvcwz5145r98QnpyRBmjn4zOXkHSlKQaQMu
        m8p/GgpRwDJ5RNq+DePZJ8Q=
X-Google-Smtp-Source: AKy350ZOc7yeozVUPq5JUuO4BxvkyAgPe780izXXLKNVSLtG9SzbGkEde+3BHjGRYx1UPJy/38hkfg==
X-Received: by 2002:a17:906:a015:b0:8af:3382:e578 with SMTP id p21-20020a170906a01500b008af3382e578mr16455543ejy.4.1680502822268;
        Sun, 02 Apr 2023 23:20:22 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 8-20020a170906018800b009306ebc79d3sm4026343ejb.59.2023.04.02.23.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 23:20:21 -0700 (PDT)
Date:   Mon, 3 Apr 2023 09:20:18 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH v3 7/7] drbd: Pass a peer device to the resync and online
 verify functions
Message-ID: <6e0167a2-263d-4b79-aebc-42dc7df636fb@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230330102744.2128122-8-christoph.boehmwalder@linbit.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-B-hmwalder/genetlink-make-_genl_cmd_to_str-static/20230330-182912
base:   06965037ce942500c1ce3aa29ca217093a9c5720
patch link:    https://lore.kernel.org/r/20230330102744.2128122-8-christoph.boehmwalder%40linbit.com
patch subject: [PATCH v3 7/7] drbd: Pass a peer device to the resync and online verify functions
config: riscv-randconfig-m031-20230402 (https://download.01.org/0day-ci/archive/20230402/202304020852.dVP30hiV-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202304020852.dVP30hiV-lkp@intel.com/

smatch warnings:
drivers/block/drbd/drbd_worker.c:588 make_resync_request() warn: variable dereferenced before check 'peer_device' (see line 587)

vim +/peer_device +588 drivers/block/drbd/drbd_worker.c

e68ceefa210f83 Christoph Böhmwalder 2023-03-30  585  static int make_resync_request(struct drbd_peer_device *const peer_device, int cancel)
b411b3637fa71f Philipp Reisner      2009-09-25  586  {
e68ceefa210f83 Christoph Böhmwalder 2023-03-30 @587  	struct drbd_device *const device = peer_device->device;
                                                                                           ^^^^^^^^^^^^^^^^^^^
Dereference

44a4d551846b8c Lars Ellenberg       2013-11-22 @588  	struct drbd_connection *const connection = peer_device ? peer_device->connection : NULL;
                                                                                                   ^^^^^^^^^^^
Check for NULL.  You added a bunch of unchecked dereferences later as
well so hopefully this NULL check can be removed.

b411b3637fa71f Philipp Reisner      2009-09-25  589  	unsigned long bit;
b411b3637fa71f Philipp Reisner      2009-09-25  590  	sector_t sector;
155bd9d1abd604 Christoph Hellwig    2020-09-25  591  	const sector_t capacity = get_capacity(device->vdisk);
1816a2b47afae8 Lars Ellenberg       2010-11-11  592  	int max_bio_size;
e65f440d474d7d Lars Ellenberg       2010-11-05  593  	int number, rollback_i, size;
506afb6248af57 Lars Ellenberg       2014-01-31  594  	int align, requeue = 0;
0f0601f4ea2f53 Lars Ellenberg       2010-08-11  595  	int i = 0;
92d94ae66aebda Philipp Reisner      2016-06-14  596  	int discard_granularity = 0;
b411b3637fa71f Philipp Reisner      2009-09-25  597  
b411b3637fa71f Philipp Reisner      2009-09-25  598  	if (unlikely(cancel))
99920dc5c5fe52 Andreas Gruenbacher  2011-03-16  599  		return 0;
b411b3637fa71f Philipp Reisner      2009-09-25  600  
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  601  	if (device->rs_total == 0) {
af85e8e83d160f Lars Ellenberg       2010-10-07  602  		/* empty resync? */
e68ceefa210f83 Christoph Böhmwalder 2023-03-30  603  		drbd_resync_finished(peer_device);
99920dc5c5fe52 Andreas Gruenbacher  2011-03-16  604  		return 0;
af85e8e83d160f Lars Ellenberg       2010-10-07  605  	}
af85e8e83d160f Lars Ellenberg       2010-10-07  606  
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  607  	if (!get_ldev(device)) {
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  608  		/* Since we only need to access device->rsync a
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  609  		   get_ldev_if_state(device,D_FAILED) would be sufficient, but
b411b3637fa71f Philipp Reisner      2009-09-25  610  		   to continue resync with a broken disk makes no sense at
b411b3637fa71f Philipp Reisner      2009-09-25  611  		   all */
d01801710265cf Andreas Gruenbacher  2011-07-03  612  		drbd_err(device, "Disk broke down during resync!\n");
99920dc5c5fe52 Andreas Gruenbacher  2011-03-16  613  		return 0;
b411b3637fa71f Philipp Reisner      2009-09-25  614  	}
b411b3637fa71f Philipp Reisner      2009-09-25  615  
9104d31a759fba Lars Ellenberg       2016-06-14  616  	if (connection->agreed_features & DRBD_FF_THIN_RESYNC) {
92d94ae66aebda Philipp Reisner      2016-06-14  617  		rcu_read_lock();
92d94ae66aebda Philipp Reisner      2016-06-14  618  		discard_granularity = rcu_dereference(device->ldev->disk_conf)->rs_discard_granularity;
92d94ae66aebda Philipp Reisner      2016-06-14  619  		rcu_read_unlock();
92d94ae66aebda Philipp Reisner      2016-06-14  620  	}
92d94ae66aebda Philipp Reisner      2016-06-14  621  
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  622  	max_bio_size = queue_max_hw_sectors(device->rq_queue) << 9;
e68ceefa210f83 Christoph Böhmwalder 2023-03-30  623  	number = drbd_rs_number_requests(peer_device);
0e49d7b014c5d5 Lars Ellenberg       2014-04-28  624  	if (number <= 0)
0f0601f4ea2f53 Lars Ellenberg       2010-08-11  625  		goto requeue;
b411b3637fa71f Philipp Reisner      2009-09-25  626  
b411b3637fa71f Philipp Reisner      2009-09-25  627  	for (i = 0; i < number; i++) {
506afb6248af57 Lars Ellenberg       2014-01-31  628  		/* Stop generating RS requests when half of the send buffer is filled,
506afb6248af57 Lars Ellenberg       2014-01-31  629  		 * but notify TCP that we'd like to have more space. */
44a4d551846b8c Lars Ellenberg       2013-11-22  630  		mutex_lock(&connection->data.mutex);
44a4d551846b8c Lars Ellenberg       2013-11-22  631  		if (connection->data.socket) {
506afb6248af57 Lars Ellenberg       2014-01-31  632  			struct sock *sk = connection->data.socket->sk;
506afb6248af57 Lars Ellenberg       2014-01-31  633  			int queued = sk->sk_wmem_queued;
506afb6248af57 Lars Ellenberg       2014-01-31  634  			int sndbuf = sk->sk_sndbuf;
506afb6248af57 Lars Ellenberg       2014-01-31  635  			if (queued > sndbuf / 2) {
506afb6248af57 Lars Ellenberg       2014-01-31  636  				requeue = 1;
506afb6248af57 Lars Ellenberg       2014-01-31  637  				if (sk->sk_socket)
506afb6248af57 Lars Ellenberg       2014-01-31  638  					set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
b411b3637fa71f Philipp Reisner      2009-09-25  639  			}
506afb6248af57 Lars Ellenberg       2014-01-31  640  		} else
506afb6248af57 Lars Ellenberg       2014-01-31  641  			requeue = 1;
44a4d551846b8c Lars Ellenberg       2013-11-22  642  		mutex_unlock(&connection->data.mutex);
506afb6248af57 Lars Ellenberg       2014-01-31  643  		if (requeue)
b411b3637fa71f Philipp Reisner      2009-09-25  644  			goto requeue;
b411b3637fa71f Philipp Reisner      2009-09-25  645  
b411b3637fa71f Philipp Reisner      2009-09-25  646  next_sector:
b411b3637fa71f Philipp Reisner      2009-09-25  647  		size = BM_BLOCK_SIZE;
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  648  		bit  = drbd_bm_find_next(device, device->bm_resync_fo);
b411b3637fa71f Philipp Reisner      2009-09-25  649  
4b0715f09655e7 Lars Ellenberg       2010-12-14  650  		if (bit == DRBD_END_OF_BITMAP) {
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  651  			device->bm_resync_fo = drbd_bm_bits(device);
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  652  			put_ldev(device);
99920dc5c5fe52 Andreas Gruenbacher  2011-03-16  653  			return 0;
b411b3637fa71f Philipp Reisner      2009-09-25  654  		}
b411b3637fa71f Philipp Reisner      2009-09-25  655  
b411b3637fa71f Philipp Reisner      2009-09-25  656  		sector = BM_BIT_TO_SECT(bit);
b411b3637fa71f Philipp Reisner      2009-09-25  657  
e68ceefa210f83 Christoph Böhmwalder 2023-03-30  658  		if (drbd_try_rs_begin_io(peer_device, sector)) {
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  659  			device->bm_resync_fo = bit;
b411b3637fa71f Philipp Reisner      2009-09-25  660  			goto requeue;
b411b3637fa71f Philipp Reisner      2009-09-25  661  		}
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  662  		device->bm_resync_fo = bit + 1;
b411b3637fa71f Philipp Reisner      2009-09-25  663  
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  664  		if (unlikely(drbd_bm_test_bit(device, bit) == 0)) {
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  665  			drbd_rs_complete_io(device, sector);
b411b3637fa71f Philipp Reisner      2009-09-25  666  			goto next_sector;
b411b3637fa71f Philipp Reisner      2009-09-25  667  		}
b411b3637fa71f Philipp Reisner      2009-09-25  668  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

