Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA6D6022BF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJRDhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiJRDhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:37:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFDDA0279;
        Mon, 17 Oct 2022 20:29:18 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HNYFXn016326;
        Tue, 18 Oct 2022 03:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=ZABsweczFSgW6PhsF8k+XbSqatvqBOcNb7aDH/oElAc=;
 b=KHugDr98SPRuCd5I6atNW9x7rJTvL1D+gE6qlDBKzLkGEXr1T3tcCvu4lCdk1afYsLl8
 Qj3M53ugMUu9lHyVUUSjjSjIvxlttWORivEClAreWMzLDfW6RSK+JeWGN3d20Z4G4D9n
 OvEOgq5KaUw5kO+b/9YxRBh+cbk/TcFJadZ8+A88PvW8Hep9jFH33iCOid7in4GSXcmG
 Quha1owbaV7/5fh8EFEN5cKIR4GGAZF9dx9FtRFnHFzA6IQToNbSJ2p83XXYVD7S3uaY
 vpwArqKvciVrs9WEUkYkSwxpIinm/ZGHZ/Ko3KJt2eXpV0w72bRF/3vloFyTNZA/vh5C Sg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3d9ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 03:29:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HNfE5L029768;
        Tue, 18 Oct 2022 03:28:59 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu5numj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 03:28:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgLNwsUtf/YbBC9dYM0USZW5dZTl6NmfEZJV1j/1QDInqws1LAQiNzHRj+kz1sOw0O6YSv9SfUZLcvgUREjhKcrzKB+2wU1zMm0Z0lvXXyGPxlv3JxqbGmbBjvjTpPSQf7F9DCB7aAX9VyEIULOdt+unYqRsJgEZbodWbV46LYfv4q1gxJYCDQb5HA5fbOCWrm5R98pg1XBDquSe41/jzYHH4W7EhAm1J9IniTdKVGnMC0ie94n0Qt2Y6qRMlIN55B1rpRPfM7XX0Whni41seWI/mf2TyP9fzCdPgr1LLrauTdc51hSR08tcuFKFZw1wieWAy+M7e2GkQHThgQPCAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZABsweczFSgW6PhsF8k+XbSqatvqBOcNb7aDH/oElAc=;
 b=EzjfjyRY69kJ/gX9HFupRkSxYA5biPv/Mq810UGUuaCD73Lhnqx49rIQbPYlOB65yr4T1a+86uinOrX9KU5V5tor4LMdoMeFbfiGSidiu8XAMepHMGmCT96VehuhcBvOiVoSkaBKBZODBePvHo0Ehm1Jj2DAkSSnB94KuSYtAp1wNeWrMRHiZmQ2tJEenj9mzNdVlQ7kM1ug59x1EXuRTZEStZypPs+1/BDNdyo9jt7wfxQ+lIBU5verG4IPhq1hlZW7SMlm9C6D/QUR2jUfOEXcq7tpquZPBXLZzux9+1AvWz6EpK40d8glfK1tuj1L8n56giPZoVzsWo+hkrzp7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZABsweczFSgW6PhsF8k+XbSqatvqBOcNb7aDH/oElAc=;
 b=Eg/44FYsjg0OusiqXEIgd45y95uvdAgtY9vp++GLXEugwXaCF1Kz/tGFFerTOUoxgSP0oEoOhe6PMv2MVufd1AzNo1imAJvHKLY+eC42/1gtyks4zffimyWgQ9mOJrqOeKr51BNpXifIQm8kVIpDAnblOaQLJJYykbU8xkPMx6I=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CO1PR10MB4706.namprd10.prod.outlook.com (2603:10b6:303:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Tue, 18 Oct
 2022 03:28:57 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 03:28:57 +0000
To:     Jason Yan <yanaijie@huawei.com>
Cc:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <bvanassche@acm.org>,
        <john.garry@huawei.com>, <jinpu.wang@cloud.ionos.com>,
        <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v6 0/8] scsi: libsas: sas address comparison refactor
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11qr524k3.fsf@ca-mkp.ca.oracle.com>
References: <20220928070130.3657183-1-yanaijie@huawei.com>
Date:   Mon, 17 Oct 2022 23:28:55 -0400
In-Reply-To: <20220928070130.3657183-1-yanaijie@huawei.com> (Jason Yan's
        message of "Wed, 28 Sep 2022 15:01:22 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0217.namprd04.prod.outlook.com
 (2603:10b6:806:127::12) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CO1PR10MB4706:EE_
X-MS-Office365-Filtering-Correlation-Id: d71f6e1c-a5e9-4efd-7cfb-08dab0b8e3c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FShrmLOmRTFk9FAJDjNAsJ7kL14+/zAc3XzUB2Prav/5iFqmDMl9y4F4NZNLdXkALoUPwY6dXc0kRhI01940umh1xwdlIlvwIFf0SxvbEu/5BhCbLfwcp/sPRGBtU1/tB6Du/zNQWbQeam+Nj5Rb1WJgRU+ZqQBctk26Yws6TNXKbMbs7YQHOPtj5Njf/aQ8KhNQRTpUIEZc2ulpTw5hB5NEh3YduOJTpw6zayAUrSBUiJQJkApPSo2eECPVava8N8Z1XfJumPeivTY/A+WeS2mGDcyiIopJX93hB5MOPOjetn8u4E4/mblUiIX0RPpz3VLsSFFbmVpGsUzSnlX82Wzj5DChaXEUyMNhEGX2QxQPuF4cvQGb30PTvlwDLn2NjU4o9aOM8K8rEKkW53jjMDHBPzwUmlAM0yqINFdM9ptC2y9vN2lEMCWJ6BDl/8U0trX+UdSjbO10amJCUUG7yVMms/0WerpOttLHOWFH+QHKQhJLpZ7B4HsILz6DmcPf/qBmEpL5HDsrAfY98XRg+qyX2dB8wSXND90wn3ZYx8uMGU8Z9HvI8oeiV12NYrL3+Gj4UgdroAGfRMeHu6jTGGbTXU6Kakfrw8+bid5/Lq4DfzHAisG0TxwKrzvXEJxjcINtHqsgSNLR/isln6o56ec/b9vG3hjUuKcHjo3jkjm045rBYFGyWlI4ZwwSIgyr0Ww8wp2rlxoklCq8o3v7JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199015)(6916009)(186003)(26005)(86362001)(7416002)(5660300002)(2906002)(38100700002)(8936002)(4326008)(41300700001)(8676002)(478600001)(36916002)(6506007)(316002)(66476007)(66556008)(66946007)(54906003)(6486002)(6512007)(558084003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kibXbdkn9+rO9Qvzz2MHd0BVWhDdRT15VODL/I6w85xZ2+FkbQIdazCVN/hm?=
 =?us-ascii?Q?s6kEsnkIYSyQHGwlDX3SE8gcXWmqJR0S3slpcfqz4ctDk30hNeHA92av3QN0?=
 =?us-ascii?Q?eo17Oce6KGQHZXW93FKPDy/ZBIuysu+kOTKcSmGAaB05xZaSPbr8tuGW2Zuw?=
 =?us-ascii?Q?7Wgi2F4cub3cr5lcEDjXm/9wLZTrb+YeQ1MJXC95hrvTLYerhqOTZSsQmMUC?=
 =?us-ascii?Q?Vl2vfB8VfL1+7hvocpm8EDdarHUe1Z9x49snqVtnOQSlH1VrY7g2pjQNCPec?=
 =?us-ascii?Q?4o0ieLiF4iAY99IoxMpuZDoqciUQ/zdrt279AwyrVixRdpBKbx7gYGetjn+Y?=
 =?us-ascii?Q?OfuGzeBeD9WLqwKxKCEMJZAc49nTSXgH3RnZkPa9bsQqK3u/R6qCehqX7oO7?=
 =?us-ascii?Q?GwYW4XQxThUT8OqRn/ueRmUxqnk1MWXFdCX/79oSRebFNBut2dhXSSWiulZ2?=
 =?us-ascii?Q?6JlVxpFs4Zy0cMzuiQNY9ScPwrHfpAxArmFBTppQf86L+L90gR6Ans8Lr6VU?=
 =?us-ascii?Q?8ImwOhnUmWsg0reM1IYwgXHyhTEcp32PYf95eAjnEqZW9AXUnFHc587ctYEu?=
 =?us-ascii?Q?/mY/ze19VGk+zpFemd0aQoNYdRb92kFoEqspymydjMoV6rFACvHzUIwQNmcc?=
 =?us-ascii?Q?4It4tyqsAX2Kdu4ZPb27GxKKWsSlwsLJehVyzgNjlqi7plF5YiNHOJGwilml?=
 =?us-ascii?Q?wjAyRG14gwLsQAOXLXXjMdH9SYDjvVRfgcf1ANwvG1G6WOLR2B67zHdAzI2k?=
 =?us-ascii?Q?rGSnAQjpH9nZqziLrVAW+xp0+2whCYdwHmSQKH2mR8fUzJm5mVoMus8kdxKo?=
 =?us-ascii?Q?lT79xJhmqCvSEmBN3KHxh2suprrfIJFjUNpIdJuu+7pRkZwIr0oLQf/CPc6L?=
 =?us-ascii?Q?b5FLBhQ6+J/yy4jEVxwNdLuUMm8aWqI+KgmIzQrQO+q7mw5EnheoRd36c2W5?=
 =?us-ascii?Q?M9V201f1ElHm/np0tMf0SA1yX51GtaA67EeLNlCKs+zRcuMy78Rc5kE6LJxu?=
 =?us-ascii?Q?YAwVXpgHkamideel7vcQmUD2ZL0ifAacTUn1ct+SAaWpfGHqHmBYvUMO+z6p?=
 =?us-ascii?Q?LWnM8qdUx6Z6URqkaiOcBTjtQENQLr4CyyeUUfu+BG4mo8hn9rX9IGACtgr3?=
 =?us-ascii?Q?9jOEhb3u1jCn6VZWlywTfwgrw7tcgpvmh6P2XQl4i/Tpsi9Kv/RMDGkpGoCF?=
 =?us-ascii?Q?lYpjtTz/G55qYqDzXSvvjISQiexDtoTipAl7PsN9Op2j+reMDpbQWNJ3NInB?=
 =?us-ascii?Q?FYPPokrqsdl2P2GTjO6yHg0qoPlbeEqe5TYPzsugPmDMxUS9DDEi7ofYXiss?=
 =?us-ascii?Q?CXKm2rjQ5AItzTUmGQQKV7CVhBAcPN9HR0TfoyOidCsY5wcGGIilNTLAZYZo?=
 =?us-ascii?Q?Dzf813AasQ6KEg/LmV/Ffi57OozFL3zJ2YBVXQ3nyfe4KW7pqZOy59qc/K/5?=
 =?us-ascii?Q?jxcT/iTByLWA8zx0IoXQSWiqWMsFMawh638GCQpMT5mnFogu4opsVR6CBYKX?=
 =?us-ascii?Q?c54qsmfwO270rBf1wAumukmT023EvTXc5RpFuV2o/Shwtwd1UEXGzg6AdaDS?=
 =?us-ascii?Q?o8rkMsJqsiigcsv3QtzbZN+2v5BSXS1WxPUBJAXsRcDYgcAskDUbdfkegX7g?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71f6e1c-a5e9-4efd-7cfb-08dab0b8e3c7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 03:28:57.1130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBPZJ4LaQ3l/3TY8GTzHHxboq1SgADIJwwt5F52bMErtyBlWQp1cTx+chq27IST9FTAIH/m4+py4GYJgp3T7kjdjrzWGy9xzTC4UFw+Xte4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=964
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210180018
X-Proofpoint-ORIG-GUID: uJPmEGUtOxNRnl985_gK7iaYiERFtaNS
X-Proofpoint-GUID: uJPmEGUtOxNRnl985_gK7iaYiERFtaNS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jason,

> Sas address conversion and comparison is widely used in libsas and
> drivers. However they are all opencoded and to avoid the line spill
> over 80 columns, are mostly split into multi-lines.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
