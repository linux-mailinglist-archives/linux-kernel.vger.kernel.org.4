Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE74C616562
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKBO4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKBO4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:56:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1CB27DDB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 07:56:17 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2DwXGB004208;
        Wed, 2 Nov 2022 14:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+uouLM9pTRHs3obItmI5Sv7Lz5OwlurN3LM87YH3F5M=;
 b=GPgSVqf/lJshFbDIWpKd00x01MB+Cl7LfyDPogNYFIdSkdTPrIJ9Jr8pULcgcxmqh5XS
 xS2RXIVsRJoRpz5/JQ7tkVZxS8hmcRl9S+Eflnt9oclJz2kqwfTv/PUAarMW86saQ9qj
 Li/uUmfZM+C4p77ZQEMZsaIKx6zhyTM5bagWgZaodZEzab/AGDrN8ocYFjr43U4p7xM3
 6BvHHXcqWXMwZ2fiHt/tZ0sM8BFdZKdDR+2iGgpQPdDtJzyAk5ce5dgSs4cRb7QtG8tf
 pWiXx/VoiHletbXgtbSfz03KUbh28Awqp54o0dTgDx/jGHiZN7zeXQJ7qXjWWOpbBOuC 6w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts1a4aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 14:55:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2Dv4Nw009667;
        Wed, 2 Nov 2022 14:55:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmbpmud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 14:55:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4DrYsDXIJMyWVv7PoJDVlORNQw+vhCLQXMSJsXAO6LVVHM0eY+FGw9mwOE9DjwLNjj0JiVxIj+kz1bkPKVmYpCfqlXkNDTcegDNPM9pOjhWzI5pCN3DXx2QLdA+sCBvi0+yEgR0fo3J7RKBTqtuzeyERcmtiCYAak8nJlPzrFyJ0iySbF6wAPUUMI/nprj5PBNcpq2HbpE//3BzQ8TGldIQr0yVUDOXYe2adEIIDO2X+WuxzSyJAafohusrXih40MtEHlJEN3sWc6ExKYZpJHZIFX7pMBr0+wpRRVs0AfoX2xTx3CBkAmLXs1BPLEJTcqzuhDOK2Rj9041Ot502zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uouLM9pTRHs3obItmI5Sv7Lz5OwlurN3LM87YH3F5M=;
 b=nkkhxtNEmFjKOTPYGjctVlOw5UObY+fmO1+11+1UA/GhURhIaJUqFPS1uWr6mid/IuBB818C32Pr3G8cEOV3zM41cRITlm4ACMR22TgfTPdLhN5RE9mdSEwwE33CtmbejfU2fVLuTP6Fjxmcg3nlt8C6dbFx795N/Mk0gZDlhAElrkgpPkl63gJ6CKviqjfwIXKdeAXjGffwl3ynIRKMOQo7CTN4qzq16XOG4v1aM46sLRqjROO0dTWfcD7D4ogdVB2TIdGI6H1BEEfyKIAXxP0htVcWjQhNBh7cm/iK3wI9ioy3ZAJcW9rkVbL+ta0XxvuBAz5XQvsVjho56w+oZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uouLM9pTRHs3obItmI5Sv7Lz5OwlurN3LM87YH3F5M=;
 b=nANtoGBsAcSM4N9GGBIvmOs7LzQBRm8HBvcL1DcZNP/pXhqYTMFvoFLzJutPtr8yhIYXZUOUjznMogt7ak5bINlb5wanxJA5hetBNzgWCmoArUdA3i3MyqSWZFANPPwvEMZ+pStT8LpP30zyVNGxic28atCd09l3qHLSEYnDMFI=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH7PR10MB5674.namprd10.prod.outlook.com (2603:10b6:510:126::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 2 Nov
 2022 14:55:14 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%8]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 14:55:13 +0000
