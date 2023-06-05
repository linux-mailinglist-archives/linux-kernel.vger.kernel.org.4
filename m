Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DF47231E9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 23:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjFEVGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 17:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjFEVGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:06:53 -0400
X-Greylist: delayed 2069 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Jun 2023 14:06:52 PDT
Received: from mx0b-00010702.pphosted.com (mx0b-00010702.pphosted.com [148.163.158.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C8EED
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 14:06:52 -0700 (PDT)
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355EsYuY004989;
        Mon, 5 Jun 2023 15:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS11062020;
 bh=DOwu1+gZ8vxDq2j/wAavKJawBvXDny5D/yRgn1j4qfo=;
 b=LQQLKNEhIFiBYcxqEp9W8UL/cqVqb9Nvej49V6qGXakgW93alRcrdXrH9PFsNyPszZLn
 nVBi02UuNnbpCO/zwFEteVufxiROlWNBHeJ+6jZgSbcDJ4naUYUCUG65oDsuYh935lvf
 RnnURsh9Klsm9XSSKKhKujshrp1SDgfG3m/UPdHxTmUMUCxPLV1JDoqVrY/PJG86rnab
 7VVHnC3od1E6GBC4DdWLeVdRx2HBzG3A2PcYf/Cch4z/MrUJ91fmdx29NJYGHQWOH03u
 fPsgxNb/KsACBqTVyfKY/5l2maqWLPf0pDygaEJiEJ3FP1A4pGdHLXzLn9A3u6jIi8Mb Xw== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
        by mx0b-00010702.pphosted.com (PPS) with ESMTPS id 3r03b5uhpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 15:32:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdjN/wIBwW2Fjcek3olhOP8DmepdwJNPfk+wMq/34F17qKS+EGPFBnXpcxaXlX6N+2+m+iWCWFykTI1FButStbbN4gn/VoO0F9w7IecIvN4pNLi+HqiwdE+OkLzNRORGYEgzS+TlDdIx/N38I6Zdxa6tcTTqvjW70DUexQW2Tdar8OZWPOHXVhUIChu9NQl9WwsC/EPTFSJE8hvOZ7CemyBcQ6uaqvWmUTZFnm+/s00frchrxs31MrgD7PuhdvVyf73d4F1mb9hTQw0lvdE2cicOJlXocREliEJaktPK99shlax/exA8D+2u8ijzlh1jYgvIzpOiB2z3CBdZrcqgew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOwu1+gZ8vxDq2j/wAavKJawBvXDny5D/yRgn1j4qfo=;
 b=gVtj/zpfXN4vXc42kbBiFN14roE293/2EZkLUdiYY21G4+jlsbKFGFmH0A3XBtgmBfNo4GM7EtpKlbBRPgk07XRueLi0wb/0092sjQvJvfMh0N1JKG11nPmBa3REI+nObSE7wAF6/PjWRBrM/vT5bf5r/5Fpaa4+Aq5XPG2562Hm268/O5eXfi/Nn3qFnH3OKcprO/oOzLhXLXMz5h7GwEQvvK81RBpPwam8yMOBOfRrWDX/KeBKXGFK2EPZCMPZNZU7G1uQRht44tlpW64qWpdI4kmtWzd4asp088jxCi1h9CmEO3/7plfDObC75+L3nmns6D+nw7/FeTJSc7gvEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOwu1+gZ8vxDq2j/wAavKJawBvXDny5D/yRgn1j4qfo=;
 b=YPQnICyPywUEkzgES8E2m+IIfR8Px6ery7g5VhQryZxnk05Oyt8l3EmxpbZDpXBvEMULs2DxDh/cb7T/mFzbyiqbgkbLzr6tzrv/Jn3zG2MMD86TeJmBbdEC/EmSSB3BWDAj8V/ttncVpcP3bRwiukZlrqSTrt3tkKuT1EsWw+4=
Received: from SN6PR04MB4879.namprd04.prod.outlook.com (2603:10b6:805:9b::29)
 by BY5PR04MB6326.namprd04.prod.outlook.com (2603:10b6:a03:1ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 20:32:17 +0000
Received: from SN6PR04MB4879.namprd04.prod.outlook.com
 ([fe80::f64d:f407:7c9c:4af0]) by SN6PR04MB4879.namprd04.prod.outlook.com
 ([fe80::f64d:f407:7c9c:4af0%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 20:32:17 +0000
From:   Charlie Johnston <charlie.johnston@ni.com>
To:     giometti@enneenne.com
Cc:     linux-kernel@vger.kernel.org, brenda.streiff@ni.com,
        Charlie Johnston <charlie.johnston@ni.com>
Subject: [RFC PATCH] pps: Increase PPS_MAX_SOURCES value.
Date:   Mon,  5 Jun 2023 15:31:47 -0500
Message-Id: <20230605203147.694716-1-charlie.johnston@ni.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR2101CA0009.namprd21.prod.outlook.com
 (2603:10b6:805:106::19) To SN6PR04MB4879.namprd04.prod.outlook.com
 (2603:10b6:805:9b::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4879:EE_|BY5PR04MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ba1744-f25d-4b6a-6a61-08db6603f463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PiAS9JbTJHzQNj84WZuSTW+QeNQRbj3X0yU3gUNRsBZ6jaTo/0zjOhfBXDZMtj3H05MSoFzzbwFK5kFCbybZLzDAV7s1Sd/vMi5jYkTI/Kuu+4hKprIss+H0Gqrk0gUawp/5FHwXVeyBY1n33ur+PzssXzpzpB9puFpczTf/wl7Prt5l72JKlmevohnWZ3t3t0yL8o1ii8y/Du8N4/SL/5azZpraV3tkbRksKJ6pBG3y+HG9ljb0BILk3m75mNSE0O4ZFZhKfRIffH2xqacg4zDeYsU+fNZd4946bgsvpwWaS/ddpN6xXaPyXU1RiZyAFF01l7PZdzQVvJn7j95aRuf9DDgJQvYjpjKo31nKR/v/U2ejXf/ZUqsZMKYlF2mYcqGpuGeJT3U5BvvD/urfDeI9qINbFrNbzSjgFqAxqrKgwFkYO2yv+K/0D7a+ECfwAdU8tBHdU6/N+ztBjiJdSrBTlw5MXWsCygRK8JsgfII73g6KbAWxT38euykSUkYTtOHMKBuN4H14eVY8Fsqgvs8K35BIz6cPnrIKQ6/gRCxCnAS0LDxU4dtTS60VZnOu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4879.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39850400004)(376002)(346002)(136003)(451199021)(83380400001)(44832011)(478600001)(8676002)(8936002)(41300700001)(316002)(66556008)(66476007)(66946007)(5660300002)(6916009)(4326008)(38100700002)(86362001)(6486002)(36756003)(6666004)(4744005)(2906002)(26005)(6512007)(186003)(6506007)(1076003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?onEVan/EYb1ODsMfag8C4eiMW/LzEU8PTT/hsXh0RcBfZLT83VB41aQF1Pf4?=
 =?us-ascii?Q?gdOhBL+JkbmYwAcWiV1aUS0VQShsnIuDK1ahUnE3S1RcXh0iAkMnwVDpO1AA?=
 =?us-ascii?Q?5+oNp578cwdBziTXe43jDa2DRRQTVNZEP4kpJkuDcgEpJNBcqSFIdNar/q9m?=
 =?us-ascii?Q?O13onJ/GaaRNhBUFB1kAc4XKBvTNaZ2cCaFeLn6rRkYJ10G6hHv8je0HJ543?=
 =?us-ascii?Q?yDYMDJCQqi9u/YwyCMlfQSfCoItdVhfHz8LQgQ1HbvTLixBwEelx2YaXP+Mt?=
 =?us-ascii?Q?qJU2e72YQmBcHxFjaCQkzLMhddH4wp6u88otqEjfBvlVj/5qvyKoAd9+ImBj?=
 =?us-ascii?Q?EKVuI6v04M4kY8fAca1FDJYh2cY5cG7s5BJuEFn3PiEbkoja12ZGo1iXFeux?=
 =?us-ascii?Q?FhWiTlyFqvE1QmHHabTU/7pBhZ2wl9ftNovSJsEjuicUxs34HhUfLgyfDXhz?=
 =?us-ascii?Q?TFgG/XB9iQzw19TrEz6NaA4KgaRpkT3eXnXQbybZb1wGedrhkWuhH/RZh1mS?=
 =?us-ascii?Q?h15FrKqmHKKlO5INiKANYLuMJlOAPwhGWtFNCpggA8Og0TtIFO6XIEdJg7Ra?=
 =?us-ascii?Q?mNLJQkUvt2ClLd8am0SGDWB84MSl2+cvxGh2TPypkSVAed1FJgNR0olUJva7?=
 =?us-ascii?Q?NCPKkAt8Hy/GggOwevDBtr5FvyQC/aduy4nBSkJR9XYt7x8CwNE5XMrnlbZu?=
 =?us-ascii?Q?hae3Y/M5YI5+HitKL4kL6iBstYDXzF8yRKbMaoA5cBDlx0wcUvsAfl8tCoQA?=
 =?us-ascii?Q?fysFWtK+tvBEMPi03wouKy/eSEf1iOgo6qTzmNyIiiXwrn6cLgVIVdCCeKyl?=
 =?us-ascii?Q?lJLZCVyGaA3enQUzHI63i7P1aPj0GQSy9bemufG8eBM8x1Sq9EmOyrUNuNF9?=
 =?us-ascii?Q?raZ7c+o4ibsb6mW8UqGGaCeI3O4t4Lo2f9MFhc3C+C/1DoIbvFvZB2zZGTK5?=
 =?us-ascii?Q?E3IbQhnu1GEPcI+4+a5PlcSHZ83QNlLXqNZONgMAU4Y9pfQRjw5hW/zInRUj?=
 =?us-ascii?Q?U2k4DMxwONkkjEuW8iDdAx8QUXiShbdqca+Kp0Eg2x2KATkEMuVEawI49FhA?=
 =?us-ascii?Q?VupeHBnh1JYuEgDHvDjNDtsTYS1D1OR4eRCfmBwe+0rTdFQ0kXUQ4Ll7ODsi?=
 =?us-ascii?Q?/uKsCo5Kkk9Mw5RV4VoTq7sOy1A8jAQUtJpm+aUmASejyt0vqTAbU4fBUCdB?=
 =?us-ascii?Q?KlZ+e9zi7PImafMI9sbATsVmQvRTVlQMjExDvLaHoMdVu1VXkB9v+jzWd5x+?=
 =?us-ascii?Q?8t+1HV2r+VFMGGB5YffbQqokQLTjfaGVzGIUNpgJaT6ZLRfjOlOhShQMCDtj?=
 =?us-ascii?Q?c8rMIuXMqijug1ZgBQ0dKAtW/O+4QTKyaH2r2c5pdY5cYbFmPbkBmQFz6FyL?=
 =?us-ascii?Q?DnfAupG0bshKxxPaFuUnIlUv/Taw/xKVQk4RjvJIbBCm0NFs4HPzwYT3iIji?=
 =?us-ascii?Q?2FsRffvr5IN60MsjE/esgr7Ng69zKGaA41FI+kf0p53qJMRBEPav9vtAK+aJ?=
 =?us-ascii?Q?Cd3oCZRDE47TDmV5XWGVU7DTWe/QWEV4F9mxJy8gDrqSDB6bfrsVShFtiL59?=
 =?us-ascii?Q?QUx/57/sFj8zWu+MkAwzRAyZVBeTqfdP/SiQARez2fg94ifEyORR+nqBHMMk?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ba1744-f25d-4b6a-6a61-08db6603f463
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4879.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 20:32:17.5138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YNR7FoI1CtiNlbWehrwf1iCdbp6jEv8GBwqymLc6fZq7Qq7tI63uVNkwkEFgiQcRibNRjqoN7FLOXTKawl3zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6326
X-Proofpoint-GUID: -pfKLAO1mLekgMNh1U4Yuw3TUU1S93FU
X-Proofpoint-ORIG-GUID: -pfKLAO1mLekgMNh1U4Yuw3TUU1S93FU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_32,2023-06-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=31 phishscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=220
 spamscore=1 mlxscore=1 classifier=spam adjust=30 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For consistency with what ptp uses for minors, this
change sets PPS_MAX_SOURCES to MINORMASK + 1.

The PPS_MAX_SOURCES value is currently set to 16. In
some cases this was not sufficient for a system. For
example, a system with multiple (4+) PCIe cards each
with 4 PTP-capable ethernet interfaces could run out
of the available PPS major:minors if each interface
registers a PPS source.

Signed-off-by: Charlie Johnston <charlie.johnston@ni.com>
---
 include/uapi/linux/pps.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/pps.h b/include/uapi/linux/pps.h
index 009ebcd8ced5..85f472330da8 100644
--- a/include/uapi/linux/pps.h
+++ b/include/uapi/linux/pps.h
@@ -26,7 +26,7 @@
 #include <linux/types.h>
 
 #define PPS_VERSION		"5.3.6"
-#define PPS_MAX_SOURCES		16		/* should be enough... */
+#define PPS_MAX_SOURCES		(MINORMASK + 1)
 
 /* Implementation note: the logical states ``assert'' and ``clear''
  * are implemented in terms of the chip register, i.e. ``assert''
-- 
2.30.2

