Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082486B50EE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjCJT3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 14:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCJT3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:29:49 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A510F7E8A9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 11:29:48 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AF43IT017841;
        Fri, 10 Mar 2023 19:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=WJOBHSQbcubSOaGkEQRU+GsdCt/r/eH+5n2D9ld4sRk=;
 b=pcRImQkS+dIjBVG0b19VtzuLcG5cL1g8wIbFiMRwiNPLr5qjKgTmuntMXAvf2XmitiIg
 W7Pcfaz0FnDU+YeDt53WPNhZt1B7XUCIRv83zavsJVZo+8hkden0Z2cJ+Fy9nPiFUFl2
 fIXWRCsXH2SjGLxRJD7G/luUnk8pJQVCzIh5/RnWpsgDhECIXB4bZsHqfYNuslk7V5c9
 qMkyNdkhPaXIqHcm0DYtPOJ1VDKb5+v8TpEDy+gKX3PIv4alPjpF4dXtTlo/pzRPYiDR
 FleIW9scPBEPS8WR17lt5DJU6FWRJbCD2iUQl8gUYIyhvVULTeW6gIbjTUoyBsRb6uA7 7Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p415j64nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 19:29:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32AHUPcw035020;
        Fri, 10 Mar 2023 19:29:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fubar3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 19:29:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1O+8Eti30LibXDHt9MGyM2KWE5wYF4ZKxiQrjLRitLwW/ASB0i8MFrOtaTWrdjaZcj74nUwAtJ7nF5NKsX1Uas1XOhS1Rx+YhH002NwRBMitL6dYfa/zaVqtTWC5Qu64E5XE0+9ktoBKCC3JwW9oKFIrwupIo3wantuOi20FVHZprPqINQCBQfYqTNZuY+6LmPPGsxJfnL25R8aecQzqIlm2/9+SPQ2J/0kkCPNA9HGrd7qnlJg1IG4H3f5KtglwN4hhWxg0GScY24wmjRQ11nOQZh3thzy1nQyT1HW8Q7Kk7bgHXbKJBrXYIR34F52f/jKpxnnDgelP5Tx3Pa4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJOBHSQbcubSOaGkEQRU+GsdCt/r/eH+5n2D9ld4sRk=;
 b=DBWdUuuGAr5jSJG5TPmfa/y39t6h1x7lR0LlTEwwk+eSNXVLqIkXxtvgIyBSIYOHKXV6+bCt4qfQYtYdI+848AcnmyCeFGIW9M9UZZFiyqfIFiffKqIBoq3xxcndphY2yKn7K2JjMzf414nnqTLP04fp9u7aqdKpq6VmInmnC4w/9edv7GUGIl9BCBz7Auz6ybHd3Nw3Sry9aI9xXHEIra/Fj46HJzhxEcpR73gifj7RQCJRNJ6uU3qt8BWptcmRkQTSLoGX2/JnjCkI8QSQpca+wmTPrFlek77Ansqyd7M5rDDyUxcQJU2xpNKEM6H/s8EvPy4RB6E06hIdoDih+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJOBHSQbcubSOaGkEQRU+GsdCt/r/eH+5n2D9ld4sRk=;
 b=EK+Wru0joDlA2r397I71bMngCZAdJpp2UOllfwFJa57yDzaWmid6biMeBTQyPD1THctEae8KyiTF0Uzel3HUgMVRFx7OYHmNa8fFVmQYWYCemuo7Ynox6I8jsogPUxNrqyQ0E1KJvZxA9bjn8/9L6hYYgHoEOrwghL2xHNq+dNo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN0PR10MB5957.namprd10.prod.outlook.com (2603:10b6:208:3cf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 19:29:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 19:29:23 +0000
Date:   Fri, 10 Mar 2023 14:29:20 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 3/4] maple_tree: Fix a potential concurrency bug in RCU
 mode
