Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A599D6DC3A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 08:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjDJGnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 02:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjDJGng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 02:43:36 -0400
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233D344BB;
        Sun,  9 Apr 2023 23:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1681109014; i=@fujitsu.com;
        bh=+dIHCpFAvsR7hmzQAKRJUqvdCdwuxuDAD8I19Qv4+6w=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=eI8Ty2hDmZrMFgNY5fhbW2Rg0B1T2iiyfOW8aHk322EiJPUL809R9r3ilsBjJhatO
         fGSXoE8p9OUVXbY3iF66lI4ESDtarNFEI2AcMTZlEsJ+UrFQC+BMzUbIrXSPrqWR42
         aVLsTAMuvVAkpT/CzPeS9UACbSzEGeRVF7pQ42KUrRCwtxjJKA00upwsNBIjGHKnFB
         ZkfVoz5zqbKNyCrEY5o1CYr1tRYrVLID2Rpg8oqNgfjs4pY8sxYeboLVyeEUaygAAa
         L6g1Ic4AXMJ+45zhwtTvNNUWuRLxorClSgeuDofy0KZnMHWQa9gDYg7E/VZRZhB0T2
         4n1m0OIIlTpag==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleJIrShJLcpLzFFi42Kxs+FI1BXdYJx
  icGOKvsWNaXIW205vYLeYOeMEo8XbTVNYLKb8WspscXnXHDaLZ4d6WRzYPU6/ucPksWlVJ5vH
  woapzB6fN8l5bP18myWANYo1My8pvyKBNWPrpTusBXs1Kp7cfsnewHhUvouRi0NIYAujxM+/V
  9kgnOVMEjPXLGOHcPYzSrTfbwfKcHKwCWhI3Gu5yQhiiwiUShxu28cOYjMLJEnMu/2WGcQWFn
  CWaO2/BhZnEVCVuLR/Klgvr4CjRMf5qywgtoSAgsSUh+/B6jkFnCQaWi+ygthCQDVX1jcyQtQ
  LSpyc+YQFYr6ExMEXL5ghehUljnT+hZpTIdE4/RAThK0mcfXcJuYJjIKzkLTPQtK+gJFpFaNZ
  cWpRWWqRrqGpXlJRZnpGSW5iZo5eYpVuol5qqW55anGJrqFeYnmxXmpxsV5xZW5yTopeXmrJJ
  kZgfKQUs8TvYLzW91fvEKMkB5OSKG8Xl3GKEF9SfkplRmJxRnxRaU5q8SFGGQ4OJQne7wuAco
  JFqempFWmZOcBYhUlLcPAoifCeWAaU5i0uSMwtzkyHSJ1i1OXY8ODAXmYhlrz8vFQpcd5f64C
  KBECKMkrz4EbA0sYlRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK8k0BW8WTmlcBtegV0BBPQ
  EVwuBiBHlCQipKQamCRbXlRelGFaafStaJX0oihrxbN6ZrrsHGsi3zZ/Ov5MjPlbyrRYwQVyk
  7VeqXbOF86JublTOuv95nO5t9V+e11fzzCzTFVGZ/OdY78tWB68KXzL9/bjsn0fuBLMbzN/yi
  yXZF3qzNRzf3ez/p6m1ysvr99ifGj3rYhN7uHCjqHTGczaAzUcWFs67tQLNj+amFJ9P0nvb67
  6q7Jdq7xjz3EtDVL8Zrbzv4262NrFvBoZilxZ01dcKfJfN2XdOsHAE4+yfxcx3mGqeneUe91D
  v+TtX1IbP97izpurdp4/7rT10tBLVgvKd9pPvM8nLTY9caG+9pS9ea4hs75dlFuW6W4RoL9XS
  aMwznZZ09cJq5RYijMSDbWYi4oTAeRYHgGWAwAA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-12.tower-585.messagelabs.com!1681109013!187048!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7500 invoked from network); 10 Apr 2023 06:43:33 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-12.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 10 Apr 2023 06:43:33 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 5181A1001B5;
        Mon, 10 Apr 2023 07:43:33 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 44F171001A5;
        Mon, 10 Apr 2023 07:43:33 +0100 (BST)
Received: from 31d618797ed9.localdomain (10.167.226.45) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 10 Apr 2023 07:43:30 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <haris.iqbal@ionos.com>, <jinpu.wang@ionos.com>, <jgg@ziepe.ca>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <guoqing.jiang@linux.dev>, <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Date:   Mon, 10 Apr 2023 06:43:03 +0000
Message-ID: <1681108984-2-3-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1681108984-2-1-git-send-email-lizhijian@fujitsu.com>
References: <1681108984-2-1-git-send-email-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The warning occurs when destroying PD whose reference count is not zero.

