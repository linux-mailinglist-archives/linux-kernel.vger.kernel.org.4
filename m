Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA09E74DF29
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjGJUYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGJUYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:24:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A47195;
        Mon, 10 Jul 2023 13:24:18 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36AHpHBT028064;
        Mon, 10 Jul 2023 20:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=wNgCJO5XgeRQClMjgAE8ZvSvLNS/fwY1eS/ecPuk4Do=;
 b=i0tuYPp7kNmurN68bYlhF9qHYjWoKSZom3iZJGe/duMvFQpXbaARGo0Tq+l7IrVgBxoO
 CB7uDudXshJVZ+tN/NfqSo8jluN4rkCLrEBhOV1bX8yJMZ5CrIftLUfM8G54pOxaZ7ms
 IFlBFiDpgpHQW6ds0mJJdJ/K74pKqCeqg9uK2qKRqYXGWxcKavw2BcG4BJxpRbVyESUB
 3efXwq3g3qhAKEIYwNyQ3o9J+7pD/NpF23CTPKmtiNsxGacZCpjkvxGWNPG6AVDl0XXP
 ohYbkCiyXg6c9C2IiZnA+v6qFJObMOhNCmFkHSQsPDncQ8ondwbZ0NGUNRySnci345QY ZQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrfj61c37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 20:24:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36AJCRGw033055;
        Mon, 10 Jul 2023 20:23:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8a7nb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 20:23:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5KxQpntIaMALEaHg6mSfJ9Rl2VDodTkFKFj18BNvfV/m5fJk1x9CmxKYWrwbtbHDl8Pki3CPiUQL9KVa4ZIVRHpx94UaZhnBpYhjRIEDcmxuiPapxtk3WB5ZPQPf3Z7XqjrYfXKU8JGLgnq0Q9x4ELH9e+V672JsbqPyn0qJk759LyksaawOqMhp9AbsfBJ6vYiPMmdQr4fhyKdwIOIgLo05A9aEVW0l26bmIQpWzrMPg1gdBuL8BzMvkUCm1uXK2zRF8Ny7evCnRW3emAh2d1r/xL4Bwy3U/j8ZzuzQDMZKaLs/ywFg6al/UhZrvfHxOCly3bLkwJiv+SjRQfNrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNgCJO5XgeRQClMjgAE8ZvSvLNS/fwY1eS/ecPuk4Do=;
 b=EiK7pvvHpbgepNvLTVjRG52Df+fM7Q2pzvGvPl1HCaFdh2zcFRJmliG7Cg0mstjHktO8v5If2+sGZZ8E6odoivn9k8v5COW4OcHPJTZVUuNPRZ108m5BM3QdZaGbD89OUVHWgbwhernwDqtSky4hbJ8vPhDTp1xfru80dickbZEDhXVHwKF/J22SXhvax9deRQoMC7/S9D1PMeZadQfnOpFmiDiF0BSTrJDhM54JJE3qTwiGsix0cjyodO5wupKkUYM1DhwZ0KZNC/cueSWPyY3mD2LggmF91J2a7AkiQBRrvVLSk0ylqwLhVKXt6otmPB9Adc7Ya+LhZacjdaRpPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNgCJO5XgeRQClMjgAE8ZvSvLNS/fwY1eS/ecPuk4Do=;
 b=l97FCdOY3XmhQG9oWFY4ediBbaAv7GDjb0rQK7D0LfBxmUWPKHhYckeTanD3sEoTFvQP9BUvPX4hoJrom+vGvtx0FfnuwvzZ4Biqfl9bcLGeksZtIIWfHhtOIQt8CJtIQHnowjfjwm64F47za7a43n0pEQKjz8koN8keWZgQo8U=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB7343.namprd10.prod.outlook.com (2603:10b6:8:fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 20:23:53 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4c83:52fa:a398:11a8]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4c83:52fa:a398:11a8%3]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 20:23:53 +0000
