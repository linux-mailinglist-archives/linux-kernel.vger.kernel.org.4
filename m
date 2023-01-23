Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D9167893E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjAWVJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjAWVJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:09:16 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FB927D5F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 13:09:12 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NKEHH4018319;
        Mon, 23 Jan 2023 21:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=YIue/WgX6NpiHVplpCWwtrhWubB3N85j9wXsPoVWI+U=;
 b=ruDcKHWU7tGU72GEkNHgQDe+1oGZd31brjO7PgicQJ0fqEVdL69LzhULah4LcHM1fVVR
 II7V8Y0faTcA0sA4QiRe/wTzgmJzBfjSy8BfTiQYr0muXj8Gm7ThYEIBGaZM7y5pk1N/
 dfgnQMV082UwQDC6RNCuPGsUl3annd7EIL7+XkRNLEZqrlO6O2JPaYqfrnj296zIucWr
 7cVL+qSvcipobCZUWpzpKUku+infpoeQuLt+B+8qL2qrDe5nMegtxfqeP8F8nqeXQ9Tp
 uSAK/SMXBoZwPr9KLF/wlz+/bxzK6ZaFslYhbHseia5XTjHcrxig5LH/MtUJ7PIUXptg HA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n87xa3vxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 21:08:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30NJLLbe039566;
        Mon, 23 Jan 2023 21:08:56 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86gavjqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 21:08:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2TFh+EhKJw/PeJ310k/p7bEPZRP+tBEOEE1MxlqUcN2NTyDyjkMzCiZHOUOV2pxUpE/8B8/8LFZTENtMU38NOXpwSOBkAt3BdWWfVcNzqqL01Za5wYYE5loUI+iQpklviPCacmHyYnYvfxk/6doClKZokWczuWwhZ7qnUr8M7M3BAmq4zPa49Pu8adFe8MMYpYjuCZf96s4GrWdhLTC90pCX8TlLxhApENoEDIJSHMIkWpTMZj6iEZv321nSfBZB6+54TKR0JsOPCH7+W3f8GnKD9uZ0TLBFoLF63HuKs+QgRLGJ2wOEedbNOQwUHWFpgjEYJSzW236n2iTDrKItQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIue/WgX6NpiHVplpCWwtrhWubB3N85j9wXsPoVWI+U=;
 b=E1wyaaF+u7Afb6qVkaB20Qk9rTnSO/C6EqztIwpRmrrxqgxfEDISbeKczUCbtysxBOGq7BSejpsTYRh0Ts0UTGKv9u8+Um5Ph/AJCoywbBbZXBYIkAR7QFkuOtoq6V6yCy4kMpuPYVKU+AirK2gtE0M2lGiTirzlJeGfrX3f8wAy9310xQFdA3yYjxYl9lY1cpoLPrPCDYzIGEjwm6WxnpDjSkNRjACD/7b1Eqh8PAU3hC9t6N4CO94vHsg5dZd+cPoVCaSuTHvPiwL4i5BcI5EG9+1z+fdLmtsHakrPjTq7vQelPlvwBxTlroAVSEFGiQnQtmnBT8B0aWb78Vjv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIue/WgX6NpiHVplpCWwtrhWubB3N85j9wXsPoVWI+U=;
 b=D2A2Xqs8yIXad9mN1Fw7hRIp5ThQdA9NmIaip7O3B+RqKCkF83YHRA21IGx4EYEb4Xj2ggacSksnvbYoRdO3xOUpsApYvtpwYvTWqEPnVp2ZQ1f9+kuWKEetcsVBQJvf+1tkWuZhDS4kcng9eJyV38kgHK/NhXlXvoAUIBY6xIQ=
