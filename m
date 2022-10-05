Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB525F5105
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 10:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJEIjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 04:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJEIjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 04:39:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532E2EB3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 01:39:37 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2956hnrE005020;
        Wed, 5 Oct 2022 08:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type : date :
 message-id : cc : subject : from : to : references : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=QpW15ujCVVHD1qAPu/YlQa4Xid3oa9508X40+pfhb3M=;
 b=0KoipfiNz0vHKAlz/Ajq9G+J5Lb5/XqGtHn1+iQiAY00VklvCHCrKVoyxUJXWmfdETnW
 vA6mGIatAiYAbT/Ou1jhWXZW3F5P+hlyu4c2kM8BMuCEiv/InOtWO5/CSPPt9tpxrGyk
 n2BXJ/x0eAvtPjB/SbAzjsJ+3qibpU7uRq8YenWHxAxjI/WtnJ1mAHa2FF50MtvugoWd
 Ry+YSEqyCvrzNMmTRzetTMaz66NBIxPexRpdMTZfVoWJE6lE3o3yKLRgzg2OhxF/6lsN
 6y+OmvUcWRiejoEArV5MZRd+X6i4ubebgWvdcPWJlub2RJWI8xGAwlZVepp1J3RKgFgk 2A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxe3trtgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Oct 2022 08:39:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2957Gopf019845;
        Wed, 5 Oct 2022 08:39:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc0b7n2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Oct 2022 08:39:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfYoryHsgmCI55WMvwQOKCgPQ2nWtIewFkgjh77n+h5Aun2P7NJsFTQ/yT63gmArCkgL3Wu2V904p5wgeqQZPnCsJ1CfGBt39tr2NPlzq8DPe3F9N3vmSzw81QTf1A0uJP+mNj9FfhU056EXEOh5VMoQEh0SAtMqcvjWhDo1AB1H/y7+JLkh0cSTghkKsWtv96/bxRsqqauWBJFAZTo2kzIdproojkYbskhOo6vegdgxE521L/fET9v2PP8jBiH8cRsONT1j8lcvVGISKdtZ2D/g3VOLH1qOwgBXtm1+4Jl4KUj0xyMMbhCxuJPygELNghd+2PJmKA6mTcS6kxuWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpW15ujCVVHD1qAPu/YlQa4Xid3oa9508X40+pfhb3M=;
 b=DX/43L+VJQW0Cqdefb1VX7qr/pP7J85fDXSVhB4vJ4Dfbn3xMZmL659O2G8l69BmEp2BFB7LchqBZrgTRe9O+gS3ZGJg+D8tDeKSeqdVPJ+zq1bcpz4PEZ55WklWx7hTvg87UbyVdZ2/gHr9xzWOr31rNpGnw0XlHuyMQt6YxqT2so4s7hE66ANmbLm7VENSJoEPRxrsPUQ9pKOLExAgT85jro+LeeNjXYJUUQrs5zVWY0bspTYCEuIiEmEIF0aSyMe1HLHA9k0k+9JonRo6PojOmXBZVksWEwtz9RNXxUsZU1T+OMx6STZFYUjJJj/INYy60BeLv31mecNgtP2lYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpW15ujCVVHD1qAPu/YlQa4Xid3oa9508X40+pfhb3M=;
 b=Nr2v2ZN/gfGag4A1RcDU26IDSYfo5ef5KZWtCSXuD5O/xTB03JeSfMgfziHBNrKEo9gPh+JwhXF8tqRwfGr9OYj/6eap01M+Qe/o6kVVU6AwPDs+jqhNiRHc0/29Mmriy8gGycb8atNSk3efJ0Ftc1pq3wBfVx1mKQDS1JLL+QU=
Received: from DM5PR1001MB2153.namprd10.prod.outlook.com (2603:10b6:4:2c::27)
 by CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 08:39:03 +0000
Received: from DM5PR1001MB2153.namprd10.prod.outlook.com
 ([fe80::f9a6:b676:811f:b1ad]) by DM5PR1001MB2153.namprd10.prod.outlook.com
 ([fe80::f9a6:b676:811f:b1ad%4]) with mapi id 15.20.5676.031; Wed, 5 Oct 2022
 08:39:03 +0000
