Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDA272A6BF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 01:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjFIXcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 19:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjFIXbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 19:31:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B078B468D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 16:29:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359HT337030623;
        Fri, 9 Jun 2023 23:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6IjzY8tA4O/YER1vHfMZilZFpjZ9ex4yhRMnloQ/PNY=;
 b=dGZDq6MgiKHzfvZA2STvmDLMVkP3VAq3tCz4Au6W3bx2on0shhOhqtSb1Fwvfh6oZkJJ
 7LUErKrT3VVTLBs44fcFUfbidOXfKqQAz285MOu1fwiQ5aOqWpw7lu/A6/FkdZdi93XB
 R5CGL1L9Pck0QhnCPQw+yN+XIcKNueipXV7DvIcr2nQjwuvLM2Bm4mtAjABODq4XPzox
 SINiee/0VHUGEzmj8RO6q/nO5gjbCztuwXmJVA3YF44Sv+ufs3DcB7D0oIdTIuJEVBhz
 f/ur3bClYvF1i+Aa90nE8zRaFQs/3dRZOqZ8zfoZLhYrM82khbjX6IvQMxezLf0bMZ23 lA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6rqtct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jun 2023 23:28:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 359M15EK015779;
        Fri, 9 Jun 2023 23:28:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6q02yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jun 2023 23:28:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+NMnYU02Qm1f4g9ib3syRMMmvt3gRYl2We4AfmH9KfkrKVnXaYjYDPlTKJRClpYj4cPAEurtNyrLyWIdfoEUNZ9iNgXwC1m9MTBpIBiiHAtJbSn5/VGh7yDVAMvMuPRov3x6s/pqRGzRq0NznBk9ujqurUuyEtJaX108JeCS3d2X2apPXv40HNox+ZHsSugo6EsNd0JGC4+JV741h57dO6UMjvcScEREXBb7HcOR6dqM3fGw0oMf4oOcJO8Hu1k3VYLNtbp6Jk9tukMOKlsrMY9Glmb6uXZmwdxqQUEWpA/nCsd6ZAr686U78obTh1YLBNZpIBP4VJOtUHtIXcnRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IjzY8tA4O/YER1vHfMZilZFpjZ9ex4yhRMnloQ/PNY=;
 b=Tu+UDN/AFvQzOcgzBz982HGtoyXpLXL3Xi5XbJjywcD2sBZlwaFW05NRpffc//R8EI7CBk/9A95ND1Fp7tnWq5uOZgGXIINrsFdkdcce+D5Q2F/zChxV5b9QC+it/OtP/QBZRtmBEJzuVB5INvfbNmS2/G/xNw0BUVYilvgrGOpwr6o+myTkgddwiX/HwtPkMvtq1PP1c0Gqi+1Ikj6p+0c7Cbd72VVullAXx1i+e28dct9romdUrax6od+PInsydu2LK+nVO/hd9xL9QqMcI6AXRLa4aNikSKN0BR/p5sfgLwfMD001DP8ia5CZNfK5qMbxwwrzazc3bx/G14mVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IjzY8tA4O/YER1vHfMZilZFpjZ9ex4yhRMnloQ/PNY=;
 b=l9DZYfst4v85YhJvxUbDH40Rj+eUUhrguTQ/31UCCPBs5mw3OJ2iXG+kSWULR8R/PrfD02Pm9hlUWrZmCXsO4M2dizMf8pE60Ce8mjQ/OC1LHEwkXV+MqpVmXRcNi/CcNdX3SLcc6p4ybSyuIBfHnDO1VMNOznbk0W8EJweXnkY=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by DM4PR10MB6694.namprd10.prod.outlook.com (2603:10b6:8:112::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 23:28:41 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae%5]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 23:28:41 +0000
