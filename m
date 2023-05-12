Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5086C700EB8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbjELSX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238456AbjELSXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:23:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFCD10E4B
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:22:36 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4KR3002765;
        Fri, 12 May 2023 18:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=NpwcPm1GcD71KNuEXeXQ/C5WFCoC3jHOpQsDf+skUYA=;
 b=f0qvYQeQZEnlj6nPCRw/wQHw7OfkKvrzbnw4+T9/o9E/3XJhK4ejJO3EaEsBaefgvSRW
 QQ0XfdM7eEXbhYwkh52sKvWxHCnhDlmojEkdzMIJZcbytM9aTGInq1v9sFm9Z/PR5kEI
 cjd7MaJhzFSEegElsPwqEyOHjJJvhJGWjhnYi8Zx49Op0pJKGRldocpwQyWX4RTanOIZ
 fuwj4GB4x3oXFcFC5AA2mgkMmiWicSQFf/zR7rswawbBLs70RpKLdHTal9hn4BFVtGvc
 zGfYIIFUduCwSPkGC3xhNOeirrolO/PdVOogsP4HviyMNFY2AOVvn9L/XQgzquPTxXC7 Pw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf777bkwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CHe6Ex014369;
        Fri, 12 May 2023 18:21:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf8316c7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGQa6E9hvyrF1ptrRUrFohxBR9TmZkp4SlKhGk+tgy02alvw8DUm1XwUK7IJUzgcbyKhBAdQkBJOKXVEID0RpIS/9fu4Z4i8EDDpsEVKmo8V/jwZXIZOq2FwD4/InJqH50R9aNjrJE0qc6gjFmexRmeRYR2ob3+fjDsGFQ2eLwCJ7Q/+f5Ipm9R7w1JnsSgVSTNEQIGXdM53yg0W1/VgIs1ZLnbL4/HP1KFRlN8eSX8FB2IZeFc29u6XG95UVzmKccHFTJdmDlWmziGvekwwYmkNVw5ojmZMc0tdr1H2f5hJRHT6A2Z8vZnv5MTlKeFTB1BFz6vWruh0YcDWXm6bVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpwcPm1GcD71KNuEXeXQ/C5WFCoC3jHOpQsDf+skUYA=;
 b=SdshFs3zXfvOKtimhW1CDscG29kAhlFhADfrgiu7Wd106gVSc56byjlpbndYm8KAlGAnH0EoU4YE0AnoygmQqE5G6PlACgIJWzmjbhqfSndThJhWf/nDgygOnJYFGE/+H4MkGJOGxNgGawhvzn/ksuXSK0bAsXFcUzSOxMDYkunZ1Z8u/UbTVnFJx9Cof6L7m/JtFJ0j5VRIIEbkSCUe4Aq+KI6d3SYnQfYFtj6rmVO4LMw6vGsWtWXZlmig0dNdTIa55+eonCOkcPsfV2uQPdFaeZ81y4CQrvfbq5i7SjKr5I0YJUrAqkfMu7EB5ZK1sGv47lMnH1SnwJGWgyKVwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpwcPm1GcD71KNuEXeXQ/C5WFCoC3jHOpQsDf+skUYA=;
 b=m80POWFPk8tjrfWrg1nHXKjTdOwE+eoyG1nQ01sXB04T7TAy4jy+rNjHgr8PitssLkl9TLBtHIMk0cX9fr3w/dNZFbpkjTJpsGAN4Xs4o4kUTsXYflUwkql8jdEejl543R+pCj48YXEBmBUye8RcZvA3+YcxG/HvspL8/3lx6u8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Fri, 12 May
 2023 18:21:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:21:37 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v3 18/35] mm: Update vma_iter_store() to use MAS_WARN_ON()
