Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048206EE3BF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbjDYONB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbjDYOMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:12:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631CD14F79
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:11:59 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDinSF017700;
        Tue, 25 Apr 2023 14:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=SjQ+Ak+LVQQqfW83hoX5RLJcaeyMVrqOz8zEeR0GSQQ=;
 b=AoyDx8ruHtcrBCl1SO6Y+t4PgA7OOtpw0qGrBNrSWidwR9Nj7AC2c63UN8LWAHh1SKyB
 mFoO/ZjTHV8c/21mqQBPPuH8Gy71Vs3MtJLKYn1qrwMtGrx4kVzpuFFSPkAzC9e/doCl
 XX1K5Kw0yGARD3S/idAWsVObRW+7ec1qJcMLbqU8+rpJ4KXr6bU8qLWn3oC9Z3tqu428
 u/gGmanqZvwdN0KbQQlBzL42FhwJvPSTd/ugnzDlfR/0NnDn8ApT1EZA4pgrENv9b44Q
 bjW4RIiSQSs/z8F2vXK7i7nQXSICag4tvE+ZEY5+6n5NX7/V9BEfKVCmULSaJsYS/8M1 ig== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47fandv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PD1ftv007351;
        Tue, 25 Apr 2023 14:11:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616ge1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7R+ro0G2UpapPaqembNViyryMV8YFP+oxJWhZo0PrDD0/GtYnhdLSjYxnTPVS7qf7GDWVDeopCyuVrxtQsadKtBAyV022dobogsK9P86Qz3xGDcX2YIF3bqqPic/5U+T3pNphXDeuoW8+KVAAwvVfDRSa3u5AtNrnsRozCOEgyFIlL0l5MSF4Ny2km5jAHgTPoVEFBCDFEFszmKWpgIfO4Htcj600/RCxQS+oSP8w+5maBlljmdDL+EpFtwfIrz/nXEO44R1XfJcMqRWO1T+p/Kv5Awm7i6zQ9VI/UWAueagf3TptYAnOWHl7g7DF5xcJhJEOEShtpY/qthBNTyFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjQ+Ak+LVQQqfW83hoX5RLJcaeyMVrqOz8zEeR0GSQQ=;
 b=TXvphHfaEwGWhFwGI5JUwVPfm0SPYCzleaqloae209mIIg6m54O1BN6GYu/eJQU4soryO/DaFdofKa1ffOkaL97QlARwyGTkjFlmdOHRcefRALwTosSR7tA0kt/O4Gga/UTvFvKmMFY6QvxF0E7OYQKEJulr+g8UXoMqElQZhlwTnUIQzIuH4AyFq/l4DPtu7DjfJRRjJgpq5sO29durZUrAcX5nb8TLLh3siH5EsG8Ij2Vb53VQtomRuITEIPV4a+5qtZ58iyDKErYR+YVSfFnjbS53W7IeIxA1FTzPHDw2+JFjBct7eONLVLWkxtbJ5++wGRiC+9sJsiRte0kHmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjQ+Ak+LVQQqfW83hoX5RLJcaeyMVrqOz8zEeR0GSQQ=;
 b=HMds6F+PKN1PyAzUeHMPzwBxzJX+CqzZMoDTX/M0epMWol/b3QPFXX6iaRgLHP6H32ZniBv/K8UTW0ENvtUvuoRdmDmiAXo2H2CRz5gvP7XXCBmK6nT7INWFj+M9dU7b03/s9dUd1yYFLSlL6RpLgGPQsbMlD3I+iyGzh1UFLvg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5572.namprd10.prod.outlook.com (2603:10b6:303:147::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 14:11:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:11:06 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 20/34] maple_tree: Remove unnecessary check from mas_destroy()
