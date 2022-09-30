Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E018A5F01B0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 02:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiI3AJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 20:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiI3AJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 20:09:45 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2074.outbound.protection.outlook.com [40.107.215.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F1217AB5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 17:09:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdSCBeB/J1rUKsdm6/jLjBW3cA19bdnMRC9+BH65ZmUBhUXs9xODPzJ6Tf7bUK4e2vxTFdSBWYbvhW7HPYy/MRzqTE+JdbsUINfkXU6KUmotAGk6ZTKvW+C6N20Ob4iZjU0RuC1hT4Js5jp7ACuXdiztnxFu8LXgzTNjsitu5L0tosO1snVj4gztubChKM/t1/V6K2lkRpb2CljGc/OZwCdcU2cbzQACpZ4Lj1zuy5sGMKsXmgtfjf6mazwe3Q72hJRjjF5ByiRjmXhBvQEJdNawHmIOBJeaoGtB1MCfAR5TGrpIB0MEQogU3ah81juwSmGasC783Qfri8x4t9rs7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myne8LuqDdibLpSF7gbKSnRqLGSWpOYrW3tAokIRvDM=;
 b=HKlG4gr0td8Q/JTXiIptAoLqDcTiRob9leqvpV1rps/VIrOa44uI/NKTJQf4ehB815ceA7wq3Hcq6myFmFZNIJ9CxWgwfKUqanCc6AYLzmSma5eVVoP1Yy1MC50LeiuJvl2vVHrmdFXxPWp1xXfsv1SmEUPnfD0WlWFnCwXOIjTyq/lsYUsKNTerCrO0Z7jCnjy0p44Exef8O1875Emd2f5YUNdKnsIFcU3Pe6tPm9Q4Tg5EkWgj5QUEV/kKIfMvBOIHm/Ok1VaU18F0qc6ossrBdvTYTgYFLt9nqvgbHcV7p6QmD5lHZRmga/NEbGdNO3cOlSrRzddFcssNZSnrjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myne8LuqDdibLpSF7gbKSnRqLGSWpOYrW3tAokIRvDM=;
 b=QMN5gkadXio7a4q26G/GbEnI7ZdxCJ4SEHKwMGHUzuETB6jlUiQ97Y2d+SNRNxGiPR2A04mnfLgK16LGiD18pFmVDLYLodNkIjEmcXehJoLeQS2e/wQ005zA6MryxPaWbt+zOf7O56/n/tyTS01DurK2wGyq+yQWuYTp/BtjxBOndxedIvpbdoVIyuO3QoTitHzRx42pldDZiSfBz34Dp5tuGIdWh62QdggbfKSm0X9NoanxNN3axsWyXq5TsdK4K0NrBAu7GZXV+J2bM410HyD34bhTPBwBf/LBzHFpWBr49uKDNYLs96xqWUJDL/3DjXdDvbMeyu0Ce9IMsPnZOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 00:09:38 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d%6]) with mapi id 15.20.5654.026; Fri, 30 Sep 2022
 00:09:38 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     jasowang@redhat.com, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH v3] virtio_pci: avoid to request intx irq if pin is zero
