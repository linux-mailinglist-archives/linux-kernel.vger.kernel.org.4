Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF13267839F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjAWRu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjAWRu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:50:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD3A2FCD1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:50:55 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NHYWEg006863;
        Mon, 23 Jan 2023 17:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=Tz8J3cd/Xy0xV+g024/bV6zXkCRuBWs9OYDHyhQN750=;
 b=iu39bWAO+bMuqHCeW5UoIXttGXln5KRFWIRBhR90j7O9omho1LUHvJpyntPrz9G/Ch9y
 0QRsyPd7GSR8M+1MEt2wjVVZFPA5AwBp9PzdmU9iU0kDRmCeFTE16D4g4i8yGDbpYF0N
 NuakHQ2bKvs+YMqQGRbceaH3bU9uWJ1QfDqsL9f45o/8Tj0psoAXDHXYHqk6qZxCYall
 dky/sj1u65QXkMGx/qyB4/96az+18AQ621IyZrLaavqBHBxvLhWwX+N7A40mKR+t40G/
 uorX9oiVq+G7hKy/SEJ+rVn5IjboIvUlnsxN0CnmSdPl/irNYZK1UZy0o0/zbsU5QBKf Iw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n883c3ekd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 17:50:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30NHjBHD001093;
        Mon, 23 Jan 2023 17:50:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86ga4792-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 17:50:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GF4QK207N1lT0SheCsaR/b1cmqxWLjqi/+wTUPEl5OVx/4oc9+tPeboEHa4a3ZAIamZrPWnsfK+qIXaXmuVXur788NSxG0R17A0FeV1XsoFyuakaTXKV+yApL0q7SUFttpBouqGgJRIjhsk47krfySN9olkUwgZiBEwxGf0QcsMq3yYW6eqBbTtviDDh2eEiOxyOkReQ2J6gpAeQAeg8E+Qc7UX7/4Uu4jWECh9a4/Duvz/3mtjsUzllFi+OIg4h6SX1BYDmoBRTaeo+YPHcQYQTtginN1hH//n0KSHkn6MCBievye+AC56iy7MR/30hFs/suBzQfVFy2nD5NUigbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tz8J3cd/Xy0xV+g024/bV6zXkCRuBWs9OYDHyhQN750=;
 b=ehS4QC4QlwMOx6mWAWq3pgU3YS+vDZrFGUDHTIh8F2Mt6bcCNIxsMJZsVpzr69ozr44pCioqnyv8WdwlsRnd+wQzlyWf3Y0IEYhgh1XCqzvy7FFP0y3/HHJY903wsGSaZGPrVrUdqOHwhWYinlkRx/v6328WOYgtnKllvDk6t5ICo10bGjl7cfhnkBRi8SS4xcLbPpHa75LAOGtfDZUO+evrGMvKif0l2VkKHnMpegCaZenho+M8hapXcjkZYJYrB12PTY/htNNIrbEUPqjoFphADxqCEmtoQ+HFY4Mo75svtN2x1MZBrCJ0V8iSbnYQBanTz4TNWiY49u+joYcb6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tz8J3cd/Xy0xV+g024/bV6zXkCRuBWs9OYDHyhQN750=;
 b=tQ900WDe2jvnXqAvWPEknvL88VzoB3zANfpFCZgYRHF9HDizVpwhAbpKrwoRe++V80x9kOm6og7shzVMW9SCJLIg5hIbdcU3Pqp6BQme/7nWQmRAgNMi3Q3+q9ZnWyDoksMFpe3oMgD/PB7UL9hLTYpQWeu/T8MNScNy5oUOzO4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN0PR10MB4968.namprd10.prod.outlook.com (2603:10b6:408:12c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.16; Mon, 23 Jan
 2023 17:50:02 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.6043.016; Mon, 23 Jan 2023
 17:50:02 +0000
Date:   Mon, 23 Jan 2023 09:49:58 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     James Houghton <jthoughton@google.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for
 walk_hugetlb_range
Message-ID: <Y87Ixj5GJJKz7a/U@monkey>
References: <Y8hITxr/BBMuO6WX@monkey>
 <CADrL8HUggALQET-09Zw3BhFjZdw_G9+v6CU=qtGtK=KZ_DeAsw@mail.gmail.com>
 <Y8l+f2wNp2gAjvYg@monkey>
 <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
 <Y8m9gJX4PNoIrpjE@monkey>
 <Y8nCyqLF71g88Idv@x1n>
 <CADrL8HXkdxDdixWRKNw6RFdbiBX-Cb1Lk7qxg6LdeNywbMOaOA@mail.gmail.com>
 <Y8nNHKW0sTnrq8hw@x1n>
 <Y8nV2TvMK12yTPzE@monkey>
 <Y86lZxGEQOBv3Hmw@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y86lZxGEQOBv3Hmw@x1n>
X-ClientProxiedBy: MW4PR03CA0124.namprd03.prod.outlook.com
 (2603:10b6:303:8c::9) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BN0PR10MB4968:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fea9578-0bbc-4ce8-ce73-08dafd6a40cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KWQmcUtWKJE7Gm8lNgOq6clYZD1+HqIevTno0C3j+yehnUb9GAyyDWYR8sB+mfSH3Qn3tcxTqMBK9sQQPcX2+hp4tFCtS2rAjLz0RlTUne6/vzXJnKG85hcHlgTphFHnFe4BGMo7y/ecsroqBWxPZJ7+PCG7Xk14fD8dtvLMu+9NkFI/KoqrUthKdOKB2zIqW3TBoVuIRle8P9SM7enLoTzKnyHSK+WEMXlbMaJf3/t2gw8d4Kl9bl2Idb9DZ3/+bJiNYMvFfY1gKHt27LAzA62ZLK4mbuW53T1nF0pCAHFNYBpGiQb0WWsV/nHmw9ANT1onTtZAi7W5g1b3mkSI8n7ro88+I5ePAy52HRVhQQcg5IS70md6ouE1ZBNvV2lAG40k+Y6yAf4BZuieL6xOY5cK/zhjN0Xfmuh82g7BNo41fYM8jzKK4HOOm4mxxICV7wmPKIY05Z6QxzAL4zPWCxDnu6LuHxQ2dgOgGxNIntQivQUjTGwHkW8LBjD9YeckQT8Byr3t1ihyLktUl4qdeiLHxbNN29s4HpNzBoNtAXS4lxVoCzrQ5W9ISMnSP0UhKBMRLIEmRLNIy4yffJ3YZjvYfTFtNOuFQH40dwlP3eO8f4JbRoUbUKNzcurvGw/5zygtQptTXrWc9Gyr4AXtEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199015)(33716001)(2906002)(41300700001)(38100700002)(8936002)(7416002)(5660300002)(44832011)(54906003)(8676002)(6916009)(4326008)(53546011)(316002)(6506007)(83380400001)(66556008)(66946007)(86362001)(66476007)(478600001)(6486002)(6666004)(9686003)(26005)(6512007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jce9PEtGk2Fi+Mv7MZZY+IQkfimZkv7C57eHgg6L9ZTNgADERSw+YRJE+A0F?=
 =?us-ascii?Q?ubrcQr4/xN0pBNm468+Glcek4ogqhOzMCvlZy1V91hGCC19grVsUqhLtQZB/?=
 =?us-ascii?Q?f0rz/KTBfsbw9TYUMNZyT5B/ShKmI1IehxiatRFDFlu97Bq4dAr8lahkecFq?=
 =?us-ascii?Q?7jmOroeHErUtod0gztfdQymGVCHIFBXrA/BRKHUNhC3Hgsw8u8hABy71d6/a?=
 =?us-ascii?Q?gHkrke/cmO+5qQr2ImiUbNurMyTsoKVEpSJokxfk3SMEbcGWQlGJRRGQhthE?=
 =?us-ascii?Q?BqFwWRVZVQUpfXBYb0Hs9XK3kNj3kjd12CUqub4in1wACF2sb5+rMgJrdVQ0?=
 =?us-ascii?Q?3Q4hiu9lmZzd6gAkrVILtmMrZhElVdVgWG4Fc2g4gUAtmMNwmzhvYA6jsCII?=
 =?us-ascii?Q?w1sMqFk4iQSbISDk64Ow2B5TgLBpAiSx4axLlFuxryb6czYug/Eaum1xecRe?=
 =?us-ascii?Q?hQ8w8dAvAZR8IsvVb45sYX2C4TR1dTCaS0GG1yq0u9v8nn9suA24mxX0g6Wr?=
 =?us-ascii?Q?hY6TeWsNf1sAjJs3anH3RQLO87zSmZcp5QUV0Ik4zXTOKOASZTDUBI6XGDUq?=
 =?us-ascii?Q?0U77xomr7/8e18wZzkd14p2bjVAaQLPaVHdMg84K1sSCtKD83rAvT/JZ5CCv?=
 =?us-ascii?Q?+48dQumjIriGrcFkbLzAnoZ5VF21kmrSY/rXO9zlipyK5kVIsQ9vPnmohpuP?=
 =?us-ascii?Q?w7pqZEsHr9ql798uadWQ+mMcQu89zx3JKKmPUPmwDDIiPGN1bIitqp4HOnSx?=
 =?us-ascii?Q?a5UwNhupY4ujK6ZwdSXY0pdH8j0ib1mGL1gR1qJy7XY5VLSNlodajNE0oFNv?=
 =?us-ascii?Q?DEy/jJU3DJ6oy4fJ7bqhZmrMKzLa+NKfNzjHHuyeZfa/TAiBFM0BHjv/pMhs?=
 =?us-ascii?Q?+42RPzLWqh3pB5HfSIftvp1VMD7KujXiQNRxIBX1ygZz3mZ4lwQkLIBDD7UW?=
 =?us-ascii?Q?gfFWk+EBoNUflau9XR5ZeC0Q4cZytgKB6yfLeoAkdc3O93ee/FhUEDY+LXSu?=
 =?us-ascii?Q?OhqDVLXouiUIXjkjxL88iPaMO5UD1D2zb3kJ0XExfMybNefhfcpcdBaBsnOH?=
 =?us-ascii?Q?IOIlvkTjNjod3VGowJDRhGBvUj7FBPJ90fLXZlq1aV2XpYMrFW231SQbgr0Z?=
 =?us-ascii?Q?7qn8azFGlfGAz9iLPwqFeJ+g0SsNDTYvbU/2yV40uL/qvvUhWBBwGhM38IT/?=
 =?us-ascii?Q?WlKLVGfsFRE04cENDzO6GeJoLgIxAvpMpVq1OKCqkPCmoNkMdLLo7KFIRCxc?=
 =?us-ascii?Q?S9n2157QLrjcrd+734HQbQphAz+ZtM2tkbcXmLvsO5lI+gXLGF0nQQLWVMRE?=
 =?us-ascii?Q?N2Ok+t5O6dLPZiMI7Qf55F5pV+hCnnSBrlHxnFGnj0DwIH1K2VSaiSCcefyY?=
 =?us-ascii?Q?ajpBfhAyCqxWq6Zei/rgBOtwctGIzrq94UgEYEUfgOQ5qTfZ8+0qjSlvWWs0?=
 =?us-ascii?Q?y6Fr2gIPaj7VP+bWS2e8Qcut2aneaKyqRUVrDNZ7b3xbhOsT7FKQwg/B5uQm?=
 =?us-ascii?Q?Q/cfus8nETXC2kTas+tjO5Cfi52Ao0IOmeumJ4Mq6XqJpqCLEdGGDFzSW91a?=
 =?us-ascii?Q?Hu4dGrdBznwyyCu3A7f0e0l0rytzRZRsI1RzhAi6xB0Z670SSmaAog0Jg/2V?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?WAbDEpQz9UBe1h0KLmF4AMkzLaQ7Z33lVGJt5svqxZaTMa2+zbTuZCmQqP5j?=
 =?us-ascii?Q?HA9bv6GhT40FrAvny96uCCfQ3lgKF5fosMW/xAa+ikjtr+dk+HSbfK/o/dn2?=
 =?us-ascii?Q?xewp3kNkMMm79/Drh3dkrPpDBftkBc5hAVn3M9oTYsMtrQi9AD1bq+HtQ4uL?=
 =?us-ascii?Q?jiWI9xVQfIspXW6CoIi4dts4dKBgQR+TkbH3ix0XXlC9ccEFKey2teKHL7OM?=
 =?us-ascii?Q?3WemNcByGfgEj2U3HnQ3BnAL41EFiFxXkoXbXk65PHuQNKLmeNvlI3Wtc3ds?=
 =?us-ascii?Q?5z+RFCpa1j2NCgtiBnoBdIWwwY7hhhAmhSdJYtAap+RxeI3LQrkkxMyi8wXh?=
 =?us-ascii?Q?qvxfOQC68WOraKy8mjvmHrHRXCLcq+RHfXrmXQbgM5RFFMqhNxBBmVv9ljmY?=
 =?us-ascii?Q?EhZh5aHIMfIRbPtVN0we3qOz5FjapNrcn4vkHwplkCmChfDg93AIoM+W+5YI?=
 =?us-ascii?Q?h08CYtQamLIAOa17yzkqnLgeZ0v7XzITiFeUa/PGTu5dcLNPpOKg4Ru6gkbb?=
 =?us-ascii?Q?9OnbT6IP+7hyDLNVKXpeWBlCG1kKXTPZxQIpTssQ9t+1fKc1z4V6iqr0Wmf5?=
 =?us-ascii?Q?0S4JR2hriyfuqMEhiXCs1UfllGz+tLiEeIhh4obRjJtDuYWVAGI6ki30f37t?=
 =?us-ascii?Q?Fx2vsMAtAa2u11pIelSMDauIgW2dgBiY2Yu7ylsl9IVdopbhnEv4tSWOlSaE?=
 =?us-ascii?Q?O2V0nhqMmdj9hTmMmhej6cssFzX7j/bPOSi1pIf1DbrydmY7f6/61UvY928I?=
 =?us-ascii?Q?rA5t13bZvg+u9dXHcWysWIBLYxYW4+i0XFLEQSwAvnfGlMxuE36F0Gc1HC04?=
 =?us-ascii?Q?dfv+kd+JARB5wK6ZVfSZg3ow/CmLaU3IQR8dDlBUhWRm0vQHUDXlvPpWmt3W?=
 =?us-ascii?Q?zgMBnYUaXMDfU3qWu1ImpTJHvCOIdbImxnTK0VydUb8GOOY609rgRgvE40De?=
 =?us-ascii?Q?Yqk8tRV9Kbbzj/Otyq0CSMcedeMR3aK3onViIY4eDVaHpQ6ZPrLpqAfMv1d3?=
 =?us-ascii?Q?3jsWbNaSFsAQbs/Gcs4cLwk3PbuAOBkGo+VRflzbF5YrKAFIVSLX/XIDvdi1?=
 =?us-ascii?Q?i9Tlm7fUIucm1Re4KTqQVrEx4Ila6GKLANX75Fztns2IGPdqf1yoT4qWn2AO?=
 =?us-ascii?Q?XN2392fPrB8iAhBCoz78XCZcPHWkr/5dGw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fea9578-0bbc-4ce8-ce73-08dafd6a40cd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 17:50:02.6323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHM6LzDWNX8C86/Dk9z+dymd5bGVlxZTNINGEHYQcxoTJdsAJcLhYplehLHFmedfcOKKeTwgczZgoQnK28opmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4968
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=714 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230171
X-Proofpoint-ORIG-GUID: N9Ywg_yWkLL8d0agpAN-yAaBuwRS_Vsz
X-Proofpoint-GUID: N9Ywg_yWkLL8d0agpAN-yAaBuwRS_Vsz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/23/23 10:19, Peter Xu wrote:
> Hi, Mike,
> 
> On Thu, Jan 19, 2023 at 03:44:25PM -0800, Mike Kravetz wrote:
> > On 01/19/23 18:07, Peter Xu wrote:
> > > 
> > > Actually when revisiting the locks I'm getting a bit confused on whether
> > > the vma lock is needed if pmd sharing is anyway forbidden for HGM.  I
> > > raised a question in the other patch of MADV_COLLAPSE, maybe they're
> > > related questions so we can keep it there.
> > 
> > I can quickly answer that.  Yes.  The vma lock is also being used for
> > fault/truncation synchronization.  Commit e700898fa075 make sure it is
> > even used on architectures that do not support PMD sharing.
> > 
> > I had come up with a rather ugly method of using the fault mutex for
> > fault/truncation synchronization, but using the vma lock was more
> > elegant.
> 
> Thanks for answering, I'll need to read some more on truncation later.
> Before that, since COLLAPSE will already require the i_mmap_rwsem write
> lock already, does it mean it is naturally race-free against truncation
> even without vma lock?

Yes, and thanks for making me take a closer look at COLLAPSE. :)

-- 
Mike Kravetz
