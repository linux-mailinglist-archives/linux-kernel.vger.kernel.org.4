Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B65C6630BA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbjAITpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237339AbjAITop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:44:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262757CDCD
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:44:18 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309JfQEu018835;
        Mon, 9 Jan 2023 19:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=uW1xdrK03J+7dublP83aQGfxKGgRGvD9Q+PQ6PGQ6+M=;
 b=tp73gFhcpk4/AnKzKCb2uXNnwKJB0BPISPc3gNwSquyuzRFphhYqJtnEtz8d9MsNJuEc
 JlFtEKFtD3uwNurg/KnbtE4NcvF3PMxE0Gz9pzy2zKbEqMLeA6lWjWnC2chf59yO9WPB
 dwKygkHOSkdK1ydrwRAWos4NKkbpnlDIoK75T1f+7+b+Jd1xCr3nSY98B1GatjEfY8ug
 YL4aBFNtNqHdSII8C85KNs17fKwH4xAvBN2A9zK/9ZolOJnYbe2XlVvBiwL1K8QaW3rJ
 y0zx1otndRBz/MD0MZgEX8jQMCQSH3/hEAim6PAhGeSBS/NRjBlk0vl4ledUZJlANwbs 9Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n0r47r72h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 19:43:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 309IFxZB004399;
        Mon, 9 Jan 2023 19:43:48 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy6afe8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 19:43:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvGSIYUWX0lQXR91QWZoxhjrLdCPykeRafKrxtl5OIy7SRGMciNkZ8pjlBxfAcl59Oc7QcdrLXENPMCpl4t4foy6jPMOujNePWFf8/zfXTgbvIrPJdF+Whdn/KpQsbbbRFBBqphco9r+gQEk9Xgzqh4Vm9bTKPS3MdMbyGjus6Rh83uozcSq6Ncp3rmAYz5LSmb1iosO6fxSCwJoCmd90/NGNZV6red7BUNoA0qECTnB7K5KtK9H1TGQ2hLuuq1uLYccmSgv7pUuySkmjDS+6cJwVw94rX5gsQ3xO4ft+LTXVS/cmUm+yR9IQCe3VedCocb3304cyYn/OTK198RU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uW1xdrK03J+7dublP83aQGfxKGgRGvD9Q+PQ6PGQ6+M=;
 b=bok9kStP+nmlBDGnJ6GZ3DZ0HnbafXGxf7KoRrYNTopbKa30mmHKIX7uvqPphOTWrXVSQpqRRFk0eiOH/zmYk1ZCfO3RmFZ1a5/od8VajZIRtusUTObhBLM+ayWG0eeDNNO4L1jpJnko7zZ3h6lmGXNCeroYpwa4mSVafLZyt1pXD08Djq97MuDkEUqUsG6rqoYm25UyYn6dCj38emVIyGriOLYMgSneLG2pL1nlR9PiD9TLNRaExs7e7phFXY1X9LJkrwkVD17HOEnGT8SYRe+23W3LelybIGxmoRgNyOHJpbwlnHann13narOIsXpBfeYDzn59OKRV4PUpqvhY9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW1xdrK03J+7dublP83aQGfxKGgRGvD9Q+PQ6PGQ6+M=;
 b=qhJXIZq04VHGZUzreyL01FKaXL/ZTxx4wXWLFsvem9jrKzIg1RezcVMLPd0DoQf54h2E37pPacdq98+VtaDvmvQt0c36hUEzuY8AyHQFQLFpmMvbRTDO0HjQwgxKqJkX/s6yGapkTbJVmQgaZq4RUkSbRxLPVc4gZP6MLF/syRA=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM8PR10MB5397.namprd10.prod.outlook.com (2603:10b6:8:39::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Mon, 9 Jan
 2023 19:43:46 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%4]) with mapi id 15.20.6002.011; Mon, 9 Jan 2023
 19:43:46 +0000
Message-ID: <bc4ade74-dcbc-88f6-2d88-2bd4c2be38ba@oracle.com>
Date:   Mon, 9 Jan 2023 13:43:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v16 7/7] x86/crash: add x86 crash hotplug support
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
References: <20230105151709.1845-1-eric.devolder@oracle.com>
 <20230105151709.1845-8-eric.devolder@oracle.com> <Y7vD6bm9xy9uyvRD@fedora>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Y7vD6bm9xy9uyvRD@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::24)
 To CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DM8PR10MB5397:EE_
