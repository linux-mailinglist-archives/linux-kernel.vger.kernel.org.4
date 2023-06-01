Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32455718F5F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 02:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjFAAF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 20:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFAAFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 20:05:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D327124;
        Wed, 31 May 2023 17:05:53 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKBHjZ020019;
        Thu, 1 Jun 2023 00:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=PicAtmW4u+dJEJqA/kev6ZL7+Fb0dR/dPSjCjotRXco=;
 b=sCaAc/6nFUtOnJcvGoDgJeW6Ve+2G4EyQT5n9yoTxhqIQ7ZLf3HgXJjaVbJfxdikROKE
 EpnVYZlnb2hswQKyzmi7DLlP8sSBVGL23HlycDixc2ruMuDSztjNWoiYyqpTI+NP/O4k
 kRjnXz2JOHsEsz02ofO4ulMdkyHU/f+O3isWywOw9FYCp374wjyy9KkHfi7W1bgdWM4t
 D8nsM2uqhWhNr/BnD4Qup5rDiH3TUtrAs7Z3EE2lNo3nLs6E96hC+J2zffzuEzwxFARx
 iT2b/Zjd0Ey3LbV2oMLTr+5gnR7L9AOgz6H6LHgdfz1BaicUh7z2NJiMzQXtiOsFHIgi +A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjh7a3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 00:05:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VNZQnJ040959;
        Thu, 1 Jun 2023 00:05:42 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8qawrrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 00:05:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUSw2hpQuHuw14rduJ347RfoVwa4NINtcQd0mdrqTT7RIkl4DRikY6SQY5NC6DzFBWIii5aWFOUjb3XJ3IYI3qCY4HVvVOEjvz908u4dFcxhLRIzDz6kIQXxjn/Vy42bC7j5JzMKZtFTzxM+suqOawYJGSuYBkzoUcbUOAYq01JwlPDB/k0S/oJQiMim0GMOEQiPEop6RDw7QjCqwM0/qMdKnAt4XRokwJf4oVhk7kAjKd9w9YPeGqSQTPgCXH9RIuCGIYVFt2BYZ8NRC/kuGdXNPlJmiXoFLXwIRZwFXJkdwAUixIcO9Ta7RAEawPnTb1p+2elQgRoo4pRhPvc9SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PicAtmW4u+dJEJqA/kev6ZL7+Fb0dR/dPSjCjotRXco=;
 b=grhJ8JOJtcQxXwsjja8amkPs2RKKzxwzDbMHqCmW2l89t3SPsiSll0lreImpPhj/80cqJxvGP/bd2lNHWpZGD1bSaO7bRXEEsrs3f3zFm0/imG2wQMkFdidGMwzWb2zUbaSHirXAtoFZs15+GHIRFiu7cg3FrhVOz0DcofrYxDB864/D+EHioL4G1by7tmOTRSLWXzjzAiVMi0+tfInLNJtWuhsukdnR2GLuLrZDqVylS1xSLg/beb/MND1u+9XDS7WbpUrmCnaUdtVwXv+WvBuo+JY5rwsXGPnZipjq5Dheiuk2I5cfpcR93qeTnXQgyNUXd2vbFM4+BvtilGqqOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PicAtmW4u+dJEJqA/kev6ZL7+Fb0dR/dPSjCjotRXco=;
 b=vMeE9QJy5gtkLoRTtStO7xM4G2CnFI7ATiXwPVoRmLg2p/R6TSygadPsvcpU0Tp0BN0YqPrl0cVEjDT/53uqLChQk3CTRSwAb/DLs26gyLJPamor2gBmO7RzQsuRVAyciQ5cK7Eg3qU+uCzBDmx5T57F8uBQYnmBTHgk9DlttL4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY8PR10MB6490.namprd10.prod.outlook.com (2603:10b6:930:5e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 00:05:26 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 00:05:26 +0000
To:     Pranav Prasad <pranavpp@google.com>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changyuan Lyu <changyuanl@google.com>
Subject: Re: [PATCH v2] scsi: pm80xx: Add fatal error checks
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ilc8avyz.fsf@ca-mkp.ca.oracle.com>
References: <20230526235155.433243-1-pranavpp@google.com>
Date:   Wed, 31 May 2023 20:05:22 -0400
In-Reply-To: <20230526235155.433243-1-pranavpp@google.com> (Pranav Prasad's
        message of "Fri, 26 May 2023 23:51:55 +0000")
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:254::16) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CY8PR10MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: b082d3db-18d2-4d91-16c7-08db6233e6bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FyUx15IxLhHJHBjQwl0D7fOFWquKKzpJhx6WGrE0kNpWZKsBJVTCADDEITSgoaF/gul7GShYy9tJjcmtXPolRaVmxzSM2ehnhxLuug80D/S304HrVZatEZZdARvGtRLJTtKFIOZDthQJIZqBHf/RXdK+NAn2ShFsh338+KiBdZltP01s/9UG6PvmZcUwTocAEancynjziHszre7fqE5rvPqh3J0T2l9s0sRpawjMDFX7qmd5gL0s3zojehcxVxlWDBXxgGHQfwe++xo0dFsxvoFEbI80Pb8yi90gcd8tyEOv7zcVv/QsJ98xIvTJRRQ19ADxldOX29V9w5hWGSydSgCrQmfhXVZjye3EQvtFKLC0LJJ8+gPJgmmciFMSqcXXOIjzWr2jACjKm406ZWDfkbIgZdYAQoRmCP2CEqifWdo5j20EgFQtbQ1i1tdVjlwarsl6SmHjSOc15iEtnv8Tfkl5wWxoGvDRnfY5XGuf9YGMuEUX/m1zftO08vxgGhXL7n0nf8/pHEPDMllGnsj++42NZWbQD3nxRfUo9hTHh3ZaZXEH0itDsllSl36DUK+R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199021)(186003)(41300700001)(38100700002)(26005)(6486002)(6506007)(36916002)(6666004)(6512007)(478600001)(54906003)(66476007)(6916009)(66946007)(66556008)(316002)(2906002)(8936002)(5660300002)(8676002)(4326008)(86362001)(558084003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C5KdZkOHKIYX4dmZ0wy0w3DL1QKUBCo6azHme1xwbxE1vJ6On+Aispa30KcZ?=
 =?us-ascii?Q?x9D0o6Y8qjPNSFI4YH1VyH7XphdPCGxQDfGG4yC74c5cvNfIspcq3D3pEIMw?=
 =?us-ascii?Q?G34MVWoCe/WvqfAeM7RTh7H+pSLrO2F4T0ef8cA1VArs9ODz1d38SnRQATYm?=
 =?us-ascii?Q?cnLMmlqbKYtBTYnxpbGn6s9EgQgfMA4uFiPuB7GFzPzDfFWtXzO17ngD7fUZ?=
 =?us-ascii?Q?gtIJnuBMjcEZ0oGo8U2PRgmxiJ/RGTnbU3QGmSNisSF9yiYIjhnLPVMfXrvG?=
 =?us-ascii?Q?CxDENBEPAa5H8W3TXabhhCWuJvuUPs8lQQRpleYBCkkjRMis1HfwS6gxbhKm?=
 =?us-ascii?Q?rGYaAsOyDL5Cj+2XvNvuEQsaiZ6PZFSrC48opy9OLq64SZx70ykasNC5pZYa?=
 =?us-ascii?Q?Zpo33TF/E1noQRNFAENF4OtpS+wAANyGpPEXugdgA72OlXvZUTUTdA1fJWTQ?=
 =?us-ascii?Q?azE4+5bOn0TLydsdRciqKB/FhHIigT/h+Q/JlEbZtwItTS5x8pdn28lXEWti?=
 =?us-ascii?Q?V6vNRYEJ7z1e6eWmbHy/mwfsguU/iM6OPhoctUXCsg+C4letrqAEMY+yBFGL?=
 =?us-ascii?Q?BRbAl7KIE6X8U2nn0zIuIh5GwAIxKHlw1fVMF82rmDCeqLS55s5dQ3UHDrxG?=
 =?us-ascii?Q?szfD1drcIP0LK5vNKT9xBSePs7zwUDERk7OuvVidrt86XHeCevMTPre4Mns5?=
 =?us-ascii?Q?epyR/0/LIulApfQDk0KT2WjC8zT2sdPQ8tF6pBk1GkROe7xpLTgpC+nXIeil?=
 =?us-ascii?Q?73zVUqar7CUb5umq4UF4wIOP1zuAuIKtiOgjlKKVGK5Dl+pzoysa7M046YGy?=
 =?us-ascii?Q?W48lbuAw1QpiwIFgqtG2d6233uUqqc12+WNtg3tDH38htz2utfjvAfcIs4Ut?=
 =?us-ascii?Q?mypSUQ1fsvJR30Qx1KLz6Epn9wzjIGvyI3tQsfb1m2slL5uMT1hQzitrTNEe?=
 =?us-ascii?Q?oyn7xQCfoEEnWyguSXkQPZm5PhnhvINGNsm1gZHyxNgEs37YFSKjFbhtRCy0?=
 =?us-ascii?Q?Y26XJalo+SYLBWJL0WgOJXkvyHfZSd/uvqmD3dxata2t7HChtwCS3IxnIQaT?=
 =?us-ascii?Q?uvqHYerL+o3ie60/JCIGUgU5dLOJHpqhUoa4zzoLXQA91XXM9B02NCamxHCO?=
 =?us-ascii?Q?NCCYW3o+ZDI4qMWwBOAagS9EnkJx6wWtNinbOUjYdrF02ZK4ITYTItYuYRvj?=
 =?us-ascii?Q?mThCSuuHaDU5EgR0yJXJcbBYriFKfz8pFdK6CKZOslvcEg7bvBGqQJQojbZo?=
 =?us-ascii?Q?QV8C5gnaZbN0bwZhPWW0zCmHu9Ctt6N9cAjXu7BcqsVxHkfYKyiN4kjE51x4?=
 =?us-ascii?Q?XHJm9Ydw0/hrxS+zTvzbHXINmCLDWrjaVV1WDtulV0Zd3mwVTrlPFqm+X8fu?=
 =?us-ascii?Q?4YhCJUEOLo605Y0rsrzzdtZ701R0gK4YQ1Jn9SeNOkUopRvkYawxvuohZqaU?=
 =?us-ascii?Q?emT/v/ineWqj70bEKRyBw7xd/0Z3Q88sU+4np/rNbwPSPfFd6bG20oqXLdga?=
 =?us-ascii?Q?Ks3QmlV9Lvv5THikYLZwZL2oNDfy9CxJU5kVZRj/e/iLfZ8XXVm/ncRnkthu?=
 =?us-ascii?Q?pOo5+2BhmSzGXc8yH3x4kcOTt01lUAI+4w3etFYHj/zWWVm2pGxe2ArUpYrU?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tXBDlqqyxQ9Vv4Xt/sKQJux9ZxW5RUTjbwboDSflzPx/mWrebDasVmK/CorosrmlgmqIW4iMa26KDvfgiJnKUuHF4aRBXeW+16Do9tdXJxTIM2coAXMf7amiFWDcXK1JGLF9sP2suLjtv6c3UtHII3E/EeV3P1vpQvLtcYDyNWKYUBWQ8LWL3ujfire4ft8/iqIdnFQO+ilC2tgrrUu7nBfRkiZD5T0B8VdD3YF6g/LE5tHPzLqLoBxxHoY3QHGwgkaKQv33dC/CMCLhdRlpJGMY3p988zqIKyXjWNIbK5w62xazkiZ2OPphNrorJpx9LgMM2ZFuj18xvr05TGV/X/jAcYbh2sWICHkMO/LuBxBhzAhfOkEc1CIRQCf58hnYwhrKTAvHdPDRk1e4yMFiXFQtOjna570GhMHu39KbYlkEkj4blfU/GAwtDFZuiaJt9YawPOgU5ePYFZ4qflV2BmPwpct8ftJUtGQgWgX29B2AuJburSSlx6DU2BCF+2M+fWhkJ1dy5F/LRBKXPgz+E2xXcNzPVm/Y6NUDfghf+2ct/8Sb8z3jdOj5HNJQcJ8tHRMxa75rmjL8xraXTy8huQZrfaOjOD0j/vGYJ83pV7R1+QrT7oeWoEo+3Fdl9txsmmqt4Z9gg0Fyvs8A+ArLjAZimrHa3KhdPfnXIK1tWdaNFWLgyh5JGLmH61hIbs0i3KI5QnMRQhuNihhc5/JBzO6TMlpfXuTVXM7i+KedUu6eDTT7D76g13zG1j8hvqRcIA2qZn62hvf63tSALMb61xfNySB63NSDgtQUaOMuDnBDjlF3/7uTMMHblLuO6g8YHiPhBsitqYHMKp7N8FW8HEuB/tF9PnDy4AJBOe3N9q4Smm7OMgZC/+p7ajc2lfUm
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b082d3db-18d2-4d91-16c7-08db6233e6bd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 00:05:25.9007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlyMNVXsadm38aW6eAI2x8ssx1rSgRm3ROWZ1AndUA+nO89sUoCFvGODqtvrRNoGj9zKbukxWTRHUBmZo39qpcv7c6u2OIORdfbWWj8tp8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6490
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=753
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310203
X-Proofpoint-GUID: LLCyR-KLBhrbm0xRs5DrzvdMBHvLXXKf
X-Proofpoint-ORIG-GUID: LLCyR-KLBhrbm0xRs5DrzvdMBHvLXXKf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Pranav,

> This patch adds a fatal error check for the pm8001_phy_control() and
> pm8001_lu_reset() functions.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
