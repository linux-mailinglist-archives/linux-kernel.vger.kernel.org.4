Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5C66F88C2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjEESlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjEESl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:41:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B921436C
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:41:28 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345Hh61u027900;
        Fri, 5 May 2023 17:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=DLizGfG6RsPpK6kYK/8TgPTR+rIq7alrCR/2NcjSElk=;
 b=JJ7eDEXjw+6rfsSL1OHz4/epsCLYQugMVI8UWNYNP38D+YZQ9NxfFs9ov3i/Swxx0dBT
 vGFB2ussI8AnEfcOSA+G3k94xQGeXjjRXfc0BIzQuzdKTHRgnFD4f4LOemy6RMePbpbn
 iCz0j09mh9jbuvSXDq7uYrhuYcfjJ3HzEkesFwLjvMtbVBZI3mqjCJR0h3Gwa5ej+pMD
 4V2d2gvNSI5dqp3ky25nfyQjdTz0/7dbtMbNfBr83zxxqdKSB2AR5+iKQ8T3xQzLxNgs
 fkJ9wELwf4X7P5f0e0jzq6CKW19nhlIrinTcqpp/pi+Uf6i6tKh/F7l19nDGCaiBQv/j uQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t5fwf4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:45:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345G4EtF027652;
        Fri, 5 May 2023 17:44:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spgetws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bw1k3p/tv/llIQl8kZvEVLB/+hndea968yXQ/Ys8iN0CsKQmpc0mnP48UP8C523boU01Qaozcd2iacZW/bRyHj+C14yI2uIIqN4DDP1h513eADicHFCe92VMUNFeLDyvurO1LhsAjTSqfVg3m+xD+RFtinFlm7liSTP9Dk0+Ex9pUDuE3c6c+KgUyd4eRwz7SHD1tJwoX8ViU33iGmJJW+cLE9QKWuXAV2z6Ggavp2o8IBaNOGIVX7g77CyXJUXTJBIxuvfUJW4lN+lA99TsH3KTn47umXKl6BdOFwkfmKYD08Kf3kS09wZ+tmehJFsPWOyLtBe/u8B9Z6Ycv2W63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLizGfG6RsPpK6kYK/8TgPTR+rIq7alrCR/2NcjSElk=;
 b=XyfzxuCeOYT3DU0ERF0GwdqVeYK4yVwlvJDxf0fqSmQcSGiBC+OJla/6hLgPaQkrv5c4/pXCMNQZZ7wlHIRy5dCH5GNicFic4CERolxQXXlZVC2lhsTRErVZhgeVE4JD82RRS3kP69ECnHf4EMBQaiYoaRHOZWHcpXzY9MiLSd89LXZTSRRtCim2yz7nEMoSDCfkKf4p8+E2UF0mk1jzghFvkiKuGS7j53dEn7jvUGHFGhi8YqewvpA+G77nXFzpPvK+Z9OVyY6EBoQL3SMSMe8dUDxirqbO7www+2C2haSomnnLfjw3mhqequonGab+l2V2Xcx93zLtjWTmUeoRKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLizGfG6RsPpK6kYK/8TgPTR+rIq7alrCR/2NcjSElk=;
 b=jwCCgu8LhglGmr+r9fDbY5VLPKanUNWtGuB+KoRwnoFx+Ss3q/C1xyhTb722sh4gTwbxc2Pc9qU3JiqMvIC2a8mfI1U/9abQhnVyarKhkn2TAbxPYUjzZ2JGM5t1VwaPg5/lzs6OMj3gGGxuXA3egK3383UeVq+KwQocmB3ZhtU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:44:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:44:57 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 32/36] maple_tree: Clear up index and last setting in single entry tree
