Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D212716758
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjE3Pn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjE3PnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:43:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BBFF7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:43:21 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UE4343026571;
        Tue, 30 May 2023 15:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=J5/SrO46wTmT0R9r+4BKq//5JniRnYggiBHUhJdM9BY=;
 b=hyLeyFAtFQN4n5lhdA0gyoCaXlBMHx3isZ9mIlJmiOSQ3hjG57npgK9cQxp4ek+uXwCX
 mzHtZEF0eJElP0h4VpZSHTgt/etqcWfsoGuXVzEJ/abmPlJNWouN6wuJsxsIyqRzxYDM
 Djzw7iAqG6K7Ni/E8zN3qoMesQ9FziycUIq76BfW5dVNrN4FUPn/W9GkGINSDyacYUmq
 A1QY9vNg+mELCo4XX9U2B3aEQJomDA2NdYH+10QJVJHmDTkkpVuYhxMX4lTRphQh9ZGN
 gTf4EqdqafitrCnfZiTQUNScFyRWwexmcKfpcVXjU20w+jG4gSfspmAMUiQLtwyzHnfb zQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhwwb274-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 15:42:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34UFJYFL026066;
        Tue, 30 May 2023 15:42:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8aak0h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 15:42:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkYbYMsNX8U1I91O0gsM+tnFWSj7GHobhn2iXuisiieiaGjvaSuFgnamky+YKXocO6QCUY2QeV9DYnbuefnU74PRRh3NhXh880i2CHMfBjYK/yuEfDZT3zYJAWIqRIBBuwdETCM9EXOxHLB6ECGn0Negc70q5dTI0hzNjVOzzIenmHFQ1MOjsriLvpaFK4382z7XcPyKk/+9yX3tONyrknve/Xx2rkWNkO5N8n2FWGk0Dsu8KKSIomPYxKbNYHRN2B0u5i3y1Zta4QnsiciETXHK5VWifOJJ/MJYn20LLLFS531lgzMWb7vxNy1XWnibISeNlVodKBWDhGVRJQac4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5/SrO46wTmT0R9r+4BKq//5JniRnYggiBHUhJdM9BY=;
 b=FRkhkH0fS29LIJOKERDjo2lTsmVeY5FI727mCWzHhB1B3zauGCplumA0MIu4oIfaSicmWBZB1cO2cG7PE8OW/o64nGGKwVySzSQEvYGuVRp4LQ+lnoki2lLAgsTRjklRLYS4MJM37iCw4Hz10u098w7+OBNgZq4CDdfEBUxLMXVFaybFgHFh5jFC0ypIO7yDUBIHvnpaFulOU66Q5D33TTm7zr6qR535ZqGTC9qTGaKZKwY+Y29FTn4jg0hDOjO+tpny2BnrmivpRaJbUyPEK7pZ5oLXTgp8ywdWOZnMj+tMyDW3+3xLbqRj1gpdIzY/G2x8NV9NhRJ3HFbW+sVBkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5/SrO46wTmT0R9r+4BKq//5JniRnYggiBHUhJdM9BY=;
 b=iFvz/GCgpLpVzy6OHdSgv25LkUAbILHaPM+Pa+4b+VtfX1zC7Hl+EZEyHi1EM8iSzNpXPVdR2lO6vlqUKgIbcwvMVFGFmDApEWuPSBsEffCfGBAnmwaATuvpewiNjJw/NGpzukeQ86svquWsxCZ+qhGmvZPkjwSXeHHDQWMizRw=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by SJ0PR10MB4607.namprd10.prod.outlook.com (2603:10b6:a03:2dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 15:42:45 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 15:42:44 +0000
Message-ID: <3c2ac70b-31a2-4e85-0ade-cb9f701525b3@oracle.com>
Date:   Tue, 30 May 2023 09:42:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4] mm, compaction: Skip all non-migratable pages during
 scan
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        akpm@linux-foundation.org, ying.huang@intel.com,
        mgorman@techsingularity.net, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Khalid Aziz <khalid@kernel.org>
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
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <4d035744-271d-1ca3-a440-f8b1573eec96@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CPYP284CA0062.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:80::13) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|SJ0PR10MB4607:EE_
X-MS-Office365-Filtering-Correlation-Id: 935bfa57-a694-420c-2806-08db6124828b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E7j3o4blKN4nlaSzQWe2MS7xPKxjx2TLh3n0+hYdEzMnbEHoCr3epVc81dgEp1Q58dVmsuUPKa3YdexzJUXZnI0whoKUX5J063fbVnuLGzswcBQL7Qp6q2vaqdIu4NLn2AGSpE1GZQTEWNfVHaVQyYIBRbZiIIkoMS3KKnvAI6gMvh28VYiswMPcY/wy4xz8fXtiwuX185vG5Nn/AIF87SGUaA2bwxPomhgcCuFsxR376412IAPPIKC1mh5ERU5Ea5hHg5rK0PTZT8ewXAbTqZtfs9H+5hZtqY+oY0tAS+I1tnapWbMlhxYlGcqxh19dP83W5J7SkNldaCUC99KBMy5opuIV5HixSkCpVPoTHdNjEZoWVRHudrD+3QCZFS66DNvSVeu91Fqdkbb+N3avatlI7YDMiWJ2eW2qC2rcLg4JusG4Ij9vGQe1aGJNesfTdtezWDDxyvngSWQnXmXkQ98fmjg+Bc4SiQ0UXVkhe8K4U1vc6rg7y0pPQncUmNhBresZtU35qEkOMq3Rh99Hf/pxy7sb4EoSG1sNeyFPETnfq7jtF2wX69vb88COwLQ5Bwl6QQL5ZaeHuSgHAKNSrfkh5SLMaeqbfRAr4rqcFAw5SyeMn44fqFGfbsCGg6LX+jMR2A4HYDhI9imURY5v9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(66899021)(478600001)(54906003)(110136005)(8676002)(8936002)(44832011)(7416002)(5660300002)(36756003)(2906002)(86362001)(31696002)(4326008)(66556008)(66476007)(66946007)(316002)(38100700002)(41300700001)(26005)(31686004)(83380400001)(186003)(6512007)(6506007)(53546011)(2616005)(6486002)(966005)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTRUYU9GNGloSDI4cENGUm5BcVY0U0I5d2VDN2hXMTRZSUI2WWx5c0xXWWhQ?=
 =?utf-8?B?OXMvZkxvZm5lR3ZGQ201SnNVSGowOXhWOEhTZnp3OHN1bFVNd2VSMk9sQVpo?=
 =?utf-8?B?QWdUa05HdmwweTdwVExqcXJJa3o2bDR3Zzk0eURxVW40SXJaanFoZWhQUVJ4?=
 =?utf-8?B?UFVadmFRZXExR3dDV0dmbDBidEFEMWUzcThta3hJQVR0bEZINEo0elBQV205?=
 =?utf-8?B?M0RDcnB3NXhVVDNqTEs0ait6c3BIcmVtZ0dDbTMvQW5LVnZ2d05LMVR6aXlq?=
 =?utf-8?B?SXpvRkJWVERDb0V0VVB5RjMwYTZKVzBuRlNUVDdTOXA0L21CblFyOWIwNzVJ?=
 =?utf-8?B?dkVpZHRuSkNiVGhweWVvdGxFNEFzMW1xcWxXWklzK1RjTXZ4N1l6SkhjMHh2?=
 =?utf-8?B?VWM2UTZFVERMQ1ZEck5KZnFObm1MYkY3M011ZmlsV1krSmtYODZQams5OUx3?=
 =?utf-8?B?VjVLZ1YvVTNSR1BzNlpjbFRnaU03RDhtS0lVUSsrWWxZUHU0WXFKTi91eUl5?=
 =?utf-8?B?Wks3RzlXR3Fha2JCYnFab2FESXhOV1dWOWlncDNNTW9iZDVEbnVuKzdabnN0?=
 =?utf-8?B?VEN3MDNkRlU2aFdoMldmMVNxQTRuZ0J1TURCWUJLWGppRmZrczltMkNTNzFt?=
 =?utf-8?B?NWxIaU5GWEdwM0ZaWmRVSDkrS2diRDUrZTZMTGs0Q2E3M1ZvNVg4Ym9SUEFM?=
 =?utf-8?B?ZkxOb011dzBNZWFkNWtrcHFMd0EvSWlvbmkwaHNsRVR4dkhzRTM0YTl2N0Jj?=
 =?utf-8?B?Mko2WUFIYWFTVXdjNzN6ZjFHUlNOKzBpRFJSZ0czTGxzYmZSLzNqYmVqWklm?=
 =?utf-8?B?dHhLTzFqZVdWZ3Q5R012NTdHTGcyb0hWQmtSNmdYY0lHVHI2OXE4aldYTERQ?=
 =?utf-8?B?TWw3aFQ5bzdLanc1eldDaGUyNDVjeEROb3haQnFRakl3S1JLY0dCdUJHZTd6?=
 =?utf-8?B?UTJ4SGdodVl2RDJqS2FQWVNXWUNvSkg5UGxuWjMySkUzMWMyZ0hXamwrVmVI?=
 =?utf-8?B?QVRPTHluRXk5dUNKUnR6blk4RXZuay9iczZMbGNraGRSaERscldZNzgvNVdZ?=
 =?utf-8?B?bFFIV2FIWDUyRFJ0c2RvTjBUSnptZTdJVURic1JacWlzZTIvV2lNanJBS2lR?=
 =?utf-8?B?OVpVYlI2bHBibFJUaEhXZHNFUytGQ1hWOWxUVm1hNVRKaHdHZ05maHBhYUp0?=
 =?utf-8?B?dmFYSnZ4QXhWU05YWXp1OHovUGo1SGg2RUFzQVdwWEJSUmdwZ2dNd1hmcTlO?=
 =?utf-8?B?VDQ0ckt2Z2tYK0pHOVM4NUowak1CSUJ5K04rUG1UOThvV2VseDZBYVRtcHY5?=
 =?utf-8?B?dlY0Y2tFaW00QkI2dzk4U1hHWkwyRmw3a3o0bGw5WkJaaWdGRW81cEpNMWVF?=
 =?utf-8?B?UHB6WjFwWmZxa3IvNThFa3JEME9uNjBheWNvYzBTdkdONmp3QnZoVmd0NFM5?=
 =?utf-8?B?V2V3RlhJS2RtYXh5TGFxNFhMWCs2VnZwTFhmaDMrc2xMbWlqeDBIWGh6RGo1?=
 =?utf-8?B?MVp5R1VYSStwSmVaU0NVcXFtK2FVeTd3TzJ1d3dLMGNkZWtQUjR4L3k3WHpE?=
 =?utf-8?B?dm1BMmhUelgzYnUvZ2x3WlBqUHh4TnpubDZod2syZEpFRmlVQmJOQ2lYdHZz?=
 =?utf-8?B?UHN3UlRDUWEzZ1g4UlpxRlRpLzRGSENvOXpLTEJ5eWNaNTI4VENJTlZTQlVW?=
 =?utf-8?B?TTZqUW1lRHY4VjFjSStwbWZaZG1aQ2hkeHhYSnVBNnlyQVpvbEZlTW5IcitS?=
 =?utf-8?B?WkNPVXIwSFhtYll1cUlhQVBSMTMzeVlBdGpBazlSUU95SWZTMjFjNUZqT1hW?=
 =?utf-8?B?VVJIR2QrM0FXT3Y0Sy9Mb1FQUjhYNUYva3V1K3o3TFI0KzFSWGNHODduZEFD?=
 =?utf-8?B?UUhsbmRzRXk3TU9zdW1jSk1WKzRWcENmTzcrY2ZUWCtQWGhuVU05U3htSDVv?=
 =?utf-8?B?MzBJYUhzZkdoNGR1eHRxSkpaUDVJUzRVV1E4T1JvMXNzeElYRmRkbElLT0px?=
 =?utf-8?B?ZjBiYmo0ZmEvR1UzK3crWFhoTHpQRGREcll5NWtZNER4S0pXWE9aRTdOWTB6?=
 =?utf-8?B?QnQrQk9mczhmZlAwTHY2dXoySGhWNTBNWFU0Y2pZM0ttTUk2bWVRV1I0R3dw?=
 =?utf-8?Q?KyToLD8Ck1TBqWgG/HDneYgdY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NXU4SmRMSnpuZytBYURmMUhCVVNWWnFudlB2VFZmNkJhRFg4VEJCM1J2R3VY?=
 =?utf-8?B?TUQ5dE9GZm9taVg2dFBlYXFjUCswMzJxSzVQbll0ZVB0akZJZnBCbXpDejR3?=
 =?utf-8?B?K2tQdnFrSHRKdjhDTktmZ2IzbjNUTW9wZGxZM2FOeThhVXhDd3NXUmliRXE1?=
 =?utf-8?B?aDlWKzlwck5sZWRCdTR0RVBRL3NNVTBNaGVFclkwS2hyUzh2eENYYjQraW45?=
 =?utf-8?B?cUNNNWJmNW5vNWxRTjZtWTR2RWZUdzc1VVc5a3JpTGNCZWdIbDNaWUFFUUNZ?=
 =?utf-8?B?WkJyL2xmMkJhUFhWenhiUUgyWUtwNjB3Si80dDVSZkVRWVNaU0MzVnp0MFht?=
 =?utf-8?B?ZGFsbmlWUzR6UVF5d0FBaTZBcHB3a1h3YWlxN2RzQWhtREIyRzlFNWJycjU4?=
 =?utf-8?B?Qzl4T3BXRGFid3VuWVNZTDFTNXhCSFB1dEpGcFIxUXNDbWtaVmVaOVV1NUxn?=
 =?utf-8?B?MEVOY3ZrQlNlUmlQQVcvbE1RbktIOWRhL1RMZlY2b2ExNjNRK1NWNy9sVEYr?=
 =?utf-8?B?TFJwUkxaUENXRlcyU1YvdFVSbldlNFVDL255ckd6YVIwNk5GYXJFbDFxWXZQ?=
 =?utf-8?B?OC95WHF4bGFMQzVhT2dSZnY1bUFnbnNIVS94eGJvOVlMYWpFTVorMy9TMnBq?=
 =?utf-8?B?VXZWZU1GSmw0M1p0a1hvSnV1QU01UXZ0QW4ya3ZUSXhpM3B6SkhuYTV2ZFky?=
 =?utf-8?B?ZGNFaTczWGpuVmdjQ3NkUjY4UDgrVzFZUis5UXN1Z0ZwMklzYnllTmM4clQy?=
 =?utf-8?B?bk9sOU9DVHJVeTdUYjVmbHBPampCOEVGZzdnQVpxT3hrVU1BZjZiL1dnVE82?=
 =?utf-8?B?dGVlNnZsY3J5eFFxaEJUQ3FjTEUzVjdBODl6UjBXU0xYM3Y2YmxBQ2M5Q1Vp?=
 =?utf-8?B?WUR6SjJLeDJ1bUtCMkdjWlpxU2ZPZGxWclJWaTlCQUxsaE01OFR4OHlhQ01a?=
 =?utf-8?B?akdkN3kySkRROGtRMnh1RSs1Y2doYXF5Vnd2N2JsM0xDVlBNWG1OSTFqRElY?=
 =?utf-8?B?ZFc3Zmp4bnVWaENCN1Z2V0EzZHU4L1VZNEc5WGxWZnhCelcyTWxFaHllM0ZD?=
 =?utf-8?B?V2t4dkJoNGxDY3dLSVdqK1I2b2Q4RnZpZVM3bzV2K1ljcVRDTGNMQkpwNFhi?=
 =?utf-8?B?ODBNUVUwMHk4YWlOdGVIeUpXa05ROTJpVVcwRXA3c3hKSDg3VEVueHdKK0Jp?=
 =?utf-8?B?K2JaMnRZN0xGbTdVQ2swaEp3RVZDMytOREJVbXFzWW5lM1hGd3JQdkk1Q3dm?=
 =?utf-8?B?QnBhZTk1b3NJS0lOaWRDZFpkVm5ZeEtJd3FqWU9WR28xWFZzN2lDbGIrblVz?=
 =?utf-8?B?U3ZkL2oxU2FHM0lGUDI2M1MvYStuWDBZZWRpZDNVUDE0MmFzR2dnUkUrNDdE?=
 =?utf-8?B?VTBoRjF0K3phZ254Ti9seSsxaFhRUkRSdUFDclBpenBkWmVlWEg5YVVwak5I?=
 =?utf-8?B?S2thUk81VTZEQ3hJWTBXeWtwbVd3a1pLeFBoMlJRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935bfa57-a694-420c-2806-08db6124828b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 15:42:44.1920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gs8JDBJOp3IwUWY76kk5Wbl8Ks/Q7nDmDGOA4F0ACFKaS4+r67msPxSnrBJI/V3ZVvjoQq2AoslzQUCnpmCnIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4607
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_11,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300125
X-Proofpoint-ORIG-GUID: mjCW8DOAdzXBnDEptHrIteWJ_5I2IS_l
X-Proofpoint-GUID: mjCW8DOAdzXBnDEptHrIteWJ_5I2IS_l
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/23 03:25, David Hildenbrand wrote:
> On 29.05.23 02:31, Matthew Wilcox wrote:
>> On Sun, May 28, 2023 at 04:49:52PM -0700, John Hubbard wrote:
>>> On 5/26/23 20:18, Matthew Wilcox wrote:
>>>> On Fri, May 26, 2023 at 07:11:05PM -0700, John Hubbard wrote:
>>>>>> So any user with 1024 processes can fragment physical memory? :/
>>>>>>
>>>>>> Sorry, I'd like to minimize the usage of folio_maybe_dma_pinned().
>>>>>
>>>>> I was actually thinking that we should minimize any more cases of
>>>>> fragile mapcount and refcount comparison, which then leads to
>>>>> Matthew's approach here!
>>>>
>>>> I was wondering if we shouldn't make folio_maybe_dma_pinned() a little
>>>> more accurate.  eg:
>>>>
>>>>           if (folio_test_large(folio))
>>>>                   return atomic_read(&folio->_pincount) > 0;
>>>>     return (unsigned)(folio_ref_count(folio) - folio_mapcount(folio)) >=
>>>>             GUP_PIN_COUNTING_BIAS;
>>>
>>> I'm trying to figure out what might be wrong with that, but it seems
>>> OK. We must have talked about this earlier, but I recall vaguely that
>>> there was not a lot of concern about the case of a page being mapped
>>>> 1024 times. Because pinned or not, it's likely to be effectively
>>> locked into memory due to LRU effects. As mentioned here, too.
>>
>> That was my point of view, but David convinced me that a hostile process
>> can effectively lock its own memory into place.
>>
> 
> 1) My opinion on this optimization
> 
> Before I start going into detail, let me first phrase my opinion so we are on the same page:
> 
> "a tiny fraction of Linux installations makes heavy use of long-term pinning -- the *single* mechanism that completely 
> *destroys* the whole purpose of memory compaction -- and the users complain about memory compaction overhead. So we are 
> talking about optimizing for that by eventually harming *everybody else*."
> 
> Ehm ... I'm all for reasonable optimization, but not at any price.
> 
> We don't care about a handful of long-term pinned pages in the system, this is really about vfio long-term pinning a 
> significant amount of system RAM, and we only care about shmem here.
> 
> 
> *maybe* there is an issue with page migration when we have many page mappings, but (a) it's a separate issue and to be 
> dealt with separately, not buried into such checks (b) it's unclear how many page mappings are too many, the magic 
> number 1024 is just a random number (c) it needs much finer control (hostile processes).
> 
> 
> 2) mapcount vs. pagecount
> 
> Now, doing these mapcount vs. pagecount checks is perfectly reasonable (see mm/ksm.c) as long as know what we're doing. 
> For example, we have to make sure that a possible compound page cannot get split concurrently (e.g., hold a reference). 
> It's been used forever, I consider it stable.
> 
> I completely agree that we should be careful with such mapcount vs. pagecount checks, and if we can use something 
> better, let's use something *better*.

