Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8CF6DB951
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 09:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjDHHo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 03:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjDHHou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 03:44:50 -0400
Received: from mail1.bemta31.messagelabs.com (mail1.bemta31.messagelabs.com [67.219.246.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424CC902C
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 00:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1680939888; i=@lenovo.com;
        bh=0V927EjiE5BPdaium3RYPi5hqbw2Q/YeBl7H7smblGc=;
        h=From:To:CC:Subject:Date:Message-ID:Content-Type:
         Content-Transfer-Encoding:MIME-Version;
        b=C4weojcpZcPZFyK7OTIKqRsqmonYTU+hEB54N14pLbPmox8saNiWo9OEbOtWqJz6G
         h84oVN0BaOEFaM2ZNZvUicZmc9sqFnePbHdOStCzJIvo4w0SQKP+ixwNDdvqBPA3Q9
         xYGY0LDuhrnKWpHPC6TPbpl+TLWcQlKjGY1uD14LoDOBncX+4Wa5bpJKBgrg/KixE8
         RIKQUMbi4gk+VmkSzdMNBds5jQpTyrmU4cViqD1ZFnWxcmhGXw+Mw5d0wKgIqzPtdP
         exV0zDbm8c2OReaPlKl/xE8siicQ1BpqzHLWrsZzLXWSMzeX7kEg1CLRGubxeLH+aL
         wZCWg3eXCon6A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHJsWRWlGSWpSXmKPExsWSoS+Vp5snbZh
  iMOsVh8X/PcfYLD50rmG0WLn6KJPFpEPXGC0u75rDZjF/2VN2i3Wv37M4sHtMbH7H7rGg5zyz
  x/l7G1k8Nq3qZPPYvKTeY/fNBjaPz5vkAtijWDPzkvIrElgzznWtZC14J1px4k43SwPjNOEuR
  k4ORoGlzBJzH+R1MXIB2YtYJeY272eHcDYwSnT/+swI4ggJzGWSWHhuEwuEc49RYvGsDUwg/W
  wC6hKLZp1mAkmICHQwSvQ8msAM4jALbGWUOHlhIjNIlbBAmsSlY41gtohAtsTZqTPZIWw9ie7
  +w4wgNouAisSs3htgU3kFYiW6/vYzQVwoKzHt0X0wm1lAXGLutFmsILaEgIDEkj3nmSFsUYmX
  j/+xQtSXSNx6uZ4NIi4rcWl+NyOEbS+x4M4KdgjbV+LikV4oW05iVe9DFghbXmLaovdQcRmJB
  ze2s4E8IyGwhFXi/9KXUM4xFomOBweYIKoMJOZ9OwKVmCcgMf/UVkaIU3UkFuz+xAZha0ssW/
  iaGeI1QYmTM59ArZOWmDB/FcsERs1ZSL6bhaR9FpL2WUjaFzCyrGI0LU4tKkst0jXVSyrKTM8
  oyU3MzNFLrNJN1Cst1k1NLC7RNdRLLC/WSy0u1iuuzE3OSdHLSy3ZxAhMailF7D47GPv6/uod
  YpTkYFIS5X0nqp8ixJeUn1KZkVicEV9UmpNafIhRhoNDSYJXUcowRUiwKDU9tSItMweYYGHSE
  hw8SiK8AX8MUoR4iwsSc4sz0yFSpxh1Oa5s27uXWYglLz8vVUqctwRkhgBIUUZpHtwIWLK/xC
  grJczLyMDAIMRTkFqUm1mCKv+KUZyDUUmYt10CaApPZl4J3KZXQEcwAR3B5QJ2REkiQkqqgWn
  6zMcKKtvzC43X6insN/l/WFHSfdWLhTdmTZ52f5LjrE9y2Rc2SHZ9b/w6m+HAfvnWZQ2Cy/x5
  JrnOm5HNubqCOUB1zZqq536zc0pYwk/tlv23SqHj+LItErLx15uWH27VkNq4TclCX7BtLavv1
  39LkvtjAuuYDlSJl+moh6bHK+xWecDJsf6JR2gG26wtvNFlimdXKIS9S93BuFFvvnFuFZfor+
  exHac3Wtmc75u+MuiQ+bOb0sl8Dn1G/zW22GkVXb74YY/H7if+y+ychC48lTcKPp580KOV+Y3
  TnAcT9rCHn1h7s5P9b+r5pH+v+c9URd2b/0ddVrLNR6jVMtbNXrkrvLjUyfLJhTpjQSWW4oxE
  Qy3mouJEAHqYqS9xBAAA
X-Env-Sender: yinlei2@lenovo.com
X-Msg-Ref: server-5.tower-706.messagelabs.com!1680939884!27913!1
X-Originating-IP: [104.47.26.110]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2997 invoked from network); 8 Apr 2023 07:44:45 -0000
Received: from mail-sgaapc01lp2110.outbound.protection.outlook.com (HELO APC01-SG2-obe.outbound.protection.outlook.com) (104.47.26.110)
  by server-5.tower-706.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 8 Apr 2023 07:44:45 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7N7a+t8XGjKDP6MLYUBmfaaKKx+0t8ZTu1MHXtmr6EKD9peTXMphskUd1kLdd+urz3eODyDUGz8+iwo9M3QSi6+qCgtiD9eh7Pe1Wk9ilCBY5ghlNLPPIlhuCdSm7dubvd/67WQrz/dMSHhwt9duJO4p/4juZRZRBUYweq4bBs6ykJDjYbIc2qQtzbI8DZnKdLVQCae/a72R+R7VtCPIMTdxNNegDWMD5+siWO/R3VbhDKFQiH1OYOwSZpQ0LCWSWpIOA2aSVkXOJRyZC4IWv6dzz/NpUXa2K8idlTHuFb0fNo/5ACnkIDdg4JZbqL5Bt44/mT8vNydKRGiJNv0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0V927EjiE5BPdaium3RYPi5hqbw2Q/YeBl7H7smblGc=;
 b=NFxMf8I1STvXY1QaKsx6/u0EZVejHo8mBG2IRpnG9Hc3gGwhAd0IMvVwBTthOS5kmDSSjVgGpX4sVlRbS5+Y3Z0wgzSa0O+C65+ipQPzXPAY+zibLIK5fJlo1vQBhDj+rcUq4NTquVLIZN3ra/nOBlcfIQ/JW/Pnv2dNKWfaZfEZfiyIAszBhPP7wD3RfhsvZVhjWFLu2j+VhTiAIyHgNFB1wgUe4kjl2zfvd7p5C/SxWnEhopBcTEXaJk+blJQRQj4clPWPfKLguEDzc9rjLy1yub0ePqwddYZNX84MFKKBtAwfzxy8/7SZkZVSkBaFlDP7NwcCwz0zzrBHTLVkfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from PS1PR03MB4939.apcprd03.prod.outlook.com (2603:1096:300:84::21)
 by SEZPR03MB6644.apcprd03.prod.outlook.com (2603:1096:101:7c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Sat, 8 Apr
 2023 07:44:42 +0000
Received: from PS1PR03MB4939.apcprd03.prod.outlook.com
 ([fe80::d2df:bfd7:dd18:5e56]) by PS1PR03MB4939.apcprd03.prod.outlook.com
 ([fe80::d2df:bfd7:dd18:5e56%3]) with mapi id 15.20.6277.034; Sat, 8 Apr 2023
 07:44:42 +0000
From:   Lei Lei2 Yin <yinlei2@lenovo.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cybeyond@foxmail.com" <cybeyond@foxmail.com>
Subject: [PATCH v2] nvme: fix double blk_mq_complete_request for timeout
 request with low probability
Thread-Topic: [PATCH v2] nvme: fix double blk_mq_complete_request for timeout
 request with low probability
Thread-Index: Adlp7D0a6eHDJ2XCQ12f5YXOFDMnBA==
Date:   Sat, 8 Apr 2023 07:44:41 +0000
Message-ID: <PS1PR03MB49397BF066FA9BC5BC5EE72488979@PS1PR03MB4939.apcprd03.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PR03MB4939:EE_|SEZPR03MB6644:EE_
x-ms-office365-filtering-correlation-id: 8e1cd836-8595-43bd-6887-08db38051d35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 64VDMmFVoPhG0xSs7+obtrlStawIbt8enectVvAqzqF814ZE86M4mnkS2LyhL+Nv0raoxnSSSEaLg9CwJfapLKdt1zCgux5LqvYh/6k5nniYKhq6musUsmPgMF3a4xNnbvFXc/t8yWxdHdNXrAbauduIsD8aF/vBcsOt6sQujxyP2TeTjy+Xr8cxqRRQrAEJYSdZyI4Zh77VbWdTfjeIDYAuBP46zgyEd+3OTsoLQgmc3rpXi28NLgPVkKfmUmOt00IMg3oUHsE87UjvUcgBflMm04SQgl+1tU1di0TsZb2U7BG/HIVfgMSnSCz1Pl207k2ek8d3TeAxzGYt7hczGxHtBEd3I3DrZmw6C8DsNRYTB0/lWANYlFVWS4UrHcqPvTGPVCf2MddSwAyqh0VELwbEOnWtE+IUxVxmYzE81aNqCokLCEDPFbO6Dj6U8VVodbR6L2tBaP7VzcWTjpgUT4uGXbh8ZPYeMTIBCclNnJ+2/mETpwALHvy4LtuqAB8mq4+CnNdqs5+1e702VGSykv5JUBFKvJtcGjYF4DDV5wq9eUeYaOencFCvFmftquj8HsGUAFyaFmIBm8Pq5XUEx349gUTLc1JflqJQcfkXR8R3fBfZuV5HTiuyY4BtFXpN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB4939.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199021)(478600001)(71200400001)(2906002)(7696005)(38070700005)(55016003)(6506007)(186003)(26005)(110136005)(316002)(83380400001)(53546011)(54906003)(9686003)(66946007)(8676002)(5660300002)(122000001)(82960400001)(66556008)(66476007)(41300700001)(52536014)(4326008)(8936002)(76116006)(38100700002)(64756008)(66446008)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6D9a/o8v2jaFyYMGBcG0wQbi43aX1cMCMTFkhxV2ogUoIMdh9Qwyg8szAey4?=
 =?us-ascii?Q?ZzXYIHCFXp9XjWLTCYafEUkC4byGBwjiA0/+Y+wJQZhMLJBxCDC1PT4zmWnP?=
 =?us-ascii?Q?dHWzvH3yiYMU4trgCZESsBeKqMbODibwD1kqpo/tCPu6kiEd8YFOj+idX+lf?=
 =?us-ascii?Q?dEhbWf+8lk9tlWDTudmSzN7A9fQUKCJE/G6KAgxanXkrpzEPFb1KaU9cc3Dg?=
 =?us-ascii?Q?Tg9rT4w1QZ4R5/eIhRGZ1V+RkNvqcetRwoeAMwtyyPxN9O0AhSYOrRd6al9r?=
 =?us-ascii?Q?563++dpjaXW1DyDD0PIuIdR4K5915xMrmbsdi6xhPzmsgP31mvOSQ5Fyz4Ps?=
 =?us-ascii?Q?hXtdgFZNPVmA1iIaEO8SpfvOSZ48XPNCZjOGSsf6G6LHZvz08Apw3kDxmB2y?=
 =?us-ascii?Q?j/h+foitG4m/uP1xvBT+smQ3X/d+A/D7rTBru+8RfRQKplHuo10OkWKoYxob?=
 =?us-ascii?Q?oGTPGGgnkztkI9bRh1U6OprFnCBg06i+BY7tbbpNdT4cl0h7r1OTZtCGokNZ?=
 =?us-ascii?Q?48WRuXJTSd9+wbLfVY8Aww/bAl27eI6OtdF8HPyy53RELgJH1ZfS9NgGIDIj?=
 =?us-ascii?Q?/E+gISpalgkz2V28mtLhvJO/Y35TcXHfgO/MjT8SiQmutAQf+yJtndYZX8mY?=
 =?us-ascii?Q?PJwIkTtrgC8NcXqUdQigAdNCWzFGp4teQljYOlYBwv7FWL58ngqBOm/SNtgO?=
 =?us-ascii?Q?qZE5bCtWpIMsgx4s79yqYzbvtoyIRpClvEBxW8PuuFmzLfioXf8DwsXMMzHS?=
 =?us-ascii?Q?Uboy2m6O3VYDkjJ2rGwIuH9cQ5GGnPnpDpoA22GEX2fz6T9QY3QNHcI+60oJ?=
 =?us-ascii?Q?5mqpvgrYRh4+kh7WkO+/m9p8b0R1wWVUa7WI1yF17Pp7e4uC+G13WFyzO1Uz?=
 =?us-ascii?Q?4RxtXZ+qVu42m7jLC6CBhrmdfBOl09Co/SSmOSKt43JVjq1QLm94+3ujTH3t?=
 =?us-ascii?Q?Ocdrw8Vkrs9g479OofCmqUTkuHyC/7OLjxXOfF0KeI/1WMVNtxz742yv4O5+?=
 =?us-ascii?Q?zG200gSNJa/xKH6CwZc/lzJLEJXCsYozMtVIqwghnpbiSfYSIWdXYlQUPYvV?=
 =?us-ascii?Q?SwYfArZQ3HmgJRHyDyBwA0BYd3VZd9AZUAbac5aWCrJE9FtP8BUVWOhnkuVN?=
 =?us-ascii?Q?ifLFnzyAxBLtGy5Ilhdbf8hEhKFeAaJ0t/I99OCbKAncXoVH3zVw5ARb6M/D?=
 =?us-ascii?Q?R9PsGTm0VL4cdfTYXGszO2f/4qY3/AE8VzEHoxsvdvR3MKjiAaT0Nduccv9M?=
 =?us-ascii?Q?2J107nFXFkUrEd3DcsC757UoOzvKsqUw7ACn3LVf59G7TLBNStRvNG3pcOQA?=
 =?us-ascii?Q?t8ie1PEfpfBd7TxQXX8JewrqzkQ9ZYL6Mt0brXFnfvJ5g8z715TVnFWKv84A?=
 =?us-ascii?Q?ejS1+BI18t6tqWYu7NkuM1BlL+o1MSLLBDhhl3XaBas0ry1QBQNZIkoF6O0b?=
 =?us-ascii?Q?5Z2YnyRhJFZ7WmrBPDcYAeEFO6TNZdFCPnlfg7CfORKjGZanLXsjF1mpQVbt?=
 =?us-ascii?Q?AeLw0yHkhiA2bX02f2maD+xilQugc19+DKWeUYTMaPksn1UcKzwMHX/4KIz8?=
 =?us-ascii?Q?JD+O1CNRVsB/XzEBsrg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB4939.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1cd836-8595-43bd-6887-08db38051d35
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2023 07:44:41.8535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ba1tb6XLRVBuRmkBxd0IBkwTqt743LO0OKgLvCzQtGKKTVyaNUjgc6ZHO39T3Hzb/61sK/5UsYWynF6RWVtJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6644
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 5148d52554d6bcf6134786d40f1c6f9f22e18978 Mon Sep 17 00:00:00 2001
From: Lei Yin <yinlei2@lenovo.com>
Date: Thu, 6 Apr 2023 23:39:11 +0800
Subject: [PATCH v2] nvme: fix double blk_mq_complete_request for timeout
 request with low probability

When nvme_cancel_tagset traverses all tagsets and executes
nvme_cancel_request, this request may be executing blk_mq_free_request
that is called by nvme_rdma_complete_timed_out/nvme_tcp_complete_timed_out.
When blk_mq_free_request executes to WRITE_ONCE(rq->state, MQ_RQ_IDLE) and
__blk_mq_free_request(rq), it will cause double blk_mq_complete_request for
this request, and it will cause a null pointer error in the second
execution of this function because rq->mq_hctx has set to NULL in first
execution.

With multipath, by injecting a large number of requests timed out, I have
reproduced the issue that caused kernel crashes in three versions of the
kernel(include 5.10.167, 6.2.10 and upstream version which compiled by
myself). The error stack is as follows:

[ 2777.253091]  <TASK>
[ 2777.253102]  nvme_failover_req+0x10a/0x120 [nvme_core]
[ 2777.255302]  blk_complete_reqs+0x3e/0x60
[ 2777.255726]  __do_softirq+0xb6/0x2ad
[ 2777.256139]  ? __pfx_smpboot_thread_fn+0x10/0x10
[ 2777.256556]  run_ksoftirqd+0x28/0x40
[ 2777.256978]  smpboot_thread_fn+0xdb/0x1d0
[ 2777.257399]  kthread+0xd7/0x100
[ 2777.257827]  ? __pfx_kthread+0x10/0x10
[ 2777.258253]  ret_from_fork+0x29/0x50
[ 2777.258695]  </TASK>

Signed-off-by: Lei Yin <yinlei2@lenovo.com>
---
 drivers/nvme/host/core.c    | 4 ++--
 drivers/nvme/host/fabrics.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 53ef028596c6..c1cc384f4f3e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -450,8 +450,8 @@ bool nvme_cancel_request(struct request *req, void *dat=
a)
 	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
 				"Cancelling I/O %d", req->tag);
=20
-	/* don't abort one completed request */
-	if (blk_mq_request_completed(req))
+	/* don't abort one completed or idle request */
+	if (blk_mq_rq_state(req) !=3D MQ_RQ_IN_FLIGHT)
 		return true;
=20
 	nvme_req(req)->status =3D NVME_SC_HOST_ABORTED_CMD;
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index dcac3df8a5f7..a25a0118b722 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -197,7 +197,7 @@ static inline char *nvmf_ctrl_subsysnqn(struct nvme_ctr=
l *ctrl)
=20
 static inline void nvmf_complete_timed_out_request(struct request *rq)
 {
-	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq)) {
+	if (blk_mq_rq_state(rq) =3D=3D MQ_RQ_IN_FLIGHT) {
 		nvme_req(rq)->status =3D NVME_SC_HOST_ABORTED_CMD;
 		blk_mq_complete_request(rq);
 	}
--=20
2.39.1
