Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7396DBC4F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 19:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjDHRWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 13:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjDHRWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 13:22:52 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2072.outbound.protection.outlook.com [40.92.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ABE9E
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 10:22:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0GLCbW9EXsXAtQfYEcDikb4IGVBx2TEoTj/YLvfBbZjNkyB/NHj2dK5ekGqGU474Wk6KUa1KdX3L4bPuYAyx6BaydVsVWALBaz3yogUHtI5CEmK9nbQWk9zlDHdjcnk/nNcycCC0DoiMFodKlFdJvzxXkjLvHgUjmOWD8ofekkWkXst+t2dcRxDzf0WZJHxw+6iqlO8UE51796pRwgfHFZFSKVlzsDYlGlzlppsptraxbxTxmxm8wIXRqOwCqbHB9v+M5lnz9ACGk9ChiHi3aQ5teXVdJTTAnfenYfj3De3a7B1MNNriulEUnsbjJVG6WKt4VhidvFfUAo/5/RfcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DP4Fg2jkIfFg6NiNE0cT4+9MIQM5T93t14HLRawuFag=;
 b=m401aF9Y/wUDsRLGFGa0fMztXzZ7jaoQamPR9yWPK8d650REqolp/GxmNcITUb0nvYhx8Bk0my2J93oOgrv4GtRU+h4/8p4t19WEo35tiNuG7bGIUCnwtvLEHxte5KMaY1pgeEU6yEI45Lzhi5/sv4/2ltJcPrksEMDlTTmjtMoPxyZu39Y7bq8w22oWdi5Y2qCm/5bruSSnApovnR0ZDB4L9e5Z0PEnLhowkbaaV9+55aV3OdXnHNpRVDf+XDtmheVQcZv0nXqGhmXIuUArRJ4++B6N8lGh0eFDPlDGX+yYC1DO23ubUQRFD2udMP3+C+CeboBosGBqZ47jFoDgYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DP4Fg2jkIfFg6NiNE0cT4+9MIQM5T93t14HLRawuFag=;
 b=fjrh9U7PbmBwDqf3adBJzodmXAcbiWAZGVK7xPMOQbSEHtrl506mGbtyC4zzoi8wF5Y3kHd2pCbxx5wjlPSLI+lWraQt+GawEezASWp8rgy3u4ohxVvfX68JOzz91fk01FxAbbOmljJ/6nfmaiq21rmwKMsyxUvWvwR3DHsHCeSrOWKEmc0UZU8SQlhmtV8p8h24zTEwsZRP1G0hgI5FWBd5Tah3IvcfCuceczuYKbkb6Xc3IifMRehB5dpO92b8cE+6Vcyv4a4qS4/S3ExQslwrV9EJd34XoHQW5Q6E7Mc2R+EeCYuNZZKKg2g3OY01OA052jcCLB69tESYajQsmg==
Received: from CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10)
 by DM4PR12MB5295.namprd12.prod.outlook.com (2603:10b6:5:39f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Sat, 8 Apr
 2023 17:22:49 +0000
Received: from CY5PR12MB6455.namprd12.prod.outlook.com
 ([fe80::a7e6:2d7e:5efe:229c]) by CY5PR12MB6455.namprd12.prod.outlook.com
 ([fe80::a7e6:2d7e:5efe:229c%6]) with mapi id 15.20.6156.023; Sat, 8 Apr 2023
 17:22:49 +0000
From:   mirimmad@outlook.com
Cc:     skhan@linuxfoundation.org, Immad Mir <mirimmad17@gmail.com>,
        syzbot+14a2433710a3affee84e@syzkaller.appspotmail.com,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev (open list:NTFS3 FILESYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] FS NTFS3: Fix shift-out-of-bounds in attr_set_size
Date:   Sat,  8 Apr 2023 22:52:26 +0530
Message-ID: <CY5PR12MB645583E34E10D7FD71B3D548C6979@CY5PR12MB6455.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <0000000000007301c505f86e3072@google.com>
References: <0000000000007301c505f86e3072@google.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [X6NHLy95vUN60DEYctdTmywj3QIZR8rM9o/CgBl/6npP8OsxVo9bcW71Q43p/g32]
X-ClientProxiedBy: BM1P287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::25) To CY5PR12MB6455.namprd12.prod.outlook.com
 (2603:10b6:930:35::10)