X-MS-Office365-Filtering-Correlation-Id: 160d3282-528c-495c-bfaa-08daf279d229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: plW+RKS5iTry+5MCF0tdiV/um3T3qzqd5+0Ox/DQiR1gOoH+HBMR4nB+jLKCCE7pul08hLjYyQTgqM2B/dfoPSMOwxECKlPb7aV6nz2RXxfcOWRrY2pUj5+c5ACRS/DNIt5trPVQcwJsBComX44UlQKA/auhjpdBsvHymX0HPNQ4b3sKv+Z6y5aqlUK7GHWoAR9J1YGVW4bCD86UMzalXJ4bQGFAjPghzl2gm/QhMDlob1222HjzOk++q6Cos3t1LFKD0FrVvpfy+D7SA/AiW08W5cpwVvrwCGKmYZIVoCG7znHrOxaJCVNmFHlTK6eK0lJCF0cETlft/3KxVx2gWOl/g2edK0gUaEZudRq970HNSwSB6qYiaH5vra7khW0h3XK4R2e5uYnu6kvKokJm3HPOAnGuqLd+lN1OzTBIrodd1I/2zQl3VhPwHXa3bUHGkrrswI3byVWSQnMu+dLYZmJyb5HaYTgg7uhcwgt4c46LSGsPu07Ftw2Cu+gMvD8fIyh+C7/ViWfMKbJLqk98hoDNmsqx/+HY97ujVzocXlgjPrrXnWrtXCh4tSF1ofmKAsnLFS7C2SYEVHaINNLdE0dnkArb0gWI6AbL/kbDN3RjiXMf5Thw4vo+4PJbWtCAVN4+9U9YAyHcfAkGGOOrnsQqn8dOcvHl/F/BlY614ac06UsXET71tKsZPZYql4+ZPrHX0KK0Bo67zjiow9AtISGtMY+CQ8svlZpxq5xGJnw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199015)(36756003)(31686004)(86362001)(8676002)(66946007)(66556008)(8936002)(4326008)(2906002)(66476007)(6916009)(5660300002)(7416002)(38100700002)(31696002)(83380400001)(478600001)(316002)(6486002)(41300700001)(53546011)(2616005)(6512007)(186003)(6506007)(6666004)(107886003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHNscFAxRGY2dDgwbDFJUHdpM2xtZ09xelNXT0dTNXNLNzhuUXJGZkI2TDJw?=
 =?utf-8?B?bzJBdGs1UGZJcTRWOFJnY3I0QUNaR01xWXBReHJtWTh0ZkYvaGdyVWtaWjNj?=
 =?utf-8?B?NnpvdlM0VE1ZUEZRWmR4azVyUGorUnV3Y2YxNElabC9QdzFWM21QeW4zNG1K?=
 =?utf-8?B?dGdDaTB3Z3FTbW8wN21rbGJNZGVMbkdDcC85d1lldzV4ZWFIcWc1QVJqTXZU?=
 =?utf-8?B?SHgrSFVtV1paWkUrMys1K0RhNnMwZTlsVTFlRW0vMTJ0K0VDemh2Yi9DQk1D?=
 =?utf-8?B?ZVBHWTlIWENLMWdXOTJqam4wWnNGK0pERm9pSStpSit0NlpVWmk3MXlJSmww?=
 =?utf-8?B?bmhOOWdBY24yS2RJVldqdUE3YUZyQ3BwRjVtZ05TZzk2OWgzMk12VElySlBF?=
 =?utf-8?B?bEMxTktnOGsyK3VBR1FqK2svdVAvaUl6cytoMnBLSXFHZnlBQ3VmeW5KajlM?=
 =?utf-8?B?UTZ3Rys1RmJsb0svcXlObmMzdHdaMi9sb2RhNzMzajlyNW5nTXQxRVY0eWpM?=
 =?utf-8?B?dzA2V2NUVWdhQSt2UVg1TGtMeXNPbGx6UE5PYTZGTE82N0l6VzNUVnI1MnZV?=
 =?utf-8?B?NUJxTktqNm5STVJFVk56VnNlNTZrYjhWL3hQOVVPYS91ZzlDWVRjNFFqWnI2?=
 =?utf-8?B?ZW8vVnBleGF5UUhyNThkdis2UHpkS3FCMXBFSmpDMU5OZDk5OTByOEtOU2ly?=
 =?utf-8?B?ZEJFK2RjNURJQWxTZ2E1Zlh3ckxKVXJ1MDNDenFKRWFJY3ZPVUVVeTFOcUNJ?=
 =?utf-8?B?bkkwNEFpWVRySFlKMzV0VGZMd1gzWW5UNHUyaXBxRXdUUWlObmdEaTB2VmNH?=
 =?utf-8?B?Wlh3UDR5OXFOSVlFa0xhS3VvTktiTXJiTzNpK3phU0JpbGZweFM2bGp4eC9G?=
 =?utf-8?B?dkdFa3FyeVA3VzU3QVdjNFE2Nndwbm9mUmgwUTBVbm1VaVJESm5TajFmeE5B?=
 =?utf-8?B?TXBWVmlVd0x3T0Ztcnp1RWhjN0FNNVo5dDV4cHRoWlZzR3BDQ1JMMXB1YVpM?=
 =?utf-8?B?dlkxRTV6TU8xWE1zall3WmZ1Q1NpVWhYWFhGQmIyOStDVU5EUUFUSUVLa0ZZ?=
 =?utf-8?B?QmVJelBOOGEwc0JjQXhQSm9Rd0JDcFg3bWdGQjFVTFVneGExOHl5RkJXaHZl?=
 =?utf-8?B?aUZqVnV1RDhSUGs3NktIMkhSNW9DMElNcWFKdE5XRHN4bjhmbEpzc012YXBL?=
 =?utf-8?B?VzVESWRnNTZsYklvNHZFeVVwMDhiVjNRVzRsTEd5UTVTTW5LdkZzM2pyb01D?=
 =?utf-8?B?SGEvQTV5NHd1bGt3cWNmdHhCTG1vd0d1d0lGemZKbkdyUW5peDhTbk5EN2VB?=
 =?utf-8?B?dk1UNnUxYk5MTGRLV2FraU1VazJvRm05VHdvQlVTOXBPY1piWlA1Q084Nytw?=
 =?utf-8?B?SmtwQnl3anpqaFNuRVByL2xIK1F0ZHdZTTQyc0dvVTlORXhqZnJXR1ZqZHBn?=
 =?utf-8?B?aG54SzZZKzluU0xjWmdmQkt6bUs2Vks1V2craTFQR0wzTEkrbnF0b1NITjRK?=
 =?utf-8?B?K2RSWFBYMm5LckE0Rjhaa0xaQktxdkpRUVV5YlZsMitmdU9Kem5yT2RWUy9G?=
 =?utf-8?B?eE04ZTRRazN5UGIvSVY5MzNSNDBnNFV2aTlEZStJaW1XVGFzbkVTclJmQkR6?=
 =?utf-8?B?dWRkUitpVTFGaWsrWmorSjUxVTFKMXpvcTl4Q3hlQ2Ezd00xajJFSUlUaHl3?=
 =?utf-8?B?V3lseW94UjM5ZndEekZFSHo3bEE5UlpxaFQzQ3pkL0NWUFB1aTRtbUlqRWs2?=
 =?utf-8?B?Q1RrNjJBN0plZzNoeDh0bkNud0hhRy82MU9NV3AxaXZZY29SaWFjV2RmejZL?=
 =?utf-8?B?ZE5CTWRMdy9aU3RSbHZURDdOM2tRZ0RMT0lkVGorVUpDZU9BUUt4cU5vb0xJ?=
 =?utf-8?B?d3dUVkVyZzBJdTI3emswSTVERkZWMmFOcXpBUkxWSHBSY1lrbkVhUndyUnR3?=
 =?utf-8?B?ZEVReENteU95UFhSY3JsbmpvK1dOZEJLdXZoL3hCSHlqYmlJWlZUeFFrMUoz?=
 =?utf-8?B?TWpxbEIveTllRERpV254b01SWlFJSWUvWE5sWGREYzFhcVRyaGU2UFhCdzV2?=
 =?utf-8?B?U3BkQkduOTYzQWp4dG00cHE1Wnl3dEd2SG9JcXU1Wk5tQXpNeXYwcDVZWVlp?=
 =?utf-8?B?d25tbDNzaUl6RC9JbXczemNmZDhPS2NCWnFlQW5rdTBSam1tWG1nWFhGNDc3?=
 =?utf-8?Q?Z7bwXcxXa+D9HXuLpaqlFqk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UTJSRHM1Q0FwOHhNckkzSGd1aWxsMVFnSjBESy9lWkF6Q0dSQXhjL0hUSU5U?=
 =?utf-8?B?M0x6ZUdIOG5vVmxLL1hHQVh4Y1hrenJ1UmFCa1I4aGd5c2g4ZCthdG1Ybzh0?=
 =?utf-8?B?WDU0TVdRTGYzT2pBb0hYMU1pb2Q3NEh1Mm1rTUZ1Ky9uM0Q2eTdJUlhQWEx4?=
 =?utf-8?B?V2VaMmcwM2orcmxyTnJBa0I2ZWFJTVkrVXpLZ3l4N1NjTFEwTkJHQW42clAr?=
 =?utf-8?B?a0hnL1g5L3JxaXAvTEl2SnlSdW9HcEJicXhWbjFPQlkxTHVoTXdrMHVmWkNm?=
 =?utf-8?B?R096bHVIMGtyaG9nenNRbnN4NlI1MG8wenlXQlFObk5ESlRiTExJM3pwSFN4?=
 =?utf-8?B?d3U4ckdNKytDZzVJb00yMTl0YXllUVFIUCtnUUxnTm9rZjJjOVRlR0xGNExS?=
 =?utf-8?B?cUcxeGZMVU1GNDJYVG5FQVI4K3pKbExPVytjQmZTd3h3eHBxcUpCZ0Qwa2JY?=
 =?utf-8?B?QlNRVzBoblZMT1pKUkFTWHRhY0FLOEZLQ3BQbE1teWhnWkl4Mkk3c0N5eEkz?=
 =?utf-8?B?bmtkZTNhS3FIYmxsUGRYYkxPejdKamQ1dUFKWnV4VHFxeStsYW9uUno1dHMz?=
 =?utf-8?B?bFFXZTNzUTVBOVF5YW5XeGR0STFQN0FoM3JwRWJIcE9uR0YxLzdKS21lY2lL?=
 =?utf-8?B?Y0Znbm5ZMXFuU29TWWgyMDhXbGNscGp4WTRiK2gwYStCemJCeVlFYjRsZmhZ?=
 =?utf-8?B?VHdUeGFILzk3K01vbU1QY2trZFAxTFFxczkxeWR1UGVsdzltYWZvd0RHaGNS?=
 =?utf-8?B?YlNuZk5mTzdKZVBqbkI5U1JGY2JkRDJncm4zZWN3cjhHbS8xUGJMZDdUWEJp?=
 =?utf-8?B?V1VHNzVxQ0tsa2RCb1NWd2FuL3E2VmJvOU5sOUFxR1hNMXhndGo0dHFJNi95?=
 =?utf-8?B?bkV4RDAwcm1YTG93cEd0UWZBUkhrUkhsUU8zYlovdXExQitGR3NVZHk0ekhO?=
 =?utf-8?B?K0xoNGVIVW1KalhqaEV3dmtHVDh0YVU0NEc1bmN2bndrMTdOSk8rZU0xYk5q?=
 =?utf-8?B?UWQrWWYvQ0NGbHFJVjllR21nZ2lOWTMvNXl2cHkxT1IxQmlOTU9rODlCeEov?=
 =?utf-8?B?RW43MGZkc21zRXM0NG85MTY1Yy81Y1YwbkxROXdSd3VFbDAzc1M3N1RkNjBB?=
 =?utf-8?B?M002NzVseC9TSUhhaUhEZlFiRzZoT2h5L1NEOEFYMldUbUVVbThOZ3dIL0VZ?=
 =?utf-8?B?VkVmZ0twVHE2ajJMQ1B5bWY3MTJpSTc0YlNGVG9MZEU0VHhidTBRU1RoMG9S?=
 =?utf-8?B?bGtCNmZUak50WTZCdFpCZDZ6eUZxbldidmQ1ZXV5T3RYR0RCSlJIcnYyWmdN?=
 =?utf-8?B?WGUyOEFjN2poMFl1ajJFOEZ1Y0NxbnBvV0hqSzViWVZ1eDBRVjh2OTg4c2RM?=
 =?utf-8?B?OGNXS011SzVhU3FpQ2ZlSmRzTmh2bzNJci9hK0puRm5RMFFSTjJjWktUbEUy?=
 =?utf-8?B?Y2xOQTJEMG5GVE9VNVl2cWExTlZua2R6eXppYUhWWTNtVVdmNUJ1eExydHQw?=
 =?utf-8?B?WTFsaU1kNXI5b1VrODNEM2JGTWtHbDNjTHlBV3ZsdmpvRjIxQ3A4RE8ydEZK?=
 =?utf-8?Q?g1UNYLCkMWgxVoJYOhlIbBRDg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160d3282-528c-495c-bfaa-08daf279d229
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 19:43:45.9761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcJ0dpGavEaKszLI1jpsDSOmPL7+OZKmTulZ02nIKoqKLFPE0FDdMswhTpRWFFUCrFwaIejTfgSL6z29VdvHb88z3hyGXthpwBD49Wa/KQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5397
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_13,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090140
X-Proofpoint-GUID: XklVL9FYvLS0w7tEL5m0kSttgRKcSwty
X-Proofpoint-ORIG-GUID: XklVL9FYvLS0w7tEL5m0kSttgRKcSwty
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/23 01:36, Baoquan He wrote:
> On 01/05/23 at 10:17am, Eric DeVolder wrote:
> ......
>> @@ -394,10 +409,37 @@ int crash_load_segments(struct kimage *image)
>>   	if (ret)
>>   		return ret;
>>   
>> -	image->elf_headers = kbuf.buffer;
>> -	image->elf_headers_sz = kbuf.bufsz;
>> +	image->elf_headers	= kbuf.buffer;
>> +	image->elf_headers_sz	= kbuf.bufsz;
>> +	kbuf.memsz		= kbuf.bufsz;
>> +
>> +	if (IS_ENABLED(CONFIG_CRASH_HOTPLUG)) {
>> +		/*
>> +		 * Ensure the elfcorehdr segment large enough for hotplug changes.
>> +		 * Start with VMCOREINFO and kernel_map.
>> +		 */
>> +		unsigned long pnum = 2;
>> +
>> +		if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
>> +			pnum += CONFIG_NR_CPUS_DEFAULT;
>> +
>> +		if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>> +			pnum += CRASH_MAX_MEMORY_RANGES;
> 
> Logic of pnum calculating is a little confusing to me. If I only enable
> one of CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG, is it OK? Say I
> only enable CONFIG_HOTPLUG_CPU and CONFIG_SMP, on x86_64,
> CONFIG_NR_CPUS_DEFAULT will be 64. pnum will be 64, is it OK. Am I miss
> anything?

Ah, your understanding is correct, and the issue you point out I need to fix.
Specifically is only one of HOTPLUG_CPU or MEMORY_HOTPLUG is set, then I need
to allow a default for the other. Using the example you have above, there would
not be room for a single memory region, so I need to allow for a default number
of memory regions.

Good find!
eric

> 
>> +
>> +		if (pnum < (unsigned long)PN_XNUM) {
>> +			kbuf.memsz = pnum * sizeof(Elf64_Phdr);
>> +			kbuf.memsz += sizeof(Elf64_Ehdr);
>> +
>> +			image->elfcorehdr_index = image->nr_segments;
>> +			image->elfcorehdr_index_valid = true;
>> +
>> +			/* Mark as usable to crash kernel, else crash kernel fails on boot */
>> +			image->elf_headers_sz = kbuf.memsz;
>> +		} else {
>> +			pr_err("number of Phdrs %lu exceeds max\n", pnum);
>> +		}
>> +	}
>>   
>> -	kbuf.memsz = kbuf.bufsz;
>>   	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>>   	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>   	ret = kexec_add_buffer(&kbuf);
>> @@ -412,3 +454,67 @@ int crash_load_segments(struct kimage *image)
>>   	return ret;
>>   }
>>   #endif /* CONFIG_KEXEC_FILE */
> 