Message-ID: <a6e84fce-31e8-bdd2-8ed9-de099f5e2230@oracle.com>
Date:   Fri, 9 Jun 2023 17:28:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4] mm, compaction: Skip all non-migratable pages during
 scan
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        ying.huang@intel.com, mgorman@techsingularity.net,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Khalid Aziz <khalid@kernel.org>
References: <ZG/I7tYY4uV/32hP@casper.infradead.org>
 <ZG/To8Z3StoVoenU@casper.infradead.org>
 <60367660-f4a3-06dc-4d17-4dbdc733ef74@oracle.com>
 <ZHDh4Jeb/vKY+nGU@casper.infradead.org>
 <f5a37f8d-d888-9085-2f2b-1e350a267396@redhat.com>
 <ZHD+eOMpZpWXNAig@casper.infradead.org>
 <e31cd404-56ce-4cad-fcc3-3a6695f750fa@redhat.com>
 <846b770c-9f63-90a2-0435-ec82484e3f74@nvidia.com>
 <ZHF2byaRlaX3W6Md@casper.infradead.org>
 <9821bd9c-7c30-8f0c-68e4-6b1d312bc032@nvidia.com>
 <ZHPydXSAfRq8sh0u@casper.infradead.org>
 <4d035744-271d-1ca3-a440-f8b1573eec96@redhat.com>
 <3c2ac70b-31a2-4e85-0ade-cb9f701525b3@oracle.com>
 <20230609151111.bb7908254853a0879db07746@linux-foundation.org>
