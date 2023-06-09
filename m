Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0574F72A49C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjFIUVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjFIUUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:20:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487F83A86
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:19:50 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359HqYLw030578;
        Fri, 9 Jun 2023 20:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=vCf6DdkyKl7GwSWHHVkzlNixIFQcOFYP4UzNiISl11o=;
 b=yY4SaSpZY6ZQn5ulGHlQakWLybYjUqb8KfR6KNFt1v3PXLvLUH5uAUHyGyYGnY9NKCKn
 O2hwoa5HVxMfx0XsIC2yQ+1LkMxoyd7ttWO6zcqJN6LRjrbihboL21LtocEqFXjNcgCb
 nXM1ZdQtnI0dSwWLm7uhyhETRgTbNZm4U+sC5NtdBcksX1I1wOS4FBZeq1dpQguTZZB4
 FYCVs6AVXIvEIIwj9RxvWIaZ/7NrXH3Plioexs3/YZioebnLW8W9wOUD4Dp+ebTBzBj6
 ADoAArRmH3C0CMkMoexYBJUuEIyc5SbtU53nr1clR1utTvWexLmZEhjYTGNR++lX9qfx gA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6rqmq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jun 2023 20:19:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 359IwOZS036065;
        Fri, 9 Jun 2023 20:19:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6un803-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jun 2023 20:19:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HT4DD989urwgcevcoVpIWQ19cIL2ZF+y+6k9eX8oRPph5hLVBqU2bhtMda1t9n8vXQS40L0bkXJCWUZ85H9wGKr6oiiBtP7Dsfox5c2KcWffVofdJcU4mkAWZzISk+jNRusBiU0KtsAH3ES9TLGh5OmpAqUd6pjPLX/LKB+gyCIcX9nYm0LKU7jW/+HHLfbPPTkyGqGHLBbJ7cBKi9sQ8HceRFrXV8ODtglgv8C5aaS8usq6wIP8Hmo7Nr2okbA9BpDCxNm7+ouA5whgI6MIKFXJ27P4nNZjAkAurK4hbIF5+tlOFc9b0Umua84t2t069g7GcKQ3u9OsvnaYtQHXtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCf6DdkyKl7GwSWHHVkzlNixIFQcOFYP4UzNiISl11o=;
 b=nIXrf/Wn43PXevTZxlt+UdmdqqLUxsgQlOyOzgb4lSUaA6ala2rIEmvs/2TB3e+11BLPtRgvDB4/XtrCjrgT+cvJLfckLka8FRSczfy3wqOHST5ggmOi7benNtOvI6rgwZ0DjPvEtiIUqY/ELnZtj3oZImEKF9aodlWYM5A7UzSWRFwcvGOoCrxn2sI4cDcfS/s21KaX6Rp//IvQrMMG+euLcbPT5P045wUo06VslCDQI/zK2aVsGAzMXpQlBNqpHdD//t2ZuiJx7dInPkqdafsyOYGZ3B2UmeO+1TePDLPA8oaDsTv9RgDBhohYB1nV1Z9jo8DlJebV+eFPvYS1IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCf6DdkyKl7GwSWHHVkzlNixIFQcOFYP4UzNiISl11o=;
 b=yKh7V0SzeYrtAfR8BfVhAow4QLdRGac9pWISHbxMweoX+hcHO3HbQ+NZ5uivXmV1pisFtcZRHKJEEbUZCeR3Cd7xcbcGALFD1/l7tAnHMSsc7pgMwfpqUg6Ti+PkBmv4gZYfg3Pa6/fOdZtLPMt/3rvLgQFkqvY2oJgnf89xPm4=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Fri, 9 Jun
 2023 20:19:03 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%4]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 20:19:02 +0000
Message-ID: <b0a1b637-cad6-9458-53ab-4f54c2b808c9@oracle.com>
Date:   Fri, 9 Jun 2023 13:18:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] mm/filemap: remove hugetlb special casing in
 filemap.c
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, david@redhat.com, nphamcs@gmail.com,
        jthoughton@google.com
