Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A79867A26B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjAXTLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbjAXTLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:11:19 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17FA113;
        Tue, 24 Jan 2023 11:11:17 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OGNx3e007260;
        Tue, 24 Jan 2023 18:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=eYx53Uo6ecvWz6rsWPJKJbwiSH7xBLPtrqhefrvUQBU=;
 b=A1GjTp87jKIkJJS+8B/s65gDScJASNGMKXnDnY9du3y44ZDEqA54vhqUdnhd8QJkiUvJ
 A/kwfYJB+OOCz/ZFeeoGfkMlplTqNLmegJqJwND6YHC4/1HG1CG4M7XceYcujkz26/eU
 XKa3/3Ej1lqNAF2fnMKvxJ50smU7fx7d0qSrpCg+w4w6w7jtSYOmEpWEcTJBuhn3HHmS
 B1ofxk15+5dx/kQms7paSBajNH8Am9IrKUT7l9MI//r+z4mf/Z2PewhyssAPtrH3myFJ
 rJffMGH6qcb/BWD5QEwgUvc0z3BZjJYz/vcK8j5NCzhwlm13tQ9FcZHVXEy/0rjT2u37 hg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86n0x61v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 18:38:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30OIYkXg021287;
        Tue, 24 Jan 2023 18:38:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g5b33c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 18:38:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaTIF+1t71SlfyUgZyWavndZOz8yRbm082khAKtv2SL+Ouj0DZWbCJwwpQibKIAg/XtdfvpPe4Y0eWYwp6CiZlcjL056FVBevHBhcP74g+66kYJgVATgwD68VI1EqeMZNTyb9a0mGY0xRjeOjKmmANI5AqNl9HDtMqiLISazZsKbyTiZxrSXS01UMwA1e6sPbhzmJ+vQ+HHitanFQKdO/oRE059AjrTedL6uijjnPQQaqB3NDrbqoH/PrJ5XJrzm3UShr4NpReXdn1JPxekKnbi6QjDQcc965HrBAsf/W6hAq2aZGZ+S3t3xyRFnBcISBmjyR55Aawc0L37Q1NmOeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYx53Uo6ecvWz6rsWPJKJbwiSH7xBLPtrqhefrvUQBU=;
 b=biU+7/pPlmEp+Si41gnE/BWyXlbHWtoloaSz48uBc9NL26GeDJ9GMyyEEV0Iw00IVxQAZfu54JZ906x52DLCTiZXi24dcupqsMJkHETvOHAN1XAAfS/viQIjD6m0YMTrcT8t1nFQQZxtGzB9XhQcTxw2jnA7aAJjDdXIRrneovTTmyEHX/UuQ4QdCZApVFWo2KUROcdG0R7zeUdkmV/GC1Yw9kBxdkPx1U2y9IHr3tVJ23yQZJ+CvRBdFVG15aE01UHFR6zX1PHIGBAaGwaQ47TcsucOA25BvNC0Idc3Pu2vXcWetGTSS6511StFHNS/d4LfG+J4gk1FVNGJHq/VMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYx53Uo6ecvWz6rsWPJKJbwiSH7xBLPtrqhefrvUQBU=;
 b=jxjLm4P7mf72uMkhbBKf1r7dOFcNcWj5nKGT841ADZ13bbLLmLZRLvoOQAT8Qv08B9h9DG7/UUubaWJxyBtluFJSJXodtgI+AZSAaYpQZxUaJcocPFeVeCOHx4bU1Hmf47l4GuOOrVh5td/dW49lx8E+RdqQxeEhClX8iaT8nQ4=
