Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF71672C8C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjARXY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjARXY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:24:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5D41B577;
        Wed, 18 Jan 2023 15:24:56 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ILmoId013700;
        Wed, 18 Jan 2023 23:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=cj4WNjbuPOD/I3yVvYNGWlTORKYdgzbXfvuI2jTdetk=;
 b=TiExImhtf2fl1eyUZ+cvgRrU/I/NONy8AR/S+75rUhImHqvwLQW6YlDuIYDQGJ3NYjnj
 fseZ16mjbmepRo0QxewlPYyshbSM16l8Ottsd2moZWnygRCMuCnhwwLAm0bSVAz1m0pA
 Axp4/jTf7zuKdondYNW3DiA6Z3hGLMr4oy3/Fb/PYeAi8BXSXWhaKQKgOGyhDYQe4h9d
 WOUxiBeOEfbjKS6t0XiKZCppgtJBQUfi6fFYK85N1g/nrHRhsi1b5/JtcQRN+aLWjLr/
 cWxkbOxWJQcPboL8n8JCZ17q6mjhpJvxqCAWsr/DeYH5AK794ELcAxhLsYn5W8om9t7C UQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medh0uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 23:24:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30ILxHUk009477;
        Wed, 18 Jan 2023 23:24:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qmcx813-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 23:24:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWhq8px96Jt0apFC8QKkmhej4py+PxbGai+IvQ1B4aAemaF+yoGOUeKcubxF5zZhUj3r8Tf++q4X2f6bX20nHJW+Y8llwF646O5Zt6e0BVSUq+T7r22HznTRpRZdU2REMHrDjyit4wZXNOpSLAcwRreEQu92d++w/QjSYAO6Q2C7TWVUNDfPNad238JBA9KaMTONGWOllQgZOdGMp0VX4HXx9jKsR6/UIc2AKwFL8eGWmU3y53KYb5IaxpM6PBVmwMkUpJE6okDy1PnNecpgg0oxgOAH8pNbdh9vmbK+t8iOtA8BlRULCmf/0nRYrwCQlNmUF0s9wU7kleYF7LTxUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cj4WNjbuPOD/I3yVvYNGWlTORKYdgzbXfvuI2jTdetk=;
 b=m+atY/lBMnJ4E0fYz9mAepP6h9eXLmB1UIluZfM7Ti3aLHBfXlywSZQu/jJpLOw1Uq2AfnTHab5kQaSO6sm0fh+Z/0xtI8ez4QtagtGYcXadqu4zS2sNO67nub2J1BkiffRGl57oYIeXbDNVE7q+BE/LAUYutS64XOccUPYHR9OC3FoDkkGSNXv8wcB1jtl7kVKO265r/IE2ix8bP17AQWzOqcOOrpLttQQPvjr1ASBAdpktpsMdHn7Aa0+M5p0uqoXbQc0FIhIxpkigsR1nyfIXJ+KUBu281d30NlnEOZFJ/hk/lo+kM55Obi0XG5Kot1qVneb+OPmbvwgjt0SiAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cj4WNjbuPOD/I3yVvYNGWlTORKYdgzbXfvuI2jTdetk=;
 b=sp6vgvHmQfCPplRtYxlozuJ8FV7naho8BI7tU3gnmVEJhCfGfLZ5wmkVd7SxFNoMI2jYE2hDJ6wG62j8KZutd06hMuF4wgHVuliQFcpN6sFXIwSra0xkXvCbWP3o9O7rZuSN36LRf3esygq8bFEzoNutF2GxgYNn95L83j/sx/8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CO1PR10MB4660.namprd10.prod.outlook.com (2603:10b6:303:6d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 23:24:48 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%8]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 23:24:48 +0000
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org, martin.petersen@oracle.com
Subject: Re: [PATCH] include: ufs: Remove duplicate entry
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11qnrqvd4.fsf@ca-mkp.ca.oracle.com>
References: <CGME20230114022406epcas5p4963a02aee5acb201c5e3495b6cfd44fe@epcas5p4.samsung.com>
        <20230114022010.27088-1-alim.akhtar@samsung.com>
Date:   Wed, 18 Jan 2023 18:24:45 -0500
In-Reply-To: <20230114022010.27088-1-alim.akhtar@samsung.com> (Alim Akhtar's
        message of "Sat, 14 Jan 2023 07:50:10 +0530")
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0053.namprd12.prod.outlook.com
 (2603:10b6:802:20::24) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CO1PR10MB4660:EE_