References: <20230609194947.37196-1-sidhartha.kumar@oracle.com>
 <20230609194947.37196-2-sidhartha.kumar@oracle.com>
 <ZIOF7pu0hvab7HYa@casper.infradead.org>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <ZIOF7pu0hvab7HYa@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0034.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::47) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS0PR10MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a0336f-ef33-4d9b-729f-08db6926c421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ok27tDIGZGbAxK1ClHHYXjEM8vOZlIglv5XFchnTJjk9ufYFgdDRjR+QURBXRJxksj//ZXysu/9jFtaN7v8VsW7+PCoMvguuYQFa4zmjqIG37onyu39x64Jqs2Pv3dwzxCJ5IK7XiAr152O6ve2E+WB3U+oYiHuKeDbQCxaLKfSiGBRx093m6FTHHkSd0YrFzkwq7u5yM4il0oP2MxlX6zQ/DsjA97aqHfKVwELAvhw30CmMceALFE3VVAWYucNQJYuB917zTi88I5bBASGtOVKFgX/hzRtLKzIklrZ9ftxDzSzC/apQM820sPkLjbS8e48IxwR+95+bBxSPZaxd1WEBs46Y33KqvE7UusbEUxTftCxBQSc9CagdSmyOAzIOFy5/tb1VmBURcqD4Hp0t+oWx73b/B9z3kA8OE/kSugxm7AMosfiN5XOrXZBd3ipjNRuRgFOr9XyZwdIlOp5BLH5yQAqH7v6RKmLzfhmbvq5dKiwHajBZ54tS6RXZB5K0u7NXJnW/n51giUI25dm23RWc1GiGpygn1T0WiPwmn3UURUlcdOCr/JAYZL/eGa6ahr5U3QIftAKV1SsnACbWqPXZ3m8QMgeMj95lu1RRQ3oCK97GSRYbtCf0cJJxgoGnA6Z0SvQq/Yq6R0FEetSJ/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199021)(83380400001)(2616005)(53546011)(6512007)(6506007)(41300700001)(316002)(38100700002)(31686004)(6666004)(186003)(6486002)(86362001)(2906002)(36756003)(5660300002)(8676002)(8936002)(66476007)(66946007)(66556008)(4326008)(6916009)(31696002)(478600001)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dytPNTZJMVQ5UE9ublRZZ3gwRjJQTlpzcFNMdWkxYlY3eXBCeENrTUN1OHRU?=
 =?utf-8?B?QzBvSkZvNUZqN05kdGNIZlBrZjMxMkdPOTVKb25aVEFsMWFlV1ZDczVzbjlR?=
 =?utf-8?B?OUpxdGREazR2RElRYWdKVEdNWjJuSEpsOGMyL0RJSHJqRWNCQ1l0TVgxdW9N?=
 =?utf-8?B?L0VpeTdLcWxLNjQ5WFJtY2lvMmZCaEVjcmFCQ0drQ2l5R0d2K0RnZjQ5dWFI?=
 =?utf-8?B?MnQzenlTRUlrV20vektmUFpkb2wxT25TZHFoWlpwRzJxd1R3dXgrUThKSjBu?=
 =?utf-8?B?Z0hYdTBGOU1xdys2SjNlY1R6VXZ0WDJUTkpOTG81Slk5WFRVT0Z5M0tTb29P?=
 =?utf-8?B?QVNrYVVwbVVvQWw5d0lDT3dFR1RHMm1KQVpKRnUwTXZCV2pTbjdib0tmTXpr?=
 =?utf-8?B?L1k5bUFXeGovOWJCdTBPL1EwMFB3bFJ2dVl2N0Y3WDlxTHdmTENOTTdqTU5O?=
 =?utf-8?B?OG5KZ3plR2U2bnNPSW5ZdjZhWHpWaVBJU3JvR3RXMVN4c1ZOY0NiMjVYMjFT?=
 =?utf-8?B?ZGVhMyttWHhWc2kreDlROGZvT2FJWmJwUkFiTzMxaXhOVG5qZUFCODM1L051?=
 =?utf-8?B?aVFiT3ZtUjlrZzBjdndBUFBiMlRRdGNET3VVU3oxUjFVMU96Z01tb0c0YThE?=
 =?utf-8?B?WVVRZFBxWDRlY3lqamE0eld4ZU9TNlI0K1cwZ3JnYWVEa3lNWVp6T3FzeVc4?=
 =?utf-8?B?RkxGbTZlUnNYeExSM2pLUnVGVzBLT2FOZ3I0ZUhpNk5SMFliZ0p5bVZUc05H?=
 =?utf-8?B?OEhFRDNoRk5kVE1BaUxJTEg4akd0aGNEYW1RQ3Y2NTNIMUFjSHhBMVBDVzk5?=
 =?utf-8?B?M0FoOWUzSzllOXVZYkc2a3J0YmZhR2gyR2JoWlhLb09NTno2WXgrNXRwYjEr?=
 =?utf-8?B?b21GK2xmbnpyOVV1emY4K25aT3Z4ZHZiNDVCMWRrcDVvRktyR0ZxaUovaVBh?=
 =?utf-8?B?VHNLQmN5cno3K29qc0d0a2d1bHZBVC8zZHFheDZFVXdhOUQrdzN2UXZ0M0R1?=
 =?utf-8?B?a2FveE91bk5ScGRmM2QzVlp1NXdqTWpCWEpUNDQ5MGdLZGVjVm9wdnliSGFp?=
 =?utf-8?B?WitaY1N3QmlrZ2QzcWMzbDJ0bCtNdjg1UmRjTm1Yck9KaTMvaGMyVSthL1hu?=
 =?utf-8?B?aEZlT2dUYUVNTFJLZXBESFBCUXlkaEQwMzRwWEJwSmRJZFJXTlNja2JtbnYr?=
 =?utf-8?B?SFJxZ2lGY2RFOHJoUmh0ZE00ODl0WWYrVzFUNlI5SVVPL3VmWlRHbkhYYTBZ?=
 =?utf-8?B?a0NKd0hhMUlsdlFjS2c3elY2OFlxUXJxZHZROEFLSnVyUzYyLzlOb1lvenNh?=
 =?utf-8?B?V0IxYUYyUVNJaDRQaEljMGZRa1dIYjVlZTNlUDliakwyTGlUd3ZwZzVPUkxJ?=
 =?utf-8?B?MkxxaUhTdTJwczRzSk1VNExuaUNmb3JqVlZKc0FMRzJqYkFGNlFoRndDaU5s?=
 =?utf-8?B?UHVucUVHTk5pcjJNWmUyRDRhQlA1ZzhBdmFwTFRSWXAyd1lMcko5VkU1QjRK?=
 =?utf-8?B?RHYzaENGV2U4cTBCOVBIazVnSTRvN1l5STRTNHQ2QVgyODUrZlYrTDdLMVBY?=
 =?utf-8?B?L1M4U3V0KzAzTi8xcWtKcW9lVGpZMEFrSE12cEdIUy9kYnZEN2h1K3kvdEJI?=
 =?utf-8?B?THdyM3hNaEpaSWdNbHU3SHkxNzk4eGlyd1U2WTJTbGdFOUt1TEF2aWs1RFNX?=
 =?utf-8?B?SDlRWkRrbnV1dmpYZ1RtWDlPeHFGU28zd2s5czVIcGdrLzZ5S3hkemJVTnkr?=
 =?utf-8?B?dlZySzNIakZld2NOU2hWbFFwVXpBZ0tVMjZJY3ZEOXJjdGxpdGVvbXlUeWs1?=
 =?utf-8?B?V216NWplcG5RdTdDOFdsdkZ6eVFvMWIxRldiMkFhLzVoV29ZdWhjdll1Ny9n?=
 =?utf-8?B?d1I2dDVLZytTbFJ2TjFGZGg5SnhmTUYva3JCWmpHYjVSRm55cUdaZXJpWHNV?=
 =?utf-8?B?bUVlU0l3RGF3T1JsMGpueUltdHhMZnBvNWs0ZkVIR2NiTzVwUDlEUmlrK2k5?=
 =?utf-8?B?eGIzazFFdklCcjZwdlN0NWdZVnhaRERCQ2lyYlI1YnNWNjMxdzNpUmlqd1l3?=
 =?utf-8?B?clhVckQwK1IzUXlpS2JqN2NRUnpORlQ5RGdiQXErTmhYSFAraUlDZGI0VDFO?=
 =?utf-8?B?NmRHeENLcUgrcjNmU2phQ0ZIYkZYRTg4T3dsVTM5c2U1S2g3OW5LOUo3ditn?=
 =?utf-8?Q?cNO4zKpkCutWGA8A24/5H84=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dC9GMUZMM3VYT01JWXVYOW1JS283cmhKVEIwRm1RcE1ySE53TTNqWXhMUzRV?=
 =?utf-8?B?T3ZLUHZNb0djT0d0VEJkQUNsVzFhZ1oxSml1RXJOOHNYcGZGM2VwUFFrbmZ5?=
 =?utf-8?B?Q1dQOG4vUG9WaWFhWkRtMFZIT2dZd3UxSk41K3ZXaUZNdXE5Yzd6VEpDbzhl?=
 =?utf-8?B?dUNsME83ckRLODMzZXBtMlFsT0ZwTzNTb1pIeGpCSlFsRUs2TE1GVkFvVVNX?=
 =?utf-8?B?TkZka0Fud3NkVUY4VTJSNnY4eTRDclB1aWx1QW9ES3RNM0gvK3hqZ0Fod1hO?=
 =?utf-8?B?OFA0bnh3a09jQ2FSb0sxUHNWZkVmNjlJczVxRUxKNDBSL1c3WTlSZG1SUXJv?=
 =?utf-8?B?a2hwaElGS2syRkxRT3BuNU5pQmNRQ3IrUGRveHhwQWlzWTlDVllOc0kwblNW?=
 =?utf-8?B?aUpsZmhCUjh6MWhlcm9tT2RnVjRYa3V5YTE5bXhOcmtRaTllVWRvRDRFdXFB?=
 =?utf-8?B?c0w3SkRnQW5kNWFMdWMzWU1pU09EZ3RIUGpmcUE1K09IbEtjOFNwa0RReE1k?=
 =?utf-8?B?TTc5UmJlQUxzNnRueEY3eWhMYWtQQkhDOUpjR2VVZzl2aExqZ0pqVzhyQlA2?=
 =?utf-8?B?UjZzWGtUc2p5eW8xRDFWVVlJM0Vnbnl0ME9lQXNoTUhieW0vM3dTSzZpNFZk?=
 =?utf-8?B?bHVxYVk1bXdlREJ6MWkycHlUb3pPd3BFRWxDZEU3ZGVROUpJN3htRXpQT21Z?=
 =?utf-8?B?cWdmNUNoTWpMOEIxcTFFaFVXSi9WWHlxV2pKTXRxWW9OZk9jaWh0c01YM2hj?=
 =?utf-8?B?Y2xnUzFTamhZUDV3eExIbzFQOCtZNnNLS0VoQzVDcmwybG1GdUU1UEVEVFVm?=
 =?utf-8?B?YTU2Y29UbmEreG1Wc2F1UjJMYWw5MGlNV1NsVWJlOGlEOXBhUWRsczhhdHRP?=
 =?utf-8?B?b0diWEl0Nzg1YlRIaGhuYjVkSG8zS1FTVW9DbnlhN2RJRDhYVmxGcVIyYkNK?=
 =?utf-8?B?Yzg1TmFXVWhwWmxjY0RJVTJHM3JCZFVBaGRDSHZpb05VWHRCRHozV0xUUyt6?=
 =?utf-8?B?OVNkL1M5VkMwK1dESG1GVTVlS1Z4RFd4UzlyeCtqU0RpaEwwK0NqdzQ4bEp5?=
 =?utf-8?B?NHB4MWh3cDYvYXltMTFIdC9rS0QxOHFLWG1xczR3U3d2K2I2T2FYQk82RmlG?=
 =?utf-8?B?NDlscEFRVktBT2k5Ym5IM0pqK1lDbmRWcUNscThpS1lvODlDRU0rUE1Camgw?=
 =?utf-8?B?Ri9ZbEtCYTZBdkROZHZEUDRPRWFVSE9RdS9NTzFiUG1oUCtKT21qT1ppMTlN?=
 =?utf-8?B?Z0pGb01rYytIQ2JUODA4bXU4bnpxckZaUzA4WFBrYnU1Yzd4R3AyZWZqVHFl?=
 =?utf-8?Q?9uz0uq1L2SauyxFWXmCcPYH6GbiXkX7W44?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a0336f-ef33-4d9b-729f-08db6926c421
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 20:19:02.5072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VvJ437l4pxShofsU1SsQIjqehF7+vd6QfVziYK8ZuTQ/Zt5m8GwMx1CrCHFnSlp+m9WSchG/XnDvKJWcbat27f9ENKmWPl+7DolvSfuCmJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_15,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090171
X-Proofpoint-ORIG-GUID: uj_NsLQV2NQgyhGD3pKTV0p-LdN_PckX
X-Proofpoint-GUID: uj_NsLQV2NQgyhGD3pKTV0p-LdN_PckX
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/23 1:05 PM, Matthew Wilcox wrote:
> On Fri, Jun 09, 2023 at 12:49:46PM -0700, Sidhartha Kumar wrote:
>> @@ -850,12 +847,9 @@ static inline loff_t folio_file_pos(struct folio *folio)
>>   
>>   /*
>>    * Get the offset in PAGE_SIZE (even for hugetlb folios).
>> - * (TODO: hugetlb folios should have ->index in PAGE_SIZE)
>>    */
>>   static inline pgoff_t folio_pgoff(struct folio *folio)
>>   {
>> -	if (unlikely(folio_test_hugetlb(folio)))
>> -		return hugetlb_basepage_index(&folio->page);
>>   	return folio->index;
>>   }
>>   
> 
> Unfortunately, you can't split the patches like this.  If somebody's
> running a git bisect for an entirely different problem and lands on the
> boundary between these two patches, they'll have a non-functional kernel
> (at least if they're using hugetlbfs).  So these two patches have to be
> combined.  Maybe there's another way to split up the patches, but I
> don't immediately see it.  Maybe after I read more of them.

While this is under review, should I keep it split so the filemap and
hugetlb parts are separate and easier to review or should I combine 
these two patches together for the v2 immediately?

Thanks