Message-ID: <20230310192920.dsmd3plhwqgma6ak@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20230310140848.94485-1-zhangpeng.00@bytedance.com>
 <20230310140848.94485-4-zhangpeng.00@bytedance.com>
 <20230310182717.csx4qgmvfvtc262c@revolver>
 <1670bc9f-e601-c445-6db1-7c769bb21547@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1670bc9f-e601-c445-6db1-7c769bb21547@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YTBP288CA0003.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::16) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MN0PR10MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: 937d3cad-9b70-48b9-9a34-08db219dc0b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUgDG79MFNuz9+qo75nUbPfVNigL0RQfODehX/NhZYQyo6tGBfRH/aBubG+GxMGmMcbBs5+821P5awzD3U9xzG5Ai51UzfKTnmVzE6rFR1fP+HqBLBqjPNEPkEHI6wblJf25YeZX8Y/YYJ301Pmd6MiTHyxrPg60a1p3wZGlKgl9DAN8WTz4F09lbNvPtIwZrB7BQnytLSNeOLBVMZX+v8oDPxxooE7c86WZbbN5Qc52Pev+mGlzjf342Au7BwptsNfeoyVJmTP2LR7gEItUucLVe7nBEhWohbLqCYacree73759L5QgjZwK1l5J5ixElBbw+n2Moyuf3BqocuD5STu4/38QRX5QNmOMYsKi5VTouOK8oPZbmdem7ntPbclt8fSeHaasLRrxb0EhrxsM5X1iKkIOu4xY2Xhh4jCgIi99jfYLX9NbasVdKakCtL1Up4er6l4RJrVIfJg+apkRwS/dDtObNje7/LJhNku9Nm2ToAPAtR8zHhVClBLvvh7IdlfXorfFYfUu7wSMn1rmUpN+Qz6RM8ZIUePN7aj6hNBZ18SSDFqbYEvozXTtkGPlMJIoSLIzrnjJAtXR0YL40Xm+SjT0QyKT0jqO1HAmGvPlHm80dujR8iUom6Fv6nT8ahuKcUS/bnaYk2aKLibxJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199018)(8936002)(86362001)(33716001)(38100700002)(83380400001)(478600001)(6486002)(2906002)(5660300002)(4326008)(8676002)(66476007)(66556008)(66946007)(316002)(41300700001)(6916009)(9686003)(186003)(26005)(6512007)(1076003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXJ3dHI4Vkh3a2t6aW1aWTV4TG5tc1U0MWlGVjVTREgrQ0NLTENUQ2twc0p1?=
 =?utf-8?B?QjRiOHJ0RUdQTXg0am5KWWJObXBtTHc0cCtQV3RtOTlXdWJWQ3ZlR2N4N3k5?=
 =?utf-8?B?bVBzRVRIVFJ3Z1AyZzZOOG9zTS9wRkI2elY0UWo2eVcyMW8vZkxlR3MxYUtw?=
 =?utf-8?B?V0xHUFVOdjJyRVU1dUlyQndvem5rbm8rSk9wTTVGbVJ1aUQ3WFBoZUpjekM0?=
 =?utf-8?B?Q3l1Sk1DbG9FSEpxYTVNQTlYdE92c2I1bWZlWDJBVU9qRTl0TVVkYTNjUHVG?=
 =?utf-8?B?WDVuVE9jcjY3NUEyOVg3UmJ3SldXTmQ2N3NmTFlUZnRJUm1neXZ6Ymc3ZFdv?=
 =?utf-8?B?Z0xoeWRYamhTN3lESmxPa3FoYk1UTngxTjNXRG0wOTUralRWN2xMOHdjZXpZ?=
 =?utf-8?B?YVdHaUMvRjNmNElmUThuSGx3bzBZR2F2MURhRmZjRkNUSVZVR0lCMW43b2hC?=
 =?utf-8?B?UjFqTmhGVEt2UVRSK3BlOVZDZUVzbEwrZXVIWWRRdXd5Z1FiaWNqaWtwZ0Ju?=
 =?utf-8?B?aXNwLzgxZEh6ZWFJYmNETnY5dmMvTmFJV0x2VjU1YXJOVnIwTktZWk02Sm9t?=
 =?utf-8?B?cHpWS0lyd0VkT3U1SXE4TVo1M2E5NGc3L1JyR3BxSzFZSm1DL1hibXFnVmdQ?=
 =?utf-8?B?bUs4YmxnemE3U2RZOU1pNnJPY3gwQjVHWWRJOVFZY1ptRzhUZmxndEszcFVT?=
 =?utf-8?B?VGdISWJHRGdLYzZQb2M3dUtxakJXdldLLy82eVBVSGNCR3RMOFZrb0xCUlNN?=
 =?utf-8?B?WGswNWMwcFVtWUlzNE5NNDIxU1RqOFd5dG11TlJyclpDcGZnbXBRaTdBVmF3?=
 =?utf-8?B?WXFLY3NQa0xjYk14dGxURXJ3Mk9xbnB3RmFrakxYMC9LRmFUUWxqRkJBWkQy?=
 =?utf-8?B?dlhJOTEyZUFwMXRrcUhsengrQWRpWG5ESEFWZ1BZTnFLaWdMVHRCMzNMaTFX?=
 =?utf-8?B?YVI4bWlCa002cTd1QkZVWE9vdTc0U3M2TDJPc2pKK3drZC92eDN3Q0k4aWww?=
 =?utf-8?B?YXpnUGdVbElwZHZseGVDNVNqbXlwTzhSMTdZMmNGazl2UWdiellvcC9JWDFx?=
 =?utf-8?B?ZWNsWENnMWRPaFJNWGNGM2ZuSEpMaTdZdUZnQVh4SmoxMm96V0pZZEpxeUhq?=
 =?utf-8?B?ekV0dVBsZUoxSGFoZ25ObDhkWkR3YnNTc1dxZ3JtM0ZRSzRJV2dRbmR6WUlJ?=
 =?utf-8?B?NGoyUWt3ZDJiRFZ5NGFYb2RhSUxZWGlINE4rRWFWdkwvQXV5SWZWNXFxZS9i?=
 =?utf-8?B?SjRkSkdEenlyWDgzdHllanpPMmg4YUJ1djRsTTlNRTdIeWdPQWt4NlNLTEY5?=
 =?utf-8?B?ZkdYY3ZZamQ0M3NvM0NQQ0IwUVJKM3N5ZjF1SmdadXEvYXlVZjMrZ2hnTVM5?=
 =?utf-8?B?dzVkZmlwRERwTG1lRDh5VkN1b1M5ZFRhQ3B6b0tlUXRpb09XelVSTWd1WGdV?=
 =?utf-8?B?ZE44QnZIb2d1eDlKM0tYbUtxcGd4SVN3ekh4Q3Iwa3AyU09LenpkWVc4dGM5?=
 =?utf-8?B?cjYwa2E4OUtPdTR6QVd1S3dDaTR0SUNXSDVndk40SzQzWmkzNVFXTnJpZ2ZG?=
 =?utf-8?B?NzQzSVVjb0ZiTURhK3NFTnJ1VGFsU05sR2xiRlVTUFNyTStNN1hwRyszQUFk?=
 =?utf-8?B?VjdWUVRuMU5SOGFyLzMyM0t3UmVFcGdCaWNNUnM0alVQSnJjOENsUWZoVmpL?=
 =?utf-8?B?U1JqMnN1emZOSjA2UU04R0RNZmlmQnQ0b3lTNlNMRFRhMDBpV0ttcnBNS0Ex?=
 =?utf-8?B?QlN3azV1ZlhrMDU3UlIrVFIwSEgxQlZwTXFFODhZZDd2a3FjbkdnMUNpdSsv?=
 =?utf-8?B?TkRjUDJ6MHV1U1RINFNGd3l0MTIrZk5rZGlUYWVMT1FJM3U0N1ZrWGFqeWV1?=
 =?utf-8?B?N2taNGg3UXk3QnBqN3BXdUIxMVlaR0lQZ1paR2dibGpmZzBQZEhzVm14cXZv?=
 =?utf-8?B?Y3grUHBqdmhoTlE4SGdaV1F5c2hBSEZlY3BIakhiaXlsajE5TGJwdmprUUFq?=
 =?utf-8?B?WldlOElpdXExZXhRVTVjSFFMYStqRzUrUUtOVHhvTDJHWjk0a3V4QXk1Zjk4?=
 =?utf-8?B?bm9uWFAwUFdVc0ZhZktvemZhNG0rN3hhMGkzaER3ait3V0JOSng2UEFtMWt0?=
 =?utf-8?B?OGI2Qm9EUkp6VEZZN0xSMGtCWUc5blgxdVozZm8zU3ZDVkRRSng2dm53K28v?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DMX0a3/bREf1GmR47LHzoEL+enCEw35y1sBC6rAeFoT9Xppt64Wc70BrAIS5FOLOsn6xN7QBNXfGQvmVual71+y+pYW7fhxYt6FppTU1XfKu0OLiqpLPBItpkbkE4VIuxTJa6jPrpotx0gpV2GzzmE6fAAT8o9X3lujEd0QGQ7FLNFRBjLMX6UWJqMiRJ7mQ1oBSgxW21uSbJFiZ4B5Xo8dJ+XnpY45QjwoTj2hi9pfAedt25oacG17fMrMVIUIvOKFu8XJ5TrwfEWY+1NLXFutNOOA0NXlDyHGzW3rWhZJmJwQ+vb0lr4BzlRzDVDX1/YAQTOHH2NGsSQZGdJ55pyEHG1vJd/bSh6l/mymqww1iG+TZYo57zDVgr+2+we2ocFonGR7LTCdAg9k1hJd6q4p0yxIWjpl/wVdJzzpqUXE6Zdxd0s2V6pwffpIiMHqTEYtBWTpMa45rqAVzqc80d1N9LLwj7DpAL4/ul9t6oSLKcRAAY2LNkTt2dJ6M77U6vKuRlHVx7NsP9hoWgffJb6VidxkyCyrQMw3M3jWAzBmYk7R0YMYem3YEolyTEk0shA7IcAEv7/VANUVe+EXtlBlHeQ+Iqt69Oz5yN+e+MptrMnm3qq6q2higRHweJgG+0ea/HC7odzavm7i+wsirGAvi54qsjwmgLggyl31xrs0Nq9ta5dF22S30uIOWpJNalU6iFa5doaDWY7/sY+b2SeGqFwWcVTfeVwGO90xy/+EQyR6cdWPxnR+anD46eQR99ZVpgDcaSiI6sAf4fb5qkFmBn5mBlzVSDGAZCIofyQymb0OWLIEw2n/TevN/X3S1Um5UL1cdnGq9M2be3YwEs04gTUrAAshYoMAsGpdZc7xn8TQEJXlHrmsy6FuhJx+v
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 937d3cad-9b70-48b9-9a34-08db219dc0b1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 19:29:23.0441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDBydH1y60nlxxdLXPMGXlyvgDXgGyx13t6j4/hgvFATWrcFfzCq5vfRn2ItgKQKgjX6u3Eimy01rqzdrrSa3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=998 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100154
X-Proofpoint-GUID: JoWJOzmRsCFlaVmmfoRFGB8U-_A0aZYd
X-Proofpoint-ORIG-GUID: JoWJOzmRsCFlaVmmfoRFGB8U-_A0aZYd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230310 14:03]:
>=20
> =E5=9C=A8 2023/3/11 02:27, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230310 09:09]:
> > > There is a concurrency bug that may cause the wrong value to be loade=
d
> > > when a CPU is modifying the maple tree.
> > >=20
> > > CPU1:
> > > mtree_insert_range()
> > >    mas_insert()
> > >      mas_store_root()
> > >        ...
> > >        mas_root_expand()
> > >          ...
> > >          rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node=
));
> > >          ma_set_meta(node, maple_leaf_64, 0, slot);    <---IP
> > >=20
> > > CPU2:
> > > mtree_load()
> > >    mtree_lookup_walk()
> > >      ma_data_end();
> > >=20
> > > When CPU1 is about to execute the instruction pointed to by IP,
> > > the ma_data_end() executed by CPU2 may return the wrong end position,
> > > which will cause the value loaded by mtree_load() to be wrong.
> > >=20
> > > An example of triggering the bug:
> > >=20
> > > Add mdelay(100) between rcu_assign_pointer() and ma_set_meta() in
> > > mas_root_expand().
> > >=20
> > > static DEFINE_MTREE(tree);
> > > int work(void *p) {
> > > 	unsigned long val;
> > > 	for (int i =3D 0 ; i< 30; ++i) {
> > > 		val =3D (unsigned long)mtree_load(&tree, 8);
> > > 		mdelay(5);
> > > 		pr_info("%lu",val);
> > > 	}
> > > 	return 0;
> > > }
> > >=20
> > > mt_init_flags(&tree, MT_FLAGS_USE_RCU);
> > > mtree_insert(&tree, 0, (void*)12345, GFP_KERNEL);
> > > run_thread(work)
> > > mtree_insert(&tree, 1, (void*)56789, GFP_KERNEL);
> > >=20
> > > In RCU mode, mtree_load() should always return the value before or af=
ter
> > > the data structure is modified, and in this example mtree_load(&tree,=
 8)
> > > may return 56789 which is not expected, it should always return NULL.
> > > Fix it by put ma_set_meta() before rcu_assign_pointer().
> > Are you able to write a test case for this issue?  I understand it's a
> > race so it may be difficult to catch.
> Yes it's hard to catch. I'll try to think of a test case next week.
> It is difficult because of the need to expand the competitive area.

This should have a fixes tag as well.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")

> >=20
> > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> >=20
> > > ---
> > >   lib/maple_tree.c | 3 +--
> > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > >=20
> > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > index 4d15202a0692..de43ff19da72 100644
> > > --- a/lib/maple_tree.c
> > > +++ b/lib/maple_tree.c
> > > @@ -3635,10 +3635,9 @@ static inline int mas_root_expand(struct ma_st=
ate *mas, void *entry)
> > >   		slot++;
> > >   	mas->depth =3D 1;
> > >   	mas_set_height(mas);
> > > -
> > > +	ma_set_meta(node, maple_leaf_64, 0, slot);
> > >   	/* swap the new root into the tree */
> > >   	rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node));
> > > -	ma_set_meta(node, maple_leaf_64, 0, slot);
> > >   	return slot;
> > >   }
> > > --=20
> > > 2.20.1
> > >=20
