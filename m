Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F6A720892
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbjFBRsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjFBRsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:48:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBD8123
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 10:48:07 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352Hf9YO002775;
        Fri, 2 Jun 2023 17:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=JV8fhaNO6mas3VSqVtWp625DleQjEW1wBqBwSbGNK64=;
 b=Kf78yFUpHCDd2IPlmUm9l9abbKxKLChH0FWWj5GZWPsN4gt1NgVf+Mdpl1A+pYKN3RiO
 AEQZyI0vDkMnD0rHF8FeB7wsc9TdUVAmUNMct25ESXOT5K4DpDLXUG722EViGxjWV25C
 PqXRmCOOwmkEw9V4Tc5UorQA0p0U72rjId+hvcLSyv9FP6a/loKrHHSnK/b1GrMNGcvp
 NtCRMCz8oL+x5BUkf8p0jneZPoeag0n5wqi+YdICKjrOyxP4CdevoMhEfVFOoNejkSCO
 Sqsg3QsEv+vgo5ayskn2pqoCXm/0eqhLcAk6dE9UO7HHAHLoJG9prYB/HobzW0r4XVRH BA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhj53en9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 17:47:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 352G0fek035185;
        Fri, 2 Jun 2023 17:47:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a8vj8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 17:47:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLiO9MjaxKYCJc3gb37EV4ehx5Xeb9GnebcCJMzma4R+BUllW1IiByjviilcVnM6ojSlsvtQvMdaKknDIa34fQRiBfskX16IwZ0hmOD7fqxB7dUanu2zn+HWIUtMu4wedkE/uE9EsiP/UtxwU5iWPut1MnyLJC2gXGMhBA3sv92uVxdcwjfDi5XYH0XRh0Jaqb0svzN1HEcZTP6dc43yZL24N7aaj1JARVDVuVZL9omLrCuDFHZGpIjPmBoKIDFSW4U6sEH9mnjsAapw49lz5hqquGWzEGjFDVO+RauanhapizV0XMeNeXtiXnpdikr3r7Z7IBGfRAiy377BDeYBdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JV8fhaNO6mas3VSqVtWp625DleQjEW1wBqBwSbGNK64=;
 b=g6RPBLcSWCgYsjJPyxNjc4yMjHChSUovRay/7sVfv/WvEBJPZjrObXj87Cc5gjkB/iWFqJ9azlw02XlznIX+5CuRN/dqsSSv3q8gqKpY3dndRcNtVbzUCK5H2Sk44Zsu2UUWgJJA4Aq8X0nH9jNHcojq7k55kU77YJAjJN+uLAOJzu11ZWsdWmTV+tXktf5I2Htxe+Ok1veG6tcoaPfqnQsDKt0uE8q9bsH4X6+haRfjkM3ABA7XaPB9k0+OPBMFzWzWobToDWwTLrSQKwELW3RbHpo2YMbGAZQoQ0uq7Ukv2yv4eq7L+CMRVSzpfEYyI5EdJDN0DwtI7qWfqb4nOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JV8fhaNO6mas3VSqVtWp625DleQjEW1wBqBwSbGNK64=;
 b=OUV+Y4J5b36WdyoOOwcVOxwEb2DTJ3e1ScEFXKmx3FupE6e11YjP1h92++wN+HcFA6r/5pixC2UFNC9UyrwCknoUeOu7Vtm0+ShS6qcM5D9on/iWbNJvDrY/d1K2WssQdCZFAo+0QCNa+ZNfEcF8BI3JhFqMha9T3m6W1QS6KQU=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY5PR10MB6237.namprd10.prod.outlook.com (2603:10b6:930:43::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26; Fri, 2 Jun
 2023 17:47:41 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342%7]) with mapi id 15.20.6433.024; Fri, 2 Jun 2023
 17:47:41 +0000
