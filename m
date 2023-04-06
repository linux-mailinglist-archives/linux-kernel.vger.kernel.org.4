Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCFF6DA15D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbjDFTd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjDFTdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:33:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF8AE72;
        Thu,  6 Apr 2023 12:33:22 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336EhuLa015755;
        Thu, 6 Apr 2023 19:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=z31+0RM5se9tsEpbotQz5AmEWlD7auB24+w6j8NYrWc=;
 b=JefO/9fbjPZYFedR6Vs53r19TmKbud5HSH8R4m4yGmIMZ6dCfRcsIYpyI+RGksjifzhA
 Bjz7SbTIvAvVQrxaoCctbI67rQLzBXC3XuKNsifNJpMMWPtKKgd00rFh9Ukkma4S3ND0
 i4tyU4Dsp4d8nMC9jDuj7EzxLdAVCiRNmJdPcDrcM7IpYCr9RDtxrILU18nsCVy91Uoa
 ElHCN8RjeaN7Plai3q9mIGnJaAAL4t3xHl2AkMMm8nywSB3ASAiTXPLMONmvdEIqA5/i
 tc0CRoq7qY5OEpPmC43Rks+O2O55F/5cJU8NSwR9uzV5fSCjdGYJXCsI0J5tlUX4S74S pw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppbd43rsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 19:33:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336IkR7Y027478;
        Thu, 6 Apr 2023 19:33:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptutg8tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 19:33:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ttw3PyJHjMvYWU6kLDuD7UTZ5xFh6ljjurtd5HXOj1thmzK6+CCAIdWFmB6j/ouzgc+PyHjd2QQuDOz0R/ozEekzi8NXswt+raaXzgRRwNSd7DPVEklzP3C9E7kIlm4er8MDvfdJh+/6QVZrGOksycIyWswloKcTaBT3hUnEOlWi6njJfWW7LNXUb65480GEEWb55Mz6MauZfAah83h7/EQcXzPGy3FFkoSdRCdbc4CQ4m3l4HsyKmq0BRaomhhlOu5VCXEZynVIu2kQiaU0GSeO6olfXLlxvpULHOZmZeEE4VHk0NvHIXyFZBI05GVJF3RtZZzFUqB6y14SlxzNZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z31+0RM5se9tsEpbotQz5AmEWlD7auB24+w6j8NYrWc=;
 b=nqOhj1LRVFhTGUNuBIXBx4EHSPfDSdter0W398/qFR21mYMknMe44nEoL0E4iak6qGrWS0GT2rnw/Axnt/lb0xZBYcYSmyQB415D0Xe1unT2w31N1TwwiWg+rPy+/Pa2PntfipO809tO9VybWOb75qCw77c/X0KexYHgnuS1g8I79MuESZN6oqRKDXZL7DlUs2iOUP05H0O5FmZuzc4JCWyxRArgiml9i2amNEdvr2lR0tg52xSrNx9N8EzIafYfWZZZDNrlUalmrfZ2FwNyMUy2j0wSnnbUp0LIQw8pBBo7wa6TZyTubQRtgmKFcmVOO8kE7az8gyF6B9RFfmcxkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z31+0RM5se9tsEpbotQz5AmEWlD7auB24+w6j8NYrWc=;
 b=dn0yMloNqmzFlV8TGYqbgT9UBqqC7K9x9D7hqeNgUMlToFcQzV4EReYhdsI3cqse2eg7rlT2b8/3nLO8yIZsy9eNOoSCVCuH3nlP4Lg9iXP4emnYyPeQZrFt6Gu0TzZD807rB1HDlIDCkL7mxPpgQt+eVrMY6k1NTtnINjiVNGc=
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Thu, 6 Apr
 2023 19:33:12 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::d8d2:ddf3:e236:99ef]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::d8d2:ddf3:e236:99ef%4]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 19:33:11 +0000
Date:   Thu, 6 Apr 2023 15:32:55 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, nathanl@linux.ibm.com, junxiao.bi@oracle.com,
        joe.jin@oracle.com, Eric <eric.snowberg@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, axboe@kernel.dk
Subject: Re: Semantics of blktrace with lockdown (integrity) enabled kernel.
Message-ID: <ZC8eZ/RTX//0urV/@char.us.oracle.com>
References: <ZC8Dbux56HbJjpTy@char.us.oracle.com>
 <CAHC9VhQ2rLpjczvb4993fQiMau7ZXLe8aTLtMZO_iF42w=1frg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQ2rLpjczvb4993fQiMau7ZXLe8aTLtMZO_iF42w=1frg@mail.gmail.com>
