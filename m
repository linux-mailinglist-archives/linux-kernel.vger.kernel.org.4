Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E90712B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242133AbjEZQ4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjEZQ4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:56:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BB7E46;
        Fri, 26 May 2023 09:56:42 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QGnLeY003621;
        Fri, 26 May 2023 16:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=aXuMYrWF91rTJe5p10wC8Ct92fMASZnEmQ/Gqo1EPwc=;
 b=DAurNxthkf/Eilq1WGl5Fjq0pt271TIot8lVFkiaD2eSPDjUNItA6SAWxrQ+0nExQ497
 VppuD+yIxIQa2ugonKCn8CKVEPDnEkyeZL8y2xDql3pJ29eoJ7e3WfvQeoExHehOxbU6
 FV++HCU/NPZnVMVDl1bKGY/997qSz2/dE003MENcUBJX8QtyHo8McC/Qb5VIE+HFFUil
 ON+SJcT/QOCGXo5E3AwjxWDiRM5upUQYg6BV33bv0gcXANq+9yMngEx52YCRT8RJZXTZ
 CRQLZexQ5uECt/TNsgL0BMRHFsesGjaPRrzzRPzqRNpb/poBadAX6VfI6/FAH7J+xZkS 2g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qu0mgg0ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 May 2023 16:56:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34QG3o2B027326;
        Fri, 26 May 2023 16:56:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2hwfee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 May 2023 16:56:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBHxa+h9XTmtXnr/OQHv+mvymbqSNzOMlNvQRTDbWGUqKqpUzdPH0iXvDJZQrnk46L9Xws7wEPyeXf7q7f0zK69hRs28llYro4LhxwAS+wE+cvPwn2d4mUo1SR7y812XzXNOP81p9Py4KmOTmSTHRBXvlKybaPi1LF899jOa3A568/1DfMrzqHgpkEbK0UZC89SGy8/TTgO6cDVPnTICQf0FeRFZv5fmaZ8wgbrn0B9r3iIb/KB71vS0KmrlmxczpsZovm+SuXwDnqDdHPvlIeA3s9NY4cuav3iYcBNcvuse+AzEmuxX65WT05clnI9gfDJkqkut711BAr9MFuxG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXuMYrWF91rTJe5p10wC8Ct92fMASZnEmQ/Gqo1EPwc=;
 b=lO2vinpOExKZFoqLia857wXEz1IwuHUlLYf9LghoYq+DsldYMg9Se7/7sZ+tHjHTLf//WAZvKOX+V1N6XN4BuoWwElbakIoOVtNZNTTK2LvrWLKdqtMJMLIqRLY9KcVy6y4pbjBJ+Cg4WNvB4JgH01D04epshQa3BYuk8pR8bIP8QTGQUf2BJsKY+36x2VlZcfGEqUWoZT2j5eH5AOh3WTsX4DslTHeN7gJmqdg/kfbrniLA95bXfn3UDVHU8DEakmy+h+V9TTf4CliIdxoqCOKIQF4xJ2qme3n+wgXvQHf/23+Xaytq8q5WFyHa8cydqlmwOm0QCtcKBoI8WwXg7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXuMYrWF91rTJe5p10wC8Ct92fMASZnEmQ/Gqo1EPwc=;
 b=ew9HePSL3b8g1Ko2ItoLgqq90BYSwlkAXHHT3anXRtjyzFl4icbSdWkZ9ia4gS+/1gLQIXSJKjiSuL6/fMtI99J4PmOBpiGpGl88B4Rn4n3qJph8IuOJhQB99dhO5Xy8iH1wDYnGUDcfm3iERkvoqbvxhGrzuNCWlamoOFgVrWM=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by DS0PR10MB7521.namprd10.prod.outlook.com (2603:10b6:8:157::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Fri, 26 May
 2023 16:56:25 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4a9d:b42c:57c7:b53c]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4a9d:b42c:57c7:b53c%5]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 16:56:25 +0000
Message-ID: <58172674-2e0e-1bbd-aff1-881c2096c5bb@oracle.com>
Date:   Fri, 26 May 2023 09:56:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH V4 2/2] blktrace: allow access trace file in lockdown mode
Content-Language: en-US
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-block@vger.kernel.org,
        nathanl@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        konrad.wilk@oracle.com, joe.jin@oracle.com
