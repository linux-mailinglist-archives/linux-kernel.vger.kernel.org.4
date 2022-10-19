Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B604860507E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiJSTfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJSTfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:35:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0AC15B121
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:35:19 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JIOUU0012333;
        Wed, 19 Oct 2022 19:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2022-7-12; bh=q3HrbbuFG1zPzGRziGaR245Xk+RU6lNvHRVrBcCXn0o=;
 b=Pdy6Zmskqd5E23bAi5fHLYOuiFyBoSCBJlFvjYEzQM5eS0EU3JCWdTN9VMMt5veziZHH
 28kpE8nkDdS1KLu2FCREIaH0QgBFl49cUuHzX5Z/Ab+pB82w6qlzbQqK2aHl+kSifkYQ
 F4zgfiNso3W/X7vim2qiehMtF3AyjVpULtn6i5MVI4k7lwFodGVP+OtpxqgaNa7XK9DT
 exsJlKDquF/3B9lCcS5FGX0h1OAAkGIQaYNXyDJ+vbOa2D31yVD03mS0UIAJglYu5SbI
 qIzR7+fHgPgZahtFFkVjVIEUSVS8TvcYb600RwfXKxEB8Ah0oZLZQXRdzs3OZJBdyNSl uA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9b7spg7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 19:35:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29JHoApI014612;
        Wed, 19 Oct 2022 19:35:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu95223-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 19:35:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjPuph8rpRDtkb6sgAWpd/5ymlI4mrua1OUHmZi8aSlLS31fx8HT4/4XIq6aCt+GaXG6kvGVJakqjVX6/wPBQpq09GfPc44P0KjZxxgszQ44MYxi22T6CR0gZ53BP7THo50HdT+qB8BOjmpC6PDl1972qVWR0AKClv+92iUp6Q598f/ouc3wyJR+Og+HrQufh7kqiYwsGhPeCX+ouKzu7bEB5qhzMmxP2P47EA0EBxFeyLovQOFXGH+x6EQsipcghOKYbAiWvWbsE6Ys0aTRdhhCZhufEdW/MEwurbfXE/vZwZQ1Of4nFK5gmNdbceY7/uYVvnSln5o+uogrrbALQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3HrbbuFG1zPzGRziGaR245Xk+RU6lNvHRVrBcCXn0o=;
 b=mWv/HPjGbFfHhVO0IGa2ElxUs0jqAKWIxsdnEZCa/IGA71wpTpigJQ1HLfCBsjncsowXlsOgZz3LX783yqSjSB6wiZ6qbMh/qmLL5tMr8x33tP+YRPLnn08QNhffy+QsFmHP95n2biBRy4OMyiKGovHVLwMyTbgX5YFJesTEZwl2NnnHfV7K/8LM8hXDmMtKOEVZUub6Au83JNFNBiuFBIB3K+585ZR69AMNDxYKPF9q3V6DUXwt+uE4TaInsra9R5H2NXy8MPQWgZVa0pQjGruXjpaPFC78ZNNFJHkjDeCe3Q7rA5stfzXWsGIBwA+fL9G3KoIbvQNCcEI2DdQsbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3HrbbuFG1zPzGRziGaR245Xk+RU6lNvHRVrBcCXn0o=;
 b=YD9nNgTBPlwUVIx9hJIrHgeKcdRgHtDsoSIHZJ/Hm378vMMc2/EwiheCPevQEGrGWT0/RixW2OIPXCdJAxDnk8JlxgTK7IlvT6asW/0KhLojo+3G8WkGjpkKS/trOXs2FLrCEr/SAIyJvRRvV7WU3CjzuK9snQDwvStlHphM5+c=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CH0PR10MB5274.namprd10.prod.outlook.com (2603:10b6:610:dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Wed, 19 Oct
 2022 19:35:01 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 19:35:00 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     wangkefeng.wang@huawei.com, konrad.wilk@oracle.com,
        haakon.bugge@oracle.com, john.haxby@oracle.com, jane.chu@oracle.com
Subject: [PATCH v3 0/1] vsprintf: check non-canonical pointer by kern_addr_valid() 
Date:   Wed, 19 Oct 2022 13:34:30 -0600
Message-Id: <20221019193431.2923462-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::28) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|CH0PR10MB5274:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb9cbae-1a8c-4956-77a2-08dab20902ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VlnHlS+l5LcAhiKPSqfIQ0BFBf3V5eNSeBfXB5g2nwHLW6641w60AYs11xshF+Eel2JxXwBGbS02WJOjeMS7RouyFtt3Osz06Vsxy2hdU0H6lXhtS+c9n1ebgwXOALlL61mn8ayFQi+Wc8FGN+ReEWxwZU643nSmcgZqLRAindJpiyCOP0b9KE2ob+zG6L4uuj051QggjCkV1OnK/Aofmw/FpsaCi4pXID/DlDy2cfL843aHIaPcVEm5dOKRKBqpF3u+B2rTkHBX6J8jq7HYYZ2b7RHCjTukoCZjmrEHZ9AG9em8MLHqzqf+kCHl3MHKGlfuQBZ0jDLix9CbkaRAd5qEj7hh71J01DFRy8ItorWMtHo2gIA1E2yqfYgRoV+H0vxjOMLHG4/X00psnD7MVXJx7KJiQTKoKo/YIGIQqjui6jm0/oy09t3ROFvGiqJ0HgnseZw36jvT45SR2Av7CSKJnCLAEIWDS1FJDQHMVlB+5+aM5/hfVIGUuelgmJ/5fdDSHOqnOANVriWxx6MWJzcL1ZH+wTUGuzHtCtbCNleeiBeXuw4M3h49wJQQdVohU9lDwyc9/SU5aVWlqjFu6y2GeGJqCXnn0n4I0IKtTFvmsr3d3mjO+qheAyvJFjxPCAwVC99RNQ28203CUXBjDCli0c4k7WzuLSGEDekynIQmUAzEj7A8EnQm9hKdKKh5+5MslSlWHmQ1HK1VYVJjylQsw1a+CFBwhhHTwfi2BRBFAQugbRChHMbZIZUfQm5apFtNJCp2ek4fCKSyAJj/fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199015)(966005)(38100700002)(478600001)(6486002)(186003)(6506007)(36756003)(4326008)(44832011)(2616005)(4744005)(316002)(66946007)(107886003)(66556008)(8676002)(6666004)(6512007)(5660300002)(66476007)(1076003)(2906002)(8936002)(86362001)(4743002)(52116002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uplvN3cslnYKaMhjD5+2O+bFbyLZKhkMGfr/zqETUlGszfgmm33IgcNtmgw5?=
 =?us-ascii?Q?Ob1qL/Jt3jrQH7Wn+2BLOcclONxIhOkQ8DL00spJE2mHxpsgiaiYSSsgEaSL?=
 =?us-ascii?Q?pXDE1RAX2CQIfjF80+sx4WajMP1mKVza0VDGqTrN9WipgBRy1BMljcJAmSFN?=
 =?us-ascii?Q?/ljfch+bWbutbBlYIOu68Pvyj3K5gjWQmN6kfOPuEKjVc/t37RLqFjxrnUVk?=
 =?us-ascii?Q?Y66C2SdsXmM9yFIE+WkPW0rOAzuR6zqwF6zd+hzlhdykADQS+D7nsWik+NnO?=
 =?us-ascii?Q?4weebbSGMgN6FYuSWCGMn68DXGy/oKtlnhXAD2QAEDL/tYOE+ZayAsx+HBZP?=
 =?us-ascii?Q?UBIbhp7vMR6G4a2saFhl6HQlC2vFM11AXCZJwf1AuVrKMJx7lKU/tdLupoWc?=
 =?us-ascii?Q?PGSUGFxkGuI9TQ09BtNLKGR8lDnFz8908osNJXZzRaoX8TYy4R6htq3Nhp3N?=
 =?us-ascii?Q?p3z8H3fljD2wQvwA1m9ZMx3OKosMEfjcnWDFhHusQxTeOZVTzo5Egitxou3O?=
 =?us-ascii?Q?aXJ9Sl7pIBet6e0ney09kjq3viDxERzV7wBD3u5LquXIrs5e3Qgoqpu8T/CF?=
 =?us-ascii?Q?7Wmgqj91ZcUtDgE5T9BsJMCJsqjLilv/DHM/NtYmfOscN8ZH5+pTsvrFx+V9?=
 =?us-ascii?Q?t1xFiU7rD2KcEtXM4WnAAWRb+3kKgnA/GUu1dZS2g3L/yQvF8zS3sregsitV?=
 =?us-ascii?Q?6GQKfUIS2kSeRs8g1mCfPxZRTxMWLqT7ipneCWKrnXEzZjV4YlSLp9RWag3B?=
 =?us-ascii?Q?RCkHWJfX0bPxri7y6P8IZkkhGENO4ukJ1wT+Sdnm5wehMle4XTtH43q4oQ2T?=
 =?us-ascii?Q?Q4/LtHx7vf+3SZpmjUZSddO1eolwoa3F+lP4hZ1HijE2V9p5bEhZElfzLNKN?=
 =?us-ascii?Q?IOnvIIJhZWs9zQ3fe3K7CiUld3+bhkZrPR8NmIiqYhoPWXPfGDJqVVHP5Vxl?=
 =?us-ascii?Q?YYf5XnDyWk6DaDjusG2cN4X9P6Qcfp1S5k3RNtm+Y9MifzeppPajXwXGEPk7?=
 =?us-ascii?Q?BIb4OgLvi24ogh0zzIxD4/e7flgkCCZjIGmZiGUS9x36T/rMGTtzoGJro2Ya?=
 =?us-ascii?Q?iev0K6xWT9vE/uej9rqv4CpmDVkLadKJB+oGQQah7X0uHzd4ooK6MPcXmggl?=
 =?us-ascii?Q?OD2VOXCeT1syVuK/tZpZtCZopBGSn1+Ck5qSGtwGE7SmNbLS1bCl5CSg6K9y?=
 =?us-ascii?Q?J7NyxvmOUcRFNalJaXzxlbE4mMBPyp8O068Ph1VEG8lKI/AW8tP7pwJjB65Y?=
 =?us-ascii?Q?xSiiYYtfPlAtx22YA5VxHEUmcI5lcIXN0HQcc0MTyos+MjGqIjcjMulDkuZj?=
 =?us-ascii?Q?Oc1uAVkwxRz+0KBEkv/Ke7ZnisrxyLO68Yht23CjWR/xk3FJUiy62iOGzZ0S?=
 =?us-ascii?Q?AiozlHtW/GycY5MneVoBNFu0jKGYqVbErP3MwEcwB2bKQnVmOfLbGEdp8Ell?=
 =?us-ascii?Q?4N/9G4i+MHsgPHgD/T5KxK3X7A0yWM8CM1AfRL4C6LOx5s2HaF04yP51Ey5L?=
 =?us-ascii?Q?oOLDEUY+JpNe+7/22oiHG6M7Fx4vMOPIyBZLqgI5SDsFNoRveVzOIrniecx3?=
 =?us-ascii?Q?7Z5bj2I+uAJy9aC7ccAwbtk+1WW/79a9IrmhhwMVdevJHB+tdJDUa4MJREV7?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb9cbae-1a8c-4956-77a2-08dab20902ee
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 19:35:00.5134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qopetYT5WvdM5v8u3P2XR4SHbu9irmcS/7q4Vi0zou3G0nPFxT85pCgQJ3f2N+qg69BYObtfv82O0WFqqsfmbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5274
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_11,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210190110
X-Proofpoint-GUID: e9OI1zHnF6YtkUk2MBYviomF6lSPs7IL
X-Proofpoint-ORIG-GUID: e9OI1zHnF6YtkUk2MBYviomF6lSPs7IL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2 [1]:
 - revised commit comment for clarification;
 - cc linux-mm for expert's review on the kern_addr_valid() usage as suggested by Petr;
 - cc Kefeng Wang in light of his recent patch [2]

[1]: https://lore.kernel.org/lkml/288a7aba-c647-b51f-bdb3-99a62449dbb3@oracle.com/T/ 
[2]: https://lore.kernel.org/lkml/20221018074014.185687-1-wangkefeng.wang@huawei.com/

Jane Chu (1):
  vsprintf: protect kernel from panic due to non-canonical pointer
    dereference

 lib/vsprintf.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.18.4

