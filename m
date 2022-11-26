Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACF9639372
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 03:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiKZCjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 21:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiKZCjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 21:39:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B105BD48;
        Fri, 25 Nov 2022 18:39:51 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AQ2AKvO016781;
        Sat, 26 Nov 2022 02:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=hIiJE7MkTiFcwJgoK7A+wqYiUrz6dwCiYSfJBtfomq4=;
 b=ZHc78YCbCy/UBtWEXu2neXT4ZO3jjo3iNvH5n8t67nh7U7yDsxiylP0xzZF1tWkz1AF2
 CF1mMepwWiPD7N7NhlqxwQsYOIyYl+os60wtx4iA/WIfse96FkDv6LXOBUZ8RQiUGnPF
 I5HuahafYd//jkST6771Y/oTwtvq2zqpJ8EEG0CoWqecVTiOuVmGzUAmce4+VTHV0S0z
 PtI8p3JFdjc7TmyOrQzMfP5IdK/O1WYF8KR1mxdf6C4BGS+fQ7ocXWp3GhDdfTX4bfky
 nWZ8dzgYBBoyf1wqb2Pt3EDXV54zUe10CuC7ABbg5f0pl+n6BoBUz7KF5kXe1YIeqMCH 3Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m39dfr11d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 02:39:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AQ1X973011728;
        Sat, 26 Nov 2022 02:39:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3981ss99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 02:39:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzhNto55Yh+jKRu+X7Co7be8ifUvu/Py/fkhKG3ZWWw9xQbA9EXl1889k89GG+9UH6srywhnHvaE1017XYsPOCuFTvUMOGcSf2EMXY8ODwg1P9UkMRzfPHnfgdrpoo4yyHgNRYdftZ2giwa5GX/ZbfRgbOZlfdZRTa9VVjqPg5Dze6u6yF5hedtUBmMEW47PzLrlqN6wWkl4IbazWXN7Wv3QPRtklkEXaEuRhEcN4i5KHs1zZ1Lnpg1zwUHqBfZotYsCQIqlXXJnlVLuCsxMjqPdGiFSpZDc6gldbOf4V2++YmlG/QT08KAxSogY8o8orjnEWRFJpGQyyDEWXKcVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIiJE7MkTiFcwJgoK7A+wqYiUrz6dwCiYSfJBtfomq4=;
 b=LvZC/hire5LtHtyAWiSxPAVeT5n0FZLt7V7itGgcpBuSsqei+isY9gTqioH1O7CBa0uFxuNSPyMl6kpH6g1nvKn/+QjY6yumSqAw67FXxhA0F/DWKB1sTgtCziAP33gSDuIOhW+XZFrJB/P8LhGe8j5+nJp2dPdzd18hZHTp5SWMfSXxFd7CPU1hkS/wvmLIerk7Cpc5naKohOB8L3C5Hhyz5wp6WU8t/v4YLr7LhgaIwWrSynEFa+k1IGMDUCDVhvYHOvufX/1t+DpV5E2zW7cs5UZlyU5gRU+iwVPBM61tejYSgwvP4YBtolgDDmuG9hetME8cWdD2mOmWpVU4bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIiJE7MkTiFcwJgoK7A+wqYiUrz6dwCiYSfJBtfomq4=;
 b=no/xq0NeokQ1kp7chSXLDBWCM5kN0L7GfC5D31pD20p86NidUtIhdDgYbVriiqQqjIyGk/RyH+Y2Ckee58RpQjCJmDQ+xbl+ZZKT2RKvZJS3/hG/cbsJe+BLvIz54gapyQQ+PBjwmQSxGUhtu1npS/u9kPAl93mcR+1em91eNaU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA0PR10MB6426.namprd10.prod.outlook.com (2603:10b6:806:2c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Sat, 26 Nov
 2022 02:39:46 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a%9]) with mapi id 15.20.5857.020; Sat, 26 Nov 2022
 02:39:46 +0000