Content-Language: en-US
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <20230609151111.bb7908254853a0879db07746@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0144.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::29) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|DM4PR10MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d7e271-429b-4b51-6c0c-08db694141ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QyCyC+h643GMHAr0Dnt6SLWNFF0Z1GFcfuTl/e0B1hmm47oBMox84UEpUII0i2Di3MmEajw7Kg++eMMLlb+o6ud5lAKbGU/u8KYa97oi8QVu1iRH06cbjnbuozBWyrCAj83UihOv/i4Z2/ZymulaE7opQAy5TYS9cSy2eSDV5BtISzsYN0o7rk/jxZa5+4byMvy20UEDR3+qKstB/WF0NoFVYTxP5dWHxO+2nvRKiZjPZy3xruLBFGMMeB98pAgWP1P5D+AN3EHwIg/0WxARtElfwacnNQmtxtdPHBMplmsh8+9fvZME8Adcp2sxYPp5ShI2tsiqF9GSsjHa7PilHNG8l1gDtqY1GQHezkmqFORs0r7LyedoVfYYQJ6PxRZ71o7Gn5Bm1YWASKPV26pW3kruQLY5CHMLRq9htPMsWwg7lknANl2/FOY/QL0vmFCCNxbk/AFMdtj2t4yjvCAgSMJMeigYfYr4XLqEN3c8CrzobttzfJ7BE4H3gHA5iW4SnpdU3d6yiKwB+EcRYtPm77ZjMHC3aI8xcO6tgFN8ZYIQq2Plr27X9XYk70LlMu42EQzuIv2Q434fLVOo868AwtFuT6UJTi0B7OYjQf9mOBWvozo/GMnCQtawitZyKWv9VqFL5AmJAbtp8LBhQrOrJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199021)(83380400001)(38100700002)(86362001)(31696002)(478600001)(41300700001)(54906003)(6486002)(6666004)(8676002)(44832011)(4326008)(66556008)(8936002)(6916009)(2906002)(7416002)(66476007)(66946007)(5660300002)(316002)(2616005)(6506007)(26005)(6512007)(53546011)(36756003)(31686004)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlZjM1FVNlhaTndsOFNCS1JkVWcrYzk0anlERWtWa0FBakVDOWEzZ1BNZlR0?=
 =?utf-8?B?Um15eFBwWlVXZTNBMUZLWWlUd20rLzNDVWYySVZ2NjNPRTVYRTV5MHBTL3NQ?=
 =?utf-8?B?NEI0QkVKTjFYZVpyakViSk1tOFQwZjhHK2F5dTdvRHpUdTVrZE5UZ1Vtdnhy?=
 =?utf-8?B?ZlRzaHBpU0FOTENKM0ZqTStSK0ZzWjhMMGYwcy9qVEswd2czS0xzekF5REpu?=
 =?utf-8?B?djJ0eTNTOUJVWkcwWmFuMjVmU085UG5LUlpQeGx4Kzc4cXZBb2F2dS9scExW?=
 =?utf-8?B?bkh2UkJVQUNscEpJQXlOYkJ5cDBUZlcwOFcreXJxWmxMaWxrT1RJaGk1SzQ4?=
 =?utf-8?B?N1dERHduL2ZtQTlMNC9OcW56dGtEalNEc0FJMTU4ZDMrczk4eVpkaFVmL3M2?=
 =?utf-8?B?MG5hRm5jb3h2em1SaEluTXZFeHpzNlFQWGdxQVJtZTJsT2JmY0VHdzBndVd2?=
 =?utf-8?B?RkNhd1ZvdUkxR25PYWUwOHNuMm1iUVdmMFpuNlhuQ3AzeThKelFCaVBFWW4y?=
 =?utf-8?B?MExZdmFPek5OdkNPOEMxK2psNWM0ZmpQMnNxa1hJZ3p1VURudGNBdzVlNEVJ?=
 =?utf-8?B?UWdjOFA4WjJ5bFRjQVlFVlF0QnczS09uWnpZTHNRb1ZUVnhWeUdhRlAvRnVK?=
 =?utf-8?B?OWFpNHJ1V0x5Ym9ldW5hKzJhM0VaZTlGalBUUXIyVDBSVDlsSEdjOEhNVjc0?=
 =?utf-8?B?WW0rbHZDNFRjS0JiNkR5VGs4RkdTcUo4NnVhWGRiMTRSUm1pQTFxejR1aHN4?=
 =?utf-8?B?NWdlV3R4SUNETEM2QTRqMThPQXN4UG13bVFOa3RpN0V5bklyc1V4dUUzU3ov?=
 =?utf-8?B?MWFxUWpoemNTRHhDc0xobzBFWWQ0dXpKNTQxMldXRXhPUEVIeVFxWDk1eG5C?=
 =?utf-8?B?S050czZRaDluRkFFdHIwWDlhc3daTUk4SzVPZUFsVGphVGF0K0FQNkxVd015?=
 =?utf-8?B?dnRpUWtoUTM5K3p6aXpCUlNWMnVqRXVZdFB2MHRhVVM5OTVNdmNpN0FKMHZR?=
 =?utf-8?B?VDE1MWR1eXVFaDVpNEhwejZadUI1U2t4UUZ6dSt6QTl4ekxHQ1RyS3c1UjJr?=
 =?utf-8?B?cnlwd1lja0VxODBEQkNRSkZ2eGd3aVBlbmFZd05mVFl3bzNLaHhPaWkvL0hY?=
 =?utf-8?B?U1JaYkEyQUpnRHlsTGU5RWtKNFg4NHBQU0pLTkRMdlV4M2pWNVBxNTdUQzNi?=
 =?utf-8?B?WHdDV0FXOW5kNzJqdWJVNDJ0WmRqN2lEeFdGSzI0TUVlbXVIaHJubGxWUnNG?=
 =?utf-8?B?aVpnL01qZUNxVkNYbnQ1bURoeU41dGc1OHZqRUkzcXpOWk9oQkVrbmJ5dUVi?=
 =?utf-8?B?dDl0bkFTMTZPQ00zKys5cFYwczYvZURtbG11WXgxNitieWJvdjRVVFh0Qmpp?=
 =?utf-8?B?NUlucFJrYkpDMEFheU9NSHRvVGVYSnlTeHFJaFR2byt5Y1lETjRKM1NqTXdN?=
 =?utf-8?B?eXpVZzBpd1Rrd0VmSFNSbVNwejBKckZNNXNoaC84TjM2b01UOU5FaDA3UXZ6?=
 =?utf-8?B?dURtT3JxSFUrbGJIOVhRdENGSnlHMEptNURrS1lWOUlzS3V4aDFUOEIralhq?=
 =?utf-8?B?L09vK0R3SnBRQmZGbEluN3MvTXlWeE0xcDQ3UVhJVEdaVUd4ZmFqSys4T3Y2?=
 =?utf-8?B?MVluRVNGSUJyVjNYWEJCbVF5WVZNWnV5TjdKZzBxeVlOVWE5ckpaMTBGeWp4?=
 =?utf-8?B?VnRyaGpZTzNiQXpMRHo0YnVQM0ZVdVhNdU1lalNOMWl0SnBCWGNoODZkQUc4?=
 =?utf-8?B?L2JZZVN1Wm80YkxTUjhCZHJVakZSNEhPd2l5M0Yvank4TlJmWDRyRmJmQkMx?=
 =?utf-8?B?SWc0ZDdPRWpoOEpFM2pKaG50VldlMEhVbU5xajEyck1tWkxoSDhUaHdWdHJX?=
 =?utf-8?B?WnNPeEpPdTNPYXUzVUlSZ3B3VjgwdjJNSnNFZjh3U3RWaHNkWGw4QXlLZm1K?=
 =?utf-8?B?RW1LZ3RyMmhqRXRDRGVuOFFYQzdXMStSblFTbnc2SDNkTlZteDc5R3kwQmFO?=
 =?utf-8?B?TGFJUDRiT29ac2JzbXJFam9ud2FjRUhkL090NzZMTDd0WDNMOVZldjdCYk5J?=
 =?utf-8?B?V204SXhuaGQxRnRHRnR2dm14Tkppei91NFk0amhOZ2VsZWJGNmNWUzA4dllm?=
 =?utf-8?Q?2ZhsxgtMCJGqixlCpIZi1JXNr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YzJPZGN0WU45cDR5aFpYSnR1bzlvS1B3emIva0cxdnpXMFRpT3RxMHVJYjlI?=
 =?utf-8?B?cU1FTlF4WlBsakFyeHFJOExUemZqRDllUUlDWExaVVBIbzF1VmVxMkNUQXkx?=
 =?utf-8?B?OXJjQ2lxUGZaTEJGQzcvWS9BZjY5cE9FTGQ2Y1hNYUUvbitBNlpoTmRFZFNM?=
 =?utf-8?B?eW1uVC95TEZjWm1tZjZEUWlTNURUa3F6U05oQit4TnAyRW9Td2xWalllTGQy?=
 =?utf-8?B?OEZMVkl3UEE5bmRpRVMxSVMweXN6bDQ2dzdPd05sTWxUa3RWZzJrejdXeUVD?=
 =?utf-8?B?dUs1d0g0TEJhR3cvM2QwSFphRm9Hbm9QNU5xeTdHanBpa2JucktkREhDNngy?=
 =?utf-8?B?NEFDRStsNlBLdWVERTJYem0rWGtlR3lFUTJUbVBQSnVycEZpVzcvQ2VpYld5?=
 =?utf-8?B?MTlYdkJJNnNML3gvb3RwcWZiY2tXZ0w5WVBWei9FMnFIWk9COERWajVOWEdw?=
 =?utf-8?B?RWdoSWw3N3krc0RDT1pSMkJrOU5xWXNMd3dBeDBGdW0welh3S2FyanpNc0s2?=
 =?utf-8?B?bzNlLzIrc2NVc0xCUTV1c1pKVnh0MnZyOTI4VnB6SSs5am9ndU4yNndyQ2dG?=
 =?utf-8?B?STh4aERMOU56SFE0OUxiNE9TMm5XZ3pyVG1QMWY0K1BpdEx4aFZUWm1JelI1?=
 =?utf-8?B?dlJnY2cyYURydmJIekdNaWlaMmxnUWNqbk5oMGRHZVc0LzlNMm12cnJkenZG?=
 =?utf-8?B?Yy9lZ1E3cWhEUWd5NFo0YlFYRUdOQmZXNHN0cVlDeUNieEs4blNvcnNGYnI5?=
 =?utf-8?B?Z3VoQnJROHYwMkd1UE13QTZ5a1hlOTJPOUN1aHZJc2prYXFaL1RSMTBDcDV4?=
 =?utf-8?B?dDFiMUJ1Q0hTek1oNzhnSGh4UkUyS092Z2VveFE4U1J6eVk3Qy9sUjFVZGRM?=
 =?utf-8?B?Zzdxb1hhWDVhMklPNUR6R01vaU9kTjRuZmtPUjF2cjhycWlWZE1xL1NsRk1a?=
 =?utf-8?B?SzY4MWYrdXlRUjVVN2lOV0d6U3VEdHc5SnNOeSt0VzRjSHgzRlBMSGJDeE1j?=
 =?utf-8?B?OHRmU3RtWmlHZENaaCt3SmV6Um96ekNwQVZxd25tL3diN0JlYktKMkZvMUt3?=
 =?utf-8?B?amhnTzZldm5nRG5tMlA4UnNMTGhsTUVhTzNwbm95UDlZOVBVeS8xc0JaM2lY?=
 =?utf-8?B?WlZkUWZYb0xSczFNWW1KYk1xaTh6RGxOU3RWb2tCRzNVeFpheGZjNG1nLy94?=
 =?utf-8?B?elB3aTNNcHFEN0tib0dtajFLYkNhL3FZZFhnT3RwdGJkazcrN2tYTnNGZFpz?=
 =?utf-8?B?R0dTRWptaGxFNkcvTlJrQlFNYWgzMG5SMzVNRHIvdWVEcmNySVZId0paMjRn?=
 =?utf-8?B?NGNLVWIzdFFBN2p4eDNCVlMyTENEUkMwOXhOaVozU3FLYkwwenV4Ulc1QUhn?=
 =?utf-8?B?V0F2ZytnQURpUEQwbUpPTkxBSUdBcWRkZ2FLQW9JekpNdi8xWVdLem9GSHBm?=
 =?utf-8?B?aDZFZjRDZHRVWS9ST09ZVk05UncwY2hzWEdpa0dnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d7e271-429b-4b51-6c0c-08db694141ee
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 23:28:40.7413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmxFOGUxwodPGl6blkJzrn+/FBpgXz/UHOAxlW/3SMNvlTA2vX9JtzK+dbaHuQosq3PEyZ7NyMYeEUcKlHfNjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_17,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306090199
X-Proofpoint-ORIG-GUID: Q5-su78ceuSoFxHNXt5LQlRJ1MJ16JVh
X-Proofpoint-GUID: Q5-su78ceuSoFxHNXt5LQlRJ1MJ16JVh
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/23 16:11, Andrew Morton wrote:
> On Tue, 30 May 2023 09:42:33 -0600 Khalid Aziz <khalid.aziz@oracle.com> wrote:
> 
>>> I completely agree that we should be careful with such mapcount vs. pagecount checks, and if we can use something
>>> better, let's use something *better*.
>>
>> When we have a reliable folio_maybe_dma_longterm_pinned() function, it will be better to call that instead of doing
>> refcount vs mapcount check. Until that better function to check for pinned pages is in place, may I propose that the
>> current patch fixes a customer problem though not optimally and is a good enough working solution. When a better
>> function is in place, page_has_extra_refs() function can be updated to rely on this other function instead of refcount
>> vs mapcount.
> 
> We seem rather stuck with this patch.  I think I'll drop it while we
> ponder a way forward.

Hi Andrew,

I would still recommend that we use this patch and fix the existing problem, unless there are objections from other 
people. This is not an optimal solution but it works and is similar to what kernel does elsewhere. When a better 
function to check pinned pages is available, we start using that function instead.

Thanks,
Khalid