When we have a reliable folio_maybe_dma_longterm_pinned() function, it will be better to call that instead of doing 
refcount vs mapcount check. Until that better function to check for pinned pages is in place, may I propose that the 
current patch fixes a customer problem though not optimally and is a good enough working solution. When a better 
function is in place, page_has_extra_refs() function can be updated to rely on this other function instead of refcount 
vs mapcount.

Thanks,
Khalid


> 
> 
> 3) page_maybe_dma_pinned()
> 
> Now, why do I dislike bringing up page_maybe_dma_pinned() [IOW, why is it not better]? Besides it ignoring FOLL_GET for 
> now, that might be fixed at some point.
> 
> I think we agree that order-0 pages are the problem, because we get guaranteed false positives with many mappings (not 
> just on speculative page pinnings). For these order-0 pages, it's perfectly reasonable to check page_maybe_dma_pinned() 
> *as long as* we know the number of mappings is very small.
> 
> I don't consider anon pages the issue here, we barely get 1024 mappings (not even with KSM), and it's much harder to 
> exploit because you cannot simply get new mappings via mmap(), only via fork().
> 
> In fact, we could optimize easily for order-0 anon pages if we'd need to: I have a patch lying around, it just wasn't 
> really worth it for now, because there is only a single relevant page_maybe_dma_pinned() call in vmscan that could benefit:
> 
> https://github.com/davidhildenbrand/linux/commit/0575860d064694d4e2f307b2c20a880a6a7b59ab
> 
> We cannot do the same for pagecache pages, so we would possibly introduce harm by carelessly checking 
> page_maybe_dma_pinned() on pages
> with many mappings.
> 
> 
> 4) folio_maybe_dma_longterm_pinned() ?
> 
> I thought yesterday if we'd want something like folio_maybe_dma_longterm_pinned() here. Essentially using what we 
> learned about long-term pinning of fs pages:
> 
> (1) ZONE_MOVABLE, MIGRATE_CMA -> "return false;"
> (2) If !anon, !hugetlb, !shmem -> "return false;"
> (3) "return folio_maybe_dma_pinned()"
> 
> Yes, above would easily create false-positives for short-term pinned pages (anon/hugetlb/shmem), but would never create 
> false-positives for any other page (shared library ...).
> 
> 
> We would use it in the following way:
> 
> bool skip_folio_in_isolation()
> {
>      /*
>           * Avoid skipping pages that are short-term pinned, the pin
>       * might go away any moment and we'll succeed to migrate.
>           *
>           * We get false positives for short-term pinned anon, shmem and
>           * hugetl pages for now, but such short-term pins are transient.
>           */
>      if (!folio_maybe_dma_longterm_pinned())
>          return false;
>          /*
>           * order-0 pages with many mappings can easily be confused
>           * for pinned pages and this could be exploited by
>           * malicious user-space to cause fragmentation. This is only
>           * an optimization, so if a page (especially shmem) is mapped
>           * many times, we'll rather try migrating it instead of
>           * accidentally skipping it all the time.
>           */
>      return folio_order(folio) != 0 || && total_mappings <= 32)
> }
> 
> Someone long-term pins an shmem page with many mappings? Too bad, we don't optimize for that and still try migrating it.
> 
> 
> BUT, I am still confused if we want to check here for "any additional references", which is what mapcount vs. refcount 
> is, or folio_maybe_dma_longterm_pinned().
> 
> Of course, we could similarly write a variant of skip_folio_in_isolation:
> 
> bool skip_folio_in_isolation()
> {
>      /*
>           * If a page is not pinned, try migrating it. Note that this
>           * does not consider any FOLL_GET used for DMA yet.
>           */
>      if (!folio_maybe_dma_pinned())
>          return false;
>          /*
>           * order-0 pages with many mappings can easily be confused
>           * for pinned pages and this could be exploited by
>           * malicious user-space to cause fragmentation. This is only
>           * an optimization, so if a page is mapped
>           * many times, we'll rather try migrating it instead of
>           * accidentally skipping it all the time.
>           */
>      return folio_order(folio) != 0 || && total_mappings <= 32)
> }
> 
> 
> As long as FOLL_GET is still used for DMA, the mapcount vs. pagecount checks might be better ... but it depends on if we 
> care about short-term or long-term pinned pages here.
> 
>>> Anyway, sure.
>>>
>>> A detail:
>>>
>>> The unsigned cast, I'm not sure that helps or solves anything, right?
>>> That is, other than bugs, is it possible to get refcount < mapcount?
> 
> BUG IMHO.
> 
>>>
>>> And if it's only due to bugs, then the casting, again, isn't likely to
>>> going to mitigate the fallout from whatever mess the bug caused.
>>
>> I wasn't thinking too hard about the cast.  If the caller has the folio
>> lock, I don't think it's possible for refcount < mapcount.  This caller
>> has a refcount, but doesn't hold the lock, so it is possible for them
>> to read mapcount first, then have both mapcount and refcount decremented
>> and see refcount < mapcount.
>>
>> I don't think it matters too much.  We don't hold the folio lock, so
>> it might transition from pinned to unpinned as much as a refcount might
>> be decremented or a mapcount incremented.  What's important is that a
>> hostile process can't prevent memory from being moved indefinitely.
>>
>> David, have I missed something else?
> 
> 
> What I learned from staring at the code in mm/ksm.c:write_protect_page() for too long a while ago is that:
> 
> (1) Mapping a page first increments the refcount, then the mapcount
> (2) Unmapping a page first decrements the mapcount, then the refcount
> 
> So the mapcount is supposed to be always larger than the refcount. Especially, if you take a snapshot of both (read 
> first the mapcount, then the mapcount).
> 
> A hostile process wouldn't be able to block compaction here forever, even if we accidentally would make the wrong call 
> once when deciding whether to isolate a page. It would work on the next attempt.
> 
> That's the difference to page_maybe_dma_pinned(), which can be made to consistently block compaction.
> 
> 
> [sorry for the lengthy mail]
> 

