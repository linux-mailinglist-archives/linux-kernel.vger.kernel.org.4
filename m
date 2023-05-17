Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4938705C8C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjEQBlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjEQBlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:41:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C975ABA;
        Tue, 16 May 2023 18:41:06 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GJxV5K010600;
        Wed, 17 May 2023 01:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=YjJi2FoiPMdwxNvsqQrYHSXguML2hbgiYXL2ZqbsiJwXfPs9ZEgIBCsE0YItCL9WGcO3
 /uIwxJBtuxS9DS/RHiszLYgLQrcl6LAusNlwFeW63P/DRW10crLJfWmcI4WowS2nK23X
 Et+asgsxW4TASybGTIx16v7vHo38UWUNasGgr0dVfZ2BR6tasGPhLHigsvy0/pOFpQtU
 o0vskPL7hcS7DqVcZ0jq67NAd/pLfuHTbpJIWImt7ITKlXiIbIKGPsEiUgYQZhbg0J00
 zZmboX7mSv0a+08wOYpD0ln+FxymCgYG/3sypuGrqsmBW3k8VyyCypFn1PCwNGF4/+Cy LA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc4pju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 01:41:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34H1H7vw032130;
        Wed, 17 May 2023 01:41:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10au4xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 01:41:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mB0A/VpGf0UjfDKjzW+F5x9dofuQFQnxvyGujUJFb3jKIx/XAi3iAZOYZ6RBgFPoTnRCZW3JJhxwQvynTRBLU4myjczovUH5yxrrKuV7Zy6O/fJr8/zvPmGtBKRCiJ+L/5mM+H7nvQ0duBsogGeux32wnSgwUGxRMQAlNBVChVJr0y3H4QXwhT7wYVmrya0/EPxyHcCLeR14k3DF2QWRBtw3daxJAfBAEUrO348fs6Kfk/f+cB46huMeddM+bCa+a7u55N0ghKseiaEDmrpEBN1/zAPQI4sbFVF6gKodaXDXF/KBpRTSgSyWDtQrWHmVLn//IsxpcmRe+SWHoDD7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=URfomY0fk5VEPcdz1nSFNn75SJ7aquaYBC2TI413JnDvCDE3QWvIm0X0636yBq08j7pqyL3QZJsNEZpEk4Dvb7tsjHZzzAEGhdUEe3xO9AUWLII2LUYI5zDK71Pjqj6UX8pQmz8b/5VI26DDXx2nRK1JmV4mJavE+/DJcip2JUy9XPyVBg0EPn747IffIqMZZ6w8tF1wXolbAm4Lx39xE6Du7rDU//uK+VNoLfCTSn1/3e5Q25+nRLuWWuWWCyqS/Nwu9V+FGrl3Qd5SOICqN00m3Y6iFgNbJkEd0MJHxZ4v/GjZh9drdpfII5zD8RIjXrxuUEbBz7r4O2ZXtYmTYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=DY9TfX3avRX29qXnBYV3tD6VbesV4rrBgcGq3qi0JM80KtrzmLMXrj8ZOH2SAmvTWS+L195jTAblpf0JCu8sp6uO8mcqo+r/e2iXGIDnO34cpsq8QwLfygIharhtAUJSoVXJLW1UuVZ3cPdrwoZ+xgnT21o9/1NiA6XmKW0uXw4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA3PR10MB7000.namprd10.prod.outlook.com (2603:10b6:806:316::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 01:40:59 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 01:40:59 +0000
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: qla4xxx: Replace all non-returning strlcpy with
 strscpy
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ilcru44h.fsf@ca-mkp.ca.oracle.com>
References: <20230516025355.2835898-1-azeemshaikh38@gmail.com>
Date:   Tue, 16 May 2023 21:40:56 -0400
In-Reply-To: <20230516025355.2835898-1-azeemshaikh38@gmail.com> (Azeem
        Shaikh's message of "Tue, 16 May 2023 02:53:55 +0000")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR02CA0146.namprd02.prod.outlook.com
 (2603:10b6:5:332::13) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA3PR10MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 4002abdc-c97a-43b5-3c73-08db5677c429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bk+8jIYVBKH8coo8MZowBDxNb901R8Ty6cyGl1M239kHZdAIYE/yT/rVDApBogMnIrbq4vzYEe8564VTzhiRVEDjcYyILqCiyMiQJnmjOSoR5fBY/jaZNyUg7ZnrKVK6UsldFvK6TVWPxBH/Lx1u9qZ20BmwdLijEDCp5pTZ4Uh4Jn5xoMk0xG+UGoo1GhVowzM2O8nrkhWDA5QPDzBbnb7v+drJbFJZv6296JGWxSHhwOUxh1/iGJW6pJJNoxIy0ZuGV5A+zOfYC3+2fTxkHFXGx9EThUUn608B044+XGkyy4chcERScpcn7EjZEjFTiPjAtbK9JNhDW66HKOMGgbCLx/y8I3SO0W+wTtgaozMnAhIlok4IZQO5zOF6bvBAn/z2JpNQzk8QUbT/cQLmlTIn5XG1FCKEnX8M1ANzUJNfUwsAOE+oAR70WRxJB1WIllj9iH+x75QOxkspbmgzbGBrRgq5iZD50NXet0DWtXrnyyQ0QBCY3f2+kD9gh6nXR9CM+UqWNynJX02ACxLb4RfEkAblybwWTNbEX3tjB98LsVnwp0GkNATpommQFJgnPt82csKGDAvvlYHnX5q+7kgsnQN055HCO8Vdsa55XmGN1NwL8TQdH7CilFj3s54q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199021)(86362001)(54906003)(478600001)(107886003)(186003)(6486002)(6506007)(26005)(6512007)(6666004)(38100700002)(41300700001)(66476007)(66946007)(4326008)(66556008)(6916009)(316002)(36916002)(5660300002)(8936002)(2906002)(8676002)(83380400001)(4744005)(32563001)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OSIaCtrMhttjSQQgostMqqUVUkQ8z0wb2xiRr4W048GP/VWxRH4xSGPt98P2?=
 =?us-ascii?Q?FKQgLGKp/k2BTccDQNshHVzptbTiU625DBwgLiyjo1u82zw2kzNwyxoM+CDR?=
 =?us-ascii?Q?LXI1a2//QOJ/Ey0D48/5qa83s5Q2D4oIrlDLeGJyThbUUO8F9PlEu2Kdda0s?=
 =?us-ascii?Q?n0i0vTc9trEfWM7OElMcEWo0Zirv7tgOAD1qKRRgj/U4e9PLdUoKCeTO2F1d?=
 =?us-ascii?Q?SVbMzWoM0SsqKuzOe7WrS3v70KHEXCCMYGZjeoKTwKl00nYN7IgDgesHWk2E?=
 =?us-ascii?Q?JD/92pwqo1OrIesCg2yOKUA0A0HM/xojDv4Z31DC/ltFW8Z7/KCsbOn+dWbW?=
 =?us-ascii?Q?iqaRUk61jx/qonsd8lBWDWKkBPaxA2Nxn5ZlSExCg6SylIj4QLrfAZUucVOq?=
 =?us-ascii?Q?f66gdaY4BraAEnAR1p8ThoZSE2fniH+YiBdy8w9Z16QnJ2pCE84QTzc7SulU?=
 =?us-ascii?Q?HbQ7yoD4seLHFa48R4ThYzS6DSa8cT1KJqFRq99anNFjUYGyLc/e2wVSPf2E?=
 =?us-ascii?Q?4XBi1Svg3ZaA8Txf94Ep9NEHq5wn5+N57SCdy3zPWGDP/dsHkJBH4wpeUNNr?=
 =?us-ascii?Q?iFmIuuYrZbgFNWygc2C7jaNnKyMb9J77yzAhcs7+FeIwZ61rM2SU9oQEQq/m?=
 =?us-ascii?Q?X5ujsaP/pqTqPnzL3kg15EJG277Ru6edWDTja76s+aqKbVUNE1UKx2wOqRdP?=
 =?us-ascii?Q?SJhVtHL2UJvnqv/sl8xBC2JRT6QKMv0NeBE9LkAOGEdR2gpdqHHcjAJLFUgo?=
 =?us-ascii?Q?u6J1XbMMbFoDocVaRv+bzwmqDgM++gjZSejW2SHA6cCAaA9cV33tWAIbnqcc?=
 =?us-ascii?Q?QyV8LSjOJig6SCFwjkbVybFkeocDDtExK8IowzicVECzU0/mjQYeLx1bOLpc?=
 =?us-ascii?Q?cgWKuwyYLAEEjJNbbFd1sS5rhL0hIvZEFXAB97BacpJIWTJU4xAEy2y1gKds?=
 =?us-ascii?Q?DGE+YwnjwvW9+qKpAk/dFeD4rnRHX23tQ525iQbFRQX9M7Ym5MDehApeqq9u?=
 =?us-ascii?Q?7P7Ahs+1FKfCgf9eHbtgz+jvHqFI94Da9o22UuM6+W06n84jj6ILfa+TCZga?=
 =?us-ascii?Q?ZUiv1g/bOEvDMnS1C+IXmovFPzopkdB/EZixIgaiutvHNrsbyEsLhxl6I35U?=
 =?us-ascii?Q?+EUeJzSVbfIN47k7G1ttvGsIbl/GFDQ1rHBlEKgEQfV/D++O1q3W7hGKZN8M?=
 =?us-ascii?Q?+omu+/6j8Bxyb/QzJS4e+OIbk8Ql08c03uRroyzFMdQWj4RlFC1+QbxqFgOs?=
 =?us-ascii?Q?JUQaBNokhptce5LXyur1TOguKnrgUoakGg+n2L5vaYYF9pVS/UceQbK2qqEI?=
 =?us-ascii?Q?y3UQFiEhHp9PRTnBkry2nm6QBtFFLw9+udgrtBx5GsXX4a0+Eyj8kivQLy/W?=
 =?us-ascii?Q?zOC1RpVmCgdJbGZBKxXjaNfppFY3UdYbIoepD2hWEkEsKhtpFuuVLy3mmQUs?=
 =?us-ascii?Q?gFhO8S0n9qC4Hr/09XR/v2N/Aae9vrgSvlwvNv79FOIRMbWRSPNVjmeuUiXw?=
 =?us-ascii?Q?xXoE/K1vFkLEpNwUsYcc5aQBSG3pCrUpqtbvkarmA5IIp4Tir9e1CRDl7NvK?=
 =?us-ascii?Q?GCAVoFfCCWNi3msKqh7bNpdfpI1PleUjzIf8jsOcWeJJGkQijM97I2pL+DV4?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: t5VZVaUa0TGzQUpu/9qt3z1ePi1+a9suMp62eUVN24QbNiBGdC0QtXA8uTS+jjfz5OmDntG6drbMteWAeiOJi1XZsyYZJVM21P7M9lUxNLbexucxIrSnWyZY1uBl7EbKDtIB9ymg20u2BxQwfNlgRaufSOXzbEwDtRhLQHf1Csp7jNp92BoITGgkpduUB67S6HXlJMre6lIqEOkUu7DKkqU0K4flcHfZ1528mqSfssbY6vMgCEC724Qcz+qvxsOpqcLGMVChcZLOJ+8CUudKq97xg652nucRKs6mTD4B0EmR/MCDz4gpcHPIkjI+OVM1R4JJ35qE+nEs21zvPb1qlHr9T2+ib9u8NEdGmtWICHE0SZxHe/D7/ZE+o74VhG84ZAf2CKhZ1tt6rA59Wr9ds4RO73SOUlyW2jfnnyqgXjX90ywr/mSPBQDl0VOkSHKCbaNx0k359HxSJQ0Hr76uQvJK1I1eSzKEG7PCk2yAfy1oHojDU8YjCsCMkPRZ8mg8S0EHD9KGzmlfznUE8yfnzHLwaxECMVq7nCX96D/KjWXQzWqjtqmYc9xGgXMYoO14yDsDbAez96ai7KKRpg6CRB71k9Opnt+ZCjrLWULJF17pCBUhIuZBVIuh9YVoTtqjXcBDGbyNk3JXh1pT/xr1oazG/PNdLN2+jZEPrmNTOdg377ZeyEw4o/rrjGmNgKRj7CWns4reKD/6HZ3F+LIStU6NxCoin3H/cztUoDPXv89edCRLhsHFQy2Eo/bkBL62/UD860ziJZxn+eb49Xwake6xrQMfS8F6prpnZo2KuihsSTLqTIjzxAqKJ4wodC59kBPTVkwasFsm0FQt1CuzE5969lqGl8UcwpQ8R/aBwKw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4002abdc-c97a-43b5-3c73-08db5677c429
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 01:40:59.7444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJ470QcOTA80+WEiDW10jiwtyqaDGfGpejlPeA8101Zew0LnvL5eQN5gxF2fxwTgKLIIH0J626ElyRGVSIUBltNfeFzvYRYV4NnWhR6rbOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=941 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170012
X-Proofpoint-ORIG-GUID: 8uETZqJGbstVh5_K4740kGK9eZHzhCQB
X-Proofpoint-GUID: 8uETZqJGbstVh5_K4740kGK9eZHzhCQB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Azeem,

> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead to
> linear read overflows if a source string is not NUL-terminated [1]. In
> an effort to remove strlcpy() completely [2], replace strlcpy() here
> with strscpy(). No return values were used, so direct replacement is
> safe.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