Date:   Fri, 12 May 2023 14:20:19 -0400
Message-Id: <20230512182036.359030-19-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::20) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c3b1b4e-032d-447c-5907-08db5315b974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xym+iGjq1oMyf4HxiGUy0TPEEiM06k8BXBSRIr76BhjnSvvLw4j3U0qA7s1+2k1jPhc1IQOwFDaDgRM0uqEAJScwFmGDNfLKZsJ7MLXgJQloAl6+j1azwZXH7thdy+wz3wSoRBrRSMRTk6oyH7Le++GsVtGlnrHPBmBr/S3WVVpCHn1Rtf1nMhl1uAcu1iDGTVdYYEV65u2Cm/PyuiAtpMZbZewUA412my8XFOntl8oRZqfgH2vcKlbnxumtUP3sPK+qTc0lLtlJkj+Ck/0dN8R8BpbM6oGz2rdvSEz9Eu5h5RBvSATWr3Ez23V7/Kbh6AZcdRDsM912S1EMwj5MUWicwuWNzz873odyzTKVdeH6TeREUyJOLiOemYBnlNxJpYyrbnwcvUrIBMNxskmRAyvYyVVlA5Bfqje0Gw/Sy3AoyMD2YDbRhE86Q4Bc3xy0H4G4+3M0Gp6OjoKGCF2CgblUT/Ysqpfs/h4W2bQmoMKLTLOKaZ+ie6bTnyTTVhA6zOiLkSY25+h2R2EAHmP9XkYjRzk/1zv5I3zOC6hdck2/4hpIRO2+gZBqp6Fj0cBW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(2616005)(8936002)(8676002)(6506007)(38100700002)(26005)(6512007)(478600001)(1076003)(36756003)(186003)(4326008)(2906002)(66556008)(66476007)(6916009)(15650500001)(66946007)(54906003)(83380400001)(5660300002)(6486002)(316002)(6666004)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ImD42Z+Z0wV3PLPnP/HeT17jYRFW5djwI3WWL38uXuu9sszmrAqqtv0JyrQ2?=
 =?us-ascii?Q?P15KyJTx7LZDsAel+y1jUWZwXS0Xj8g3ebCXvQmcD3n6V2TN2wQbDH1kF2mI?=
 =?us-ascii?Q?P/8JQxDJjhkIkcwjl5LVnO4N1FEIV+e2rgEY02035tUucUXK0n1KYJAc/z1E?=
 =?us-ascii?Q?u7gPt0dkrSjHysXQIuooRL1JNRy401FRyDcWVBxo40eDpcTvNlIZOawbpyLY?=
 =?us-ascii?Q?FjKc46yRA/JjWp2wGjY9INbknhZ4+zNnsWTFuViN+49hqA8v1bEMDf2woI1Y?=
 =?us-ascii?Q?UxV9rJymEZIwGoXRF+FhScwvefOqLWBZpC0t7OPHYc9wgPvDVYCvFgRFtITH?=
 =?us-ascii?Q?vsF7TENtUNiKG2xoAYu07OZOAIhDNhXAQpJNiQtD6GRTR6QXWtfNh4rgMxCc?=
 =?us-ascii?Q?W9a/+i1o1SLkxExoP9yUV/4Bveepp2zt2QaGK44ccWoHgIdUty6Pb6/eIZ3/?=
 =?us-ascii?Q?3HCgWMW7hSBx8eQBWI3bh39/kA67U3BhDfdV0zHiyx1ffQ6NlXxRPbm5ATu9?=
 =?us-ascii?Q?o8ewCLmbzplveWKlpfFA23Kp1DHySuv7CUWOetwcz0Xgz0OoZhrg2m6aWx5V?=
 =?us-ascii?Q?+lh8ANk/NH0/XiBbqtg80rma2JaaFgY3OsuV//8WdlOAyWWUyV91qwy7jPTZ?=
 =?us-ascii?Q?1keZHIi/wM8VruBiEnmgU/oG0FK9w/GzhspXfhgKkt7jPr1J7TwvsdFn46EF?=
 =?us-ascii?Q?foqsULfeyeTHCGRsZ4lbQCIQ7UP0KgRC5kiHbftMstyb5wurwCESQU26WDLC?=
 =?us-ascii?Q?rkpx009dzm5Ya3ERKIeJpnPsZUEjK2FSMBRLUIMASAQT0cWVfbepY10eIF1m?=
 =?us-ascii?Q?6yXl+UyR42xrBrX2+8QT3EWEcQxlhIHoELA58jUG6IYx7id+xXzUhxE9E/l1?=
 =?us-ascii?Q?x/zQYSdtY6+pKV4uOXmMf/Ih9EDl9tyAj+UfFcGEUspvafb/IvndhC49svvD?=
 =?us-ascii?Q?OlfFpthAkvbYYBmNBShrwLnmTI0uxuDzl9HEQlirCy0XRjtpjB4V0nX9+/YZ?=
 =?us-ascii?Q?1XA6hhPPwrECdTY+ACznBEScu1cgiW5H08OwSDV+HG5/MiHkewBehkQ2DOVg?=
 =?us-ascii?Q?gcl8bI+JgjJBO0gsFaRBoxFf8LIa/oWMySuU4gtRHSs+uLhZtcJd6sLK2FTU?=
 =?us-ascii?Q?GFeMsGnLc/I0Fk5P1NzR2RRuI6PL0tnBDSMcZ8ppgb1YUVyDtomthRJBU9V/?=
 =?us-ascii?Q?LVghdZphjaePXEfsFG1WM5YjHxtheIeB+ylIWTuJSY4cVc8nrnSQxlvecTXk?=
 =?us-ascii?Q?EDPICw74pvm2mmPV2RTvBC8Rczm2jjjGRvbjm/xiXju6+1AyqlM5OxoYkLkO?=
 =?us-ascii?Q?aCS5h+Bzik3woMFj3pqLMbKKFD8nZKICt5Ena+5fVgcpFn56IrpSbM0wIHXd?=
 =?us-ascii?Q?6R7CZwaE9UDZkLTFt3UCGHcG0wL15l1blqn8oi+ApqLmr2txfGZ1qdMJb01o?=
 =?us-ascii?Q?8elx5haGEWwAhK1Z6pJginJIf2OB39ruAwJu4arxpmExomSFNLgQOX0boh5N?=
 =?us-ascii?Q?K3AcRwSbVncOhjZKsa8pNQSCK7ewKnyq7Zdxt6mv5bQ5dLtCrmEpQw9elS6N?=
 =?us-ascii?Q?/LbLbTax1+3ZpUXQ0LqnMCswA4Y0ixCnRnMTnORbC/G6IGNj6a/2k3HWr9yd?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Q2OF1G5U/xAKb0WjYX8WbBxlLCOmXx5OsMxQ+2dTT40D2XKMRTwOZO/CQ3hx?=
 =?us-ascii?Q?7DSExbiL8hHNeDfB6wIJW054sH41xQkcEyDlR4bkrpjRQYBBObxQP6eIMQPT?=
 =?us-ascii?Q?XNkWrPc6wFGofXYncJA4WSl4n2WBWo+4hiLM+YOOimDD9NnKT8ricpC4MKO/?=
 =?us-ascii?Q?Yp2QPc+yMt09C5j9DbJmcmxzhpAUrKuyeWm4C32rrt1PBEaryiQD6z6WW88D?=
 =?us-ascii?Q?J/Bni1nx+BTzrGHKyK7IjHkabe+ymWz+W172qf48a5eyqkmJYWlSwb4uEp5z?=
 =?us-ascii?Q?p2dRE4an/PEU4w/ho4zTcY400U4+4eF67sFy/SmyNkXJxb80iyABHvNCg04p?=
 =?us-ascii?Q?KvE22lDK/4DpHD3QUgL5z3cGf+xKDU5Q4YktBEb6EbBCvRVDoBuiOv3EdRKW?=
 =?us-ascii?Q?1/Rq4PzI3NJt4Lj1841YSOgQG12Bhmo5cpwOMwyuddoCHNdPhCCPNX6hdxOv?=
 =?us-ascii?Q?fUSJtbs4JoJGjqrYZdsXC/VDmYdSgM489FFUHiPZ42hg7NluaYHNgCOsaR8q?=
 =?us-ascii?Q?ZU7xn4uJbJVsMf7s/dayPTirwENwzDrR43HHVNbVqbsBxZLJsyfpjmYWzcwO?=
 =?us-ascii?Q?Jf4zIg0mXZ5jAiuWGQzhO208RekJc048s0Ybk2th4jBZlHebvq8LBtTlWduj?=
 =?us-ascii?Q?Lciyahism6Zxl869jpd41Nen7WRNSOhG79x0D5G2elM2LzduX7PjUIY4SeFt?=
 =?us-ascii?Q?KWG3B1HkbPDV/Sd2SAXCTgFKEKSF2+9PpZwxyU0OPptsYaijQ3NpNtX77MdH?=
 =?us-ascii?Q?uKKF7QJZT6WFmdHJQg4jz7NRagu/CFg3hnljqbvy1vdJQIKFBcPg9ikKYnuo?=
 =?us-ascii?Q?zwM8FqutdSbJlBOKhCCFKYuO6c9SaDngqj8F3M3d37XolkagDQTa9+200Kre?=
 =?us-ascii?Q?osE/tgGk3olgNtmvAZxHi7HUX33Bkqcl5pgwkhdVnFaMO6XxCKAkH80IXh45?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3b1b4e-032d-447c-5907-08db5315b974
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:21:37.5598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbAcE22UYR2CNgpWhDdG4q4nJc1SYGHftOkJd5MGo4UVswR3u35mP+qmkyxBo+w4mtLxiK37+hhgMh12uJl3Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-GUID: 0bu4JhqgTqYzhwYItFJNFcRu9SWm6LVb
X-Proofpoint-ORIG-GUID: 0bu4JhqgTqYzhwYItFJNFcRu9SWm6LVb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAS_WARN_ON() will provide more information on the maple state and can
be more useful for debugging.  Use this version of WARN_ON() in the
debugging code when storing to the tree.

