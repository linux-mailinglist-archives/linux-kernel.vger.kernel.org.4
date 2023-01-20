Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93F4675FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjATWGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjATWGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:06:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7008198F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 14:06:28 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KJwsLY004812;
        Fri, 20 Jan 2023 22:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=C76o3sNC74BD+lsjLE++5dstOeJ5MW28nAVoNaxYLe4=;
 b=Mxj6Uc8Vn2dut3fcbwKqGOzYPfgggyv6qvKOfp2RVAA5HPilh14Cp6qaSKA7TgbQmFjV
 DbkjYoSGPWlWAw4V6FlkvBmjeqV4z4xYsj492f2h30T4L8B/IzEbyfxnm1Uv7Gr4Guzu
 X7/4KVYAKuxCleF90d/DubPAJlxiJ3+CKq89szQuniLEThCTcBsQILptQxu7nmH65NXx
 Uv/gXLR7nLE9pi4NYX/uywr1gjrD2Bgn98z4+J84P+koO4slirdYNnEkBFsJZzjKYyW9
 QEak7wAkVyC57XyatEagbe9BEyEZMAubsGByOZGZvvlnz9WrDZ8/2dm9n2lN+uwM6sMz Sg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n7895bfdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 22:06:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KLa0G8004664;
        Fri, 20 Jan 2023 22:06:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2we3ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 22:06:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMWpfrkS7guLD+0vpDcWStoU/DcRMFDHBO3zWC7beXXtTyOGU3agdB1ZFs8I+bcdtbx6T2uPA6bnuh1KALHPsOgFuuG/AQPpRUfR95r4yg0PHE8lg4cGR0xTXbDqsSpcwj7pL7tAH1riQ4cU+C1tNHmyljlgcaMoUuOOq7f0STnKOUKr1NZKRoQpvQsdvr6oD0sevQjLxJFes5k3L0NOBVKjl9l7qWExVDZ6RiBQs5hy2SbXzU4Mx7G3go507LYOzGp5PJTzizOrHTq4i3eHuZuOZg4Y14nt5sHSqSujfIFmrBccpBt0VLiTmGcqj7jbLpAi1Tz1gfOYh5VoEQbMcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C76o3sNC74BD+lsjLE++5dstOeJ5MW28nAVoNaxYLe4=;
 b=k6PuiCxcopJyabR2aFChNawZ0ocZTvlWz9awxJsTNVkCgI5Aw3t9XG9ampMvKmN38Vgjt/60jV/3XZAMCzRq9gqKhbBaSDeWOZ5S/XFWUQAiiJrizh8p8aGWehBHyU/v+ke1/JhIq2AfaD6fC6rjh4z4IBmMHrw5+n0bPMoDWiktUhQsS6/Z77XYCcOq9SjEapgbyIglZRMjpYz6iI4pYJ1E8+uZAx2F4LIsTIYR+7Cq8LVYTVpmewxRKkwlNBa/CXGtcI12juElo62kWYEtZNPqF/EygBPE35c1yLFfkc/NPBtdQVOGHTro41pVDYx2CRCInivSUFPXoPRIGXm//A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C76o3sNC74BD+lsjLE++5dstOeJ5MW28nAVoNaxYLe4=;
 b=RJyvxn/JYFCPgJBYGZ3bKCov/yDy7yudGOYtHAgSFkWxQkqelKW9gR8WhCwfIopIKyQBqy34aR5TDwYb0hgBk3d4cqxE1BHf/0LAptW8f37slNNYk7Oti0HqOxbWj3td0LV6anbTpjBLxF/bl9sa+xbhdi+M1AXP+xjEYKp5KEs=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by IA0PR10MB7275.namprd10.prod.outlook.com (2603:10b6:208:3de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 20 Jan
 2023 22:06:00 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Fri, 20 Jan 2023
 22:06:00 +0000
Message-ID: <9c5ccb75-c06a-e638-a83b-07c318a0d074@oracle.com>
Date:   Fri, 20 Jan 2023 14:05:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/9] mm/rmap: change hugepage_add_new_anon_rmap to take in
 a folio
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, jhubbard@nvidia.com
References: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
 <20230119211446.54165-5-sidhartha.kumar@oracle.com>
 <Y8ot5Y01TWmB4sBj@casper.infradead.org>
 <9c276d01-379f-9bd7-0a7a-6a831b7b4571@oracle.com>
 <Y8sE2l7EvBPnTCab@casper.infradead.org>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <Y8sE2l7EvBPnTCab@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::23) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|IA0PR10MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: 7abbcbbe-8faf-4ccc-6610-08dafb328388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fLxX886osmSUiTmMQ/6ki8Tz9enRi5JC9TpRwj5rKD29sQgjSrkurn3SlINPGv5h82Z7+LXyUA4QYodz4gkptoN65qqdVYwPMScGfI6UeQN1RrBk6CMSz9HEQS7IojFwb0yRdsN2KUn3kVexNv+hXi+Ejgs9zapZG2Tw69bscHXs84VyRz39MuveL/rHIyb+i5FJ+wJP54Wvt9vIUgq4GVE+5t+7nOlbZm7tsrkGj8AF0rsZY/ILjntZ/XKiSbj5bJQImk2uDblfv/t1gO3oAbxpyKQxkVou2NQFPEIkoG9RkT9e66UQad3noxo+1UQQYGCUFCTcZZNuktyuMgnd+VDUyGRzBbCkw6cm7ntgIofxZbiBbjbrIxB5jx7CsJn7sfH0Tg048WNU1cKZ6RbENm3U4zLP1WkAH2bdsszpy1VsbCPXDw1wkOF/ECKS1WPAKntSXI2HvotFs+GMHIq3qojk0lFngRM9NmMH8HTBlV03gHh5KJJyD5d+dXPYJkrMAvZ9Ckjl1Q+QFkSlQBPW/qO5hqU/cqZ9BIQUOB85xp0ShwjTLvnwsmVu40Pc+V+oh1eQ/osT6zM85WE7lt9YuYEsR3yR6EZXVVUEaBNAnoOMqCp6NPU42WPkv5IU2+y9JfEJdlIyDP1xwDdA/QaOrCf5/ouyupGSC+6cgIIxNOg/6s/Hx726t5nElXgN6QB3mLWOeL+UBTO9/LTuN1xejfhyMX1U2fmISUuNNdc1GT0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199015)(36756003)(2906002)(44832011)(41300700001)(6666004)(316002)(38100700002)(186003)(8936002)(6506007)(6512007)(26005)(6486002)(478600001)(53546011)(5660300002)(66556008)(4326008)(6916009)(8676002)(66476007)(66946007)(83380400001)(31686004)(86362001)(31696002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjJEZXdVY01pdmZVMks5M25wRW1Xc24xbm1aWTJwbXBlWEUybXZpWGJjMWV4?=
 =?utf-8?B?RmMyV2Z4dXRudXA2TGJGaFk0WUVVbE9MeXB5U0d3R2R1UW1hU0x4U2grNk5h?=
 =?utf-8?B?YUtydjZDV3Q5TkVUNmpyd2JUMTI4ZjRVNW96cWpNNG8yWDhKNFBMS25oQnFr?=
 =?utf-8?B?VUxTR0o3ZVRFblpyTW9wSGwzTUZmSjFTSXBrRXk5OFN6QXdZdkowZ2lYU3RO?=
 =?utf-8?B?KzJjK2pBMFBlOUtURmwxOFJ2cVIzVTZWd0dFU3RaWDZlWnpudWpNNlJXdlhk?=
 =?utf-8?B?ZFd5dWYzbWhLRVVNcVJPMGloQzNzRFlYK0lxSzN6TEY5bjhWbndIdm1CdFlq?=
 =?utf-8?B?SHJ4TUxkTlBNdTB4Zkxza3AvKy9PSEgwVSszVGhscW1FckNaV2FnRnFHcGM3?=
 =?utf-8?B?SHExc0Q1c2l2c3FuenpzTGo2c2hLRFprd3JXRUh1WlVGTWUzL1ZTVStnSm9k?=
 =?utf-8?B?NlJOUWI2M05GaU56R2VLcHBPY1FDVlJyNkNYSDZrZ0RFLzdISmcwQkhIUnhW?=
 =?utf-8?B?aG05ZzRUNlZ3Ni9EUjBxVU1tVm41c3YzcjRUamNjQlZvNnljQW40Rm5sQ2VY?=
 =?utf-8?B?b0o3RWhLZHVUcSt6MmhIK2ZUSUNQYkE2YWZ5VE9VZU9LWDdRUE05c1FScjR6?=
 =?utf-8?B?a09uMEJQcElhWDd6cFRNTGppcVFrRFBOc3Rhbzk4QVVKN3JkN1JSY0ZyQm4v?=
 =?utf-8?B?VWRzVk41Z0hrNHp6SWt0eW9aWUhjZEtiL0dVMWlrY2grMUFFSmpxeVlraWJr?=
 =?utf-8?B?QkY0TURtY2hUTWpMeEJGakkwRjhBSm1RaCs3RmlCT2NMcVZBS1Z1bUlHWWlG?=
 =?utf-8?B?TW05eUkxeklqV2FqR3NXenJ3ZWg3UG4zOENYTVE1TXdyaWV6WnZRQzlmZWRv?=
 =?utf-8?B?Y0RsWDUyMUhGMlhCMFRxTENlMXlsejU3NDJlWVVPNUZwQlNTbGpMbXliUHIv?=
 =?utf-8?B?dEFjVlRyWHVKWjdRaDB2UDZLa3orYkNxR3dIenVDUFFqSXlyVXRIeW1HTUU5?=
 =?utf-8?B?TEZQRXBtZEN3RGRDOHlNU0pvOGJPWUJFcVBVMnJ5bUdocEh5NkJwQ1JzMTRP?=
 =?utf-8?B?R1cxL2VTQzMvT2EyaFlzQ3VqUXNoTVBCY09UZ0xFazZKK2V0bHRmZUZQKytB?=
 =?utf-8?B?RmtYalA0TmZ2amJ6NzlqT0xHSHptdHpMUTJJUUh2dVFFNnRoSlY2TjcxYmEr?=
 =?utf-8?B?QUpaMkQwODBKRVg5bmZnUGNzZ00wcmQ2emUxTkJieUdZOExvdy9BOEhzdWFz?=
 =?utf-8?B?VnNjcVMzYTMyYXB0VStMekVzc2RvYXR4TjNwTEhhaFYwMGVwajV6eURkZnJI?=
 =?utf-8?B?OXlLYzRmM2FGdTFuQ01qQTFvalpvaFhTc2RWTE9OYm5EemtTSVVLSHlYa3RZ?=
 =?utf-8?B?VGkyTTVjaGFBQ2hHSEpCYUFxSzdlR0wwOXhRR3ZLdE5ka0kzNVBjR0NNcDhm?=
 =?utf-8?B?d3JxUlZkMmd1bTBxNnBrZFJGS1pDQ2VNNGdIOFVOSXp4dUFtUDVJVkYwME1o?=
 =?utf-8?B?WG1LeERJWnR5TjAxREMrQ1d6a2hZNDhHKzd1bGFSOU1odFV5WTdYMVVqbjR6?=
 =?utf-8?B?MGlWL0NXaVFWMTB6YmgzamVsVmMwUytVbkdZbG9kcGlyVVg0ck02WjJNY1BZ?=
 =?utf-8?B?VFdyaldQa1podnVQTEplQnhDRDRDdVZpSmZHNmRrM2lxNXovay9LbVdsMWRm?=
 =?utf-8?B?NTl1ZDUvcFgvcERwbHBjWVVDOFF0blpOc28yMTF4eDQ2VEZKMW9TQ3NvNmwr?=
 =?utf-8?B?N2lmdzFpM01LaEp4Rk1sVEZjN1c0dXVYdmg5TXJld1pBQVl1OEN1Mzd4cURu?=
 =?utf-8?B?bDBDdVBjS1B1bzhqcXVhWTMwVkErU205RW5pUkd4cEZJZEQxZWJEQzFwbUh0?=
 =?utf-8?B?cldCakNRM3RnYnFDZGxNK0wrcmw2T1ppNzhiZStKZGh3a29sbW5hci9oVGwy?=
 =?utf-8?B?ckc3bUxCdEJGTEY0Y3lwbGV0Z2Vwa3U5R0tmOWFFK3VKT3FTeTZXZ2JQaDFY?=
 =?utf-8?B?N29oWlR0Vnk3WHRjeTk1emRWTVBIQ0tVZll0RGZ2Q1pOWDFJUTYyT1ZNZG0z?=
 =?utf-8?B?Qm0wcFppVW5mQnQ0SDZFNmdhM3JZSG5IZzJBdGd1M3c2Qi8xOFM1d0ZkcXlH?=
 =?utf-8?B?ZUJhb1J5ODhoV2MyQW1qYUNMVzd6aVVoRm5EaGQ1cTZuUWhqUlVZUENoZ3RU?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TWtkOVFLYll5Y05UbXhNcWJwNWRNN0IxLzFhWUptRG82K2ViTEhvZGFyWVVm?=
 =?utf-8?B?REhidHpIcUp2NFd4QVY4b1JtK01yYkRTNXpBd3FSZEFCNlBGaTJxZlU0S3Mz?=
 =?utf-8?B?QnV2ZC9rUGhwTmNUWVFsRzU2UXdhYTdkVVdQNG1tT2dzakludWlwTnhaUnh1?=
 =?utf-8?B?UkZ3ZlpWclZNYjB6SFVidjNmMWJYUms5eGFqZVhiQ2pId2ZOT21kUFVBSDBG?=
 =?utf-8?B?bUp5c096a2JSZm5yd0hHTHA1SnFONWJic0tTMVV3NmRoaGRvSzJ1SVZkMk1r?=
 =?utf-8?B?OWt2d3Q0TlNEYXEvd2RJdzJTa1MybytOVUpTWTRIeGRhajJ6Smo3MEhFb3pw?=
 =?utf-8?B?YUhTUVZHbEhjSkdFdmFEV0FldHNkUjBXQTRuUDhNRTVNY1IvL2lYelBVbjhp?=
 =?utf-8?B?TXlpYVRKSEZTdVJBd0hlYlc1WXhwaWQ4Ym03ckQ2SGQwRXFhbkhEUW1sSk05?=
 =?utf-8?B?QVlmeXJicUVWSmhFa3RUeGY5eCtUa1RMczdoK2FxNVRjK3ZWcllSYTYvNmJ2?=
 =?utf-8?B?dTN1ZlRiSWFMa21kQnN5U0g3aDhGRVhUeGxtaWRkd092aVZ1VGdPbnplOXRy?=
 =?utf-8?B?QndsMTVMbUxlZ05ON0dkcGJzcWdIbW9jbExHc0RvVkplV3hiUHRmR3FyNTNj?=
 =?utf-8?B?N2dnVFR4YjlwSUtGS3IyelZYck5PUUtXdTRGSEY4MTk0UXBjTGtIbjJYVU52?=
 =?utf-8?B?SVNqbDBYditrNW5sdGFjWHVUYmdFMDRRYXhzMlRoRVdtck52WmkwL1pCUlAx?=
 =?utf-8?B?R3MveE9vZHlvTVJ6OVdTbUNjbm8zZ0thVXd0UXFROU9LVTQ1S2lQZXpNUG5r?=
 =?utf-8?B?R3dudDg1d0JKZVRQa3JIYkY2cVI2dlRKMHBXVkdUK1JTMGNBOUdabjVyS0ds?=
 =?utf-8?B?NmsydE9zRjh1WHoyY1kwQ2dYTHBiRFJaNlJwTjE2djExMU5TUDR3b2J2SmZM?=
 =?utf-8?B?OGNnKzVuRitWS25IVUwvL0plREQza0FuM21ZY2k0RXBQWTZVd3h5QkhWenJr?=
 =?utf-8?B?a1RXdHh6TWxMUFl1TTB3SGlMNFpqOXFFaDJ0d0RhOElwOXQra2VnTk9oS1Nw?=
 =?utf-8?B?REhaT25hVE42cUs2L3I3QWJITnRDWjM0Q0crMGQ4WDZ0aWMxTEpkUGdDdkRC?=
 =?utf-8?B?cVFzOXVIeld4b2FKdnN0MkZUclkwRXJobkRqZzdHOHFseXB5aEQ2M3Q4c3Zo?=
 =?utf-8?B?R3RnMzNHeGNEejkvdDAzQjZ4REVZeTRPY1RIWHMzcGRodmo0ekZTM3BjWkJ5?=
 =?utf-8?Q?ujE0zbwxk4Rqd0e?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7abbcbbe-8faf-4ccc-6610-08dafb328388
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 22:06:00.2068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRosi0MB36iTlZZJXTXXT7DljmpGjcC8/GvaYBgugwZk5qQv2vgGjQUCKbKbKdCaELodQH8pOedOh8/4vFMBOpUJGcbRiBIjtFnFCoEjJs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7275
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_11,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=985
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200211
X-Proofpoint-ORIG-GUID: dKTyG2LhKdD5_D929TAn6OHJjn5itNO7
X-Proofpoint-GUID: dKTyG2LhKdD5_D929TAn6OHJjn5itNO7
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/23 1:17 PM, Matthew Wilcox wrote:
> On Fri, Jan 20, 2023 at 12:45:38PM -0800, Sidhartha Kumar wrote:
>>>> @@ -6176,6 +6186,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>>>>    	spinlock_t *ptl;
>>>>    	int ret = -ENOMEM;
>>>>    	struct page *page;
>>>> +	struct folio *folio = NULL;
>>>>    	int writable;
>>>>    	bool page_in_pagecache = false;
>>>> @@ -6251,12 +6262,15 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>>>>    		*pagep = NULL;
>>>>    	}
>>>> +	if (page)
>>>> +		folio = page_folio(page);
>>>> +
>>>>    	/*
>>>> -	 * The memory barrier inside __SetPageUptodate makes sure that
>>>> +	 * The memory barrier inside __folio_mark_uptodate makes sure that
>>>>    	 * preceding stores to the page contents become visible before
>>>>    	 * the set_pte_at() write.
>>>>    	 */
>>>> -	__SetPageUptodate(page);
>>>> +	__folio_mark_uptodate(folio);
>>>
>>
>> Hi Matthew,
>>
>> In the snippet:
>>
>> page = alloc_huge_page(dst_vma, dst_addr, 0);
>> if (IS_ERR(page)) {
>> 	put_page(*pagep);
>> 	ret = -ENOMEM;
>> 	*pagep = NULL;
>> 	goto out;
>> }
>> copy_user_huge_page(page, *pagep, dst_addr, dst_vma,
>> 		pages_per_huge_page(h));
>>
>> I thought the IS_ERR() call does not handle the NULL case and is a check for
>> high memory addresses, and copy_user_huge_page() path does not seem to
>> handle the NULL case as well but alloc_huge_page() can possibly return NULL
>> so I was unsure about how to handle the folio conversion.
> 
> I'm not sure how alloc_huge_page() can return NULL.  It seems like it
> returns ERR_PTR(-ENOSPC) or ERR_PTR(-ENOMEM) if it cannot allocate memory?
> 
I see now, I agree that page cannot be NULL at the return from 
alloc_huge_page, I will make that change in v2.

Thanks,
Sidhartha Kumar

