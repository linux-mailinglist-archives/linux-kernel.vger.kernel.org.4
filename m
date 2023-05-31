Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5115F718866
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjEaRXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjEaRX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:23:28 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656A2184;
        Wed, 31 May 2023 10:23:24 -0700 (PDT)
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VETBII004420;
        Wed, 31 May 2023 10:22:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : subject
 : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=proofpoint20171006;
 bh=fZ6QBXUZuT8or+Pu2R9R5wzkgXTRcQrjTtO7/5vKXLY=;
 b=kQqhQz0xHjLi0Qh2qeiaU356MN830HxX0UN4Qgih4bFCVVPHJMMCR41zRkPU33y40xM4
 pU2iCxJ32LL/4lNmgYzAA5IaQuWC+p0+vERPx6eZaTqRS9T9wU3BM9aBggnxAsJq8Jk/
 JB4jbDwy3Vs446mQ2KnLHRPGZUQAgE/rS0nZnjlXdgIRn55DrQGBQtixaSalrHe3NGGi
 unNbSrrk47GWnSS8eeADsQ5Zy5Bzx6n7MyaAmzGWjieb9lJNtfEXfbNPs+jmCzmZKnvR
 mNWVuvs/8me1UBpoNTp2ii8SuPj+QS1i1MpwA8yV9sRpuV770QSkuCcM7URGEN1uZNkb nw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qufyfagsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 10:22:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ev2uPoPBwG6y37ypWpajc5tjk/nVpHX4xCMQeM/8iKTIi5s710jQ+zJ0/m4WdUPhGNYSNTN/Xv9X47AldCoQJfLDkZcy7iQQLUkyq9JyYfF2+zsrnoXFB81A4U/st/uZRlkj6BL0RWZfrxk4R2hmiCFyCLQQls6D9u++Jn4pkVVLBUe3j54yQjUdx5QXUSqxlbCfeFDZh05iAxoKbfYK3QfQhzC/LPW58d7lfPyJaHO997dkEf/jfQTJuMu+T99yJwfLufHHy2dRLLnqeu+qNDt/iMlCKTUv+oXsym+S5hYKwmPMduFvuMVkSLch4NKFpHfR/YORe6k7pl3ketrmYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZ6QBXUZuT8or+Pu2R9R5wzkgXTRcQrjTtO7/5vKXLY=;
 b=aceK457oGlohfSmHgDnEEvd7LGqzNndXr9nEWfGtKfvhFLCli5/a/5MgimIYiFoHh7GeluI43LLrluAnMRI0htqM+B4bLkgu+pMusndWnojZJNGnPKD0bZctNK4k6umT8a7lv/ETOrANxkTFLCMyQlB1E9ebsg6L6AyUFJktLKUYqXYbiDooOJbsAXjAbVJuz5L9fm0u8MM5CqBAnejnajW4Z39E1xUI3PXgt4Idglkn5809KUKknneWLwmaIPvc7RX5EpYDBhGBRZFw9yE3d43EKkqWUptrzQy80Jz6QkwA0M/t08tqhZoIorXQQf3qODoQIrv1ROLKHrkzJ6ox6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ6QBXUZuT8or+Pu2R9R5wzkgXTRcQrjTtO7/5vKXLY=;
 b=EAyPnyCwPijfdPRyWY+nvLESzXQJ+DErZ4Fit4P35KPwLNnpv/85fjF2Kv9sPooo9O/GNN7AvAAHQhKWKdX6yVJOtNgwZaESXriz8Tk4bUu/hOwiqjsRSuJFTq4KIki1qQ1NabM4TwwUIzB9i+Qlz208A/5THfxJBiJ3/96ve7E/FF5xc9isOubu4Fu24iaKD+l++CKddHAIWx1JYJXplyKVrbqISKxMRZqEk8NQOxrBBMnCe/A1Of9b4uVn1m7xUQeQji9WJkxTZhogsQqYlhY0eFnUAuC6YoRtdNshMBiILWREzLbGM/dtP8hyKa3DDcUNI+8gbdo67Gs/obcB8A==
