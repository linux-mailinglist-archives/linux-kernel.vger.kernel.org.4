Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283BF6B347B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 04:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjCJDEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 22:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCJDET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:04:19 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94EEF6B55;
        Thu,  9 Mar 2023 19:04:17 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329LwuG4021603;
        Fri, 10 Mar 2023 03:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=GEWVG7dANiwChGRtbjQ8rRysPaJYT7fikaz89jrHlFc=;
 b=0Rf6fYRWbq0aH+MMrydHuz6CiMq6ydAFmqUs4aMh55dD3jI9LBjUvz/pQWTKQxCbnh8b
 Yv+e+KJ7wpBblZ01lGimW5yPF+yUlWGsfB9T6KVA2OxhxkQddV7n10vNA08HIuJ4BOK6
 fohNKCW4zPWBCNs47EORg9eWkHVdMSRRh0vGx6Hoju8Bs2Cgj/5ZQmKv5y0D4epeZIhr
 SuhedlPbqa6uSnq4ODxTJTjpSvJxWqSaBTNIlrqdob4OjedpUMuF7BiieXYO4nD4byA2
 PVuIGBkd+jYaDYl2uiw4sK/s0HzCKqIpIAJJYR5uakQX9K43WGPAqCetqHajXCmyDm0o 1w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p41814613-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 03:04:03 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32A03765026602;
        Fri, 10 Mar 2023 03:04:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6g9w30j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 03:04:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTCFgi78sUkijxA5BqdAadgcts1+p5bcm/Zh2v1k+YQ6E6+NOusyrZ1bpyMewWN2U/Wj1rhUA7zMy4XyFMvnK8HKVsn6XD5IQjHP0CSVyiziOlQK/KrF282XI5/xoTKxDPeZiFSYnST4lR5XUiuvdvab1FCR6j5TqRNgl/8CF8IDZ4WlR7atiNSdG7HDuh/3kyadCGLbc4Odg+V6oaTasKrwp4c3C8gc+fru8GAY668Metfc8373tw15Is1YqFXZ8/GPCZWVj13RmvvNofbAfU1DFGTqdq/jlW1Jvx6LpmDoUWK8vW3KUrVQOLaCf9rMbGJ3E8F8hmC7NadSq737ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEWVG7dANiwChGRtbjQ8rRysPaJYT7fikaz89jrHlFc=;
 b=DjY8jZCG2Bx9fPM7Ike/MtIBGV/JXUfGohzDf9PDGugMjn0egdJVHc1tmmJ+I8snb7D/2cMZ8PCrPD4EGJErOLR3jnhKd2NoW/XrSenPkral7sPrp3RimRq9a4iKXINJZa9461Nkl4T1gy0Yy22QLV9xoPCBzMlT0ZDBEzh7heyNOLopcE7qHinzTChXoxmQUQB6u1pgNETcgAM6s1tH+v7JoPwq7Qzm1wxL9N0rZhb7Yina9xtlTwkZJH1k5LHQpMX1+KJ8zm3n/cQE3ZpVHV5lWTLYVEd05W7X/CG6DbewEuPvHzLp16GdU548+No6x+GhpqwJf842RLI/w9f7kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEWVG7dANiwChGRtbjQ8rRysPaJYT7fikaz89jrHlFc=;
 b=BVUTM05JWcGzqsIRfXlFoQigb7BcK7uNEAyWrRRHKnqlVqkn8Zvt/PYAsq41xEkuiBzhU4uXCTryLISkjIak/ZGhLGzIAqUuhoXvRKp3moq36WpJjNxqsYpxdIAtI5e670OTnp+/9VBbSvRRLp7X9YcwrVq8/9G6C4DlbzDzcHM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB7562.namprd10.prod.outlook.com (2603:10b6:610:167::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 03:04:00 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 03:04:00 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Don Brace <don.brace@microchip.com>,
        James Smart <james.smart@broadcom.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Raghava Aditya Renukunta <raghavaaditya.renukunta@pmcs.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Tomas Henzl <thenzl@redhat.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com
Subject: Re: [PATCH 00/10] PCI/AER: Remove redundant Device Control Error
 Reporting Enable
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zg8l71f4.fsf@ca-mkp.ca.oracle.com>
References: <20230307182842.870378-1-helgaas@kernel.org>
Date:   Thu, 09 Mar 2023 22:03:57 -0500
In-Reply-To: <20230307182842.870378-1-helgaas@kernel.org> (Bjorn Helgaas's
        message of "Tue, 7 Mar 2023 12:28:32 -0600")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:8:56::22) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 9336e9f2-50f8-4eed-8ce8-08db21141889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbzfVLje7GnaCxErc7x7tjS+Hiobcx4pbnk4AG7Pk5zuMY/kV4y0Z6jbeXCAjC6bDbKfkzVQ8L+iSCD+YxwaLio3tScNQ/fHAASWuCH16kl1L9OmfpmZCTXnzIt7+0aw5V58/++RmZp3z1JvTAQ5f04SqcAJWN/jyAOWQ4048bD9BrTkSYV3g9z77n3WG4Go5pkyN5WL0AiF4ZuveEFOc0icXS4OqGCvVQS9DiEGC7uI04WWeuXm3U80u1ZwMIaaJ8W1cNA4fX236JTqaHhzOkd5CDVzvV3QOmrhiuCorBMdNdwVT05/CvJvJcWNFourlwu65qFJVwoRi5O1Cr5lr8z7OUC92HWTdiJkcX0o0erosZcTsDJk+xWg/ceCueU6wKJ/Hd3Ju5eNSEAeDlYytpJgzhau8bOuTGHGTU/VeyZXAPo0Za8ey/E11YnWblwHRFpBDgTtjyetmki1mRtdrEuVL3EXcg9/NIcGVDGqEQ1SMHecSAjC+anVcB6a1DO9yHI8lGlHmUmyblcByvxIBCeMRDIpAa3Yd0G56mgEqRamW6ZsggLjOq1ENCT7apsPle5u5t2qeT4oBCsX01xB5PNoHR/Q0aHpmP+IWIvqiHwviSDDzkxcK1UIozLD+Rh7gprOFIe28PTscT2Kwh+Ogw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199018)(8936002)(41300700001)(8676002)(6916009)(66946007)(4326008)(66556008)(66476007)(38100700002)(86362001)(5660300002)(7416002)(4744005)(2906002)(186003)(6512007)(26005)(36916002)(6666004)(6506007)(6486002)(316002)(54906003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9c0vhK1/P0ka98wZfC72ok69C6c3UGmomtGOht206AKmJyRzMSNB9/DCs9N8?=
 =?us-ascii?Q?YCHfKsD6KQrEBaNRENfm0i6O8yfifug7w/Se38fw5FMpZb9+cOdbnxg3sSH7?=
 =?us-ascii?Q?AO1bRJnyUE2Ka85U0TN6Bm5Rf2LZMiS7t0ZJWxcVmReSiTQVU8MXNzgcBlaE?=
 =?us-ascii?Q?SDU2IT3IkS5qG2c3VUKaLLFKwce0AdWcriG2Gh9TbUybV6idvN7gS5acJZCn?=
 =?us-ascii?Q?ObsgWju51GE+BeGesI96FaN9q8zo+NrPvEP+e24du2FZDpH9q9niUqP/d+C1?=
 =?us-ascii?Q?pXkWzSx7TyNiKv203fogiFDoBihqqDiymky5ms34rT2OC86BEJYOwAe80mgu?=
 =?us-ascii?Q?jxlNmQ1ySEWwXMjrPpGxCCySZWYdWWPzB5BV8aR/7KPghg5JAFb0KRNVLK/4?=
 =?us-ascii?Q?Meg5AYdt2LP+mIZRX7cH1P7EW2p/9Xo15c58H0ruGeNU+mhqi5sfYG8nrJFh?=
 =?us-ascii?Q?s76dNOp3rLGRYQ4jv28Na+LKJMiAoapNFj+hfP2BaOkTsNmULXwI0fJOdMpC?=
 =?us-ascii?Q?hz5J/p4iXC4WHrclE81eIn8BO9+BWf0lq0/tS+48c7YMG9TZ4zUE3S02Ezq/?=
 =?us-ascii?Q?7m3UrP5lmHfyMiJ9/Dli/28hn0PRLfI+NBsR1u6u0N0wLTyIFvdL/KcDHe4U?=
 =?us-ascii?Q?S/0TzyHYA7nzDvvwY5nV+UyUaDNUzx9L5UD4/PqVBalqX4QzldPYYvxP2kOM?=
 =?us-ascii?Q?KK4UUde7JSbRsM0RDPd7FTmDRrQtLYfiA2m2An0ELwDxaLJyRYeK6PcCODUZ?=
 =?us-ascii?Q?DWpee/QFPnglHqG1y/1XFZgyPeCHUMTy8kiphbKpoGJVYh/l02ZcvQUA3zap?=
 =?us-ascii?Q?mwdr7hPiAyCZ7NrhTYuL3OVlZT3t3rqQQZUNBfme6ZccEMCo3bs2+yZvkssZ?=
 =?us-ascii?Q?pZ6if2+w9HeZTbxBdRm8Wy9XMLQJclOWIkgOEwYsgkNhwEbQVz+nC16tkR11?=
 =?us-ascii?Q?1NZkBd2gp1uwKXu/LVlEzjzBb6hJBXqTMOV+SVYR0GvtwWDh6iNi0kXh/Kk2?=
 =?us-ascii?Q?IyMkHrg3mCpGEAGDANFeYiLZIrHJCV0C2IeOTCnPAncqT9ZWji+/Yc4hGsCv?=
 =?us-ascii?Q?NKMAFPbnNUG9O6uAdAmE5kkN0sz0OT+wBBQsiVK8fB0V2CDiKnPo8Mb7QkdU?=
 =?us-ascii?Q?T8wWArJPoKkbTsT0wmdKx888O5uQjTH3iWpQdHl4vRcyUKHN5PGTiKshfyXV?=
 =?us-ascii?Q?9gtX3QoAtUULzabiqzccIvcGa9IwVw83fQBoDShmlvzy9vGXf3lJTEZTAimd?=
 =?us-ascii?Q?4zUmKqzKAkI5jpceEObniO+oX/bc6ENjtY39iBdTmISklImka//QwBCXj6iS?=
 =?us-ascii?Q?j+Ranzj3qjfFz8i+vba9xAv6Z7IqSaHw1yg5x9LboVASVEQW9SMf6YLpGR54?=
 =?us-ascii?Q?R8dkH8RCBbiqVcvj1O+jpzagXrFywEwMJYxPmewNhQm6jc8RH/C5tqTXcWWx?=
 =?us-ascii?Q?MoYq3fF24mV3KpjPI9OHT3WJBJy5u5QVaya23hmAaTsODlpI8a49pFE1T4VV?=
 =?us-ascii?Q?xs+tLNebuH5xnkt+ov5P3BKHGSpNalXwCLihPmSzY74tUP33BkCB5VfMuhfo?=
 =?us-ascii?Q?3h5z8iSDamD3A0UhHFc8JR8QmOH6MjMrCRJUKKpaBMvP1q+wm5a/31DDqRsE?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lEOteZirfhh2UkHqV3Ecc5Ml/BUKGUONVAzEa5mF9YAJRfIKDrwtjKh2gu+r?=
 =?us-ascii?Q?um8Ipbi6pJr3dEpkrG04dZvRoNdkd1+djtC91e5lmAEkSUz6ValAbFHDaBgu?=
 =?us-ascii?Q?jnyHDFTQEiwlyd16BKjyF317BONOV4/qJsgw5389tUiyj/QuNv05gKeOYNNw?=
 =?us-ascii?Q?7ACo/fQ/e6+fgrKSpKcwp3yww2Bm1fWgfo+1V9J3NdfM7Twl+yku/2coTnwB?=
 =?us-ascii?Q?TV+OWlcwB07FsKZhA2D9w143+Xfv1SfTzaQyyhxCQIMXTeFnVXn57nJeJnQf?=
 =?us-ascii?Q?hLIzzI4qARBmxj84t8tzH6MV9pGgts5Dqj8UAeI1GnLdPiqNLX+MXZAAh9r9?=
 =?us-ascii?Q?trA1UVVUE6kRf0th1/CTRuRiLBydYHx5pbQN8PMKXmRTa5UkW9NxMhs+1mjM?=
 =?us-ascii?Q?7MHr/uNzvCbVemP+TbEDlZrjB3sAw3yj7CKReoprj8TA6BtRclfszmb9p4UF?=
 =?us-ascii?Q?3daZ1vZY9t6eQzWeat92/s/zx0HLSXZrvoRB6UlDdWe/ETa4YWkBSRVvhHYt?=
 =?us-ascii?Q?cWhaieHu33smd0wv5jmWXcHC50Yzs6uKW1w2ZMNUzRQtKK6m6DsnuhSOeBDX?=
 =?us-ascii?Q?uDah9+RznqIvYwDU9BsdLQUOAE9AXDzRVzcMikzgGznfmxhz90otsoY/hed/?=
 =?us-ascii?Q?0na+64OwchU+G4yCvz+IPs5rY0MqGucP5d55EunGWVoWjfqFYM9q2Bjioc6N?=
 =?us-ascii?Q?Qx+yWeYH3rtOWCu46ueyWpGF1Q/2ISTEHSpTXR5Mf6xUGAfvMMQI6GfOthuz?=
 =?us-ascii?Q?x2FR78ZmrXnOJG//0AQpIbt1ni9s7FjoEA998Utc4+i5GBOgx2lU3bxzjw9T?=
 =?us-ascii?Q?8Zs9jWntL9WbJTx4Vq9oTpgo5Krst/IFq+czwkmMY2M8ktikLwGYJ5wTHSxB?=
 =?us-ascii?Q?dKnnMzGmJlvoNqoTZjn5pbWPhIIA7cKRqqk2aeQZKD/TwTgCcU74qlNFFmU2?=
 =?us-ascii?Q?ed3p9/dEOBaRtwlJGAo28CJ08s6dy1Sp/k0k2UlO48+InnoCkOqKXZUzqIsR?=
 =?us-ascii?Q?CBH70384S+kda6g5uX+xMNLwd6RnBxo5/Etj7pHr6oxOcEz8LNk0HXDSNeKf?=
 =?us-ascii?Q?S+2Ix9qhSHNZzSiKwKKwoqaeDjvHKdk7GxzYOlSLcmmKFD+B33k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9336e9f2-50f8-4eed-8ce8-08db21141889
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 03:04:00.3879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8BQDYawfLaFTAU/WNEWcQOgDxhSTVNR8nJ8eHfHpVUrBeVYG6ZWRJhagKarHTIbVP4Nd+yok2v74tbl4IRv8tOfDpfTcTFljUp4zlTxWwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7562
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_14,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100021
X-Proofpoint-ORIG-GUID: fP5zsH22XsagQstDPLln6w-Apb3cHd4b
X-Proofpoint-GUID: fP5zsH22XsagQstDPLln6w-Apb3cHd4b
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bjorn,

> Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
> native"), which appeared in v6.0, the PCI core has enabled PCIe error
> reporting for all devices during enumeration.
>
> Remove driver code to do this and remove unnecessary includes of
> <linux/aer.h> from several other drivers.

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
