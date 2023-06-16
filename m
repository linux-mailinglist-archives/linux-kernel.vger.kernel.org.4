Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643D0733866
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245444AbjFPSxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjFPSxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:53:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ACD3AAF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:53:15 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GCicpN024827;
        Fri, 16 Jun 2023 18:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=adQyZxJq6VVxH7xeENXggoOgzHCyFjsGkIyxHxjb2Bk=;
 b=Hn8g2h4kBKFCZ4J4W/ODLvN+sw5usn4eU3usmUcHRrc4M/gILSRgRDtFRJNB+THqQjLP
 ECKQeoWWYIhWu2tIgkCCDY0zKXrhGn8Q8du3dYNGxP9gK8UsqpJXtssC2oMf4chDKNVv
 taznSF5EfkTlzIN2aEVrRfXBrCZtfeHZpd5O64OakjyuTjJFxUbyOgw5pakBnCCOHET0
 JPPMsM9g4SaVItyNX9khxfjZpoHLCSC7wWXVd5qMOMvmqzyVopAmnth4whuPvkKZb1AV
 cJcPQUEyaulZxcIJh8Itju+lFDIcrPFUamHI5yvaINv4urnp3/JaIhaaEzhvtJWGtBel 9w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4hquvwab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jun 2023 18:52:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35GHuJpe011492;
        Fri, 16 Jun 2023 18:52:47 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm8mb9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jun 2023 18:52:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Na9nfEYcWDL2HXLJzL8HqYG38wML7IwW5VanRt00848yc6oDJ9eOrDEjMEhEdGBDb7H+kpZXQ2T5EPwcdrnXDYRCZ7flD4FF5D4b10VMiEk21e5m4qSG82Wk3LET5W4Y1c2ZRlROlIIKwIKfhrkpy0ySHLlvb5IRSdr6Uu+PORVtJaDdDb4Ehlii/1h0dFcXtETn3dtiusql47SNAvCleycqHZQ9Gag+S4/QuXMlb2So8EmzjTo03jnhKNxT8IQYkOtglzyzgGfC5rkCil3xm/9IbwBExIWuXV+5wktWCvPs98wW1ZijZTlgLvSJjU8+gyBs1FuKBqNcVq8FCbmh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adQyZxJq6VVxH7xeENXggoOgzHCyFjsGkIyxHxjb2Bk=;
 b=RpJWz/lxpVcibioq7hHGBJ0C25fod+jBzXuNdmo5F5EkFcfyZaTd9avxDxIhAY68ExT3c3QkFQMgaym6repQ6eX7yZSetuV0LQO+xdhsOdxc0/NXVb86e+QbCXWQ4T80wy0qSt/sGTIcthWgw3uDBqF+8tHIGmmmVtIW2fUikZZqoMU6ZOv7jhUaG3DbS1K0Ym8gwiJ1eIY2Zojr7qVNfrof7CrN1QOk/eoFUNMx3uvJByfa90WuYGcJNCIW7pGAL1ymRzBCn7MZ1i5a/G8BNycKmvKqQNsmnAEPaMyDN4h0VP49Gt/TCMa5fiULwU2kKhXUhJrL6OsHQq2VkxX2NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adQyZxJq6VVxH7xeENXggoOgzHCyFjsGkIyxHxjb2Bk=;
 b=hYeqvV5+/+XP5x75Mn4VSTcRq756WAU3mO6Fu0g/aB2CtkWbiS5wgQpfT84rXGUaqjObZ1HS97RPnW9qlykFaXwhf7Mv/l4h+YJbqblP3j+yQvW039QslV7td6UOJ4DoU7LUbncodbFFktXG1u9ZtWfGxh0lOkxsHfjqT/b6WhY=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 18:52:44 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6500.030; Fri, 16 Jun 2023
 18:52:44 +0000
Message-ID: <b9ba6f95-5da5-2cf6-00d0-77650ba2e7f3@oracle.com>
Date:   Fri, 16 Jun 2023 11:52:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH 2/2] mm/hugetlb: add wrapper functions for interactions
 with page cache
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, david@redhat.com, nphamcs@gmail.com,
        jthoughton@google.com
References: <20230609194947.37196-1-sidhartha.kumar@oracle.com>
 <20230609194947.37196-3-sidhartha.kumar@oracle.com>
 <b3faab36-370c-1635-3ccf-33d51f53859c@oracle.com>
 <20230615233624.GB29046@monkey>
