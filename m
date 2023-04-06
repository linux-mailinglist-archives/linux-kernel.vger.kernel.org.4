Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3FF6D9D46
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239892AbjDFQMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239860AbjDFQML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:12:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E297E171B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 09:12:09 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336EugtQ009526;
        Thu, 6 Apr 2023 16:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dJEtXsbrXLXRWFjVQ4z4eLUyq1qFkrDIB7UeN7rG45Q=;
 b=1SxVdVnSPcvcrvNPEcUj5Y0o0OPjaO9ML62FyLMjUtRKpkq82CblI6HzaGL8zb2NJ0hF
 a+LYppD08XmLBqVNFyqm2OgnJvumOiJ46J3jvaaH6yJuse3CdFk1j3NmF2qehnoGPHHP
 Chof1XsLpjW6BmtCADdtxLVARjSOG2LrvgXzDSbVsVmHzcyQ9Kt8FId0kyfBmWPQn7pq
 +d2E3pgRR1tLvhtobtYUBQ/WmkSsP3uPgjKKTffmJFqKSgredT6aDShK6/cVvcifACv0
 sUX3P2aipQZqjY8nhvXXHz1e6V4eZN3enD/ON9bkp7dqaNXmL9jHrEfIp/4+/b9QIQ2N cg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppb1du7vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 16:10:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336FGeNR036661;
        Thu, 6 Apr 2023 16:10:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptpafdan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 16:10:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqwn8MTVes4+lfm9ccvXreTHT7glRehOYwZ4nvpdNlBmuBsSrG4GUT3KbXVA15WLAO+FnFrbCF7eVyKRn93gfnY9ofS5qRAU9iL5kRrWSQGiJ0umWf+ZdICmjOAyktXuWCYNwyKC0focbmVjznIZF6jfhJcy94NHX8g19/juGb9OgkKtZrIOHZcnSF91MkEDq5Gng9LiFUk8tMrYuK92tvwLQsIqSCNRPD+cv52VbEc4A7fFfZ7c99wsmnAXabJMSNg9s665N2felKWHGeDodkvxxtfqZLVK5ovLHtcPAeLRcffqRgZeyzBB+wpvU+whr7h7l68BEMK26Yp9PtfrZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJEtXsbrXLXRWFjVQ4z4eLUyq1qFkrDIB7UeN7rG45Q=;
 b=UjJFe8EbIgjmUoflPH4kJ4F15hxf1OrXZ26CQyv6Io2B22n9kq1ya/zVgk7RIXV9ms2MtzbYaCCRYcJrVtThiDZxmqRIw6qhTIC+rCGHWj4FhwUIOuLVKvxsO+zDKzS29n/vV3iG5VOCKvIpSvT7J3NyJEw5RuPXgo2IjOU0rq7GYlLscqworq7NERi/6Zc8qqypXfGihTT4JXbtG2MFjU3Zu+a6DTOWAwKHRHLyl3j6LlERPgNHwrfkkoIvquTPSOoMkYKrBtGcfAAbInQaSblyrDdsDyoncdD9Qy2nw2N08JA63yrzd5uj3LsFv0AvbJPQ5CtLTdghaKU6/qjxfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJEtXsbrXLXRWFjVQ4z4eLUyq1qFkrDIB7UeN7rG45Q=;
 b=JvZcXjALsjH/hK9Mz1NWlYYLtg4cLbdUx+KRDxmToP/ZVizR727NtlULP9RLJw4VqE5DiEH9A9K21DO9/CT9wEQJD8Qo4vG8paWW1oTH+vb624gtN0jwl+YkLipXly/QtuAG6A5jeKR+MSmAOOqpkeVyProcxSr07JCrAKvUUro=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Thu, 6 Apr
 2023 16:10:37 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3%9]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 16:10:37 +0000
