Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBC96DE8A2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 03:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjDLBDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 21:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLBDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 21:03:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B243C0D;
        Tue, 11 Apr 2023 18:03:42 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BLSLJA023156;
        Wed, 12 Apr 2023 01:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=rn1PLgDtxbAA5JEspboDqpk1+seNodJEzocx0B/pUL8=;
 b=xh5UddMLCm9trmpHhaLMsYmMto2D0lcRKvTQ4HmDdsofHpY3UVjiyB52UPb69EzzAHR3
 lRrlmyP/TkrkYbXxndUiwxTM9BigSAxwlO3qgtpHMgsj/DR+IErfWNvGPFthNdnqE/aJ
 NihvP2tmW3gsQrqhPTBBuwT8+z1m9fPp/MsRaPZEZnRxGea9SuG1wMPOmQuonq+gKI6K
 6nWz4ss8rEdrKognlCiuM/rTboXFuvgxX9TGMMiQN8jO0RevJ5YlOuxePqqGIrUgTZ/O
 CvrNILGspN705g2yFOfMSughhHjFdLI29KuQYxbw9tMTUPDZmM7G7s5ObQpLhV/DA7lK eA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0eq6uyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 01:03:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33C00xDN008083;
        Wed, 12 Apr 2023 01:03:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwc52dn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 01:03:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWgnosuIIirSW0MrEZqfTQ5GePXnQGJRJzsJiKOVkC8PMw/vWFE7fTSXi5TrRXvAUAh+uSheg9oT+ddZH+klonRhPcXZXEy8wGEhVIiqnzZ37sA8VpPpDP82cypfTjZdnNoazSbxFWXZlMCeeKBi6Sjzbi6XRZcgliUkQdZogZUY9ucJhwVIqeGuOyxgNAcmb8gxN5kMR07nkvgZlikgNEH6at8geM8phBnit1T1w5tMK0en2wJNetqCVFRrpcqaf4gpb7/zIOHY9ekApOJwcmnhfww3WJBOFYm7Hcu6Sv7ycdsPz2W4vNL+8G+byS4dmlPD06DCxEEAyNQRJeEBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rn1PLgDtxbAA5JEspboDqpk1+seNodJEzocx0B/pUL8=;
 b=HlVIlS2JSRwHREAOE2kXP+gyYeLAcUUSkpl3pz51fkjzXsdxraGxNVhJi0PDHXJb/sS5I0e1Co9ci5tPa+7dWVMSB7TxqWEuSZaFHRcopCx7cmJMYeOf48VD4JSu/IWx0QW/aFi2VJdlzqq0XHRrBR1Cq9F8VYkg6w5FmOVa7JTpT/xEb+Mj5jmNM6En/zaCwFAq7iehzrSIxG13saMpRbogY5gEjcHOoRj/u2RcmjO2as7IT00fZtSkhbdBzpVzpCltfBfX8LSVJLyFO2Pc0kIbq3iNVSsCXyqRQ1W0oOYT8iVyzHkhIPNY51s5cDL3mU5lZbetbb9wHfnsOHb30Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rn1PLgDtxbAA5JEspboDqpk1+seNodJEzocx0B/pUL8=;
 b=Ms/Fw6oqjAnj5ujmH3JJOC0aap49NWBk9ulJLhu0o27VbAgeGabz+kQtdUKbZIZnMVs/P39+Q2G5oYOrFow1OHaIj6E8/VsgQnx8Dn8ROdaYVc5qhoONA7hXFRUtni/OPSddgnvm7sV5ClCleRZzC9G+qlQq/R+MKZP5d4elLXE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB6872.namprd10.prod.outlook.com (2603:10b6:8:131::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 01:03:25 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98%6]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 01:03:25 +0000
