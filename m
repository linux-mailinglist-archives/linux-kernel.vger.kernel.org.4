Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3447069AD89
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjBQOMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjBQOMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:12:06 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964186C036;
        Fri, 17 Feb 2023 06:11:44 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7htpi012654;
        Fri, 17 Feb 2023 14:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=EUQ9jrYGLjpRq//gECwxFDiVTTwm9KH4T8JbXGUh3ho=;
 b=nmowHlfKhtHbZNrYzqnUAjaFk2Gj9MDtXMh0YHD1CWygv/YHjH1i77tV7whEAdOwNI9N
 +NLAvZNq5dS6OfT7XyUZ4mfG3YJ0W5BIpTP88Fx1LIJMdNIdQOYaCjdUZ9Yy0hD3ntgb
 cLniSlRPKPX2Rqx8w6G6cYGxvbdFrLnvG41pVuMuXz5gg2DqsIlL8opK8hXkAWAd4CMw
 uJPPMRuFk3an4ZbQczehrflzLwKCx5Fwl0mzdckIqFlQZwKOurtn/WhCh3IGAUHndhbb
 BthZlPhFl8LDXjPAjT5B1WRFCn2jl6ozpfgyB53K1k0ac0RquKP2NR6369ZesgARRVde lg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1t3nw65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:11:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HCV9QS036087;
        Fri, 17 Feb 2023 14:11:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fa6s8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:11:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKWGS41KNtopbLOuWElU/2uGxQsEbil7zeE7n8pLbcwqPLcPFrIgQm93kHbAwMe+vdJ+VHUYkUY3uIk1/7I4mBa3z1Y/UpOdEb/bHocMs2e+N2yvBeE9ApxkIdyxnX80wix3kPQpkFTI7GT3/iKCkHis9iNBKjyY7aAPHW9d3r0F1/r/uPOMAhxpk6KmSzKcQAcHDjmHKiG2gOo/IVLZrw+gsmraSCtxuAdVcjVhyJy5Ozq3Bsl5Hpyh9w7+Az3OU4lzpJK1OMW46LEZAsVP9NCP/z7cBvecRgAKhHetXw7v88/S5uGzjLVt9p6CGVdOflM9tUJwFEOMQ6QmUYyq0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUQ9jrYGLjpRq//gECwxFDiVTTwm9KH4T8JbXGUh3ho=;
 b=Hqy6s/+NV14Q4GZxa7HyjEBTAd1PtroUxCP8McVmkSEa9Xnt2GZ7tW3jxv3O7KRsL2f4QZ+2bXrzCfu03tvtWhvAulSJ0AO/CHhDVtI+5cV440nTCPPn7w0NNsB5duHWwgHBSi+F/wVsxvZV3LDKvpBGB8sZVz4aJvit3WcO++I/g9YAG9oUHht9AGWT0Ofjjb7ozHqPH7pSXbgDyaxVeqGx3O4c1QNQ2NfBdn4oakJNAecdfH068XTg9AaB3Mg2Eqwl+gqG0DPrnf85s5cTnKgpfLR9Vyidq0+OsOoZWb91ybHURKbzhllFsVhekjByN1RsDGjH/XW/jP0FIkArYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUQ9jrYGLjpRq//gECwxFDiVTTwm9KH4T8JbXGUh3ho=;
 b=d0vPAQ0QWHIutXYp2ShmlSgAY91CUaYK+IqvKX0a5klPLfnX2GGql/hQxgK20QsYUZl49hVKJYH9DmLZYqDC2SCjWG5jZ31y3Abd36ZoAYThz4f59FReW9MtyHk8a+fW7TFLHXfa6PHtpFIYxk1KSdt08dnNXLIsMlMrQR0WEoo=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by MW4PR10MB6420.namprd10.prod.outlook.com (2603:10b6:303:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Fri, 17 Feb
 2023 14:11:28 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 14:11:28 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Talel Shenhar <talel@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 04/24] kbuild, irqchip/al-fic: remove MODULE_LICENSE in non-modules
