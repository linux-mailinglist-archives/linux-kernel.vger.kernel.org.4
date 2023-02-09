Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FC468FD19
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjBIC1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjBIC1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:27:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD924FF38;
        Wed,  8 Feb 2023 18:26:53 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3192IlZn029676;
        Thu, 9 Feb 2023 02:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=nPKRi2ynrnfJkUToaJGPKhJl4fGo1TvMRpQOYBu+rFY=;
 b=21rhWO6sf1JICmSM7spxT48CQP3vkYadl3wQPeNq9i3NN+k2bJtG38DLquMbv9FWc6ll
 auiMX8lfDNfKUG9J9KB0/rTAGqY+a2hbwXJPv+RaAsTph44oa+Rg8tTOkBNGWWUvY4Vq
 SjhN4Hk+bFzpYT3eZmS8UlkvSyVKUuu6C+PHuhVVKqTwDMXldzOFWzuVmfw3hSAb1f0z
 1zksdICqdu4jeutzvQuVExEfxYPKo7mkmUdwVzxZHv8tJhN7GfOs6NnIYjG4tjyUu4Yy
 lpe1nEuzinS+Y3WZNkIg6DXTi+kZbv8M4WfM/tmbxGD+jewJ5o4fKeQmO2EqIcBdj4Hm Lg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdsdsqj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Feb 2023 02:26:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3191PJC3021288;
        Thu, 9 Feb 2023 02:26:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdt83gmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Feb 2023 02:26:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5sE2+F9/ZIUFJf52Vd0a+uCu0aBzyKrVagw3jwShiK/7O+OoXw+hhLJ5m/p0h6oYPFpEinr1u/aVbw9jljolJTW1P+79gKoQLjMlkZVf6hRcbO0UOyAJittPqUR1BdRzMZ1nOehhw+fXVd5GcjFIO/NaUa/C64sx0NFWFxMj7bno6Ggq209jAIFW5+pmq2UdGsk385KCaLaUCIG4j8QJwb/2DB3iTPnNFcMzotxGQH62H0EhVffSRBeN0kMmXSFlnKHbrQYOOWiVa6TBSWIEe2mt/hGU4YuiYnmDZEFaL8djhpKgXaJnWAjThhvxlN6fgbkGApiz91ViwLVxiSa2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPKRi2ynrnfJkUToaJGPKhJl4fGo1TvMRpQOYBu+rFY=;
 b=SlQIHTQxuaI/ATPLSkG2Pp3PScM7eiO2G8b+vw9ZuQrcmzZbpj0GV0UL1jre8fc0YKdYmuhBDVNmUFpZN5SEqmMoTLAMSTyqRXOwD+PMyKsVCTqr4b0VK2oafQFa7yXo8fD2C3nRplZCPL3/3W+ksKAwDxxxzp8UIbTPyuDAdcFXjf/cW2dsniPOlTNh6F8ZaEYJKg47avUSQQgHXro9huLBM88ApYI6iqu72CKlXC6x3JIiLY+tYixIDUusnk1YUYBu4h8+7vJjfWJQHmdhC9vG/NTnMEEwrMo9Kpmw1+FW+ocsMQ89MAoDfiqeR1OfeTNOflN4siEi05KS9LjPPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPKRi2ynrnfJkUToaJGPKhJl4fGo1TvMRpQOYBu+rFY=;
 b=d8hNmG8s1V0UL312vzL6z5gak6UU3synYO4DulBYOZT44ZD2Fy2FKTc/o9ULwY0YYsWz2QrUyMLQylAzddYL0F7UdNeED8CthpAjVcTFhUGHrC0ORMJYuFKP0Boa5ZOvFfcGFFW2NAy2DmQ2grXAW5IzPUL+o3FW3Esce/JQ9Yk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW4PR10MB6323.namprd10.prod.outlook.com (2603:10b6:303:1e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 02:26:43 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%4]) with mapi id 15.20.6086.018; Thu, 9 Feb 2023
 02:26:43 +0000
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Bean Huo <beanhuo@micron.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: core: Fix an error handling path in
 ufshcd_read_desc_param()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v8kbwp48.fsf@ca-mkp.ca.oracle.com>