Date:   Tue, 25 Apr 2023 10:09:41 -0400
Message-Id: <20230425140955.3834476-21-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CO6PR10MB5572:EE_
X-MS-Office365-Filtering-Correlation-Id: de23e635-4957-4187-5511-08db4596e97a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dVaWCPAh/MG/KhTJZmqL8Y0gSZqcrSGBqKn1AWca4RxzpJ+RzB0fmNe8m4qHJ+GBibRBbvYW+0iowXMa+xutcDQtT9d/SY7f3BHv4vFEgstza9VG7UyNJqts5ZaQUFOGAJW1h17mjfHze+P0begRgIGqW+3FKiVOydxlMocCjDDYz7+tHCxxMuHNV+o22JB7dm9H9GB7WzXALCNlvXRf5s3dVpjy1Gqvn9Y7kP3z5fSwr3kfEdzHDWrk4MwGsLima40CIvp4o8BZv2zUng78NiqdPB/xOTHbaf6tns0tr6AjR7HU5qROJn1e4e7dTHgIn+hFl6RyfA2LlA2Kz0kbPDrIcfGXzz6RW8AZ0xJ25SLRcWtF1pUDIaPhd5k1zv30lM7Bl1+Va1ZZfU6tJXuPRIAZzrGuR1+nW1ixdyQ1x7F+Z0zvfRqK/bPWHIf5bwsF8RL/c3PJ8ie6yXXUrm0AOOiDmbLBVODjl+d0KeEcYSEe0sq0j7n6HlnsYyVDzp87BjfDISgm9nNjbFv5G3ZS00BjUrQzjYlzQ+1AAw8GpN4wMv6YhQR0nhEFDLVjKc5s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(86362001)(36756003)(107886003)(186003)(6486002)(26005)(1076003)(6512007)(6506007)(4326008)(6916009)(66556008)(316002)(6666004)(66476007)(66946007)(83380400001)(2906002)(4744005)(38100700002)(8676002)(41300700001)(5660300002)(8936002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h7/0YI1QAHtoy91oaZIFXmdrSy5U3vdsOSgulVDCQaifD1CnJfwlIkm24WxS?=
 =?us-ascii?Q?/kEwBZh+fY9N4I3BTPabtsfsB6BriHQ/IPO7rcvDNzh+rX1GixxrO0h7EIfi?=
 =?us-ascii?Q?wwlLHxMpvssxhQxifvyNcuQWooEQ8WfIodUQNT914MYp2bztZDgl0/Peheam?=
 =?us-ascii?Q?G7QTF3AiXBC0tmYYA+g0jvzIZLfXRZOuOlBjZKpbhAM+cf/rW48tXg/fUyp9?=
 =?us-ascii?Q?HlA863lKnMgls7bZCqeC/TeNO7I3wUNaLmk5XZ+2Dr3MWCTuWOhyDWs2SIV5?=
 =?us-ascii?Q?e4+HmSI4+mgyFECoRRFCRuWulIZLjLUghmVJvZqMevsxfvg4Bq032tn/fsbT?=
 =?us-ascii?Q?ww/anUOEYszdsX213lvktqD4KuRlIq5bl4yvzBPzCEuUZlJHUXywkhWdfHmV?=
 =?us-ascii?Q?chl66Ge/fKR9wIk9jsjrRHnUad1Nx7ZOzBNB9v37alPsrqr0fcFx6XAjXbP0?=
 =?us-ascii?Q?jhGscpRM9XnIKOfxOrGWe10C3fD9zBofExrAgXLMlZLW1IjEmeYy459TUsfv?=
 =?us-ascii?Q?FTf9OWse+4na+GKsaZLgdlX9t+H1yY+lN2tp95fRYnF60xPin1alOoylj96G?=
 =?us-ascii?Q?fF0/82m27SgLbVmuGtw0Ff0j0cGzM5Tcm1LdinQbOM+ypbUfrgDXNe7dRdzb?=
 =?us-ascii?Q?S8YpjTtgIyaUvOrk7ALGYhi9HcAuVOoDYz9M7voYfF/n7bG6wv0yn/PEtSP8?=
 =?us-ascii?Q?Y0z04pdR7TGy/N2pYGM31Biw1oc9kdZR3NS0YO3tmFD1vnfZnRrgWpfAKwOi?=
 =?us-ascii?Q?9cd5dtpd/t/urS+QSBY7Nh1hZajmJ95K04MJ8SgLNffe+KO6kE4JuFrCnaIH?=
 =?us-ascii?Q?O49uXIDqTE3FsJOP96QZy5kf/0KSN8hQfHf95eiv7uDLOP0YYzdpIOtwuT0B?=
 =?us-ascii?Q?IRm7Qamj483LtzyzCxmoB9PrYE8EvjHwbkb2H6JMTQKqeno8LAASG0n3IZy9?=
 =?us-ascii?Q?+wnc8UMPsIcuzW0878IHV+N8B48oC8T39XtxEDvtAHHL7xox7O2ikS0jWr4s?=
 =?us-ascii?Q?GK+SOG47yKDwTLXb8W6MRwVIIN1fC5uBVYzpix0Iuk3ih8NQujzj1ZVjg0E1?=
 =?us-ascii?Q?Oaf3Df25VQuUK+ToEieTsryRv44zwLex1Z2rzfgyuCK9ettDiBvhW8h9hnjk?=
 =?us-ascii?Q?pFzq2g3f/zQluxWFtVVPCI9o0b7DZAv7ZmSUFsBdA1LDVYJTAM7gD4H8t8Dd?=
 =?us-ascii?Q?qqlQvGaVx4V5BKq7Z/kuFdkYyWgkxK0pOjAfWCQOhGdow50bEJGHd/LBC8BZ?=
 =?us-ascii?Q?6ugKrBvCBnNlCAaQw6R+3UQO2XmODMH3i7oprh29mmQ2aeQU6p+V/EFrjKoE?=
 =?us-ascii?Q?iMwARtk1qQYRZji3eNkBA512DEwkBXYI1HUVIB/7NY1jPARARj0UB48A2B6E?=
 =?us-ascii?Q?NmBjhwuv2IB5dXeQdaQO339SyFQAbzuN3QMS910RZQecBII2epDqZdYGsq52?=
 =?us-ascii?Q?qdIEj7/vAse3yc4CINWn2Ka1FkAOC8+HA6PDJaQKrEl+JiZrGNw6Hgv+qAZb?=
 =?us-ascii?Q?/gO/kMqjDkO787VHU+x0UOmViJK70Z+Jmb9PiPQVKsNi+xuxKcARJW/GY8Rq?=
 =?us-ascii?Q?rnbzyU8oh0jb1Bk6S5big/EuawyhbPql49j3k0vVxc7V+YRRyPg9etReponT?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VJ0oowK4FL+rEYl/l/TEnGt79E7cL3divJUyk4cZo0yOqPAodWBAjKLD/wJoNVDQ4dFWcFB3aAcS5NXEHfnLN8MidpOWyPMnTwqDO1FSGe+KswbnGy0C/rNWM8Vu8n2iKzX+yUxgJszFzkoLuCY6ZB/l3lIXWoYJ+mBhzvZqKg24GDuvHk7zZNmJ/ll4LMHJytreGjnIUzkhOqSgIN/HpY5iat5MSuLYr6a1qCXK9ZU1y/mbKJi88Hi2nqI7LNyfYEmLBK9OJpA4tErUE+CD12zIKb8ekcuIbtmVwfkI6WBvYY8FvuHuZRljzm7V7ygTkuMThyau18WB76nAUEZBNQQNQcATEXZ7b9I0COGVa1/uA4Fnq6O27uVmBn/8J1KAHIbqsQq3pl2N9yQVaeB1i5SQk/cSE6yctVqO9vrjLuRGotgGdikZKA20lEnRl6VviRuajME6Q6F3cDwBgkwy8T5aCUDke+e0cPU4Qv4UCgCjboVrpFz8/mIj+/7GbDcwIz654TFkvulLGP6kLzqGhmmzU4pDeGrpvaUFaK6FlTtkl7tsUuRXhv2wwHDSJlxPn2ovMF3yAVgi/bBSb0XCHGO2UzL3uP7djgCQRG0GmJvVQY9sqfiRJTSO8PA0hzAevAIETN7jtj//6KVKYezKpHzqnS6t/iHHIrBYXd1aG4qyXa0mLMEAPld1BnEA5wZ9iRU1IdOEL++J3qfamemFEQlHk/xceKhAgRKwJ/X7EH9Qa61gMjnpnPiNOSMlK98TDaSFAAqJssFK/okwtdwJUY+Dpe4gvdh1y9ghFuY/UIkgbtfZ3wVwfHK6BdpENfmcnvOVJ7UsHqdjatXNTjgwOJol6yU0qN30SVfim+cAIhMAXib2xAFfo3++iZh2Nngu3p5eLMkefJbjFmoQf5p89w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de23e635-4957-4187-5511-08db4596e97a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:11:06.8755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPVhHYnH1CdJsnePG6dqMG4SMDezdR5FedTzpffSmhL64LN72cPeiKDG2pXl2XYMN42LYUQE6bAZ0qNmb4dwtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5572
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250128
X-Proofpoint-ORIG-GUID: -bXm8Rt6vYSv20pKsqoExK9Grz8M8Ktx
X-Proofpoint-GUID: -bXm8Rt6vYSv20pKsqoExK9Grz8M8Ktx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mas_destroy currently checks if mas->node is MAS_START prior to calling
mas_start(), but this is unnecessary as mas_start() will do nothing if
the node is anything but MAS_START.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 89e30462f8b62..35c6e12ca9482 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5817,9 +5817,7 @@ void mas_destroy(struct ma_state *mas)
 	if (mas->mas_flags & MA_STATE_REBALANCE) {
 		unsigned char end;
 
-		if (mas_is_start(mas))
-			mas_start(mas);
-
+		mas_start(mas);
 		mtree_range_walk(mas);
 		end = mas_data_end(mas) + 1;
 		if (end < mt_min_slot_count(mas->node) - 1)
-- 
2.39.2