X-MS-Office365-Filtering-Correlation-Id: f9acea75-48a8-4932-36a2-08daf9ab30cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fck8KsMaDsCFgaf2ix5fV7U0JVBr1OkgBpoA7S6kCY2SXBsHABXa853ycAlkBeI2bul1dk9Ar9NB3fwGQvSzAE/W05nqjN5yzF9iag/pngSp8pcyexszXhk3njf6+qI5rD63CQ+1CsoToc+4ompBM0KBOh30bWfwTMxkf0FSPpPzw0Y5rt+XksD/DhLimeDDloU3JfL5TOQWSVUIfqdpXBMrLvd+flNT7qbPtEA980Z3uaUV8WE0M2aVGXtn+b27fivNhLazci2dog2cOqhMYUu/cCMwPBJfzQIX680NgDwrFT7pC8L/eIdNCefFPgwAeIQCuV9CcHe5D14uUVLcKEJKBbQtQq90WeSRVznEAD3BU02UxAvmNaIk/DuiZZNskBvem8pwZfbeqSzAhkVRBg526+X98O8C/8kEeB4WUT5Un529bYYkzBViSUujeiaRC6+1ci/PLycZZN3tnUqzhXJVSo8P8/eFy03KPkeEVgbNKiizeGVi0FPpekR3y9IXgIo4kWlyn/0zN/oaTy+nxh6pf4uy9qnDPR1Z5lAecNzm84vm00gYgw9Epqy+STosF6FrM7WVFUCjzj0vWa/eA1nPxR5s5P+/cwPPa4sXvlewBKFLUWpA4L58vpAiI88zTgrvomn5gAZZL4YjNRLi6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(83380400001)(5660300002)(8936002)(41300700001)(6916009)(8676002)(4326008)(66556008)(86362001)(558084003)(2906002)(66946007)(66476007)(38100700002)(6486002)(107886003)(36916002)(6666004)(6506007)(26005)(478600001)(6512007)(186003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WWcAu01aZUSxo8HEg5v/mFlaymyzElQnz46FdXVWCfngodL6DfWbY1Q03Fjt?=
 =?us-ascii?Q?Asa5stVhl0+WXler8z+/0OgaZbYLJleqyZMHYazDWMIKM1pQMizNIOvIIqc+?=
 =?us-ascii?Q?bRWBRWprh6WybyAAjEhlkMkFKxNT6Rjf13KK40ejWMK4zMSC6wYiQZ7CG0rS?=
 =?us-ascii?Q?QES8An2K+NQj/gSkxEsBSq786/4UB/jU+TbqnHCiIFbNdArWjlwkP9slCyGL?=
 =?us-ascii?Q?GgCi0U00eBLxZSSBn9SHv/uMDpLJb/2dbt0QymP9K98T5MHqSMBF2eXTa14Y?=
 =?us-ascii?Q?TsZy68HVaUfAHuGeeiNEqQegJM+8GQxHS+/BS4gUE40aapAytuzl7NZAczAT?=
 =?us-ascii?Q?znvfIooHhV7B5SWviab0JQ24v4WZtxCLJWUPEayKeUII1qd85uevgmOmvaBu?=
 =?us-ascii?Q?Hs0zfRrEVoII4UQTyfuqsYZPWvaAaTHJ4kV9iPQRHceQhbBqgU0N7lVItZfc?=
 =?us-ascii?Q?IOv53ek7EUQUL2/sYpWovgk5m5dVmhv+kGJjHA+VDVFuX4x3eAW14e7N/YIz?=
 =?us-ascii?Q?kY5vTI7z4JOMo+J5CkMWGSF7TrZMTVGRN+ObLx/3ed9ltoIQyFwYHC3XTBRv?=
 =?us-ascii?Q?LgKLWncu272E8o5mthwYVkT2R1bE9OvRJV4c7Z5wGRdzeICM6Zv87pXxEUFh?=
 =?us-ascii?Q?5XPwnhqjbrPBh0VwdRgGyByXZEoTDheuOgNqRp7A4TJjag6Ft6Rt0z4vHogV?=
 =?us-ascii?Q?rPMg57EhRdbmeyJIrZblbAQj8zSFAFYquPK2zi6gnwyee4WUaKgSgIri7c0C?=
 =?us-ascii?Q?EON3/fjDEtIYOpmfhqOh7X4Pf5gYVXde1EpZooRIBUH/Qw8LAiUwxf6n4Wq/?=
 =?us-ascii?Q?ITESZGMSgbQqELD3uwMey6CclGcBxvpAHEO3TWvQK+0DCUUJPHY9CIo7cZV4?=
 =?us-ascii?Q?ye1btdbMxdg44T5bT4bG26QaDJV+JjW2XTNCaZ4t/7Zc2pSMPHx40vCQE2Bq?=
 =?us-ascii?Q?cNHF4PEPGMRB962rqZdCjvpji/SNOCkKC7Zz/EBxoO+lK632N70lZYpFPJ6a?=
 =?us-ascii?Q?/SISQ8G1EFm1tVboYjqCMPQifJ9+WUKhVecpwLwkGeFCFeRgHnjFwVJcOiHT?=
 =?us-ascii?Q?kTr0Oa/LoC97FvhY0gM5IrKcMd/DmdNHlEtXPg0iMZLvX4cdCfIoJNaoxLrX?=
 =?us-ascii?Q?WSckRvuDtSUmQbWMZiHsKK8KFKuIFmOsNTuXaNjp/DNLphgsxAedwXypbHG8?=
 =?us-ascii?Q?Mt5RlJSO7JGI8BBj0BymMKRylF0M53ZnK70dh7u3tkwte0pKAnoUEfckTzio?=
 =?us-ascii?Q?SFjCyC3yKlrMs6MJ/bBrJPpQp6Vrij9+jDuixsH8g7H8k3r/VamVdA1Y/qzz?=
 =?us-ascii?Q?jCI7da11/G1bNvIbm38HRBEal8sN2yc/8JsZzlwczVSKkxFavc7V/QkSwIEm?=
 =?us-ascii?Q?FDi9bYcEeT6cnm5giIoO64Noicw2RQQVSjTMWXLK4M9B0RGjUqVHbjRN38kG?=
 =?us-ascii?Q?VrGXMrqpXzXaiuib3q4E4c4iV6MyRVpM3H7AEL/xg78RLqKJxcGpuIg5X2E8?=
 =?us-ascii?Q?9N+qcfrf1Ym4H/m2o5EcjIgI/RJx0rGBp0MZbLtM7CKoZ7++QM47xshga7xI?=
 =?us-ascii?Q?KLQUo/1G7fUmtb/8E8raHoUG8QUa2NttFf7mlhex7oYXbX4Fdv6tbKvqH9/X?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EBtZMKHxImOpZ/l0SKjgh73jtrvNcCsqShZ3DVLSypzPbuQV1yytHGxG2DT03IwjgGthY5ubIvQXWahFkEbRfaVvUo8RDs0v4mFBM6f5MzQo7p6tY/P2fsGAmdUo+nvCwmbcQPscDIimzLRlp+4Eg6XbNRuFKue4/NUytMno7/nJcfMlfRdAlKvPQcKIq/Mb53utbfJhtdDsUSqNy3ObiDCws23KVMwYcKAJ7mWu2ULxniKqTPK7d7Wq08SFMOWinzvvFwtHhsOO9BqV20WPYVCSqVCt1rfAPT278ZovtqxyCvMtPFabSioc3RME9Wto/ZzhIPOc/uxpYKqDLswEKQTEj4Lvz7Sg6lFCOWpiUiLjcaZK45Qw+su6Yw6du9FZEjDMyte+PXXp9RSxIQs626tgQdoqFuxjx0Kf10NRC0++Nsr3q2jAvsIR/UkaXEp70zXsJysHm/5PxSWO7T4imekK5JrBj1TKYa7oBKeIZzE6Yl42t1WGOQbhjtYDImUPuqFs4flBdByfTpUxyXgGXZschIjtXhmedJDgbnKLQS17VwIeo6wuLLCHMGaVPVltPt1bgbvXxK//IQXJLO1ccIsuuCxH0wfBOpRHIPwG9n9eO3jTgGhXmudd7X6YsU04X5+8pya0sYpncc0gE316eEYmyByFb5LDaVd/ZeCEMTM80iYsLEvuQJlKFAFaK4Jn/3HuW+360cSJvK57V5ehMP+XW/sTBefWHUeoIj4HRtyTK+vqs4hegaGC2P+nvQt/nuTQxVNa4q236Gd4clkZ1UmBRrNuhlr1k+3EWE4L2WzL+zZ5HQjUoPrswc4Y++Y0XVmfUSwax866BXGgQGRiqw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9acea75-48a8-4932-36a2-08daf9ab30cf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 23:24:48.1831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CMsoE4t+2fsfudmdmo17nghwo5i2Dx5+CSegn3VBoek96cg64nwYBvcuoP5ZGXf5echbbBxqiX+yEe1ynDoedTwMIfHyOSCHpoDZaH6RgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4660
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=977 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301180194
X-Proofpoint-ORIG-GUID: xeYRSvLTP20AN9QImbofc5NwBRI3U03E
X-Proofpoint-GUID: xeYRSvLTP20AN9QImbofc5NwBRI3U03E
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alim,

> PA_GRANULARITY is duplicated, let's delete one of the entry.

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
