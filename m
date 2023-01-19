Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB0D674020
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjASRjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjASRjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:39:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C132728
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:39:13 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JGwcTE029439;
        Thu, 19 Jan 2023 17:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+p2QoWRHrEVLcW7FFa5ZCIxBLsoh85hXyO9BGDQUXLM=;
 b=Z4z3Sx0oBACoufsGuZqygUJu8usq4ozvX6UjQrmFgOeKUkO+pBghcaaQ5OM7Sjz97Ys5
 wShibEmIpzlKGDGI+kTG+YEVmdpn+FAO2bSSedZrlkizvuSjhXd7f+43jO9Lq5oot391
 02u4VRha2lWOlVgUuzBCHmwaLjHUPdNru8qkQ/qei/RLPSrXtfFArR8grB9gHlAuYVGY
 ZSBtkxCKeVFqeAzIv6ltsvyT3UFLjrZL3glzg4OWAePUc1I+CITt6DY4PIFNAXirhFw3
 hbHpZBlndbQb/mfMXw1DRMW6TEQD9Y4kvEeoFKPwFPs5JXBdUZ3exIGQ4lR1WGo0HBzb tg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medjwd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 17:38:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30JGC2HB027886;
        Thu, 19 Jan 2023 17:38:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qubyde0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 17:38:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nf1QfC76hs0ogZDjoZTEAr+aZLcz/b4Ck74aFSPK7md9SD/UtpilBPhhXoKN7mMZFpQ6Cb4HebAywI3luLRyhNyRilESw6JGspYMgl58QKkKC57nsury+MvaEGAvkBxxovh512cQRqiE+BxhTkMirWk0EU1KaJsggrAo2iXHz9aU5x8B4EigfcdGLsX+3B1LTeropS9D6RQCaVmDnOgLMdtyOKP0UIQwIfrGNX0cUGGuGRmNJfYI9AF7QXg+Ml6RF4+Sao8CyWcNWHVIVTRxlgWPLn/c8KCd0U8CrdDVzTLF7mrsbq1ab1c8IXJILt5TYMuc1DFnj53QJ/zAF53Z8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+p2QoWRHrEVLcW7FFa5ZCIxBLsoh85hXyO9BGDQUXLM=;
 b=ThIpX2y6B3g1ghk4PL3lNuFUY6H29vWFpCcb5tG6N9JoUSraX7+EXlDoOn7iTsv2AZKFD4IaMBVN4is+L1YGCh7DS2RHCQc6sHcJg10gyixmA9Nwt+9yq9KBfqh1URr1FQy37qq6Y9reEJZku5j93TzE6OrSDahBDfigzJjdbUdu1bw0R4ddN1dxHpb79Rwido0RsLNmjdGHQHjLleeIep+KUo6o1KQEeofSEk7bu2e8dAu5vMzg2I2lGGrW9aY1yupxCjmyqqsxsLdNnqrRRxl6KqMX31yvBDnyMIcGRlgB78mH6/KqW9gARkcvEpc6iDjC51/gX8UbDvE5Th4qqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+p2QoWRHrEVLcW7FFa5ZCIxBLsoh85hXyO9BGDQUXLM=;
 b=vayV3f+QQnW5FjNhZO1Bb3D0VZ+ImGzwoJS+7wt9yGZqqJZX1Fl7NjXC1nzGb92+OFl42ZUDqOGJo4OJivYYQtsibA04s27flD1E5yf1MlIE6HR9TFJbDrYP6iSfDA2DyCoI3rQiv0YhBheDMKrQ6fDzUltp9OlZ6C0ysi8f9A0=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by DM6PR10MB4138.namprd10.prod.outlook.com (2603:10b6:5:218::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 17:38:20 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Thu, 19 Jan 2023
 17:38:20 +0000
Message-ID: <5ba1c062-1e8b-2147-a750-7f151cb3a34c@oracle.com>
Date:   Thu, 19 Jan 2023 09:38:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm/hugetlb: fix get_hwpoison_hugetlb_folio() stub
To:     Arnd Bergmann <arnd@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Peter Xu <peterx@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230119111920.635260-1-arnd@kernel.org>
Content-Language: en-US
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20230119111920.635260-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::15) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|DM6PR10MB4138:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3fadad-4ee4-4353-c4b9-08dafa43f4e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5cWLJ10SuhyBdLtB8G/2eEqkF3TL7e2fE5hujR6stjueW53CG2s8KcJ/Bms4+OltWAj6t3HIHsyfiKNDe2Dban/+bKg8CKMlMYn3C8FuSyo8PDuT3DW53O24BA18IgNB2Wfqz4yHBDZvRihzHFISvmtqLfZlAMBOe2Ki0Z1zMVUKnMVrgxYH5fR2Yc6pAasFnqB/PhMkSHC1Jsqu+vTakmUhLl0KkqBxn7sb1NsfBTUdew8sWZHoccF58XfI1aUGMLeuey3Wq5UV52lGr6EiWe4LzdUv2tSM/fNDgDjOh082L//kmdReJ/8PQjoqPlxsZnQ7xTMmiKRjXvz8CEo67We1gcIVY0KrvDV+LMN142NqsnzSaoNZ8rlvpTaqtk8iqO61fqGGw0pyhJu7gIX3ENfB/jDhT83OY8Z5He0lqQA6at7nE2D+RYsPuBqbpfNY3YO3G82VTg1WTPjerI/RRm8PFlfCs9RvZYNUOmFwxyMoUq4Rp+IH+K1iMUreH0lt1NMgEyaGJ0vLbDmqg6nZWO5aqa0VNGZspQ2CRVo8FtImImkq8dFbWRBLqsUeGlq2q4CLBE8yID3lxGZr6LbbVl9HU21CX1czFndbvRaQU+ZooL8cju1vh53Q+iY0XhzI886tw8pgf7NjHi4c3F6773wQrv0LV/sqX0qO0TrtfJyEri/ISCFR5DHbKsYgzCqllKIr/49zzeLu99NdC+Hh7s9YeF/4yRFFrEEFzuSQGMiGNgll+Fak9aIw6m+IiwFn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199015)(2616005)(38100700002)(110136005)(6666004)(186003)(6512007)(86362001)(478600001)(31696002)(966005)(6486002)(54906003)(36756003)(83380400001)(41300700001)(53546011)(7416002)(6506007)(8936002)(66476007)(8676002)(4326008)(31686004)(44832011)(66946007)(66556008)(2906002)(5660300002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDZxT0EzWDJHTW1ZQSs1VW94eXdzZkYxSURqYjBNUnFNWnZFak1uencxVkMx?=
 =?utf-8?B?UGpYL2dLL2w1SmIzMVdManB3ZjJNeGhvZit2VXFtM1FIL2x1cmxZMHlRMW1F?=
 =?utf-8?B?ZmpFMWM1eXRFTDRRR0VZK1MwVTBKeEhPc21ja1ZkaVZxMXhUc0ZMUjlKSktI?=
 =?utf-8?B?MUM5dm9qRHNvTVRrcm9LWTdOWFMwZUo0MjJyWmhNZmRyVXkrM0djZzVOU294?=
 =?utf-8?B?K3EyYnl6YUtxVGhMeGpwWXRZaEZJZ3Rkb2xvcUVpOEluMWU0bXpRTS9VL3Nk?=
 =?utf-8?B?OU5yY0QybHRXWVh2UHJETkxLUTVYWTcwZExXblRBZXl5TzRNdkxmbHlFVUxy?=
 =?utf-8?B?NFVnc1IwOUUzK1E5bmphSU9Tanc1bHl1b256cGY5TDl1OTZtWDd5YUJMaG8x?=
 =?utf-8?B?MllhT2VaWkFEYmVnbC9yTllqTUp1Y0VWR0gzdTRJRWtpNEZ4eTdRMWRSNmZj?=
 =?utf-8?B?dnNKdi9NOVVtQ2ltdm93WEowWHFqSmNUK2tnOHQ0Sk1hZklhRGJpWG1yZW1P?=
 =?utf-8?B?dzAvWC9OcVdaUXZZbXJoWTRWVzZBQ0pqWDVLUUV4Y2crb25oVkZMdVkzSVVG?=
 =?utf-8?B?YlcwS2EvcnkzcklhMHJyZkR6ZEZaYVU5UG5OWW0yT2RsaGdHNDllbkZabENh?=
 =?utf-8?B?OUM4djhHd2FtRjZxTHJ0dG14MS90TTZsREVkaVU4ZHYrbC82VlRZZk5BQUI0?=
 =?utf-8?B?eDY3eUhweHZRK3FmWXdQZ0FpdTUvRlFZRG9hd2QzbjZmLzNnYUFML2hFdm5i?=
 =?utf-8?B?ZG9EV3hoMHhoTS9iRHFMOGZvSStzVElJVnM3b1RmSEwzSjhOaWZpVGo0WThT?=
 =?utf-8?B?VHhCTVVLSEYvTHlWWWNxSEtCdjBoa2Q1UDVmWW9zd3l6SmphbWtYWFBvcWZo?=
 =?utf-8?B?WTdpTHo5UWs1Vm9pRit3Z1oyMnJmbDUramxMRFhzQ1RnMldDZkhwWFcrVUpR?=
 =?utf-8?B?QThybXlJVTg0TmpMb1BXRllvaHFuWlRhcFAzS2lKRVJSd295b0RrbTA1bzNQ?=
 =?utf-8?B?N3VpdUNMaFJWb0VDN3d3YVVRdWUvMVVUSVlpNXZnUlRvRFhLYkl4dXJLajhp?=
 =?utf-8?B?VmVpeFBibm9WV1NrRGFuakJueS9Ja25YYTJyVEJCd1lqeENSamo3MGJNVFRs?=
 =?utf-8?B?OWtBVS9OQkM1M0RUWmlCcHNaRkkybDFRMHIwMW9XbkxaTHEydUU3T0Z0cFJo?=
 =?utf-8?B?UTlMTnM1aVlYSllONllWY1BHTW1DaVlYd21xK21oVEM0QWc2aW8reUtBcmwr?=
 =?utf-8?B?aWpTV25acU1UcVdGRTVjKzArYTRsOC9rdUcvWHBoRXZtcTNLWmZsYmFtVHNp?=
 =?utf-8?B?emwxS2Q4Y2tZMXJZUXRuQjNBYVdlSGlSbkFnb0l1Y29DSEhsUC9nbFBoY2hR?=
 =?utf-8?B?VHBvcXBCclhMdTZhT0t4RUI0UUdNTE5ZbDI1LzhJT2MvT29rUGxLbHFXd05S?=
 =?utf-8?B?YW1CcVlwMGtqQktHaXN0TVFMRHZUblE3aVdQcVNSR25xNnRJWll2NzJqRkdh?=
 =?utf-8?B?dnp6d25pRG41S015bXNwVmpyWDF4OEZxM0ptdmJWMHVYVlo4RFArRGkyakx0?=
 =?utf-8?B?ODdtQTN1QkVRbzBWY3h6V0pTREp1VTYzbTJnRzBZa0JSZXpTMjJJODBqVWlZ?=
 =?utf-8?B?NERwb29OYWRzdkZ1UUU2Y0dKZ0hmcDZFeURaVlJndHh4cEdkL0ppcGhQTmFr?=
 =?utf-8?B?ME5hbEJpMU5GRjdwZWF6VW5hanJWcWJFSGczakJUMHdMK0tlMmdXK1RtcU1O?=
 =?utf-8?B?U0RnZ28vTjF5SXc3ODQ4S040UHNIdGhqQW9zUnhWa2FWaklZaFZvYnRGejlH?=
 =?utf-8?B?WWZieEhsV0d2dlpRL2FLTjVad0NFak9qdjRiSW5oSzNSa2RpVkcxeUZ0Rmlr?=
 =?utf-8?B?dHdGeXQ2ajJ6OGhpSlFpNHlJNnlLRHBHaDlneGpCdC9ENEpjOUVpK0N2VDFG?=
 =?utf-8?B?L05mc3JMMWRGdEpycGo1NzRqZndvN01vZkpVV2IrbkRSOVlmZ1IwTHQzV1lv?=
 =?utf-8?B?RE5hVnh3eWpWcGRVbHA4U01DVjlZSmU3V3hpYnRGV1NiU05Bem5Fc05qMVhu?=
 =?utf-8?B?RWsxbnZxdnJsSElOZkxWT1dLTS81eWNoVkx2OUZFQVkvZ3hMWWlGSDVXV2FJ?=
 =?utf-8?B?OWIzakdBa1NEMHIvZERmNFZZeldDTlZuSGpJYitwdm9XaGpCL0lycXZKOFVM?=
 =?utf-8?B?Tk4wbUMwekdTYkxTVkJnU1ptVm1NRWFuL3MzWkZUcUdoRW92UkF5b0ZvK0ly?=
 =?utf-8?B?SXl5RTlYYk00ZGhIWVN2cHJ5Y253PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YUFsODZEZ09KMTJlcWhzZ0Zqajc4YkZXTEZ4NEtIWUpWQXVFSnlWN3lENmJu?=
 =?utf-8?B?dGNpRitVdjVnaFhieXhzN2Jwa3RFS2ljbDcxNi9LanJvZ2xWWmR5MkMycVdB?=
 =?utf-8?B?Nmp0OW9HcXB3amNUWG94c0lsY0dpN1VpeFN0SnJia1p6OEFUQ0VyeGZEUXp4?=
 =?utf-8?B?aEFvTzJDbStlZldaMnpSdHV3UDlUc1VpSDBpVzh3bS95MmNuZlJCTWFFQ2E5?=
 =?utf-8?B?OWp1MUtBY0RjUys5L0grUlNWWmtobm82ZDVrQkhuU0RhU2JaTlZyVUFLUFBq?=
 =?utf-8?B?OWdZdy9aZHA1VWJqOEVQQ0x2eGtmVG5WOXNtbWlPdENDZnU3dUNmQU8rT1BF?=
 =?utf-8?B?TlBsczNvN0w3eHNGK2IwYkhnOWc2blVGYS9IdWxQc0VVdjAyek9Cc1BHRzVR?=
 =?utf-8?B?eG5mb0RHN2RlODg2V3Voblpmc09PRU1HWnFuTTJ3Sm92dTFNRlpjRnFiWUIy?=
 =?utf-8?B?cTNjbXdiZWZUNHpqMjZrdHpzbHlMM25GU3pMVGkrdGZtdWNWMDFRTjA1MU81?=
 =?utf-8?B?eE4vZXA4SUtuM3Y0T1kwRndTVm9ZMUlIRlpIeERvQkZXVWIzY25FaVFLcmJL?=
 =?utf-8?B?UndMa0M2eHV0Z3VyWVliZ0xqZnpnTVNLRnFyOEE4eUZtSzRlZmkyb0YxRzN6?=
 =?utf-8?B?ZnhGOXhYb2huQzNWTHc2OER0RC9ZdmZvWllBZUdVanBhcmcwZlA1MElvQ05m?=
 =?utf-8?B?c0dEa3dtNlJ6a2hEMUhBdWNUcjlzODJVakxVVk8rSDFFVGRTVDVENWJxbURC?=
 =?utf-8?B?QjA3azByMmZXRlAzaE9PZlR0cGdYakx6Wnh1VCtUaTRuM2VPQkhsS0RtS09R?=
 =?utf-8?B?Wk8zNnRRZ1hkeVpGdFNXTHFybytvNitId0x5cFhXem9RaEdBeEtyVVViYVV3?=
 =?utf-8?B?TXl3NjZmV1YxdWQ1QVJ0UXZmN0ZDOVk1RkRLeE02T25ZSUpwUncxL1hMOTJW?=
 =?utf-8?B?VTZFZWtsMnVtK3Rtc0ZBQTAxNEFZZTQxQWhHV0R0VXdtdG1oWExlRWd4WlI1?=
 =?utf-8?B?N2hUdGQ3dTJsT3ZkakJWVnZzdzYwb2MxTmdZM01yRFUzSlVibWprbjZmdkho?=
 =?utf-8?B?aHpSNXIrcVczWTF1NmZNWEt4cWVZNy9JcnF6c2ttek53SEZzaXFsazZ2eFlE?=
 =?utf-8?B?bllWNXRINWRmV0NqN2JHem0remZmNi9wZmNSS0Y0dGswOWFxeHQ2TDBwZSs3?=
 =?utf-8?B?SzJIVmxhRHVvOExWdmJsNjdmblBicnlPTmNJcjllQm40Y2R3WWk2TGpJREFx?=
 =?utf-8?B?NmROYUd1OGUwbGVGZGxYYnEwVy9kNzVoR1dNZXV2N1BFeUZETEJNWHVwajRY?=
 =?utf-8?B?Q0ZHZDlpaEdaclpvVEVEU0dMbi9XSWJyd3BuQ1ZrRWpNSjgreWw2RUFCblVy?=
 =?utf-8?B?WDRVNFNOUG1sV1BtWVJ3OE9XR0t0dEhMSDVvMU0xQ1ZPL3lYd1p3NER2YTJy?=
 =?utf-8?B?eWlmVVE2cEFHNjJDNnRhVjdQN3FNTTZqZ0U2aDhRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3fadad-4ee4-4353-c4b9-08dafa43f4e0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 17:38:20.7907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCWM3rlE9Czb/XWWPzliCclcUo/df0z0V815bI0B9bG+iL1ORJrdUIBbd18EI9fzfR66lbMpdmpwcAu5ff+aSjOdp4Q8N2DxL5xMScXnkc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4138
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_11,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301190145
X-Proofpoint-ORIG-GUID: gpzWiEmfhkhw28fXdc6J5zUlPah-THYl
X-Proofpoint-GUID: gpzWiEmfhkhw28fXdc6J5zUlPah-THYl
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/23 3:19 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The folio conversion patch only changed one of the two implementations,
> the empty stub one still needs the corresponding change:
> 
> mm/memory-failure.c: In function '__get_hwpoison_page':
> mm/memory-failure.c:1335:15: error: implicit declaration of function 'get_hwpoison_hugetlb_folio'; did you mean 'get_hwpoison_huge_page'? [-Werror=implicit-function-declaration]
>   1335 |         ret = get_hwpoison_hugetlb_folio(folio, &hugetlb, false);
>        |               ^~~~~~~~~~~~~~~~~~~~~~~~~~
>        |               get_hwpoison_huge_page
> 
> Fixes: 92e109a2c5a7 ("mm/hugetlb: convert get_hwpoison_huge_page() to folios")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
Hello,

I also posted a v3 of this patch with the build fix here: 
https://lore.kernel.org/linux-mm/20230119011057.91349-1-sidhartha.kumar@oracle.com/T/#u

I'm fine with either picking up this patch as a fix or picking up v3.

Thanks,
Sidhartha Kumar


>   include/linux/hugetlb.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index f14a6bd2a6ed..06eb59711e4a 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -417,7 +417,7 @@ static inline int isolate_hugetlb(struct folio *folio, struct list_head *list)
>   	return -EBUSY;
>   }
>   
> -static inline int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison)
> +static inline int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison)
>   {
>   	return 0;
>   }

