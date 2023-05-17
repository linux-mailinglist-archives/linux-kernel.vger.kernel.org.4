Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C72705C86
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjEQBjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjEQBjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:39:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442D5BA;
        Tue, 16 May 2023 18:39:13 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GJxVTo010616;
        Wed, 17 May 2023 01:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=ALJP11wQvon0LkPgvP6sWKT/OKsZH6lN3UP0x38chzXcrfJQIWJ3esuMjJAKWls4mc4k
 3wWZQCGwsmXL/gkOXY4XMQp7wdySebhtc7SOGg5pOlGttzPQcdMbpALVsaD/SgpBhEVa
 KFf+LrsHzi2EUiXMDWAdrjP+IRmvqu8q/P0FHpW/6d2sxvOYqoR6cBKYRT66qjGohWHt
 b8LhPxEAUXmJi5L+zDyxAoDgjCC1EeF7lFmShKpQALB9Tfw7/o1wJpGrzCl4dWKqPp/a
 aBCED1vi3jAvddAKa48JsvVE2VinjCK28HuqnZ2ja2wG603Q2rmDn0nrDkOgFVNNFRVh KA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc4phk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 01:39:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GN2W44025051;
        Wed, 17 May 2023 01:39:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj104t98e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 01:39:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMRrsLUg9wEBUG+AYJa9I6SebH1YrXbwXxKTB1VZOovkxZs1ic5WSGvkweWIt96nZEp1SVXoz3fl1cSJh3T0Dgzk1c8WRReSDKU3uUz12xAWYLmxmi1vlByGlsFY25wh6sXY+yJhDeEY9ohZCHOvSK8HvpW0NOHA/Ezjy5bYwLmuStsJN6L9UyPkEM031azGOYFxMPVECXcEWppFpJIBkmyBYqgkgxgML51heChXou2BC9WTaaFt9hWsJiTRTWyV4zJR8ZiMSJsgmxrNIQF1s0DAXUz0VS0CwxPUwONsSZpk3xh5xAVyjGCAbNN2XUw06RTZ9pzFHCb0m+V4B+lk5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=XtfyP/yozHNeLkSU/w7HcgscTKObXrF32NfPMDR33WtuyyjwxMNVez6lyUIbvfxBWtmXDjXTD+oq5hYV7o4OhDJsGVzJJaFiA4Y9i8V0SgLO3f3z9+sa7/ca1ffUrz5PXL1xa8B4ZYiMorlLyR0JccOxPztZ76uRhyYxrnGo3VRl0YA54LxgvCho5E/1ZGuOHTf04jxgbrPFiw+Ic9TZsfABiSWrjn6PBgkz06daf/D8w1YfvPZNtKRAIXc0VxJ6U4sUBy8V3TtSkKs5Ddd9yebwBGguQRR8IhwMU69zUmfCSV58OMsvoDm6JzWfhB9/PtJgSzQWyVExwqmvbvylkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=Gpoh+52j9luQaf/nd7Cu2mW5/9c9o6iOYd9FuyLGzNmYPvMZCqcro0CLEImn+ASwA4PvLwd7P5uWPLpTV8sTOyfFP40xxcqWWiJSfL9f0zPRZqq4NQWfYEk+HUpQU8gg6F6RGavxqfc4rXQoJZZbSXCcstzpxlrkcUFlhiseypk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BLAPR10MB4867.namprd10.prod.outlook.com (2603:10b6:208:321::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 01:39:03 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 01:39:03 +0000
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        azeems@google.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: bfa: Replace all non-returning strlcpy with strscpy
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ttwbu47w.fsf@ca-mkp.ca.oracle.com>
References: <20230516013345.723623-1-azeemshaikh38@gmail.com>
Date:   Tue, 16 May 2023 21:38:56 -0400
In-Reply-To: <20230516013345.723623-1-azeemshaikh38@gmail.com> (Azeem Shaikh's
        message of "Tue, 16 May 2023 01:33:45 +0000")
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0002.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::8) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BLAPR10MB4867:EE_
X-MS-Office365-Filtering-Correlation-Id: feb9885b-dadf-4066-50c3-08db56777ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpJD9yEnSP7Lpb3yEf4BuKCn2gR8Z/CipMZTuKSmWGv7jta6tkTcFnj4cxhLWe4dlckZ5Ucjdq77g3w2gvTXUailWr+29EIcwTwKKd2cN9uif7QYKQi6j5oB7IdhO22wJoSdv0T3CqkzV+F+2i1rA0jaBpBdk6Lkt/qIIGGF4mOgZlFqWtrMPm4kUksU2CjwlfV9Pj3bp5AeQSiDP8o2cy/4VgPiRMbxOzODNVA78gszshKjaVLI1vqQonu2jGvtjJAdlo8AGbqoV/BUmMpW7LtBfepsa2Hfx4xaNVJ5lC10UkJmFtOaMRDheDAQRo9asoWKIdp+h/Jyjow+EKLjbRAG8BF296XDtZRuaLu8MRBZjkgt6Zwmcr4saJIof+QnHv3FFFnBCX6HWTYWT/VpzkZ9QtFKs+vDzPyhPXh/uRm9qBCd8QlJYqoVVfZoDdXW0K3iXKKz2cBfd5nApagf+YkCNZmSNz3fVnzZbjyfHXLB+AFbJyka1ZkzesB3HOiJmrkTfIv8GeeZNspEksqSTbDr3oywSf8SlAgSB1SjijXg3+Us4lFJfXeZwkqcmY4Bp7hCS9OpE6WRAt5d4yE7ZgMDEfLRDkH5uHcQqsxGZNk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199021)(54906003)(2906002)(4744005)(5660300002)(83380400001)(8676002)(8936002)(41300700001)(316002)(66476007)(66556008)(66946007)(478600001)(4326008)(6916009)(36916002)(6666004)(6486002)(26005)(6506007)(6512007)(86362001)(107886003)(186003)(38100700002)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WRdCtvtmdYhmVYuXND87250UlWJPI9Fs86KmSUK1POFJCj49BFmg1Hs4F7G/?=
 =?us-ascii?Q?XtKTWxcAdlzZ6Qlz0zsR6n1EhCwlXk2j9IqREggMoMwplKGmjSaJInJyUyPB?=
 =?us-ascii?Q?IdmAS7U0nIvnDktwmdmSUlWC3OiXsjw1qNGpFbqZVkdP7R+GAUQEb8Rd1383?=
 =?us-ascii?Q?Edub+xAu+PJrhA29nWQabA/9PTSxFUYlKlm+5+ew0nybgvsqTnfVTmLHEesu?=
 =?us-ascii?Q?jhT/r7jZr9n8/kwtdEDMdIszFFnOTWKoiudU4mZomjRHTSa00hYdLrO+79xS?=
 =?us-ascii?Q?c6HVHx2dorYaesP2WuvOWUyPQM8D0VMcMt6A1pc3uEiYdpeU+3zhS/DucddQ?=
 =?us-ascii?Q?5E4AtqzTwChWOVvgTegc0wCKibISYd8DGwSTxAgAHTseQiyA4FJ3+0T+3jUR?=
 =?us-ascii?Q?s8S/hbgrl+6hjMHJUREbHnWqFEXPpSQq2JHknFO7EhrXSqpK4FLNNUp8rMNk?=
 =?us-ascii?Q?RLnMB5UssZ5NPjcdwDD144ATdpimvojBbwuPmwkxZK3uQs+fPKGDPTI0E4KD?=
 =?us-ascii?Q?sV/190eI2tuUtkcWCLi3mjCKq/1PVnfcys812ZCgLlBhr/cbnRL8ZFgJcAdf?=
 =?us-ascii?Q?XzSanQGpR1hdfhzVuXrOsa/ym78CpEAuI20RXB8QNCn+6Ezu6snEKrdkjykQ?=
 =?us-ascii?Q?o8mWJy4FMPM81cPHwUrMPFpUq9BaWZcA0wEy0kEGAhNHdaVOwpmtYzwvb4Ed?=
 =?us-ascii?Q?4Auh71nnny80SPA/IetU2zJgkVwEqca8cN8bTfukxkpVk9N/Ct1/1Hst2C42?=
 =?us-ascii?Q?eZ1YZDqMmFGRIHG+jGf5Yoc6ucSjgR9UGRC5SKQ9IblIDlUfUnJGEJ4BKjDf?=
 =?us-ascii?Q?oLrc/m6A/Cje9lF2U66MmkjdwIw5hLtbxBSZ+sA2cnPEVS4URZZnKuz4bqED?=
 =?us-ascii?Q?JmWJV9zw+Af9piGYbHmECHK5eya0pPBY5Tt1SU+JJhsvxQ2eJpIUXpHx80oe?=
 =?us-ascii?Q?na9LrUATWftL4VBB4VYQcYxSKzHHPRNLHWF7X2puYOroW2azzF2QdXOneVTE?=
 =?us-ascii?Q?PsB7ybZ6fuTFPesMZ/N/bZChTTx319SEOelyUpfCbU4zzVZJc2YFjIKFNyzH?=
 =?us-ascii?Q?frOSnABNIhFQTz16Tn7C8ro1jCv5Mr2t7sc540vQH8ZYQup1gMsqEFD1Kpg8?=
 =?us-ascii?Q?4j/5KPWYMA4tCJMSxk945fQXv76dCBmyCwqmlBDIolcmRJcNgoOMiEksfa2I?=
 =?us-ascii?Q?FrWoJvhCcgCa2DusuQ1chBn+/o/lIzvL4528Cp24/WmYlkCIJryE+2j35kTS?=
 =?us-ascii?Q?7NCTXtFTXFWY7RN0a3QrYKixqLDPWuG8GaNBgZo24J6OH1dmxcChIzgV5IF+?=
 =?us-ascii?Q?WOwBZkj/tPBgQsUuZqScaxkq4wBb++1D7RUOboKy03wrWPTR7xFu4iSfn9KM?=
 =?us-ascii?Q?/GWCCcvFMqWBzvWooxscYkOhr/dthdoi1ZFKrZ86NPSkmya3yaA4/G73rtZj?=
 =?us-ascii?Q?G0hcEZg5kN1GiKTjXRHfBE41614WF5XstudQy1MbtPKZFC2bxz237scihaX9?=
 =?us-ascii?Q?PbBCc7VXe6FndozYMYct6gVCyIAkO4lgnWvt1ATQIckYkYY0FQjRXa0QLwLG?=
 =?us-ascii?Q?3VlpJ96WGSwVWscKh+28YrXGQXAN/+DbjCIFEaRdHwdgStAkWuMHTzT1Loo4?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PI7snEL8BU5IYpCSKhzw6bHJwKPK+0ZdWNzlTdBllMkAYQrXfoaeTh+DDO9VX0cutt1ks+h52jilbCqyBdj5OYZpASbX0/9kEQqV46wljBaFat9T5ZE1EI+MdXai1+rzCKCSpLqF4CZZWmggrPJfpGc13xLsFU/YVOtJ8PdPbKvYxS9O+2i9vhlTfsN8e2nRa8M2DK8KthDOnc9UhC+orHBL/1j0Wni5jy34KljSYFzf1DcJb03w/4Q/ef8kU+hWnPQ9FRk9f8dRp2owYJJs/f3H6CE3cYq4XKgaMgd5IOq0W1f6TNbzgLZox0NzY9n5wQ+/8AjK/F38IhickhVn40JdjEyWHnzwry82+tTuLQuuYEBi32WGLthlghkEfUPL4ISAcPbaydPv1wctBpYjbKOx/5lErdRlIpjnBIlyVp5gka6z4jFva3e6y+1KEwIawBOQUij5wl6iJolDnTw5G0cf2z+VnJAuvXy8ekv9822TTgKvXU8MsTpid9Vp5lAFEk0EGOz2ofP2vQZwjzX4/SozzZ2TKN7RYzrNdK6PwlayDVBZW1Reo7aEozj3AFqDj5F3nwBwKaFnQO4zidZL41g5RTMBqGxksFz9oEF9taRNXIfyhpfcAr99d58TaJSZ0Q0h8yrT4SaSuDYY7Q2t1lpsQbXz9wlmzutmVdSmSUrxFP0kD0GxD9O3TXc7MxVO6fhB2xuS+yrnO5HVS9XTslBIOHEPBjFHUi2hJxMA/+S44V1t38zoHDUnksSYeMqhxx7yYNHybQRMgTFIH9hOYnMmlQD1h52LqCstDS0cZ8vZ9M/nK8lr/h9/t5aRz3T6o74ZEnQiYEIgiFDvxDzpiz+OSkr7nb7pMr61gu90F15DSjLYdhWlmZ9emjRyWfM5
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb9885b-dadf-4066-50c3-08db56777ed6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 01:39:03.3398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBgjAukLoQDgh6Sz2c3NIoxffOj/ZR7VyQ8kqC6q/Tb39PhG4RAwcPKudXb/28fcIOCVb4prAL7vvJDqaUb2LWZ9uX/9tAzYzYTzdMXcrHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4867
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170012
X-Proofpoint-ORIG-GUID: 75rew0ZpDqQ4BV23f2yDHKsu4ECiC0FK
X-Proofpoint-GUID: 75rew0ZpDqQ4BV23f2yDHKsu4ECiC0FK
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