Update the printk to a pr_warn(), but this will only be printed when
maple tree debug is enabled anyways.

Making all print statements into one will keep them together on a busy
terminal.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/internal.h | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 8d1a8bd001247..644fa8b761f5a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1047,18 +1047,17 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 {
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
-	if (WARN_ON(vmi->mas.node != MAS_START && vmi->mas.index > vma->vm_start)) {
-		printk("%lu > %lu\n", vmi->mas.index, vma->vm_start);
-		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
-		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
-		vma_iter_dump_tree(vmi);
+	if (MAS_WARN_ON(&vmi->mas, vmi->mas.node != MAS_START &&
+			vmi->mas.index > vma->vm_start)) {
+		pr_warn("%lx > %lx\n store vma %lx-%lx\n into slot %lx-%lx\n",
+			vmi->mas.index, vma->vm_start, vma->vm_start,
+			vma->vm_end, vmi->mas.index, vmi->mas.last);
 	}
-	if (WARN_ON(vmi->mas.node != MAS_START && vmi->mas.last <  vma->vm_start)) {
-		printk("%lu < %lu\n", vmi->mas.last, vma->vm_start);
-		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
-		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
-		mt_dump(vmi->mas.tree, mt_dump_hex);
-		vma_iter_dump_tree(vmi);
+	if (MAS_WARN_ON(&vmi->mas, vmi->mas.node != MAS_START &&
+			vmi->mas.last <  vma->vm_start)) {
+		pr_warn("%lx < %lx\nstore vma %lx-%lx\ninto slot %lx-%lx\n",
+		       vmi->mas.last, vma->vm_start, vma->vm_start, vma->vm_end,
+		       vmi->mas.index, vmi->mas.last);
 	}
 #endif
 
-- 
2.39.2