References: <2c6e42205e5ec22e5e8c7c85c6deb8fde31c74da.1673781835.git.christophe.jaillet@wanadoo.fr>
Date:   Wed, 08 Feb 2023 21:26:39 -0500
In-Reply-To: <2c6e42205e5ec22e5e8c7c85c6deb8fde31c74da.1673781835.git.christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Sun, 15 Jan 2023 12:24:17 +0100")
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0011.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::24) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW4PR10MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 15401b6f-7aed-435b-1206-08db0a45154f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYFdxGSDxA78EIXAxEyuGwP5fgvdkcCtMbyvgXuZA/KHUxcicMNMz47Th/iNZvfILyRifz4WWUwYj8ZAZzHgq1xPBsIab4I2Srj4HUv6G467iadELPsSoWADrrA3fofSZfAbzIIP4hhi4FCRHmH8gpGlwizOjQoeuqmenp2lGqkwnMq2tY7N8aCzUsCuha/XOiXNwn5J2AXnfBzIOJBj7UGz3N7JXwpHmvGtthXK8s0VlrO5ardHbRPxRRr4bhdwKInVkUsY+NORBQ2grh41KgDzXQ6NlwQSwdfP2Lq3kDtiUi9t0dHjWsHZKLoOvreofGaOrgKORC9KQOsxwIYk1KJ3uB9R0RPrkRIhyat2hLAgULDJmk/Yl3LYejAhk3F8N1lXUwmxF9mrk9qIqrVoKrkAE4T4MFNLzZUl9hma1CXDOiNHltjolX904TOd5uwpCLIAXf91DBed9nK1rCjirsaCMT+q+8LIvk4UPkQiKnV9E822D3MEgUHwyklyCg70jYI29yPVDjrV1KgnLTMZyp6r1+Y1i/FJKt5ilPinpua2jBoIK0ttbuzuTVYkveiYiz8Hk4EUu2n/bR6Un32llLznk8qk5UcobRx3CA4yE36Phyqz8jyQo2mE+EBA6bZZhyT0gQYEEDnTrV0pd8eyXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199018)(41300700001)(66556008)(66946007)(4326008)(6916009)(8676002)(66476007)(2906002)(558084003)(86362001)(38100700002)(7416002)(5660300002)(8936002)(36916002)(6486002)(26005)(6512007)(186003)(478600001)(6666004)(6506007)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4N6s78t8vJWhQyoUQNWz4a0gcqgxHrcRVrTBxhzYOS7S57WSAc65AhnpN5oT?=
 =?us-ascii?Q?GAB8lOuSTG5QGbV9laaP1Gxz8vGawgNeeEbP2Xy6HHzz7CpzoLC7/7kuBqhL?=
 =?us-ascii?Q?4U7DBvR+K5YaJ4uGxd4kxWYirEwGewmfTQ66JXPVtDYhMClZ0zNg7pzPqooI?=
 =?us-ascii?Q?EBVGqRSQrCILTpht995hviROzKLxDVBTLLKJbFLTvSq3e3hNfSmQmweGEQBM?=
 =?us-ascii?Q?afXMa6PkfD/ve+p7G4RFx+PRZ94leqKSdl29OP3F1afJEPFewm8SgxdyVznD?=
 =?us-ascii?Q?XRQyuUpw/Ix014ImSDJvhGXpq+dbdNNAyEJt9Ypn3NuCX8cMASqqtAM8Ry4D?=
 =?us-ascii?Q?VGt0FERDToMOySltSnDYM4T2VteH/2C1R2GsIURfP/IkKewhIozgVvrw2aqi?=
 =?us-ascii?Q?2OO9bt63VIf3xR5O8yi4qDIYUn9d1hSamMVXND5GvV7C46GjMcrIAwmq+PRJ?=
 =?us-ascii?Q?6Z7HOHoEJhUsFrTx4OtWU/bqfKBE0V3/WHKWO8lWk6wKKWLYSBSsgpyLgVwa?=
 =?us-ascii?Q?l+mPHEO9zgkFtmYc0veVnvSYkO3Y1fe9EevkI9M9LxgYQ4bQ2LEM+rcHaGXp?=
 =?us-ascii?Q?+TRglube5Ho5DSFvD1cG9XUIvDa0js0IilEXiKfM/KRxyx3ySZYPDIIAM93e?=
 =?us-ascii?Q?pZXIyH1qz6I5Kx3MH58nuS1WOinVu/u7fY6SFMhMpmiZAYNIUZYoPFlfKn9s?=
 =?us-ascii?Q?iZRQInDPSWrDQjiy9CR3RjUUbVFLZLnkLSsC+888MYUMf9MBb5YrDOLQ8lkC?=
 =?us-ascii?Q?eYkcDAMsIgr5vtxZf8yOT5v+kxLNRe2P509MYDlkIczwyDPxTvj8jMxwumsr?=
 =?us-ascii?Q?WhpbSku7wQuXjsDuOMVf0KHzFu/MJ3mRpqgC0qJ6eMcOnmBgeFdqm8RisHFe?=
 =?us-ascii?Q?OZfk906Y3enRrCgtKiXhHIJKdYFPitH+uVZTAVzRjfeYjaCVNb6squ11vMf9?=
 =?us-ascii?Q?O3HPxP3haUIG7XNMGpta7pfNTH4HqqKj+AGlpB1CRbStj+TrIdeBumD7f4iq?=
 =?us-ascii?Q?u1ZtD7mHqnoqcPXVQ0oKnYT83ppQm9+ejIPmLtqtJpSEnKw86zNu5JJVxxv6?=
 =?us-ascii?Q?+2pd4CKWo2YfyG8GLUiJru8cwcNclpKwzefcCwbX1KBJp2Re3TAob2ub2Oti?=
 =?us-ascii?Q?/E7kxdFqTHFVky/SFSYqLwM/AfzZkGaeONeZSkPsBOed6Hgj4I8xqFUY/F7d?=
 =?us-ascii?Q?rCJCnHphiMTwOY4NiWxRJ1kw0+uHImQ7d4FkFQL9dQEEqYAPXcdT+QPmsttx?=
 =?us-ascii?Q?pbjt7JY1h+aJm+nAMvojvLGUDEYU8Fv5MYIl/s3T6ytWOP71hqLAzrMab/KM?=
 =?us-ascii?Q?zQuvcJDnZeUT5fF72T5FaJZRdR5beDYyvMxbux1KCmMifyKT+i1wcIU/2giM?=
 =?us-ascii?Q?CIwb/rVDnK4teWDN0m6P5L2yk2MsCtnOX0IzJPRAVdd7aNhyOrnUimM+fybv?=
 =?us-ascii?Q?8VQOLB21r/z2ogu2VK9uju4Ko59W6v3bfuakHSbCP4UkTM9zxF8oQdP47uYZ?=
 =?us-ascii?Q?omNmijwMOu8F6xvS8vNd8/W5e5j9OiT3H6bNnGGhR6Vq6QcRLSj8kuRBHLyh?=
 =?us-ascii?Q?JM7fauh28Flz6I/Od1wlsfk2Qvpz89lsjjKn4/GKFsM5up6Z+ywk1WBgyTDy?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?an0TcYvogUnnG8qLlViyj5cBKFXyHWetHUB73uHxkkt2NA95aTuDyblFmPmb?=
 =?us-ascii?Q?OGbmhBIgMqobWoeIaBmc/lPbQ01iNc5S6E9nFXzxuH5c4GiC64gL+eHC3csP?=
 =?us-ascii?Q?e2k5IcKSr66W76TnY7RqDCEw1NnX225D7IFbSycM447wX+MXh6WQEvGLbLIv?=
 =?us-ascii?Q?nErlpF0OV/NkjnDHD88VYBTeCwPZYuuNNk8hjroiwLQ+F8xsxz2jyrfExJPw?=
 =?us-ascii?Q?um+F8IJiM+sm+wt4i1qg7LfKwzl4Q6HKzJmGSjjWjm4mvXY0siE1px2dbgj7?=
 =?us-ascii?Q?e2Su682qcQiAKMzWpLB5xrALCz72WQ2OuDSELAzfSPdvxUm7cmbiZdpGknzD?=
 =?us-ascii?Q?+tzU2DDatYWyOyb0mX45XQnpNH4hnXTvh3JchmUSsAMsK4sOUL4YPuqW0Kr9?=
 =?us-ascii?Q?l0fjH452m6V0BW69j8moVUF96yxwysf7iFZtNDDzN/9wR/f/UpZHZvyprJhs?=
 =?us-ascii?Q?dIy5M6A98B4LkLkUZQQaxhmgSE50C5DqQMavoFJjZgk9sN74vK6153tba+sL?=
 =?us-ascii?Q?gXsk8QAGrh4tiJ3wvc3mHJkgRqsG9rXDxgAHQEAah5KTEIK7gEfjSD4UiUKy?=
 =?us-ascii?Q?6blWnNtVf8+1gb/Fmk96SxIkyVMIZbmkhtUEO42wJ+bC3pDHrL5u3oWMRp6u?=
 =?us-ascii?Q?2ifEoQmtwvBzUstozn5kF7a03JOjKFBQmZoZhDsgfabucF1R3mnzgJpDFNZU?=
 =?us-ascii?Q?u8nXQBq+uAEDBgRW96wlqPlm535MMlG+HNQOlCiZs6GhH5W3bo1XfvEEdB8a?=
 =?us-ascii?Q?P7pEW9d0LL28ycVDv6OMA8Ns6alQ1okIEHqyjHGBMmmHiE7OXJ/1g8FM0GZZ?=
 =?us-ascii?Q?eXIjCVMTc8Mf/MW+QX+Nhsgd+eImK9XmqqPbWfttEP946xdAItz8UVvw2uA7?=
 =?us-ascii?Q?ty5ytuKfzqtUTvqNVrXBT9YvxMoOFkAWEvjhPNmRG/D2rPTWlphgADjDXVhg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15401b6f-7aed-435b-1206-08db0a45154f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 02:26:43.1468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuJHaVeEoaQlSMbYvpgWZT5b/iVqMk/JVHo/ze41/BCRiMGqlwqOT71uiGxifXfBIsaAYlHW03lIzi7foY8Xnsz85oLpRZsxF3X2JVj8H08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6323
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_11,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=837 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090020
X-Proofpoint-ORIG-GUID: 6_pDB250rHs6XnQSM8oZZZ7P-Npi65OA
X-Proofpoint-GUID: 6_pDB250rHs6XnQSM8oZZZ7P-Npi65OA
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

> If an error occurs, some memory may need to be freed, as in the other
> error handling paths.

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
