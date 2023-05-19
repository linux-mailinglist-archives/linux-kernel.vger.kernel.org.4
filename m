Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB1C70A2DD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjESWnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjESWnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:43:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416A51BD
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 15:43:13 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JMQ7cl030182;
        Fri, 19 May 2023 22:42:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=GxGNThTfi0hxqI4XJWWuUU7iQnM2akuBNYM5nRmP0nI=;
 b=0VykxbvUwm2V0r5PW4HpNfNXY/AihlqJfoxVkNyfkkNsaocwH0ekuotgrHmLQKy9oSRI
 x8I6ffXlFz//JAaznJo8oV6MILCUoyR0Gx3gyHXR9VvHNTzqXGhNUOi80kvMoS/XWcdy
 KQ8nmAtVYLhVVeykY5JdTX4z5vdKhENkH1obCMqKUI2bim5um5V9AVcYrfYXmf5erlFQ
 URQWCwP29Qt6rKkgNb4CCMjViroecefC7o+7MuvpWO6Qkdjq5ffXbvwSdqtFpvFxrjCW
 JTN6j77WOXJpHExx1kCiFT4peyEnziNyoYNRht1RFeGQpq2gbda8X5tBcEz4I5A0+1vL ww== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj33v37we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 22:42:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34JKIUgs004214;
        Fri, 19 May 2023 22:42:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10ey1cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 22:42:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjmTB2xBSuNgysvj0lKIE6rCEHtU4GII0rAS7dKDy+UKCm/IvxL5Z97o9wKxhlwxaHLupnE35NwwqRcB73FHb+PVPk1iLJiSoyGF0i5H0oEZ3X4DIfTyGzLt6gZylDXA1O/Ef26sx9A8JsqNXzcxUmMruLDFGo70afynOjoWrzEKeVQ4wKzsqG1/A+7Bd+Ouo76vR4nqIAnZg+EW40G+AMrDFlndTM4778JPyLBctNbEW7uszMYM/6Yp+lpmcrOgR5ga34ASnq/uFr5PEqWx3zuSL/l3yJOTxQSSbhNzRnZOHpTtjYvv9p5dlqushWObsWVO6KFIQxdvmTKAM5XkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxGNThTfi0hxqI4XJWWuUU7iQnM2akuBNYM5nRmP0nI=;
 b=E2XxRjIhadZPT/OsfVn+emUfO7GL/XIMPUOWyNZdEPnlMXaVX9ztIfqgrkkIa7uRQJr/fTgyZm7SKnNvmAbFLL26ioX2KPmgh51kwvc/SRPk4U834Y5Vn/sbRKAQnU3nURrKUxZgjpwPvOpB1hPdhTjVv47J2kO4PRd45tF2KLuaIzj6h2+YEvy9IVJY8fZj0hYV+swEQ5OYUUf1rL1zOY7cZyFtM/ujVa7KVec3SYRNWKFXckKHthi9Ohs9Rk+UYyPXXjXZXLnwcXqqcEHW3Hozfqcmq5V48ykUKuV2LKqZBNcT/YLdxO4k5kIPkQ2aZJUD/4yGLvtrlLQfNK++1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxGNThTfi0hxqI4XJWWuUU7iQnM2akuBNYM5nRmP0nI=;
 b=xE7hEOieDQxTMLvRECWq4e+eF7K84afpQCsLYeBWQT92YxRhhhdkFRA+iqSPsYKGv0q2xDTGpSd+D1LwXUiWL1McpQecT9JuTRhMyFBqFfomZpwD2HuaOymlIq08fcP38mWPvfc3fV8Qpzr34MvHSt10lc90zvtZVVLnRQV6MgQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW5PR10MB5737.namprd10.prod.outlook.com (2603:10b6:303:190::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 22:42:17 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 22:42:17 +0000
Date:   Fri, 19 May 2023 15:42:14 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Jiaqi Yan <jiaqiyan@google.com>, naoya.horiguchi@nec.com
Cc:     songmuchun@bytedance.com, shy828301@gmail.com,
        linmiaohe@huawei.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duenwen@google.com, axelrasmussen@google.com, jthoughton@google.com
Subject: Re: [PATCH v1 1/3] mm/hwpoison: find subpage in hugetlb HWPOISON list
Message-ID: <20230519224214.GB3581@monkey>
References: <20230517160948.811355-1-jiaqiyan@google.com>
 <20230517160948.811355-2-jiaqiyan@google.com>
 <20230517235314.GB10757@monkey>
 <CACw3F52zNguJ-MvXOAJuMK+JfreLxorvHDPwO8w_gQdOzWj7eA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F52zNguJ-MvXOAJuMK+JfreLxorvHDPwO8w_gQdOzWj7eA@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0183.namprd04.prod.outlook.com
 (2603:10b6:303:86::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW5PR10MB5737:EE_
X-MS-Office365-Filtering-Correlation-Id: 759847ad-577c-40e8-8b35-08db58ba4c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +VpQWsnGXW8yxv5PahYZWg9VTFN5jdJ9urEQFSWr93gc1u1E0uNhHDc9rNSfeYiiFA4gHAtMEzRpYJc8RmuDx+sP6s0qD0kANItJ9+I1GuhFhtCnM8i8giPtvo9oCZEKGvSBTcZLxB6wsKa0kQsFKGuEsqWUUGJLxFm+v3DzY9uw5fFkqjibBQYcyjh9XxSXgvQMY6pWrlV/hXeyqEowj59I0VGZE8esVjS9xgY8WJRlo8NUryICpJ9+DQn8Q6jCfsO0cLiZooCZY8F3jcwvQWQiCvr5OK2r1nGH7sWGeCMyEdf0wPQTckXLtB7Q/mEx0McOQ4psJvAWY7S8Svv4ehiCNV3T5kBkgOx/8HfO5R0NR/pn6yyiKDNnUezftCDNxXvJrTw3HdmtHgGvS4Mo+LtNYGUFBkWFHhHdxa/90cmToMbrbzhtP8a0skMoPvvNv/npfDARAwr1I9wKANbySy2cQTSksWo9QjlbwRpypYF0eVLr2F+8fYCohECqRJzasH2i6tBNDxCk63V8kd6DSuDPap+XEQZSmYgFp8fnsgY6dXabFV3zNJMgrZzLGPuh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(66476007)(66556008)(8676002)(5660300002)(4326008)(66946007)(8936002)(478600001)(2906002)(7416002)(41300700001)(44832011)(316002)(6666004)(6486002)(9686003)(26005)(6506007)(1076003)(53546011)(6512007)(186003)(83380400001)(38100700002)(33716001)(86362001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGNGSStRVzhFU0VVVmtWZlE4UDFodUVKYWVFVkFtWmc3UmhGQm1iVjk1bGUv?=
 =?utf-8?B?eE1yL2F0UzFiZGcrZ3VhWUFSTVRHWCtqK0cxZDRGM3hVZE5RWmlhb0VFUzNu?=
 =?utf-8?B?VDlmSzl6NFZTQTdkcVNhK1BOOWkvSDM3bk8rQzh3VmFZdHk0MUpWUWF1NjBR?=
 =?utf-8?B?WEM4WThJZ2M0MFdPVjBLYk5PUHMzbTJFMkNldmRRQTdkeGlIVEJ1U2J6TTBm?=
 =?utf-8?B?aUF3Vm1vZG90dk1aeHdXRXZpVjlDaEtvOGlMQk8yclUxTEtXNENDL3J2QVRs?=
 =?utf-8?B?NjN2em5tKyt1VFBZOUd5a1Z2L1YwL3ZscGY4OHg2MFBlY2NLUDYrNXdKWkRa?=
 =?utf-8?B?aWpJa01iV0tEMzNjc2c5bzFLUGNadjJuYyt5eVFlRDEzUUNqOE1BcE9kUkNB?=
 =?utf-8?B?ck9WU1ppV2d5eCs0bUg5enpXQzc2SERwaUVyejZsSFpNU2lxd3VxRWFBMWRu?=
 =?utf-8?B?WEJQbXNZeXJ1SGdoTHNDTmdMTEViREpWTHRMRERwcTZoQWRocGlodks0L1pj?=
 =?utf-8?B?TStQNkc2c1VpRC8xSFJ6UlM1VGxORHhqcFgvVmo1SkFjWnRjQVQrdmhQSHg2?=
 =?utf-8?B?UXNLT2tzc3JxbjJYenlZbTdWVStZd21PT1gwZ1Z2MzhRY2FnbksveE1PUEs5?=
 =?utf-8?B?SDh3WU5yVUVnQzBqOExiclRnbEZZcnNnZ1YvU2F0STN2dXJ3SGFuSmZhenRQ?=
 =?utf-8?B?RHlDSzlWb2I3N0d5WW5ZWmQxRmhtd0FsV3hMQmJhdnIrMTh5WGlLZmdTbytv?=
 =?utf-8?B?OFRLYzh2Y2FWWDVzN1B5UVQ0d2NNazN2bjVlODBqWUVxVjZIRCszc244clBL?=
 =?utf-8?B?TTZsUDVHSHBweWwzQnhVRnFDcG1XSW41elVnTWZ2aXREQkdERHQrSTRuaVBB?=
 =?utf-8?B?Y0xQa1dHL05VaGU4WVFXNHQ3bEVNNmlJSzJvNkY5WVVkQnFjNGVjZ2NiVzd5?=
 =?utf-8?B?NW0wUEg4dXFHUnl3MW55d3pSQU80UmFyTnJERkh3VWFzVU5yVnV6d1A1cVpr?=
 =?utf-8?B?UExRMTNUVENuK3FKNlV1UVhwQzU3WmVtQjNvNVVuY2xUcDdSY2ExK0lucG9z?=
 =?utf-8?B?emlKVy9LOHM4aWw4UXlCYVpiRW9wTk5BSjV1T0d1RnpHTnpIOFdkeGxBNFQ1?=
 =?utf-8?B?cUsvYzFkV1Azc1JBTHBsMUsrNjdMUHNGa1RwWW1RdDE3aWhxYmRaTkdlemUy?=
 =?utf-8?B?YU9zeVhMTlJKTTR2VmtYZzRwcE9xWmNNN1RqeGZiNEp3Mk1pdWpLVkNzTXJG?=
 =?utf-8?B?N3pUYmlrRTBKbFZrbVB1WlUweS91UnBMaFBQZTdtN3M1ZEkxdWpZdzhOSlQr?=
 =?utf-8?B?WTFhVmpacGxtbDNjZ2F0UEx3NEZlK3lDUkdrZlU4NEpIZ2Uxc1J1a05MU1pO?=
 =?utf-8?B?aHRFckNmNklVbE8yYVNWWlNzcmFqYk1HYmlLc0U2THhOcEgxRnFYTnM5c0o4?=
 =?utf-8?B?VEpJTWFkRzljRHlZNWV5SnJkWmcwbmt3YjgrUk9HRytQbWY0K1VyZjRkRDNS?=
 =?utf-8?B?UEtaQ1k1dHMxMVEwZlQxV3YweHp2d09vemgyTmQwalVHWWNodWd1elRZbXY5?=
 =?utf-8?B?eXFETlorZ0dITlpVWHc3Y3hmK1pscmVPakw4aGlPUFFhNGhRaTdsd01QSlFZ?=
 =?utf-8?B?ek8xV1lRZVhSUzhvVVB1dGdyREVKWUFFaTY5YStZZ3h5UUYxb0draUhZVFpW?=
 =?utf-8?B?T2xHWDc3VUVTTVd4c3d2UHZGY1h4VXFvNk5BY0U3SFUwWXJyeEo5TlpOZDRP?=
 =?utf-8?B?OS9mdE1XMTBOVVB0NmpoYjRzb3h6aWZjc2FhZUxtTVVUTEVEamZ4V3RZUTdH?=
 =?utf-8?B?aFZvL1M0QVdaVXF3emVLdjE4SW0zNVhxc1ZMSm13emltM1Z5dDlUdFZSLzFv?=
 =?utf-8?B?U01wNjB6RDViNUYvQ3VCUjBGZUJqSDh2cFZvVGEzZkI3bDNPaEdhbW5iN0tK?=
 =?utf-8?B?cGJZckhKOEVLQlZXb1B6VmNPVTVxeTgyeWxlMFJQY1hqSU5JUy8yWCtBVWRm?=
 =?utf-8?B?YnlmZ0ZBYjJ6WDU0M21zUVlyc2I5QzNpeDM3NWExK1pXZ2FweTdpSGNFK3cw?=
 =?utf-8?B?dUxrc2w3OXYxSGtJWDBVRjZZZ1c1M3JvbXdIQTlOUFZTTzRJSXRqRCtmRC9L?=
 =?utf-8?Q?v0+Pe6xno0hsrarh5BoYtwXOU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eGVqc0lXaDI3TVRGUDRXMGFEWlBFaGhaU2VEa0hvM3UrVysxdjBteXNKZzMx?=
 =?utf-8?B?c0NZUlBmZmluSHF5OUNVSFNCM3p0M1gzakpHZUJTcWh3NFlUYWZZeC9hNTlW?=
 =?utf-8?B?MWNRYzVPMFFVNmtLb25iVnJKWTBXc0xibDFXZUtNdjVsUGgrNU44eXcydnlW?=
 =?utf-8?B?Z29COWkzUzhKei8vTnRoRmR5eFdBV1I0d2lkSGo0UzBYYnl6N25rZU52RERQ?=
 =?utf-8?B?UGZ6VlVYNHNnb0pVeGdSRDltZWlwUWNOMkxzcXk0d3FWWkhxTnZtSzJ2Q3hh?=
 =?utf-8?B?UEpJeDRTWEdsR2VpT0FvY1dvZWhEZ3VldGRlY3V0NGEzc00xU3M0VXhJWHIw?=
 =?utf-8?B?Q3VIVG5Ud1ByZUJ1QjZDbnRFWEdvQzZJWXpxSXY3eHY2M0ZHaHZwQUM1WExr?=
 =?utf-8?B?Q05ibGJLWkRIWk14YmVaejBqNjNJaWRWc0QyUmcwS3JCcmNTMXczVWI0N3Vo?=
 =?utf-8?B?MTZTWnRRemxwcXdtQUNINHMxOFBuU1M0M0FlTnI4bnFhdnFRMEErd2d3TE5q?=
 =?utf-8?B?M2x4aEVaNFZwTlNHVkRoanJaVG1MU01ZUjdSWENmakR0ZjcxcTNGbm5TOS8r?=
 =?utf-8?B?QUZXWFpWeWlLK3g4NittODJzdHhTSDRiOEJPdTVvdVBoSXczUi9XMG1EZ3pU?=
 =?utf-8?B?QWhlMnJQWG1YOXRuTjFrVm9qeFA3S3QvZzVnVXdHNGlpZG1LNCtJd01INEtp?=
 =?utf-8?B?eExabWlQU1YyeUVJRTdYQnhBamNPd0UyNW81bzZTWFRCUUx6OEw1S2U0aWto?=
 =?utf-8?B?NmJRbmhsbFlEVzNlNVNwTnBzSTRJeXJJZGZuSmEvb0U1RmYvNVZETXprRzJR?=
 =?utf-8?B?aTFPSTZoU3pGdDQrR2JIZktWYlppQ2NWQXk2N0JrUWFnem1PRG1MUmJYZW4x?=
 =?utf-8?B?NmhMN1QxREthK1ZUdTBEeHFRY1ZuMGwwUTRrTjY1OXRCQW82cWdnR0t0UXp0?=
 =?utf-8?B?aWRKK0NVejVGZXlYNXZEYk9ZZ1p2ZXlld2dkSS9tcFpjYURycHpFQm9UYmpL?=
 =?utf-8?B?dCtwZzZUTU5Jb2lvNloxc0hSRmlQbU1TclNTYXhoTUh2Mjh2Yk9CaU0xK3A2?=
 =?utf-8?B?Z3MwRSsvSi8vaHRGS3NYQjFheWNlY2RSQ2hHelZrS2JuOENqRHpVRXNEMlZv?=
 =?utf-8?B?dHY0ZGlFeE5YWktDbC9iRlUwQjJ3aXJVSFp3MmNpRHFETnUzU3BPcmlvWWNZ?=
 =?utf-8?B?V2VCL2JhdVpzQU5LYWFmTXVUdUNmZ0Z3amZaTkF4V2dyNFZ0S0RNREQ4SHFo?=
 =?utf-8?B?Zlhtd2VtamlicXZxWW1neWw1VFMxUEdvdkVrc1JFaWZzTmora1hJcFlyazVB?=
 =?utf-8?Q?FZS4pB+mtp7aI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759847ad-577c-40e8-8b35-08db58ba4c4d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 22:42:17.2683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fg5zoBsdSS3otfaCfcyO1z2df6wOh6K7Yas8Z6HFbAHnxMGOtq7cOF2EbdOevT2ZEGlxqNJVnYZH81n0sbXU7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5737
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_16,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190194
X-Proofpoint-GUID: kFOEPlRMR5W24dwXot41KEyQqadMqNXo
X-Proofpoint-ORIG-GUID: kFOEPlRMR5W24dwXot41KEyQqadMqNXo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/19/23 13:54, Jiaqi Yan wrote:
> On Wed, May 17, 2023 at 4:53 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 05/17/23 16:09, Jiaqi Yan wrote:
> > > Adds the functionality to search a subpage's corresponding raw_hwp_page
> > > in hugetlb page's HWPOISON list. This functionality can also tell if a
> > > subpage is a raw HWPOISON page.
> > >
> > > Exports this functionality to be immediately used in the read operation
> > > for hugetlbfs.
> > >
> > > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > > ---
> > >  include/linux/mm.h  | 23 +++++++++++++++++++++++
> > >  mm/memory-failure.c | 26 ++++++++++++++++----------
> > >  2 files changed, 39 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 27ce77080c79..f191a4119719 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> >
> > Any reason why you decided to add the following to linux/mm.h instead of
> > linux/hugetlb.h?  Since it is hugetlb specific I would have thought
> > hugetlb.h was more appropriate.
> >
> > > @@ -3683,6 +3683,29 @@ enum mf_action_page_type {
> > >   */
> > >  extern const struct attribute_group memory_failure_attr_group;
> > >
> > > +#ifdef CONFIG_HUGETLB_PAGE
> > > +/*
> > > + * Struct raw_hwp_page represents information about "raw error page",
> > > + * constructing singly linked list from ->_hugetlb_hwpoison field of folio.
> > > + */
> > > +struct raw_hwp_page {
> > > +     struct llist_node node;
> > > +     struct page *page;
> > > +};
> > > +
> > > +static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
> > > +{
> > > +     return (struct llist_head *)&folio->_hugetlb_hwpoison;
> > > +}
> > > +
> > > +/*
> > > + * Given @subpage, a raw page in a hugepage, find its location in @folio's
> > > + * _hugetlb_hwpoison list. Return NULL if @subpage is not in the list.
> > > + */
> > > +struct raw_hwp_page *find_raw_hwp_page(struct folio *folio,
> > > +                                    struct page *subpage);
> > > +#endif
> > > +
> > >  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
> > >  extern void clear_huge_page(struct page *page,
> > >                           unsigned long addr_hint,
> > > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > > index 5b663eca1f29..c49e6c2d1f07 100644
> > > --- a/mm/memory-failure.c
> > > +++ b/mm/memory-failure.c
> > > @@ -1818,18 +1818,24 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
> > >  #endif /* CONFIG_FS_DAX */
> > >
> > >  #ifdef CONFIG_HUGETLB_PAGE
> > > -/*
> > > - * Struct raw_hwp_page represents information about "raw error page",
> > > - * constructing singly linked list from ->_hugetlb_hwpoison field of folio.
> > > - */
> > > -struct raw_hwp_page {
> > > -     struct llist_node node;
> > > -     struct page *page;
> > > -};
> > >
> > > -static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
> > > +struct raw_hwp_page *find_raw_hwp_page(struct folio *folio,
> > > +                                    struct page *subpage)
> > >  {
> > > -     return (struct llist_head *)&folio->_hugetlb_hwpoison;
> > > +     struct llist_node *t, *tnode;
> > > +     struct llist_head *raw_hwp_head = raw_hwp_list_head(folio);
> > > +     struct raw_hwp_page *hwp_page = NULL;
> > > +     struct raw_hwp_page *p;
> > > +
> > > +     llist_for_each_safe(tnode, t, raw_hwp_head->first) {
> >
> > IIUC, in rare error cases a hugetlb page can be poisoned WITHOUT a
> > raw_hwp_list.  This is indicated by the hugetlb page specific flag
> > RawHwpUnreliable or folio_test_hugetlb_raw_hwp_unreliable().
> >
> > Looks like this routine does not consider that case.  Seems like it should
> > always return the passed subpage if folio_test_hugetlb_raw_hwp_unreliable()
> > is true?
> 
> Thanks for catching this. I wonder should this routine consider
> RawHwpUnreliable or should the caller do.
> 
> find_raw_hwp_page now returns raw_hwp_page* in the llist entry to
> caller (valid one at the moment), but once RawHwpUnreliable is set,
> all the raw_hwp_page in the llist will be kfree(), and the returned
> value becomes dangling pointer to caller (if the caller holds that
> caller long enough). Maybe returning a bool would be safer to the
> caller? If the routine returns bool, then checking RawHwpUnreliable
> can definitely be within the routine.

I think the check for RawHwpUnreliable should be within this routine.
Looking closer at the code, I do not see any way to synchronize this.
It looks like manipulation in the memory-failure code would be
synchronized via the mf_mutex.  However, I do not see how traversal and
freeing of the raw_hwp_list  called from __update_and_free_hugetlb_folio
is synchronized against memory-failure code modifying the list.

Naoya, can you provide some thoughts?

> 
> Another option is, this routine simply doesn one thing: find a
> raw_hwp_page in raw_hwp_list for a subpage. But the caller needs to 1)
> test RawHwpUnreliable before calls into the routine, and 2) test
> RawHwpUnreliable before access returned raw_hwp_page*. I think 2nd
> option will be error-prone and the 1st option is a better one.
> 
> Maybe I am over-thinking. What do you think?

I think racing code accessing the raw_hwp_list is very unlikely.
However, it is possible and should be considered.
-- 
Mike Kravetz

> 
> > --
> > Mike Kravetz
> >
> > > +             p = container_of(tnode, struct raw_hwp_page, node);
> > > +             if (subpage == p->page) {
> > > +                     hwp_page = p;
> > > +                     break;
> > > +             }
> > > +     }
> > > +
> > > +     return hwp_page;
> > >  }
> > >
> > >  static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
> > > --
> > > 2.40.1.606.ga4b1b128d6-goog
> > >