Date:   Fri, 30 Sep 2022 08:09:15 +0800
Message-Id: <20220930000915.548-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To TY2PR06MB3424.apcprd06.prod.outlook.com
 (2603:1096:404:104::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3424:EE_|SEZPR06MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: bd942ef5-a3f7-47d9-952d-08daa2781028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jjDMHdrHFj7VQ988mFo/Bl6DddpK3r7zfiidoMfKFwAWt9q12ixiUYE4gNYj4ClJhk7Qi2QgzCei/QTGqIDxU1+AFiRDW+JCdw7kEqC6km9rcjrfqa7s7UAzFrpF1ia+lbTR+qRsSgeDVBdcV1AVhY0S8TqHeCZWDklvk/VZ6ukTiHheER1WXc3v/SRbhTgGr/2GXcp1QC77Yexq18N6RTCm+Bq3QYgAeCP6inGL2sGuKqxvdM8rfWG3FoDd0xMmkrFJxnsOspd1C4R/LyxRllim01m4BZ6bAF/fyYTgMa1Kd2w0XICS+vvIzx9x9Rd6FwuFP3OWToTYjSLJ+v6Yb2t8tpA3moTbUsS2/sbA1z76Z/lugjH9Dflb2d/o7Rm2t+RhKYNvVnChgQl6QPp/XwpIxNpa3TiohOKy4rwXY4zAtd7GzA4ftkD3tBk0Lu1WYHWvQQVlffjsj8tvbNmr+E5OWMHfTHpowiGDY87IiSP3rVlSLHrfZKNgH7dW4CqKGR7DKYNyZo5j1VDpOnVSE6IjSaFyslMJ2Zbm5IxNeHAFwkQQcYRoz8erJR3cYZ4eWoHf8kiP5GHcND2Vav8t6PQ9UQOmb2Xgiczhb1B0DN6l6Cy/czuXG3j4HODtZUUjIxuVP0bAeddMZ4yVIzxCgL3t6LhypFOvaR/unVpse5RlLBuLsVsrTtZZ2hEkwZv16jiH+BcCP503wzF/vT7dSjl7UvD05u/4Iv9hE1zJPdUUnFXVs/mQg1hoQdPc12vAGrqbd0t37LQvdMiDw5GJnpKQCign5H+HmIFDspFFZmI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(136003)(39840400004)(376002)(451199015)(26005)(6512007)(186003)(5660300002)(1076003)(83380400001)(2616005)(44832011)(66476007)(66556008)(66946007)(6486002)(4326008)(2906002)(316002)(8676002)(478600001)(86362001)(107886003)(6666004)(38100700002)(8936002)(38350700002)(52116002)(36756003)(6506007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fh2Vqyt+1TPvogjABGg3Irq3676zg1UUXwiln7CY3vj/CuLSGMntv7JB4D1z?=
 =?us-ascii?Q?Pb7bzr6Ds2RqnBzx1tGsjkxMvq5dme187Xk0A93p0HmXiPwtIF69a0tnLEsU?=
 =?us-ascii?Q?lVtTYtVBMWtUll78K4mCMSGBRW6DyqclCYtd6Swr1uQ3QwFtnzBaD+pfh4d8?=
 =?us-ascii?Q?v2mMoAZ3Wk0vyiU0DoLvHS6tFIDJEj0g4vscuI4YWfAgvegDpytF2i86FN+Z?=
 =?us-ascii?Q?8cA3Gv+OMRQkeXMlmOV3qlGY58ePfopE2GzTJw7sQPJB9fqtzW4Is0yM17ly?=
 =?us-ascii?Q?RqmgKsXk8CF6vJrM8cEvpL9K3KTPGU/SIAwNrMTc6zdvZ4Yk2iS94GzinYyW?=
 =?us-ascii?Q?PlUKMWBM7yElCM8wFjCqCc3rE6oU7Yypy/HsgZaNLsH92TKp5icyjqwud+cM?=
 =?us-ascii?Q?tMNM/sq+OFaWNREdDX/XGSRURTyB1x7+FPFfm0XgETdWK35wRyqrNDIgjn8Q?=
 =?us-ascii?Q?BRQd+OTdFaBYQyI5+AoVaqqFLD5kfCsoe7WWleSpAVgeZ3OwbQhAyG9aBBjn?=
 =?us-ascii?Q?AptfCcebtQUM7oRh6qKtKHRqM4rz8o1Y8O463ZqT9diSAzK6scnVaMkuzneY?=
 =?us-ascii?Q?DQKahT9DrtTD8r2lG/WFPp+rTDsYHLcifNXtTD5aZtS6X/6iqwFFpGRtnR0B?=
 =?us-ascii?Q?CnrHeEaqG3OeDXGnyWWm5nBpdeaG+c72bE2eknWOIET5x/OFavDfTn6eJGrz?=
 =?us-ascii?Q?ol/i1rJehuRn4vOuu0nG3t1pJ5/UeNShJy9nxDcQZQWJjpcy/+Lu+N/wN0Nn?=
 =?us-ascii?Q?+U8Fln8mJLvJs+KevnldBxYEI+hrC/UOn0v3SEnSALe/znXi3xeAHYMKmZas?=
 =?us-ascii?Q?Iw8iHocln7ZCb0ezOvuZ6Z64PJtlNBKn9lLgaswNRMG5EgpnqA9EFf9gDDF8?=
 =?us-ascii?Q?Zd0dLxyj8dBmCJic272xV0/4azZn+S7qZQAktGj6mHMv0GQ2paDKLok6X9C7?=
 =?us-ascii?Q?nOXxrMb6APJzpS/Z2mu+MwrsujJ1OypEageXCsXcQx6po3EYoAdrhkyvaWqL?=
 =?us-ascii?Q?Q0VhUJqq9qb/NB05hBwTbOmZye71I2aSxuWS5kcTV72D8Yvc/RxTZufasKkN?=
 =?us-ascii?Q?iTQIbuDVeUaGWkk5xS2fW0QQ6Gav1igwlgkexvQ5OtaC2CaAx135+T6HQHLA?=
 =?us-ascii?Q?qprBDRAGjoGgZ0p3Vl25GgsmWsyBGnt6Nm+p4w6NZT+yOoDCwAS9THJpd5k+?=
 =?us-ascii?Q?bZHi55FOmwmfv/4F9nQJhJ1pOKgMtbiZuq+PEAT68a+knyA3jtzzcvH3Ziuz?=
 =?us-ascii?Q?8NJLog+xAdNbX32s1bFq64baqf3PTMTiDVI0rXBzgTc/wybldVhSsSYoc+r1?=
 =?us-ascii?Q?0/XFGLJNExodPJ7/dxdsFGoln78SvydSF+uurDldkn2/XMj/rLHrtbvs0Lpp?=
 =?us-ascii?Q?lNE51r6GuZ8sP28SXFbHuSFhwOP2WXK4fwgSCjidRIbI2tzlawj5SPaEeHeh?=
 =?us-ascii?Q?K8LrZR4TnlSE57uzi9UvRykrCVRLRIJp7wu6X0/tM5WgIZMPmR0FuKyZhCvS?=
 =?us-ascii?Q?Hhfz4jtCLpCGJZKtEg1kYTJdsFrBmiZ4JknOd6p1GMUmQwuW/FS+d3SHnwtc?=
 =?us-ascii?Q?cic3VO+uK03Oy10lFNFIoDLX3wR4Pmlp6VBF7Nn+OVjTxtJTiUmrx1vhqIJe?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd942ef5-a3f7-47d9-952d-08daa2781028
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 00:09:37.9404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i74g0Lqc74UW5PYW+NPk+3gqIHbwn38qw+WQUJ8LD/u8aW1RMP0IYDwoL2AIlH1T7bBj1q1EXRKLAgvKgn/LXGeyzclMQoNalQM36kDtldY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5624
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The background is that we use dpu in cloud computing,the arch is x86,80
cores.We will have a lots of virtio devices,like 512 or more.
When we probe about 200 virtio_blk devices,it will fail and
the stack is print as follows:

[25338.485128] virtio-pci 0000:b3:00.0: virtio_pci: leaving for legacy driver
[25338.496174] genirq: Flags mismatch irq 0. 00000080 (virtio418) vs. 00015a00 (timer)
[25338.503822] CPU: 20 PID: 5431 Comm: kworker/20:0 Kdump: loaded Tainted: G           OE    --------- -  - 4.18.0-305.30.1.el8.x86_64
[25338.516403] Hardware name: Inspur NF5280M5/YZMB-00882-10E, BIOS 4.1.21 08/25/2021
[25338.523881] Workqueue: events work_for_cpu_fn
[25338.528235] Call Trace:
[25338.530687]  dump_stack+0x5c/0x80
[25338.534000]  __setup_irq.cold.53+0x7c/0xd3
[25338.538098]  request_threaded_irq+0xf5/0x160
[25338.542371]  vp_find_vqs+0xc7/0x190
[25338.545866]  init_vq+0x17c/0x2e0 [virtio_blk]
[25338.550223]  ? ncpus_cmp_func+0x10/0x10
[25338.554061]  virtblk_probe+0xe6/0x8a0 [virtio_blk]
[25338.558846]  virtio_dev_probe+0x158/0x1f0
[25338.562861]  really_probe+0x255/0x4a0
[25338.566524]  ? __driver_attach_async_helper+0x90/0x90
[25338.571567]  driver_probe_device+0x49/0xc0
[25338.575660]  bus_for_each_drv+0x79/0xc0
[25338.579499]  __device_attach+0xdc/0x160
[25338.583337]  bus_probe_device+0x9d/0xb0
[25338.587167]  device_add+0x418/0x780
[25338.590654]  register_virtio_device+0x9e/0xe0
[25338.595011]  virtio_pci_probe+0xb3/0x140
[25338.598941]  local_pci_probe+0x41/0x90
[25338.602689]  work_for_cpu_fn+0x16/0x20
[25338.606443]  process_one_work+0x1a7/0x360
[25338.610456]  ? create_worker+0x1a0/0x1a0
[25338.614381]  worker_thread+0x1cf/0x390
[25338.618132]  ? create_worker+0x1a0/0x1a0
[25338.622051]  kthread+0x116/0x130
[25338.625283]  ? kthread_flush_work_fn+0x10/0x10
[25338.629731]  ret_from_fork+0x1f/0x40
[25338.633395] virtio_blk: probe of virtio418 failed with error -16

The log :
"genirq: Flags mismatch irq 0. 00000080 (virtio418) vs. 00015a00 (timer)"
was print because of the irq 0 is used by timer exclusive,and when
vp_find_vqs call vp_find_vqs_msix and return false twice for
whatever reason,then it will call vp_find_vqs_intx for the last try.
Because vp_dev->pci_dev->irq is zero,so it will be request irq 0 with
flag IRQF_SHARED,we will get a backtrace like above.

According to PCI spec about "Interrupt Pin" Register (Offset 3Dh):
"The Interrupt Pin register is a read-only register that identifies the
 legacy interrupt Message(s) the Function uses. Valid values are 01h, 02h,
 03h, and 04h that map to legacy interrupt Messages for INTA,
 INTB, INTC, and INTD respectively. A value of 00h indicates that the
 Function uses no legacy interrupt Message(s)."

So if vp_dev->pci_dev->pin is zero, we should not request legacy
interrupt.

Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
---
v3:
- add quotes of PCI spec
- Move the judgment from vp_find_vqs_intx to vp_find_vqs

v2:
- Decide whether to request an intx interrupt by pin instead of irq
- suggested by mst

v1:https://lore.kernel.org/virtualization/20220928000228-mutt-send-email-mst@kernel.org/T/#u

 drivers/virtio/virtio_pci_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index ad258a9d3b9f..44a839127f2b 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -409,6 +409,9 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx, desc);
 	if (!err)
 		return 0;
+	/* Is there an interrupt pin? If not give up. */
+	if (!(to_vp_device(vdev)->pci_dev->pin))
+		return err;
 	/* Finally fall back to regular interrupts. */
 	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
 }
-- 
2.17.1

