Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207786E264F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjDNO6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjDNO6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:58:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDA5BBBF
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:57:59 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EEmvZB032198;
        Fri, 14 Apr 2023 14:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Sr4Mp+0V0sRCW3UJBVTgNl1W5Uf1WN5u0vUhLFPUlC4=;
 b=NBCFeJq1Qt3gcBj1s+spFpEdZVdmeF7K7Npsr9PRZzOPk/BiF/Xa+4Jn7O8Uq62yt1h7
 +iNrd99A2ZmCP7MhLWS83uXH1lHBwJmXNeN/Ie5q9Yig6gieS6AY6ghgsBvjw3ZzEzaJ
 wwq4ZETa/cEmUQ0l/F9w0gujmPi3k8K4IvZ+DzGAfoRvBXETre+Y20y5Hp+03kp7+7lm
 eSATFLa7nkYz5yRt5fEk2dIqfeKdtpGrEAItSARDoqi9oa7+qhCskF+0c2olWrzeCkaj
 974/85wWrq0rXr7c6PsbFQ5DXFFyWFtFTTWd8mvtSRfUHBWLQpTD4vvcYUaP6VP091gy 3A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0b366wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 14:57:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33EECkEv018816;
        Fri, 14 Apr 2023 14:57:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puwbt7uf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 14:57:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhlpyvOwKyjNii6ef9EAM3xF+U/8YQLEu+UQ7OKIJ71aJWk0k34zIyBOxBITH+iniPpCvMXPc+Tcf4WWG0U2bcZcz7Byjz3hxbiePP+yp0Dskz7gI7tbdzoX7e6XNOAzwnY+XMhkrdGFAN2neoloykjfdH+M8H4T78xX5Jbc7qiAV5Vg/aP4AIxre6XsOQeUym0gJmvtiqIcgVL81zP9Hcuygl4BKID1e/W48g4w004e9CFHzT1z0O31hm8agPLQuQw2XG18cNAGw7kDOxNgE12OUPIUE7HSNLGdeqm61eceb6nBDXejsmlg8c3pz+pDdc/HC8AFlgdqBiHwcvmQPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sr4Mp+0V0sRCW3UJBVTgNl1W5Uf1WN5u0vUhLFPUlC4=;
 b=MNHkF0oARtYwqbmbf08G3fxlm+otJKFS1QaEKdHnllxjfCiab/pIACdEfydcj5WFfwukNcmbRmtwnbnF+7itN3KCnJ1jg35KxdBQNklrSPlDpap2+DpSSpWp5jhaeMR1pMfLax1ZjKJpaRGaQrWjY9QPK9wCMJlnYA7uver3syOko+in+itHKiSdhUxWabBgfESkFLA832fdPnOxVFxRX5Le9jC6EELkwmzwsw0ORHhEStBUQjxxcTlz3pHGUa2jIF6ghVCdWtQK9i617h0t9JCyN8pHjGd9dNwqTHhNUrFrIziEC7/Epb+uGfi1OiHQ34Aru/1GqWvgLQVibUGHrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sr4Mp+0V0sRCW3UJBVTgNl1W5Uf1WN5u0vUhLFPUlC4=;
 b=EFHbPD7GgE9J889ikKMZAc9l2qXxrVf9n/ePSyH5QIpDgvQV2SXOvu51ykhE58ttGQmn7+yWW7SMs/TJGWwYnyZeG95IYJ9/Hjj6wREKAY4/xOmxV+ogkmvUQBIX3AoMU3NdnAdkDuEemlLilQkYmGSrHgR66f0TWJsySCnQNrc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4582.namprd10.prod.outlook.com (2603:10b6:510:39::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Fri, 14 Apr
 2023 14:57:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6277.035; Fri, 14 Apr 2023
 14:57:50 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 1/3] maple_tree: Make maple state reusable after mas_empty_area_rev()
