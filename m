Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D686ABA3B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCFJoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjCFJoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:44:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F070023C7F;
        Mon,  6 Mar 2023 01:43:41 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3268IiwN031823;
        Mon, 6 Mar 2023 09:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=g8Db6zORaTq4hr/scjMDQC8fvo2Ejxoopow85nv+ixY=;
 b=FG42g96t7FecrVbqZj7m5FVhi8e1LxwOpbKbN1Pacs/8Gf51QjpF4K6kyQTEYdqYtyLE
 wfSFaBmhp+EDEgnJic8DIh9Nfv4/3GevDMGRFbfNL082FbP1NF1RyecPtW9NPXdf3PiT
 X9Dq2G1PysZTrB5m2l/y3PdnmXRbG0sCvsgD34cEdDnk2tcHaKMA0IycGFlH2lkSZARA
 mthmBs2d67MuH59vM/AJOSjuN38aLNvX2TYveZ06zAPuF4ifKvaH8zHrFOPnI81FpUFn
 eRi8c2dU4wZCssaIXyga8z+q5Ubs2iiL2yasJc2JgDqVxc1iundHm944OHjHeH45zTyF ww== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4168jf8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 09:42:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3267M8vJ027227;
        Mon, 6 Mar 2023 09:42:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u1d8q31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 09:42:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0UIXEWrW+8ByIhryl6p7zdRiE8JX572twcLYrVSKGZoCIGvMmnuDwuhCMV1My0O3jMcbEH0UK4Wun/aAm0z17GQrYdcCr92727EOZCrK5dG0wdKcbDo9+Vpt11dvc9ai3/09TPfXKg4MQ+VRXuhVWkwIlFrWlP/A6G2xN/pRUFwmgoRVVep4QsZ3zdrx4bDOePJfkxN1EHXdsE3p+x3QyFjEHASAgsiiMukXnhVXnWYWXbaVwWU93LIKBTzdLAQQ7FGiE+UUr8Bk9+DHRymMJwIot1kNaNlaSQAMUyz/hQog1CReEvJiECiAUgDblwXO37maacVTF5p3aVXjEa1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8Db6zORaTq4hr/scjMDQC8fvo2Ejxoopow85nv+ixY=;
 b=DcNIKecXZDlEoam1sfTCZduyAJrVBWiycCYorQ94cbkkM+Zam2zoKSh9AyZXs/9C8s1QCWwTgwi5m5t2Oge7yBnINJVHaoqEGA+IEm02iybmZhTFpfKNT3hWOYlZqWwEtuBNUvbzpy0LtFQWTh+7ZYIzcJ0kcgXW7arZGcfmqcsMZ5Odgac8uQNK99E/hv4xa6MOWwRu1B+A3HiFSjwll7Q5jw9UK5eYL3N7nGVrb0HfuTtUJwLcFEwo6NLY+0q+8jzIuxfpbL98YHghSGBVnCGXJhNJtQ0UgL9bi02Ias7J3fcyN6qLavRGFWUpRUo6dRM+RmC903FG+Aveu7mZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8Db6zORaTq4hr/scjMDQC8fvo2Ejxoopow85nv+ixY=;
 b=L9Lod89WS48qVBmpkFCtVcyF6Tlaz/3XszDfUZ3313r13grA0ovbguxLt5bjNVcj158XHqjlT/FgbUY+oNfYXC9Ot1M76R8xv/KsbqogifyKFqZwwS5iHXSjrpe3unSSVq1z0pRkH5/XKrWhFoLJyL61CpWT7TkAUrHwC3Hxwps=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by MW4PR10MB5725.namprd10.prod.outlook.com (2603:10b6:303:18b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 09:42:31 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a0c1:677d:5394:bf43]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a0c1:677d:5394:bf43%6]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 09:42:31 +0000
Message-ID: <823bae9e-1458-3654-bdbc-67d8657cd865@oracle.com>
Date:   Mon, 6 Mar 2023 10:42:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 0/7] Documentation/security-bugs: overhaul
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Solar Designer <solar@openwall.com>,
        Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org, Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Security Officers <security@kernel.org>