To:     John Garry <john.g.garry@oracle.com>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        damien.lemoal@opensource.wdc.com
Subject: Re: [PATCH 0/2] scsi: Some minor scan improvements
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zgcemobc.fsf@ca-mkp.ca.oracle.com>
References: <20221121121725.1910795-1-john.g.garry@oracle.com>
Date:   Fri, 25 Nov 2022 21:39:44 -0500
In-Reply-To: <20221121121725.1910795-1-john.g.garry@oracle.com> (John Garry's
        message of "Mon, 21 Nov 2022 12:17:23 +0000")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:a03:60::15) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA0PR10MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: 28034ae2-a7c0-41bb-f5a2-08dacf577b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mZs4oTYawxGACrx0JdPCHKN8YShfVmdFm/2+4jL9g7D6ZDXpvczPZt1a7UUrX3Dklxrf+aB+8NFAnh0R0g77tPMdrbrKFQ+ilxSiM2YUb5xFb5B3YDye7cPshXTEKSi7IyNVZgkmJhhaLJ8AlDZ0b7p2KcVKZ066LRAYHm1fJgWIzuMfFdEMgNChtoZmdpquVQ5wOHf+r20u2QNFPuzBEBTYNWv9JIUcOU54Ay4vJ0Gcv4km86YBiup85vRo0sIgQmp9YWhTgx97GbAdpn+b1Zv9Yr4K6ajPRVq/5knKKsWhkhEgHAhiB9BOxqLyalRf2aT90IsyW4iYBTJMKG/nGt74mbue077B4gg/lx124vLSjao442GCZGPGgQixX1LSthLbkYILvyJtTLlnidr12fRdm2Bt3mvLkRLyhKAPxchVaEUqDuwbW4yRFnxQ7Dc17ETwty+BS+wNTVXpBnAP8cXqjSEP+BpPQCfDEb26YR3xZz7Mq3cvzYcR5czkSpepvQMGLRJeSFfKPONLB8e+sPi4qRTqvSkdA+eezCzvUxLUjuXFRzHOoQnnjWegpvUB2XSLnpIrajS4N2txAohbsw4/KtRGrKnr1G5P0QT6S7Yhfd4lCXxbXcTMgk/O79nWuUNu1P6N9SPET9Sxt6rbaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199015)(6486002)(478600001)(6506007)(36916002)(26005)(38100700002)(2906002)(4744005)(186003)(6512007)(5660300002)(66476007)(66556008)(8676002)(86362001)(4326008)(66946007)(6862004)(316002)(8936002)(6636002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VAlvciECAyb9Max60NAjS/Is1ohabOMRzmzEwYUi9+hRS0bywMETnENwhfc3?=
 =?us-ascii?Q?N1HnuZIkiSxwDvv/fKHa0DCrxVk7IN0htAsrX6QTv1jEItBqgsY9wzyg8nBy?=
 =?us-ascii?Q?AtqTiROZ6C7eSxBW3lPLdHZn8GAxdfaElc+j13MxbWK+ySAbJXNUaPp+j2Qz?=
 =?us-ascii?Q?AJ4sb7AKaIMPeOOvywpTJy6p3+mhics5GQUFBPPC7SggpLNrzNmFOy3Hm2T4?=
 =?us-ascii?Q?ugGquYBtvIP8EirRYgVWuXi80QChKu25u8mxuIy9m7dOo0fqCnSClbyMOuyV?=
 =?us-ascii?Q?ftBbziBU4dpJpRLX1TSVYFWtIEE/BM50N64OlPK45F6Dska01SiO6LBaYtOl?=
 =?us-ascii?Q?xKqKzLQVyzXXKd3FkzxZZiGqB0c5GvdJxwhtLD9xyADJaa6YOuyj23+wIpSJ?=
 =?us-ascii?Q?7unKm9HZTwtAOKLHLhjSfuaplwWFoIxMLswxcYKylXegRIQXGgC05ZOdOgKT?=
 =?us-ascii?Q?Q/LumMeQIeF7E/dOO3ULH9058jjwnBPOxJV4R1sd9RoUJ/5efj19KGKoAV9L?=
 =?us-ascii?Q?fkfqJkL+VuhlmtNbHkJc16NVWcjo3UMSKcHd55j5YeqAAlp8aymLOb68mfpX?=
 =?us-ascii?Q?K2RRv9zWR+zFf91UoCTXGieG9dHhWn7WCVMBlmMqsrsYmMKgvH51wji5KICt?=
 =?us-ascii?Q?aH29dQ6Lvcc2F5TbCax3f5yabqdWkPG7qwKBpIBSuWCK4nh/RT/htaF5NxKb?=
 =?us-ascii?Q?SZ0466MpN2tfg61Ni/SQyuGjJwZLGIzDHj+Vz7e8Y83sAO7QpRe6JEZzxl8N?=
 =?us-ascii?Q?5gApniDm0FEmIw4pi1HtNlZVJorUTu+HaDh3Z2L+jcSbgTw78fwDIMen7KHK?=
 =?us-ascii?Q?MFR9kIoi9WTc9UFYXzGEKl6wkmyh5KJMwFQgDSvJEpKFmz3t/gay+yXj+/VV?=
 =?us-ascii?Q?vBoVoxkIBSGut0ypdwZkp43JZ8HPi6BArm2nHPfc8B4YoBAPPEVDKPfmvYHG?=
 =?us-ascii?Q?StUr6e+Mi9qW2l0rMJh5yiIRON1bBY6HuMIk8S0eagSbVG2sosFl4kfzJTwn?=
 =?us-ascii?Q?GqZsfnbwNlo4EwgUNzhKdpx5mz7FLg3LNyLcbr49rAqevOACVCMqEFLA9LMu?=
 =?us-ascii?Q?D0TVztEz7fNgF/ZEMBb8yVq93+a8H5R557XftfQssY4bs6moEJasE598rspc?=
 =?us-ascii?Q?t4uD3cQ/TIoCJrTlcCWcINOfo+5jHMv9zzuXZt7R0LHxJD6OImlXbbq1GljI?=
 =?us-ascii?Q?t39Xgt9yT6sXnuizIe2YZFN6Gy7i5KAzTK5e/N9VYUe/3EgiMs+0kiPPZBd3?=
 =?us-ascii?Q?W45MDrQ++bG5lOtZf1i4kpRGCg0FjDE4+MNhDSAtsNdJC2dMwdmQ5sk37Wqi?=
 =?us-ascii?Q?D+VYH8V03ouBt5D9iCK6/gn12U22bP1NvsZDMDqQ6k7btmOr38UwnS1S678m?=
 =?us-ascii?Q?Yt/+rl2GlHgCJUdEyelGGFMed01vd7Ahuv/ndFTjmS8G7/piUtoZGavZcUA8?=
 =?us-ascii?Q?oTFtxHN6vNIk+JPxLOReHQKQ32N25N6DsuWhj41f7IS5lznIoDd9WDM3/JOK?=
 =?us-ascii?Q?FnYQqoLmwTIwmUCQPgG1m14Usg72RcpQQ+89vO9UX8YXI9SytnMllH/Xezp4?=
 =?us-ascii?Q?Mh91yLC4O9IguqS1yNo9IgazQr9uWaypF1kF4u16ex4bMSfTI2CueuYvwi2N?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dAmTHqcPOex2yTctriywzppXO3pN3WOkjGts5lXDrL9WiThscVWQPBiqsqidDfTm5w3ychMXN9IwNHf09REIjN0ahJLWSHCIpht4kU/FKt9dsZDTMAc1x6GVVPK7ZbqaKiEHhBw+UX4QRZ81FvUuDOcfOUekkKAeoM5kI4gn9Xlj/NAYqoIiHS8pB+9qqJE/59fzvmkqcRn1B9qyKAB8yLCpaxVpvQKrI2NUBsRMo2kuaAQdhhkNh5+5hKe+A8sLW9NP5MlJHOuXv3O5xoSI5ahQ/8RZvoS8kmbTXLiZkXG0I6c+bdwKHDzpWUjcXZ+PB+8dG5inc4daPVez4xZ2niEaabXl9DP7ooNzL7tCF/lOKQy4CWbT/M2sZkexO75HWNOMPxbYkUAYuolaEoYP187yvFEv6afS8AJMgGbpfcKc0MS4+bVmuez8JtlbE7X9joFh7qezQKnYBbeY0vBHxas5egzuw65DXrS+n5ozafPs1lUNR/eGB1yZ9IF6xgtgO3LZgh++UpnsV+Ga9XyRO0s4iugr9twFr9RlaWoRNyQtbSA23unK+b6N3z2Vc5oUhMWPp9r5fRGqVob3VIIQRIBQx6lp26ePMKulL2yBzVVYeebEGKHpUqLG0rZ0p3v/8O52r0/uDA06KY7VLovRygXP3elmGlBf0d8heC2WkbzbFyx2qugQ7S/F8IF3W/9I+W41IAOFXZkzxCz2G4GAvC7pz/jFphOXRQh+raGqVBD8KMiw3o00rMdszRxDMOJROvYw/REsLmVwjJF6wttnpqfZex0uvX2KO8iayshQwAKql3bj4qRubyv5tdPZN90X6na4sBGq3MjfztQuyi/bxCTTUVrGzqCZEHDHYuMvzxfsQSYVaxfYNhN0Bg8WYjzML+MxLwdooFmyS76nGlSTYw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28034ae2-a7c0-41bb-f5a2-08dacf577b4f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2022 02:39:46.5539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOg7eRXPtUv0aGCR5e3SjTSIYH4dv7QUNP6NZvHSB6IxQ05hZWX/bMdjffrx/S9p3icKLz0Uxy08CNFKJligAWAKoGtGcvziO3UpPM/nQZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6426
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-26_02,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211260018
X-Proofpoint-ORIG-GUID: aUMdYyQixVHwZ34FhaqnVCtPDjwdMxwh
X-Proofpoint-GUID: aUMdYyQixVHwZ34FhaqnVCtPDjwdMxwh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> The __scsi_add_device() change is from another series which I sent a while
> ago.
>
> The new change in do_scsi_scan_host() could be combined into the
> __scsi_add_device() change if I have anothter RB tag (hint, hint).

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