Date:   Fri,  5 May 2023 13:42:00 -0400
Message-Id: <20230505174204.2665599-33-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0251.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::19) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd5c748-5c0d-4b33-d9a0-08db4d907140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7U1IRfBfvxzh5zAFl7bwlWU/oL6xbbgP5/lGIVQd5USGjcRaAQjGSuWIE9E9mVoeVqdh+G1eidk77K5EI/ZTqjZYkve3lvapQydWyUV4aJWAFNf9EBpYmh/jYOna+8yNG6g0TBCWkzZJe4ZwCkMl+ZseckmGpCJtC6hYSzWxaWQaVKWb4YPsX7VJ3SJnTw2j3JfpWcRb2nOoQWLUT6FA+iETqTmmJV8B8E5gqtiA0/IJRRlAEzIimz8p8DpweHy9h7TBt8OkeFBuVmTYZ6w6Hbf+2RBQfkkjyFDjiWarFTNOjUr6gPjd/IL19DRg//hu+Y71Erl7TS8lRSwo/dfbYjwrUWCqEHarhCBCqDNPypa685HbtADAeZfXxrj0VdGrXNacyXtN1KPFmsD8gPwYuQX1YbN+yRFlu2AU19t6t6wrdbWhyF1reUNAKJG/ySkwlxfFq6IaDW/fYv2pNojV4WfjwOz07nltxX3pI9FtwrE18JewVJNZrUAo+OJpQW8BReBODYaVKIkqsu7RH+jYHsER4vs7cVVSLP/HK91k2qLxz4pVdY3o9yq3JRXDWJW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(4326008)(6916009)(66946007)(66476007)(66556008)(41300700001)(8936002)(5660300002)(8676002)(6512007)(26005)(6506007)(1076003)(316002)(478600001)(6666004)(6486002)(107886003)(2906002)(186003)(2616005)(83380400001)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D7dBLONcqYLjARsooyVd65lOPLZ03jlYoVPhnhHHb3G7OnPj9mKFbx5CrEXy?=
 =?us-ascii?Q?BiNvb/ScWgxRlnK0xgpV/j9WtgW8wk0hRjPgggicpIyeZjrNG7bCdKvKVIlz?=
 =?us-ascii?Q?a+pyS0Gga7a6cU80yvwbAQ/sI//h/fe9utJSAuID0LEOidexLgKk2AoSSamQ?=
 =?us-ascii?Q?cjl9CItq2AoCugrJJhWIlF5W2O/lcLO+goz/u2NXbKDiy6SomDqLVZYr8Byu?=
 =?us-ascii?Q?W0vpsiEew2RVAxDkjaBc9gtzg++TxMLjyMW4IkdrD8SOXQdyuVuJdZK1IaCT?=
 =?us-ascii?Q?IBgHIJO0FkuQOCkmu4Kfo0LGWdiOudQ+KL9/s1tYMJvfaSWbuCcu0rXcCYf/?=
 =?us-ascii?Q?GafAyk+hO8ZrJw5ypK9G6vGisGQS3EKKUlQKKD3x396XI8dM+IcVye+tdY9H?=
 =?us-ascii?Q?2Jt3XHopUSNtP8beLTdU1TqzChMu9pzT7L7C+apIHi7n3GETX/80b8KTUj30?=
 =?us-ascii?Q?GRm0LXpsaNbK2TvnJk8qV0mQJnAzMmQVmU6v6RyhW5mwKLQstMAliO9IpcH6?=
 =?us-ascii?Q?dz+P3dOMboCbfJbhknLwV41f2wjYEybVZ2R9PHgk+gtn8uPU0LcfMJg2xgQf?=
 =?us-ascii?Q?C/TpsseVyztoS0riwEXDG3hAHNoMO97wb/tbu/DXWtL3i69E/Bv4NiKmea5z?=
 =?us-ascii?Q?pZ2mlu02phuy5HNpN3cJa8SezZIB8RZghpkIzC6703r200d37+p6mFE75rja?=
 =?us-ascii?Q?CCIutdSoBJgpz+iNXQ26Q6l5DVJ9AjKrIp8owuhL9z2ygRhU52l4Of6FXHDd?=
 =?us-ascii?Q?Gw1pLcr4ugHyKaD8UP7TlL/xlxIb46xeZD6gQuNuvCiwmyBM8tz0qNo00iQU?=
 =?us-ascii?Q?eM/z0ANOSYHLbgEmETJmo38Qn49UqjeW4WIG8etdvpXRSrcF/Jk3axS/7lT/?=
 =?us-ascii?Q?1AZXhQ/+rdHF4YrlIZjMsB7iALei+cpf7Op7cRyM4h6r7/INe4prDtm5xNCd?=
 =?us-ascii?Q?EvoeQcAoywT/OnDo05rl8hKI/pXCiJntPPms8xtJZR+QfUODiPwQUQ/p7Gzt?=
 =?us-ascii?Q?d92EJzWEVWCf/f3wIvjiBjFMZic3qBT09yL/9a9x+HbY1Gzcumy3zonlu3jv?=
 =?us-ascii?Q?kTxX+Ob3BCoayOy15KOrpZRHUy8naNbWegrXRTjWh03ZP7TxCTdb5hh3xMuf?=
 =?us-ascii?Q?SfaQ7300DIHF052RmyzTQvFt25F4Z15uQnuD1yQM0+YLJq/XK07kS8g3RfuB?=
 =?us-ascii?Q?lHRfgzdAOSQp8MRI46JJ+PII3eDGkJAeFM/oc6RcwKqEHmP5UGnOL8OSgRfP?=
 =?us-ascii?Q?FNvDtYCoouPOuVtUOQ48IFPjxuLa/FdpVx+H1aOIdg1WHx4xqc1ApkhyqIwW?=
 =?us-ascii?Q?917GEwOxEhgJdPDCJVAzZDgpGBNB/ciPLMsGMW6awXbvbBXrPSCEA8e3vz7Q?=
 =?us-ascii?Q?+onPEjEY9bmFJOdB9oURJd6cuqRiSNX6rYk2NmS3S/mEkRuWf+CduVNvSWnp?=
 =?us-ascii?Q?+SztlCouQFSdnHkVSeE3sCwxvQmNfCBwTKjtw7quSQ8Nx7lkDC33X1u7byzk?=
 =?us-ascii?Q?6YpnbCjCrdfO9msWO8rlXi+bVJ5bkGA3S2GgsILS7fhPY335UZb5o/Y7yFkj?=
 =?us-ascii?Q?sM7ZKGxLl2SJt3unKVQV35WioWkhY6CtwNKsxSNynu7ND1RKQftuE0Vsyui7?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MoC6P2vwQKtePk+mWPcGlHe8T5QGhozThSs0gA5j1cq8hsW2THkfeDvDYUhxnmMcghe8Fmx02FpUKm+99wLXf60epT524qIRI5uroQgky98AEhaB1NFXEmqipBBn4LUk6952PJ7P0hXfKzkG0WUhgvb5sPFN/3aQ6uVZUrJio6HuDEqh02WWjtHSLevgB5/q3i/xAzYIb9Qvu5bCuQF+8b/G6cyJyrQOYslUFhEj4D7t8+NtrcrULaKRrE0BIhogfkX5kHqvjPOYtiNPUMqV032xHQAUmtu8wd45300w7L3EH8mLLTOtroQPiTGM0OVKOz/zkA++UQjXHp1/SsXo5lxIO4CZzOUTUzZnSDTVAua4tNVXuM9jx2ANQIav56rWsn1cPfESc8S/T2/PsC3RUxF/gVxUl1Dxx3j+j0o1mL/xGfLOUKBHKHz49bNjNv1ajwJquDTumUBMsjMDDULsRlOs8n82RVR3rhDVNY1XlQNQjJV/BOtZrUF3bzAfGnzN6/3GbBZS1cNoYSRqjiRCwc9H++PRhpB9LfaW1PijEpOIZo3uwKKlWv7rJSdhBBs6SkauMnziJ5ij7pIVVHWv4Oqo7HTjBoowD80YwS74ivp04GJvL4AlFVr67BPjMEPShPunCFEJ2DpfIRkJJVU/vuWDEePj9tILwMy52Ro2QMRXxfXeNhKlB4OkkbB1YiUG/mrIK3kmR82W6Uc12oURSuLmE00byXdmS49x4b0hgJGjyqzKMLnyoQFN+hSYBXdwcaatHV9gemDohkq5TTuXRFoTbzHLl/+8fVn8XDCain4ERQY3ia+19Qr5q9IwbYZnPC0PpqgUOCxsIGhgs6FQPPB5wzvQ6Sv9qSlvYYr3enHKD5EdX1Psnbx18pYNVq5E4TuPMX7SjEmcIV/mdg6kfA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd5c748-5c0d-4b33-d9a0-08db4d907140
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:44:57.4888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pu6caMv+N1IXiYGAmcOi/fKGrx8BxenzDhgIMvcGGfWVisdREw1hjmQJW2mRr6MGWD/DPF7iAtDs5Lf7NvUj+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: IWiT81jmCRPMkQ_TitPZY2Uewq18osnx
X-Proofpoint-ORIG-GUID: IWiT81jmCRPMkQ_TitPZY2Uewq18osnx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is a single entry tree (range of 0-0 pointing to an entry),
then ensure the limit is either 0-0 or 1-oo, depending on where the user
walks.  Ensure the correct node setting as well; either MAS_ROOT or
MAS_NONE.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index f060c71965c0d..914399519cf54 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5022,24 +5022,25 @@ void *mas_walk(struct ma_state *mas)
 {
 	void *entry;
 
+	if (mas_is_none(mas) || mas_is_paused(mas))
+		mas->node = MAS_START;
 retry:
 	entry = mas_state_walk(mas);
-	if (mas_is_start(mas))
+	if (mas_is_start(mas)) {
 		goto retry;
-
-	if (mas_is_ptr(mas)) {
+	} else if (mas_is_none(mas)) {
+		mas->index = 0;
+		mas->last = ULONG_MAX;
+	} else if (mas_is_ptr(mas)) {
 		if (!mas->index) {
 			mas->last = 0;
-		} else {
-			mas->index = 1;
-			mas->last = ULONG_MAX;
+			return entry;
 		}
-		return entry;
-	}
 
-	if (mas_is_none(mas)) {
-		mas->index = 0;
+		mas->index = 1;
 		mas->last = ULONG_MAX;
+		mas->node = MAS_NONE;
+		return NULL;
 	}
 
 	return entry;
-- 
2.39.2