Received: from BL0PR02MB4579.namprd02.prod.outlook.com (2603:10b6:208:4b::10)
 by IA1PR02MB8898.namprd02.prod.outlook.com (2603:10b6:208:38a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 17:22:15 +0000
Received: from BL0PR02MB4579.namprd02.prod.outlook.com
 ([fe80::b138:ab35:d489:67f]) by BL0PR02MB4579.namprd02.prod.outlook.com
 ([fe80::b138:ab35:d489:67f%4]) with mapi id 15.20.6433.024; Wed, 31 May 2023
 17:22:15 +0000
From:   Jon Kohler <jon@nutanix.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Richard Gobert <richardbgobert@gmail.com>,
        Menglong Dong <imagedong@tencent.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Guillaume Nault <gnault@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>,
        Qingqing Yang <qingqing.yang@broadcom.com>,
        Daniel Xu <dxu@dxuuu.xyz>, Felix Fietkau <nbd@nbd.name>,
        Jon Kohler <jon@nutanix.com>,
        Ludovic Cintrat <ludovic.cintrat@gatewatcher.com>,
        Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] flow_dissector: introduce skb_get_hash_symmetric()
Date:   Wed, 31 May 2023 13:21:57 -0400
Message-Id: <20230531172158.90406-1-jon@nutanix.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0185.namprd05.prod.outlook.com
 (2603:10b6:a03:330::10) To BL0PR02MB4579.namprd02.prod.outlook.com
 (2603:10b6:208:4b::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR02MB4579:EE_|IA1PR02MB8898:EE_
X-MS-Office365-Filtering-Correlation-Id: 34888dc4-565c-4b35-8a78-08db61fb9436
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jk0pYt+RXlDWN4qj/VMOxd/eJwytOtOOUqTtJQs+BXPaZhC28cciwLbR354t/9xh1/r0/WZ1QOX9P/DEaMlxyXEZLLQ4fpBem5BiI2KWuPKtjAYVgYSuRFkm6dG9uxzemq+aEW31riWuczd+5RxGPvZn2+m0ActaOCedDgaVKYS39WcpGuJcQkq0TvR0psNxqTX7CCnA70F9LHD58W9ME82xkW88ymhaPkbNM0E0cKTCRQO7jZbBsN/1zfYlEzxtDZpBTagWJY4ey+FfnAA9lj2YLjnio+LSTCoL01KOEzgTn67z8pTLGc+Z6OoRBsuIPLrUu2/Ndsnh2Ws/n9YS593Stih83PLSUF27rXLR+E3/0MmbebKWhoj0eU1lHVcCkJ2XkDQVMIf2+UAdVb+pdAUKTvbNxMavcTNkHXx4uz6DbjJ4NC6tcLIIgiREYNJCMcYzRPs71NTHulEQHkZpj4Qiqd7gcx6nTkxWhIDW8Oq244lUYLAl7lwrfj1fWUgSSDIU4COgwd3rLGuKNn1ZhazLZRUTizRprw6fFZMuIbzHXPLihG7gZrlgCSpkmblp5z9OzXvWITGSVykcxgWXlK9wau6F+D5H1xAafxpJQiw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4579.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(38100700002)(41300700001)(316002)(6512007)(6666004)(921005)(8676002)(6486002)(2906002)(8936002)(86362001)(52116002)(7416002)(66556008)(66946007)(2616005)(66476007)(36756003)(110136005)(6506007)(1076003)(83380400001)(478600001)(5660300002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cOvoeR3B4wb/5MZQUPvp1jt0fssi6jq6afmfjPMeqFt4d93NQ8aC6GvDia1s?=
 =?us-ascii?Q?9S35i/qK96YiEk4rncl/c/XdeO8nn8Db7nq+FpK4GAYtEkkUYZQtt6n4hRdQ?=
 =?us-ascii?Q?3feDjfuRv0Zx5fvGwE137x2R3dEPoI+Ky0X9Etz9HoTxK8MGeM7VUlRkUnuQ?=
 =?us-ascii?Q?bI4JZ62K7VbPubos2qZ4H9oTleFofy20FA/s2D9FQe1otZ6BMV1KeAxeQ/ZS?=
 =?us-ascii?Q?MeMhBLVmOd7JRgR9fMNXbAfHScEkRff2cNWBnsnC28yU9Ct29aVDzh8nJtTb?=
 =?us-ascii?Q?gsWR4RLaTrErWv2UPPe8wVmZC3Shmz+wlOY8fQPIjWtZNBsSTVTVvgjN4jUV?=
 =?us-ascii?Q?lB47RwBwEFdbwGy7xbahTUG+Mj9mIbXYJDxnP2/g7NsX9Fte/o2meVSgv4A6?=
 =?us-ascii?Q?RRqaJqY41njHylbh5UM0EK0EzHpcfPdMC3GbTKfwi8J5k7zLzRWTHzUCk/aL?=
 =?us-ascii?Q?YOsY6ySYN0D9JuVysQkI8Hx4QXx8Bn7lA7uoPVJlYKojwROMaV6svRMjELCE?=
 =?us-ascii?Q?2rHxmFggv6Z7MOKBmAzYdLEaZWsYUX7EC/viojgdMy0SlgfO0K8EYZyFLrWk?=
 =?us-ascii?Q?KDhQ70AJouW+fE1LCveBKlx0L1TUGandrx+1FWWGUVrlAmekN7YKpu0b3G3N?=
 =?us-ascii?Q?NYzMEKL+A9BDa5f0fReVFW3dDo58weY/JDmjZX34+7FcTdMjMaHSMasyXNQq?=
 =?us-ascii?Q?w7PA+RHbrk/jzhKpT86KfsCHZKjnBGGl2Z+vuUhJ8j05+lvl5WfgY6b/XQbM?=
 =?us-ascii?Q?yqXiq+DFM9cADO1zo0hFtpl5kCGp6fPmjz/5x8mqaZDjqo1fQ6GIuWOn4sQ5?=
 =?us-ascii?Q?A9JF0mVx+ZIOP2T75ihQMwFuOPsaLAvg5wm3r+WdYPlKoZur9E557hZ7purI?=
 =?us-ascii?Q?VvSAU8MhTlqUpiwfcrZ8tm5U9mptl1SlL8n9T7WaCxDxjiMue20h/IQyjBjB?=
 =?us-ascii?Q?E18A6y4970R4kgX43pXCzAvUV3mUhBx7jD+1awMpFFBdvQm0XUI0Smn9e/2s?=
 =?us-ascii?Q?ggrpuf2h/MokyYJqug1XVgssEIogq5t7ffioCXNR6v+4lXaG80jmEjjDdoU3?=
 =?us-ascii?Q?9X/n6gRaboXYbsNJn+5u/oN3w0RwZMXBc8k9m3+ffwFherhM5HqtmiX//5BU?=
 =?us-ascii?Q?BBCMHjSJYC+pz8iNF165BnpUienuXz+IlNvpcZ790VOBo98adb+mHQvTBqdY?=
 =?us-ascii?Q?KbnSgNnfPi9Ln4acQbFlmaWIVGlqqjWd4SWvE9DypCJgJVbZqOoL8sDy8zN4?=
 =?us-ascii?Q?sTfv2D3xDFBs1auadjdkVfcQBjtPKXLOqoq6YB3OARalfEIE5qumVCRFzgKg?=
 =?us-ascii?Q?9OiuuPaUWFMT0SOs3+dkuyIQMY1Sv7SU5NzHPaDWKGe7wxTDGIFFAMBEJM2V?=
 =?us-ascii?Q?39Sf5lp1ObGF/VzsCLBMWvhmLE7MkVVgSlngcJ+mLRODxOxDgI5MeFlpUV8p?=
 =?us-ascii?Q?hZwnvh9UA4Oh4y0ITc62ahjb6++u544MXUQPmoQY/BEFrIPreLB62O+jEi9e?=
 =?us-ascii?Q?0WBpjvuZoJ2YwDxI4zZd4nQPXr8UR7UJll4QqotVj2pkHy/Z6RPvulBoCLzy?=
 =?us-ascii?Q?+2YW2rLf+gcOPfI6uCalISx1Y1zATZ+aoA9+1Nxc215xSYJlCFx4CsoCqoKH?=
 =?us-ascii?Q?KspcTdS0syMgP2Wxntq/PRMiqY12rWYVMRFJEzcdRW4/N+aNME3LG3sgI7AH?=
 =?us-ascii?Q?p+G3mQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34888dc4-565c-4b35-8a78-08db61fb9436
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4579.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 17:22:15.7639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zFXFh9poK/8+xcM2kgrT6MRqtMP/439HVNi2gv03p1dUNCj6H0EiklucTCDNTt1fMv3nRaGBB46XjuQGgpNZ/VKpTosKiWQm7QfxOj8ILM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB8898
X-Proofpoint-GUID: S9fN7LPCh--hPtvpBswqdCaEoeyYWdXb
X-Proofpoint-ORIG-GUID: S9fN7LPCh--hPtvpBswqdCaEoeyYWdXb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_12,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tun.c changed from skb_get_hash() to __skb_get_hash_symmetric() on
commit feec084a7cf4 ("tun: use symmetric hash"), which exposes an
overhead for OVS datapath, where ovs_dp_process_packet() has to
calculate the hash again because __skb_get_hash_symmetric() does not
retain the hash that it calculates.

Introduce skb_get_hash_symmetric(), which will get and save the hash
in one go, so that calcuation work does not go to waste, and plumb it
into tun.c.

Fixes: feec084a7cf4 ("tun: use symmetric hash")
Signed-off-by: Jon Kohler <jon@nutanix.com>
CC: Jason Wang <jasowang@redhat.com>
CC: David S. Miller <davem@davemloft.net>
---
 drivers/net/tun.c         |  8 ++++----
 include/linux/skbuff.h    |  1 +
 net/core/flow_dissector.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index d75456adc62a..27e9be434593 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -528,7 +528,7 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)

 	numqueues = READ_ONCE(tun->numqueues);

-	txq = __skb_get_hash_symmetric(skb);
+	txq = skb_get_hash_symmetric(skb);
 	e = tun_flow_find(&tun->flows[tun_hashfn(txq)], txq);
 	if (e) {
 		tun_flow_save_rps_rxhash(e, txq);
@@ -1046,7 +1046,7 @@ static void tun_automq_xmit(struct tun_struct *tun, struct sk_buff *skb)
 		struct tun_flow_entry *e;
 		__u32 rxhash;

-		rxhash = __skb_get_hash_symmetric(skb);
+		rxhash = skb_get_hash_symmetric(skb);
 		e = tun_flow_find(&tun->flows[tun_hashfn(rxhash)], rxhash);
 		if (e)
 			tun_flow_save_rps_rxhash(e, rxhash);
@@ -1933,7 +1933,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	 */
 	if (!rcu_access_pointer(tun->steering_prog) && tun->numqueues > 1 &&
 	    !tfile->detached)
-		rxhash = __skb_get_hash_symmetric(skb);
+		rxhash = skb_get_hash_symmetric(skb);

 	rcu_read_lock();
 	if (unlikely(!(tun->dev->flags & IFF_UP))) {
@@ -2515,7 +2515,7 @@ static int tun_xdp_one(struct tun_struct *tun,

 	if (!rcu_dereference(tun->steering_prog) && tun->numqueues > 1 &&
 	    !tfile->detached)
-		rxhash = __skb_get_hash_symmetric(skb);
+		rxhash = skb_get_hash_symmetric(skb);

 	if (tfile->napi_enabled) {
 		queue = &tfile->sk.sk_write_queue;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0b40417457cd..8112b1ab5735 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1474,6 +1474,7 @@ __skb_set_sw_hash(struct sk_buff *skb, __u32 hash, bool is_l4)

 void __skb_get_hash(struct sk_buff *skb);
 u32 __skb_get_hash_symmetric(const struct sk_buff *skb);
+u32 skb_get_hash_symmetric(struct sk_buff *skb);
 u32 skb_get_poff(const struct sk_buff *skb);
 u32 __skb_get_poff(const struct sk_buff *skb, const void *data,
 		   const struct flow_keys_basic *keys, int hlen);
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 25fb0bbc310f..d8c0e804bbfe 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1747,6 +1747,35 @@ u32 __skb_get_hash_symmetric(const struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(__skb_get_hash_symmetric);

+/**
+ * skb_get_hash_symmetric: calculate and set a flow hash in @skb, using
+ * flow_keys_dissector_symmetric.
+ * @skb: sk_buff to calculate flow hash from
+ *
+ * This function is similar to __skb_get_hash_symmetric except that it
+ * retains the hash within the skb, such that it can be reused without
+ * being recalculated later.
+ */
+u32 skb_get_hash_symmetric(struct sk_buff *skb)
+{
+	struct flow_keys keys;
+	u32 hash;
+
+	__flow_hash_secret_init();
+
+	memset(&keys, 0, sizeof(keys));
+	__skb_flow_dissect(NULL, skb, &flow_keys_dissector_symmetric,
+			   &keys, NULL, 0, 0, 0,
+			   FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
+
+	hash = __flow_hash_from_keys(&keys, &hashrnd);
+
+	__skb_set_sw_hash(skb, hash, flow_keys_have_l4(&keys));
+
+	return hash;
+}
+EXPORT_SYMBOL_GPL(skb_get_hash_symmetric);
+
 /**
  * __skb_get_hash: calculate a flow hash
  * @skb: sk_buff to calculate flow hash from
--
2.30.1 (Apple Git-130)

