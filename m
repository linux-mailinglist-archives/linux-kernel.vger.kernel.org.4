Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8456C4BED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjCVNgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjCVNgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:36:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBD51C7C2;
        Wed, 22 Mar 2023 06:36:31 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MCYmGo026975;
        Wed, 22 Mar 2023 13:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=9E0zdOHg2tr1Sh9PsCfXYhtON+Vp+DmVL7MwW6y0nSk=;
 b=1/daZxL8kVghMA4ZLyuNqLb2/YYl5fgL5kDr0EmqKS0ROlYe9jrQT4Nk4lLbfKKZuuEv
 oqeqOk7C+WiniOoCTRrMN8OTLxYNgNJC1U8inCBs1Ut/KkRf/X2dUweoka6FFGyV0jPA
 7ueKeI7LN4sNyCjCrqs2G0jXQoKUO/F+T4kFlizt585U7BRVeaUWlF+0l8WLAeCFFnQ3
 aQzIHRLWkm2fR+EbIH4RqMriDCGsIaxH2xwwu8NqOkSDm83pxa1Tv5wP88EmLmUW4JGj
 P1aBYZZKt7E2Udb2xdWJR3XZu5T3P4Hkmh7663l/0X+Lwdp3wq0CffDBPpEuFKaa8/MZ AQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd3wgh37c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 13:36:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32MD4FsD038171;
        Wed, 22 Mar 2023 13:36:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pg28291be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 13:36:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYJDbUjSBDTTdNBspbEijEUOpno1l1eWLd7nego2NqhUb+H54/8NkSF/xZhs8hJNNCsm1awB7Z9iJuL9KUmVoJLk/0xvkZXO0pFVYWRKvXirbEo08Kxyqwft8FG5gIPH49+6ftp2FS/weZSNGA9nPj6kreUZ9dcGC0rB8MtJ2IQ1H2e/5nuuqPjBCz9X18VsRRv1rmJkqnT3YY7NvpO47QxSqe9zZimIRynMJV3QFqGh9kJrplWic3LBmX3tExURn8dEBZpG12htthCJBJuycl4p2S5DLpnWVqQfN3SSF4ezkbIRnylsV6fb5cbPorvNWrRlu69tsfhoGhnV9kBzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9E0zdOHg2tr1Sh9PsCfXYhtON+Vp+DmVL7MwW6y0nSk=;
 b=lA6dBzX7CYIMu3sQtnBRQyGg836l1m5CN+bG7HYf2IF/3GnwClRL/aqew7SoVvKmNtH988vHKL1fpWHOLOT23mu2ptV4+eWxYpMzBtNupxhH2ZqGYFC4yc15VSzHth3LUyOmOnVqVeDw4u9Wb1pU1y4a++wtICQaPzn99saG9L3ezqfGpqTk6BphguyDpB8wnZnmd8HlE2zHXdFXmbI6+S0wh7O9v5AQZihsnj7pQEMCsPacQ5eZq5ff3At/fN0qVtM2CUz2f0i9gGGo++1lspaG56+VHWGm9QuZH0ipfjKuN97WSbLBOkUi9p4gy0Y1MpQoa9o/31ruuOF6/JWO1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9E0zdOHg2tr1Sh9PsCfXYhtON+Vp+DmVL7MwW6y0nSk=;
 b=sRdKTUy87d63zskbWHdUPLFijscZ6dd3fZcY5GXDl9KBhcv/tC6x44Iwa53GisXsLGCNh9nZIHMzrLg/uazE2IUCCDMQmKrfXJFzdErsKKwpOKykoQCRv4jbnKQfDSAEoJfyQB/rC0emcaaDQSo7+jL0pnOjhtDydNs+7MCM18w=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7017.namprd10.prod.outlook.com (2603:10b6:8:14a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 13:36:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%5]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 13:36:21 +0000
Message-ID: <0e7b4269-a96d-db71-b0a6-5e61af731fc2@oracle.com>
Date:   Wed, 22 Mar 2023 13:36:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH RESEND v2 09/11] scsi: scsi_debug: Drop
 sdebug_dev_info.num_in_q
