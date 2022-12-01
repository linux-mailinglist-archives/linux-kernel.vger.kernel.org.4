Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9723F63E82F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 04:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiLADIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 22:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLADIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:08:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B0D48767;
        Wed, 30 Nov 2022 19:08:45 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B1297xT022942;
        Thu, 1 Dec 2022 03:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=oq2Kh65ST9lqZbEwSzBAYF8EvPzbg/xB4tyGP610RLE=;
 b=Te0wiy62WqZotX+4jWqoDCv9INtF+gI8M0/4Fdkzx9So/nQzMKONlwaWyX2o5MZIiBZV
 Nu0JQ77ek6kfy0k9xI5xlQ5v2Jm351Ek7TYJqautbfU2ufogI0zDJAbuoxc1dUphgWU+
 6fRFk2EAAYPiVyOsWLGlS17/uLef8WU6hCUwb0qLytAbQ9JMlE3nza3A7+iPTo2tFywa
 FKBNuGHCgi//X01FXIHpolBFUyg0J3UGbtpsxED2rSBd24wO0ti2kiGuYj/OqyqaEyeQ
 rmcw+z7u2Cq6SY/rQcuFT0XJYukfro9rZSTIpvrd+6mewr1cZHbRonbunj2oTR1MbytT MQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3xhtbkuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:04:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B12DQhk036699;
        Thu, 1 Dec 2022 03:04:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m3c1ye16n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:04:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWGWIVp9xVmY4ulmXT9EC+XafRxxzjoLPLMGhLuRwRhlPVnTI/cSOkO1dk3ogkXoChz+ACSLQ/BVMGf98HFj/VjY3czVzaIy8cUo2XYIiFBEwSA2hJ0ct3rPQgI5XgRptGglI4LR7rkuhm5DhHFntnvMwvBJpmvihndB+40Nhm+ZYLiT1eiq32YuG8YZBIgVVCzNo9TjM0Ej96+dhCOWzf7RcQ2LtcOXPCPpQU46q3bYOIb1QSMeyb3OkGrdG1mT8OfgS9cJzmV2Re+DA4NXdHkPI9G0z/kk2YSrr8rRyeHOBJ6+aLfXiek1baZ1Sk+nsRCMdjVvsSftJVAIqpPdYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oq2Kh65ST9lqZbEwSzBAYF8EvPzbg/xB4tyGP610RLE=;
 b=BV+Vl4ByZG9zSGAga4LC47bwBe1RH9/7993nWhklSYS3NhM3Yk6kOTmi8gIYOF0qJIhTEwHpsrdetRTLBSqMJQHDuuHtvAGxjZk4a0CnZjxmSqKk+2MMzL5kFiaSb+u9+g7xnPKaYuzdvFeLL323eWGCDybqpJHgHspaURU3ROZq4nG5OwFlLJqbcbWfkSKGxqiHP9R71iGssfG+nZnihMJ3ASleeUQGlt8yKPteXoQHI6EyOxy73DkYJFMZsoHEOmJo+ECFX4F1hX179BONPvAbl4b0i1CKInjS2ShTohDoGIb9gpf4EOJJPYPg+JHaCzPdAaHU3aLl9GUMDW3s9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oq2Kh65ST9lqZbEwSzBAYF8EvPzbg/xB4tyGP610RLE=;
 b=m5yUpQ9KP6oZHukJzlUzk0NRF3kqFw73Es8P0cb6sGU8I3YzSiHtyonX4k4QAhmjVGdvU1lgE1FRBwjSr7V+uQvhrWVTMKff1IvRlKZ1yF+3rih1W4+O3G3EtYvHFNOIUMIANcmQCTY0TU5ltK/kiBSGETVsQWE3Sp7sFkQ2pQc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB6293.namprd10.prod.outlook.com (2603:10b6:806:250::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 03:04:02 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a%9]) with mapi id 15.20.5880.008; Thu, 1 Dec 2022
 03:04:02 +0000
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: libfc: Include the correct header
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h6yfkepf.fsf@ca-mkp.ca.oracle.com>
References: <960f34418358f0c35e645aa2cf7e0ec7fe6b60b9.1669461197.git.christophe.jaillet@wanadoo.fr>
Date:   Wed, 30 Nov 2022 22:03:59 -0500
In-Reply-To: <960f34418358f0c35e645aa2cf7e0ec7fe6b60b9.1669461197.git.christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Sat, 26 Nov 2022 12:13:27 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0110.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::25) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1c79e9-afa1-451a-eb5f-08dad348b352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g/LD3nfywjkdjh09xPeL4pyPVCNJLCKLS56TNb51YZQqjfTAkAtt7fNxruAv6SZKyegJpfeyfr5ZutygwM6DGMcIPwdLGMR3dM4Ii1WF7xwnCoPneVg1lGGEFtrijJ/yctUnXRw6jHwvJto6pNLOtOoi1KMuvusPd6lm/bPWwsdytvAoml1roWW0E71okGem7+lLmn6jFAR7aGKPbtL8V6HBJeRZyBdR65Z8q7byXmepN+6tCf89iQrf4egct9zbUCA3D66Hn8bymHLQM5zjM7f7H0rmCM5hSaI/prQ6zns563ITXZhWvpGgrE8yYjeTJJR+wrc/JYKyYQ9aQ62vRPY1HTVGj1shVkwN7GbWAxJT75xiiXiLyikvJWCl395UX+8w5hOvM+j0rotTdxTziVJ/bltHy6dAlJuk2qmnZrUagY06l1GmmAC0ozoEYvl27Uus5nbFgPVaa1rjScmbnIedwab1bZyR7VMlXKK9uGL8H7Fbn8kVuCkZt+hwewIo5hKLJpHDgIKjrVoByk9IVfo1eImGL1kCa8s0Ojvk3Sdg0FIZl3nHKKlBqaEo/xsXQkaZ0PsfhCULPgSUgNYrvASTnLnBFbCA/u5xbZj23YE7mXLswscD5e+jT9bWjj7XBiJPOYfdn839OGexPGyDnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199015)(478600001)(66556008)(6486002)(26005)(36916002)(6666004)(38100700002)(6506007)(41300700001)(66476007)(8676002)(66946007)(86362001)(4326008)(316002)(54906003)(6916009)(8936002)(5660300002)(558084003)(6512007)(186003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yygh8xCByGhd8G22r+VuDLDLljkswbem/zGhb6I0EOyCl/Li560hNX0N2SWQ?=
 =?us-ascii?Q?TnY2SozFjCx3BBs7Oxsmwp5GsdYs5VwM3+LDLU1GgsFsB7aRXBhfyCSrCUUt?=
 =?us-ascii?Q?BLm/RlWC7kgCRaYbsChMaFl1c8k3TEZy9bl3+sYbNeelkicSr7EGwUbyFzBi?=
 =?us-ascii?Q?lMjmc6v5LgaXKvdn3E7B/dq+WwC76A/coEHWgGeyBT9f63o3sVkLAd+NJzSK?=
 =?us-ascii?Q?9iqnFhdMvvweKrai5jrMYxQpIx4EPIp/NusHrtLguh+PYIQvitMWIvicdVmH?=
 =?us-ascii?Q?/dVcTKYYHDxdVy588UEzAQ/qme7R/qMQimcBdW8DUaZyvusZJlnwNqniJXOW?=
 =?us-ascii?Q?F8pXvsZh1dIzcgJKmHeOk6VNsjPtFYqVXS+C5MvvPbOhySjMLxoFCFDTPHrH?=
 =?us-ascii?Q?IHmXAE29ChfAk+PJFGNZwj3LTSD8cdECnL+6Mg54KpY7WLCsinS4Fd/g3/Ki?=
 =?us-ascii?Q?7a146mZgh+/ZMJvDL7TuEdPjI3DfnFMYpqyjtikufnAaM0HnD/Wxxb/55xxp?=
 =?us-ascii?Q?G1hZH7i2Ds4Cc1Ft6EW4k03H4ex7rfJJdmLGUKaSp2gzEfVM7C+92B4oiG9C?=
 =?us-ascii?Q?PhNZKT1NRmp7w3WcSkyqOzfMy+EnV/mek+OzuGfafTAD56K1gCFcj8Q2I7Hn?=
 =?us-ascii?Q?0Up1Rl8f9XNRHvNPHo0VtGjU1CtBAKaq/L0igPSkv4V8ELUutzQQ7qoqUrgU?=
 =?us-ascii?Q?cKjRZR8TlBtrGnv3dxYjju5sLx3x0211XiGwRg1HlMFESLBu2a4/TRmLq7c+?=
 =?us-ascii?Q?plSLeFjO5G9cFB/rR7rnhedOFcDuko9gUNFkeHNGEanb3xlePNmhSxkSdw2j?=
 =?us-ascii?Q?7ZHqeEGShzZ9Renr42+vz0Jtka+seGR8w7UVhcRz1LxyGvRB0FylaNHg3Ufc?=
 =?us-ascii?Q?p92rwDh20OGqRxMGdJwZ7zlcH9IV5O7zuiijeYKrvVs4TxYhK7/XLVnzqDR1?=
 =?us-ascii?Q?MuYuiijxJkMg+Iwk5a6wj9NC4Emu2J4ZQQux+P1oYnzWShlR1UfSN2z/fZa2?=
 =?us-ascii?Q?5H96YXc+5sUY3FkTIDD5Ch47PDEbECDl+HR8vcV6Jb0KS+Nmud7ek5qad6Fl?=
 =?us-ascii?Q?5CiYwEaTVYlTxUu0nglhoYJYRQ4ulrByVSj+7sJg6GyQfOQmBSBHxHQmLFDa?=
 =?us-ascii?Q?EuHLl381Vi3A+myvkL7Cm1V+GqCnLFzRK+LZwvJyOtQZt7kSEUpBW4THknC+?=
 =?us-ascii?Q?EnNqAUODieEM/berfjBt3Fdyivs34BoHb1eAR7XeVx+AphRw2+cBaP5cl11D?=
 =?us-ascii?Q?kCipdMa5PJ+x2e71VO38rohiUPrHNZmw2X7x9oiGHm8zqj2NygEohhBy5/Yi?=
 =?us-ascii?Q?GDjmuLlEXDZHfefHtjYsX9WPK8kM4dwRiHptRtOsx2cZ5UZ+eh7lMeZGeOdS?=
 =?us-ascii?Q?ebNmk+VxM9k4+VrfR3l7MgcX1BYzX+Iw45zBuK33s/v0dKRko5G4mm+1rL6h?=
 =?us-ascii?Q?/eYAnlx3eLGC5CfSXVYeIsQQZe9fsEBsp3JiN4ZN6NYCnA9BE79rzMv+Mv8J?=
 =?us-ascii?Q?IxuH2AHKYYcNU9hCqf8Xxt8LCSj6/vAiTYrNy74czgC3EW/rMJwJJIIDTnNG?=
 =?us-ascii?Q?wkc8Vf3xdbMvv+WZSpYXKZE2wgTTYDka4F3ctSI9puHLYSEyIdb0vJrk0fWy?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Sl8JggcwMAYAOZBZCLDTPPCNRGvSTVddoyzJQkrxFlQd30UVZzl2dRrp4IH1?=
 =?us-ascii?Q?qDWWXoEnMSjjVKryOx9yuj9Hx+rS+IX15ES82wVMj0UGTkovjpJQObewygxR?=
 =?us-ascii?Q?VNy7Jvgmyh/EFMsBm2r0b6j64D7K2/fIlUN4ykiSCPOqgnSyBCSzfbJt8RmL?=
 =?us-ascii?Q?TfAJOnRSIVIRFLHwtPE08jAm4nGsIgAlpdqgxm1tEEBspuK30ahup+21/onr?=
 =?us-ascii?Q?Cxq/1ADzNpbqndldVhAE70Pe6M98WgYbI3x14VInYgAQ88IlnIGo8uDCPiml?=
 =?us-ascii?Q?iCuK77yTJ5z9Syu+1fKvTMuMhxebCw7C9i5PKQjoC8gmCxWBBH58sWxLdb0U?=
 =?us-ascii?Q?okJ49yBqkaZXqegsJhFwZmk08gTI+wX9xrPpY5UDfZH6tyWMAnNv32EYuD3+?=
 =?us-ascii?Q?qWzBYRotxjrPpD5GKBH03HmYd+YeCKeGyWj+lWyVSVaj9xmebKp20AuTMaKs?=
 =?us-ascii?Q?5oLxIgoqhVkEXcDaYqF7F1uA0fKAdvZIhIiF6eNmz/SGcgLcLkJocZG+3uw2?=
 =?us-ascii?Q?Wk7TqYe56St97VwPp9lM1XWbP8BhOImVFshMhtmrz0B30kUIJkb+5wtiMBdz?=
 =?us-ascii?Q?3A1hsT1uKu5itTdA3vBDgzBmde8ajctY+J8y0E4avYuMtLyde8b+8clUGwRn?=
 =?us-ascii?Q?EktFC7J0H+lOGynB1peZKzK7iWjBqKqM1dVU3iJ4LDsEYniYuOneNlKqF2A6?=
 =?us-ascii?Q?SbLdt5F2nXYZhr6i1ilvmWziUgM2zIpTFejHAEZxu8bU28JhjoVfqLyu6ZS7?=
 =?us-ascii?Q?ZvOWgIgk1zSeYeAbUsbEb65R8RwNJhbCzPmpp7yMw/ngGu04T/2fdvu9Uxpy?=
 =?us-ascii?Q?Fzb8PAwHgJBdbYbtPddqA/x5YcMAH6TaiWAc6r7XZnixMWjRui4QU/IitsfZ?=
 =?us-ascii?Q?5BJJKN88MrzBvHfhGUjgpCgXuoyVbxuDkUqElfRLar5s2U9oW/M8udGqgcA8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1c79e9-afa1-451a-eb5f-08dad348b352
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 03:04:02.7570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H75ED3x39Fx8b5w+gsqcCfUDUbMzJgFbF42x5V1i+xSClUHFzi8qMUtU+Yj4xIv33JV5Ij1qh9xLKQXOi3fggS6D+/+WRU32d044VisgsGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_02,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=826 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212010017
X-Proofpoint-GUID: 8KbbqrxXcdqOWe4ILU9WApmiQjbyNRl2
X-Proofpoint-ORIG-GUID: 8KbbqrxXcdqOWe4ILU9WApmiQjbyNRl2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christophe,

> This file does not use rcu, so there is no point in including
> <linux/rculist.h>.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