References: <20230305220010.20895-1-vegard.nossum@oracle.com>
 <ZAWB5kwcG9IpWvE/@kroah.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <ZAWB5kwcG9IpWvE/@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0147.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:377::7) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|MW4PR10MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f7c0ac0-304c-4b62-635b-08db1e271b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sbnaSvPK+M3IP6FUwqZf7H9q0aPwXODNcOXJ7ECJQU+mOKn5VmnvMrdR+9VyIHdRFpBwB26KxTZ2+15JNTuPMOPvIU2Fwhn5XGa9TTxN744ZcapuJXQ/OG6hlzFT88yNuEOxPyM0/4ezL4cozhnXSqjdl29OAQqkMd304VCkCdGX2L4JdkXOh1AK69dyw64u2IDix9QSz2Nio30Vd9mIs9SJxB1yLYaJExCwDP0U9GF1LF09KMHNFlpIYHZNRWOEYahO8IH7nj8b9q97heHu2EE17A6VDQhrCasMyLndac/M576cZTc4+BIhNmlSU/dJSQ+TfOFUTm2NPQgHpa6Zxw9b9FyPK3Uj9xI8n1MwHfDW5kFlNvvcQb4S9QWxVaxkdDognIwge334lH78bP07RiU0dU30c2vcnmEK9Fjy0zW3ze/7J3qNwK16G0czxzZRAx2miHt5yhE+sRR1joBkRabpNXoYKQbc26OH9edTYDydKA6vn+V+FH4chO15p6jffqUrI957n75aithBHCeP5JecvwpL3jUz/DOtD3CWsaBynBdhVH528WM2aP7xuMTU3s12rHGY4ClZWMBWkmztSBvk2eqZKc8xfpkGrWzkksq8NySpoz4IE8e/Ihsp7v59ED1tCMHuA0ot62TyPUdp0cCS8K+CvdcZIOykYVldvEW8j2u58G3vntYx2jGNBh5D5T4hFc73llTG/8ekihv6EZCF8Dp4h5ydUbmE/mR/hQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199018)(31686004)(83380400001)(36756003)(478600001)(54906003)(316002)(38100700002)(2616005)(966005)(6486002)(6506007)(6512007)(6666004)(53546011)(26005)(186003)(15650500001)(41300700001)(5660300002)(44832011)(7416002)(66476007)(66556008)(66946007)(8936002)(2906002)(8676002)(6916009)(86362001)(4326008)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elBscnNFYks4SFVvdFd4TDh5NGw4QUwyTm5VRUtpalRKMG5xd2kvMlBrZjlu?=
 =?utf-8?B?aU53cHBVUXRobVFjaFExQ0JjcC9aUjdYODJ5MmtBWVNtSmVkYnFNUmFOc1o0?=
 =?utf-8?B?T05uT2xRZlUvWU80MmkzWTJsOWs5TDNzRVdFbGV6a0E2TlJtdTRrYUQyalJi?=
 =?utf-8?B?M3JOVW1ONktTV2tHSTJGejdPZ2RFU1lseUUzSDM3ZUNjUGFwNzJCK2FLWFFp?=
 =?utf-8?B?TmIyWmk3YWpKSFZJS3M3VVc1eWYrMHgxYzJuNFR4OXZ4YTNkR3BudmJzUXIz?=
 =?utf-8?B?QmxBK1FlVWt0MGpEQlE1M0lJcHFxZVNLYnFxMkhqc2NwdWlEdzFlY2YraUN5?=
 =?utf-8?B?YVZORzhLNHp1bHB3dzhoV3F4S0ZQUHFUTm9QYnpVYUkzN2VSV3B5M2owallh?=
 =?utf-8?B?OTlSa3lDYUUyRzdPUzNNbU93Q0hobS81bzJVSFQ1WVkweWhGYVRKeXBlUXVZ?=
 =?utf-8?B?Z1Z3a3R6RlFxR0ZHeHpPYStGdGw2aElzbCtpaFJBUlR5UGdCeHhEL1hsc1Zv?=
 =?utf-8?B?WlgvazczUkRaOXF4b2cxd2FORTl4NzRmTmh4emJNbTBZU0drUnNHM2Z2Z3Yz?=
 =?utf-8?B?SXh3UzQyaFpEL1UxcXhiRWJFTGVmSk9CeStzOWV6dHVsOGU5Q0x2K3ZMZGw4?=
 =?utf-8?B?elJZZDZkeWpZMUhrTmxGSENBMDN2cXJHWWY3UEFWeStCdnppejAyL3BpOEFm?=
 =?utf-8?B?d2FIbEk3dDNRemNKUXhSb3pXR0hDYUMwRUwrVCt2K015M2NOdlJoWUpUZkRx?=
 =?utf-8?B?UVYxTmxkSWQzWUZ4Y1VGN3ljRDBRVG9JNzVMRlVwR25DcTgvYjRCZUIzVkFQ?=
 =?utf-8?B?TEMrSzJIU1U5L2tQZ1VYZkhoWTR6bml1S09iYTVUL1ZwYTM3UTJFUERyTmJF?=
 =?utf-8?B?ZkdHTXZxellBK1l2dzJJWWRtbkF4YlBpYWkvLzZVWlkzSHh5WnJmS1BsQzdO?=
 =?utf-8?B?MEtJejdzbHR3N3BIR2NCa1ZpVmJ0TDhSYXlUblNiVW1zZnUxcUdGcW1GTE1h?=
 =?utf-8?B?djREdmR2OXJQWlFPaEpQV29YRjY4WHBTdzFQRG1CZktjM0E0THZNTzBkU1Y5?=
 =?utf-8?B?VHhBQ1NmSm9jRURCWVBQZkthbVh3aEdPK3E1SkJ0cHFKbDBtRG9uV2RYYUxC?=
 =?utf-8?B?emlXS2VjMUpZNm8zYVlmUXNUTXdnVmw0S3dkUDBPOEhxNzAvSzVpQldXTHRY?=
 =?utf-8?B?TEk1aWZSMmtMek80S0hTSDUvdWJLUWc1Z0c5QkxZYVZPRUgrbGswSUZ0am9J?=
 =?utf-8?B?ZDRmWlloNTdkQkFMR2t4NGtHVXlMVlVDVzl6bEhrNHIva1VqRkRNcTIvbnZ5?=
 =?utf-8?B?aEN0Ykl6TW9BWFh1RE4yQVY4bTVVUU94NytzTnRvekVXRThZTWo3Y3c1RGxa?=
 =?utf-8?B?U1JYaFhyMWVUc3FOc1pwaXhDMlhCaUYySHJHb0NTODRoQk5SOHpxdU1pbUhw?=
 =?utf-8?B?MHBQRUEzNzdOdVB1RmhIVFFFVEpDb0N2ekh2bVFvOWdKcDF2dE0wa0FOcWp0?=
 =?utf-8?B?bDdQZnVycUl1b0ZwWEhKWGUvL1RlWVNTL0MxUGlTNTFUMWdYKzN3Uy9JU3JN?=
 =?utf-8?B?RmVVdGlnSUJaZlBuRURrajFrUURVRC9DaDhKVm9wSU9nUlA1UStLODNOWHUy?=
 =?utf-8?B?WDdDV1d5YW02V0NhUlJLUWVnQVlqaDkxdHM0am1iZkdwUFlBVGlsV05xSlRL?=
 =?utf-8?B?YktKUVUvUDZOSGtKRE1tS2s0TEtSM1ZwN0VaQzBDanZTOU8rVEY5ZkM4ejds?=
 =?utf-8?B?czBWcnBiRFVzRm4wcmJ3TWhUQ2NIbk9URVo3WW9VNVZXUGRSSzc5RThLdW96?=
 =?utf-8?B?anEzcW9PTG5RTERnU0VNV2EwMlc3dExrcjMzRlFKMFZldzQwVDAxNGJVVE9k?=
 =?utf-8?B?czIwOTNjL1UrNEQvb2ZpMEJXTjVTT0U5cXNTa083OXpaRytWR1JISEsyd2RG?=
 =?utf-8?B?VzdRZnd6elY0V1pGSE1WN3JrNnlUY1Y1ZjNxdEQxbDAvc0xBT1Z5c3k1MUxa?=
 =?utf-8?B?Tm5vU09ZTncwbytWWUcyREhtaDJZNDVIckRnWmdrMlZvMGZBdXZYeW9WM2Jz?=
 =?utf-8?B?ajAxdGNkUFFkTkhDSVF0Vm1tM1A4QnZsU3hRN0RLNXYxSG5ZUDhqdEN6Mk9o?=
 =?utf-8?B?Y0gyejJWUTFFTEg3WHo2OVA4aTZnZk1VUzRwSzBUK2ZqZE1FbkJoWC8yeko0?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NkVaM2NlU29FazVXQzY5SzlVK1NLZUVCTW5xMnV2alh5Ny9mdEFvV1JIc3lq?=
 =?utf-8?B?UjRPVTVpaitEejYvWWhLZXYvMGUxMnFwdlYzdlBUaVd3Q2xVeFJSVStnbE9n?=
 =?utf-8?B?OWsxdm5WMWtJb3RyRE0vRkRIVXBiWThXcjZrblJlOS8zU2V3RTRDN0h5SlJ0?=
 =?utf-8?B?dFJUWk90d3Z3SHRxNFNCUTdqMHp6eTJwWjh3bWxKSDdzYmVVVmF0S0d3SWFD?=
 =?utf-8?B?T3RER3MydVh0THFCS25XblZ5UWxIWE9ub1lZdVBaR2Q5YWN3L083Mm9ncnFE?=
 =?utf-8?B?S0tBREhad3FjRFpReHFnZkFtSll5ZFZSa3RDR2xFNVZGMnRVSyt0QWJvMGhj?=
 =?utf-8?B?QTNzMmJvR2VxNTZodXdiMVhKVWJxUkcyVjhxWjh5T216YXgyZldXSHJUUjhM?=
 =?utf-8?B?T0RKQUxKUDIyN3dmc1hlOEhGN2xmZ3hSSHNHZjI1MTYrQVhPSnJEQjdWWEp4?=
 =?utf-8?B?b2FocmZJTnkzNWo5czJ0Szc4aFM5RmM1Rkh6N0ZaMlRyTS9DM09odmx4Mjds?=
 =?utf-8?B?Y1VjY1hvdWJzeFdCMkw5U0hBcURJMjF6Zkc4ckVhcmZVdGNYaldteGxkT015?=
 =?utf-8?B?NEI1aXppSnFOT3VqUUJiV1IycUFocFdHZzZKdW1kQ1lRZ3lkUGY3QlVnejV2?=
 =?utf-8?B?Zy8yVk54azRXOUZMRWhVVm9malF5cFRIanBwQmJqbC9ncjM3SzFOMkNrL2hW?=
 =?utf-8?B?b25udzB4emY1RlMxLzVlNDBvZmU4MEdRbHZCVTh2ZjBRTm1sRm9GY3NWNVM1?=
 =?utf-8?B?ZWZiWjducHVpOWZKMHFNQzFwNkRwWHBxemNyMXFLRGE0QjhBTlk4cmRySXlZ?=
 =?utf-8?B?QXRpNlAxVXhBcUZ6eFNPY2lrZHdWR295WGJmR3F1bncvZFk0TjZ5UXdRejY5?=
 =?utf-8?B?ZkVXcElISGE1ZWl3eUoxSkdxdHFuS3JkTkZlRmpUQi9USTBUTjJwRDVpVjFK?=
 =?utf-8?B?K29Sd1crcmZsZlgzSnA2bHhYVWYxMzJNM3YyN3JJZW1JUkpZR0lLVzE2MHZu?=
 =?utf-8?B?eUIvZUxLNzZ0dWpORHlBdy9KSndDVGh2aVp6cTljRlJkcG05U3NNS1NUNlh1?=
 =?utf-8?B?OStuazhxNHdjb1d0MjEya3E1dm80SGEyV3hzZi9qUUdnN1hTdHZBY0IxK2ZS?=
 =?utf-8?B?NmpYMXVYN0Q4VjBmM2VlQ1hPekVkMUczaUJvQVEzSVhSSDRibDhRb2k3b3Y5?=
 =?utf-8?B?V3lac0hRNnhMNWF2SzhsNkcyajlVb1daeWgrY0xJQUMrdVlCZUdhV0I3RjZz?=
 =?utf-8?B?dHl0MXpXMnJ3bnpLQi9McFBBNU9uSkg5djE1eHh3TjBuc0NwVVV1RWpvY21T?=
 =?utf-8?B?aFpBam1kaEFxaDJzNCtscUNIVFRtZ0lwSTVVRnJ0ekx0a2kwU1JjZVprczd1?=
 =?utf-8?B?RXVSZzJzYTZjMy9NWnYvZDJTWGJaOVkzSVYxdXF1Uk5kOHJzUnlLTGROZm9O?=
 =?utf-8?B?c0Rmck1JZDI1U2Q4Q2RIdmF5VDlZd3VTNVhidWNDdlZRTmxaMTBJeG9NU2xX?=
 =?utf-8?B?eFRlbGQ3U2pyQUtTRU1ua2s1Wm96QndRQjh2ZlRuVnFMZnBGZWt0cUZ1WWlu?=
 =?utf-8?B?QU1qdGJ1TnY3bnZzOXRJblVPb3Bmb3NremZxYXM4RWp5VWNTQVFLQVkyR21H?=
 =?utf-8?B?UWNHcDNBRFpLWTRObmhTSjZBbEtic1c3WHJpaEdFUTJtUmtQWURtUVJiRFNi?=
 =?utf-8?B?ZzZLZjMzRWVqMVU3c2l3dzk0K0ZVZzVYM1BtbDY4N0hnR0Qvb2hSYThyMXdR?=
 =?utf-8?Q?9IDnOAtTNHqrtyRzz8QsZShs3q0lUbOZmiY8Iwu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7c0ac0-304c-4b62-635b-08db1e271b05
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 09:42:31.2403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2zfEL9xGzrlCh3U7HitlbUJCYsXtvCkmI94O5tQ4/gu5rYTC1ESF3x1mmP+lOCEtGMRgJ1RTp0w4tq/6lLlsSLztfH/SauiExY427frQ4v4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5725
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_02,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303060084
X-Proofpoint-GUID: OGUiLVnaKfR2v9XY6t3avDSnIimI3Z8o
X-Proofpoint-ORIG-GUID: OGUiLVnaKfR2v9XY6t3avDSnIimI3Z8o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/6/23 07:02, Greg Kroah-Hartman wrote:
> On Sun, Mar 05, 2023 at 11:00:03PM +0100, Vegard Nossum wrote:
>> Lots of people have been confused about the 7/14 days of the kernel list
>> vs. the 7/14 days of the distros list, the fact that these are two
>> separate lists, etc. Many reporters contact distros first, or submit
>> their report to both lists at the same time (which has the unfortunate
>> effect of starting off the disclosure countdown for the distros list
>> before s@k.o has had a chance to look at the report). I've shared the v2
>> document with a couple of people who submitted reports and they said
>> they found it a lot clearer.
>>
>> Probably the easiest way to see the end result of this series is to view the
>> rendered HTML which I've put here:
>> https://vegard.github.io/security-v3/Documentation/output/process/security-bugs.html
> 
> Thanks for doing this, it looks much better, but I do have some
> objections with it.
> 
> First off, you didn't cc: the security@k.o group to see if they agree
> with this, any specific reason why?  :)

