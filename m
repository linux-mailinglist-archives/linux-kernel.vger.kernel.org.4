Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1085A6C1752
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjCTPM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjCTPMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:12:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FF631E25
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:07:16 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KDiNSb010391;
        Mon, 20 Mar 2023 15:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2byuyeBQIUN0PfFJFL6CZOp+smM8+sA2hrzmUqv6P0g=;
 b=RCU28FjqgqStLwbJFXnQ8dENYDUGd0RCbQKcXXri7Qp6Ak90rJnRn8o+LvzzvPlD0czo
 lX9QhHZItITdSIzg8aQO+Ni3AzCbxC+XdIX3Z3QUrMebT5B3OP8YE0OOYA7txmTHTf5y
 fAHsfqNaHlZLbbKUTpcgILilEnj3MDNXm51ju9cWx2XW2OmDQfaeO4cYbzhPgXOKm0Yv
 npndpulkSqnNkUMqSteAQVeC7/JU3YFBnDWuv3CLTOZsEPi34xIkXrbmzqdIIFxo0trh
 COMeeWafzMVdpyaDa0VKcDudLz4OomPUXaRIL4RfCB/OfQ61CmQZ6Fd3EwS7k+XH/A0E xA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd3qdkmup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 15:06:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32KDqbvr026460;
        Mon, 20 Mar 2023 15:06:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3r4duuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 15:06:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSqIUXOpmL3mmX/pLHRYiWWv1w+xhYRNggb4z8DlV+RB8aZogXhULRhDECY0allLtp5wFds8+ARY9QZrEl4PltFa1BbrPOnxrrSM/Fkur0iIdEh81Ju5/B8gRJieuw4Orp4oBhbA3btYq0RA1e5QjVkZW1uS+1HiY0aqzm0YIkb5s6yq9LCJtU+HHGTA+9eSOzNmOXpRAewVgkSuizH6Yl9WutKeQuoW8NlfmDs3IcoIhtCkGQwkSRz0P3hXpSame9NB0k2oWesOVDz/QofLOuqfNrkfHqxnqNQzUxSu1Nhk2Xk6kJyc1pnfxrv6nvZRxvCJcF2TsjyWjlqxDNkqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2byuyeBQIUN0PfFJFL6CZOp+smM8+sA2hrzmUqv6P0g=;
 b=SHMkoF5Mn4hOfp0tI+ixn699qOL3A267VW9xugch6mEOye15HLTbFfyp/Tn88syW3SkguzbY1/9JxPpXnuyb7413nII3dS0f61s28GzCIc7jp7UkU+9o0xWij0JWlOhHgKA5zf8s1m1dodr65yGwVpTzXjIbMsvaavXyrAFFoZS0i+2WPHH31/DwtWymrjqQujhkJ2Ah1nD+QgT0wSVaLXgi5owpvXRqBYQpoYQzRTEBYn0FhPhKPrE3++4cVutQ8myr/cK70KiGhoAY7aRdF1cWOLsp6A8Eo1QoVysr24BxzJneMQRUuphojczGv5SNrRtlEKb6kwhXrs045yG0zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2byuyeBQIUN0PfFJFL6CZOp+smM8+sA2hrzmUqv6P0g=;
 b=DSc1Apu05kadYMRRU9w80metmn5HNKjezhSUWfIrvGawhAL980EL0rI8jQZLV7QASfHPDN2yVTtDvHVa7AJN1q+70y8PQJTkPRRm4zw8HSRGvHTlX6a8MY1dvFYcADWxKaQ3q9OqPDEJPMoPS+j42zwERTtLWvW2wiv6KU2xUQ0=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH7PR10MB7107.namprd10.prod.outlook.com (2603:10b6:510:27a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 15:06:35 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 15:06:31 +0000
Message-ID: <12fa9836-4ddd-2961-7d32-4754506c84ae@oracle.com>
Date:   Mon, 20 Mar 2023 10:06:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v20 2/8] crash: add generic infrastructure for crash
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
References: <20230317212128.21424-1-eric.devolder@oracle.com>
 <20230317212128.21424-3-eric.devolder@oracle.com>
 <ZBgVjjZdiEA5YxQX@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <ZBgVjjZdiEA5YxQX@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0008.namprd18.prod.outlook.com
 (2603:10b6:806:f3::32) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH7PR10MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 28912a6e-2ffa-4aa6-0586-08db2954b002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yfSZtB56TlwIaObYL9xMVniNoUhgvkPP63QcjMcUlGfjGv6goiOy8AbP/6NcUYpAFy6PU7Fjy1il7jyJSwNU3M4ej3ao+nnsZbivqQGKTzvreWoWzG9UIFdmwdFM3jjxlvExsapYuUp3KfEyTWQTrK2SkUjctjB8mB3H/leuacKIQ3yDOuAIIzF8EJYcNEQEUyLBN9gF14TfLz1Q7d+/TIeshD/L+lbLSWgnKaaPi6IUqRXA7BPHHx4Q9KZue0Ee9hvJYaSAOaCywgRy+bsH8HYhUtgKjORUiSrKbGue6LJcdLY8av8xgKo3U0MSvxUobsYOWrZn+zf+a3JxZnoe874t6aoLpT7fKdtawGHcF+bXj8fgqI5IET7JZi7Xawhl+gOzVyctLs7AgZV0HHuzYXk5HSUPF/bOyFiLmfk/yNdPACYpsxtR95VEH5uddchSl4wCtq6S9tZ+LXYtoYbR33ExtL9K2epIVib3ijzxi018zg9fRUtxB+sBU2oXdgXMCOHKW6jSeQ5yEmWmoVvGhTV6rGzanqEIpTh1JRsYKk38tpI08IIoJU/cbPjtsg8wjUEVBZ46CYHqBw/6vPlgLOJwePGG9Pp+G2BhOQeHP1nCGdXXBgGxKYJjj0iFYpRCOC9kKC+h/Ono0IL+M2QZmuHH1ICd7/pcLWiP8IK8itGDX/aZvSzbOUxmpjZ3jogEj36jVzfcwO0nGD969vQmQ9pkBz1RhI8O7DecNtbaj1rcVWIJuoc3QM14O+AtlmM2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199018)(2906002)(38100700002)(2616005)(478600001)(316002)(31686004)(186003)(66556008)(66476007)(66946007)(6916009)(8676002)(6506007)(6512007)(36756003)(53546011)(83380400001)(86362001)(4326008)(31696002)(107886003)(7416002)(41300700001)(5660300002)(8936002)(6486002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTFGSEhLc2NHc1hHYm1sNE1hRFZ4djRSdWpxM09EOWQ4ZmlCekp6eFJFdGtw?=
 =?utf-8?B?N0g5Z3Q5R2VyOVNBK2pTb01qeE9welUwcHN5a25XTVVUZU9sWkg2c3l1S3Na?=
 =?utf-8?B?T2tzQktLRk1NREhHalVCUnZEVXF2S3c2cms3NXpYckZDUTFuYmRIS29YTW9s?=
 =?utf-8?B?RU5EQVBuN0xFMlNueEFUL3Z5WklxcmlTcTIxRmQ1K3lWNWhsOFRtZTJBUm00?=
 =?utf-8?B?RW51OUM0RGFmWGtzZnFyWW8zWWNmZFllbmtUM2NDQ1VUYkwxTnZSc1l4UHJi?=
 =?utf-8?B?OVpqK3NpWkxwa0JBSHM2a3VQODZuem5QcGVBYWVUbXRBanNuK1BBUDlyK1Ry?=
 =?utf-8?B?aUd6TGx0UERQQ2s5TlM0UUE4WWhCSk5qUUttUGtvTGxtcCtOdG12NFcrL1hW?=
 =?utf-8?B?all6K0pIeHNMTG9ZQ0RqYWhZdVJnSjQvQUlFOC9zcjB5Zmg3SDJkWkR5Y3Zo?=
 =?utf-8?B?Y1MzNWhMT0ZqVE0yU1JtTFA4U1pkeGI0cmc0cE1XcmFTbTZZMnVreW5IaE1C?=
 =?utf-8?B?VjBCaGI5QmlHdTdDOWFjR1l4RFBNckZmQ3c3TVB3ZC96bDA5VzlFQ2N2R0ZW?=
 =?utf-8?B?MkJVR1Mzd2ptL0xacFR4eWZZTEU1Y3ZiNzFkbW9jUFZ2ZnJ6UjBpdVQrYUFR?=
 =?utf-8?B?WllaZytGdXRWS1pvQTFTckQrTEhwNllZSzdUYi9QMkFld3NXK0VKdnYrKzZl?=
 =?utf-8?B?cmlmaGZGV3RRRmRyb29xWTFkblp3SHhsZHowcWsxV3BSbHNWYmRSbjBCK0pK?=
 =?utf-8?B?emlXaDlONUtzRTlNbElwQUMrQmJzUFpEWCsvRDJXc3lPUm1RYi9ZNTFiQ3dP?=
 =?utf-8?B?RWppMkNtb1ZIOUtiZE9zdnlVN0l0eHNyNWxQZUJ5SXJOOFJnVVFxNkZyTHNk?=
 =?utf-8?B?VlkzNWpYL1VxbmxGYk9rUW1KSGpYdkIwU2R3cFJ0M0Z0K2VkL05vS2hOOVBC?=
 =?utf-8?B?WFgybys4Y3VibkIxOHV1VVUwandVSFY2QzlHc0g5eTRMb25TUEQwYzM1TUU1?=
 =?utf-8?B?N1hZcDYvR1JZUm5LR0llbEZ4V1RNQlBYWittdWNxQzgvZFFPbDU5SHhMSDFu?=
 =?utf-8?B?ODIzdHFYWFppNWhmNVlaQkhOb3N2dWNZOWJTQk9IZE9xS05VNExaelVJeGlz?=
 =?utf-8?B?dStBajgyaUR5aDdQSU83OHBQaFFuNmRaVVJJNU5TWnFUODIrTjN5cTcvang4?=
 =?utf-8?B?a2wwUzFTVTJLQ1lvcGFVamtHRjJIYnUrOXZtcFoxSlNvQ2RlTk9pbXZiTTZO?=
 =?utf-8?B?YUJpY1NmblZadnpycXRzY0U1NHI4MTUrQ0JSd2dJRGV6LzFGeHl5MkE4Y21E?=
 =?utf-8?B?Tks4bHoyM25YaTE0SDV4M0ZiSERPNktSYWliMHRkWnh3dFEvQWV0Q3pLWkRO?=
 =?utf-8?B?amJDd0RVaFdaZ1M4NWFWYlA2UExoY0lwaGlOcGVuZnkyaG1oR2cySVk2bko1?=
 =?utf-8?B?c0NEeGxxcGt5YlF6bVdqVGMyWkI0aVViZld5RStSN1JSd05pZ1hPRjJONE5B?=
 =?utf-8?B?RUNqTWl3ak8zTlhEK0dLcG9uSmNicy9kUmZVWmhEWE9EcnI3eEt6U1NOZmRN?=
 =?utf-8?B?N2ljUDNsSnpLeUFDMFM4UlIrMU1MMW03VVBVLzlHOVVJUkhJMDVDd0cvajdt?=
 =?utf-8?B?Z3VlbDY3M1prSmZNSUwyUktobXRGdHdLZ2NvZ1pobTI1clpWOUFZODFqVnoy?=
 =?utf-8?B?MkJtbytRTVY0eXY0L2VsQ3laS0Q3aTJnczEvbkI0bTJ3UDF1UlozMjUzeWg0?=
 =?utf-8?B?K1NTSXMybkxMYUtmMzVyNVprTjZpTDB5cFR3UnBDUXEvWW40azcyOWQ2SXZF?=
 =?utf-8?B?Z3g0T0U4RlNib1Fyd2dwZW5Dc2wyV2VhZWhXaHpQZDBSWjdrUHVXMHZwbzNN?=
 =?utf-8?B?RVoxa2ZqQUl5Y2Q5SHp4NlRrTGhWaVB1S2NHa3cwbk9Pc1J3VHIyRDZrWW9X?=
 =?utf-8?B?aWZXcGgvV2ZBb28waFdSSmhMV2JPYXVPd2dHRjMvdFJZRHhNRWRMSEpEelYw?=
 =?utf-8?B?aENNNmovZ3lSbStaTklzMy9yaTF3RjhIRDF3WmVSdm5rY3cvU1A2Y0VEZGFa?=
 =?utf-8?B?eEJWcUlQdWRObHNLcVlibGRhaTcyK3lDRm5Zamo3dk83eUtmNmhKWC8rak1k?=
 =?utf-8?B?QzAxL2hWeFc5QWdha1FmM2lKckxRNFdIVFpLaFhaRjZCT1pjQ0l6Q2o1VWNU?=
 =?utf-8?Q?QVy5A7B9a7PMpfWcVmLSWCg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dXZJK3l3U0VzYW1jdUhyWlpicng0cFJmZnQ2amlab1d3NG5nSGJnbXpLL1lK?=
 =?utf-8?B?eTByNDNCY3JKTUV3SVFDbmFIU2JiZkltbk5uWjYxMVF4MWNCNVR0Q0l4Sm52?=
 =?utf-8?B?QjlZbVM4UTB4cm1URXp0alEwWDRtSllGeW5ZbHI5dDgwWWVyeGtkdE5LMG1t?=
 =?utf-8?B?MVdyNGNYOGE2UUJ6ZUlmVm1SNVM3VGNQd0JyMWRmTzdySEJOSnpST1ExMDlG?=
 =?utf-8?B?d1llNzF5Y3RDMmpqTE1mSmc5cjZTb3F2ZjBVanQyaW5idmNoaTM2MlhmbVR5?=
 =?utf-8?B?d3BkT1dvOU9YeHExeDBYYzFNb2FSZVgrL0pZaGxETGo4LzJHWnVjWEpNdzZU?=
 =?utf-8?B?QTE5SFhROUJia2RBOHNoVmJZOUNVMk1TeEV2elFUSDg5bWRrbDBjSng0dUR4?=
 =?utf-8?B?WWtJSkVDOUxSVnRHbVR4NmxYbkM3VFRsNURGeXN6dU93eXRWZEFQZTV3VFpw?=
 =?utf-8?B?WlJzckE3a2taTmxHcE5qZC9IWnpLbTFmdkxvdjB1R3llekJwbXppYi9BMndO?=
 =?utf-8?B?cGZJdmI2QVdvRlgyc2xRY216THZWNWRscDFHMUF6WWFGVEdzYWdCUWRoZUJh?=
 =?utf-8?B?MWY5WTFVME5MZVduYlJ6ZFlPbldFc3U5QUNXUmlJZUpoNkxnWFlnd2JDaXVa?=
 =?utf-8?B?cTZ4Q0RjaXk0RUo2M3FEc0VJbjhSUVNTZFJ1ZitUSjFNVll3bVZuZWREZUNa?=
 =?utf-8?B?YVJXcXpZOEdkd29Sd24wbzI3VTA0RGdCQVN3U3QzMU5YeXF4QmU0NEZnYjBs?=
 =?utf-8?B?WUFJZTJCWFBXbkVTT3REaEUrbjVEaEZEWXlGc0ZKVit1TlZrVHBvUWgxVmZW?=
 =?utf-8?B?TXowYVRBQUNWcVlDaUdMWXRNelJuenBiZEpFWGlXVFkzMXcxV294aUhqSUNy?=
 =?utf-8?B?YjRuUEc5TEhnd3c5TnFZRUdZbHZ2Z2lRMFIxS1FoQ1FtbmdIME42S0N1Q3F5?=
 =?utf-8?B?eHBrOWw0QkUvbEJicEZBOFd5ZXdxWVU4b0hmelBxbEVsSWg0VE41cURSRllB?=
 =?utf-8?B?RXZpSkcyZDdSUG1MRjB5T1BrOXdZUVBSbzBsLzFtcWV3RyttVkRhREk4VWov?=
 =?utf-8?B?Qm9BUW1CNjRkUjExQXNZQXpoRVRPSVI0YU84K0NyYS96SHpCNnZacG1obGw5?=
 =?utf-8?B?d1Z2Q3ZsWUtINDZBYTBDd25odE83eVVIYm1ZWTZTdDhSVGRNbWF4MlZzOGxD?=
 =?utf-8?B?WjkydC9weDJkV3daZWxIa0NBclNhSjhqQzFIbTlTTklKMytQR0pZSkVHcnhj?=
 =?utf-8?B?SjZSMVpXTmRnZTNObnJXUkJpMi9jSTN5Mi9RM1RjZ1BiQVZuZmUzTnpLckcz?=
 =?utf-8?B?TzhIamZKTk00dnRJNVM0S2ZTN050M2ZlcXU1Sjd4TkFiT3NqSTVRanFxWjYw?=
 =?utf-8?B?Q3B6eTVRVlRPd3lXTXpuSFdkcEZBVi9PYU8weXF5ZFJFbXA0ejJSeG9jS0E5?=
 =?utf-8?B?MXV6M3prejk1cW1VOHl4WUVldTBNVDJvQ1FoZGxjOWtJQ3VEL2tDZjd0Q2kz?=
 =?utf-8?B?azZ4bnFmV3FjM1NQdFl6NXVlSVVIbWpXL0FJeUpnVkRrZHJ2YW53MFZ6QVYw?=
 =?utf-8?Q?IN2iyXG2NgFPobGzgyKTvNYfk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28912a6e-2ffa-4aa6-0586-08db2954b002
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 15:06:31.3094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhIUK/GoNFFMLsDs8U4OxqxUqGq1cPRTMspec6NpK9+U+Cg065Oc0IBgYO3DK0DRaznCgjiJST2Fpjd/LhOjzsWX7izKy+ji8betEWg1Ivo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7107
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_10,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200128
X-Proofpoint-GUID: BEnBDTAIHqaTn-6xssLDrUJb8R8dm5US
X-Proofpoint-ORIG-GUID: BEnBDTAIHqaTn-6xssLDrUJb8R8dm5US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/20/23 03:13, Baoquan He wrote:
> On 03/17/23 at 05:21pm, Eric DeVolder wrote:
> ......
>> @@ -697,3 +700,137 @@ static int __init crash_save_vmcoreinfo_init(void)
>>   }
>>   
>>   subsys_initcall(crash_save_vmcoreinfo_init);
>> +
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +#undef pr_fmt
>> +#define pr_fmt(fmt) "crash hp: " fmt
>> +/*
>> + * To accurately reflect hot un/plug changes of cpu and memory resources
>> + * (including onling and offlining of those resources), the elfcorehdr
>> + * (which is passed to the crash kernel via the elfcorehdr= parameter)
>> + * must be updated with the new list of CPUs and memories.
>> + *
>> + * In order to make changes to elfcorehdr, two conditions are needed:
>> + * First, the segment containing the elfcorehdr must be large enough
>> + * to permit a growing number of resources; the elfcorehdr memory size
>> + * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
>> + * Second, purgatory must explicitly exclude the elfcorehdr from the
>> + * list of segments it checks (since the elfcorehdr changes and thus
>> + * would require an update to purgatory itself to update the digest).
>> + */
>> +static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>> +{
>> +	/* Obtain lock while changing crash information */
>> +	if (!kexec_trylock())
>> +		return;
>> +
>> +	/* Check kdump is loaded */
>> +	if (kexec_crash_image) {
> 
> Here, what I mean is:
> 
> 	/* Obtain lock while changing crash information */
> 	if (!kexec_trylock())
> 		return;
> 
> 	/*If kdump is not loaded*/
> 	if (!kexec_crash_image)
> 		goto out;	
> 
> Then we reduce one tab of indentation for the following code block, e.g
> the for loop block will have smaller pressure on breaking the 80 chars
> limitation.
> 

Ah, yes, ok. I'll make that change. Do you prefer I post that soon, or give this v20 some more time?
eric

>> +		struct kimage *image = kexec_crash_image;
>> +
>> +		if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>> +			hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
>> +			pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
>> +		else
>> +			pr_debug("hp_action %u\n", hp_action);
>> +
>> +		/*
>> +		 * When the struct kimage is allocated, the elfcorehdr_index
>> +		 * is set to -1. Find the segment containing the elfcorehdr,
>> +		 * if not already found. This works for both the kexec_load
>> +		 * and kexec_file_load paths.
>> +		 */
>> +		if (image->elfcorehdr_index < 0) {
>> +			unsigned long mem;
>> +			unsigned char *ptr;
>> +			unsigned int n;
>> +
>> +			for (n = 0; n < image->nr_segments; n++) {
>> +				mem = image->segment[n].mem;
>> +				ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
>> +				if (ptr) {
>> +					/* The segment containing elfcorehdr */
>> +					if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
>> +						image->elfcorehdr_index = (int)n;
>> +					kunmap_local(ptr);
>> +				}
>> +			}
>> +		}
>> +
>> +		if (image->elfcorehdr_index < 0) {
>> +			pr_err("unable to locate elfcorehdr segment");
>> +			goto out;
>> +		}
>> +
>> +		/* Needed in order for the segments to be updated */
>> +		arch_kexec_unprotect_crashkres();
>> +
>> +		/* Differentiate between normal load and hotplug update */
>> +		image->hp_action = hp_action;
>> +
>> +		/* Now invoke arch-specific update handler */
>> +		arch_crash_handle_hotplug_event(image);
>> +
>> +		/* No longer handling a hotplug event */
>> +		image->hp_action = KEXEC_CRASH_HP_NONE;
>> +		image->elfcorehdr_updated = true;
>> +
>> +		/* Change back to read-only */
>> +		arch_kexec_protect_crashkres();
>> +	}
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