Content-Language: en-US
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20230615233624.GB29046@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::12) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e542c07-5075-45b7-6d4d-08db6e9adea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Laph4BEv9F7va87QJqvXLLweL0Yqb8a2gjjkIhwVSO5N5XCq6B4+ei54S+qp4uJEawfAvEQe/bkgqFbVtuuSfj1F07bByucAkPGfoArZ5O56xCa9NQnuAldkTCq5Jk26mj1KLFmnPYOoXEnny63luJltp19BvqcqmAy+yAJzkC2qeGuEsHSqryXgDn5qsMi2JixXTOmWvpdPTR/H7fxklo5SKTS7HrGsIlvgvMeVXaPZORt2UuA5bx8QIAgaOfXPVGzM+LN8FWqjU95r90chGYxsEQZWFu/O0r7PhJTW03xxorIK/HUlIDIQHbuwpMQ+EPZCrrOIc7988MUf0hoeUmnG6hXOeMzxXWHDLDf2HRzykqo/qqjhWwQ8ptL+YdmvHDrww3sSALmtTKYzVVbcK4yq9UM6fsCaI6mF8Ll33S92iDOGEFUzhekKSbF5UZTxuQQog0cSHPbya36RRW5AC+RiMRVbWpqqeZNXsm3hmTVoRnZNLyLI5RLXh9mhoIKKBi7bZFSnU+BA1LQqWapzfpBOXWe4b4bQdnxfXg2h7u7gNxCfUd8nKhMq+Bce7RKU4yyqWbtFwwv5FCC4KH40oVWi5BAV0Gm2H1XHEKym+p3ef843teh74sHuxOfJ493ROCfWCNcYz8CaJ9klHO/NnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(36756003)(86362001)(31696002)(37006003)(66556008)(66476007)(6636002)(4326008)(66946007)(316002)(478600001)(6666004)(44832011)(6862004)(41300700001)(2906002)(8936002)(5660300002)(8676002)(38100700002)(2616005)(83380400001)(53546011)(6506007)(186003)(6512007)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3RzUFg4QlNZYUVUSE1xOE43Y2I4QlRyRU1kZlUvWFc4L1NMVXF0SDZLbktY?=
 =?utf-8?B?bXdNNERmcjZJZzdyVCtYOWdpVG9ma0t4UnZUbTFCNnBnSW1NOXFLU3JtM2ox?=
 =?utf-8?B?WW9iUFNQSkRLU1kzRDhWTlMwS1BWaVFjSmQ3Tld0M0IrcjFOaTUvSUJMakxC?=
 =?utf-8?B?ckttalB6S0RWMGRCQnFBa0tUSUQvR2R4Q01nTUdQb3VkNmdETzhKbXpWd3Z5?=
 =?utf-8?B?UHZMRW1VRkIzZ08ybGt6Y1lMVU1yak8xMzkwZ1haNFhuaGhGMEErdm0zYkgr?=
 =?utf-8?B?bGZQdzdRdmhCZFN5NkE4VGZhV1JBQUZwQk5NbXVLSEtnbE1ITGNOOEY5NzhG?=
 =?utf-8?B?VDR5ZmI1RXp5SVZOcHBlQXhyanEzRno3bis4Mm5hQjhqaWtpNTJwYTdua3VR?=
 =?utf-8?B?dytJem9ZcXIvMnF1VWEyd1laNEpsUW52UjRSdHhLZmhFVmMxb3pxU3hRWnBP?=
 =?utf-8?B?eUI2NFBOcHBDTnRKUjRsQ3FiazRoT21YdDFrOWVLZk8xQW53OHZ6bW5qbHdD?=
 =?utf-8?B?cVRYd3Q0ZlZiV1JKUjF0bXU2VGdmYURVK2JxVzNuTjF2ZzNicXI4c1Jkdmo2?=
 =?utf-8?B?UEVmSFNMTFBKN0FBQWpaUmdaMko1MnRPeU5sZ0J1VWl4OE4wNGFmT2VPNzFF?=
 =?utf-8?B?Q1ZuVDB5REkvdGRPZFBvbDhUSDk5MFYzY0Z1SzZKN2hhYnh3eDNIdGc2aWs3?=
 =?utf-8?B?eEhEUUN6Vkt0UDYyWDRFSkdqQzZFYkh6N3I0S2J3dFAyK01nZFo2bXdWTXYr?=
 =?utf-8?B?Q2VQUEFuMVA3Um9vVDFudERTRkVXVmtpcFB5TlF6QVEvaG84QTJhUkY0VTZD?=
 =?utf-8?B?K1VNaU5iQXR4VHZyaHd4QXpmandPOGZwckwxd0REcjR3QjB4VmIvSWRXdnYv?=
 =?utf-8?B?OUJ6V25iOEsvejhOeHY2OG0wSXdUK1hQbVJRRk9HVlVGNWIwM2lUcHZIVnlr?=
 =?utf-8?B?SVYydmpEUXV1UnFLbmsyU2U5cHJ3aDlrU2FLeWJncmh2cWovd2dlMzRGN1hX?=
 =?utf-8?B?M21OOGFnT0MyYTdCcGRNNUZPbXdmZ1BZZ255RXNodW1Vb1loZHBsVExxZFFt?=
 =?utf-8?B?TmZYQmpmYmgrWUh4VGJGcFIrYjBTZnZiYVVqZURXTTk5RjNmcTN6ZmRkVWNO?=
 =?utf-8?B?Zk9PYzdmUEhxR3JKZm52d2tWMlVwVnp6bjIxZ2VSZVdOQW9Idnd2M2pVeCt1?=
 =?utf-8?B?TWhDWmdHRzJxRTlCaW5FelFNa3pkMnV3VHdTNjUvaFZGWE05NXFZVjloNS91?=
 =?utf-8?B?c1JDc2hOcWMwMXAwMnNmdENCYzgyR2ZPUWx4VzNNZ25aSUIwWmk2R1RuYmhU?=
 =?utf-8?B?NFZmR05idEFYWHQ1UlZPcHNVYVpjRTNlV3MvcUNkMFN6VXI5V0VuVEJ0OTdp?=
 =?utf-8?B?Z0RPaWZnYnVuR1VqamxEZDZoTTZKV0JmdlE2N1YrUERoYS9jbDFVZ0tSTVBV?=
 =?utf-8?B?MGtYVDVLTHFSYlZXWlVoT1RpRkRlNHlyRFU0ZWlnNkVqRTZBV3pNTnBaWEhY?=
 =?utf-8?B?NTFCd1pWUTgrNGYyVS93eWZBS2xDN2kzNnhjS1lqSmNVTzFHU1VDYlFQQkdh?=
 =?utf-8?B?RkVRZHE3TnQrL282VjdIR0lHOGo2cTIwa3FtM1lXb3RlT203UUNrNUVFcHJU?=
 =?utf-8?B?REIybHRxN3dqaTUybUtkb2pEZVplOWpIdUpETk5hMDhyOTVMVTJFUkplbVVW?=
 =?utf-8?B?c1c4bnM0RDF6bGNJaTBaSWFyU3QwL2RDYkFaMjhyTlhEVDVjeXhEbTVwNHlL?=
 =?utf-8?B?dzVIYSs3U1JoRVhHSUJYL2gxVnFkY0NSZXZXT1BRUDBrdytITTBXc2ttSXFC?=
 =?utf-8?B?VGxkdUFBYTAxSWxjSnBFamQ0MXF2MThsSkdWZUxBckF1Zkh4b1Jib2xHNzJS?=
 =?utf-8?B?RkZpSlFNdTJza3R1N0FpUElkOWZDblkzRkdWVjJld1ZCSTZvSHFBYU1Sb1RF?=
 =?utf-8?B?Rkxram1MSnNndEdlQlU3SzlqYmw5NlkrNmxEbXVrVlMvMmZsTXlvM1pNMVBP?=
 =?utf-8?B?M242MjhLbkpEMFpscFlUSjFiekF6ZFBlSmp0NldZeDIrbTc2dTFQK0xkM2Np?=
 =?utf-8?B?M0J1aG1EcURYc3lFZGFHTVJUdTNKRzhtTlludXFzdkNFS2c3WUJVNEh2MXpw?=
 =?utf-8?B?QnJQK3p2Q0xISjRRWUhOWUpFYVhXV24xY25oajFSc2p0bEdnUWY4RDRvWUhj?=
 =?utf-8?Q?7DEYvEi8LiO6bKqIWoo1Blo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RzlhcEFndi83V2phQ3hMVG45Z3VPYTFYWHBrdFN3VENidy9ORDBHME1kaENj?=
 =?utf-8?B?ZFpJQmRVdStza2tQajBObEtQS3Q3MkpjYWcwemVqUWR2L2Q1aXdpR1FibWRv?=
 =?utf-8?B?WnFVbVk2Rm1GcEt2dXlyTHNvbWt6MHMrVmRiMkRLdEk0ZVo0eTZ4WHJIY3Z3?=
 =?utf-8?B?a2duZVNhbk12SEFsT084ZDFsUEkvOUdONCtmRFdmUk5mU0swamlOb0t5MmtW?=
 =?utf-8?B?cU5na3hxMkxIcUpKVFlVOUdnY0EwQXlWTmxxdDlDd29NVU5mNzNGWW1hbWF5?=
 =?utf-8?B?Qi9QSDJDUjJKOVd1MnlVVEtGcmVXai9sckY2b1BkaTlmclk0QVQ2T3pDWGFR?=
 =?utf-8?B?cUtpNjFjR3drdUc2ZUVETUdHdzhiVmRBT2hWb0hUY0drNzZxNVRQVlcvMXRl?=
 =?utf-8?B?ZzlCMFZZUjZ0TmpYVGt5SG5FMFp5emwvNzlxcjdWZisxR1gwVUtha1lqMG1F?=
 =?utf-8?B?bEc2RHNhaWFsUnRrUTdLd3UxK0FJKzBiTTFUYVdndlZkcElQYXpiZzZzTWR1?=
 =?utf-8?B?a3dsR3ZtMEIzOTB5Wm14d20xRnd2Yi9TU0RQdE9PSXhIenVKL1RLMUY0WHpv?=
 =?utf-8?B?Q0hjc0JqeG5vTnJ1T1RIN3dVQVBjSFRIbkM1Q3hwTzVaNHNxWWVnU2tpK3hs?=
 =?utf-8?B?QkhEVXVaOExGSXhSRzRXSThNZXZ4RVNqV2kyUnNlR3Y4ZWgyN3drdHFSYWxj?=
 =?utf-8?B?WnVqNTBYVk12Q0NaMS9ZdXNNaU92cTIwempFRHN0bjQvZFczSjhldEpmSjUw?=
 =?utf-8?B?am9JOWxZaXU2OHpBVjZFa1U0RHdrYmFGZCtCZExEbG9zWkZKUW9aeWROK3c0?=
 =?utf-8?B?clAwYWpmWFF2OTduVXBkaHgwZVVUdlhFYk5VNGxBTlhzT1dEczdQMEl6OGZy?=
 =?utf-8?B?S2xvWTBXYXdoTHd5MmZJQS8rU3NLWVhhQlFmditVd08rVTFKVTk4NVNnZGhX?=
 =?utf-8?B?bVhTa2xGcm1GR21vL3lOOEFGaEs5VmtjMUhSa2toa0VDV2ZIaDY2QlFNOHlK?=
 =?utf-8?B?VHoyTGNIelJBbWllU2w0VmROWEs4b2Z6MDkzVUJFZWowTEd3Z3hlcWlveGlG?=
 =?utf-8?B?M3dydUZLcENzeVVLZUpyMU1Md3BXYUI4MDU0TnJob0hqNEZOeFhFVnp1WHg0?=
 =?utf-8?B?LzEvYThVUVRicDE2S3hWRTdiVkt6c2JSdzdhWHFEVEplbUFUb2FDOTQ1ajZK?=
 =?utf-8?B?eTM4RHpQd0R2d2lJZXJpblJZczdsenN0RDRYZXVFcGxoUDN0TEEzaUFpT3cy?=
 =?utf-8?B?Zi9xSDYwazBlQjBSa0ZRRFhJQzlVU0VPSWFzbjhSekZVb0d4UzZCSTBjaEFE?=
 =?utf-8?Q?+3/XYcIocVjYf8VIQRV9esaUyy/6RLHQuS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e542c07-5075-45b7-6d4d-08db6e9adea9
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 18:52:44.4170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJ5DMOc/ObWkcRsPXyN6s9AydGCi6otAh/hx7RQrAPdxDcuKWbf5Oj8VRg+6zcZMDxQBmYcwbVVhSHOC3Sou3+nhiKTmbhWWNLRBFdAsFSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306160170
X-Proofpoint-ORIG-GUID: kw4kfqxCD7tZB2eMKBN0vSF5Zp2MtJ6F
X-Proofpoint-GUID: kw4kfqxCD7tZB2eMKBN0vSF5Zp2MtJ6F
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/23 4:36 PM, Mike Kravetz wrote:
> On 06/09/23 12:52, Sidhartha Kumar wrote:
>> On 6/9/23 12:49 PM, Sidhartha Kumar wrote:
>>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>>
>> Sorry, I missed adding the commit message to this. It should be:
>>
>> Add filemap_lock_hugetlb_folio() which is wraps __filemap_get_folio()
>> and passes in a linear page index. hugetlb_add_to_page_cache() is modified
>> to also compute a linear page index before calling into page cache code.
>>
>> linear_page_index() is modified to perform the computation on hugetlb
>> so we can use it in the page cache wrappers.
>>
>>> ---
>>>    fs/hugetlbfs/inode.c    | 14 +++++++-------
>>>    include/linux/hugetlb.h | 21 +++++++++++++++++++--
>>>    include/linux/pagemap.h |  2 --
>>>    mm/hugetlb.c            | 22 +++++++++++++---------
>>>    4 files changed, 39 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>>> index 90361a922cec7..90d27a8af4b6a 100644
>>> --- a/fs/hugetlbfs/inode.c
>>> +++ b/fs/hugetlbfs/inode.c
>>> @@ -617,20 +617,19 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
>>>    	struct hstate *h = hstate_inode(inode);
>>>    	struct address_space *mapping = &inode->i_data;
>>>    	const pgoff_t start = lstart >> huge_page_shift(h);
>>> -	const pgoff_t end = lend >> huge_page_shift(h);
>>>    	struct folio_batch fbatch;
>>>    	pgoff_t next, index;
>>>    	int i, freed = 0;
>>>    	bool truncate_op = (lend == LLONG_MAX);
>>>    	folio_batch_init(&fbatch);
>>> -	next = start;
>>> -	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
>>> +	next = lstart;
>>> +	while (filemap_get_folios(mapping, &next, lend - 1, &fbatch)) {
> 
> This does not seem correct.  At this point next == lstart which is a file
> offset passed to the routine as opposed to an index.
> 
> I would think next needs to be set to 'lstart >> PAGE_SHIFT' here.
> 
>>>    		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
>>>    			struct folio *folio = fbatch.folios[i];
>>>    			u32 hash = 0;
>>> -			index = folio->index;
>>> +			index = (folio->index) >> huge_page_shift(h);
> 
> Here you want to convert index from the PAGE_SIZE index to a hugetlb
> page size index.  Correct?
> I am terrible at arithmetic, but huge_page_shift already includes
> PAGE_SHIFT, so it seems like you want this to me.
> 
> 			index = (folio->index) >> huge_page_order(h);
> 
>>>    			hash = hugetlb_fault_mutex_hash(mapping, index);
>>>    			mutex_lock(&hugetlb_fault_mutex_table[hash]);
>>> @@ -693,10 +692,11 @@ static void hugetlbfs_zero_partial_page(struct hstate *h,
>>>    					loff_t start,
>>>    					loff_t end)
>>>    {
>>> -	pgoff_t idx = start >> huge_page_shift(h);
>>> +	struct mm_struct *mm = current->mm;
>>> +	struct vm_area_struct *vma = find_vma(mm, start);
>>>    	struct folio *folio;
>>> -	folio = filemap_lock_folio(mapping, idx);
>>> +	folio = filemap_lock_hugetlb_folio(vma, start);
> 
> Here you are passing an address/index that may be associated with a
> tail page.  I assume since the hugetlb folio is multi-order, the
> returned folio will be for the 'head page'.  Correct?
> 
>>>    	if (IS_ERR(folio))
>>>    		return;
>>> @@ -868,7 +868,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>>>    		}
>>>    		clear_huge_page(&folio->page, addr, pages_per_huge_page(h));
>>>    		__folio_mark_uptodate(folio);
>>> -		error = hugetlb_add_to_page_cache(folio, mapping, index);
>>> +		error = hugetlb_add_to_page_cache(folio, &pseudo_vma, mapping, addr);
>>>    		if (unlikely(error)) {
>>>    			restore_reserve_on_error(h, &pseudo_vma, addr, folio);
>>>    			folio_put(folio);
>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>> index 21f942025fecd..55f90e051b7a2 100644
>>> --- a/include/linux/hugetlb.h
>>> +++ b/include/linux/hugetlb.h
>>> @@ -727,8 +727,8 @@ struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
>>>    				nodemask_t *nmask, gfp_t gfp_mask);
>>>    struct folio *alloc_hugetlb_folio_vma(struct hstate *h, struct vm_area_struct *vma,
>>>    				unsigned long address);
>>> -int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
>>> -			pgoff_t idx);
>>> +int hugetlb_add_to_page_cache(struct folio *folio, struct vm_area_struct *vma,
>>> +				struct address_space *mapping, unsigned long address);
>>>    void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
>>>    				unsigned long address, struct folio *folio);
>>> @@ -755,6 +755,16 @@ static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio
>>>    	return folio->_hugetlb_subpool;
>>>    }
>>> +/* Wrapper function for __filemap_get_folio*/
>>> +static inline struct folio *filemap_lock_hugetlb_folio(struct vm_area_struct *vma,
>>> +						unsigned long address)
>>> +{
>>> +	struct address_space *mapping = vma->vm_file->f_mapping;
>>> +
>>> +	pgoff_t idx = linear_page_index(vma, address);
>>> +	return __filemap_get_folio(mapping, idx, FGP_LOCK, 0);
>>> +}
> 
> I like the wrapper idea.  This is going to replace existing calls to
> filemap_lock_folio.  What about something like this for the routine:
> 
> static inline struct folio *filemap_lock_hugetlb_folio(struct hstate *h,
> 					struct address_space *mapping,
> 					pgoff_t index);
> {
> 	/* please verify my arithmetic */
> 	return filemap_lock_folio(mapping, index << huge_page_order(h));
> }
> 
> In this way, existing callers would only need to be changed to pass in
> hstate.  Perhaps, there was a reason for your wrapper not obvious to me?
> 
>>> +
>>>    static inline void hugetlb_set_folio_subpool(struct folio *folio,
>>>    					struct hugepage_subpool *subpool)
>>>    {
>>> @@ -1021,6 +1031,13 @@ static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio
>>>    	return NULL;
>>>    }
>>> +/* Wrapper function for __filemap_get_folio*/
>>> +static inline struct folio *filemap_lock_hugetlb_folio(struct vm_area_struct *vma,
>>> +						unsigned long address)
>>> +{
>>> +	return NULL;
>>> +}
>>> +
>>>    static inline int isolate_or_dissolve_huge_page(struct page *page,
>>>    						struct list_head *list)
>>>    {
>>> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
>>> index 17c414fc2136e..ae8f36966d7b3 100644
>>> --- a/include/linux/pagemap.h
>>> +++ b/include/linux/pagemap.h
>>> @@ -860,8 +860,6 @@ static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
>>>    					unsigned long address)
>>>    {
>>>    	pgoff_t pgoff;
>>> -	if (unlikely(is_vm_hugetlb_page(vma)))
>>> -		return linear_hugepage_index(vma, address);
>>>    	pgoff = (address - vma->vm_start) >> PAGE_SHIFT;
>>>    	pgoff += vma->vm_pgoff;
>>>    	return pgoff;
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index dfa412d8cb300..824d6d215a161 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -951,7 +951,7 @@ static long region_count(struct resv_map *resv, long f, long t)
>>>    /*
>>>     * Convert the address within this vma to the page offset within
>>> - * the mapping, in pagecache page units; huge pages here.
>>> + * the mapping, in huge page units here.
>>>     */
>>>    static pgoff_t vma_hugecache_offset(struct hstate *h,
>>>    			struct vm_area_struct *vma, unsigned long address)
>>> @@ -5730,7 +5730,7 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
>>>    			struct vm_area_struct *vma, unsigned long address)
>>>    {
>>>    	struct address_space *mapping = vma->vm_file->f_mapping;
>>> -	pgoff_t idx = vma_hugecache_offset(h, vma, address);
>>> +	pgoff_t idx = linear_page_index(vma, address);
>>>    	bool present;
>>>    	rcu_read_lock();
>>> @@ -5740,13 +5740,16 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
>>>    	return present;
>>>    }
>>> -int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
>>> -			   pgoff_t idx)
>>> +int hugetlb_add_to_page_cache(struct folio *folio,
>>> +			struct vm_area_struct *vma,
>>> +			struct address_space *mapping,
>>> +			unsigned long address)
>>>    {
> 
> Like filemap_lock_hugetlb_folio(), can you just add hstate to existing
> hugetlb_add_to_page_cache() arguments and do arithmetic to convert index
> to PAGE_SIZE based index?
> 

I wanted to avoid using "magic numbers" through doing arithmetic shifts 
to convert the index and instead explicitly use the linear_page_index() 
helper function. However this does add more complexity as the function 
parameters are changed. I can change it to doing the arithmetic shift to 
minimize code changes for v2.

Thanks,
Sidhartha Kumar

> Again, I could be missing something.  But, IMO such a conversion would
> minimize changes to the current code.