Received: from BLAPR10MB5106.namprd10.prod.outlook.com (2603:10b6:208:30c::14)
 by MW4PR10MB5861.namprd10.prod.outlook.com (2603:10b6:303:180::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17; Tue, 24 Jan
 2023 18:38:39 +0000
Received: from BLAPR10MB5106.namprd10.prod.outlook.com
 ([fe80::682f:125b:f637:f89f]) by BLAPR10MB5106.namprd10.prod.outlook.com
 ([fe80::682f:125b:f637:f89f%4]) with mapi id 15.20.6043.017; Tue, 24 Jan 2023
 18:38:38 +0000
Message-ID: <ed11ad59-e2cc-a839-86aa-e6c4df23fee9@oracle.com>
Date:   Tue, 24 Jan 2023 10:38:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 8/9] mm/hugetlb: convert hugetlb_wp() to take in a folio
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        linux-s390@vger.kernel.org
References: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
 <20230119211446.54165-9-sidhartha.kumar@oracle.com>
 <20230124162346.404985e8@thinkpad>
Content-Language: en-US
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20230124162346.404985e8@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0152.namprd05.prod.outlook.com
 (2603:10b6:a03:339::7) To BLAPR10MB5106.namprd10.prod.outlook.com
 (2603:10b6:208:30c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5106:EE_|MW4PR10MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: a999742b-5551-46e3-613f-08dafe3a3568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xeF9mKbLBFC5yayCJkx5ueQmXdiwvGxU5fC1+dF+Yhu7//5eUhoHItvneWi+aTFjNunvnuqZ7RrW9dCr+tslezMoMoxkJaJkWEV6KBcVqyqEhUE8yEcwT4AaXKyDBhlUhrE3KS2R1yGKRTHnqzcfAfwB+ir6zWc0kL86Y6Sp19z5B2SylKwiLqS5udpBMtnF8kq/uJtArqrR8KKGIBNnVmDDUvsy3DKGwr6G8uAlJxuPCdKlZ+5NDYrKzrdfFWb42T6hLt+5IXw6P8jO6mSaPoug1xtoTQ0Ku06mYpcksH6hfrZE+6krVCVvXmdFJ5fhxhTGdsFnUtOKyoI5gvNVSDC47dd05IszwajQOTR50lwclU9g26vYQQm2ZKDbnS3LarQ5pP1W9Bje8F3jjacMaCGETFsHTi2S6H1YuY+1O7yEwhc2yUH7RS6VcnXSN9SEvdXJAQLCKiy5XI5DqGDXNXYzY4fagJQZAaqgAGg9DinYKOS9VCEXBGqBkE3eNEHsToVN4V+8BvK2ES/u24GidhI/VeWr6hS4wa7ONjbwexE4Xsox30Z5londJD5XxfWTtbVFdu9sV9/nJGXxaMsZK9Hh5SWeZ4Jk/Kfpp1Lua0IefY+9A8uJoLNoQIAUn51EoePgMyJcDFWVNIBHxoH8eRX4wY3JLbVaC0/kP8G05FfrcVJRAakCfBcqrF5ok9Olb19cPUnCVehIP/R7gD3SXFRgxiDuziJZQ09rZlU2yiQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5106.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230024)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199017)(6486002)(38100700002)(316002)(6666004)(186003)(6512007)(6506007)(26005)(36756003)(53546011)(86362001)(31696002)(478600001)(4326008)(66556008)(31686004)(2616005)(8936002)(2906002)(5660300002)(66946007)(66476007)(83380400001)(44832011)(41300700001)(6916009)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVo0cjlBb2ZYM3RZS0ExQXgwVmtXOEdORVlDd3djb09XMmJMdHArTk9tU0dj?=
 =?utf-8?B?OUR4OEg1Z0tGTytZSFNrTWw2UnFQYlM4cE1uaDVuZlRIdFdVNGJUMU1XVzI4?=
 =?utf-8?B?TW1YQVE1V2s5NFlDMHdlanNrKzVKcC93SkF0by9oOUt2Um5aQ1dhNmNNakRG?=
 =?utf-8?B?b3JBQmFjdkZuNWFOa1J0WS90czZhUlFUNFY1UzNmZlF5QWNPamhjZForMWdS?=
 =?utf-8?B?VEZRaEd5MjRPR3R6LzhWRUdTT3o3M0V1YWRqaUUrbWlCOFoxM29neWpneHlU?=
 =?utf-8?B?WlZEdWlRcnZqV0hVRW8xbTMyQXQyY05WeGZVbWRtNFV5eGJYN3Q3NGJQbkZh?=
 =?utf-8?B?aXdjY0ZLanovTC80TS9LdWVEN2QyR3FPbDU2aW4zNmxnMm5wUlFXZUJDUC9k?=
 =?utf-8?B?N21uRnhEVEFaMTRyVU1XUi9sSGM3ODRaN0Z0NkJQSjRQOTQ2eFNJeG9kQ1RS?=
 =?utf-8?B?djBOTVdWajdyTEsxMHArU3hMSUU2R2hnanNGUEdkM2l4a2lNYkVUR0JHNXM5?=
 =?utf-8?B?QnUyZzIxTklsMzZjMEhxN0M1b2lXMlFPTnhtbzZJL1RJbzlab0dHVkgyMHZ0?=
 =?utf-8?B?WndlanRtemljakZqYXExWVNaSkNWTDJzQjhBQU0vWUFZM28zTHBTUHp0b0JJ?=
 =?utf-8?B?R0VKUVBUV29qWm5WSzdvY0d4Ukppd1dBek15aEhLMDc4MGRnQ0lEc2J3TXZu?=
 =?utf-8?B?QlN0a29rcktYTEh3cVhDcUJxNGxaZFZDRTlDYXZ3SzEvOEpqYnBaVjdCSDNF?=
 =?utf-8?B?K1JJUUlhbXp1TVBOM1luYXhJeXFiWkdXMndZRTNqODJhKzdJUjRWYkI1WU5i?=
 =?utf-8?B?cGgwSmhOTUNUcmMyUzBDZno3dmsvK2k2cnA4cnNKRDh0WWphU3d1ejlxbmFW?=
 =?utf-8?B?RDV2L1l4SGtMYmdHSktGdktYVkhEd29DcURzdjRnRmtsTDJhUnh4S283MTZ1?=
 =?utf-8?B?dE1jUHdEelVUcnRNemZCYmxqaUhOMmhHeXVhcXhWSHJKbzlWdU5BWFRTTTlG?=
 =?utf-8?B?V0NQTDRnTmt6anZlRDdjSVdWWEdmV1hkZjRndGlDbWMwQkVoaU9pWmhMazVY?=
 =?utf-8?B?YlBXY2syS2h4bFlCUUZNV2RpcDlUWWNOQWVrYTdDUW5JZytCRUlTSGpwZDJS?=
 =?utf-8?B?dm9wWXU1VmgzUkVOd1FaOS8yOWdUbnMvVks1VjBHOHZ4OThpNU9FS0EzZEhV?=
 =?utf-8?B?WW9XTklDejdJeWYwd0Y3RmlVTWZ5Vld4Mm1OQ2V0Q292N1JRZVk2TTlZaXNw?=
 =?utf-8?B?c0xIQitpUGJmMmx0UWZNT0dsNDdISU1YTmh6TVh5SnhkMkdGZ3RoaTNiajVS?=
 =?utf-8?B?ZkFCb2JJTjVhS0piUGZ1aE52SFZsamhHaEMrS1FaaWNqaG9ycEorMkZFemhJ?=
 =?utf-8?B?cVMzb2tqb1JsaENsb1M3L3k0c1dEWFZPOGRzT0ljZlAzeGQ3VTdVWHpUSWVx?=
 =?utf-8?B?Y01pRG5zclZMdzFDREplcHY5VThEL1laaWxXTHdqbWg1SS9xajM4dEtPV1dD?=
 =?utf-8?B?dnRjZWRxT21PYVZUSmpXcENNRUl6Um1kSnBUcTk3eTQrZ0F6eU0wOWYrQXdO?=
 =?utf-8?B?Yk9lbXdLeTJTQmk5LzBiYTduY0toQU5PQUNZVFlDOWp6bisyVk1MTEFIOXht?=
 =?utf-8?B?VlpHaHo1QzRlOFZNcEJDNlkyQ3RabUM4NlJBTm9UM21UMWpWNzZpT3FLd0xE?=
 =?utf-8?B?S3Q2cXVZOVBERHZMc3FtZ0dmaElmcUlOcEFrY0pubnp2Q3JwajUrM2VRNDh2?=
 =?utf-8?B?dnFCV3FKUEl4V1dJcWNwVnJDVTdYYjlRSGtwMVQ2a1luRGpGWEFrTmlaM3FN?=
 =?utf-8?B?ZE1LRWRlOVZMd0V4TllHNnZtY0JPOTNFa0RrSzBobkVYSmFtUjFpUXcwUlFG?=
 =?utf-8?B?RCtlY0dmbW9rYUhTV0QrdVd4MXJDbUJCbkpzSThzYTN0cmZkVmZsRlpDNG5C?=
 =?utf-8?B?WG40WWhZTW8vZmFKSldEd0R3NjluZDh2V1dIOEorU2ZsUmkzTmRDdC9kRjVa?=
 =?utf-8?B?cWVhZDlnSm8wbDZhSVZKV3lVV1FqZEVIZVdubHVRYzZsdHVTMGdQVm9YWTVp?=
 =?utf-8?B?akNaRGU5d2FFUndTdGwzaDRiWERkNmpIRmhPTitKaWRBbzd0TDVzY1ROclFM?=
 =?utf-8?B?QXJsaDgvZ3VoaWFPZk1Vbk5kTDk3OXFvcFYyUlZJN1IwL2VNRDduNTR1NzVD?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZVVPTnU1dSt4MjRTNFA3VmQxQXUyaUxpK1cwY05SNlBnM3dxbWYreWtFWXNq?=
 =?utf-8?B?YlloU0VDNFlmVTFqeTRBQWFVa0JFSjhqWDNXTHJGY3hmTFdPKzdjZFdocU16?=
 =?utf-8?B?WVZ4dEtNYkx0YzdJTjArRmFMb1YvVTI1RU9EcS9aSXJHSFArcWd0U3ZNdUQ2?=
 =?utf-8?B?cUR6ek1OL1JFUTA3ajBtaUxlSXc4bFBRWE5vRVNFMUJSc2dvYkQ1TjJDWW1a?=
 =?utf-8?B?eGE2aUdtaVRxYXNxRk5KZkxqOWwvS2MwMXFiNmhTdkRCUUlvOFZPNDZRRlhx?=
 =?utf-8?B?QVJidGx2QlBnNmdCbi9IZ1BxVlIwY1ZKVzNqM245cFc3Z0tXNTYvTkY3WTlM?=
 =?utf-8?B?N2dkdWtCNDVpVGJjUXJmd1RONjg3alhaVkcvbWNiVjZnRm5VNHlPcEd4N2x4?=
 =?utf-8?B?NGhNVjZGK0cxb0thMzBJakdMT0lrYlowSDI5cUJkdVBpb3Q4cUp0OE50T0pC?=
 =?utf-8?B?T0xxSFZZcFhCdTdnWi84SDZxTXZQY2VvSmU5Z3JOcjNDdDBOY0dROVd1ZVU1?=
 =?utf-8?B?NGFWTkV4VFZBazhXVlJ2T0tyakpXa3UxY2VseE5KRW5JOWlvWHpWYVB6N2dl?=
 =?utf-8?B?VmJ4bUtIUzlrY1JkL2oveld5eFltRlZQUExZZ2JzZWllaVZHUEZMZHVrMzA3?=
 =?utf-8?B?T2NUWS8yMEpQVmpQZUttMjEwUnE2M0J2bFZxYitYQVN0VHNuYlBvVUw0NjZl?=
 =?utf-8?B?R3pIakp5VmNkNmNPSTBPaFNJUFJSL2NlYThUMU1haU9SRXQvQkkyc2NrS0Fv?=
 =?utf-8?B?ZU5SUnAxaEM3L2FGMi9wdXhpWVB2TFkrekJNZG9aNVhEWmJFcDV6REphL1dK?=
 =?utf-8?B?Qlk1YjR4eVVwTmE0SXJRb2tESEYzZmgzSFNPUzZYMVNYTTUxelhrUlU4cEJE?=
 =?utf-8?B?MFJ6TVFTYnNJamdtOC9uM2l3STNFSjEvdWlSVzBWU1Q5L0RzeDFWSGxQZ3pN?=
 =?utf-8?B?Q0xjMWtEa2sxaU5uZ3FpQkw1SkJUSTFmU3VaVk5GdUlnck45Sm9uVmxVS25V?=
 =?utf-8?B?b1UrbllPbU5xL2kzY0RmM2dHUHVUbTN5c21NbEtTbm5NcVFQcHBNcjd2MnU1?=
 =?utf-8?B?YXZlN1VsYU1jUy9xTnJLM2VnMEpXMFN6NVE2bE1JTWdhUy9kRkdEd21hWGxU?=
 =?utf-8?B?QVIzZXJRWWlhS25IQUIvVEp6MWZ6RGRBU1FwVlBaNTlKdktZR3ZwZ3pmTHVo?=
 =?utf-8?B?RUZpbVJRaG9aWHd5M3QvdkdOamtQTkpWdHlqY2JBdDd6dHZSR2JXcy9Td3A0?=
 =?utf-8?B?ZG05WlIxT1lsamQ2OEx3VmxQMmRiRWYya2ttUi9INjBGandpWG40ZWkreXhh?=
 =?utf-8?Q?3aGbE0TjKUKKA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a999742b-5551-46e3-613f-08dafe3a3568
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5106.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 18:38:38.6906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJxJn4U9eYysuPWCn1e/oFzZJy1of0XXn1t2zqsfiWWPVkrVXLjnINITH4wotVWvtprQZH9osW43f2Ie/G36d80sAEijrc8oF6MZevISJNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_13,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240170
X-Proofpoint-GUID: YhPD7UveWdh2CvN_9tXPCRehJ5BedMvL
X-Proofpoint-ORIG-GUID: YhPD7UveWdh2CvN_9tXPCRehJ5BedMvL
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/23 7:23 AM, Gerald Schaefer wrote:
> On Thu, 19 Jan 2023 13:14:45 -0800
> Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:
> 
> [...]
>>   	page = pte_page(entry);
>> -	if (page != pagecache_page)
>> +	if (page_folio(page) != pagecache_folio)
>>   		if (!trylock_page(page)) {
>>   			need_wait_lock = 1;
>>   			goto out_ptl;
>>   		}
>>   
>> -	get_page(page);
>> +	folio_get(pagecache_folio);
>>   
> 
> We get a kernel crash on s390 in mprotect testcase from libhugetlbfs
> testsuite, starting with next-20230120, bisected to this commit.
> 
> We get here with pagecache_folio == NULL, and crash in folio_get().
> It doesn´t seem right to replace the get_page() with folio_get()
> here, the matching put_page() at out_put_page: also wasn't changed
> correspondingly. Also, pagecache_folio == NULL seems to be a valid
> case here, on all architectures.
> 
> Reverting this folio_get() to get_page() fixes the crash. Not sure
> though if I missed something. I think you only want to replace
> pagecache_page with pagecache_folio, like in the rest of the commit,
> and not page -> pagecache_folio for this get_page().
Ya that get_page(page) line should have stayed how it was before as 
pagecache_folio is replacing instances of pagecache_page. Thanks for 
catching this, I'll fix this change in a v2 of this patch series.

Thanks,
Sidhartha Kumar

