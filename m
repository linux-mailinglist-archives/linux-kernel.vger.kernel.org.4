Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0126DE8D0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 03:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjDLBYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 21:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDLBYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 21:24:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DAC3594;
        Tue, 11 Apr 2023 18:24:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BLUcg6005413;
        Wed, 12 Apr 2023 01:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=OyPN7I0U/ohnQ7ejkU+iKFjsneG2Erxgo9w1T48u1zo=;
 b=DZ9J2yjCqaUpAzQL7zOkOTTf66IR0LoVKxs+cZMUO0dXcXMwzi2NGb9IXDyORUFzD19n
 lV3Qrkex1DZo2+c/z+9/GdPjIVfog2O+oGLerxDrJUzq1Pa3eiMIFKijczNOZzanME9a
 Dz8ATbiccHMgW6IbEXL8tHe/unA4uJ76towPPxowglYxBhHkMJzIzp6sZ8P5mr+nyOUR
 Nu7mjsWn+lDgZo6imqrqGhv+TWW+qpOQj3V5m8mCC78gLi6MyzDijyQF87px+GxjK2F/
 cRJ4GN3nlxsgClfSb8ZhucSFKTqdxKcCFTzSS9oBxn7eb3BDFCpmMvlCeKCocuazYmJW 9Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0e7eu4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 01:24:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33BNtimd008065;
        Wed, 12 Apr 2023 01:24:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwc53an1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 01:24:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcfDvwm5ScSGZ9IOqzVJDEHj3VQ8pZmOeyYtq3H6B1ICWCluF4m9P9XgKDKhBB7w9xJXJPBK4gl+ueZpl2d8XYLXtRqSbI3X9MFDmDVzqGRGPm3/ZkT9b0KhGXbbk86No4FAM8KWjCTabP0Lt3yILaqNSk2FVGHek1C4qp/yqQMjPYlSbtKIl5Q68o52DOl6Y0CP8NBMYvLiQ83QiXtW1of4O3+g+mp18fb2nSpbb0zDD/Sw+XlpJWazERG/EFr3Wr52L9KZNUuvpgt10vgcg2b67zD1qLn2QWIYia+6midRMilAPBIGTU1doZEGsDxNe/RDhYPkAPzVF/XPM0paYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyPN7I0U/ohnQ7ejkU+iKFjsneG2Erxgo9w1T48u1zo=;
 b=Otd7ra6qK6cK6paOVVCoXoQODyNHJjh7yLTqyP/NpL6psOGk2O1CE5n0LuWJpyMTSd+wZ+AP4yMi80RUTj1tCm/9G1d9ktRvoVRiZqXUpm5DD3sgnFuN7SRA6BTgtYgPYe3GkNvgyXiV5HSbHx0S7QOwKTaPigQvitLkrqK0fTbKezeVzi3QHX7uEYkokLTOeQkyU7uHIDrKn2jr+zOGIq4td7QIouHW3kpKJYF++vHmStmLKWtCkvHmJ4wDOVA3IYfg7IGvmXGMTVbt8Z/6p9NNsNGJVSl6rNWtjIWcj/K7M0iM06JoXbpCK4K1swq6wZQjCXFOrnt/Ro51iuQopQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyPN7I0U/ohnQ7ejkU+iKFjsneG2Erxgo9w1T48u1zo=;
 b=MLYN80k5ZdYv7m681jTT8hcDNStq6RdM+kiB7BSNKPRKOFYFg6Af2QXvRo7z/Ze4yBpvcoJOGq8qKMYMvZytsbnY2rve/lH8i/bEVR4Jj6k3H7NkiI6zPEgy9cFLPj28/ZkRXBc8tsXsHvgebuoEhTWnmaRbXlwCamLJkVIT0vM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6156.namprd10.prod.outlook.com (2603:10b6:510:1f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 12 Apr
 2023 01:24:02 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98%6]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 01:24:02 +0000
To:     Jun Chen <jun_c@hust.edu.cn>
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: lpfc: silence an incorrect device output
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wn2hnba0.fsf@ca-mkp.ca.oracle.com>
References: <20230410023724.3209455-1-jun_c@hust.edu.cn>
Date:   Tue, 11 Apr 2023 21:23:59 -0400
In-Reply-To: <20230410023724.3209455-1-jun_c@hust.edu.cn> (Jun Chen's message
        of "Mon, 10 Apr 2023 10:37:23 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::16) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a34dd63-ba68-4ef5-1523-08db3af498fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199021)(54906003)(316002)(478600001)(36916002)(66946007)(66476007)(66556008)(38100700002)(41300700001)(26005)(186003)(6486002)(6666004)(4326008)(6512007)(6506007)(8676002)(6916009)(8936002)(2906002)(558084003)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a34dd63-ba68-4ef5-1523-08db3af498fb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 01:24:01.8551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K3rbyK6Fnq2u/AgYE02DiVfBSu0G2fne7XldysFWYKJja9hPAKOTPLRpgRFJ1shJQpAs8ZkIMEHvYoKFwXTUnOcgyNwnyMkltehy4zAA//8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=757 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304120010
X-Proofpoint-ORIG-GUID: fsp7fkBtcTTncoQUp_O37b8mQGU-y1rU
X-Proofpoint-GUID: fsp7fkBtcTTncoQUp_O37b8mQGU-y1rU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jun,

> In lpfc_sli4_pci_mem_unset, case LPFC_SLI_INTF_IF_TYPE_1 does not have
> a break statement, resulting in an incorrect device output.

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