From:   John Garry <john.g.garry@oracle.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com, linux-scsi@vger.kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com
References: <202303201334.18b30edc-oliver.sang@intel.com>
 <92a2d9c4-cc7a-6a26-07ea-b49ecdc920cc@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <92a2d9c4-cc7a-6a26-07ea-b49ecdc920cc@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0092.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f465ed-5670-4f49-0a86-08db2ada6c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZf5VGj4cFMKnd9qmmcKiMyBL49hpi/4+kSuAQFBf7deKX1VQ27hvuwCFtyuqrUXPEgpl+PeMKYqfkcBq3wOf1epNM0Y5HNLFgmh6pBeIN57s4DGwcR5FnCjGRIAnFuy3ZoZfkHO4woEiiCDv+iaa9NIKZSY8g1IJ/wppTdtN57gIXEGyrLiwHrxm2yht2L6uiiVLgtGcYt90XuMyXkpYY0JGHJDEQB2lLjSN+YxdBpIflAL3jKTKfZR+7TY50JNVhjHvY/BRWcNNwRUbEgwrnwJORHjVdZ8jR+dE7Z90XKj0nnD75qfaUqHG/CGWdN6ZTJfuhFcR18YhTPqa5m0neIAVJsVNK6QFzRqkyEIwmzy61nsnpw/qKaB+MNY0EFzyS0T5ItOzpANNhJg9uoyYbQDuVUVBzH9N6XNH5oqitYtiN8Pa0VX+WultZWWpXY96diRT31z+rxMhhbO0nQ1uCKH38FFvLWKYAAwP8T0ik+UA5/1bZ/m8iUDzpNTIbhdkmN0q1QlxHj0Y/4AkkuZY5xe8hph4x13AZgkWqtlC167QNsgA9tG/A08wlpVlXcCGdtGoHYznZaPNbJqajZ5bGorVy6rf3HKzb+6asePrnEZpQ9HtASteFvlb+W8HSc6oUsNHDmS4PLyBrtWcAtMYy/QxWYgmebYDw3m5ifeLlVkUQLu2hQRSOeXe1ZMrh5z1thMNCvOQ4DrlcYIU5uknHR3dtjagr56tgJixUR53pI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199018)(316002)(478600001)(86362001)(2616005)(26005)(38100700002)(41300700001)(36756003)(31696002)(186003)(8676002)(5660300002)(6916009)(4326008)(8936002)(2906002)(66476007)(66946007)(66556008)(6506007)(6666004)(6512007)(6486002)(4744005)(53546011)(31686004)(36916002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUV6eEFZcXQvaEhHeWwrUGkyUEh4UWJNeFFaM1J1Z0I0U0JEMm1yQXlZWmg3?=
 =?utf-8?B?bm1iSVZvVmcybVcwUWNNNUEvRWxyRHBkTk9BelA0TFBQMTZmdHRJcndNdTVD?=
 =?utf-8?B?ek51elBjclhFUjlwMUEyYlFMNThvQ0FGNXJyN3VBMzVRRkJhVlhiSGpxbTNu?=
 =?utf-8?B?dkFUT2NuS3dxblZvb3JIWk5leEoxNGEzT3ZRUFJ5bXl0eThadU9VSFp0UTJq?=
 =?utf-8?B?d3h6Q1p4TnlQMUFkMjFQcjJ1YTloTlp4V05udktXUW5ocnltYWhaNlhFbm0r?=
 =?utf-8?B?L1U4R0RYZWQrcXNLU3BHNmw5cUtFU01GNSthakQxRXA4QkQwdkx1ZzRiN2pT?=
 =?utf-8?B?U1RPaG9WTjY2NlAzbElxWTRVM3RBMmhKU2NGaXY1QnJXU3FEa1pJTDEzS2dO?=
 =?utf-8?B?ZytodFg5N2xSNzBqZjN4MU1qSHYzd2RleHdLZElldngxSEVkVFNuQUhxMU9t?=
 =?utf-8?B?UzdpQTN6NzVjak8vS0Y3L0Vrazh4T1E5NS9PN3dyTlZjcmg1U3NMSlA1ZThZ?=
 =?utf-8?B?OEg0cGNnVjZpcXV5Tk1FRGFIZ1lhcXlDZFlrMTV4Y3M4Z2NWd3FuYVNNRDNz?=
 =?utf-8?B?eW5qcFdwMzVoU2RsUHp0aExlYzFXZHdLWTZhWHRhN0t5OUpWbXJRT1JFZEhO?=
 =?utf-8?B?K05nM3c4VUJ5b1l6eDFkUG02ZkN5a1JZUnliU3RrWkQzUXNTYmticFZFNlpy?=
 =?utf-8?B?Rmp0QXZteW00cEw2a0h6SWpqWXZhNWdhVEwrdUdFSjkrTXZMMWE1dEsvMld5?=
 =?utf-8?B?OWNLUzFIMVNBZ0Fla2NsT045aTdrcEd3UHJBa21rbmVUU1dBRW9STjRPd2I0?=
 =?utf-8?B?VVEvcUFhWDhWeWJNaG5TOGtPSjUycTRmYjRGajlqVVN3RWhTM2IzYWw4SFlz?=
 =?utf-8?B?TzUraERzbWRtWFVPaVoxWUU3dE81T0FsTlBWRnVpMktjc0YyRmE1eEVkcGlJ?=
 =?utf-8?B?emRXNFp0RU5YdmRBODRNdWc1cjNJY25kOWY1VThPQjU0ekRYWnBXYis1NXBE?=
 =?utf-8?B?eWZ5dzJRc3ZkZkVEem1nOGZheE9oZnRlbXI5NlhVUHFHK1hDTEVPNS94SkQr?=
 =?utf-8?B?d3V6bkYvc2pIQ2hId0dMVk9UZXpwYnNJMEtMdUtUd1pIQ29XOGtDUFZKWnFE?=
 =?utf-8?B?UTNmYzg1VGp3bWVIMHlNbzRTTEVRcTNtaFJ3UlFHUlQ4U1NZUXAwM3F4NkV1?=
 =?utf-8?B?Y0NjNHBzOXBwS3J4MEJrOHh1ZWVEN0VYeUI1aU8rN1hzQzZqZzhXVnFiUVBN?=
 =?utf-8?B?aVAzTEIzOXlqazJnT0tjRStQeFBVaDc5MnUwOWwzZ0p3L2MvUXRMLzF5NEtH?=
 =?utf-8?B?bytxQmlVTmNoajFrQjlpNXgrYWhrUkVvWlZ4VFQ4eDBPV1l6aG1nenYyNW5K?=
 =?utf-8?B?N3VLNXlCM3VqU1d5Nlc5QjV2K3l4Z1h0SHZ5ZGpsb05WM2EydUFLemZ6RGpx?=
 =?utf-8?B?TjY0RGt4SVp6YStENWxOcThud2JBSHFLNTNyWk1LTGNLZnpyNkRJRGEyQmRX?=
 =?utf-8?B?dnVYV05FSFpjOVQwKy83SUNEZllBOVNNRktNcW4vRUhYZFZINnpWWjVnZ2t2?=
 =?utf-8?B?NlBIblIweEUzUHAvWmlKMHZtRnMrcCs4VjVmbVRDak9ySUhmODM1TDNUY0Qy?=
 =?utf-8?B?QnFzMTVZeHJjenYxT21hRENwVndVNm5hQSt2VUlpNEFtV3dyOFE5d1BLUlhw?=
 =?utf-8?B?bDM1T3A4SlBGSTJ1VVZKTTdKY3hMZWRRRUcySXkzNFpkNTkyOXErY0tYMU8x?=
 =?utf-8?B?aDF5TWoyL2NPRGdPR1VMYWlTaU80dHlUYldOWTYyTmg4MFB5VWx5YkJvcGQ2?=
 =?utf-8?B?cDMza2VzbGVJZGhzN1NRWTBoR1ZXSEdUOXhUSFprZjJDUytabFEvYlpsOU1Q?=
 =?utf-8?B?VDJUZjBnREs4eWo0NTlCN1R1NmYwMWdkdGp4OU1nRlk3U3p3UjFncEkvQklu?=
 =?utf-8?B?aWVtVXM4c2M3N1FlaUYxZm9zMktVbXp5emxLU0VmUHZpUmZackJ5aEx4Zk1Y?=
 =?utf-8?B?S0ZkZEVWd1F2T202MDhJbG9mcnRqeUlDSFZuUlJ1Q0FKcmZPand4aElCS0FI?=
 =?utf-8?B?TUZZVlJmUGZMWkZoeXQ4ZC9EYjhCT3R2RWlKWUFPMjVwWndXTHgrK3lLMFh3?=
 =?utf-8?B?aFVmelRCTGdIcmdHKzF5K0tpb3QxekwwdnF5ZUFrMitlU3hOUGN5aC9LcFQ3?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9AC5OwckjxiRp2E5GIFXNes2s+5NKnQZI5y5DolwN5GTdw2FauU+22UqRGcN7ajUqLVRbJvd9xTb3iFLSrkBxYhIXD37/SEmLhz2dbWZT2+51lR2NuYytmeIFNM/Rb3RV46C6jdFKGuDY1GC+eEin1MqBptGe2PzKVaC4+vK+Yi+ycPaeVHKNKoCOd9xF7PRq4KwZBICEJ4w8Zur5WxnNrW9CLmInZDdLW7aMUSOsEYdet8sUWp8ksKDWLXnJpF/TP+KUipf0FU9Uk/Hl1JhjH5Lo41a2m4StZsgiF42sFo9/bjBMenzx8F2BgmC6e+6p5TkdiOlLMO0KbOKt/QGwo563Kttq7JWMFtrtxyFiWDNYFGMHlRAtNez4jvbbuaJawK12RKtBV7CoS3jVzhGrhnLeRsbgP17W8CwEQ8KqQI0xwOxQz63pKYwtpMVcsMRjJqmFERpLj0TecmH+1AXjEvuUaxr/9KmpTKDX+83NngZWlkCYjW/AxtutAIaiIiy+b9PvJrZEcxqUZLnk6mV6ZLv0HwKbxwlj0yvwMqi63OGyreKaY5vXBlucnA8bUHmCaOM0b0oonKEdp4s+mci176bGtAg1OvbMFdEzyigbLgnOEchwmlQQ0LGJ0UEqD9tuWRjjmfJIlThLYm0lIqPHgzXg3iJb/O/DZ92wqgQqMIJhKG7n8IblTI2qvaqIIgTOzlF+E09ypBuYcvCgIfyr6FOCDF34OUtgv2Q2AtIlcqTtqfBiNQJuswj7zVRXRsbII+wEOU1kBOAgHfm2gC8qiHaNXHfb6QwnggeYyuZvk4MJxhATQ/2HIEVaaZQmBKagJWAG6Hq4e3ny1KmGOJpAtvFD2UxK1hX7TKP/gu9wngNnh1maFgg+9akGIHYBh++wkb9dUCausrBwqaz93mXB2sRqNzj9fCDrS62QitB7vg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f465ed-5670-4f49-0a86-08db2ada6c7e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 13:36:21.6524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8Wy4CUL5juRzA/bE6E+AHzL8CdvGHj1jkZKEcSQQyBlLKWOnlOdvx05ULmIDMs7jc1HPRdJ52qsxacyBkD5fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7017
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_11,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220099
X-Proofpoint-ORIG-GUID: uJlvYNPj4iS99dOyZPH-eBMWzcUO-mm4
X-Proofpoint-GUID: uJlvYNPj4iS99dOyZPH-eBMWzcUO-mm4
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2023 11:41, John Garry wrote:
>> scsi/004 (ensure repeated TASK SET FULL results in EIO on timing out 
>> command) [failed]
>>      runtime    ...  1.467s
>>      --- tests/scsi/004.out    2023-02-28 16:52:49.000000000 +0000
>>      +++ /lkp/benchmarks/blktests/results/nodev/scsi/004.out.bad    
>> 2023-03-18 00:19:00.232079954 +0000
>>      @@ -1,3 +1,2 @@
>>       Running scsi/004
>>      -Input/output error
>>       Test complete
>>
> 
> I'll check this now.

This should fix it:

--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5580,7 +5580,7 @@ static int schedule_resp(struct scsi_cmnd *cmnd, 
struct sdebug_dev_info *devip,
                 int num_in_q = scsi_device_busy(sdp);
                 int qdepth = cmnd->device->queue_depth;

-               if ((num_in_q == (qdepth - 1)) &&
+               if ((num_in_q == qdepth) &&
                     (atomic_inc_return(&sdebug_a_tsf) >=


I'll send that change in my other scsi_debug series after I test further.