X-Microsoft-Original-Message-ID: <20230408172226.9599-1-mirimmad@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6455:EE_|DM4PR12MB5295:EE_
X-MS-Office365-Filtering-Correlation-Id: beb4a7dc-d4d6-455e-ae4b-08db3855e08b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 45NJiiyjlSOa06YLpmV+IH8tEh5u/d8J1DGw8xM3OcdAk50nRPB2OlxAZu76rjXndw150k2yxYT1tIosu/zQd4FkmElZFWBaYKqyg142X3WMtaH3zs0aJgR2deEPLUX9SY8jyeFputpNQRZap6xoCRLr6Z/UTYGV7oHakA+cj9EBCRR+D0eDqupQ2V2KxhqnQNH5uZiFJoUqhgve8mk4WClbYozJ+HpGXijeuy3Yo8puo8lpenl0osU9D+pmuKBK5fjBhkKB3i63FSyIKTzsuavy337XcXG1kZexRMq/bwar1WOGCP4FGtFw3F1Q0tJmOmjgFDqsMTKbY+VfFcQvQ4OkXpAJbHHWt5+xYWlcXam4VxmuGzR4O1RHwtUskR5sspRqL/SV6/dAKr7bY1ralP+a2+oBc5+ALqIH+yqLlA7z892Nav5YJI1Mv4JcQF+wBnmLCpbX3yhgiQ5LvrWK57R9BgzlAeQ1J7YgDUfS1G2He9inHMBPpLWdnnP67iKrdEW7x8+Y+rrB1oeDpHIOxAEu1Jwi9s+RCX2kIO+OjIw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J6qU7UkzPW90brS1xdDXexMlYV3dxz+DSdXd6rzUdLza/gh0pLHxnM0KIqmy?=
 =?us-ascii?Q?kLfQWxlNnogoTrDCPix6iUCvcpKhKKPPNQwgloWC/IGX5l9rhqSWoeP+hj8Q?=
 =?us-ascii?Q?7Mz3FQQW0zeoSqyKLEJ5nArF3FO14BSVavPRNR0PvWsn0xky87h1GyHHAHXG?=
 =?us-ascii?Q?Zpd1bqPdCwfrwLaKmKvR6K6xTuWYAM3U/JrTlo9mcbQvOgSdUJr0+qpoD3bC?=
 =?us-ascii?Q?XWLhemBMlviWvD6rElwnSxRrxxkjyMQm9PxGiSOVw2+XG1eLh8FrHSAGZ7mr?=
 =?us-ascii?Q?OiclOPlwei6E8Mq8mkEu9BvQD9MpfE2YWwHaoHG3rjaeABtNaeF/lGW7JtvP?=
 =?us-ascii?Q?GFXOpng8bwBIyoArQQvBeSAizGlpaWyRYvvyOiVGmnlCOwkklsuo9jo+SmSY?=
 =?us-ascii?Q?hb3QkpYzvUo34Ad+rXj/p5uygcyzYoEqxxxZe8TK5kKza80f2HbH+Viz7nW7?=
 =?us-ascii?Q?M5nrd3VmgJw5/ck6szc8esfOTOHDO656nfUIW0iX59dHnP+gR0j/ywmzw2re?=
 =?us-ascii?Q?a/qtTlgtSdW+OvSwURyxdtjWXdaIdUFDMLaQCW+f54GpbooPuH3Yne8B/QJf?=
 =?us-ascii?Q?RsVAzMAkZlNbkHkr8an7ilHeonV7ckviMvO5JAkeAOv8pYpYaczQwPNaC4ti?=
 =?us-ascii?Q?v6INogpvKoyKvibLmxugHqYe74T9u+Imb1ZqW7lGLKnMh9Mdm7fAo3yhFNgi?=
 =?us-ascii?Q?xcIkKf+vHKjSMG88Z0OTdiqJtp/srZ+IRQBRmnqy5VEtnou6c4EDQYAbhG9P?=
 =?us-ascii?Q?LK9nOKi8D8D4Al9+pEoTayDEYyVsT6nq0lQBYKfYdyjcI+zbTr3ipQfw9gFq?=
 =?us-ascii?Q?nvrF+hkZsiVEiz37W2MdgIOrGJdot09/jKSWNlB5e96OUioseiQlQVeXEX7C?=
 =?us-ascii?Q?xUsqoCRLJ+T/VLvLPptf7gpNVuWexNOqMmXtgqnS/DgHEqGVOjcua6WZ16YA?=
 =?us-ascii?Q?HNQCx0uzUsUsR8PJRWJEmY7LBm5xIyV4AO3T+E3uknoVOJLX7yaLIJc07kZv?=
 =?us-ascii?Q?eTpw8uWpmXi6sGPpE9UOf0nc6SSJzhehmm4XwcQxL/4gagjxj0HiUhBsB2ts?=
 =?us-ascii?Q?eNMfaMdVyB6VKP5SIqAAB6A8zVGbvksPD8uyMmQY2bTuzwV+BZ/Tko2lzszg?=
 =?us-ascii?Q?pqyQSHhD1XHIFdKu6Hj3UL2clQr6cB6lTlxa1856cV/HgamWwuGOAbvNXoZ/?=
 =?us-ascii?Q?4+2llI6Ed+4RU9DheJatNHPyuaxchnuG+AVFUHI3GBRrW0T0MDNQzMcu7/w0?=
 =?us-ascii?Q?RmPqI/dsmmfSHz3yebdzeGxFG7yUKWy6PEYStGX1/A=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb4a7dc-d4d6-455e-ae4b-08db3855e08b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6455.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2023 17:22:49.8838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5295
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Immad Mir <mirimmad17@gmail.com>

The bug can be fixed by changing type of 'align'
from u32 to u64

Reported-by: syzbot+14a2433710a3affee84e@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=14a2433710a3affee84e
Signed-off-by: Immad Mir <mirimmad17@gmail.com>
---
 fs/ntfs3/attrib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 5e6bafb10..c306aa087 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -415,7 +415,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	CLST next_svcn, pre_alloc = -1, done = 0;
 	bool is_ext, is_bad = false;
 	bool dirty = false;
-	u32 align;
+	u64 align;
 	struct MFT_REC *rec;

 again:
--
2.40.0