References: <20230420215331.88326-1-junxiao.bi@oracle.com>
 <20230420215331.88326-2-junxiao.bi@oracle.com>
 <05b3eebd-7a3f-13d5-1fe9-8f4ab3080521@oracle.com>
 <30ab7555-8f36-cfb7-9101-0ebb92af3c2f@kernel.dk>
 <6300a33a-9d3d-42a2-d332-81e02d52d310@oracle.com>
 <CAHC9VhT2uCc5ePi+ung+rLaDiLCCCF=fjq8G+D3FJf0i4E8_hQ@mail.gmail.com>
 <f016d747-c01a-c46e-59a7-13d0d6306827@oracle.com>
 <CAHC9VhSCjuJZ122EqdDxzJTU1tGq5nU_3+11WGKZ-WHjzU2FBw@mail.gmail.com>
 <afeb0ced-e4e9-6039-893e-b50268c1c148@oracle.com>
In-Reply-To: <afeb0ced-e4e9-6039-893e-b50268c1c148@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0373.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::18) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|DS0PR10MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: c535ee98-6a49-4999-be2e-08db5e0a2421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xD1oc7foocGO8FAYrv8O0hmt6UlSSpf9SZIi/NSKCkam2Kem86PTCrBYxir4WpJ4D+e8tnxZVdw/IOFerLcmMonVBNVIpfYO/YfUWt3Pn9Kd6evVh8rxyUD+oU5+Kv2LNLwsELmxcPCzPUgwAsCQft757hWK+YmhZyeXt7lx9ek7vJ3MeJdwxrFwg0qJjUNLDeGP8mPM8umOvHQnHsYKTCyKLnf5+NtMPLgnovfbQchpZ9wHpzg7IVxEO2MqN7X9RCpV1oIErzUbaQvC92BCoQLFZNDKq2g+ExFp4gbhcVHCN+xipPp4ZDNPQzAOWv/Uu7Q4J8uDRjC/fHTxgXRhCkqCjnhzHmIbk4tCFdL0HAMez1yh2MuDvm3lO0wet8SDGhy4AAHvS4+mgQAnzwOB1xZ6ZZltfad5k4/dDUFQiWaBZ9qxZkQuCispdGM8r5WBTCwIrdpmsb6B+YC/Op0rDDmOaFkc3IuBJo0sTokyHP7xFUat39LENRHccnMPe87hEpHytETdKZGU9F8Leh2lfm3x/1NaMip5IuwGg6nvizR0AIuLXnqnmxWS2ZCDb0piXhz70gcqXPAZM9al+4p7FOTypQEb7eC6WxJ+1EWKYa43QF92GcLLRpvXQHUvwc7cet89R6Ct5k/jvW5F/7NRZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(366004)(136003)(346002)(84040400005)(451199021)(31686004)(8936002)(8676002)(66556008)(66946007)(2906002)(6916009)(316002)(4326008)(66476007)(478600001)(44832011)(5660300002)(41300700001)(6486002)(6666004)(26005)(36756003)(107886003)(53546011)(6512007)(2616005)(186003)(83380400001)(6506007)(86362001)(38100700002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXhWNkpPRXZJY1JiR1oxQjRrb2NkSWhEK2lSMk1GczVPV3BHVnlEVEJkUkd3?=
 =?utf-8?B?Qk5tM0JvS0hoTU9kb2hISFpha0w3Zzh5c3JKdFN5c0d3NWdKUkZ1Tk9oclVH?=
 =?utf-8?B?cUwyam94Zk9wVGZhSHNGdlNqbzdhSWdFVWhGMS9wWDAyeVJUUW1DdkgxODNL?=
 =?utf-8?B?Y0dEdkE5N0cwcDJLaTJydDh6SG1PRStDOUxsL2RsbEVFTEtXWFBUVVBXd1NP?=
 =?utf-8?B?ekVobnFIa0tXNldLaHU3eEN0cHVXby85K3dnZXFCNkhrR2FSNm93aVBTNVh0?=
 =?utf-8?B?S1JGNm9FZlJMejhGbmdpenJWNys0aG95UVhZd1h3OFRYYUNJTVg2VUhSTS8r?=
 =?utf-8?B?U0hyOUVWLzBQZ0txY1V2MER4U21heWUrVzBWUk1PcDVUT2xxYnBuUUdVS0tT?=
 =?utf-8?B?SFdYdEFRb04yWU1Ga2ZLb1ZyUDFSaURUZFNabkJWdzh3d2g4aGx0bWVZYzIz?=
 =?utf-8?B?bE4ybmthZmtMRU0xSU0vamZYUi9RY0tKNlZDb1lmRlB6NWNyVjNTVDdoMjQx?=
 =?utf-8?B?WTJRNnVmVmk5ZDc1TlFnNzhWa0oyQm94VHRlMnJFNzh4NkhsK1hlZlpzQlJq?=
 =?utf-8?B?cEw5WXo1Y3BXd0F1NWlyTUJzV2RmTU1BZUEzTXVtekxva2taRkJIUTNmODVm?=
 =?utf-8?B?eE81eFJaNkhYbldqSDliSHJwY1hSM3l1c3lkUDlMUHdSTTQxR2tuc3haRm9l?=
 =?utf-8?B?U29SUDBuOWVWK0J3cG9qZkl2Qm80elc1V2pVT0Zxd2lKeW96cWhySjIwcGJl?=
 =?utf-8?B?RjFYL2hEdjc5bFdxQUgwa3VaT1hhY2pKdmtGYnZjZlJCMkQ5ZU41NGtFS0Fo?=
 =?utf-8?B?ZGRlYUt5Z1EwVWw2ellPUGZ1RURtR0xhc2gwV0NSaG5UWFJvNjkvRk1SQ0NP?=
 =?utf-8?B?b3grZzdrM0NXUEtRV3RBTXlDZjNQa01NVHBjVGxzdHp2UlU4a0FWRnk4aGw1?=
 =?utf-8?B?L0VwdjVuVStqQjJiRU5hc2VKT2dQeHY5NWV0VjFSZGtURTNrR09SVm5Eajdw?=
 =?utf-8?B?WHQxODIwa1BtRVI3YzErelp5Qk1xeERXQjI5VVVReXRzNThpcTZ4RGlCN0hS?=
 =?utf-8?B?aFhpQWpGazlyM2YwNGE2eUFQaENRTUFYY1hKV2Iwc2RoK21jYzM1REtNOWdv?=
 =?utf-8?B?TTUrQzBqMFNFQzBDTGI4cXhEOTNzdGZoY3dqdzkvUnk0ZGRTM01ranRnLzk3?=
 =?utf-8?B?a2JjVURPYmhNV0JUNmNSN3JZcDIrRnVkZVNneXo2ck94YmVoQytiZlZOTUtM?=
 =?utf-8?B?QUVabzljbUl4cEtQZWpmbThuL0IydDMyZ0s4MlhpcWYyaFl2b0taUlhwU3RG?=
 =?utf-8?B?NFN5cFpiQ3AzRnJLSmJKZkk1dkViVkhYUERHN2RXaG1uOXVxbGtMSTJ2UkNq?=
 =?utf-8?B?WDJvODVLNWNsTk4wRnhKQXVjQ01iVzBlUitJdXBYM2NXOG9sT0Zjdm9wbmx4?=
 =?utf-8?B?bVBuYTZZK0RwWi95eGQwZkdWSlJrV0lWY1RXWVBTRFRKdVVwWjFUSlBrMkFq?=
 =?utf-8?B?YTFlZnQreFQ0MDNhdjVtOTlUakhROGM1d3N3TlVDZklSTkNiTXFMWEhDMUFJ?=
 =?utf-8?B?K0llRzlLOVZmN1lLSExFTk8wSDVjb3p4aXhtSUE2UHpVQVowMTFBMnZ5SzI4?=
 =?utf-8?B?WXA3bmE0dCt0VzVuOGwrZXcydEZCOW91TUluSWNGblJMaktRWmE4WnE5SHdp?=
 =?utf-8?B?MzIvZURQWVJhYW5CeFB2LzVPcHMyZVZPaEdXR2s1TkFYeVhJcFczMVBTNFhw?=
 =?utf-8?B?bWo1MGQyUTFqb2hzUGxNeWw4SWJ6N2VDaWlJeVM2bHhwN2w3V2RtTzBuUXBh?=
 =?utf-8?B?a0lSYXBmdDJ5cFMyemRrNVh3OERIVUorck9RNkdOK2lJQy9TZHArYWMzRlVN?=
 =?utf-8?B?LzJ3bW4ydEhoUmlEN29SZ1FMMEwrQXJwZ0MzWDFsbmpydkNPbmQxY1pabnJN?=
 =?utf-8?B?WEhLYXVCRGIxYjhoMmR0aUhjZ0hIZEJ0ZnJhcmdxNjNMOU5FQXc2SjZ3U0FS?=
 =?utf-8?B?TG55OWRtSS80M2drMnczM0Z3aWtJRmpGUHM5ZmZEdWlaQ05scnF0a1NNdGVZ?=
 =?utf-8?B?QkxIODNkTGlDQ2tyMGdsK2V2eWszSStYSFhaNDR1Uk9ueUJUdHczR2N1Uk0y?=
 =?utf-8?Q?FyiVQlflNDGRVdw41AbFCJs80?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jB3P8NRyPVcxJfb7E9S8fWDniJFvpUh9+zWmap/fdldfD5SXMzrZFNd6jD4CJ7VgPLGcTeUx7ay99yt1dffe+3n0ysa4UuYYJ4jHX7vE0jfwsUi+llIXEK3q97Gq1CRpxYPiDrV/IqIHXEv02Y5pY9UfcOM0s3weH5Q5KpoA4wLphVt8umYXPCsXtNTQ4/WsYN5qViefD4Ekoej59uAjmAkkF0wjBE/T1g2lggtGYeR+ChokzHvDTRzLpg2Ht2RlLnCZinkzg/AFmqGOITcVMEmtT7iKL2f6m91RgDdeDGlYq5uXv87oJE9PSzmCaCSeBqln8e3sqQeC+Scten4tM3TTMTsRBT8F6ibij7kTETEub/l52GJLHwSYQDNiRX1AIqmTZSTkfNkzLsHbNAb4ISZJzBVnrpLPJPHWoS2Yrr67Sv8g547MTf3e4Mr0cEGz985e3syGh2D6JkjEJl5+KkbrYpvNZEWsCFKpl07A2sJHLrDWxbUeeuQ7AuDhPB0qMXgGFXTZXeiD6DvYhXXCRowVhSKm3NbTUwMR/I+usgrQ++kPGjCQLZ3114SfW4PpHUvPpFVIRdga+ZzuLVP41+wvB47CfLTztDCqzdq9jdguxnlp34Z4+We1vhzgNuIB0GLMIXGtOSib1ApfIADsbdqFVoC9TNKIc9Ay0ZbQpp238qnE63w8VqKcdYeEJZpWaigMZZoQplUY2JGb2ERFsB+w/uxBbbQgk6Yq1xqejUVHUh7ygAeABv7igAGeWwwajdLmy6w52zcWw3p8YgNQ/l72kg2mNa+ZekN5RkDJRdu7m8KZ89oGkKs1+ASTvXkkzVhf4qGAYlC37dvlIaqhpQC87xyjb+5uGYWrcr7mw7L/wuhG9onw/artFCEdhCRyeqfMFi7VvXeyA5icCWps45QT32fvjRpea9EM0Qk5Cuo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c535ee98-6a49-4999-be2e-08db5e0a2421
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 16:56:25.4736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1cZvkebfsFXRmMxmYrRhvCe9i1Tpk/91CYHZ4V4ilZKY4tdZRB2LpfzMVSk0YBcLx/2898lZ9Dluc/FSGfmFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7521
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_06,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305260143
X-Proofpoint-ORIG-GUID: Vq5LeogDvOzyOodleQj8S5i_xxXN_oGQ
X-Proofpoint-GUID: Vq5LeogDvOzyOodleQj8S5i_xxXN_oGQ
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

The patches have not been merged yet, i would like to resend them, just 
want to confirm i can add your Reviewed-by in the patches, right?

Thanks,

Junxiao.

On 5/9/23 9:13 AM, Junxiao Bi wrote:
> On 4/30/23 2:46 PM, Paul Moore wrote:
>
>> On Fri, Apr 28, 2023 at 6:41 PM Junxiao Bi <junxiao.bi@oracle.com> 
>> wrote:
>>> On 4/28/23 2:26 PM, Paul Moore wrote:
>>>> On Wed, Apr 26, 2023 at 12:33 PM Junxiao Bi <junxiao.bi@oracle.com> 
>>>> wrote:
>>>>> Paul,  do you have any other concerns regarding blktrace? As Jens
>>>>> mentioned, blktrace just exported IO metadata to Userspace, those 
>>>>> were
>>>>> not security sensitive information.
>>>> I think this version of the patchset is much better, thanks for your
>>>> patience.  I don't have any further concerns, and since the lockdown
>>>> LSM doesn't have a dedicated maintainer I think you should be all set
>>>> from my perspective.
>>> Thanks a lot for the review.
>>>
>>>> Since there are no changes under security/, I'm assuming this will go
>>>> in via the tracing tree?
>>> Should I notify some specific maintainer or mail list for merging?
>> When in doubt, the scripts/get_maintainer.pl tool in the kernel
>> sources can be helpful.
>>
>> The results for the debugfs and relay files are fairly generic, but if
>> you look at the results for the blktrace.c file you get a more
>> reasonable list of maintainers and mailing lists.  I believe Jens has
>> already commented on your patches at least once, I don't recall if the
>> others have or not.  I see you've already CC'd the block mailing list,
>> so that might be enough.
>>
>> Keep in mind that we are in the middle of a merge window so it is very
>> possible this patch might not be merged in a working/next/etc. branch
>> until after the merge window closes (every maintainer is a little bit
>> different in this regard).
>
> I didn't see the patches in the trace tree yet, maybe better to merge 
> it through block tree since it's a blktrace fix.
>
> Jens, can you help merge these two patches to your tree?
>
> Thanks,
>
> Junxiao.
>
>>