Date:   Fri, 14 Apr 2023 10:57:26 -0400
Message-Id: <20230414145728.4067069-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0309.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4582:EE_
X-MS-Office365-Filtering-Correlation-Id: e9cc4981-1268-4037-54fd-08db3cf89e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OSLucgV+Ty9yGM1I5d+ju5a+LkLrYVAn0T63kwLOml7EWF8Csf7gJPP/XD7uWTa1IpVrd3oYcSxM7IdKO6fwpnroYWU2RnB58yeIcOHrbLOdSh2DWntYHc33WQarr1CpGGjynK5VEsxZM4DAi8dVfLiggEbL8hFZOvyEtsRNQypnzvTeHImw7tvVmmtx4wTQCUc7K0RgSScVu3xgg5nZs5XmAbsk3FhZ21oVv65qlAJCTv7SNdY6JLszPnq8qs9v3UR6U5S017OW0fijFKK1izqtKaLRK7aTSU/FhSepBT0OKmjedKkx0SPsLPGCo2dYhnfBIWD0L7/WTSGcu03jetgef8wAnNz9A6uAS1n38s2IUSTownhJyfkQXJK21CUETNlrz5eTo8D1s9DXc9bLETMrin9eX503q66xV2eGz+v6S/YpfO6gq4FEK8n/8fF7hbJexldDqLAuOWzhnXTcdoPseeEz5qalAWD7vexzI3wlmtejNURVVcl30Ib4ffsGvxoDKCeW3nEysVcONvD1awDZnD027dkZWLTKlc8NuxD2pOfugVDTS7VzmZtrY0Rm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199021)(1076003)(6512007)(6506007)(6916009)(86362001)(4326008)(5660300002)(6666004)(8676002)(6486002)(36756003)(316002)(8936002)(41300700001)(54906003)(478600001)(66476007)(66556008)(66946007)(2906002)(83380400001)(38100700002)(26005)(107886003)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/0jrIv6+c4O7TXVAjADSs7LjBSNzsJ0t2l9jzZR+uyKWGZX/6ZhRS1YPD5W0?=
 =?us-ascii?Q?J71EZQrVJ0Pi4+BSNRfB8DgN8wQkV6fEMl5QfQcIBoV8aG0VFEGBx8Qpq1Rg?=
 =?us-ascii?Q?SDftVO7T9I05SDtU1ZHuIbbhEvR9qv1l+NRgh6nOmhLFbsGA9jDUeCrWVqz5?=
 =?us-ascii?Q?QGTMSBbQIIhaDUHPYC5Oz5+gFI/Ka91szsC7IV+MnR7HSX2dBOqklCi4qhqf?=
 =?us-ascii?Q?nMBzEu6gtDHeXaq0L1XIb1OhAK5ZZA7xkNTSlIAboxP3z0o21k+dzOF6N4Z0?=
 =?us-ascii?Q?aa/7BOXQfF4pJhlk1FhDqPm7/b3DxLC2E2WmBpdGSGGmbLZdHJDkcT7Ihebg?=
 =?us-ascii?Q?sNPdOma+D+TxOjjw/6KOf9DY+AIKOdHZ2lr/o9GSpYhjL1rHZk7YLHMPEHDV?=
 =?us-ascii?Q?OtwTL6/soeumuz0dc5JjIQ4oqOTbsnTNzNWiBwDhGmI7fAy7Dn2t/2qBgLFw?=
 =?us-ascii?Q?os2GzkLYFMFg+QP3L2m8mFxbVSmVn56a7yYIaoO7SBpbPX022ibAxQgkQ2Rb?=
 =?us-ascii?Q?MQ9DaIqPk3A9vc1aBTRdDWr2+vaQo5NE9Q9ynjt2y6bUZGmnsX9uWepmos85?=
 =?us-ascii?Q?D6fy6iZezr4O1ClH+1vmUI8tk6dUJR2M5CCYVZZK67cxQcSuoB2Jnl/lfuGi?=
 =?us-ascii?Q?/me9GW1HJBA+PCTor9RHb/nJz7R09OIdLztkcHrO0F8GJK/KjSeNQOZo+KbK?=
 =?us-ascii?Q?HpbFJeQ05sdq27ulf+zxNWRGrBa8vuwMKifzoNZgZ4W69sR1wHu0acS4Ox4a?=
 =?us-ascii?Q?dr/EDHWFU1p0UniV+3iNN4Q0crSlKeXzTM9BIKFKMIgV7lPpQ5HorJUFMruw?=
 =?us-ascii?Q?0DfOcw41PKhOJOZeyrTXLyq4wuzf5OMNDusBk7et6SqgsK0taLPSTsx7zIbj?=
 =?us-ascii?Q?WE84DrEDuoQROAGzY8NvqsQrMj2k6yc28Sz6nMc4goGqnPnjRUEEa0xMlzxl?=
 =?us-ascii?Q?ui+QkTwj5SF1ZPdK6jEOJMUynZvLyUIQG9A0xV+iprTfWze+fNrPhGlOjK1F?=
 =?us-ascii?Q?8hAObtcJ4JYfp0TCDvTOCY68sU/cAIQpPePxZ9PtYOJtJvv5/FAVzqjR9bSo?=
 =?us-ascii?Q?A9eTSybiMihTJ7Z+H6D7DcLqqe8jfqT5XWr1HLFwBwtS+OCxbqJAZkHXlCQ1?=
 =?us-ascii?Q?y2NLrdLyhyF83ClqsP3c0sMdIiNAAf14FviwTylX5tHER5fMshW8RS0Lnm6m?=
 =?us-ascii?Q?ivwOxBlofvf1PWLDDRkgyVY/KhYNIMjSmPr8loHbMu279xUsk326l3UQapIX?=
 =?us-ascii?Q?XTFkqPRxC6N5LaBiowt6aIoR+kPVaQrlnm4miVPC2V7d+XC9JmlkUPUZqOGP?=
 =?us-ascii?Q?fx+W/XRDSzo2mIze5KM/E8FXbuvtJn98E3VNP7Kh3atjyp7mrE+k3VlfUXIF?=
 =?us-ascii?Q?3lk9DJDOz0c5TZCFpOuammf1acfd8gFDHlW8B1QeG9muoflvUYiuTrLg09M+?=
 =?us-ascii?Q?NBDhp8W62RK0juozjJV4WG27QwWxmOrnJhTvJ/yDq28i+B1v6e6SRgrCLEt2?=
 =?us-ascii?Q?8xQ4rLMHgFXhAzwpuj2dwkonrofgumfG8DP3JJkX9iCAaiyem81cLotdce6f?=
 =?us-ascii?Q?clGfn9SWYKqJHkG2hZpaNmizhGDnHectjmSQFdZtFHqgvh2WdoE5CHfZYZ4r?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LITFnAL26wLrygZp3enNx49OcXLbYz+sOmuIIdBXXm/PL6lAdlbrLiT34YOsRJkQBzm+b0mkka9jI7Nw0CMjo5E/BA9/GpJ+cr2R4wPSxUSOUIKpyuzI3JtTIh+ePEuPMiSb6l31Utcko0H1bfDpTrZKzcA/foiMPi6zXdkUe4bWE1vXrKRaBvoxBkySSQM2JT8fihuNdc40nbO1Glkhzj9AwRoXVEnHdO/tRPkt1NZ9aK3OHRS5gajr10BEBi9T3ZAx04e5mqP5Yd+aX/mV/u3S2Q3bOdo+wmna+3ojFzNM3aybvkpZ+iX9/fq5vQ8zY6ArjXafHRvj6b+12V2aOwhxO9W1JbiZoSQYbtJRJJxk+zqSPmwHohY0bgfMACcx+JFfSQplhAJH7LFC0jmKxw7iqyN2cq6JLs82Y1Wzk41wrosVzaiosZma9DgO0urclUHLXnUIkFYAf4oLIVj+8tfQXy2yQXZJyT+cT8CJ2zvzi9e4GvRsTKy3RJCO1sB8zHR2xCnjsDVcfoboM3bToWNlToQp8M+BI4ZCkbB2hkQJAvssIunitG9YPFhc9V2A5BNpQDKF9af1GRbQej4RlaZUs5ipPE7pV6Uw2mRZU0imkakFxem1UFeOv4iCIBau92DS71PcANPCSer4MIhx2KMp+Hf+DeiYEwZoFJJxdvA6QTguShOceh7Ue/oMxhwWpPmI/LvlMHX4gTnLfLVD7p6AIN9OAX3C6iKSRhSN9i29/LEKZ/FmxmipjPT9jjpE3Li2hwN9GCCYxV9urDTT+uttdr6ecmU73SPXaZdHoZ01898LRBbVOSfv/cvAAUtMqdmAiZD4N7jEQlrmZj4RrY6N9wIjNjaXNHSPcYRBw3eqNpidPAp5+BH/Jq/qCVD1
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cc4981-1268-4037-54fd-08db3cf89e0f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 14:57:50.5296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /83t4Yx5kz1l4AlssjddbY6v4Ib/xrBNrPreoq7Ms7O8IKo6aEmYg1Yikg+l7xmXPZvHHpdivtJ7DWWZ4ZPAgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_08,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140131
X-Proofpoint-GUID: 092BZYmO4tmymAdF9uC68hBdlzX8OGAv
X-Proofpoint-ORIG-GUID: 092BZYmO4tmymAdF9uC68hBdlzX8OGAv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop using maple state min/max for the range by passing through pointers
for those values.  This will allow the maple state to be reused without
resetting.

