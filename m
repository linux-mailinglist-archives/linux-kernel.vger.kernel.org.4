Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989325E9477
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 18:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiIYQrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 12:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiIYQrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 12:47:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AFD2181B;
        Sun, 25 Sep 2022 09:47:49 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28PCUNYZ002868;
        Sun, 25 Sep 2022 16:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=FM9lDwpQJ61kwYUNHrBqw9xsykFiTU2Gb5BVwu3Qvfc=;
 b=breSZTHBkZZ2+Eu+COs4+s8AYBPeO8uuyOFlVeEXxkuA+yv0J+gCZR2ahb89lVStZyiy
 SagW/7xvaJu04lY7Ja5NOgZq176pJf0upDWGsWlfCmlPyFiR3sNvUE8s/VWtpATKVAVP
 xj8sCeacya8kRQpnS/qSQu21IuFRMuw73oSzZxnq8zVx17Nqf+T1V+PtX9A8Yl5ub3nv
 EjHhHPz3G7LHnW2HxSkRhjg8aY62SYuwS0lbYFZuajmEtiCGvq6ukj2416gaZcbyEtLN
 pdL2uRuHhwutiqT5GqEuPMTqXFQ2ayGbcVSiUVqzbUt5eVON28U6t1guh7FVmSrlKg6J Dw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssub9wxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2022 16:47:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28PCFrG4019667;
        Sun, 25 Sep 2022 16:47:45 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpu8374g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2022 16:47:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0YiKQCCY9KC8lrpie//8rGNEcj2rMyA8hk0jEvfi3ezS6KRm5kS+qfG4DWf1mH7u+6N1MU3bHzeFhK/WNMWDtBKbJbNx/+7wjpr4R1bqCYv0CIFSEHS5gXz5jhLEL4R21C3jMsEvX3nhJLZDkf3jTfnbDiGA9WNkt+ij6faKlpDcuPWwr9IqazF0dp4FKq0EAZSwmG9sDIZF9Ho0DNJcOZtn/qA2r1XQwmXsiQMw0Bf6PX1iIN8H8I5DwMUhtkuOINdLzuacwRiDnzzMj2oesrRUcaKARSRRwkQzugvVbyO1ZU+cNYw7QP1ag0bf6hb0NLLNsrS1Fef2Y2JwRrv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FM9lDwpQJ61kwYUNHrBqw9xsykFiTU2Gb5BVwu3Qvfc=;
 b=XO1YYqUKd6r6A9JG0Ftja4VeSjN6jaBenNpMaVAFQYCc3VgKLQb9Yq2k6jQ6XObSKF7jBAnQEj2A6o6ptQ52nVWkWQBQi9LW9w+w87uCUFolb550682YdpMy7uRGkP5iVh/lwIbdVde2vM4DfNgZx2s1iODZGXJDrMqT8VKO1Da0Ny05VE1H/WcfR+GNddRtsZ1eX5yZJsZnRHKKm3RWyKIv/6/YKsEBcE2V4+kY4BIGOYQK3Envfp9g0vNYTLxKC9YHo5cCLl30MChKA3NcJyk4iWt0GATqyPChj5fOogLl6ytci+xKI3mGnKz7YCwgZQxNuFW5Azyo77ocu8xJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FM9lDwpQJ61kwYUNHrBqw9xsykFiTU2Gb5BVwu3Qvfc=;
 b=OY3qXvI8wRPoQMaLUoFcsOLcUM2lrhY7hBNGmxP+gQAvRVK9tpyy9+00TIt1z+VUCwyJdJqfAYYaymM+Ka/aoSQYUvaxhnn3D0nfH56UcQmRlnvmGmWhgv03pRQfdwbRPZ2WMmLWcGHX0GV+7P0Jo9KN6LhHoEcbJxUyOj0ImfQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB4413.namprd10.prod.outlook.com (2603:10b6:a03:2d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Sun, 25 Sep
 2022 16:47:43 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351%5]) with mapi id 15.20.5654.020; Sun, 25 Sep 2022
 16:47:42 +0000
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: make SCSI_MOD depend on BLOCK for cleaner .config
 files
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1mtans8o1.fsf@ca-mkp.ca.oracle.com>
References: <20220919060112.24802-1-lukas.bulwahn@gmail.com>
Date:   Sun, 25 Sep 2022 12:47:40 -0400
In-Reply-To: <20220919060112.24802-1-lukas.bulwahn@gmail.com> (Lukas Bulwahn's
        message of "Mon, 19 Sep 2022 08:01:12 +0200")
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0022.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::35) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ff2222-b0e0-4f34-69cb-08da9f15aa30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FbCQLUxQrUwbUVPUwh0g7SiuboEt0FjAFI7lfG4yyhccgHsGvzAc+Q6qlTcU0xUBYR/Fhxx55l/JwnIHJWHRLGtjHkm3tqmMfKCIiOKilwbtVQgmnRKsJi3ig3Y92p2HoyXHhOAS4DO/aoZL6Ur2mhkPnIdslJNSlsZYgYNx1VTWZpEN6kNpwhUolj7Wj60EkRIZRjQgUKtaK6UKErMsY08cKVfYGy0GQ0PQutGorNJ7Bvg2o3cSa1zbPqwq7cA6TIfv0VNqB2OYOZ3GNJYSgVytBKR/76HUhh1tw740KVkREHj9MK//u26sfu+PsFJxrVIbJkdMuMzu0vGKCy7VJQ4Q4Lrk7NnWBNAGscAY5dFcXkgOdfKNdCAevJ23f78j/GArzfCDpW+bnunqgIk9/LkYt49tXwLsAxYp4LeMNHGy/zEdbUL8hNgFWUjEHc0EA0pbREyCAu+AsAjRiU0V68CUwPLCSbUu+e1KFsCPX7hcgcLZL7wXH5qxeoi8jwIet5FMGNTM4fPmltily7M5ki0e+217HdY/sERKbhAPAEuqIDeb6XCpeax6mjoVLt8BO/HhDovITrqN24vDsFxbPPUhCgeVrTjaC00V4+OQPF3qSO2gIy9OMjIbDc3RvyMEca0brFSLjReSnl2j5eIonrYKsUN30Q42r/tYWxJr1DSGS+I9kntX5wpGYHlBoPrmYKFTQkidXKJ2FGWDPrRo8H5RCh4n49sMyUKJy9GAReKpNanq1x94re+iqoAKht0+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(54906003)(6916009)(2906002)(316002)(8936002)(5660300002)(558084003)(41300700001)(86362001)(66476007)(66946007)(66556008)(4326008)(8676002)(186003)(6486002)(36916002)(478600001)(26005)(6512007)(38100700002)(6506007)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iPrFc2gOCLoKRO6WWBBb0L678Sa9O1ByPBRlENLvtV5m4pKUXtNUUQE8hJWU?=
 =?us-ascii?Q?zcuEa7W9ydxYetn31yD7Dm1leWb7cPUBBJj0/EbjdjvDVpbTyxxQNjC86PjI?=
 =?us-ascii?Q?Vi4zW+/VaYgllRqI1PSqu61kRUCU0uFVhWcxR4EcilPPXlKwFInC2nyoEdEM?=
 =?us-ascii?Q?GIO+poQHehvUJzGoJo8cumCHoGC0mfE3NT2rMeNY3Rh+lJYVnr8EtXleZze+?=
 =?us-ascii?Q?+UBBjZl/kiNiCJ3zHRt6b0JV304s55U0OOiFhgntCPqDGPwg8Mhm3esBAcun?=
 =?us-ascii?Q?NsndpGQV597eK7uYIwvxSxQwG3Ybl20G5ByQSnOMhVlQ/HWKi26iOrEJiyOV?=
 =?us-ascii?Q?hl1kva4ddzKmmtlOAMidBjT0IKSjY5FxW7qKWwuvUWhDIXOxL9jo5P0OvYwD?=
 =?us-ascii?Q?kZ5FB12PXpiF4x+E39DLPtttVbAgNIXUcVGjadVyHj3Q7YwzzaELzRJiOHaA?=
 =?us-ascii?Q?Xa0Xjsd8qXUFCWasMKU6b379o+s78aQ8B/vpKW6YzqH73xQMqUhywH7suohR?=
 =?us-ascii?Q?rEzfPruManhQnfEdOkcF+P6Xoe+a7CUA9FtI/sXoUbrFEFd2bS5IUABuDUCF?=
 =?us-ascii?Q?iXu1/dGPjvmi3Oygx2P4e+anV+2NjJPRuaF5LWnKAo0VYAH6KOhUeIa4XC+Q?=
 =?us-ascii?Q?8/z4BTVozGNXfuiNVNBZGrnPjx6Ih4yC7AiaQ1Qor674PECC2SEA4oZlKYEG?=
 =?us-ascii?Q?sCGSKwx4LUCJ6wAsn5DrMWH82k0Q5M4EdJV0byb8FAjBhj8iDbjItRe8aOyL?=
 =?us-ascii?Q?aTHexArB9qr/sy5pcxaL2tn1rs1KjYrqD+oKVs2sGxDEzAQcwxW5rXn0BGNz?=
 =?us-ascii?Q?pXMrQOhFQNBB6uEbWe9MsvbwJE1BuOgg0nJlHCDBIlg9MuDC6jpa6yO2l8MJ?=
 =?us-ascii?Q?CWmm67mZVoXD4lnG8JXjcb7jkLqOkdkZa9KOMtv9K/qlypOFRBb2P7ZjsCUz?=
 =?us-ascii?Q?rU14+63jJJPf7YHwK3pHgbK6LRYBhVi/X1el+gkBWxSrysxlKLo/RSzr9ZM/?=
 =?us-ascii?Q?BegN+l6xavUSJmdkIclzvVBRpkuxTj5DcoOIkfKttgBkl1MHmi73FlHUSjYd?=
 =?us-ascii?Q?qJTDEgyiv3FpshvUhhLF4j0Z+DroMhQ9biv3TBmW3f0Q0mSOGUp1nZQ/fryW?=
 =?us-ascii?Q?CgckiyEKuzYoBKw5rPwf2u8h7Po/X0Sa93PpeGUxjbwWLsqEOzzjGVqPt1Df?=
 =?us-ascii?Q?z+fvcE7qqu4Ag7m2gG1vNZr7CL3xpBJVdDSZ7zvPJDbcQdpd1XIeEoKlb8mM?=
 =?us-ascii?Q?x6USf8muQ9EBTSBXz3oXjNhUiEVykrTPAr+q33vuzhsIqRDdMQepEwbOTUlT?=
 =?us-ascii?Q?LiZ14axClDUAvokRlB1tGu5e9BnO8NLOpqu8SysS7F9kbpEiVD/RjziaDQMV?=
 =?us-ascii?Q?FnvUsbJE9iyJGWuPgfdHnl9dJuFhYCoOmO1cSsyUt4EiKDvxf6G0C95b91V8?=
 =?us-ascii?Q?vCKD6Gn1vJVGRLPcgMPKqTGeeS/G/CG3q2yFTD9hILtea5kpj/G3qn3Y/t9F?=
 =?us-ascii?Q?EQpDT3mqlOnySJdEFHlBrC1xrjd6PKO4yGHWTxlgr07Y7gi6Pu6KTshw/RBt?=
 =?us-ascii?Q?Mwp1s5U1nsSsv4u69Vo+3QvOaEKXTDaOQkNiqYJQ9e3dpDe1rGgoPC1G62/4?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ff2222-b0e0-4f34-69cb-08da9f15aa30
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2022 16:47:42.6650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJ7p7SBYV269oVwkRSM3IHiSClDV8C2nyphCCzfJ4DpcszwUhdn/mS/WAb4GVq3tDR2il5mbqURjs2tU0OQb/5ptZS9S6608N0XQsX4Ta00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4413
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-25_01,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=861 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209250122
X-Proofpoint-GUID: 3JZsAoNdqgyDd1oxtq-1SAu5ICXndGDu
X-Proofpoint-ORIG-GUID: 3JZsAoNdqgyDd1oxtq-1SAu5ICXndGDu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lukas,

> SCSI_MOD is a helper config symbol for configuring RAID_ATTRS properly,
> i.e., RAID_ATTRS needs to be m when SCSI=m.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
