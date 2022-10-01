Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17935F1B95
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 11:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJAJui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 05:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiJAJud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 05:50:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7789810FDB;
        Sat,  1 Oct 2022 02:50:32 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2919O6s7019200;
        Sat, 1 Oct 2022 09:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=NI9oEKnTpMZ5UapiTrccS4QJ5z04RbaaYBYPtOuZCtY=;
 b=kKLpGwPuNF/hv2YxTOjAca3MwmkRAJ1X6N8WQotsZa30qia/0JtEp+cvMis0RH3ziAAk
 7VrbIZkEHpZV5pA+KwHsPPtypebrHY4K+8Nfl3VaKeheXuGAwP6ejeOjvNinnTB205wa
 nh7DjYF5AssoWtUbcVA8LDsLvyAPglBt3GKjYvB44JUwL1XIuDaXBkbQi/pbi6heLhvT
 179FLZdvqjSZYCrvEceM6YnYjRXJiE7a0OMt8VgnrJbiwC2D7sE4VUbsaEAcbyN655Nd
 AWeD6CWLglwP6BSE2CMe+gEEDgZzBD0WLitbIN2pSqwzCD5W41105Ebtw4SQMo8mzXVz Aw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxc51rgkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Oct 2022 09:50:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2919AgbY003307;
        Sat, 1 Oct 2022 09:50:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc07pf45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Oct 2022 09:50:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJO79FQrVfDDshaTDxFdSPlUCt6OXIZHZkyLinhLpDssNtNoI9A1xflodndSHZMtXT4FFyMuM9m/XovwQVqxaP65oyxJRqpEcz590FQRiYvJGftAXTo/YEHJJWkSdT/c6eiXgXOhVqX13ubzNBTZTUTOZxs3FNKv2TOgBhabyjXBDbZ7kAIIcm+OPFCJL59NP08jTDMR/cBgY9AC7aFdaIUK6jm+2lxctpmUBoD+x6XdEzrBEygfLS65B0ummILHkBJNn732K9F5Ll7PfBW668hNNja+WgG3W4ipD1H7tGNZTJiTSACLzWd1ZsbUt5km03/8Bw5dxCt/Ae7qc7d34w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NI9oEKnTpMZ5UapiTrccS4QJ5z04RbaaYBYPtOuZCtY=;
 b=Lc++Hv7vatvwTR9n/90doUY9CmiFHlBhU14xk07FTbLhBvzP0FsssJyy2DpBzldW7wBC5o9+BHaqByYyg8Seni5/jNVsAwnwzJtlFFIY9Uy7dMBAtPc6+PdSA8jZ2LqwCQMyYWWgPYvaTqHFj/6Jws1NiXgHdyQOVyVH7oiVSWBaMT0x9uhFFX34TbmVRKlObaMHn+ktXL6/AvKCAlsdgYjSPXoefeBdB4o0mHNh9SDLp6lxfVpydmVsqYScV73Zv3P70YiMblA/I9s+O3pRd9e869T1/5NzXX3P8CkuJzQ/6E99BQ05pBzj4ngKzgoVaXnS6KNJDUCBnfTBb6g1fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NI9oEKnTpMZ5UapiTrccS4QJ5z04RbaaYBYPtOuZCtY=;
 b=eCdJnZ3kLWHRtzjKOo6BX/fh8/Fy/oJYnpFGYhhazzQiEzk44vI+Wbgdg991ZBR/AUlHV/GcPKjJeV0rnHkIWOTgF/KxJFgn1nWxdj+gA5J3dwj5ueGLnNaLRHHtgy4tZS/uhcWh6XFHbVELTAlPl/esk0AOTKRDXd8qVGCKIpU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB6616.namprd10.prod.outlook.com (2603:10b6:806:2b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Sat, 1 Oct
 2022 09:50:22 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351%6]) with mapi id 15.20.5676.023; Sat, 1 Oct 2022
 09:50:22 +0000
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Quinn Tran <quinn.tran@cavium.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: Fix serialization of DCBX TLV data request
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1lepzkh4j.fsf@ca-mkp.ca.oracle.com>
References: <20220926230245.790508-1-rafaelmendsr@gmail.com>
Date:   Sat, 01 Oct 2022 05:50:19 -0400
In-Reply-To: <20220926230245.790508-1-rafaelmendsr@gmail.com> (Rafael
        Mendonca's message of "Mon, 26 Sep 2022 20:02:44 -0300")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR01CA0010.prod.exchangelabs.com (2603:10b6:5:296::15)
 To PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ec7e41-e737-4b52-6ba7-08daa3925b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R7exUTq5QSVmldPM6fCnYKzsnfqYomABPY+QZgKDlZCLjG1nUN1Gx2EsLXJp31L4uqlnv7tv9RgVdAZFJJgeap/hj9gCQeVjpcQGkOtl5JNeit2okLCw3RZHx2B8ZX0CVftoGho8m8/9crsuogxZbvDrdpQOIct5SoQCkZMrCGQFv3IyKwAesD7qmkX84456mhIj0GD65M/1bFRbAVQRxQHXTmzeTaGE03gQuwiraD4RaQLzckhu3tm1H16lbIeA3wex78lWbAghsQLTTaZaR3DQZ0Va+JC+Tednyx7ZxQB2uMrvnjsyc0jHAfeUTJg4XnTk2fUfwPZ9mGGXHuV8YqwnlzuLghoWR8r69W6WSfHtHJJDRJdwn1L1x/fnYuDtgJFTi6f5ye6PIui6JliiC40H7MGFw12ErPFRXCbr8jsrq41HkES6xwChukXPWApK6Kre+DY9BaeUzFl5CZqTrrAT1JrdW9gKjJv7bOqb2YGUmPtNhmgIsTce/nE8H77SwzWhDnzGtNjUBMeY43CfT5ZhD4km7SaBT5Ar4UuSMs0xxebsEIqdktR6XJwWuUvj+n2NIU99TkFzZlJMOsBc9o4TeTiaeovBHOWFr59AFQ84DdCoXHmYKjR+bC6ADkbZEUwRR+YpEZEJAkmKESNaAF9iHsJ5J2qj6iZdPBk4nJPSHj+guVkoVrn5YT0pqR/ZAJGy/e5zdxXJKOdCRScZ8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199015)(6486002)(6916009)(54906003)(478600001)(316002)(6666004)(41300700001)(8676002)(66946007)(66556008)(66476007)(5660300002)(83380400001)(4326008)(36916002)(38100700002)(6506007)(8936002)(4744005)(6512007)(186003)(2906002)(26005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?74T6c7jyJRdARgzRjonlCwBkmcTUPEgpPq8WHZbLPy0Wi76OJKmRDR3i1Wkf?=
 =?us-ascii?Q?1BF06qMYcTAB3nRyq4M0Hj7+09GlbmYqnrJLiE91mxc9JidLJzi/NDpxQahY?=
 =?us-ascii?Q?cgWQ6wrzUo5nSuteck0Y/5K7zOy3ffnbZi8uLgV/WTfCGSit8IR6mqDz00hd?=
 =?us-ascii?Q?oRAP6C0Zeadx4dfnktCum+6f4RtNPSOG71U2slcW01vXrOGFDDrja3uWAq9J?=
 =?us-ascii?Q?SAB5/TopnaYUBsNgs8LEwNtosREGN913GQGzLMKVVnuUiJMjdzEI6S7RaCvF?=
 =?us-ascii?Q?99DmAB/W8Jkyh30I9FkU7VzfQwuqaVtORd+x73toHPfwK2THsxagkndLwsBy?=
 =?us-ascii?Q?cRXN4iiX11mL1hfzxMBNL+LgIgmdiedxOBucZbLth77chUQa0EOgqZFisN0F?=
 =?us-ascii?Q?H1nytRrOC83+nhXKhkRikgT4Lcnz6KiZ9vPyWDEApAApQccoqx5A6hFhTHTU?=
 =?us-ascii?Q?XcXba9jhdW55N4gEqLQJ3zQurhKvPdt/SHjhStVo8b8MywzT+Pg/OiLm0oR2?=
 =?us-ascii?Q?mMGSsAI+HYRdh/OmhXLYarqRdg+toC/nEIiXRAqnNiP6oy5MacJ29BhaESdc?=
 =?us-ascii?Q?Be7h6bj0gCnEi/iZQnjzVecfIENJcNCxe8hasUMLymLJgBo+SSxPUX6ylCNw?=
 =?us-ascii?Q?FOg1FLUBiRwt1lF58CjtYCpmJ/9bml6R4eBMtioqKWBS0aAo3quDJIvdvBg3?=
 =?us-ascii?Q?8A9TylJ25VgqJpOHPyXucDNYjSnUjCiyDcDxjTw4U1qdJzfIU/9/63laVZFD?=
 =?us-ascii?Q?kdUACTFk+l4o9Ka++IVLTIi4AcB8Oj56cIlMmSbR2XTpmC0cEX+4Be4q3YWN?=
 =?us-ascii?Q?XJyA7c6iy5iP/HK51rw9T0MB3bQRmO4QHtur5kULlK5QeyRcK0eU40q35o4L?=
 =?us-ascii?Q?pDvuxv5NMeByNrb2xpMamv+okrgZrWmAGS8a71c7o44uBtXManVkTujDhX8O?=
 =?us-ascii?Q?Z7uJnsw2uFWWAqM1VyUAJMFICW30hT0zBVU/th5Fnxap4wrW4UtiyWyT9M55?=
 =?us-ascii?Q?PtJwBz0sREjw09BVadqUft5RRZWf1gVK/vuK6PErUFTnjT0+Q6IFnRPTTwZo?=
 =?us-ascii?Q?dCqi+RI5s2EcrUzu4ri8DGWtRjlbIZSaHqwoiTgQ2MtsBNGhe2NWhWi06eWM?=
 =?us-ascii?Q?wNew2e/VmxhGwm9E7sWvaG7ruhlvTKk3b+3KII9sBmMQq8u7L8JbcYol+ZFX?=
 =?us-ascii?Q?2NtUknXwkFvTEd5pqhzgng5NtKm6lOe6VJ7WSFgcdnNzaBbRtN/F0XSkX0hs?=
 =?us-ascii?Q?APFbGu/w9o29e1QYpYolesd37B4TX6ubl42uQsgNIIlvFBFXnw4RasyK0dIu?=
 =?us-ascii?Q?DH9WUo+CAhgkkCUL8+z8bSdhFbPStYfV1np10Bbc7OcMKOoGF1tf6tU3FFiW?=
 =?us-ascii?Q?FGm+AmAOCRdyNfSnOv4oljjGtqMhyk2XBmmp4iBdlvDe9aqah6wRcfy/3z6U?=
 =?us-ascii?Q?d8RMQl6p7nVc1/wyQZCGs72i5/t0M5BenkPYVL0ZahxA91vL0njHVmQFR82N?=
 =?us-ascii?Q?O6HxLi5HmOwOtdFW/jSvFVo4svtC2Xd9XOItX+8w6+T3BJlkoy6m8CcZxyas?=
 =?us-ascii?Q?uIh/4UqShfY+hyh7lnKECv6+1Ivsr0EokTZvf10kezyzTGOvaGSkf6utM5VU?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ec7e41-e737-4b52-6ba7-08daa3925b79
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2022 09:50:22.5801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8oBoTLFFqw+UaFRuUJ3Ve9j9TpDGDYL16PmDhuOUf9ECw4m6oih635HFmNsyI+H1Y/ZeSqAxINmNu7AEcgs7pKhDgqTH+HTqXz0nXvpnDpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-01_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=867 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210010061
X-Proofpoint-GUID: SR1nbTKjQIG75pMV0Gsjjlcnyb3qn-qp
X-Proofpoint-ORIG-GUID: SR1nbTKjQIG75pMV0Gsjjlcnyb3qn-qp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rafael,

> Commit b6faaaf796d7 ("scsi: qla2xxx: Serialize mailbox request")
> serialized mailbox requests from userspace using the 'optrom'
> mutex. However, in the case of DCBX TLV data, if the memory for it is
> already allocated, then the mailbox request ends up not being
> serialized because it is done without holding the 'optrom' mutex.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