Also add some logic to fail out early on searching with invalid
arguments.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 4df6a0ce1c1b..ed350aa293b2 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4938,7 +4938,8 @@ static inline void *mas_prev_entry(struct ma_state *mas, unsigned long min)
  * Return: True if found in a leaf, false otherwise.
  *
  */
-static bool mas_rev_awalk(struct ma_state *mas, unsigned long size)
+static bool mas_rev_awalk(struct ma_state *mas, unsigned long size,
+		unsigned long *gap_min, unsigned long *gap_max)
 {
 	enum maple_type type = mte_node_type(mas->node);
 	struct maple_node *node = mas_mn(mas);
@@ -5003,8 +5004,8 @@ static bool mas_rev_awalk(struct ma_state *mas, unsigned long size)
 
 	if (unlikely(ma_is_leaf(type))) {
 		mas->offset = offset;
-		mas->min = min;
-		mas->max = min + gap - 1;
+		*gap_min = min;
+		*gap_max = min + gap - 1;
 		return true;
 	}
 
@@ -5280,6 +5281,9 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
 	unsigned long *pivots;
 	enum maple_type mt;
 
+	if (min >= max)
+		return -EINVAL;
+
 	if (mas_is_start(mas))
 		mas_start(mas);
 	else if (mas->offset >= 2)
@@ -5334,6 +5338,9 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 {
 	struct maple_enode *last = mas->node;
 
+	if (min >= max)
+		return -EINVAL;
+
 	if (mas_is_start(mas)) {
 		mas_start(mas);
 		mas->offset = mas_data_end(mas);
@@ -5353,7 +5360,7 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 	mas->index = min;
 	mas->last = max;
 
-	while (!mas_rev_awalk(mas, size)) {
+	while (!mas_rev_awalk(mas, size, &min, &max)) {
 		if (last == mas->node) {
 			if (!mas_rewind_node(mas))
 				return -EBUSY;
@@ -5368,17 +5375,9 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 	if (unlikely(mas->offset == MAPLE_NODE_SLOTS))
 		return -EBUSY;
 
-	/*
-	 * mas_rev_awalk() has set mas->min and mas->max to the gap values.  If
-	 * the maximum is outside the window we are searching, then use the last
-	 * location in the search.
-	 * mas->max and mas->min is the range of the gap.
-	 * mas->index and mas->last are currently set to the search range.
-	 */
-
 	/* Trim the upper limit to the max. */
-	if (mas->max <= mas->last)
-		mas->last = mas->max;
+	if (max <= mas->last)
+		mas->last = max;
 
 	mas->index = mas->last - size + 1;
 	return 0;
-- 
2.39.2

