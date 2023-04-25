Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898816EE3AF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbjDYOKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbjDYOKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:10:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD7A14442
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:10:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDi1SK008675;
        Tue, 25 Apr 2023 14:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=hnIf8rM9FwgxfifBfgv8ptwUanorf+NhjcYAJVOIWxg=;
 b=e8KX9c0/gOqqHLZHmn926OWJ4lRQQjDQDiLmL883PG3T59LQJtqBF++mFfLQ/GqpkhGy
 euSZiqIph9Z763XLyN4wXN+Z714veYNsA77RXTw0xBL+9M2SjZMCJBHMIA6mGF+qBBA3
 +lQI0GeU3H3WzBLkM+iyxUMnRpAVNWy9lVFrFrT5qm9zldiTS6NNLz/AgE5SuAcpd6nY
 RB4V/N9YqIwpoYP82mXZtVWsfgCQV5Gpjm1Og3SsQKX8ELrmodpd16xigShXE2bcVGQ+
 8VADI/46h8mcUOKOpPzCe4o187AgnJOQmuOEYIYJpsUD9EC4q0NmoxsoZtSVc90Z+3M7 aw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460d5e3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDmQnF024975;
        Tue, 25 Apr 2023 14:10:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461crb9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CL/Ex5UXRL0RitVuIHkSmY9Q/YPhbyyBaW8J8lfLvniu4m7E0AGIXZiuCAo86dBGBQi5KFneJy0eT+z90vwH3tgO+diK4BjpcT1QqClphqZWx59R0+RzIvUYZ2EHnCskvuKSdQHZfH1I7UpH8pYPN8KgEIeGdyZf3vaF0qY0hmeRIjrIvlAQpdFieu5S1WF7EM6DZEoipQEkDsh2R+drnf+G5l/HrLuwc0lDLns3zRh0gBporIPgh90caaO9UJ9Ggc3YHQc78ZhDzz2nV/TAk96YGTp/FZoEMKvN88YtIQS5HheYNvBl2DQwmAjaI1/Mwbbduwbn19FBYi1gEAtiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnIf8rM9FwgxfifBfgv8ptwUanorf+NhjcYAJVOIWxg=;
 b=col8EehAXIZEUyzzPH4M9BG4GLm4C/xarTZzoXSEj24Mffa93BQPTeg5IVlEocgNN1ONuyD9Yf3R4FZ1QKdBxTrnXDyEVUaetET6PXWVhswwmLm6EsUm8sN5upccZ8eYsf6TtRoPvRNdLp6iNKLRza7YoG37wA1O3oHu9q0hWFIz1LK9aMeiMCuTEzzXR+C/ZwO3XMnmB4EkTOiD79qAXULEMrMF6QLjHyITYjiyDP7oU9gT16nZURLQSacTgzHaqJZA3KcdTHWfYY8bl/EirLT+RO67sEIeOqbX185QlJvwPEDDN0mqzbYbFPoEK7Vz88VXKHWRkBSY+JQl7+o+QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnIf8rM9FwgxfifBfgv8ptwUanorf+NhjcYAJVOIWxg=;
 b=UBfHVgDgb5s59gRxvDLBdEUYoCPrlj8dzfx/RzKxIGr6H2314vAJSofuvytQ9Jyk6+gDaIxQ5r0dySiMufJnLR0O8iK+TKovsiFKb1mwwBI3MdfWO3CzJSmt1qUZ7MVMO/5l2HEb1HfgwZXY6qxL65fNGoANZj8/pbVtAQIt9sw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 14:10:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:10:29 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 04/34] maple_tree: Clean up mas_dfs_postorder()