I did consider it, but thought it was better not to since this is not
a security issue -- but I see it's actually listed in MAINTAINERS (in an
entry I'm changing, no less... *facepalm*)

Added to Cc, beginning of the thread is here:
https://lore.kernel.org/all/20230305220010.20895-1-vegard.nossum@oracle.com/

> Secondly, and the bigger one, I think we should just drop all of the
> references to linux-distros and oss-security entirely, as those are
> groups that are outside of our control and interaction and have
> different rules that we might not agree with.

I find this a strange sentiment. All the major Linux distros have a
presence on the distros list and it remains a valuable resource for
coordination.

I think most of the friction of the past should have been resolved by
the distros list actually updating its rules last year (if not 100%
according to your wishes, at least a good step in that direction), any
remaining problems should hopefully be resolved by improving the
documentation so that issues are not sent to the distros list prematurely.

> They also just a tiny subset of Linux users and companies and as such
> do not really reflect the majority of where Linux is used anymore.
Is the elephant in the room that Android vendors are not rolling out
kernel updates in the 7-14 days given by distros to publicly disclose
the reported issues? If so, then I think this is the real issue here,
and it should be stated outright.

> But overall I like the slimmer size, so perhaps the end result just
> being the first two major sections would be best.  Let me take those
> changes first and we can see how the result looks for now to see if that
> will resolve some of the major issues the security@k.o group have right
> now with reports (i.e. CVE requests, other group's disclosure rules and
> dates).

I personally think it would be a mistake not to include the info about
the other lists, both because I think they have real value (and I do
think they represent Linux kernel users, if not kernel developers) but
also because, as Willy said, people will find the wrong information
elsewhere and submit issues anyway, people are still going to want to
request CVEs (regardless of what you or I think about them), etc.

Anyway, I don't represent s@k.o so I don't decide, I really just want
security for end users and as responsible disclosure as we can hope for.
The patches are out there so feel free to use whatever you want from them.

Thanks for looking it over.


Vegard