Received: from BLAPR10MB5106.namprd10.prod.outlook.com (2603:10b6:208:30c::14)
 by PH0PR10MB5548.namprd10.prod.outlook.com (2603:10b6:510:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.14; Mon, 23 Jan
 2023 21:08:52 +0000
Received: from BLAPR10MB5106.namprd10.prod.outlook.com
 ([fe80::682f:125b:f637:f89f]) by BLAPR10MB5106.namprd10.prod.outlook.com
 ([fe80::682f:125b:f637:f89f%4]) with mapi id 15.20.6043.005; Mon, 23 Jan 2023
 21:08:52 +0000
Message-ID: <5c40ed66-1e51-78fa-193c-0eb0db814b01@oracle.com>
Date:   Mon, 23 Jan 2023 13:08:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] mm/memory_hotplug: remove head page reference in
 do_migrate_range
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de
References: <20230123202347.317065-1-sidhartha.kumar@oracle.com>
 <Y87wJ6ERhdujjo6P@casper.infradead.org>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <Y87wJ6ERhdujjo6P@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:a03:255::18) To BLAPR10MB5106.namprd10.prod.outlook.com
 (2603:10b6:208:30c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5106:EE_|PH0PR10MB5548:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a639623-1491-45f1-592a-08dafd860776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j6ad5UKrqEYh7LbsqSfYZhLxuFEwI8ZBDe60xHN2FUlZb+l2JLQc9kImCfVRh5ecurc5xRC9p9od7pQh5wzHTYxiEWUBSXVtZ3ABCR2xq9WBgABRHngM7a89fuOHLH1ISMfHQJDQgvVFxp72leN9qiwL88PqiLVAHNGxbUyqPivzUJ+DXUkemx8BE08J4los+viIbzyt9lyGoYaElgQF/pQORHGIPGN69Idal5VdPXuQU5tcKLwX+elKYB+Gx1QU3BHH1hRtRcgqldyEtjm24OP2+hOJ8dlZNcV2idF9xSrGsDEv6LqYaMx8oYj4iKaMwabD3eV8yV1+rUQXrdHCJ1trU95XhaxzdhN6c3iYQVdm8jXVXFQWctFSI95rZPihdt92WGz1493RKX7kBIDIv/QgoBy9rocnEKBOgbcbYGBsok6cRj3Ueq/9W2JjTWNs31rZUDcWyhqLlhXHsorbICkjStyburf8/1ZiA3P/JSFXeLFC89cPUcQlYEs6xygqy3MuTIrCQ+UExX3ZuHopwjViXlOAA/U0swjeXJp3h9S9NAJCa6Gswh2WZKXVG4+m3RB/7lM7RR1wvRxnVutH4BPOEhhFmBzIGuBQ/d8NPLREMdielVd/CcamujdKW/e7RmIjyA9/+yPBAJ6DPInU2TPWTuYwiQE817dHmsKZ6robgPWTT7YWt9HNhCfCbW4G3chPPLi0O0dhtvflkFZ47PwhCF1xpeYD/FYkPpqweyY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5106.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199015)(2616005)(316002)(36756003)(2906002)(83380400001)(41300700001)(44832011)(8936002)(5660300002)(38100700002)(66556008)(66946007)(8676002)(66476007)(4326008)(6916009)(6506007)(6486002)(186003)(6512007)(26005)(31696002)(478600001)(31686004)(86362001)(6666004)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em1tWVZRVzErMS9CZmtNclVkaWt2UzJpdDBsNzhvTEJEbEdYQXV3YW1nV1lt?=
 =?utf-8?B?a2d6NWY1cGlzZTRaUFZSZXBqYkV3SUFZM1hyZ1ZnZEFEdzRxblFkU3BsaXJK?=
 =?utf-8?B?STAwZjBqbGk2WDBzZFRkL0hGbldObGZSVDE4N041cEkwcHhHVHZCallQUXBT?=
 =?utf-8?B?SlFTdjFuQVJWdXlIUnRsQko3Tkc4c0lLR0RyTFZSVnQ0dnJhNzR5d0NEdDZL?=
 =?utf-8?B?VXcvWGxwTFBleVZ3YUl6MWRRd1lpVGhlZUd0MEJmcG4rUndQdkk0Rlg5UGNy?=
 =?utf-8?B?eEt4dEg0elI2eng4c2xReG9ldjdnZW9uVGVLeGE4eGlHelpqSTJkNE16TkQ4?=
 =?utf-8?B?MitQak5tckRFREFjdk9LK0JhR3Yrc2VsdlcvYTlTQTRIVTdpSUlIeGFTOTNF?=
 =?utf-8?B?cGdQODlpQkpwMHBZR3RwWGd1SFROUFlwVGxmQy9yeXBrVWFZYkc2bWROZ3NL?=
 =?utf-8?B?bUQ3NG5taWJrU3VwVEkvbnZsZkY5a0RRWHBXNWIxUEg3VkdKVncvazE2a1pz?=
 =?utf-8?B?Wjl2bnliWFVpdlFiejlmYTQvY04zZWdvRU1HbDFNVzh1QlZLbytlMy81a0RT?=
 =?utf-8?B?VXp4SGZla3JRTzgwaGErS1F1bnB1Lzl6bFhVdWpndnk4UzVWMENreDZDa052?=
 =?utf-8?B?WGQzdzhFMHVSL1l2bzZCdVdSdVZIZU5nMUJ6YWNyelRJNk9acEtPNStacis3?=
 =?utf-8?B?T0xuUCtoaVVDVzRCUUxyeitYVmxHN1Y2U2czOGtmQkVmei8rSy9PNkZ5SnJ3?=
 =?utf-8?B?Q3hPeE1Jb3BWeDRqYVpldlIyREovNjZGdE5tM3ZLUVNiYXh0UktvbUdDQkZ4?=
 =?utf-8?B?NDFJMCtROXVoanFFdFZOSEVwUzM3UkxBTjl5SnhhTXExSlRMclBxMDVpY1Ev?=
 =?utf-8?B?bjRnUFZCVmhBcmZtK2JFUGxkZGVzOUdPYTNnb2ZkUDExdW1UZ2oxL1RhRENX?=
 =?utf-8?B?RWw3a09SRHRyNFllTnU3NEVnNjExM1orR3VtaExLdUtscXVQMGlBaE55VStj?=
 =?utf-8?B?ajRMRjZuVGpoTkMvU3BjdE0zQVFWSVZXaE5zdlA4WmxRVlZScnR2WElUQmE0?=
 =?utf-8?B?aVFEeGhkMUtBeWhRdmpORmJralpCdUNkd0FuYWM0NHVMZEhYK2RCNDlzOTk3?=
 =?utf-8?B?eTladi91azI1Q2pkZU5Xby82VXZHUExhL1NNaTZUZCsvQTB2TjlySDN6Uk0v?=
 =?utf-8?B?cTdYamM3ek1QL0w2OGJHYmVpWUxoL1ZLUmY3cnZ0QUtkdGZXQmNLZ3FZZ3pk?=
 =?utf-8?B?YTVEQTR2RmdhN0FPU284RjJrbU1EVmQ4elV5bnZsT3dYcHBLVnlRT2dYSy9o?=
 =?utf-8?B?VHE5ckxiTnczVEJRV2hTeS8wNS9QOFpZNWxacjlGemE1YkZkUkt4bmpqY28r?=
 =?utf-8?B?Znd4ay9rb2dnMHR2V2hYNmdYaFhrMC9pSUt6WU03cDBmM2YzTzRwVEFtTG1O?=
 =?utf-8?B?MUZpNGwxREk2MjNHN0pTaEsyRjJWai9aSUF1allpTlhJcGxIWVJodFNCSTJK?=
 =?utf-8?B?ZU5nZDFBWGRrRkJOZTF2anNWNWtmVENwNE5TVFNieFJyNjdCSmozUGFlamIv?=
 =?utf-8?B?aWlDSWJRUUlLZ09pVHdNNVZSYTNTOXRsMlhGcFhKK1dZK1RMR2xrQlBGZXV4?=
 =?utf-8?B?Ykc4MjhHaGkxNTdTQ2tHZzNUcUJYOFU5dEplK25QdWtaWGVuMHdSS09uUzhJ?=
 =?utf-8?B?ZFB1SzRpU1pNU01pamdDck9QajJZOGIrMGNKeUlTUzY3REJDL2h3cGZabTNQ?=
 =?utf-8?B?VFRUeE04SWlGZnRLTTJEaHBhdm82citzYTUvSDZqOEhidVMvSHRnSlU1VHZO?=
 =?utf-8?B?NGQ1S0JQc2NYa3NyT05vallJeElnQVU2ZFVVelpoUjVqd3RKV3NDcGQrODZv?=
 =?utf-8?B?TXdCUjVJWXhtSDk3ME1aMnBaSjRHZDNqRUIyY1RYS0xuck1xY0U4Rnk3NWtB?=
 =?utf-8?B?MnBwa0dSNjc2dnhERUlQZWpWc005WlpCYk8vdDIrRWprYkNuSm81c1FTaTBW?=
 =?utf-8?B?Y0RvSUJyN1BLMXlTY0JCc0dhZ0N4aVBHODV4OHZ0b3ZMdmZ4aFRtVFE3MWhW?=
 =?utf-8?B?eDdkVzFsekwwY2tuYllFMFE5SVJqaHpFY0hFS3hNRmpJTUE5UWtWd1RpRVpr?=
 =?utf-8?B?azB1bDNPYW8xTDFoTVowMTJqZUk1b2tDVmFPRXFFL3BrZWk5NlBwMU9LdGg1?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eTJSOHhxZE5lODgvWkZPR1Q1cmZzc0s5SlU1dnFMaFFuNmQyaURJRUUvZDN5?=
 =?utf-8?B?djF5OHBoQTF3dVpWRnB4K1gvdzJhQ1lFRjllMVFTT1cxck1WRmNQb0c3NWZI?=
 =?utf-8?B?UGRjai91dEQ1bDBONjArSjNBc2ZqbDVxak5pazE3NGlPdVNjWlMzMmJ5OHND?=
 =?utf-8?B?R1FBcGNncEpHRVN6UXJVM2JOY2R6U2xGUHd0N2g0R1pSNE9BZ0trVjl4U0hl?=
 =?utf-8?B?Nk56cUc5bUhRRkdTSVJabFNRajczbnowNnhsczR3QXR3TmdDMUtJaGNQQUcx?=
 =?utf-8?B?eUY2NXhhS1V5NSs1U3lkbjQyREN6aUNnQkFEZHFtZ2ppTHpzaEZqNzJ2Z3Fp?=
 =?utf-8?B?cmkvOExCY2M2cDl0UDNBQlB1bDEvVUlmbHpvc3Y2SUlKakJXTmsrMEhuSkJG?=
 =?utf-8?B?NTVuVlVtbitFQTdCSDZlVFBMbW5sRUxCOXRZZTJFZFROdTJkZUhZdE5nbFFi?=
 =?utf-8?B?aFIxQXJ1RXAyUFpFSmZzeEV0cXRnRFpTTGJUQ3hIZnBjOUNkV1gzL3cxSHEz?=
 =?utf-8?B?WXJvbXV4eklYcWFBUnlScTFNWkFvOXFMelk5eWlMSnlCTE1FY1dsRTNQbDFL?=
 =?utf-8?B?QTBmSzlTT1cxK1FjLzRybjM2QXdWejA1bUJKRkpuTjBGOEgxYTMxTkhEWi9n?=
 =?utf-8?B?eis4bDYzUXJXZ0RMK2tBTDZwS1p4UTJNSlExQTA2QzErc3VrNHVlY01mSHpJ?=
 =?utf-8?B?UXBhL2psUllCb1dHbEpPdk1PT3ZZamY0NDRIVUo4Rmo1TUVLbE1hSHhua1Rt?=
 =?utf-8?B?TklXU0ZQQU53QVIwSjhNdkhqZlBUZmMzbjR6d2RoVnFablIyL3FKL0orTjJ1?=
 =?utf-8?B?Qm8yNWt1aGd6azMrNXUyYTBvamg3azErRGljb0o2dU9BTUZZcENrYzY1TzhK?=
 =?utf-8?B?WGU4L1JybTgyTkNrYkJnYkp6VUVsSzJLSFNZb1NtQTU1RWpCS3F1YU9IWUFa?=
 =?utf-8?B?NHNIWWJVR0FXMXpvWkRpOTd2Z0QzcU1jRE9kSHdQYUtPRllpNHJlVm95cDli?=
 =?utf-8?B?d2ZzTGJ1VHFwZ2dhSWsrSWhBU3NwTGx1NWd1alVhRmZtSDJWRnMvdGVhdURs?=
 =?utf-8?B?SUFQcGhzZE9jeDVzMXBYeXlMa0kvanYzeXNLYXF0MTNOSXFLWldQWW5HOTZi?=
 =?utf-8?B?Y0RIRmk2UTFCQ3JSUzY3SzQ4RFFKS25aN0FzRTFiU2hOT0t5QjUvM1ZnR0Zp?=
 =?utf-8?B?Z3pwMnEwK1Z5UVF4Z3AzaERad1g3TXU0eml6K2kwOWFPRjlkejVSY2dZbXda?=
 =?utf-8?Q?aIbsTH2tVN9TZ7l?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a639623-1491-45f1-592a-08dafd860776
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5106.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 21:08:52.6157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFIlp9abLzN+byztQN2S7S5Ou4GwvI8K4M7waoql/XxMdM0RxKwARD77VeI0mQUOeawz6ACtaO2d5QyspACfgWmHhYfwsALxSn7gzg22z9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5548
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 mlxlogscore=906 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301230201
X-Proofpoint-GUID: O4dt8u9lszxXS-TYPocvawRVVTr7FlBM
X-Proofpoint-ORIG-GUID: O4dt8u9lszxXS-TYPocvawRVVTr7FlBM
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/23 12:37 PM, Matthew Wilcox wrote:
> On Mon, Jan 23, 2023 at 12:23:46PM -0800, Sidhartha Kumar wrote:
>> @@ -1637,14 +1637,13 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>>   			continue;
>>   		page = pfn_to_page(pfn);
>>   		folio = page_folio(page);
>> -		head = &folio->page;
>>   
>> -		if (PageHuge(page)) {
>> -			pfn = page_to_pfn(head) + compound_nr(head) - 1;
>> +		if (folio_test_hugetlb(folio)) {
>> +			pfn = folio_pfn(folio) + folio_nr_pages(folio) - 1;
>>   			isolate_hugetlb(folio, &source);
>>   			continue;
>> -		} else if (PageTransHuge(page))
>> -			pfn = page_to_pfn(head) + thp_nr_pages(page) - 1;
>> +		} else if (folio_test_transhuge(folio))
>> +			pfn = folio_pfn(folio) + thp_nr_pages(page) - 1;
> 
> I'm pretty sure those two lines should be...
> 
> 		} else if (folio_test_large(folio) > 			pfn = folio_pfn(folio) + folio_nr_pages(folio) - 1;
> 
> But, erm ... we're doing this before we have a refcount on the page,
> right?  So this is unsafe because the page might change which folio
> it is in.  And the folio we found earlier might become a tail page
> of a different folio.  (As the comment below explains, HWPoison pages
> won't, so it's not unsafe for them).
> 

Thanks for the explanation of why this is unsafe. Would it be worth to 
put this code block inside the

		if (!get_page_unless_zero(page))
			continue;

		put_page(page);

block found lower? My motivation for this series is the HPageMigratable 
call in patch 2 is the last user of the huge page flag test macros so a 
conversion would allow for the removal of the macro. I thought I could 
also remove the head page references found in this function, but if that 
would cause too much churn in a complicated sub-system it can be dropped.

Thanks,
Sidhartha Kumar
> Also, thp_nr_pages(page) is going to return 1 for tail pages.  So this
> is a noop, unless page is a head page.
> 
> It's all a bit confusing, and being memory-hotplug, it's not well
> tested.  More thought needed.