Content-Type: multipart/signed;
 boundary=e38e8ba36671be4adfb48d8c065096aa4842e725837190220e18958090e3;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date:   Wed, 05 Oct 2022 10:38:59 +0200
Message-Id: <CNDUR9ATG2H2.2VY6HU95S91C5@orcldev>
Cc:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH] x86/alternative: Consistently patch SMP locks in
 vmlinux and modules
From:   "Julian Pidancet" <julian.pidancet@oracle.com>
To:     "Julian Pidancet" <julian.pidancet@oracle.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>
X-Mailer: aerc 0.12.0-76-g1c2dd4c9f15d-dirty
References: <ed7a508717bb8bec6273c2740418f0dc2df9eeba.1661943721.git.julian.pidancet@oracle.com>
In-Reply-To: <ed7a508717bb8bec6273c2740418f0dc2df9eeba.1661943721.git.julian.pidancet@oracle.com>
X-ClientProxiedBy: LO2P123CA0097.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::12) To DM5PR1001MB2153.namprd10.prod.outlook.com
 (2603:10b6:4:2c::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2153:EE_|CH2PR10MB4150:EE_
X-MS-Office365-Filtering-Correlation-Id: 5190b728-1fdb-4e6a-a749-08daa6ad0eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q5+htzWTZ7TQiN/Tkok/hNHUjT0+Sy3oSbfH8BZHC1wN2SXi3cYcd3MnBtc2LbLNjo239hyvD8r9ROXDOaf94F8E+5x6hhGshcNHP3Ab2jCAXI+qrO1qQVW6P260gCcueP1+YWR1MmRoLzRb8yJvURdKKrZ4H3LJI/6DgTsXVvOCQ5Ck4BIbjSyDf1hcmeiveqWEfk58zW82qnnN9kzMz22ste/dagdnzdcebbRYOoIFkXYm41N8YvfPtr3GLjc91QWUtUDZKYiK4SFybGGC0bTA48rEJWhFQZScS+ZzZ3lsc6h9794D+3H8Y0XpTwe4r5Nkn7P610DdkjGii+k8smQs2OuwrX/Uld2F615YO4ckqTjSqaLH0oq0M7hMi+KNbM31Be3xFSshPF+xi9vieLh9oXRupRdqFqPuc9Mh4KpLMvWN8XnKQQLMBFo7TeR2V3D44mkWO9HDYPLcdO2h30/T3ft6T7vZXRFfV028Bz/UHamakoTJDVPy94joyfZq6D9HvugG3c1QMxpQsn4jLG/qmB7AHELsxJY+9B69fOlH0NZc79kbBpQ+uZo6/OW5nSkZyXP2zRMV8SeUthBn1ck4PhK/VPTXcn2NRgEBMZTN8b8Ulkq5jXYijx8euF7BcnM0PkuN8gAAPIk+qM04GSN5u4AmivOMFqzYabJBvLyDBnTF05yeTtld+fga0SFyOZJXDbemEW97gky3qB195YEfbWLT7lflwaObM2vEEr8E69PM9f4ZMFrddAHbXW7X1PA/o5gT79aU/pux64RvdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2153.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199015)(33716001)(21480400003)(186003)(83380400001)(38100700002)(66946007)(66476007)(66556008)(4326008)(8676002)(316002)(54906003)(2906002)(41300700001)(5660300002)(8936002)(110136005)(33964004)(6666004)(6506007)(9686003)(6512007)(966005)(6486002)(478600001)(33656002)(86362001)(66899015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2Fjd3drVFhtN05nRHdSK0RyYW9ES3NFUTJ1bGZLdFRwVDBnbisrV29INVVt?=
 =?utf-8?B?YlhIenJ5eGVmMFZmajB4c3A2eGlwTVdZeGp6SWpLZzdsNmZaR2dRbEJMSmdS?=
 =?utf-8?B?L0xJVEZibC8wOTdkT2NGdC9qSjY0bkY0T08ydzlBTTArWVdxeXJ6RVFPbEE5?=
 =?utf-8?B?ZzVuMmp1a0VYODBDNUZoSXRaajFxMUw0NmlHaXQ5bVRnU1c4L2N4amVac2pT?=
 =?utf-8?B?dHhEMWF2ZzZIWHhReDVYNmtIYzRYZFhPdXNzUVlmcUZPczhPdXo4WGZubDY0?=
 =?utf-8?B?N0NwbTdqZElnWk9kY2pqNGRieWlBMjg2OTNOSEkxLzNvR1REM3YvbE5KRzdq?=
 =?utf-8?B?YTF5Mm1DRUZTeUdwZjBHT2RTR1dOdHNVS29icEo0QmIvSm1RQTFBWGFtZ3o5?=
 =?utf-8?B?R1JmYjdZZlp6c0pKVVNiYmtLU3RTbkN2dFd4SzRIUjFvYmVObXdLNHE2RTZ5?=
 =?utf-8?B?eWVTUnlmeWgrMkFiZlhzRTRPOVB6TWJOMThLbno5NVJHcmN5d21yVlZIQ1d0?=
 =?utf-8?B?RXQvbHNhVWIyUkY1TTZ0L3Y0ZHphWVIzVXJ2a3NRR24xMyt3Y0pzLzhsNkU1?=
 =?utf-8?B?YlVwZS9CT0tWWTYwb0JxdHJnK3JySGlYSjBJd2IxV0FOTUcwa1ZuMkVCODlM?=
 =?utf-8?B?eG1zZ1lmMEpxcTNWYWN5WnNXSGMvbjVTYVB6d2VVZTltV0dYdm54aHFOVG02?=
 =?utf-8?B?YmNSTmpUaUUwOWN0aHdJVGtVR3hzdkJOOTEvSFltU29MTCtIWlZ0ME44citN?=
 =?utf-8?B?aHNVQkxMd2ludXhVejd3ZC9nUDJ5Z2NKUXRnWEM1VHdxd2dBSi94dElCUlo5?=
 =?utf-8?B?b09aRGNMT3FPRjNBekt0YjlVOVBHRlJRWUFiN2N3V1U4WHNqZHRHRjlyQjNY?=
 =?utf-8?B?MjNleVZkNm42RmtuL1IrN1lBdENzRXE5aHpDTE55SWExQXpSSk9aMG82WVZR?=
 =?utf-8?B?dkNacVRoa2t6OFo5b3Joa2labTYwUnJtbTBBK2dSMjlqMjM1NDlqRWZGbHNt?=
 =?utf-8?B?VUkrSUNvR3J6ZFdqbDlBbzlneFlwekFaZzBmVElRSi9nVEtBY3htSXJHQ2Nn?=
 =?utf-8?B?VU03VGtDa3A0bTQrUEZGWnQ2eWxvdHhOSTNWazY2ZTEyRVZSRHRaMjM4K0ZY?=
 =?utf-8?B?STg0WS83T3lBZG02MVl3UlFHZzZRWXZZZG1MdkFQNFN3a2ZGaXcrc2wvNUZq?=
 =?utf-8?B?bjBIVlU2YTNuQUE5dnIxMUlWSmZmYll3eFhyVmdmMVVzQjh1VnRPN1NIckNZ?=
 =?utf-8?B?bG5Hc1EwOFNnQWJPaFY1MTR1QmdJRG9mWVhwaEE3YXBkTzlSUit2VzFTTndY?=
 =?utf-8?B?Q05wT21OanRFQnpZbThpRUZxa1JXb2hFdm0yZysxaUFWNmZHRExJNy9rNURU?=
 =?utf-8?B?bVVyU1p0c21CaTFxOE44VlQ5dUIvdW1NVEJsbVRvVHRhZVVaa0haaW9FKzdJ?=
 =?utf-8?B?TUVqdzhKVnRMSkhYdzJNb0RxcGJnY0ZMU3RsZHZqYk1zcHpsc1dkanpFaThq?=
 =?utf-8?B?cWlCN1ZubEZGbG44ZktnMCtQTmtkTzBGZTJST0wvV2huYmdPYWlaTHd1YWYz?=
 =?utf-8?B?ckFoTkkzeWYxRElNSTYvZjdHbmVXb0ZvU0ZLZVR5RTVya0Ntd0dacEplMHdv?=
 =?utf-8?B?dlV0S3dIbWtlVlltNndYK3N1V2lKbUY0bDBlVjQxUnhSaldQeDRIRysyZzFU?=
 =?utf-8?B?SGdORXhOSlNyeit3LzdWRXhGc1kydGt2WUxIZ1RvNEdMRzJTS05xaEd5RFM4?=
 =?utf-8?B?Tk04SmQ3TU1Tc0ErN2l4S3d4clJwWDF5N3A1QkpaMTlNMTc0ZUk3QnU2QzMy?=
 =?utf-8?B?MHdTKzdUVjdQRUlqUWJhL1JtNDVyVzVOWm4xb3YyZWhBNlFnazgxb2IrTWRQ?=
 =?utf-8?B?RkRZZTlYRHlxSDJVUHBxd1M0WnpuNEYxOG5HQnlxU2Yxc1hoTE1xblpPVk5x?=
 =?utf-8?B?S3VhSnZUaHFvZGJHUDl6cFRLbG96MlRGOVhtMFdVSW9qaGs3V1BLTnptV1RJ?=
 =?utf-8?B?M1NLalNJUmlUM0s3UzM1UCs2SGpubENZdjVNZ0ZNOTN6UzBYZDdZdlcwOS84?=
 =?utf-8?B?b3NMY0RSdFRiQlBtMW9vSHhUZnU2b3hRN0hCc20vQUowV2NqRGpQQ01MaWs5?=
 =?utf-8?B?aWtwZm9Sd0lCdHozYy9LbnFGUktOTldXc1Vxc0x5TUh2TDV3N3NFNnFzTEFM?=
 =?utf-8?Q?e1UBruFSchIEeSaNyAp1qLo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +/tWhYpKb79+xaWs7x/zxsfwAoli8jvuy8f1zb8BGhxYOBt3e45MZT8zLp2KC4nZD988OOhJp+BmAJYJFsAp1G7yEC8yrJDAH+3tELWl4IurFMAFduo6v/K3WWI64dDqO4ijiLEjv97gdkdca3R5jzbUfnty9Tn4pa/BvXFmIoxbnIidpzoVKFpb8lZYKivfz3htyfs7cOsKEpMgN299uJQB16ae6OMDZqIQVXmP5dJRO2hJo2iLpRK7LvXAnSaZ6/kGCeNkHNmx1afm9scjEoc9PJNqhCbLw2txG/XQqF6VgfBOosZF8x5cdNEzt0yml7bPQUrb3KEJBThSSdmXjuDa7ZNhsvIn7CTON2RB6HtdiCHEMRs9tUJ26ELDAtkGALWZge7rJVwDdhEXb8+eGeYy8vJzznLt+/2fl4SpTUELoxVJsskcjcNoz99IvsB2u+n8+5kebBC1SLYi6hmNe1w/F6OmTDT/dx364dAVmj3waxd7gh68VCBY6Uw90HF0G8oQDWTtd3/7ST8XcxDeTnujpBY9mwRa+IKRmh1OY9GGfAgYgbUmiZ7Aqmnwcf3io+TEEgYve8LWWaj+OpagtU/ZTGyuFUGk4DpGPYmf8+9VoWa494vD4QWq3EHKLQPsmdf7vCe7lByzQtyj0cTGer6YPCbQTQyuObn7uNI8/3/lsWvTORsiLkIsNSn3ADhnYApktU1H/OPBw/AF+us7ik7Q3IMN8mEuCGBPzab+vc06L9lV7+hUv8/CitWWpCP8gbqKSpO17e+BdwEEjARewBc4WdnTkAS1FzqnTLkwSxl8sdY5KI9CJ4ScJZiD+z28phAM21Bp96mWYS3IlJVg8E5612r3FoDCKyWoZOP9wd0jSduMAWpx+SeWdYnBurFrjQFJ6ILZxPVbOpogU5gAU4uI1Y2DFDgGMz6x8U+p7XY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5190b728-1fdb-4e6a-a749-08daa6ad0eb7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2153.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 08:39:03.5160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSSLh89I0jg2rOPy/Lux42O9BsFjqaM3XeBbtua2iUrKO1QlHjz5bnoXXrm9oxXeMgMEFccu77wDb9s9zzzy3nMqNGuYx9/5O7BY1YPDgxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_09,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210050053
X-Proofpoint-ORIG-GUID: ebcVC1OwYJFZYqAmA7T9j8no_xoT_wO2
X-Proofpoint-GUID: ebcVC1OwYJFZYqAmA7T9j8no_xoT_wO2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--e38e8ba36671be4adfb48d8c065096aa4842e725837190220e18958090e3
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi list,

Kind ping.

On Tue Aug 30, 2022 at 09:42, Julian Pidancet wrote:
> The alternatives_smp_module_add() function restricts patching of SMP
> lock prefixes to the text address range passed as an argument.
>
> For vmlinux, patching all the instructions located between the _text and
> _etext symbols is allowed. That includes the .text section but also
> other sections such as .text.hot and .text.unlikely.
>
> As per the comment inside the 'struct smp_alt_module' definition, the
> original purpose of this restriction is to avoid patching the init code
> which may have been deallocated when the alternatives code run.
>
> For modules, the current code only allows patching instructions located
> inside the .text segment, excluding other sections such as .text.hot or
> .text.unlikely, which may need patching.
>
> This change aims to make patching of the kernel core and modules more
> consistent, by allowing all text sections of modules except .init.text
> to be patched in module_finalize().
>
> For that we use mod->core_layout.base/mod->core_layout.text_size as the
> address range allowed to be patched, which include all the code sections
> except the init code.
>
> Signed-off-by: Julian Pidancet <julian.pidancet@oracle.com>
> ---
> Public tests: https://gist.github.com/jpidancet/1ee457623426f3e3902a28eda=
f2c80d0=20
> Related thread: https://marc.info/?t=3D130864398400006
>
>  arch/x86/kernel/module.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> index b1abf663417c..da22193eb5e0 100644
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -251,14 +251,12 @@ int module_finalize(const Elf_Ehdr *hdr,
>  		    const Elf_Shdr *sechdrs,
>  		    struct module *me)
>  {
> -	const Elf_Shdr *s, *text =3D NULL, *alt =3D NULL, *locks =3D NULL,
> -		*para =3D NULL, *orc =3D NULL, *orc_ip =3D NULL,
> -		*retpolines =3D NULL, *returns =3D NULL, *ibt_endbr =3D NULL;
> +	const Elf_Shdr *s, *alt =3D NULL, *locks =3D NULL, *para =3D NULL,
> +		*orc =3D NULL, *orc_ip =3D NULL, *retpolines =3D NULL,
> +		*returns =3D NULL, *ibt_endbr =3D NULL;
>  	char *secstrings =3D (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
> =20
>  	for (s =3D sechdrs; s < sechdrs + hdr->e_shnum; s++) {
> -		if (!strcmp(".text", secstrings + s->sh_name))
> -			text =3D s;
>  		if (!strcmp(".altinstructions", secstrings + s->sh_name))
>  			alt =3D s;
>  		if (!strcmp(".smp_locks", secstrings + s->sh_name))
> @@ -302,12 +300,13 @@ int module_finalize(const Elf_Ehdr *hdr,
>  		void *iseg =3D (void *)ibt_endbr->sh_addr;
>  		apply_ibt_endbr(iseg, iseg + ibt_endbr->sh_size);
>  	}
> -	if (locks && text) {
> +	if (locks) {
>  		void *lseg =3D (void *)locks->sh_addr;
> -		void *tseg =3D (void *)text->sh_addr;
> +		void *text =3D me->core_layout.base;
> +		void *text_end =3D text + me->core_layout.text_size;
>  		alternatives_smp_module_add(me, me->name,
>  					    lseg, lseg + locks->sh_size,
> -					    tseg, tseg + text->sh_size);
> +					    text, text_end);
>  	}
> =20
>  	if (orc && orc_ip)
> --=20
> 2.37.1

--=20
Julian


--e38e8ba36671be4adfb48d8c065096aa4842e725837190220e18958090e3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQTd3Z6iZzTygRNy7F4XFh3U+bgUcgUCYz1CoxscanVsaWFuLnBp
ZGFuY2V0QG9yYWNsZS5jb20ACgkQFxYd1Pm4FHIDsgEAgwfV6laOjw/P361tBp8v
GUZpSc/JD5NQ/srQ/9mZdhYA/2pam3NThOBRljLtKb1AN3OuoGp8HbyD6Tx14kmg
T6UL
=FLvZ
-----END PGP SIGNATURE-----

--e38e8ba36671be4adfb48d8c065096aa4842e725837190220e18958090e3--
