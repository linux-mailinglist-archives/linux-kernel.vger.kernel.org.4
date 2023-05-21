Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE03E70ABE1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 03:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjEUBUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 21:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjEUBUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 21:20:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E5912B;
        Sat, 20 May 2023 18:20:04 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34KNwnb1031544;
        Sun, 21 May 2023 01:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=U17qyCluoaKX08RRPvqhBSZVOgHsoc0P+dHjeZnk/Eg=;
 b=TweoXnwT/U41CQtdCikcBeC4IsMNITCKq2jmJ7oyYZ+HkXkjLnW5GBGogo2IT/UqpSTz
 0jZzLxHIMa+M4HQzlXxYdsF8zEY+zEtutAomUC4XrOozH1jpJp9C9MgIQu++YM23q/2O
 ERnnvzQPfV2OfcEJrzPX7zz2ixQHtrEAC1WkzbEQ3BB45o9MVh5co20q9o4opk1OU/uj
 UXgwRj0fbBE4ChYc1z90krk4ixmXixrNfIp5p+QoNdWgA6M7FGbJJUXm0d9t5ZIvXzwi
 wLfm1o9iqQQyzZ0rgLZ0dp13pOz0KT0ggW4j+WbSSmci7NaT8hvcCtFWiWrTyTZ3na0Z FA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp3mgs7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 May 2023 01:19:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34KLosUI001316;
        Sun, 21 May 2023 01:19:59 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qpmn1nudy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 May 2023 01:19:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJAEldOdF7QHTwjhG4+W2mIlBI87Abc7IwNoEF0UOOzz2sSiZWuCzukyyp2tZ/H1Rwr4IVFc+A95L8sT0b10XM8vV4Dcz6qqbl2bDfcg66enNiJQk30mLP0p8r92mugyblRMSCKY+QNH2u+aHII2wme6yne7qUTUK4Z4BBDuoXSVxW4CC0xF44Dn7WyqgCwwM1tYLcyw4wUSm7805t0e+KLONcRhXKPIoWSgYpnT/LcEXIU+OONPFzn8gl7JMgwlTFGcovmudhoYfgNr2TDi1bBnU6P0SlAFhst8Aq2/2Y9DxRrL2TNPp2mx/+GAtxQvMOWL9xNQYozMblBNp3UdBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U17qyCluoaKX08RRPvqhBSZVOgHsoc0P+dHjeZnk/Eg=;
 b=UcL/OcS+4J8WIHXSUeEs3D23XL4SUaO0dRwVwOjAfN79LlURV/J+a54JmVm0ymPzKZ0+1Rk3uVMxLE+fhshpZbG68mKVznZLAD/sLRO5+iatjiJUzJPk0WWzOoFNg1ACpG6R0Rswb2KzpwM18BwGgURn62gxtL8g0f5k/wGICoQ1L0X2xo83s0h0HjY47qBYdpeS1Vein59MQRZhxfg9COns6i2aScfhwUNIV7rFTpJMMbr3LDEyARe+5Fy87CyDDTzlHpidzg2iPYqFCIGQs6l7DTlyuzzM5bfspQ4vQ0e9oEHVLONOb/buUTvB93iv3YdlutUbn2R6WtStTYUrtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U17qyCluoaKX08RRPvqhBSZVOgHsoc0P+dHjeZnk/Eg=;
 b=DjmU6Yszir1GqV/E8QrYmwPVziBgt/DBR9N7JHGkQTD2N8wfQnycTdb8ESNYA0DvmsyxWEqOY38n1ObZlUu5V6G598hA8MwoGUOWSnZ46DHJ9mrUfxduFAQFC8DoSWhImQB0uaE3+TYskcfiQNDLTz37nfQMQtaHi8FJz9p4Jis=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6966.namprd10.prod.outlook.com (2603:10b6:510:277::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.25; Sun, 21 May
 2023 01:19:56 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6411.026; Sun, 21 May 2023
 01:19:56 +0000
To:     John Garry <john.g.garry@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v8gmpkq4.fsf@ca-mkp.ca.oracle.com>
References: <20230511123432.5793-1-jgross@suse.com>
        <yq1ttwbsoii.fsf@ca-mkp.ca.oracle.com>
        <6614f626-d174-03d0-0993-79e6f6169b71@suse.com>
        <9d356278-c826-dacf-cbe0-79f512b7970e@oracle.com>
        <60aeffe4-b31d-4ea3-d4ea-f50ae25e0316@suse.com>
        <74879c87-689f-6a8e-a177-8bde4c9c4e51@oracle.com>
Date:   Sat, 20 May 2023 21:19:43 -0400
In-Reply-To: <74879c87-689f-6a8e-a177-8bde4c9c4e51@oracle.com> (John Garry's
        message of "Thu, 18 May 2023 11:57:36 +0100")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:5:334::15) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: d56ac490-d908-4ccf-5e3a-08db59997ccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bnPxZVOhp0HIk2eg0ced1Tca/ES5nZveKXcQEVeLdDInqzSWkx3YHC1imovIb31l7wn4EgiuoYasvboKN3YKrU4jp23qRTZ9IyiYrgygMVLdzBOxORQd7gF4Yp2yM1mHoKY8oapsn25h5exCfxxPGycYk9F1XDYm2ppY7n7C2zDP2PiRbSGlbJBePKv/eWAed1NywBNk54EBR+A6pvsvdMeFO6XlItOhTyUhPt05lo6rEiPSqTGG2HA7RICpgVrbGp2cTmpPYmmLmeGefLULE3FXDAKXas2wg927LzKblj2ovS5LEcMJeyr1DJq1NSDFDWQfUMyHYyL+5nQuoOjdcIuf8qwAZD1QXMCnF1sBo/AM1B/3tGjZPmbw50/WdMa4qlEzdjnkPAZyjAupyBKS/E9l+hRsUV48du/ma/0B1J02qJRBPqkqp0atgLtSDEbBK3njn4WZ8e1/44Wr982LwRQvVqyzz0UoRkLVuRSyZpH0/WPh0MnqaNNRQHd7IbZzdP04yvmxdlgZZ2CAN5aNK6L6imzPQd49PZ66cnoHgEJHUYc4cdHWD+Zgs5YdxEcCczdE8wFhvCEO1Pmx6CZHmCT4fXbUP9x1t+E6IIkCI9Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199021)(4744005)(2906002)(54906003)(5660300002)(6862004)(8676002)(8936002)(41300700001)(6666004)(316002)(66946007)(66476007)(66556008)(478600001)(6636002)(4326008)(36916002)(6486002)(26005)(6512007)(6506007)(38100700002)(86362001)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HX/6D1avUA7Jghnv+DXk7JOhHFmXQw+Fdxue5SWwjMeHiPpVuJvf6kmZP7V1?=
 =?us-ascii?Q?ycBacpXDslrq5A9DWLFMmZHH3mUlkuwd1A9LHrlz9r703nvOy+ZCFslmFNlp?=
 =?us-ascii?Q?VQgAg3tdjgU5nWBuPiomRiZTAu09ljAPn8OK3f1jtbRwQ7YSYX575PgsQ5O/?=
 =?us-ascii?Q?9Rmw6Zks7Z7XnwcBzYXx0QQ9ecr9gs3qpuBE4SmbLYXidUHfcMOBjwNOcIK+?=
 =?us-ascii?Q?baUkEE9wsn5PM45ihHUlvJnffmI11XKGE1NoG8AuKpt0XdCABOvt9a9HbDvb?=
 =?us-ascii?Q?MOWW2h2SycWc1j9WaX3J0Fy9mHONklIvmAcPjGzUAcWPAstK0sxyLOD35r5b?=
 =?us-ascii?Q?H6Aml4Q3HHoh0K6iqFp5rhbPKwfxFE/Qx1GAl5mKOvpfEq2iNPPtDczb0RFU?=
 =?us-ascii?Q?E00f0r9L/Me9QMU48QQU8HsVNb9uBORtZot7duzqZFTyEtBKLfjxPY/J0Lx0?=
 =?us-ascii?Q?F2EGWcm14wSzcqMboz/u3zjLsdJIZfVhOfAcZAPacmaXtPVKD81f61INaOOl?=
 =?us-ascii?Q?qCKh0/6od9dIKJgKLDcM8XDTn1DUyCo1A9VdufnuKsEKSrENo58u/i7f5Fic?=
 =?us-ascii?Q?V0UtB7a9CR3FLUCxsm2DGzhZbpX0/kWP6avVDXrW+N1BT1cYcgzwwipQ3tEL?=
 =?us-ascii?Q?7qvgiWPEF0A/4cTgXcbeLlefLpG+L7a0T0urh6f9zSL7bBh2SoCPioY5V3Kn?=
 =?us-ascii?Q?miWqlk2hJdaT4U6xC/DvY+UUuxAABXuD+sPZPPN2ptIhyQQxa1bCt2PK7l3V?=
 =?us-ascii?Q?wDswpNUhGw8TOgY5/cgPZt2FFKWWEAjNXX65kIh+hJla40lKX26dupyNukvK?=
 =?us-ascii?Q?WGAGei7ZJw0qprVX6qifxcdU2XeNd8rkTUVErRBYz8fk3by6gxtz4hz3k/vU?=
 =?us-ascii?Q?rQMRqxS3oOfn5G2kzTZBa3PTgz5ntRumD4iE/lA4Km1GjSjcmfzrBdzhPwqm?=
 =?us-ascii?Q?Zshyrjmuj66LtRijZAg4CyxePEqivvYZ8+ZpGbx4N5aRgUc3gkpdwS0Oe0wf?=
 =?us-ascii?Q?TMR7LarhF7pj7p4ysgsVif5FuWgYweQV0k9OLds3NCzKrUPM6aDuRRboxiIJ?=
 =?us-ascii?Q?oPF/IiR/WnWbgb3VHwUliw8kOOyvxVgaRzfygUMYd/thmyM/Yh7GI2UoiWb9?=
 =?us-ascii?Q?ezl2GsS9HyZg2ff3lAoEpr3CV7Kg7yT/iYF/e2bX6bnewdVncFId6aQVVgFd?=
 =?us-ascii?Q?mDRARMRlkB0ktqHxAascIab0vmt7iqVkUrmpM1N0iwGku/U/zRjgcjA+Yd9F?=
 =?us-ascii?Q?lCsvYmgY8wB3c4LVgPTap9eQrbMwgRHyGi+s0CdObvOySU7B6UaVJNSSJevX?=
 =?us-ascii?Q?a5O7ppox/C4glP8irQJu8TBUaI+ZIMViw+2DdI3xkzb4nJ/mkrg2uqc+Awqs?=
 =?us-ascii?Q?jrtnJYS+MEweARK976oDEIQig4UtVZDLZms7uS8YVMpjEjRc7kaL9oOdM23+?=
 =?us-ascii?Q?+DEdULAtKXZcV+na2jODDNz/b8lqJ6odbQH8bGBuoijsuJSPjFtDD7QDoVaN?=
 =?us-ascii?Q?zoMmoJ+V2wGW1adQy3PWvZCDArP1x1+1EU5i2KmxqgluEwTQoOqX8YlDwsk/?=
 =?us-ascii?Q?mtFI6EdupblbvfgJZSgwrkqjmtPbLQzTnIFmmwdzx2rFWfkvpf4PDTdAQkU1?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Nky0mArsPMZgkxkXjT7mYMXVWH05cMXY3xUzGtk1f5O3ki5DYvAxayq41AuU8ktT5uVsXioWdtg96NBUz7iX37fDkjO1K4d4lOdX7qWJyLLG9hu8DJqt+8XoKCfCylS2yL+vTxCjK91pxZvVi0JLQsVa6zEiPb99C5pUXl/x6ew+J0nqiav7iI5aDcNJLNdMs5w1PHNhp8EekpDgVTFxz6rhCifXk3hzkYA1vokfhKzAYAd5ELF/JUSg1DkFdfiTzbkBGaosKG1hNNv7NUmQESQi9DQvp4Pjtji7pOf+DdMfA1Q0vRKf8pxI2p/Jjq1B6djV2OOV7ofiGWRcv8xMo2a9QQDYCJ5mbMJX8bwFd4oMFtaowRRDYy2YYPIZAG7XV6OWq1CzK1RTRXNV2U0ajqYcsHkKo50IES7bvBeEghVSBK137R5TcLGW5+yzCYU4h9ZLmCYReTIghPuRzKZKh9YHsSEofgjvx/nYxwbMR7DWpHcb/RakStVm+9fjW2t4ASWuIOiSHcPrTBj9f3BLRxgqEj3ENUoj66+fL/76VBvMXq0WU8nOyh0ProkaJov779kfN8V/pnu4X75LNcjQ0OvukVXpzBRFcAk+mUUYq5NcUNzMdUun5ZuYGjvi7k9A4MgHnV4oep+4qO905k9XuRl4WRLmL/Gb7658fTncghmXz6tAZ+ff2PcQjsMT+4F7Lj0DsXpp36fiReJkerQLaOLVkSXFp4PGzMErwNPHeo+8pg67Ytc3gVSgT/awmymM8rOcmWBVORKUl/aFNIj904CH5yi38o1uwqWGf8rAZHS/iRltoUnlbGt2Yc4/Xx0t
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56ac490-d908-4ccf-5e3a-08db59997ccf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2023 01:19:56.3573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESYQD409vO6EdmMX+NjEZ/M3joAZIa8CY55KkjbJPl3xHgKFgdJNLBd4dAEQKzpOl0+BD1IrM+SQEu56p4F68hhoZPMtd+u/SLF8ojgayH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-20_16,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=776 mlxscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305210007
X-Proofpoint-ORIG-GUID: f6GjF8sGHOL7uyWC4DNCXSRLRkztBjeR
X-Proofpoint-GUID: f6GjF8sGHOL7uyWC4DNCXSRLRkztBjeR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> @Martin, Do you have any preference for what we do now? This code
> which does not check for error and does not pre-zero sshdr is
> longstanding, so I am not sure if Juergen's change is required for for
> v6.4. I'm thinking to fix callers for v6.5 and also maybe change the
> API, as I described.

As I alluded to in the tracing thread, I'd like to see SK/ASC/ASCQ being
generally available in the scsi_cmnd results instead of all this sense
buffer and sense header micromanagement in every caller. That's a pretty
heavy lift, though.

Short term we need all callers to be fixed up. I'm not a particularly
big fan of scsi_execute_cmd() zeroing something being passed in. I
wonder if it would be worth having a DECLARE_SENSE_HEADER()?

-- 
Martin K. Petersen	Oracle Linux Engineering