Message-ID: <5a807641-fae7-a727-4922-2e4516ee303d@oracle.com>
Date:   Fri, 2 Jun 2023 10:47:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] mm/hugetlb: Use a folio in hugetlb_wp()
Content-Language: en-US
To:     Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, mike.kravetz@oracle.com
Cc:     muchun.song@linux.dev, vishal.moola@gmail.com,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20230602015408.376149-1-zhangpeng362@huawei.com>
 <20230602015408.376149-3-zhangpeng362@huawei.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20230602015408.376149-3-zhangpeng362@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::21) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY5PR10MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: b422bee8-b8e7-4ece-4582-08db63917659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eoAfCSKeIzwMjktqMIimLw/VXrDLK7rfR9u/xBLXnS9wyoTvRpKtm0KmUmaq44igwVFRS6wlj5vX9LnyMJy8MAbPU5J6quOHQsZoyM4/iwm8PKloMQwqSltbTAtjYGi/wy2sFsGC+yv3kWjVcW9u9yT5VOISRhhE+7VMrVCKcDF8Y3cl4VMF+BgBD7PLwj1EHrQ/HlmI9rWmRSKOYQJmsyyyekAGBW1Hj7TrYRx1P7ZKQGo6iag/6NMu/57/fnle5ZL00JtGXqkwoTObc6+tlLCV963A5ATAN/QsQjwZSVn6rBfsyZvpyAChQKfXGu0GbE7L3e12YttZqJ6S8dxzwntIxeuA++XXYXAYRCyq/OYpXuLyka7EcgpIE/10J9boRrHyMgx4dzwtkNlNvee2ZwZIHAAoZRkVVxkxa/41sFJWMsLzHgJO0h4MTVHLssdZ4iHMnOkMRus+Yc64hGI+boP8GEBVPfIiSRSJBjhRBI1Rx8PcanyneFIKg2vUy024+Jd+be4/QQkVirBztzyrywloWCAbV5KnYDmAPxFh2GDMbOerCl2P5ZtUpdrpV2MAkpnuaMGiIpFIOt139XsPC4o/Bf8l4Zo8JMCJkkXjVT42kFmcBLsAxGZBhr8NPUhBA4QpEaOtS54IFH6oqqIADw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(31696002)(86362001)(44832011)(5660300002)(8936002)(31686004)(8676002)(2906002)(6636002)(38100700002)(316002)(4326008)(66946007)(66556008)(66476007)(41300700001)(478600001)(6666004)(6506007)(6512007)(53546011)(2616005)(83380400001)(6486002)(186003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2t4UVhSSDBLV2x4am9BakRoV1FjT3gzN2ZZSlZwVlNEK0lKUUVSN0RrYVhU?=
 =?utf-8?B?YVpnbnBJVDZTd3c4ZGJBUTdCQ0lPWnppajRhY01zQXA2L2tBampHczBzQVZh?=
 =?utf-8?B?WHBoM3FKNXFoQmVMc2QwSTluOXcwRVFqRXJzZ0pBaVdTVFE2ZUNHSHRJYVNR?=
 =?utf-8?B?aTZNbGtXRnhFaFA1UkxoTHgxSi90U282aW9hcXdiRGZtcW9ZMTFVQ0pQK2lC?=
 =?utf-8?B?VW45YWMxTDNTZmR0amdxUmRqMVZBY3VNOFZ6NzhXZHRkTWtCQWdkdGtvQ25x?=
 =?utf-8?B?OTBSTFNGTGJiRFFHZ3ZETm9kRkMrWlRGTUx6VjF2cWFmTVg1ZjhRKzF4NC9w?=
 =?utf-8?B?WlVoWkkwcjJkWGR5TlpHcENJYnJwbnh0MGZWTWtCUGJPQW8rdDBOQW1FNlJ1?=
 =?utf-8?B?R3o2WXRCZTJ5WXViQTU5YkwxaDlzYU1RTGsvWmtlOTdGY1hkRVNpVjZ3YTB0?=
 =?utf-8?B?UGFTRXh4aUQzOTl0TSs4U3dWUkpEUXB1dEJNVWdUNGhYM1NLYWtlZlIxaW8z?=
 =?utf-8?B?eDlmNFkrbzh6MmxqTDRkMk85MjN6YXNzWmozQnJVd0ppNGxmSHVYYzhGaFRQ?=
 =?utf-8?B?QzFEVkpYT0dROHlETjM2OStTWk1UVERicytPMGQ0RFVQTnoydDhTOG1YTTVY?=
 =?utf-8?B?Qmw3VElLNTV2S2JFYnpQZUhjRlA0VVREMVovaVp4Y2M3UDEwMmdkUVpWYzVX?=
 =?utf-8?B?ZFRVNDBBUGRVa1JiYkJ6TW1GTnRNTU04VGd4dVNtS1NXR0g5WEJMK2VmWWhq?=
 =?utf-8?B?U0VHbWRsMHFjeUh5NjluYkUzeXR6WVpXRU9STC9jK0VHS25Dc08wWHR6eFc5?=
 =?utf-8?B?MjJOS0FYQmFWVkJ4a0xyb0lZRm5kQWJLYmpNSFl3MEVpRDZUVDVtRmVhMGs3?=
 =?utf-8?B?OCtrZ1ZCWlk2Ym1pa29BZmlmTW9zZ3lhU09qYjFLNUp2VHNuMlkwQnNJNHNN?=
 =?utf-8?B?K0xOY1BNVU9uMFl6Yk55aURaSlBXNGZVSnVvdnFTL2xmWk96RnphZ0ZRaFdh?=
 =?utf-8?B?YUFpN0FIU2drazJudnMvYlMyRlp3UjdJK1FBY2hyazRzVTVwWEdWYTd1ZHVJ?=
 =?utf-8?B?OVd2eEhNSVdRZ3BHN055cVBBanFmTFVqL1lXNG1NcWNnZysweUtiMC9mRTlP?=
 =?utf-8?B?RitkOFQxOEQxN2JtYzJGck9pKzY4aENXZXloN1FBWWx0M1A4TXFDM2RoUWhk?=
 =?utf-8?B?YnlCWmlFd1VpN3JyejRJSE5rY2s3L2Nrc2k0dVlzOWpyL3d2ZTdaU090WG8y?=
 =?utf-8?B?cEdQQ2NoL2JoTHZzcTFVRXJXa0JGRGVpR255dUhBRzRvRUFISGdSQzJ2b2Ir?=
 =?utf-8?B?OWtILzI3Yk1tKzRNZStSZVJkeU5LaXhXK0NKK3kyRERvREJQK0JOSkl5Ujli?=
 =?utf-8?B?TndkeDBML29tYlU5ZzAzekZsWk42ZFFtdjM3T3BmMklBbGltTkRmUnBSTWFw?=
 =?utf-8?B?MVpKNkZXYW9uT0pLaHVCWXpBTmhHR2t1c3p2OGk3TFZKMWhqRXNOQVAyUmJ2?=
 =?utf-8?B?VC9DdXBrUHdHbG84L0ZoMGFsaHlPaVJmdHh3UFBxa0VqSWpZWTVxMHdBd1I2?=
 =?utf-8?B?bW9oNkpHYktEbmYxSWFCRllvL29McVkxYWRINnNic3RXSS9rdkl6SFFJQkhR?=
 =?utf-8?B?a1JWWTFNcUpFNGI5bi82TlF2U1dLSHJDVTJ3YkVudHFEemVPakRxc0syTGEz?=
 =?utf-8?B?SUYzQ3ZnbGNPOTNzTzhIVkIxb0F5Vys1dmFBanlZOXl1VGF3OVMyMDFSR1NG?=
 =?utf-8?B?N25vQ2dORGZ5clhIYWF4eHlIb1RxQytLT2krUkVZcVB2YW5laDJIRVQvMDJz?=
 =?utf-8?B?MUd5LzVUZWFlc2tadno4TWx1OVB2S1NESHhPemhWVWJBckx1dk1pRjZVa3NQ?=
 =?utf-8?B?aW1hdk5mZEVRZllBTHZkcWpMWjZmTlFtbnF2R2kyZEJiVzRFYmVWRGdWK01C?=
 =?utf-8?B?bXdwajg3ZXp3UEVHQUdZZUlDVzlaaFlxMWllNlVac2tLdGtXMEIxbGdRTzFo?=
 =?utf-8?B?MXh3YXg1UkpJNEdRWlhUdjl2a2xQaGFRaFBYdlVPMFpMNFRmWWFCQlI0S3ds?=
 =?utf-8?B?ekY2V1h3aldJVFFVNWxsQ25jM3lWcmRDQmRCb1UycEV2VUVwYVB0SmhuaHBG?=
 =?utf-8?B?QVZyUlVMeHhpVHc3elVnNzB5bzZJaVNSYjZzYjU1VTB6SUhCNzNpVkZXTHEz?=
 =?utf-8?Q?NTtexKY6PmHsoLGEUYR0jbc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZTkyT0haSDY3SmVtaU82YmFlR0I4SFFTWGt4TU41NFhFK2g0SkVpS24zaWZP?=
 =?utf-8?B?L29PcHYzZlpOY2p3c1pwN3YrandkVjk2MVdrclhScUhzM2h4U1hqbFZzVkRL?=
 =?utf-8?B?R3BmNEsvMjMyZVhod2NvZUp2N2I0aDVQeE1EazdCRW1HM2h5bW5wOVN0dW9B?=
 =?utf-8?B?SUdKL0JJVHVXOEEwNjA3QVRtd1VnbmRMUmRXV0RIa3Q0b3pEK1VMUjk2RTFV?=
 =?utf-8?B?Y3BZRy94Z09FZXBDaWovZk02UHljMlFwaXJ1UXVHR3Q3ZnFoQXpBcHVDTjVO?=
 =?utf-8?B?Q1NqcUoyS3h2UzcrRHo4eWNrZjUzOG04ZnNDM3FMbXUyczFDd2lNTThrdFYv?=
 =?utf-8?B?ck84ZVlubHphaXhpdG5EQkZEaEpxMVJSM0phRk5wT0tLNFlvVXFQRVhwYXI3?=
 =?utf-8?B?dm9FOXNWaTJZREJNK1lSUmN2Z0FlOEJQV0NZV2U5aWhYMDBxSTVnREpDcWdq?=
 =?utf-8?B?ZWJoYW9NWEozMnNEV24vRkZaY3hrQitxQ2ROalBOQUpzVU9UVzMxS0FTKzFv?=
 =?utf-8?B?RitQRlBFVjJUT1p6K09jZUN1dGZ1R0NBbTJVTXNYdWFTV1hZdFRSR0I5elBk?=
 =?utf-8?B?OUMwczZTQzZBaTNrQ3p2S2kzT2M4KzNIWVIvQm1aeW9QWUVjK01BUGtZc2x3?=
 =?utf-8?B?elJ2RXRUM1lhMjFvZUk4WUN5bTNsOWliY3k0VEQ4U1ZjVGpCN3ZLcCt0Qm9W?=
 =?utf-8?B?d3h2T0RUMjNiUjNsZ1VqdVY1VURSakdkU0J4YUFSTVRJNGtUR0Rvclc4Kzh0?=
 =?utf-8?B?NXpnN0JSS2YvMmJWV0dHbHRxZUMyYzNlVU1wRDNGZTc4NXBGdEVIZTR2N0JE?=
 =?utf-8?B?Tk02blZ2ZjZsQnZPd0xqc0N3ZDRBQmJCUnJ2VHRtcUdUcUZYMmZFQnZVWDZh?=
 =?utf-8?B?WTFjZDNSc3I5MFRZVUp1TFBFRTBRL0p4cUR2K1A0c1ZVNzlyN05yRUllWGFr?=
 =?utf-8?B?N0tBNm1ocVZSOWhFYnQ4NklGNzkwcnVvdXVDNDFUSlFheE9hRm4yK0FPZTlC?=
 =?utf-8?B?TjdPaVg3UHd6OXcwMUtUcnUrdVVHQU9YbjFSNWh6US9XZTNremJWZHMzNW4x?=
 =?utf-8?B?RE9GU08yVG9PZTdFNnJrZE15anAydjBoVXh3MWZPYmJsUW1mc1dSZjl2Sy83?=
 =?utf-8?B?cEdyVDdBMWM5eUREMkgrcU9QcEcxUHlpd0p6Um9sS3lNNEdDWFp4UTcrVG1H?=
 =?utf-8?B?VXpUN1krQnhrS2YrN1Jicjk4NmRIQjlrL2ZaaHZEaG1aL2hpQzVoRHNId0Zt?=
 =?utf-8?B?cWpDNmFEbXRudzlFekd3SXVqVnRFSFJtak1aQy9tLzFLSDV3Zz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b422bee8-b8e7-4ece-4582-08db63917659
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 17:47:41.1851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yE69L2dCBAGg8s8d/l2jDs7EI9Gs4uzIgqBPl4PX/f0sA1T8w335v48ILdEiIlnJnnNSjcVxMduNxHfM2yLNJ0Iq83ApNOtHFsWZK7pNRmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6237
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_13,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306020135
X-Proofpoint-GUID: iHmOke8BU46USwSrnS-2neD0OSLEaqSl
X-Proofpoint-ORIG-GUID: iHmOke8BU46USwSrnS-2neD0OSLEaqSl
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/23 6:54 PM, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> We can replace nine implict calls to compound_head() with one by using
> old_folio. However, we still need to keep old_page because we need to
> know which page in the folio we are copying.
> 
> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
>   mm/hugetlb.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 0b774dd3d57b..f0ab6e8adf6f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5543,6 +5543,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>   	pte_t pte = huge_ptep_get(ptep);
>   	struct hstate *h = hstate_vma(vma);
>   	struct page *old_page;
> +	struct folio *old_folio;
>   	struct folio *new_folio;
>   	int outside_reserve = 0;
>   	vm_fault_t ret = 0;
> @@ -5574,6 +5575,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>   	}
>   
>   	old_page = pte_page(pte);
> +	old_folio = page_folio(old_page);
>   
>   	delayacct_wpcopy_start();
>   
> @@ -5582,7 +5584,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>   	 * If no-one else is actually using this page, we're the exclusive
>   	 * owner and can reuse this page.
>   	 */
> -	if (page_mapcount(old_page) == 1 && PageAnon(old_page)) {
> +	if (page_mapcount(old_page) == 1 && folio_test_anon(old_folio)) {
>   		if (!PageAnonExclusive(old_page))
>   			page_move_anon_rmap(old_page, vma);
>   		if (likely(!unshare))
> @@ -5591,8 +5593,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>   		delayacct_wpcopy_end();
>   		return 0;
>   	}
> -	VM_BUG_ON_PAGE(PageAnon(old_page) && PageAnonExclusive(old_page),
> -		       old_page);
> +	VM_BUG_ON_PAGE(folio_test_anon(old_folio) &&
> +		       PageAnonExclusive(old_page), old_page);
>   
>   	/*
>   	 * If the process that created a MAP_PRIVATE mapping is about to
> @@ -5604,10 +5606,10 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>   	 * of the full address range.
>   	 */
>   	if (is_vma_resv_set(vma, HPAGE_RESV_OWNER) &&
> -			page_folio(old_page) != pagecache_folio)
> +			old_folio != pagecache_folio)
>   		outside_reserve = 1;
>   
> -	get_page(old_page);
> +	folio_get(old_folio);
>   
>   	/*
>   	 * Drop page table lock as buddy allocator may be called. It will
> @@ -5629,7 +5631,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>   			pgoff_t idx;
>   			u32 hash;
>   
> -			put_page(old_page);
> +			folio_put(old_folio);
>   			/*
>   			 * Drop hugetlb_fault_mutex and vma_lock before
>   			 * unmapping.  unmapping needs to hold vma_lock
> @@ -5674,7 +5676,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>   		goto out_release_all;
>   	}
>   
> -	if (copy_user_large_folio(new_folio, page_folio(old_page), address, vma)) {
> +	if (copy_user_large_folio(new_folio, old_folio, address, vma)) {
>   		ret = VM_FAULT_HWPOISON_LARGE;
>   		goto out_release_all;
>   	}
> @@ -5703,7 +5705,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>   		set_huge_pte_at(mm, haddr, ptep, newpte);
>   		folio_set_hugetlb_migratable(new_folio);
>   		/* Make the old page be freed below */
> -		new_folio = page_folio(old_page);
> +		new_folio = old_folio;
>   	}
>   	spin_unlock(ptl);
>   	mmu_notifier_invalidate_range_end(&range);
> @@ -5712,11 +5714,11 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>   	 * No restore in case of successful pagetable update (Break COW or
>   	 * unshare)
>   	 */
> -	if (new_folio != page_folio(old_page))
> +	if (new_folio != old_folio)
>   		restore_reserve_on_error(h, vma, haddr, new_folio);
>   	folio_put(new_folio);
>   out_release_old:
> -	put_page(old_page);
> +	folio_put(old_folio);
>   
>   	spin_lock(ptl); /* Caller expects lock to be held */
>   
Reviewed-by Sidhartha Kumar <sidhartha.kumar@oracle.com>