Precodition: clt_path->s.con_num is 2.
So 2 cm connection will be created as below:
CPU0                                              CPU1
init_conns {                              |
  create_cm() // a. con[0] created        |
                                          |  a'. rtrs_clt_rdma_cm_handler() {
                                          |    rtrs_rdma_addr_resolved()
                                          |      create_con_cq_qp(con); << con[0]
                                          |  }
                                          | in this moment, refcnt of PD was increased to 2+
                                          |
  create_cm() // b. cid = 1, failed       |
    destroy_con_cq_qp()                   |
      rtrs_ib_dev_put()                   |
        dev_free()                        |
          ib_dealloc_pd(dev->ib_pd) << PD |
           is destroyed, but refcnt is    |
           still greater than 0           |
}

Simply, Here we can avoid this warning by introducing conn own flag to
track if its cleanup should drop the PD.

-----------------------------------------------
 rnbd_client L597: Mapping device /dev/nvme0n1 on session client, (access_mode: rw, nr_poll_queues: 0)
 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 26407 at drivers/infiniband/sw/rxe/rxe_pool.c:256 __rxe_cleanup+0x13a/0x170 [rdma_rxe]
 Modules linked in: rpcrdma rdma_ucm ib_iser rnbd_client libiscsi rtrs_client scsi_transport_iscsi rtrs_core rdma_cm iw_cm ib_cm crc32_generic rdma_rxe udp_tunnel ib_uverbs ib_core kmem device_dax nd_pmem dax_pmem nd_
vme crc32c_intel fuse nvme_core nfit libnvdimm dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_mirror dm_region_hash dm_log dm_mod
 CPU: 0 PID: 26407 Comm: rnbd-client.sh Kdump: loaded Not tainted 6.2.0-rc6-roce-flush+ #53
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
 RIP: 0010:__rxe_cleanup+0x13a/0x170 [rdma_rxe]
 Code: 45 84 e4 0f 84 5a ff ff ff 48 89 ef e8 5f 18 71 f9 84 c0 75 90 be c8 00 00 00 48 89 ef e8 be 89 1f fa 85 c0 0f 85 7b ff ff ff <0f> 0b 41 bc ea ff ff ff e9 71 ff ff ff e8 84 7f 1f fa e9 d0 fe ff
 RSP: 0018:ffffb09880b6f5f0 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ffff99401f15d6a8 RCX: 0000000000000000
 RDX: 0000000000000001 RSI: ffffffffbac8234b RDI: 00000000ffffffff
 RBP: ffff99401f15d6d0 R08: 0000000000000001 R09: 0000000000000001
 R10: 0000000000002d82 R11: 0000000000000000 R12: 0000000000000001
 R13: ffff994101eff208 R14: ffffb09880b6f6a0 R15: 00000000fffffe00
 FS:  00007fe113904740(0000) GS:ffff99413bc00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007ff6cde656c8 CR3: 000000001f108004 CR4: 00000000001706f0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  rxe_dealloc_pd+0x16/0x20 [rdma_rxe]
  ib_dealloc_pd_user+0x4b/0x80 [ib_core]
  rtrs_ib_dev_put+0x79/0xd0 [rtrs_core]
  destroy_con_cq_qp+0x8a/0xa0 [rtrs_client]
  init_path+0x1e7/0x9a0 [rtrs_client]
  ? __pfx_autoremove_wake_function+0x10/0x10
  ? lock_is_held_type+0xd7/0x130
  ? rcu_read_lock_sched_held+0x43/0x80
  ? pcpu_alloc+0x3dd/0x7d0
  ? rtrs_clt_init_stats+0x18/0x40 [rtrs_client]
  rtrs_clt_open+0x24f/0x5a0 [rtrs_client]
  ? __pfx_rnbd_clt_link_ev+0x10/0x10 [rnbd_client]
  rnbd_clt_map_device+0x6a5/0xe10 [rnbd_client]

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 4 ++++
 drivers/infiniband/ulp/rtrs/rtrs-clt.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index c2065fc33a56..4c8f42e46e2f 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1664,6 +1664,7 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 			return -ENOMEM;
 		}
 		clt_path->s.dev_ref = 1;
+		con->has_dev = true;
 		query_fast_reg_mode(clt_path);
 		wr_limit = clt_path->s.dev->ib_dev->attrs.max_qp_wr;
 		/*
@@ -1690,6 +1691,7 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 		wr_limit = clt_path->s.dev->ib_dev->attrs.max_qp_wr;
 		/* Shared between connections */
 		clt_path->s.dev_ref++;
+		con->has_dev = true;
 		max_send_wr = min_t(int, wr_limit,
 			      /* QD * (REQ + RSP + FR REGS or INVS) + drain */
 			      clt_path->queue_depth * 3 + 1);
@@ -1742,6 +1744,8 @@ static void destroy_con_cq_qp(struct rtrs_clt_con *con)
 		con->rsp_ius = NULL;
 		con->queue_num = 0;
 	}
+	if (!con->has_dev)
+		return;
 	if (clt_path->s.dev_ref && !--clt_path->s.dev_ref) {
 		rtrs_ib_dev_put(clt_path->s.dev);
 		clt_path->s.dev = NULL;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index f848c0392d98..970b75633594 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -75,6 +75,7 @@ struct rtrs_clt_con {
 	unsigned int		cpu;
 	struct mutex		con_mutex;
 	int			cm_err;
+	bool			has_dev;
 };
 
 /**
-- 
2.29.2