To:     lishuchang@hust.edu.cn
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        hust-os-kernel-patches@googlegroups.com,
        James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: lpfc: fix ioremap issues in
 'lpfc_sli4_pci_mem_setup'
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1leixoqt0.fsf@ca-mkp.ca.oracle.com>
References: <20230404072133.1022-1-lishuchang@hust.edu.cn>
Date:   Tue, 11 Apr 2023 21:03:19 -0400
In-Reply-To: <20230404072133.1022-1-lishuchang@hust.edu.cn>
        (lishuchang@hust.edu.cn's message of "Tue, 4 Apr 2023 15:21:32 +0800")
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0107.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::23) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 30188de3-b7ef-41d1-ac22-08db3af1b827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1yp5p0LuzQDzLPMpV03HUwu9TVt/WxLKNElcJwqpwoAfwHQgjnhMQM55YMG1UIFmtZHI+shgiwH0shxPzlB/8QTRMFzBLPujB0jHsUcMwHyZMmbh9da2Ct1ToyimxnfGLETbMFMvwK5LrGo4Kh7zBqdRFtT3aAa2Wa1TtYnxZ3iLVPvD/syvssK8RBZ0qSXincZr9uzMShxBzTqgaeJxBWIkv9dz0f8bosOs0VZY5HhDmFJJIzwgoVLDC9TiL2cjb/zafDnpDUKy2/DaQrRaRm1dmPMsBM8DYHQy3bw3i/6OeCEQqaBDNwicddpyzL8t3OLZ2xldKqxR55byV8ujRHHSBa4thWcqtZiB6MrcUZ4dBMc5M6oV12AcLpPxjSPE1wAfWRur/0obTzW5EjPHjI/WZZoeRiAVI2/Vd36BMXvxXzB7RdgalmgnbpCM9lJdHRSda6stSkc3Qw9rZaM8DQg1TJpPJLd0XlJQk0sUwYX0puSYpMexwtomBUKIr4N2G17KJ69lcikIVL+AGtirUKM4Bzyf42etpJTk1Tt1Eflxpf7k46BkT1eGty9MrjsL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(2906002)(86362001)(26005)(6512007)(6506007)(38100700002)(186003)(316002)(5660300002)(54906003)(6666004)(8936002)(8676002)(41300700001)(6486002)(558084003)(478600001)(4326008)(66476007)(66556008)(66946007)(6916009)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BEh2vISmHykIHxYon+bz+rB4YsO9mbpcfmuLJSdrER46YEk9q2kE2Nlp72Nj?=
 =?us-ascii?Q?K00KZcQghuO54bn+rR6XBTkBg3Ou2ioRyemJOLhyEhaUB6eOQz68eZ8yMm/G?=
 =?us-ascii?Q?q1O/TM2bCP2OjHKd38KLKfQNJPbP6qbZpeuXOQ/pmei8rpr/ybFS9pGnkDHb?=
 =?us-ascii?Q?XoUXu1fnHZ+0P5AsjBD2Qmln2svrg29FZlqHnPe3POjJ4+R30r4rTamXf3AL?=
 =?us-ascii?Q?jDKevXbAGWanrZYTavyOVco9KMcHMh1yPB5UMW4KUHq7SplY2UabACcHnqO9?=
 =?us-ascii?Q?eTcX/5m64eYIcOtLZ6pJQEKx8cvZ/4MuEbpG2Dvjc9IInHR802kpR24pKmk6?=
 =?us-ascii?Q?sOVkcnlB8T63dkeQ6zTV3kAuxmEFJ0I9xX7KiP/xvk2wySD2ZAfuIdZAZ2ve?=
 =?us-ascii?Q?xBUT3Mm1/aR8dH6TJr8wKBlwWdbM/1TEvbgIBpFfoChMZiKU0hO4ssUWRwXq?=
 =?us-ascii?Q?Ms4bESekRld4knsV1y5+zAHOzNSiYGRXhG6hRuvAdlTZMdvRYajkZ8s+rQ9t?=
 =?us-ascii?Q?wMGAcglSNeLcxVhA1aG8BPVm/4q6fz9Lj3kxn5lgggUy4TcXaJ1Pt0aZy2lY?=
 =?us-ascii?Q?lsfZg8mi3Cd8mSJ3LoWvpFcIJWh9xZYCufHyeZbYSa64Hs/RgMKIHb8KkoZP?=
 =?us-ascii?Q?imOa3pFLIUyU9mfOedxxcTeSTg9v1CPWhyMnvkma++Wunu9bsa5w+1c19+IF?=
 =?us-ascii?Q?QSthFamEcGkY7D43UWBw8/OtqzMdMImJ3ZlzAYZdP9qb+AwbHM8SYBHlK6Wb?=
 =?us-ascii?Q?UBgL+4zHwvEgfpxbWMWDGf+2XpgCdxy5v0tFUZxePb361hLJl/I/c29Dl0Ro?=
 =?us-ascii?Q?fwnycddGZfWexRB5mFeX0/YPWRk24by48iXLX66eAyXEisyvq87bVke4a5ja?=
 =?us-ascii?Q?8HaPkkR5PdGthn0gYjM4ijzTLRynq1TPZUuY73LCYA/WwNn5ZOJU9EIjXaZA?=
 =?us-ascii?Q?hYxr6qlvN0FbKAImRlnn+1oCXJa2TcJd2NVwaH20zo/3+G8wtIhuJKzE0Z1u?=
 =?us-ascii?Q?j7YM3mEqeq2Df0L/syfjbFfYOfRssb0jal/fAXfDMGhYQ5L1EUx+nVwMbqrs?=
 =?us-ascii?Q?vir3MBVOqXtJWjAZHgRcttawKXpeJix6/kRFZChWPQv43SFn/8SB0Ap2c9zU?=
 =?us-ascii?Q?NtoYMTxshLKok4jbN5bjoZmEKBkARzoEaOCVXeH+jZUhVp/SrZCIAuLudgef?=
 =?us-ascii?Q?Xu5G3AjvFh0e6b6Q+IFIz3JXeA7GxwRrYQIbZNfI+GcQ9cghoNuzo9QVEW3a?=
 =?us-ascii?Q?ivF18idyOSCqMnlSc6jW6qYfe6rX/a3eTWBfgSbemZmZTrdgU8mZzACwyegU?=
 =?us-ascii?Q?76ho5FzQWJZAfffeRA2XvnxYEejl0HhXT4vT68ahPYRFZ48k7zrmZ1XbV1Wq?=
 =?us-ascii?Q?vUqj4IC8XY2CwmAKbc+dRsqL2mDUrFedU5q96VBIdZ3FplJDO9EFkqbMXWJa?=
 =?us-ascii?Q?CoR2Da96zrxox3B6BI9IerwISS4wEGfIy8Y6N6OuhBiCuDxF9bV7p4xpJxDX?=
 =?us-ascii?Q?Uo7bQYbFGJ8+WRketCRZdXE2Yho5BftuVKqq0UIWydTMi5FdXqbUYnFvSQX+?=
 =?us-ascii?Q?hmv/Bk3t6Ap+S/bRa+QzwwKxHrAVpyEo7le3q9ElC0XKga0wBy3MDRrTqU01?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Pqk2ydKYsLTR49ObC8vxYlU84lrnxTW4ZOIsWNs3eKLwwvfhXxkJuBbK0UIF?=
 =?us-ascii?Q?kx9REJEWJ+e7cYOnbLjcf4ECY6dwfib+363S8HHLmyd1+Xbn947tT3hhfqpv?=
 =?us-ascii?Q?+yx3Q7khrL4xcQ2LvFzLCi3Liz0mCH1A0gCBF0XauHkYBn3Vxha8nMlxwLil?=
 =?us-ascii?Q?7y3HFqE3xGot4Ml81JmHaRNeVwRJXYv92T2RVetSNOvJl6Ld+8csy/zD3C6z?=
 =?us-ascii?Q?+w/do8TlpCxTMKxu17Xt19U9NiGGBqkql6UtMFPIG3rurwKBhmFMHr5EP58W?=
 =?us-ascii?Q?+taLIk3AbSqRWjslIfGAFxwuz/Ck//CKwEu5ZtwQKEUAAPbl6UpB3XTpMzwA?=
 =?us-ascii?Q?yz/hYCcMKi/wW0mhUifSCxTbzCU+Oo3fwAMxia9jBrN3oO2BLr9/uIKUcFN/?=
 =?us-ascii?Q?wish+rnQGDikrTaW+e9tQwIQJRFXkK47NkZ0eK9LcaolmHVv+hOVGmzJC6pz?=
 =?us-ascii?Q?xhBU5M5I1U//JMlw6NbbqgI0XjnuCabL3aVAGg9A58AIvj7aOQQ077FvEooj?=
 =?us-ascii?Q?Yyc7kZJeZyK2z00h1gqLvJXOLsouRZ4liGD6Q2+XcwJrJp92Uto46DLH+Z0U?=
 =?us-ascii?Q?AlbzA4FL5urNyMpYSuVi8Dt58Al/aMrNjomlX4X+KPaPXoFuyM3WdlwdbSza?=
 =?us-ascii?Q?9I9NDFsWkHiYxja3my7Hny6wn4gYAhF7PtNePcK7GU4LxD4rm2hDImbybERG?=
 =?us-ascii?Q?UTdhlue5Xl9+19qkbTRyGpPGafGBXT8z36yLu0KZ2vZKYJB+vlrXLL4qthj8?=
 =?us-ascii?Q?PcGgMUV6WKRa14RR6rLa3US7gO3FvDW8qmqJBCB/ERTnUZ2namsXikwPfQUq?=
 =?us-ascii?Q?bNcAEYJujwe+qCex6Kci0E26lTidgNBlOcbDKwnN1/TCGTVh+B4qgnxRStvO?=
 =?us-ascii?Q?2nI8h3bpPJPWH8fOpot+ZjxesLn+loSOXiWZpfZ43WhjPqbuFezJCc9L4VTC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30188de3-b7ef-41d1-ac22-08db3af1b827
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 01:03:25.5749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59b5U8GHMYVcGdJ2hQY8q+fUhrkJFMiQ9+TOnMNabr/c7BYTlRYiFFGiaP7Pthksq+6iDfoABICfe9E1IRcs7e0Tk88xKeQEe1iOj9N1W8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6872
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=640 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304120007
X-Proofpoint-GUID: SW3Ib4GjKNx5mSPgSrWc8EsOCpG5ZDWr
X-Proofpoint-ORIG-GUID: SW3Ib4GjKNx5mSPgSrWc8EsOCpG5ZDWr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> When if_type equals to zero and pci_resource_start(pdev,
> PCI_64BIT_BAR4) returns false, drbl_regs_memmap_p is not remapped.This
> passes a NULL pointer to iounmap(), which can trigger a WARN() on
> certain arches.

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