Message-ID: <80767ccc-ffd4-9cb9-44e4-a8d4f0e13853@oracle.com>
Date:   Thu, 6 Apr 2023 11:10:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v21 2/7] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230404180326.6890-1-eric.devolder@oracle.com>
 <20230404180326.6890-3-eric.devolder@oracle.com>
 <ZC6nWzPuIWOxmvv2@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <ZC6nWzPuIWOxmvv2@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0091.namprd13.prod.outlook.com
 (2603:10b6:806:24::6) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CY5PR10MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab070cb-727c-402c-3125-08db36b9757f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FIYzzSb+JJ9Dst9sodDg0/VSAShiZJJN8Ednds+X+LdZyVb98UVKU4P+Zvohio+cgH/458nwkjAVCD0W47RYeMn24wirQ94jaF3je3ar7FbAXz4LBLLKzWkNWtxHr0UHhSAbOfnSH0kokmJ0iDoF8slGpzbCYYRU0MgXYBLsJKLdQgDPjlujItWJMh9wC0DY0tNfGKjknolJPiY4NDwXtempNZyMKqYbuUA7ZK1FEXvetTZ+yozCe+y9pHvAHz4qOd/ltt4Y9mpDIXd5KvgaACgXeD3tennm4v2rJsNxI/ZqnuW3eAr+SMmybbMzwb2APmLTeB5mQvwjbi7RMi3vm3KDm43HSa9XzoK8euYRCZDSNBNOn4163Gn2J6Pl0BCpnI4FueWUGhkn/62WVsaG+8BnBcNfUcQlw2pfiJgAc2pjZwUDJOUNx29ty7bnr7C5peHjFL1qvT1MGsQkzskq7fMAVqZ/x7pmeJqEyUMs6HqmwgAso2ra89SbJCDSgFhuLwbmnCdtSySd/F8C9P0AeJIVoWbDq3w3CRXm2Qde5fCHeXl5FSsaLMTIDRK+9Y54fZcTz0PVy1TmZxNKNGfwq6mjpAYdVZD3pfZlXDqENWH3LR08F5ADDrM3rEcN2GHfUtwCEqshMhfnira7PEIFgZ3mlv5LpWs1DyO5dOKCgi5E118TPP9bBRP1JV4c1DBBfDTUP5H6wEiXV8a2ZKbVOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(31686004)(66899021)(38100700002)(36756003)(2906002)(5660300002)(7416002)(31696002)(8936002)(66476007)(66556008)(86362001)(66946007)(8676002)(41300700001)(4326008)(107886003)(83380400001)(6916009)(2616005)(53546011)(6512007)(6506007)(478600001)(6666004)(6486002)(316002)(186003)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkF3bUQrM0Y5NWl4Q2hrZ2FHY2NlSVBGbi9ZTFRtbVVEUjM1eHJDWXVwakZX?=
 =?utf-8?B?WWpWcFNlQmQ2VFc0MmwvclRqNHUxVkFmNDRmL0NnOWxTQStaaG8xUmdEN2lm?=
 =?utf-8?B?S0ZlY21RUUt2bUVtKzN1alRlVTRaOFZIbSt6cEJsZWQxazd0Vm11TkNBbHg1?=
 =?utf-8?B?M0Zrb1ZORFJYOG5WZUFodDJjRkhQTnhOMlgvV2dHSTZ4LzlESFVkaU51Y2lN?=
 =?utf-8?B?Y1JEdksxZytJWlVzQ1pVQUxrZ01FcmVTaWJSODd3MTFneGg1cXBwTEttK0xt?=
 =?utf-8?B?WE53cGpEK0lsUG9jTmVhNXZLRExESTBkQzBrZDg1WHRnOVR4ZDFjYU9Mb01D?=
 =?utf-8?B?VVBRK1N2dFp4elJzcXR5cHhQd3NVdW1QTWF4ZGRjS2k5WXpTQ3ZPbUVhbmhD?=
 =?utf-8?B?VXJPOFpjTGV1Q2JOcDZjS25RTjQxSFNaMU1jRi9IZmVSekZ5VUJUaTR3S3R4?=
 =?utf-8?B?aUxyZFRPR1IzRGNuT1J3YWtoMzZrL1hRMktBWXp5Y3NZOXpmcnd2RlhkRVdh?=
 =?utf-8?B?VFBvVmJWVi83RWR0TFVzR2pqWTlKa2ZQL1pJakwyTGY1UVh3QjlISTNaTUR1?=
 =?utf-8?B?aFJDVnBLUW9tODBFL09OYW9lb2NUd3hBdmR2SUtkd2V4UnpVSUdBcGlFdHcy?=
 =?utf-8?B?YTAyWFFHN2h6WVVmeUtudWdQQWFTVVIvd0NUSFhmWDR5SHJvK2hCTkR1QWxQ?=
 =?utf-8?B?MHFkUEVHOElBUG5rT0VqUVIwQUVqK1VPdi9LdncxdXVIZmVubnFPRnpGU3FH?=
 =?utf-8?B?S0QzV1JucTRYMHNBbUduVGdYN09GMzY4WkJpNHV1M3c4allYQjJtQTNSVENF?=
 =?utf-8?B?L2R5MWtqeFh6QjRkSUZKNUF5Z1BnWnA5MGJXR3B3RGFGM2lWWjRaY3JGK0ZU?=
 =?utf-8?B?Z0RuR3VPWjlDTkhPMjJQNDFJZGV0Q29BcG1oSEVkQm9QLzgwaldvZm9XZkts?=
 =?utf-8?B?NGM5MzRIZm8yemZGUXF1b1NTRUg3RHMrSXZsWFBsaGtSZjhaZmhDMWtFRlE0?=
 =?utf-8?B?SS92RzUyV3hkdU5Zd3lwbExuL0ltV2tXNUR3WUdHazRZRVhuSUIzRXNzUHYv?=
 =?utf-8?B?YktNbE11ZDlyRXMxbXpVd09RQnoxME9SbFdOMjgvRWhkSUVoSHdVb0RvNTNH?=
 =?utf-8?B?TW5XY3c4R2ZMb0NVTFp2bENFMkJPRStIS1ZKZDJpN1grWlBHM2VNN3ZmdjRO?=
 =?utf-8?B?RlZWakxhcDRyRlJpK1pGYzJheGE1ZGVWS0VPL3RYbjUzYkcyaDdoeWl2WXNU?=
 =?utf-8?B?L0lXWEpaYWRMaFRwbmhVZkViZHdybW5xb3VJdzIxM2RaN1VhZ251N0lhai9a?=
 =?utf-8?B?ajNmNWJyWkVybWxjT2g2dVRub09NWGpMcTZjNW5DeFNsQ0ZlYW9vUy9QOVVF?=
 =?utf-8?B?eWRYeUlXSi8yaVR1dUhESHJCcjBHazdxMEtzUWwzMUhGcEhBMU1kVzlIZlJ0?=
 =?utf-8?B?V3VQTlVHQ1R2Z0V4akpoRGh6bS96MFMyY1BFdmR4ME0vekR2eVFOZXBnOFFW?=
 =?utf-8?B?U00zaUlUZ29UNjh6aUlqR2JjRGpiaVVEdkpkeDAzNi9Ga2NsK0ZKYTZnS2JL?=
 =?utf-8?B?a3YxNVRFV0pZZkV2U3RTaXJxdjB4V2Rwaytid3FxaHNkdkVsK2xoYXo4N2E5?=
 =?utf-8?B?Um9NT1RweHBXa0R5WGpZYWdYaTZGVm5GVS9QSTlUeC9yWGNzL2Z3L1B2WjVW?=
 =?utf-8?B?ZVdWMm14S1E0aUxNOEs1cnRvb2pZZWJVdmhmc3BWNDNtQ0NwNFZIN0YrNlF3?=
 =?utf-8?B?OXdwYkRBQXlQZnJVWWN3NlV3QzBuQmh1Sm11WjZRVG5JZGxmeG9KY1dxTjdw?=
 =?utf-8?B?ZE1RMlF0RnprYmxjZWMzd1VsdXltMWttMCtrbDJwSDhtL2w4R29ORElGOGxh?=
 =?utf-8?B?OTY4UXV5OWRxeCtnRTFObkdOVmVONkl2bTNBRitNRGpxQWpIZ0Jhb0s5L3ll?=
 =?utf-8?B?dzJGUmhrUk8rKzNjd0doVDY1My9COEFVcVZrZlJmNlM4em9RejJDdkdraVdx?=
 =?utf-8?B?SUFBZ1RPQmRHZHJPRlNpbXVJRkVEUFEvOUtmYzZoZDNldHVZdGpWUmdCOE52?=
 =?utf-8?B?WktMWWVoSCtWT2ViczlLZzAwVGdoN2R2QjA2M2E0bzQ2MEhEbERKbUJNdnMw?=
 =?utf-8?B?bHYrRUJ5LzN5NUZZOUw0dVhMMzJIbFdwTmFLSXJZbm1aSGxVM041a2VEUjk5?=
 =?utf-8?Q?2R9nX8ldl0KC34zfw6xUt+g=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TmtkTjNCbXQvS2FZUlpWQzJiK3JYd2dreUpzdUNUeGRRemR4SGZSbmVvdnZ4?=
 =?utf-8?B?SGJzZ1hCdTV0WGpJQW1wUVZTaHh2a05JYU1yaWJKWURXWEYvOTRLMm9EZjNW?=
 =?utf-8?B?N2tNUm56QWNUWFBsT3BhU25CczRqRkMyU1dFNVZ3Z09LK2J6WUVFemN0QU5a?=
 =?utf-8?B?MWpUOEZCSWw2dXIxK1lGcURldTduL2ViNGEzKzNXcTg5NkxKL3liMlJzTGNr?=
 =?utf-8?B?T0hXTWRQSytJaE5DK1B0SkxYVnd6OVZZRFY3V0o3YThNY1QyUXVkeURjWlhU?=
 =?utf-8?B?VlMrbVBzSVJXbkhmWUQyeXpuaEZSOTl6KzBIVmE5YjcvSTNYYjZZaGlCSjkr?=
 =?utf-8?B?b0Fpei8yN29jMWdsbU5xTTQ1WUdCNFNGQnQ5bXkyaFZNUi8wRUFubHg0amxI?=
 =?utf-8?B?L3RuOVpnYkVyZXlhZ0VjNVNrVkwreURFcHdZeVhrS1dyQ05mcFpKeTlUMGtB?=
 =?utf-8?B?cng2a1I4dDVlQzJmK3JMTi9lSVpmQ0VMWGxQWXpaeTdyVUlCSjNESXJoanV1?=
 =?utf-8?B?QWpGb1ZSSHBIODUzRXJkU0NUUjg4dnZXVnlqdzhkNGx3RlBGTkFSR2huSHIw?=
 =?utf-8?B?bjE3WEpwenAxZVhFS1VodU5xUFVjZUE5dFNZTWpvdEthSjY5ZjZYZnFhanFR?=
 =?utf-8?B?TkpoWm4zYTA3aUhJVVJNY0QreWt3Wk9tOVlwWkFzRTR2dkN0eWFJRnMyN1FJ?=
 =?utf-8?B?Nm1BVFBQTDRxd2dmV1BLYnM2VTBzQVJVbURWanNBQmJReTFpVVc2Q2M0elFm?=
 =?utf-8?B?TGU1M0t5czlyOER2aWRXUEFFMlh3eEVhaDlkSDZJTlo2SFp5ck91TXh3VmFN?=
 =?utf-8?B?L3FHMmU0dlJxMUVyd0VsK2lvSzhpeHVCNy85OU5xZjNncGYzMVl1QzdsZktw?=
 =?utf-8?B?MkZYNXJnVVg3MUY0SEhhVis0TkNvdXE0SnRvOUdDNHlEZW9DRVNuc2hEcEM1?=
 =?utf-8?B?S00vREdYb2dBbmlIL0d6V0loelZzeHNTNGtWRzA2TFNMVGRQdmpEMjVWWDdZ?=
 =?utf-8?B?cStibXAzaCs2RE5zajNSVTZZTjlud0xzNUlQeVRmSUd5L2JrNlFsZllVOG9O?=
 =?utf-8?B?eFM4eW9ibktodEdpSVFUTnlGdmZTcFAxTWhlaWRaaGY3QnNtRUZYeWNPeE1K?=
 =?utf-8?B?bnkwT0pndEpOVG5UWGprbk1WYVA4VHNVZnFRVzFKdHZRU3U3b0YxUEtKdHhW?=
 =?utf-8?B?NW9mZzlpaVVSbzlVaEpSeklWajBSRVlkYVd2ZjVCNnpLT3ExcXBEcVNuTElh?=
 =?utf-8?B?d083MEtTZW5ZUU9UQi9rK3NwUlRZSThWSTJLdGV3TWMzNWw4MlFYdEE5NFZZ?=
 =?utf-8?B?Vk9mR2lRTmRvOTE5UGtoUWJsL0FkSHVWR2V2cXo5VkU0TVFRNFJPNEV6VFNT?=
 =?utf-8?B?cVpGemVOcnZsbFNYYXdBZzRsTUR5RWVaOXd4bERUbW1Ea2l0WkQyZG5rcVBT?=
 =?utf-8?B?SUsySDJVeWJZRnRKbEpHNjJ1TmVFSGYvenVxK0NtRitFU0JwREFoWFFFWjQw?=
 =?utf-8?B?Q25PYk1adUV5V2RQNHgyZ3hrcklkcUFidTRhRE04bzBxdC90bUNRMGlvZG9D?=
 =?utf-8?Q?JJFObN2LQTbKfGxFxJu76oYhA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab070cb-727c-402c-3125-08db36b9757f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 16:10:37.4580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWcEBMTHc8Pi4Yf7LKpIodqIN9sc/7xhlzI9uLXpAmagHH+zG6j5Bh5BwutZ+0xx5okJA0vsdHx1HeLPnx+nAKvZXdNNHy/kkRaV2gfWL3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6165
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_09,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060144
X-Proofpoint-GUID: RfQPLWhjfklxSinEDknp0AcgGBKFQe-D
X-Proofpoint-ORIG-GUID: RfQPLWhjfklxSinEDknp0AcgGBKFQe-D
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/23 06:04, Baoquan He wrote:
> On 04/04/23 at 02:03pm, Eric DeVolder wrote:
> ......
>> +static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>> +{
>> +	struct kimage *image;
>> +
>> +	/* Obtain lock while changing crash information */
>> +	if (!kexec_trylock()) {
>> +		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
>> +		return;
>> +	}
>> +
>> +	/* Check kdump is not loaded */
>> +	if (!kexec_crash_image)
>> +		goto out;
>> +
>> +	image = kexec_crash_image;
>> +
>> +	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>> +		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
>> +		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
>> +	else
>> +		pr_debug("hp_action %u\n", hp_action);
> 
> Seems we passed in the cpu number just for printing here. Wondering why
> we don't print out hot added/removed memory ranges. Is the cpu number
> printing necessary?
> 
Baoquan,

Ah, actually until recently it was used to track the 'offlinecpu' in this function, but tglx pointed 
out that was un-necessary. That resulted in dropping the code in this function dealing with 
offlinecpu, leaving this as its only use in this function.

The printing of cpu number is not necessary, but helpful; I use it for debugging.

The printing of memory range is also not necessary, but in order to do that, should we choose to do 
so, requires passing in the memory range to this function. This patch series did do this early on, 
and by v7 I dropped it at your urging 
(https://lore.kernel.org/lkml/20220401183040.1624-1-eric.devolder@oracle.com/). At the time, I 
provided it since I considered this generic infrastructure, but I could not defend it since x86 
didn't need it. However, PPC now needs this, and is now carrying this as part of PPC support of 
CRASH_HOTPLUG 
(https://lore.kernel.org/linuxppc-dev/20230312181154.278900-6-sourabhjain@linux.ibm.com/T/#u).

If you'd rather I pickup the memory range handling again, I can do that. I think I'd likely change 
this function to be:

   void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
      struct memory_notify *mhp);

where on a CPU op the 'cpu' parameter would be valid and 'mhp' NULL, and on a memory op,
the 'mhp' would be valid and 'cpu' parameter invalid(0).

I'd likely then stuff these two parameters into struct kimage so that it can be utilized by 
arch-specific handler, if needed.

And of course, would print out the memory range for debug purposes.

Let me know what you think.
eric


>> +
>> +	/*
>> +	 * When the struct kimage is allocated, the elfcorehdr_index
>> +	 * is set to -1. Find the segment containing the elfcorehdr,
>> +	 * if not already found. This works for both the kexec_load
>> +	 * and kexec_file_load paths.
>> +	 */
>> +	if (image->elfcorehdr_index < 0) {
>> +		unsigned long mem;
>> +		unsigned char *ptr;
>> +		unsigned int n;
>> +
>> +		for (n = 0; n < image->nr_segments; n++) {
>> +			mem = image->segment[n].mem;
>> +			ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
>> +			if (ptr) {
>> +				/* The segment containing elfcorehdr */
>> +				if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
>> +					image->elfcorehdr_index = (int)n;
>> +				kunmap_local(ptr);
>> +			}
>> +		}
>> +	}
>> +
>> +	if (image->elfcorehdr_index < 0) {
>> +		pr_err("unable to locate elfcorehdr segment");
>> +		goto out;
>> +	}
>> +
>> +	/* Needed in order for the segments to be updated */
>> +	arch_kexec_unprotect_crashkres();
>> +
>> +	/* Differentiate between normal load and hotplug update */
>> +	image->hp_action = hp_action;
>> +
>> +	/* Now invoke arch-specific update handler */
>> +	arch_crash_handle_hotplug_event(image);
>> +
>> +	/* No longer handling a hotplug event */
>> +	image->hp_action = KEXEC_CRASH_HP_NONE;
>> +	image->elfcorehdr_updated = true;
>> +
>> +	/* Change back to read-only */
>> +	arch_kexec_protect_crashkres();
>> +
>> +out:
>> +	/* Release lock now that update complete */
>> +	kexec_unlock();
>> +}
>> +
>> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
>> +{
>> +	switch (val) {
>> +	case MEM_ONLINE:
>> +		crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
>> +			KEXEC_CRASH_HP_INVALID_CPU);
>> +		break;
>> +
>> +	case MEM_OFFLINE:
>> +		crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
>> +			KEXEC_CRASH_HP_INVALID_CPU);
>> +		break;
>> +	}
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block crash_memhp_nb = {
>> +	.notifier_call = crash_memhp_notifier,
>> +	.priority = 0
>> +};
>> +
>> +static int crash_cpuhp_online(unsigned int cpu)
>> +{
>> +	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
>> +	return 0;
>> +}
>> +
>> +static int crash_cpuhp_offline(unsigned int cpu)
>> +{
>> +	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
>> +	return 0;
>> +}
>> +
>> +static int __init crash_hotplug_init(void)
>> +{
>> +	int result = 0;
>> +
>> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>> +		register_memory_notifier(&crash_memhp_nb);
>> +
>> +	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
>> +		result = cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
>> +			"crash/cpuhp", crash_cpuhp_online, crash_cpuhp_offline);
>> +	}
>> +
>> +	return result;
>> +}
>> +
>> +subsys_initcall(crash_hotplug_init);
>> +#endif
>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>> index 3d578c6fefee..8296d019737c 100644
>> --- a/kernel/kexec_core.c
>> +++ b/kernel/kexec_core.c
>> @@ -277,6 +277,12 @@ struct kimage *do_kimage_alloc_init(void)
>>   	/* Initialize the list of unusable pages */
>>   	INIT_LIST_HEAD(&image->unusable_pages);
>>   
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +	image->hp_action = KEXEC_CRASH_HP_NONE;
>> +	image->elfcorehdr_index = -1;
>> +	image->elfcorehdr_updated = false;
>> +#endif
>> +
>>   	return image;
>>   }
>>   
>> -- 
>> 2.31.1
>>
> 