Message-ID: <8a848504-6e4c-ba7a-4777-3175c1fdc6d7@oracle.com>
Date:   Mon, 10 Jul 2023 15:23:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: linux-next: Tree for Jul 10
 (arch/s390/kernel/machine_kexec_file.c)
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230710113814.4a4916cf@canb.auug.org.au>
 <9536c8ca-a0f2-c4be-d705-2ac1054ebf7d@infradead.org>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <9536c8ca-a0f2-c4be-d705-2ac1054ebf7d@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0049.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::26) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 22414417-a099-4d71-af67-08db81839420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kj5akI7rig6QVL/CjIN0XnLxDb3XtR4PP8IqF9oib7xUGgzI+3AumWQHjoE9j50RCBJC4oiwJv/QyfsUuAydIEjoKRexXrLEWHrPYyUNUiV4XTb9cBX/f6+EDKco/zlTnEmmcZx+mHCFS5PTsSAgjNRJnPWCVXcMHVs/C2Zs8P+V6UEDxKpqq40MIdy6ba7MpkiUrxGDcw9mJvuU04qDnIgpP6op/v/QLxYKInC67tN4opbrYT7pmNtQzlkkK/HPy5qOu3Kw7NIKpWwr1WfBBip7+G1K/i/Ucb1ESaKWFOles720B+y4rmvk1ZeRqJcHlxKN2q8TNxb6H1E5RvsRpjjDBUOGIfZ+7AYboCfTupBR/wzJVO7cfuzbmJ/LsjBpoN6NjC3FYaslH/Q7GV/peeyKmNc4vt/y5rE4ZqWeR36CASwfgkjZbkGZHwBFbld/Dk2IUPk+mHatzyLA3zUEVUh4Yyuz6Gv9Fy2nvK/cewAzkXBbiNJwkwDzMXE/hCXritEcIi/AHbnjQY4ux+1QEL3PblgjakQMWYDp5NdoZvBrE1T8F0UhH0ZD6l/rOoOV4d46Thpqin9HpYPBmOuQKoDteMesDXUZFUbE7qEQF//9QqQHDIIixbK+kLLYoxO4axtA9/LDMOBDVXaIlNMNAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199021)(6506007)(186003)(6486002)(26005)(6512007)(53546011)(2616005)(83380400001)(4744005)(4326008)(41300700001)(66556008)(2906002)(316002)(8936002)(8676002)(5660300002)(66476007)(6666004)(478600001)(66946007)(110136005)(36756003)(31696002)(86362001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RytoQUlpRyttUytqcENYMzdqSXEzQXl1ODhZTzN3OHFJVVN2TFN4eUN4cGpQ?=
 =?utf-8?B?NUxOaTFwY25raDlhWXZwQ2wxNWV2MHB6YkI2bGlXSGJOQ3NCeUdkT0twQXZM?=
 =?utf-8?B?TnVoaTRURDQ2aG1xeDV2Vit4UVgwV0dHNVkvbE9WcnJIMUhockcwT3FBTjJ5?=
 =?utf-8?B?YUpXVURwRURUUFNQeVBFVzFITldqV3hjTTIrbU1yQU9DRjFObXRnNThmL0tE?=
 =?utf-8?B?QlM4SE5UMmxoUlI1MjJWajFObWFQMlZGbFZoNlFRdXpGQnRsMkorZVVGa29Y?=
 =?utf-8?B?TG1uem8ybFhQUkVtQk1JbW1EWkJKYlRmSm1lQjZoNFJqdDJFdklTanh6TlZu?=
 =?utf-8?B?aXIrTWViNlFidE90am9CNm1yUml6WkpNU0ZNM2U5TTFyUVM1V0JxcjhQWWda?=
 =?utf-8?B?RlU0U0owQU1xUk1hcTR6VHllc1Y1ZTVWVDBzc1RvWjltZmJVaGdGZG00K3Jo?=
 =?utf-8?B?dGVEQzM1V0Z4NW5vVytVNUo1QS8vdlBETU4zOENhWEJnRitZRHZlUWh3eDJJ?=
 =?utf-8?B?aUxBSHVickZhbEE5QUF0RkVhejVCVWxVa2g5TjF1UjQrVmtFNlJtTHRNMWJF?=
 =?utf-8?B?M2pTYnVvdDFpaWNYTUhOWEU4NDJaK05HemhIWng5akRJTEQwTGNCOWNIWEZj?=
 =?utf-8?B?MFJLNGJNWTdLa3k3YlBCZk5BOGxKMm5lNjhRaXJwenJrOGlROFZ6YmNRSGRy?=
 =?utf-8?B?MWNGOE13ZCt6RWgwNGVxMWVkelNjeWtzYkcvTDd5R1Q3ZmYwZHh2d2F1Z0NE?=
 =?utf-8?B?ZXZxNnNWTTlwV1l3aUVUeWFLZ1VxeHhnVXNzYThaUkF4aEZzREVhdk40MWla?=
 =?utf-8?B?RFdHMFVxY0NoY1YwQzFRVjhJRjFXSng2L1EwTVI0dWJud1ZwWGYrSXAxbW9v?=
 =?utf-8?B?S0tuYkYxK1pEMWlCQlgyeHA0aGpCZGg3ekUwQ1RvbExRaGF4bk1RVnRGTTE5?=
 =?utf-8?B?RTg3TytkdjZEblVCeHQwL2p5d1QyQWhiUlJxSW9lTFgwQmlOOTdyNmIrZll6?=
 =?utf-8?B?MmduYjlvbVpiNFFaTDdIalY2YU9PWng2aSt0M2xWTXRVYkFRYmtJZGxDcTlm?=
 =?utf-8?B?c2l5bHM5eHRFanZmR09mV213SllIMzlFSjNnWEV0UmZoMzBhUXdWcE9lc0w4?=
 =?utf-8?B?eFJrTGNXcEt0OHZleGNjV0tRc1FoOUZlekxtQjBlZUZiZkZRQjZ1N2dJUktD?=
 =?utf-8?B?YVNxTFBQVC9iVnR3Qk9EVUJBamxkYWs1dDVORWd0NEVJano1THI0UXJLUXZ5?=
 =?utf-8?B?am5kdTRnajdIajJZdjNQWmh5SVJyV24rUEFCb0k1bDdEZTJhd2FkOFh6WVl5?=
 =?utf-8?B?MWVxeHZCSi9HQkxOTm9nZ1hRdFFxRUlTSmFjZS9MMzlFd1FFa2FIa1N5UDlG?=
 =?utf-8?B?eVdnanlyVkplNU81RWNZa21tV1lQQmdTQ2xGL0JiK09peGhzZFgzV0p0a1Q2?=
 =?utf-8?B?aGlELy9PaWVRUlU1T3BRTkhxbXBUV1doWlNUWlVlcnJ3UkYvMDNnRmcycTFj?=
 =?utf-8?B?ZCt5dzdRRXdpUjN3czB2UllTcC81OTVLMGZTNzh1T3lJZDFzR1ZpQzI3SE9s?=
 =?utf-8?B?eDc1QjZuOFUzbTJiVDF0cGdWQ1NEVDJPSnJ0ZTVzN1psWVhNR2duQWF5U1Fz?=
 =?utf-8?B?YmJyek8vRzJnWWZSNTJydzJtM2xua0VjWUsyQ1V4enoxZmQ2TUxVTklEWXhH?=
 =?utf-8?B?bXZvVVlHb25VTm85RDgyTUNHWXZrZGpXSUxhcU9oVDhjaWZ4d0FrWkVrTis2?=
 =?utf-8?B?K2hnTW1LazZiUUlka2x2dXk0WFZybGVUZGphZVpYcWdic1hNSmlqRXFtcFVn?=
 =?utf-8?B?UnlKS2JZYnlhV1RQRHdJQi9tR2lZRVRIM2Z3MC9wOFE5ZllTL0w4ZllLek5m?=
 =?utf-8?B?MmttTGNZU3QyNVIxcDB2ZUhNWWR0OG5iRFg4YW5uaVRReHBwellTeHN0MlNX?=
 =?utf-8?B?b1k3L2hwMzdEaTkyWklGZzBhMkpJNk1QVFlrRHFEUEJHZkd1OHgzelFUVklo?=
 =?utf-8?B?UnJIaHg1ZVZpRnBsVGc0UW5EbFNRdVpEMU8yc0c4dmlKYktyUmhxMG04VmQx?=
 =?utf-8?B?bEhXT1h4aVBiNGp6NjRPaXQvdFFHYXBoNnlCMmhuZWNYbnY2djVQSjR6RDVB?=
 =?utf-8?Q?ghL5fcPOUu1lnHqvHtv2lpShq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vPlDEQiLDAvuzAlzHnbhoYfmBhI3saGCRaUo2BChClcRIAyKerv+QDA6am/BX20FaGzYncEsscbOwoeu2Yz6tuR79mB+iHRgKp/5zRQZ+KBzI/YTo/6o2C9i/qLQ4KcykI7mXmxvMFDOC7zedHpUXS0llHgK56ppL2XDDIGfn18TkeT6lT7Q2PEICaQU9E1K+R4bKU/Z9+hxkX+di0DMY12WxGvirGDc4P6vjuk3jfZPBb5mVgAsKiGbFj+XCiCWpPUHrY9zoOlPWMxfve2OvlKb53dXVMukFqLgLR7YAaAi/T/5DEGlu0tKvdJJHlLlqP2WAH1SRhj1ZXNaG2p0skOnNrotZbWHRwb6/1jFeT22iLULOzYZjhGsKiqnmZwGBTclfoqXBmdUEawxeMtRCbijbKxNvTv9t/jPGss+VyAqNUqVSTm1kIATLfYae54q9X/Xlugje307zpYS5KYuIAflxNCA52mGAaD4k9kI427J23eUGhAiS+/xO6es2v6GwzNnL++548OSxVroK3UQEVzwDlTAYvTElYknf+8e3RdNWcn0y1kjlt7aUpe7uu3ynR6P4cNiEGnYqJ6eI/7R+sudDGPHfUurQHWkhUpZ0ZpdQYb16i4kEcnTjQoSI2szltc4iXg6OzaLH9XYYiUUJDJbi/zLG0nuz9KnCpRpr+KPMvNt2+54Susn76BtYKqrpbAXfKxcT3brC93WlShk/wbfDevviK50iPgXQTrrqtAfv2zj/oHyAWKaICPLRpy0ZDQ5PBOw6RAya+yhFSNYdsxm6bcmHjk1A442ihWfprH7/2V8rxJVozgx6TjsQyQD/KOnDLmbCpAdq2Ea9LBI8A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22414417-a099-4d71-af67-08db81839420
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 20:23:53.0838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLWzsaL5hhAnwDBPZb/YpLOThhWC5QTkHD1gYjsyNWdheznfH61doGZa+47l4dHZB/uMrGOgduFJAposxu5qwQypPPo21VDqvJxHdRRiLG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7343
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_15,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100185
X-Proofpoint-GUID: b_AcfBPF1hEak7PKqtFTavhLmA4kGF6l
X-Proofpoint-ORIG-GUID: b_AcfBPF1hEak7PKqtFTavhLmA4kGF6l
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/23 15:11, Randy Dunlap wrote:
> 
> 
> On 7/9/23 18:38, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20230707:
>>
> 
> on s390:
> 
> ../arch/s390/kernel/machine_kexec_file.c: In function 's390_verify_sig':
> ../arch/s390/kernel/machine_kexec_file.c:69:15: error: implicit declaration of function 'verify_pkcs7_signature' [-Werror=implicit-function-declaration]
>     69 |         ret = verify_pkcs7_signature(kernel, kernel_len,
>        |               ^~~~~~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> 
> 
> Full randconfig file is attached.
> 

Randy,
Thanks for this. This appears to be randconfig testing against linux-next.
As of right now, linux-next does not contain the v5 that I posted friday.
The v5 posted friday was picked up by Andrew and over the weekend no fails
discovered, and the series currently sits in mm-everything branch. So hopefully
it will appear soon in linux-next!

Let me know if I misunderstand the situation.
Thanks!
eric
