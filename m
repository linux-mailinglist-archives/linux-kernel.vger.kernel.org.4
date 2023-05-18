Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81EA707EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjERK5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjERK5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:57:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75592E8;
        Thu, 18 May 2023 03:57:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6IoqS006515;
        Thu, 18 May 2023 10:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=uXy+F5qNwk3EGIK1ulrX+vvJoAK0wmy7MWSxq/lHqJo=;
 b=GHrnGJTLmQjLKLQxyPIGx2avuO7o6S4qlw2tKa19P4yirBy+4Fi02+z9Ciul43ZmDoC0
 YnL4teL/UQSYL35frcMcain029et1MNh+JXT4pVeJqEr+9oRWY35hbAGoZHsMsxgzKDx
 0q+SEAO0hREjYxV5q7k3EXByxcuuapJ8UYeNH+7Ce2eQHaoV/hln0ifESubS1Ghci91Z
 okM60Xv1XMWbzIRchPL95MePB6ixWEx6wuY+SxZkVqBjEVwLNc1QMoRVPRIQOM0k6Poh
 6bKwMJKDapBJ+R3WgOdXoIvghSMJQbN78QPfggKKk1DMINjeuIL3VaEiRmu5WIHJhUOp ew== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye7mrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 10:57:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34I9g3OV033860;
        Thu, 18 May 2023 10:57:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10742ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 10:57:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaFT/MzeqpqbHOtnb98vfsejUWDDdGNnz0JElu8HVJ9Yb4IblRMEQzI31oH0k42sUqI0bIZuFswTEl2knE4OHC7k8abyK+0L+5PJfMm7CQ3BI3jTIQWByjaLzfn+1BdSu0OBOikhBSFNFWCcLFNxvj1wj3TmRiinUOq4btNPmY9cyOWRk2EQp+baO0OW+4xPfFQ5IF8Vs9zV9kmSxlphNi9rZ0LYkma/eop7Ffp4WyE+BMs8uBZkEAiXFaGGuU172k9189zAOWgmGVoQeWBtlb30E8eW/ElGskLKMimFyYzk0MF24kIJaLhIeNT6iJrf3ZZtXKPUnx/5jZ4Ya9Ro6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXy+F5qNwk3EGIK1ulrX+vvJoAK0wmy7MWSxq/lHqJo=;
 b=DGxPiUDIqsz0MIjVTlVz/Ni+cszN5NiE1tGklBKFoKWiQd9aBZYrzYGcYmPww0T6M7innyN54xUenNeIx0z1XGBNn+bwZ84Jry2qUy1zVdmjTNwDofDI7nGiz3kInDwe2C52dc/+9GnLogLzn7XOCgNqz19aQ1JuQI7h7v6NPkZxJMUjsAEVwgE52LY3QbEz0IyuKrxzuIUOYcs/p6brPJWvP3e/CvR7Sb1QKjlaZxt1CEl1Gj21ovefVLA2lpeyPWrEMaJGfS4tqN5yeFDXsqFBNQ1/QsiFIe+NrLaEunbG+0ZeFCHnhddcyhRB697h+EmEJgyUOsy121vEiRHKpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXy+F5qNwk3EGIK1ulrX+vvJoAK0wmy7MWSxq/lHqJo=;
 b=ytnISeE6sLa5wxeQVu7t9aF7eW6o50UsD9tu3VwbwPWlHfl2PCvG39GMvquFTMlzmO56mSH7AkvOnS6gn3YKAdD1Qw0I683w2BIkzrX+RSsR4PKMTB2yAwue/yTjZvv6nrb2I5cNThMk3kVcizAuegiEzPgELMcmg4htkFpyOwg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4943.namprd10.prod.outlook.com (2603:10b6:5:3ac::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 10:57:41 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 10:57:41 +0000
Message-ID: <74879c87-689f-6a8e-a177-8bde4c9c4e51@oracle.com>
Date:   Thu, 18 May 2023 11:57:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
To:     Juergen Gross <jgross@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, stable@vger.kernel.org
References: <20230511123432.5793-1-jgross@suse.com>
 <yq1ttwbsoii.fsf@ca-mkp.ca.oracle.com>
 <6614f626-d174-03d0-0993-79e6f6169b71@suse.com>
 <9d356278-c826-dacf-cbe0-79f512b7970e@oracle.com>
 <60aeffe4-b31d-4ea3-d4ea-f50ae25e0316@suse.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <60aeffe4-b31d-4ea3-d4ea-f50ae25e0316@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0505.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4943:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d68962-7cf3-4f45-8ca5-08db578eb3a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbEoUbamS81OI3B5H6Jp7Tvwog/CceRty9J0WDaKibRcrvaTVy8n3lIxykSvUlcN4rYW7M84QxSQLQn7GNrri30AVXkU67ytr/h4sLvofNMoQfNBIfdJ6cPeBLxno5kPsCnykyZB+DoXzkvUVOjJk/ScdgMAfm90vAFRyLIWtia58UkOsTBnT0zeTBQLGlgclBsg2JrnCqYlxpOMKOJIvPYwb1/Ka2Gro/X7KYyNW4v8qj3svuWOIObhGUI6BTRevrnWIdwHlEZQv8KR2k0rtr1oFotahyVfE9bJPDqoUKy/9pW0EXT/NUGPqcscHaMi5UCjgAPJM09kSX1p5hkoMAjE6cSRvQaQSeTqa7R07tNgD4bgpiT13qgcWYNfrH60LKWe0S/Eftfx5jW5BRrTNCSfcgI286p1XjDriwK6kskEDtlzshAXzWMi+jmMZHHKvcMkonguH2oJVbfy9Z4hniBj76DjFICaSXFuEnaTSK1n0V4o9WHuO+q0WMYF9iOgwFVW8GWuBGio/DpSHulBmOIW+SN+lZkJlSOIo/V5gjQeJyjFgvHMUIqpHEZlK5ItVtqNbvgxW/jlXNHJli65QR2KAGJwhMeHC56ctUAVD0sufLmeosFtjHJwuz38NAoVFm44Wwe+xxlWDp7fSk6vow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199021)(66556008)(66476007)(4326008)(31686004)(6636002)(8936002)(31696002)(8676002)(5660300002)(66946007)(316002)(2906002)(478600001)(110136005)(86362001)(6666004)(41300700001)(6486002)(36916002)(26005)(6512007)(38100700002)(6506007)(83380400001)(186003)(53546011)(2616005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEJHOHFPRzdjMGRGQ3pLSnBlYUt2a2E1c28zbGRUcC9BbXBYUUJLQTFueW1i?=
 =?utf-8?B?N29UYkVnOVZWWWV0T0g1TFBZV0pWUGNwSzRiZjBXQS9qUWpZWDFneTZOYXRU?=
 =?utf-8?B?b1JkQVBEbFJnenZlWS9HVXZISWZIY0lmRlJzbzgrdUplSXJZZ0puUUJ1cUtF?=
 =?utf-8?B?YS8zWDBtRm50azBqeTlVVEZVbVhRODZ6N2Z0TjRSb0k1NU1pL3U1eXZuaFBm?=
 =?utf-8?B?Z3lrNmFJSlZqNjFQRitxc1JwZXl2Y01BalByZFRzL21nZ2tsUVVCRlhpdUdY?=
 =?utf-8?B?azFLb1R5TFcvQS9UZHQ5ZURHc2RaRWVHdVAweFh1MHhNaHBFTXFqUlpkbzZj?=
 =?utf-8?B?TTUxQk5ieFRpQVp2Q3dnNm9aeStja3pzemZuL2FhMXNLT2JYN0QzM3VKSUgy?=
 =?utf-8?B?R2FwUFdCL1c4cUxhUk5TdE9jaDlYc0JPSjZaa0t2RzZDT0MrMTlGYy9ndTVZ?=
 =?utf-8?B?bmZPZnF3NmJacnNnS3ZkOUtnaWhpZFlwS29QdUNuSUtWYy9Tb0M1VWhqNVpF?=
 =?utf-8?B?SkdGTm9nTjNpbjhkU0x5cGlaTG9DeDBCY0JxMjJOcmxwL21MT3ZaVkJ4OEpv?=
 =?utf-8?B?c1N0VlllOURhUWkzVFl0SG9LV0UwWkNENm9LTTVVUEwxbnNnVWgrbXZwdFBm?=
 =?utf-8?B?ZzA2Q0JURk1pYTRnUSswZnNpY2lkZlcyOGdaSHlROTF1RjFzaDZFMWJTN1hy?=
 =?utf-8?B?b0dMZXFRc3N2SEcwSVdxbWNWakFnMlFoMjg4ejViQjBqRyt2bTVlZGFDNGFW?=
 =?utf-8?B?NkdqYlVqTmp3WGZpRXJPdldXMGNkMk8rTks2NzZoSE1YYXpTK0NnVU5UclZJ?=
 =?utf-8?B?WStocG9KQnd2eVN4ZURnSUE3bWN1SUNHSUZYdUlEODVUVi9rZTZNOVd1UkJF?=
 =?utf-8?B?YmlENTM5WDBuSFZvUmxlV0ZGREF6MmppTkJPbmFlcWdUV0JHSDY2Z3BOcHZJ?=
 =?utf-8?B?c2RQY3NJV0N4RE82VVY1TjJFUGtOVUltNWtVWUxaMkNsWVlMY0tYOVhyTS80?=
 =?utf-8?B?SGNEUisvbjNJQVRVaFBpMDFFdnlIYXUvWXBiditra2NyOWttcVF0am5uamtU?=
 =?utf-8?B?enNsZ0dhQXFZNXNyUjIxdUxEN1NKd1p0V0hTTEMwd2prMkluRlhickd5M2F1?=
 =?utf-8?B?cDlHdk80ZnRIdm1INXJCaEM0OERLSDdKTjhXVDlLbTZENU11b29hNzRKaG45?=
 =?utf-8?B?azQyRkRJSi9GSDBqMGdsWU1Uc2V5S2g0TnJNL2FvOElDZE1PNzNlQUwweGQv?=
 =?utf-8?B?TitxZGdwZ2ZIMFBxcFBKY2tCNk9zeFJCT0o5b0VUWi94cUJEb0NSOVQ2NzJT?=
 =?utf-8?B?b3lKMXlQV3pBLzBJZC92TEpCcVIxOHYwbzdrOW5pK1h5NUlTTTV6RWxEY3ZG?=
 =?utf-8?B?VDk3Z2hjMjZkKzExdE5HWEl5SFV6R0lQVTIyZ1hmTkdIV0NDcnBPVzMxUkNF?=
 =?utf-8?B?aDRwZVlkcjJ6OXF2WTAxOUxZeWtHZkFTQ0EwQW9IVVFTODdCM2NSYWUxVUhm?=
 =?utf-8?B?SXoyUGxuMWVFUEJhMzdmOEUybHRFK2ROTDFocDJEdWVEVEZkUVFEY2l0R1Ax?=
 =?utf-8?B?LzJua0VSek1Rd2JLbmdpU3FjSHlXVnZpWTVYMkJtT0xzL1FuZVJPQUN2U1Jl?=
 =?utf-8?B?aGZVaWhzSGNSRUYycVdRTk1HSnVzSVAyK3Nhc2NPbzU0UTIxZk02MURuTXdi?=
 =?utf-8?B?S3lvSllOeE5mT3F0aXFKQ2lhdmlmVENmZjZCcVZabHk0M1NjTnVhSDFQWWda?=
 =?utf-8?B?ZlhndkhSQk5SU29kaURKb2xKS0cwTmxRWXV4N2hsdWw3NDRHQTJGVC9HSEZr?=
 =?utf-8?B?NUI5QmtDVTVSQmFZeVE3aXpMejVCV0NLcW8wWUc0MzQzTWw2cWk2eGp6VEZF?=
 =?utf-8?B?M2xVekc2NGROTEwxekdWWHQvc3UwVU1oeVVjSlZJdHZ2QVd5VDI5a1dod29S?=
 =?utf-8?B?MU9xSEkySUMxVEI3T1hwRjBaOXZHWU80Q1E2d1p1cVRxQ3AvaGlRN2NJWlJV?=
 =?utf-8?B?TmY2ZXRibkVGWUNGM0ZtaEpHS1ozMzNzaGcxYk02ZU4zeFd1U3VjdkhXRDlt?=
 =?utf-8?B?ajV5bi9DTk5yb0ZnbHY3VGIvUTQvaEIyOEhNT3hLV2FTeEVoN1kzRDBvWG8r?=
 =?utf-8?Q?T71TIJQ564ENerhU2NLr9baXr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: htWoGPeGRc7AKw3RUbx3IdY7Fo1icGfHjpLnbCUrHc2fbDjNjMODzmifUOTU7Qw80XQGXytl6v28D5WAnoKFV2i7gZHLtTVzrkyd2h2386bNqZh+1ESn9LHC4Ym2147WtaZPfYqhS7KQXZjjaHGv24b5tnjKaszPkmAxINosAbFHUzMamPtwtqowSQG5CVT1liV1cx+D34kuusWoIkjLnaG2LenrtJIJOoRFOhciYZFqvxTXYwJ9DM4ate4elxOm0qVo/d+A51a9K0nKJ9vHYt2eRKwliGu4vmLuZkWwlrK5vzamudDzHOLmEl4xtl+Vt7oPDs9BiXb85no4fyMr1pKIyDng07mUWFo+bXb8YAIv7xAmMLetTGcmoIqUeTK1hXr0p0ffqYJasrDUn/jKTJ6+/ZgZjXHJgDixhVYDBc5uryvZ8kmKR2+q+YdCF6xwxWkM5gVUvkUTreQMe5rVIXIaTSWLZGcBE6hSZlgpoBbyZougN9MTH2wn4KkhK3PuHI5VNwh6XBFZxHgXaTUwiu5lEmSkI4S5vBFF2qE85hnfRC6e1jn+bYEdnTpyOkCP5mDOczk2wVvsAgEGIIBB9S7a7Uv+x2LKLinH2sE2LTx8pREh9S9pQdwGPWNXBFU7A8Y5CVU69Vvtt5e17VVNggmqke9QgOFIwwRBzleNVvsAWuF+1wmrL+6kq6b95KuEEX44HfIYSWrRgeBjdn4qnIfxHKe7oCni5+ipO317pxhxXM+48vypGkv6ixi5a9tzXSNp1z4LI+OO9NKoiMa7zSTcWwV84gwkzcwdou7tEUsFw8BFA7nM1GZzmuUh8Rm/uMcP0kImY0hPGwp4QQfyEQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d68962-7cf3-4f45-8ca5-08db578eb3a3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 10:57:41.6399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oT3H21otOIDGbWCbTtMd5w4712MO7DbalQiVUf2OexFtzsIhqRJ1kSnXSvABg0Y7Fp6W48joJAUZeAvb3JzAsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4943
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_08,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=863 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180084
X-Proofpoint-ORIG-GUID: 1f9B7HId8j9ntUvQFPBz1wLXOhXa_ulF
X-Proofpoint-GUID: 1f9B7HId8j9ntUvQFPBz1wLXOhXa_ulF
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2023 05:53, Juergen Gross wrote:
>>
>> Is there a reason that callers of scsi_execute_cmd() are not always 
>> checking the result for a negative error code (before examining the 
>> buffer)?
> 
> I don't know.
> 
> I've stumbled over the problem while looking into the code due to 
> analyzing a
> customer's problem. I'm no SCSI expert, but the customer was running Xen 
> and
> there was the suspicion this could be an underlying Xen issue (which is my
> area of interest).
> 
> It became clear rather quickly that the uninitialized sshdr wasn't the root
> cause of the customer's problems, but I thought it should be fixed 
> anyway. As
> there seem to be quite some problematic callers of scsi_execute_cmd(), I've
> chosen to add the minimal needed initialization of sshdr to 
> scsi_execute_cmd()
> instead of trying to fix all callers.

ok, understood. I am looking through this thread again, and you seem to 
have to repeat yourself - sorry about that.

So I don't think that this code has changed from commit 3949e2, as you say.

I think it's better to fix up the callers. Further to that, I dislike 
how we pass a pointer to this local sshdr structure. I would prefer if 
scsi_execute_cmd() could kmalloc() the mem for these buffers and the 
callers could handle free'ing them - I can put together a patch for 
that, to see what people think.

@Martin, Do you have any preference for what we do now? This code which 
does not check for error and does not pre-zero sshdr is longstanding, so 
I am not sure if Juergen's change is required for for v6.4. I'm thinking 
to fix callers for v6.5 and also maybe change the API, as I described.

Thanks,
John