Date:   Tue, 25 Apr 2023 10:09:25 -0400
Message-Id: <20230425140955.3834476-5-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: bedcb2c7-8e45-4c4c-e780-08db4596d31b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGz5brbAfEGjFh80UAcD51aj3SSgTAVCCPnv7m6n0spcwjtzSup1SwDGYlN1rwUhwL0DrwWbcUhPZu0XsdA1MJm30FnqUvKTWQM4/zA6t45JL6lDXgsuOo8ogy8zZMvy3NK5YX9RqBdIG+Dbzjzan+U+BvjTbdhvKW/iG+W99q8U0vRWD6zCvd03ugDjuvYxCO3htukCyaGp7Qzcmg0B38dGsqme6nrKiIDse1LxieGksJC5Ni7GzjJ+NFG/7W1f6d0srn8aY2onwuz+RRHCw1O7KoCseHTT8uuzc57YDKaZM6wQYYTd7NokOzuHjixEewBAdO6qEo+ivFYiOZLvefxGnVEjZjIQgaON5S8Lqq64dhq877SQNWqukf1Zw3QKCP3nE2uZcDotla4AM7OnFsx2FsdIKbMYOIH6RGK7k3r8CJWuzzOuGKLGUKF1tpD8wekBZbOocKpZ1P2UVzyZS6zlIUiHkJI9lKr5PHWbAvRMBglDtRL/k27P6+62vzLA3MMSr4nTJhX2d/ZmRtKZP/43sQyilio9wCDataEMPyWCBhEa6X9IhhK/+AmGFNPD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(4744005)(2906002)(66476007)(66556008)(66946007)(6916009)(4326008)(316002)(5660300002)(8936002)(8676002)(41300700001)(36756003)(86362001)(186003)(26005)(6512007)(1076003)(107886003)(38100700002)(478600001)(6666004)(6486002)(83380400001)(2616005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kxyCAtx+u8Db1QzuDyL7Br5xmwLX4sHD4G3d2HZSQLaYaDDyOrGg6V2cRKhk?=
 =?us-ascii?Q?lnZlOPV3391M9G7AaCiA/6Tu4EYAqXVAj7vt+JncbrBKfXqS4dpqkEFzfyEQ?=
 =?us-ascii?Q?XqB8JvSFryYlliBQVDaaP9bllRC1Rn+pvNbN4cJSOC8UnCISSrDHWDs+9ZyA?=
 =?us-ascii?Q?WrFgDHjZc25DhSbsIqjbg1JWX9VpoYeAQ+vSITxb38cyEwzACPyPKGM0MEnV?=
 =?us-ascii?Q?s6sPU9iTSxHY8Z5bJwB0P6kjDWXYMFNFlGfg/ENyXj73VGWZGMdGsDu81XwU?=
 =?us-ascii?Q?Zbzt+T2+JJzMPe8kAkywxsld9VfLO8y2nuvcyLXgBStPk3A69n7kUUeMYOcF?=
 =?us-ascii?Q?QoopFxhInyBdNwzLjx6pnMSMTiHvfwE4X7e6CmdyvdUbkgtsS99U1w402Qqn?=
 =?us-ascii?Q?2CV2q5NhViFwZj8JmQprfI3C5RVM9gJe86jKupzSAcMFaXkvE2E1WmU6S7IZ?=
 =?us-ascii?Q?83xfgrgBEtcTiC6t4xxpfQmJH1YVU9IOK5v5Fg66J+p5Jg99JfZaFZYujtqJ?=
 =?us-ascii?Q?CLJd74w+emkMEgZmFMtFd+uwqNmgmvCsqAyIp7XL0Vpr9fny43L/d1GA07lP?=
 =?us-ascii?Q?9Ipt5twFiqDG4IVpeFJvOA1IF3Bd93x+5UOWnYREsn7NmPtYHe+uZ0FIzokX?=
 =?us-ascii?Q?v2miBh2cAWpMekgG7GybWHLZgnC3XM7BKrM5VM9n8t8JRtKGalibzAB/kIQQ?=
 =?us-ascii?Q?+NJLVtzynHbRSHa8/zzZ7IOAa1eciYsziK8WTp+ZFUDW51gzsSQbW6H4oNwY?=
 =?us-ascii?Q?E8YtSXjCY8cAyw4jEpnbEYnNoFQfwv6z8Dx2v9HmEzUKJc0DaTIYXRbcziAz?=
 =?us-ascii?Q?Xc3r70YOqcCnUOnC67LJ6gyG/eGyq5npMCnMy2ZNYmzZ0Z9yq9V18raXHkyi?=
 =?us-ascii?Q?UerIeGOvaxfhGibRmK8FiUjzRtxrd3zxwQuy9oxkFcMHRjgKFy9X9OslEdoc?=
 =?us-ascii?Q?9Tlixl6/wHafaqb5Mis2pj9CoWHhaUgUaL7j8Fz33zx1MIZ8cOalHiCxsaYq?=
 =?us-ascii?Q?pqcKz8kCrCfmhTilEmDBRjZl3gBc0fJ8OKcX1W9nD8U5DrxBx4LjLui+WseO?=
 =?us-ascii?Q?shui2SAD9WHzKwE/5WFYhyhGq84hyCWEIF/7fc1fSZBFXbVJTRUV6grWokOK?=
 =?us-ascii?Q?4t5TFi268qQPIwtB05xnWaULWkgy8mvOZBJks6tYjTuGkLMewsjgqDwnl8WO?=
 =?us-ascii?Q?U3MovvGIqIkCHtA4zIB8RLjrkZ5u/sfUZZATfDHIhBIlf1DYN+M7fg+X2l4o?=
 =?us-ascii?Q?cBSfFtdEgv3d1/uTCxz/BVwYdR4HrwQwu709ietIN0HTRw+ddXWWeTxBFRoM?=
 =?us-ascii?Q?S66MnFQQEx0uNdqMugVL9+OguAaiWuDXtmrZSJ7vte3PWwC08yZdrMBKMmmI?=
 =?us-ascii?Q?IFhZN4IZPao12SFzcBY3+5zkVsBW7OsglHQkSq9Q8c4gKF4u4MF8m769+p4p?=
 =?us-ascii?Q?dgJdz/APhl1Bfpaq3VD2s6gWnaQInLIq7KILNBFSlmo3YKF4y7HORgpEOhwz?=
 =?us-ascii?Q?l2idN/Ihfhi/JYdiepbPWF5GU14Ce0uwoR7QVRFRHHwbx5dPtuePMcmsSYax?=
 =?us-ascii?Q?RsJ13uvjPTduzaB1T2JxT6pvhy8YJXiuGOuIZXXat+oMmeuZvy5TdkrwSFvu?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6APGUy/6I7vqNcdJHpQ0KwOiRFr6x1pbm29J/v5+fdLHKAmhEEFzUdXOYQX1I2Nd0iplD01Ula7ZIM5kkYQPWePqwOb6QnYc0/21cE3qanNFx0CINBRoLUkpKqS1EYpgsEZ1SHHTtaxMN6h1VxmK+s2OzD3JKfRO0/0cRpndHhRhZ0AniXvPdPH8243b5D4MBtKtJLh1ZXXe4ZBOwK62VqCN6SX4IEgd/u9abjlTcUvvFuFZelB124sCEhY9aPR1QEcH68p3SPBWFCvTdTCMqqeKCYhdrGh1tpdVi4VSbIsm1qY3GPgZG1AgQz7mcFd/ZOqvs3sTNFLYhxvatgKSjEy8x+1i0c6Db3SF62zER2yMdHOoqmhwAepnYHT3v7GWCZIMd9KmrXaEo3WP+73i5zpgjxxTDmXlaWaLxNozrTNRdCxJdBv0ikbmoNyO2flijVqB07djnb9FAp3enUvT+LA9RozpsxHajWRtdzkZZKkYxr8iZ1wo1dpqhE5NqQ3v4TtlctgMV1ag8yV8bGoJFFgMjajlNSf14o2yJT6HnM6gmihifHMmSb+ht/Z54yWrBUI6EqyNvozIEg9HRgumx+p4W+DCx8VHDcLjdFYy3mLPqSdhF5cCr8K/6LBZT0kc03q7BE7044IJ9aOzE1TnfMVHwyhYsREbLgdRQkf87D2uQtSQXerUgI1ofBiAFsjsKyia1d0+EKdSOZrC9+MCkZI/oYL98Jy5SfT3+HptWIs1P/cF7p+uMTIVT9IUi2E+hTO3T027yskvxzmiZKAbUJ8MecuujyP5v8T6w5/lOWq4bRIfr9DynqEAmFp0fpT783fIkV1qfzmi7QXLYOyVfRn3Mrst2lDdvIDOGSqYDycmZCvTtWwP0Zm+wucqI2jXBrLuycQdH9d/WGIyTWcUkw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bedcb2c7-8e45-4c4c-e780-08db4596d31b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:10:29.3438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1x/9hgqpXCuPycVrWTFYungAKfTGUMHhm+bHlta51dPidddZwVsTIVK1pF4Y0EB0+GGo629QhVF6dUEjCtRWYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250128
X-Proofpoint-GUID: SL-jpWtxVeWocq1cX4LrM9CCghPJsP9L
X-Proofpoint-ORIG-GUID: SL-jpWtxVeWocq1cX4LrM9CCghPJsP9L
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert loop type to ensure all variables are set to make the compiler
happy, and use the mas_is_none() function instead of explicitly checking
the node in the maple state.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 60bae5be008a6..dcab027b73440 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6740,15 +6740,12 @@ static void mas_dfs_postorder(struct ma_state *mas, unsigned long max)
 
 	mas->node = mn;
 	mas_ascend(mas);
-	while (mas->node != MAS_NONE) {
+	do {
 		p = mas->node;
 		p_min = mas->min;
 		p_max = mas->max;
 		mas_prev_node(mas, 0);
-	}
-
-	if (p == MAS_NONE)
-		return;
+	} while (!mas_is_none(mas));
 
 	mas->node = p;
 	mas->max = p_max;
-- 
2.39.2

