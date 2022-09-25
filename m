Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE875E9489
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 18:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiIYQ7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 12:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiIYQ7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 12:59:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6B12B277;
        Sun, 25 Sep 2022 09:59:13 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28PCSnrh003824;
        Sun, 25 Sep 2022 16:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=NmCHfXGm2Ce/d4eCQqGTIFWeBL7QqPHNJkiBlQdaEsY=;
 b=IOqAzVS7F2/FSb4LPnf3jcxKZ5Hqvqou9LFuauElFDEUVyL/aqr9uR5ipMuM96RnjCbq
 GDymlbih3xaI0GtVDr8cMOS8V14+oGeoZEMNSH6ote8O+GmpAi3ecvNzAnsHZOwGtdTK
 ohLi6eU5gZFCG0282ESDsUO2SpOwqBGm9eSNy26LA6mrRaszg4voAOoFE4NG5ExecF6L
 ZXX+RFUEFO/FJldP/FAeHBFye45ysmAhrpGvev4LY1cp3vcCauxYYpcfcTdsIvcnUIQU
 yHCV27EXpAmyvXu8/5+mb36CV2U3l01ynUjHFJF3Tt0/oAfgS27IJhchqHfy9DFQBlOU aQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssub9x4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2022 16:58:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28PCI9Jo019153;
        Sun, 25 Sep 2022 16:58:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpvck8cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2022 16:58:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuGqAdQaihvdqM0gaF3gq3vj2ZJa/d04kDLeSDN/vhQh/VGn7lr8ZDYQm4kaE5T9ctnW4kvfA1pIxQBShNyDpSDHyHdGTL2kYhlgL81Ns3iDEpmjEBJs2x/8s6VpAzK4sZJwybjWrs3gnul7mDEa/yHoLfJjNOyNcBC6ikGjcNRK2/C9vDfLGwrDvYZ0w6l0hQhSLbEONAkGt79Q154QxpwFmNa90sAmDFud9pAugBjEMWCV87darsuCJXUdotlZ4FSmBUQpYH6pOUVuZpwvorAYfJ9tnfjIfJfmXQm0G1omnZYpiAr/eXoHLlcoyvrBQ5Hls03mMGzG7r0cI6CIWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmCHfXGm2Ce/d4eCQqGTIFWeBL7QqPHNJkiBlQdaEsY=;
 b=O79gEnoUlMJOtqLbcmnRAiHhB6dZz9mLvCqv3YKOnLJgKSoME0BWlp8sESct09mMXEiPei8MQY0C3pDt+OeORPlPfQ9IwIFth4iA7s7k8fVy3lkbWs7qPen5HuiZ42MkvpN+JsJDA086csJpzaTneBFziDpmvuweqpgk/mBIpu07SIXS9DFRSy/7OrjQV+YocfrBtL0mNPx1oCvGOekfMsDo4GuBSZcGeTXgHCB8DuQp80woTUEeykc638MJgaiktxoo37diRaBtvZjfz5F8/hwx78vnz89UVGbFGCtI1GiPIRCph61mYF9Yzp/DrHdlJhSeLIfjPm+O3DPe5QU+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmCHfXGm2Ce/d4eCQqGTIFWeBL7QqPHNJkiBlQdaEsY=;
 b=VhHE+QH0/rlZTwOHRokjU4Bt0Eg/AXzOwJfXuCZxYNVJGFPO25wTTSJjLVXn3hhcrkNWUBG4z2Mnzi7EwYJmlLRZX2hFJlF4qOGbTI+6geJApJU42ZR7jpnh0YEmQKRdMQtxXiCFtDW6u/UoDylCMsgIiD7w5zGFWPWsubF57ts=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB5687.namprd10.prod.outlook.com (2603:10b6:806:23f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Sun, 25 Sep
 2022 16:58:56 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351%5]) with mapi id 15.20.5654.020; Sun, 25 Sep 2022
 16:58:56 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] scsi: pm8001: Fix running_req for internal abort commands
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zgenqtkt.fsf@ca-mkp.ca.oracle.com>
References: <1663854664-76165-1-git-send-email-john.garry@huawei.com>
Date:   Sun, 25 Sep 2022 12:58:53 -0400
In-Reply-To: <1663854664-76165-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Thu, 22 Sep 2022 21:51:04 +0800")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0319.namprd03.prod.outlook.com
 (2603:10b6:8:2b::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d178ac-fc72-4ec5-70dc-08da9f173b91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YkqmMyIXJB+Ml91cnpo9rkglLYsVUTdxkwZPzZrGKuLzZzIujcEdRs6Ec/rHC9lMZ97VM1Tmb5yVpM3sYi3sB6iHOJW/lshn/Q7hizJC8jkoZkTcjLaGTXXc+U/26zGTvlfIygQsZPeQo0s7gGoi5mZPqqu0YdNURkD6DXFAwV7D/BF7skEqxP0lZyz2Gedzx7DOz8KlXLSPeN7Xb1/vHtQlDuXWQMjIh15OFrh+ot+Fi83Z92F5KkbGQCvcp5poPht5Db25BcVF8BoZBgQTS1jCdR+qwQA2+ytPMCJ3ffJ4c68tybyQLkP1tyDr5hfkIVxH3pqdQIXJxfc0ZfL5HFRGI3/EbZmfAdSgnGahuoD2Q4owdzoqhe9eBSznYVdiIpQqItJFmsERaXSpzf7pDvdIBgXfR6jyaHev5J0kWPe62akFAR49HR6iyRqd0JUmYFSklP2oldeG7e8rxAs94uCHF9QmjtXiSLYFBsovxqZ6ZmbxVvUVU6ph7qNBWmDaE6rj4es20042wb6GcRDokWwofadlaZe7WapEjYHsdR4U+O6ksY5ALEZ/ltOurQC5dw3rLTIr1Acaj+e5C0qZ3Byze54rBM4J6qnkQRRj0FLy+2lpThaMPET9x53Q+pMtON5nFoKH07ufuvlATFklTQBez2dempGkxDJyKIOSKatEfznEgu7k4SzqTT9z6hdzuFCu+4MYDwRjjFlUDhZy7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199015)(54906003)(6916009)(38100700002)(316002)(5660300002)(2906002)(6512007)(8936002)(86362001)(26005)(186003)(4326008)(41300700001)(8676002)(6666004)(66556008)(66946007)(66476007)(6506007)(36916002)(6486002)(558084003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bZCmsV03Vl9rvc2NjpuVpfkX9tYg08QA6zeF3YQJQ7Wms1qOsjTIeWw7NFnq?=
 =?us-ascii?Q?ozeKcltSjJ4JvLe6EduAh3977ufEpUwkye0hE6J7PkJVYSqC5+dyuz614W+5?=
 =?us-ascii?Q?cZWUytxPEp0hXuvpRvDzMB5Ir+PcCB8cPZiuFslNI3uF7ua5daAhgc2V+XXx?=
 =?us-ascii?Q?PFCqEnVuLvfc5SddGqeJnx2oyfFw7vm9y28YSrP7ZDHJzTHZFLkX2KV6ZuBC?=
 =?us-ascii?Q?hA8qycksRwDHUb8sKob1jgzHJeXM9GCRINaOAHieog9s4/d/3qHsOHMEjmdP?=
 =?us-ascii?Q?MDpayT9LFIMY4NBLqvOQZRDCir64oarYutDUaiNphsmYNmpz50G9RgmweiMA?=
 =?us-ascii?Q?okvssocTDyl++W+lX3c91qkLHVRx8XjJ+DDLrJjlIOqFSChEByzXK+WxoiUk?=
 =?us-ascii?Q?iEs9QXogqHJyXs0K+unCcfRT9hk9j6HW8c0yfhlJzL5a7wBikyCAs3dY4vOi?=
 =?us-ascii?Q?bI3k3E8Lj3AcDbaKtzaN7YsO3Kp0oaSqdOkUYwqaQsAlXp8JIrNMoQSv2g9n?=
 =?us-ascii?Q?3cHP2BR0FAxiHCMZXOoGeErxOIZXzDS7JZBjcuQl8N8H+b100kWpjGsUonZa?=
 =?us-ascii?Q?8/+BlxBn4UeNYazjqqOGYx4mXenA6p3Eo7fJ8rnsYMzrjnzN6gh3O0V+cA2V?=
 =?us-ascii?Q?dRCS/d5LlKvy/trxUfSvzf9dfmiQovgAcXQy4Xr7uJvxUwlIlYYhVvWZzJ4M?=
 =?us-ascii?Q?dG4mU+GmeXaQjOCRtWd5aeSkNFAxI5WQleoP6Yq2UqdYrblEEvBEMNYfcP0e?=
 =?us-ascii?Q?FLYR1yDLUlMs16x+Ndrt66g7qt4FpVNbLsw7Sey3slYH648hc3M63LAK3LoF?=
 =?us-ascii?Q?srlSA4PKPqFi3ve5+Iysm6BZ/BINBRL6gkf8hf49xlYgzLbBxz3WkIv22W1v?=
 =?us-ascii?Q?672mXddRLalJ89pxbgfqvv0g/1eDJKoOez8PANbJz+nM9ZpXMCo/eV0nSE3i?=
 =?us-ascii?Q?VH2SjeAEwA9HlRhvELcI9o5+/SCA1rFmUh+0zJqwHAIc7z5RXjlo10H/e2PL?=
 =?us-ascii?Q?f+J9YmPSZ2nRRXt5pNmRsPzmtije2j+nO8drPK/byavBVxO6N6ojZ2De/SA1?=
 =?us-ascii?Q?XBVso1rxiD20SiKM2tEy7iP7APxFQUcurOg7PhxIEGdHU4GvzG+PzoCKbqzg?=
 =?us-ascii?Q?ROXp6a7E9C41twkOElTZgYesGoCpbSraSktuJjKocrc4+NjLmnmXrYMxGoxJ?=
 =?us-ascii?Q?NUAflLVxUIKIFb9891UVDCj4P4eAzW1rAwgYNNhIoSKZBGb0LpggqPCqgIkX?=
 =?us-ascii?Q?TxbY76b0NRvvoHtPu8VXem3PY748kKylaW4sl1fQLoc7sbmB/DiwIH2RpeDo?=
 =?us-ascii?Q?tmOyGJqDqiGANPmIYtG+6ghNqfmMHOofcVxx0/wuwoUceYVp2M67fgMoIPZX?=
 =?us-ascii?Q?06vOU2fY6XIh03Cj+USnG0RSdnfxkcfDPWz0C0hrDHO5+VN4j2nWHjKWYQuw?=
 =?us-ascii?Q?9C0L06Hp8enpj8j8LEheVMts2I+L+kGlMb2Q3a19zdCi6LG+SRFqSYrQM8Nq?=
 =?us-ascii?Q?w32LTp35XDBPppia4ZN3/sbgkXm6kWMmJ8jf5YG9Y+vVen1X0Caw8w5PGUTS?=
 =?us-ascii?Q?6plcoQDg/zykhqlwJWR2gJmQrmgGh5irqvbNGZ0rougwXW7S2zPtT4nV/vN0?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d178ac-fc72-4ec5-70dc-08da9f173b91
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2022 16:58:56.0203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1aiuw+G5KQcuwSKZAQtxKMxQtSmjzlYFUJ588ZU7Sfl+ARwBNpVuHrHUm5IJwP9pLyxNBGKZVOWr79/ChkipyQ5C/G8XmwnRkwmg1RkoIbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-25_01,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=988 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209250124
X-Proofpoint-GUID: Xb1kxDgtlXoWoI71vl5DjIrjUs_QyZz3
X-Proofpoint-ORIG-GUID: Xb1kxDgtlXoWoI71vl5DjIrjUs_QyZz3
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

> Disabling the remote phy for a SATA disk causes a hang:

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