Message-ID: <06ef6e4b-1f42-d50f-1328-4f82fb34dd4d@oracle.com>
Date:   Wed, 2 Nov 2022 09:55:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v13 7/7] x86/crash: add x86 crash hotplug support
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20221031193604.28779-1-eric.devolder@oracle.com>
 <20221031193604.28779-8-eric.devolder@oracle.com> <Y2A4TqyOaPYBu4Hk@zn.tnic>
 <1c11a429-b5a9-fb55-fbef-b49e760e2d1e@oracle.com> <Y2I3zQ9ZU+C9Kgf7@zn.tnic>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Y2I3zQ9ZU+C9Kgf7@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0029.namprd18.prod.outlook.com
 (2603:10b6:806:f3::28) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH7PR10MB5674:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3e3679-4bb7-41f4-f86d-08dabce23eca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ig26Ti8hjbmzP6D6S9gj/f/TpO2RxMhsyigwY/SliSVHK4sCiW/tNpJ/Y/wTaXtXQRY2tel8gyxqYDCms6CatPExPeHONPENpXSnUyTUlqkJATHdzqFaJTr4HfoL8ilm4a7KIQIJiKu4/zWXy6Iakw+/xUDO+TpIS+R5dCZj4mChpnMOnURn2tuWKMmt1MPKjkxn4M9HEPcbUJI1txTQR1vOiAbiHLmm9Npz5eFpEx7tGdNUaHV22K1KLKZboFmAfIIVUbRvyDEL7dg4q/xIaqdLS6ssNksNJpAWCfG8oojvKqtA504cy+0ilb/pRcE6IaNh4ztYvBcL+Y8f5hAb5meL2/1QPVZtT3siMoyvwbkGSdLH3XvykK0IYIXetnqze9Tz3Yp7Yv2Q89jJT3QvCCQVFAaHs/24QSVSUmcmqEFTAbAyf6Ot6ijWWQsf8LvzIU2RleEj48+2wnqmlOvfg8X2jAYfCp41toR+DbwCntutURzfOc487f5WB1YI1/rCrvG5U/u8VlLdRNsmbi+7DgPcrUNuPRMOODjdoToKAqZnrBehF7digtUioA3UlRUgFTiCuS4ozQrh1oWZvvYHWU7Sy33k3XWL0uZ9EMPIV+xLevXz31EcCsKHIxJm+HIcOqM/yzuJCtl37dq1/O8UD1n9/K6VKC7fhQ1aT+KlLyvxnIR6uaeHXORcjdGh1iEkMozU7Netoq2Zn5H6j8vH0utNCEYJZgomAq1IuqK42v8taWiRmezg/4x8bpYsCOSxpfWjyi+O4KnX6YMI299Z9sNOTTMyc1/P2T0jX4IL4hs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199015)(31696002)(86362001)(36756003)(31686004)(38100700002)(2906002)(186003)(6486002)(478600001)(6666004)(53546011)(83380400001)(6506007)(66476007)(107886003)(2616005)(7416002)(8676002)(6512007)(8936002)(4326008)(66946007)(6916009)(316002)(66556008)(4744005)(5660300002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dncrQm9sc2pLVXNuMHIwMjI5NjJ6NUZRdVBwMVhVSEVwVmtHam1mVDF5cE9q?=
 =?utf-8?B?dHl4N21RVzU2V1MvVWtJd3lvQzdZOUpjV3Y0WTZKcU43QXdlQzZZMmxSMVEv?=
 =?utf-8?B?cWVsOFpIK3ZCNUJ2M1NqZXVKRUh0em5MNTZGR3YvMXcwRDBHTzhyYUQ2TXcz?=
 =?utf-8?B?SWVwL2R5Nll0bHJob3FmaVBPTG5UbnVraVgrM3ZYQ2pGemQ4VFFEU0ZOOHFr?=
 =?utf-8?B?Y25RQ3J0enl0enoxeUtPZDJqTitkTjFPdk5SRlVCTnlBNkJrcytqaVZDYXlm?=
 =?utf-8?B?SnNmZnBmMXFLUTFucytpZ1dzY3lWOGZSWlAvTlFuZ00waGZIWCtpK1p6SWp5?=
 =?utf-8?B?bDdveExrRVhSSUduUGRIYitWaHFaeVR4MXdzcUNZWU1BL3Y5ZEJBOVo1RU5j?=
 =?utf-8?B?WXYrY0cvNE9wWk5xNEJLSFB5LzVuWENkQVlzVEtWTnJhMnFXMlIxWm5lQjJD?=
 =?utf-8?B?a0VRcmw5c01oTDVWSXNLUEFlM3djejZDdmpjOWZCWGZnUTFEbXFITWtBOU5m?=
 =?utf-8?B?bE41ZWE1OVk4SHhJRWN6dks0WWZiTS83S1V2eHRTYWNZUUJaRGcrbGxzTXVC?=
 =?utf-8?B?a0trMWhUdzZSbDJjZnRRVmsxcVR2eG1uVko4VXNvRXNJSGh5ZkgrL3IrNEZK?=
 =?utf-8?B?dVRXaFBCUm11N08wWjNRK3ZsdFpXS1lsWjE3ZTlyL3lDTm03L0JwYUlRVXIw?=
 =?utf-8?B?VzhkMy9qMDBRRGV2MHgvaHQzc1RYbXBUOE9WVU9KbHg4Z3ZHK0VJcVliKzNG?=
 =?utf-8?B?cXJ3QnZnTk52NHRWRjJTRTZRQ0xaWnNzdVpSbk5ITjVRKzJGODM2amRoeGI3?=
 =?utf-8?B?YWErTSt1WUtTQVliSFpZSXN1L1M3RSsxd0cyN0d2aWN2RUFGK1EzU2xxNHdt?=
 =?utf-8?B?eTZvZ05YMFpGdi9wWlJQMVArS0hpbmR3ZHNjREIrVlZFNWRybXJnRGYzNkF1?=
 =?utf-8?B?cm5NSFB2RkpBSTVtdDJLQnNZeWJMU0k3Z253SWtTeTk1SGZBRHNCcGl2WE1m?=
 =?utf-8?B?QnBMeG9mMWwzUFBoTW42dlBqd1BnM1lucDVtQ3FGalNsV0JiNVRTYnEwWDlk?=
 =?utf-8?B?M3hRdUxoazg2ZEc2QithTDBJb3dWT0k3b3FpRTBpZ2JHR0djUnIzY21hQ2h0?=
 =?utf-8?B?cDh6K0xLQTdzSEhDaWtFc1dpaCt6RFE0eHpUTW92S0ZuY002STZtZ0doQkpF?=
 =?utf-8?B?ZWpiY0k1S2p6U3VVblNBTS9KSFFTYTFZWkJzd0VoSDVjNFJUSnhWeU5FQjN0?=
 =?utf-8?B?SnJ2a3d2M0UweXBjMGtZeXpaZDdqRU9vZ2kwRkVYQ2UrclpldWozUFVkQldo?=
 =?utf-8?B?ZXI2RWtSNnZEV2ppcUJpcGdnK2VtaDlHek4yemI3empnMEZGaUdFc2tLTlND?=
 =?utf-8?B?N05zWXJLT2E1eTBHMTlwYzg4dDBxZXFZRmVMeEJjWXh0dVhjVXZVRmd5SktM?=
 =?utf-8?B?Q2xxUFdXVHdOWDFZVlRnUHhGYVBvSkhCYTZYM2xXVXpLb0V2Z2JSZ3hrWXJw?=
 =?utf-8?B?OXdKTnRyQ1ZJRjQwMFQ5WmNkVUQwNVRBSnNjMGJ4ckx6d2h4VWhBbytkWUJ0?=
 =?utf-8?B?bElXeUhXZ0J5OHY4Q0UrRzRCT20wOWxKLzIrUXdvWEdjM2k5M1FUVlNXaFRK?=
 =?utf-8?B?WW1SaVdNNnFvVHFRUWk3YTlJWWJ2ZC9LVVR4ZU0xK0twK1ZxMlJlb3JUYkE4?=
 =?utf-8?B?ZGpxdldjQWpXMjBUK1cwMmhURUFNTUcxSkVsNUxJMnBmUjl3MUpKYTVUWDg5?=
 =?utf-8?B?R0w3bkRadXZuM01ZZjRsMytKOFdXbkxydlJRUmtveXFML0pwWWZEWVpzN2ZH?=
 =?utf-8?B?U2FUczhXMkdMUnpOK1EwYmhCL3NTaTB4VytsQlZhTkZXU0dNaGx3Ym5JMVdu?=
 =?utf-8?B?YktkbEdPWVFuYkI2UmNZVENpZ1h3SzRSM0xnZ1E3eFV6dHgwNjlHSmVWczg5?=
 =?utf-8?B?SmtDZzh6dTV1MlR1T3RWcmJPUjhFTjJvejJuc3ZTc0VER1oxeFpVd2NyOE10?=
 =?utf-8?B?QVc1V0dzOS8yc3dkcmJJS3NSaytOTnloU2kyZGkzNGlwUngvYzgrOXRHU1Vw?=
 =?utf-8?B?aXdud28wcGdpZ0RCNWlZckJreS9PL0NZcGJWdUwwZForL0NXdkE2d0xyODk3?=
 =?utf-8?B?cGIvSzJFVzU2SFFycDZXZExOenVnYkpKSXVJODdJRDdZZHFrUXZucGNDMHEv?=
 =?utf-8?Q?lrE2kunzWEGRwe+qbGICvEE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3e3679-4bb7-41f4-f86d-08dabce23eca
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 14:55:13.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdRk5aYgvL7srGeLArulfUOBcKJ3K+qSgCSzZaGHJXD7VHyCxAJlvFoQwkm56Fvxcfv/gf3dWAn6NmpvDROAhUE2I7FX/95GY1cR5laCZyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5674
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_11,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=998
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211020096
X-Proofpoint-GUID: N7HoZRW77eQ20m9XQhfmInE46SpFu0Y1
X-Proofpoint-ORIG-GUID: N7HoZRW77eQ20m9XQhfmInE46SpFu0Y1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/22 04:26, Borislav Petkov wrote:
> On Tue, Nov 01, 2022 at 10:45:00AM -0500, Eric DeVolder wrote:
>> As I'm re-reading that message, I suspect now the preference is to just to
>> strike this ifdiffery line in this file and have the code always present?
>>
>> If the preference is actually for CRASH_HOTPLUG, then let me know.
> 
> Well, it is this part:
> 
> "But on a plain simple laptop or workstation which has CPU hotplug,
> would it make sense for the crash ranges to get updated too when CPUs
> are offlined?

Yes, it does.

> 
> If so, I think you want this code present there too, without a Kconfig
> item."

Ah, ok.

> 
> IOW, if this thing doesn't make sense to have on the majority of
> machines out there - and memory hotplug machines are not the majority -
> then it should be behind a Kconfig item which is default off and gets
> enabled only when the user selects crash and memory hotplug...
> 
> I'd say.
> 

Ok, I'll will remove the ifdef line/pair.

Thanks!
eric