X-ClientProxiedBy: BL0PR0102CA0065.prod.exchangelabs.com
 (2603:10b6:208:25::42) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2999:EE_|DS0PR10MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: d64aca2a-5135-422f-210b-08db36d5c224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQHvSrtIkGW+rZfOStOOpUya34ejy5uZsCv0KePjEq8ZatPbYbFlIlWzkK6kiHlboweYwd5BoUvlBr7mn/S4yiSsdspizFwFunIMVa1jODpDSP3zw8oy9HBalV8MbaogcUX0ENPImJy0bss77tzt9FvlgV5CVCnzYRfYmq0k8g4PAwSav4L1O1fGoop+guvEIuwNr7Q6yOZBFAAcWUvnUfX4EoA5QCOBOI53FSaBo+P9S2rLep7V67uMoZbNmPJXmbJgqftPsS+uv3JExkxQikeKZhMBJI3PyX5FvfQ+hFIbrPV/bkHa0EcKj9OGugiKdA9tm97ATDy2R2huCJ/RcChhg4sjwPqzL8IDQSaoyLS/lTStgcTtgnzL5At3ddzUdQeRTP8l+BBG8HBQUDWuwZmnyDN2ITBt77F9jihzZup6hglO57dHtpQFHg/BW8mfaHf7Rupbv048KHmdJntNdTlCVVkW1vfGrANl13cc0PWBzYA/LwDVJNn5FSwP9WzCoRUYrRuTFmKVvpL4TkTLK1DednFTJo2JoIOieVaiAddjD4zUcUePwyO84d4UNRFx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199021)(38100700002)(8676002)(66476007)(66946007)(66556008)(41300700001)(5660300002)(8936002)(6916009)(316002)(4326008)(478600001)(26005)(2906002)(54906003)(6666004)(86362001)(83380400001)(186003)(53546011)(6506007)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW4xVGlZSWpXakQybFM0MHhvMGwxQlN4eHJta3ZWb2taMm9ENXdOVVpPQUFa?=
 =?utf-8?B?MXVCMHVtKzFiakRabXE3Y0h0L2ZwV1ZVcFBtOTNPdFB5SklNd2ZyYkN0T1NW?=
 =?utf-8?B?WlVFLzBhKzZYamdpbjV0SWtRSTBaZ3lVVzVhZ0xrNkt4NXAzOVF6enNIT0hh?=
 =?utf-8?B?RFNOL1AxWFBScE5KT3FwWXZDbHVmeTBuZHZrR0hQdmdWcHRZUWxBQWVOL0Vi?=
 =?utf-8?B?U0Vsdy85aGN6LzNKd29IMDdHcDlhLzRXcWhmeUtkS3lVVHNzWTFzbGhwbCtE?=
 =?utf-8?B?ajRMT1luVStZRUJiS2F5cnJJcGdwVVBoTHE4YTM4cmNCSklVYm5RWFpMUDdq?=
 =?utf-8?B?Mld5akVWN0N1eUV0aHVkZ0JRK3ZvMEgyQ3QvbWZ3NEFULzFabTVvd2VMNzZn?=
 =?utf-8?B?UWZXamFxL1E0alFjbUE5ZkwwR3VUZzZvWnRQektESEg5WUcvMDdnazR1Nith?=
 =?utf-8?B?ZDUza1FnV1pJY0lBZGE0Vy9lT3lWMHVzdXo4ajJwSG10UTVYbHk4c3hXS0VV?=
 =?utf-8?B?V3lxYTRPcktNYm4vclYwMW4vYUJmUjRsMGVBanJqUUhRVkUyaFNrVzUxMFRX?=
 =?utf-8?B?ZHc4RTBWVGt0VENNNmNwQTY3TERnZ0dPMWZtdkFKc21Dd3FwVVRXczZGelZt?=
 =?utf-8?B?WStYaWJBSGRzL1J5dHg2WUM5Q1hMdVhzekpOUzg3MmNVWkpDZ3FUTXNsNFpt?=
 =?utf-8?B?bndqNDNBelVsVDJhTno4dGJPTG9PZ3dzdTZOUWgvZi9LaGh6Y2RnQXp0bmds?=
 =?utf-8?B?eUJsR09DS01TbDdhUlE3cm9CQ055dDlMQ251TTZGOXY0WlVrY3FxUHljcE1P?=
 =?utf-8?B?U0E3U09ZU1k2TzVIYzAySk1URFB6TkIwbGd3QnRsTG1QZG5DVE5DZ3hzL216?=
 =?utf-8?B?SWRxL0JYUWlvcitiZXZPV0E1QUJUSWZXeHR0dlIxUVVVSUxIejZwOWlLVHdF?=
 =?utf-8?B?LzgrVTAwL21SbnVoUTc2N2hPOUFpSWxLT2laMXJHc3VEazYzV3NPVTBCc1lT?=
 =?utf-8?B?YVNIS29jVEsvQTgwaVZYVmxQUjFWbERrWDhVNk9wcFIwNWpPWWFMZXpyVGdU?=
 =?utf-8?B?SnhqUENpeXRnM1VHeFc3N0czY1dFVFlZNW9XdEJKTm83YzhKS2o4ZGNHZHd2?=
 =?utf-8?B?VTNWdnEzdk1CNC9mNmNmVmpxUDA2ejh5N2Z3RGFDTjdBdFVWZSttMzlORW1I?=
 =?utf-8?B?cVlOeCtxcDVyeDFwbmFOZnJQYlpRNXVEaUVvSWhIT3QxeWZEWmZmVFJJb2NZ?=
 =?utf-8?B?eHlIcmpyUWNhekFKc0ljZlFRQmVLMnl2M0ViRisxUzN1SWFaSkpub0VwczQ4?=
 =?utf-8?B?VDI5UTVjcTZqN3labEgzb0RnNTNVYmxBaktWVFFjMnJuUExMdC80cHliUzNp?=
 =?utf-8?B?c3pKWU44b2orOUFQb2lLd2x0RHdoYTVjQjV6S1lLSERvZ1RwblRUNVJWZWY4?=
 =?utf-8?B?RkN5MHhkeFd0VWZqOXF0bG93ZktFb0ZNZDdvemRrRCtyUDZxT3pQbCt6VDdk?=
 =?utf-8?B?djdsY2lSbnc0M2R0YlI5Y3ZsVGVNdDBJdFowZmdocUx2MHhPV0ZhOWJOalhI?=
 =?utf-8?B?ZW1zaFVGSXd3UjF5NGFMQ0ZFYlhuV0VvNlFnTEtlWjBTZ3NKRS9WQlFqVm1i?=
 =?utf-8?B?cUFjV2dhUUlFTHBUVWJpK0dQUjZWU3UyL1Blekp6OS93VlpEQjMyYTNBMVJF?=
 =?utf-8?B?L1YxN0kxOEdDOVFDcWNEOEVveTNrMllyMzVHdFRWS2h1UkVmOWRTZm52UmFz?=
 =?utf-8?B?R3JUK0VsZmFwQ2NRRW9OY1d3T3JoQTYyNXVrNk93Mk5xWDFHdW04Titjb01S?=
 =?utf-8?B?SkdqVEFOVlI4WSt4akFFSTdacGRWNEtQanl0SCtSQ3k3cHBuVFJmRTJPbGs0?=
 =?utf-8?B?My82VXFtNXhObUw0ZWVWVXNrSmd6MFkvWEFYZWJoTm5UbHZvRU1ldGJFNlJw?=
 =?utf-8?B?TU0zSDZuTDdncXZWYnFOUDFpZUgyZ1NqSTBVTGI5dlJKc3VsUVNaNmx1UDBB?=
 =?utf-8?B?WWQyMzNLNDBtbTkrN1I5TWtwaXoyOEVhQzRkOWJDOC8xMFRPekkvcUtVN3Mx?=
 =?utf-8?B?dERYS2ZkQ01keDlKZ2VTcVBEQkRrM1h5Rk5FbktqczQrUXFTOUtObUtzVUlu?=
 =?utf-8?B?Ni9tRG5kVFd4U3U0NUlVU25zemlGdXRtRytzMXpSMnZjVlpndVM2SlRzRFdX?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 96yvYHb+Vd3o3+0lgNRYpGmRKQHr3VoRpL1NtBC1vHAbsOwDNaz6wDLLqj9593UM43YHWu2cVBgnVwwEXvEc67SXVHng/SW0s1WK4UcbyT6XuSQxgMHTa/5CDi3pEXgw3yTWOvdFUY6CG0cCHYr/OYlo7NpApE6p3l8+FKOgBF5H5uU2Yl6YpT50aIob5FKaMk4HzbFCnD8gJVBeO3FgGTh+lAGpxITu1oVGHC4YXcCxTQ6/Vq/1QM7MVClFnfCdIVTUxrKLD9/exf8X+FNLdUB6Ue4tVyxowDtdoazLFlH7lnU2GCcn7Sebd3/Kjpg6qOVZL5kQKSofUKcuqujPJYxkdhgaNfxErCJp9pr6zBgUWTKODQDAXj7hB4l2DSBQFClChkFISevJX6BvtGhjLcppGtu3FoxRCjUMiNOgZU0brq/4K/Gq/RrPbgtSl8JkpiVPB+QcUOtt+ToCAUUtxCz7PFyGP91DTcMGoIQFIQrn11vS1bmbxr/e/pyUXBhaKT8kbrBqcr6Ophj98tDduPwb2+KIbQi3CGIvth4McjvzhqSIdQZVwZ6Ix4Ls+0bxD0X69M7Db+WVuO++6Ee9J2AmDPv67yKAIYBON0yVb8FzIBJNcPUKNj/XE4LqU2GRpVMhEMQ3uuOjIsHmzGBIg++74t+gUPGPG1qqAYsV3tnWd/SUjoycNzEFLn2yb84c5o4dToJlAlHh2KgUsxr4GRsmEU1j0YpgF0fXR//yPfq2PWfXtn4E9PnqdF2b11bJw7i9WRDMUfWmO7XDXZ1rsDxRxQ6vudVU8kyqF00XpOGxKqN+ZI2R3VE+8u2IJ2a2QrT11l2QcxpWcZsHk5Y/pr7eXKL01WXlc/lH2S3sPgkspm1fS6Wbg1wDYWvnq1bV1R+NqF1hRaMyKUj/0CJh5AIevHsYuvkX25Y48HrJPGg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d64aca2a-5135-422f-210b-08db36d5c224
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 19:33:11.7821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dEPqYgIxZuIkbUifDLikbObqL0bt93ogMpFhmdr10oXUFOwQDbrFcEZCl7Z1852SetfqJix2feZ9ELX0QI72sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_11,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304060173
X-Proofpoint-ORIG-GUID: flvOxW4wFu_40G1x6m9SCbBmMHWIY-yk
X-Proofpoint-GUID: flvOxW4wFu_40G1x6m9SCbBmMHWIY-yk
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 02:39:57PM -0400, Paul Moore wrote:
> On Thu, Apr 6, 2023 at 1:38 PM Konrad Rzeszutek Wilk
> <konrad.wilk@oracle.com> wrote:
> >
> > Hey Jens, Paul, James, Nathan,
> >
> > We are trying to use blktrace with a kernel that has lockdown enabled and find that it cannot run.
> >
> > Specifically the issue is that we are trying to do is pretty simple:
> >
> > strace -f blktrace -d /dev/sda -w 60
> >
> > [pid 148882] <... mprotect resumed>)    = 0
> > [pid 148881] openat(AT_FDCWD, "/sys/kernel/debug/block/sda/trace0", O_RDONLY|O_NONBLOCK <unfinished ...>
> > [pid 148882] sched_setaffinity(0, 8, [1]) = 0
> > [pid 148881] <... openat resumed>)      = -1 EPERM (Operation not permitted)
> >
> > which fails. The analysis from Eric (CCed) is that
> >
> > All debugfs entries do not exist until blktrace is run.  It is opening
> > /sys/kernel/debug/block/sda/trace0 which isn’t there normally. While running the utility,
> > to place something in it, it must have the write permission set.  When exiting out of
> > blktrace, the entry is gone, both on a machine running with secure boot enabled
> > and one with it disabled.  Which also indicates the write permission was set,
> > otherwise the entry would still be there.
> >
> > The fix is simple enough (see attachment) but we are not sure about the semantics of what
> > lockdown has in mind.
> >
> > Looking at the include/linux/security.h the LOCKDOWN_TRACEFS exists which would
> > imply that it is expected that operations with tracefs *should* work with lockdown (integrity mode).
> >
> > But at the same point, debugfs writable attributes are a nono with lockdown.
> >
> > So what is the right way forward?
> 
> What did you use as a basis for your changes?  I'm looking at the
> patch you sent and it appears to be making a change to a
> debugfs_lockdown_whitelisted() function defined in
> fs/debugfs/internal.h which does not exist in Linus' tree.  If I
> search through all of the archives on lore.kernel.org the only hit I
> get is your email, so it seems doubtful it is in a subsystem tree
> which hasn't made its way to Linus yet.

My apologies. We had to add some extra code for flipping IBRS on/off at
some point and that is why see this 'whitelisted' one. A more upstream
appropiate patch not be based on this.
> 
> Before we go any further, can you please verify that your issue is
> reproducible on a supported, upstream tree (preferably Linus')?

Yes. Very much so.
Thank you.