Date:   Fri, 17 Feb 2023 14:10:39 +0000
Message-Id: <20230217141059.392471-5-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230217141059.392471-1-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0056.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::20) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|MW4PR10MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 479eae32-eefa-48fa-35cb-08db10f0dcd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +45Ppw9uOgDRmsmt+1GlVqmX1ETiO5v/bWpdSpNJIOHJFGLGvkeUI6apBN6GpUzL+er89JmfqMQMvRcvr7/JWBU+Ay6VoqNXOe9OMgheIdoawRa71SkMfgANP1ln/e2pwePASo8Z3JjSvSAxDdTk124vrbdX53hJzMx7AzgB2Y1wh96Fu92ROSDlIwfrX8fsaRYKbQwhYr9nmDktQqu/j3ej2b6qoZdRk+yZMUu2cJPj1c7YCuW9yyd5QeFxs81rYikYkBnjOYK0wm0iYYqUehTQuSAZvROQi0w6F6y90AvpI/vpER8LDUaW12nwtZRn8aYU3DkKbZGZomItESK2eFrphZdAkyn0Qjtf8QbO3rXoZRl0LV9SnMdecZ6vbUZHFAQOfGLIh/tlYjEeKbNzA8mSQNFYTi73jtECViy0QuM5UZHPtZqhIhzXUdXZet3yvE3pHKay3O8+VagCi9hDGPq5H+tIEukjEYXXwiPwc5Ipz9goIqxEAH78VFfCIjVKcgfLOEad+nzFeVuwxF8W5YfnWZErcnmkWxmQVa0CGk2c3dCUZQbH++Q4J6E2uxRgFs9e5GE+hX+EN1XOYw6jk/7B01kI8X+2VM/RKq7Yb+ESByRr6rPgg8xdfXJIJAowRrvD0lj6K8xwlt89hH4LTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199018)(8676002)(6916009)(83380400001)(54906003)(1076003)(66946007)(5660300002)(8936002)(2616005)(316002)(4326008)(66556008)(41300700001)(66476007)(6666004)(6506007)(186003)(478600001)(6512007)(36756003)(86362001)(2906002)(38100700002)(44832011)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3rleNz13kGJ6tUsVxO6UfZuKE4othq14XP+WJwQkzumRpXqe48OrfrPL26Go?=
 =?us-ascii?Q?qjc1O6pdAey2RsIAaS0TiZ+QToU3AWcr38KzKgcZzgHleN5N96Rrmk2dLdW/?=
 =?us-ascii?Q?ozPQZRVMscO7AsnwSUS/YUOfGK13UmDglk6C72dq8K7NY6JfRpkoSaOf3+Fv?=
 =?us-ascii?Q?4aOZM7urx3/QvPcbtNU8nSxUkFDISNJQ171THX9dJgryVUk3CNX0/47yXHHl?=
 =?us-ascii?Q?GNQ9j5hO8OiU+zbs7NT4CjoiQn8NwkaEkK6jNub96w66Z0bsQ4LvXC1/41eq?=
 =?us-ascii?Q?kVb8XYw7GartDR244bZ3KAQuhEE4qhgBSWjC7QcEHbWNc8j6LIhYNF9psFkA?=
 =?us-ascii?Q?9Gmdz7Hs+kRpJVXlRVfUMjX9K+lqjJd4jF8VceepPegeLktvnzIH4XcDVuox?=
 =?us-ascii?Q?PDhnNkLeFUG1d8Cbd0ttRaRV35yjnHkD8koZhAYrveMw7KZa7GiOSBtcIBVc?=
 =?us-ascii?Q?lzDvIke4jdD/py7WtcPKIUlOdvNDRdEHYgeznW+LUv71/Q3+fmhSetEBbBsp?=
 =?us-ascii?Q?/9BNHJVfy237E+WXuMFAahySVVEeQHO5UKEnam0r9SblcxRev7A3aOBf0eUK?=
 =?us-ascii?Q?TTld3L9/4jNusPT7FkY8YTvx4ZnoSbwcq3c6Xs6nQfotEx73nUACjW0SFSCU?=
 =?us-ascii?Q?mgNnrljNHm07sCzmc+gFqYAyevG8JnTGY3q7DPJ62O33AEetdwlbWZH8qI9K?=
 =?us-ascii?Q?j1o9IQIwTmNRj5ElgrIITq+CQOUeJpSbl4BOsfEUlrWc61F8oQu6p1oH5las?=
 =?us-ascii?Q?SZQkj3iZc3Uz/Gfaz4XDn50HxxP0dkI/udWGq7GR5OLSbXmcTQJE+Kx72ihY?=
 =?us-ascii?Q?Whk6RuRXLt2twGCkBD8/gnl8DTDtru9tWOsCb89LzesDPpb6fLeU7MzT/3yI?=
 =?us-ascii?Q?dEi6thptANuaaWnLYKTrI8XJsXraoa40syA+AmORVn5GnXqh4LoxC63fFIGO?=
 =?us-ascii?Q?eS7V++3MQpnzQWz/Yxo7ZepbOne6Yd1DYuNJG8V6bzBGOo6daIBzRaC4yIUF?=
 =?us-ascii?Q?Y/cI0J/E2fKUWNfvOWMoT+lxxBaIztIFsBE3p5X1ovYASkxLVR6QqczCOL9i?=
 =?us-ascii?Q?cw+Xv1FQ6BreZh0Oy21SoKwoHvuMytzn4VE6xrOcg9cbuKVjpBahtZgM0pC3?=
 =?us-ascii?Q?op/kCU2PO5oLGpiJGtnXUiaaUxh5Mht8SVyQ8hpxi1vEigS1hS6OycKF2VZa?=
 =?us-ascii?Q?jSYJ5UOnWn4Ac/myFCkhTClv8B22M/bSnAEpx7SP4i2FWf/N6A9NeuqE1kAZ?=
 =?us-ascii?Q?DcdoQtEXYudUmTLyPJpzT1CnDXt9u6gy47jl4eH1XXMJUntNao5zV/ujW+tD?=
 =?us-ascii?Q?ZgVpyaDjLisQcHKOH3vTnsk+bySUZMThJ9MlmYbO39m25DGiraRwRFmI3F70?=
 =?us-ascii?Q?fY13sIaFmC380b2G89AWTZI+eSDpyMZVyoxtyrvLeR8LFz9SfdeZoEg7ymLB?=
 =?us-ascii?Q?5j0nCWutk94/+RkPJ7sQYZdHn/Goz3DCyUXgb5BXuK7JAus8MDHsNvzQouMY?=
 =?us-ascii?Q?ZfoZ0OTd5tzZOxLKlA1eFJjJoSWD/+h8A8tC/Jt3fU0vrWESmca8qT/sx8Tb?=
 =?us-ascii?Q?esiDHT8rbBPC347FEWhCiTCDpsQ+Tv9ZrFABgb2y+/JI+7AVM8rWDo4NdFyg?=
 =?us-ascii?Q?gyxBsI3ypPXINqxYuRVzziM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OW9LDsiCwmc2QhqBckYzvm7Jf/Ok5xW5Bu7HZaO3YYzVw4bE1igPdx1rXk5yuxlix2PpEA0vIIbZCTnt9QA0FFaUdWkuftyOKFgjvf+y1wfCU4crChuLEasfS58++ex+k898UcLgPBKHMfBxT/b49wXAcLPsYuQyXZb74T9XamLl07woCRFBOr9WXhqZXhIMgk96f/HwZWOGxRqQKBhVVlLuHeShK7KFd6yl2ZrLa8xtUcOedJigGjtsxBFMdWUhDhyobOQuwO+/P7mGe3GoLb3GtZEQ3nHLdqyivpORsIs4Tm2sXzAqJYi5n0jfZo2WuU0iD/pPfAynlHn/YbiW44yhRogiSYQk/fr34IlyIPgZZPl4wOnjdBIPp26ycVHBp54DyywdmirW/mn/mBUd9lf+XGdCgRzcX4UpLC4hnVGayGIgYb6TZp3aSgYkFbzd76jsqqNoVCYmjvB1uMTl+Qd5clipP0E3au8d/zPHVZ7TNA4YpWm1EF4tWpdhiN/dkOZa/pw55wnUZzH+dTseEn7R1B2luPt6wlU3buI6QA1lGd9VzC6DHHxGeQMcsOE6Bu3NyUX/CP09LoLIvKxQ3oeDbnqzP3kmFj+Ge9GgrhGZg1XX1+n+xh29u3fywy2w99Vztx1jQIsYneF678uZpavon7/aJOaqTudJA4Zeq6p6gqrh80eH7X+PHraOxnfGqaszkHjA7dWP2dju1y5mUaTX260L8TKdKAUa371k3SFy+UyxOFMPvOAbiA0RQ3if/p9vudwjmaKq9Oya537E/RBueY1Xaol0AIhlJMTWhQ1GR25GwEZFOR0fGa4ZIU4ssyEsKT/PmDtQdd5srTxXNCk0a3d/SwwVkNSSX9yZP8aImHorXB2exfN+wB8sfRGY5UQEmJ28tPOsJudzDxjUFw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 479eae32-eefa-48fa-35cb-08db10f0dcd6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:11:28.7528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /j1owlZq3Qh4ZZfF0ayv/DPUvhPWNvliGnx1FMMP4utGMkSVjT0Z1DfXgmJJNNOpKLcClvRD9ynuqJZT6HM3fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6420
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170128
X-Proofpoint-GUID: fnOPKQ_iJ4bKBGFukjDXOvoaOU5pYq2M
X-Proofpoint-ORIG-GUID: fnOPKQ_iJ4bKBGFukjDXOvoaOU5pYq2M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Talel Shenhar <talel@amazon.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-al-fic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-al-fic.c b/drivers/irqchip/irq-al-fic.c
index 886de028a901..dfb761e86c9c 100644
--- a/drivers/irqchip/irq-al-fic.c
+++ b/drivers/irqchip/irq-al-fic.c
@@ -26,7 +26,6 @@
 
 MODULE_AUTHOR("Talel Shenhar");
 MODULE_DESCRIPTION("Amazon's Annapurna Labs Interrupt Controller Driver");
-MODULE_LICENSE("GPL v2");
 
 enum al_fic_state {
 	AL_FIC_UNCONFIGURED = 0,
-- 
2.39.1.268.g9de2f9a303

