Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4F06D9C57
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbjDFPaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjDFPao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:30:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858C5E61
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:30:43 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336Ei4TH015765;
        Thu, 6 Apr 2023 15:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=H+19+kSVGvgiJNpRwl1wOoFFHyc2RxGqpgefdf+tr2A=;
 b=G5BKTc/o/pOBN1ZmvBfkb9WZWEdpseqdLUWsscuZUrQNWxXuqidq5eU+CtlJ1wPRUDFE
 56ZxQFu2hZA2F8wzT2oOKEQIPTIPYcBz1LbNQxULowUAFSnoUVBG4Gk/t4BFd2Y4QCPO
 nlzpl21wdR1uusgXWj9tJV6I6bVV+IuXk9eiRbk9iEKmxmeMCbWD48hAHgh1ZUqftqsU
 rRDOD/Jkj4U5lKTH4T9d8eZj1OTtJgqe/PqTWe2ypRdKSM9DsmqcpeB9pGpiEsS0LbY9
 D6rom/jmvRC2Ls49JVY87Dcb0QYWa85+H99vF9BYWKVONX36xa5EYvu35ESmLd569UAA Hw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppbd4385f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 15:30:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336FEJpG018360;
        Thu, 6 Apr 2023 15:30:33 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt29n084-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 15:30:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGfLFA4yP5aoSYk70mny5ErdQa0ip6Un1Vu2cWHaJh5bW9pxM9k+wg1mQ/2qBZ4Ww09LLdlaJs3lGksYZaIQa9u4dheZdCxTch6w7CFkvxeKcUr2ggRyn/UwdOzOJIcwo0VHZeLS7KM7qbTn3GYShOUAKqx45J1hKzQA75/bRG03DApBtUl2NLTJ24du6MT0i99A5+rGwQgFfCNqMhiac3Sjn2fi5gVRAkzYSrV2G7w6Uc1Vt4/iRnT5W1O8eQLv3CR8ve5+lNX5y8thb0/fXFbZfukDDPyxzGNl6UdDirLiHRCNdv60n1IRugtOzdjdfwnowe8ud42SQT7BhXnEIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+19+kSVGvgiJNpRwl1wOoFFHyc2RxGqpgefdf+tr2A=;
 b=EM1Jl8czo5AuIALT1wbeJI2/DKTA/a96fs3nl1zlZY8ajlpSm9odfKO5L9Ow8uqZgl+IoXHN2tfEJLkY90YD+fMZTCxwMNPOK4fUtQR1swIMu8bIYAUbxx+M3f0WyB/cW6JWcuhasGpk3sfr739Xb+79iwDTfHBW78SlMNYenaEXw24R+7mGYaBxMB86Qwe5yl1p+9j0VxslA0KMDo8nepEBD8N+ebnsgYa67XDfcdpRPzdz7heeNLcoWtEa/rlqqUc26DtXta4sK48zSe4WR82OsW2DWAYFSHbiq6ltEoQ8ndXfgUTm5xSSLB4HxByiVz0Ap0CVQRAFXpf/ZtoIGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+19+kSVGvgiJNpRwl1wOoFFHyc2RxGqpgefdf+tr2A=;
 b=hVwsJcCAdjJg7KYs9m0oJYH4Ie7TUuKSK1VgWbyLL/boYiRgrQYxlfOPeP1tMzpaHK1gn+JhE/ZU7p+3QnbyWRSPw8nGtA2kWz0aG9fZSD56zEpQ5vVwPm2Uqd/JI9XD6ZLoa5EfBpjDGEyeHKaGBlLUhuvqQEi9O+klC6PB6uk=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by DM6PR10MB4252.namprd10.prod.outlook.com (2603:10b6:5:215::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 15:30:18 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::ab8d:2bb:c060:7d73]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::ab8d:2bb:c060:7d73%5]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 15:30:18 +0000
Message-ID: <f063cfc8-805e-4d73-4c62-ff1bac4b1ed3@oracle.com>
Date:   Thu, 6 Apr 2023 11:30:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] sched/numa: Fix divide by zero for
 sysctl_numa_balancing_scan_size.
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        peterz@infradead.org, vincent.guittot@linaro.org
References: <20230404182915.2264557-1-chris.hyser@oracle.com>
 <ZC5tNK50QouEvX7Q@chenyu5-mobl1>
From:   chris hyser <chris.hyser@oracle.com>
In-Reply-To: <ZC5tNK50QouEvX7Q@chenyu5-mobl1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:610:52::22) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|DM6PR10MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: aad2e1da-bdec-4837-a7a7-08db36b3d3af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KIWYI6VaVsOv0yRZJTDCTJLpLo8vfHG6GEQt26j/jdGIhNTrNiOQMOe/37RZv7qJKUDRn/2YW2gbN3mogcW3n1RMYz2F7GaL1dFYMX54nHz3ayy6c66rsnsYSt9lSng7kig7tyfzNIZ+prwbcet6Wo4k6q7dmG9+x8Uysbj7QnWc7b0mLgHc+9riXWHgQrfRJnG9sGYEgPh4oBWO5r6MPG1YYVYlbbhFEsA4sY1T24LTMXTHEyzhssAywEc+v9Kz/1l1b/IUYlrto5lT2NGROerYxfJk+xBqBiZsE7JADYj54iCzZTBEzN5mRuQUl6tHNiJ0zelKE2GNwxAqJlGgpYvHeIyM8N8G2Q+oPl9dQS9W25AsNZQRryjSh+UqFAn78KuUfEaA3RulpLkCasXXz2KrnRFQxKPt4q3RBfFSkar9f/xmuQjQrx/93H0N29luaP3pRr1uNLxOtCrGNYoUcC+Sg49ec/xfBQZFCXZ86PEOZvWFNIBlOTlDVfw3U00v1Jx5cmrbe6ZWY31bLLh7yH6Wy5b7YwNEraKjS1nVl5zZGeEWiHkfqc0Z/e6FhpcghgLiSMOREzycLsk5B7DL2yWODuAzyAhvuOndIqcQSeS53yEMWY9AmgToNPYW2Tebw2B2B+sQBAQnVJdpmUHXFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(66476007)(66946007)(8676002)(478600001)(41300700001)(66556008)(4326008)(316002)(8936002)(38100700002)(4744005)(6916009)(5660300002)(53546011)(2616005)(6666004)(186003)(6486002)(6506007)(26005)(6512007)(31696002)(86362001)(36756003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzRsaCtRYm83WjdWdlJpMzk5eW00OGtQWnl5VmloNDU3UXVxamROeDRMSXRH?=
 =?utf-8?B?RmwzUTAzN3dHQURqbkREdUdNcmxvbU5SeXc1ZlVXWWFYOVRlcU5hcnRsVE9J?=
 =?utf-8?B?QlI0UURNcGx4VURnMFpXdmN4NHpqNTlTQjhVUVFRbUJRVU5rNXp3SFQyM1Ji?=
 =?utf-8?B?SGpSMzVZTmlvWDQvYTZRVzd5RHZVc1B4UWhTb05jc3ZpWEx5R1AzWlJvTnFM?=
 =?utf-8?B?cmxRZUZmZE8rTGdRQjI2Qlp1L0JtTTNmdlJXOTZGTkRRaml4YW5sak85T3dv?=
 =?utf-8?B?bFlrQ3VnRWZqcnYvUlVTL0FnK1pBakp6VjQyTEtWL0ZqS2dvSUdXUTltS1Bl?=
 =?utf-8?B?VW83NE5XcjBMaHh6d2FzYUpSRk95eDlXSEF0b05hNTQzM3NvUkRQNUgwOUc3?=
 =?utf-8?B?UTdXYml5ZzI2Q29mdWY1UVFULzhFd0NjVTBZaitmNDZvTnFXbUhNV1B5c3Zr?=
 =?utf-8?B?VVNlR2drVUl1bkZKSXgwU0hNSEpYOGE5QnVXeGZDK1pYaGxLLzNHQmorOGNz?=
 =?utf-8?B?UzFwcGJtNENWUkZvV29QRlJmL0pJelBuT2s1N2FxeW5aallvUVdvVUJVdk9E?=
 =?utf-8?B?ZGgrbGVHdjFTRzRrMVpWU1ErcXVGQ21jRjcyQTlkdmxiZk1GalpUZ3REYW5Y?=
 =?utf-8?B?SzRVU1V3bmU4b2dKZDZNc3ZYdGZ4RFhoRFozaGpzMGZkV1BYdG1XNTZ1elhi?=
 =?utf-8?B?aUhXczh6bVQwa3RvbWVId05RY2poMklPZ3I4elpvZkxwWGtiRkRUQ3FaS0Zw?=
 =?utf-8?B?MG9pYWZBTnVVZzJkWWlBbjZnT0JXcW1sckxlMmEzSkRlQjUza1paRVVzSHZI?=
 =?utf-8?B?L1RrNFpucDkzK1Fmd3RUWThPb2h5NUd4c2Z1UXI3VHlWMjV6Y2ErQVhtV2VW?=
 =?utf-8?B?Sm1la1RGeWliblNkTVRVU1ladkNDaGdEY3hqZkR3L3o2cWRkVEg4UmJ0WjJx?=
 =?utf-8?B?RVlJRFlqZThNN0lRdmVjUXJmL3l0anU4QzNEVGF0QVlzUnNnMGx2elQ1eFB1?=
 =?utf-8?B?WVFnZUhNN2QxL2xwZEhwSjhZTmZtNmVFNldDMmYyOE9QbUFRd1UwOW96VDRC?=
 =?utf-8?B?aFYycDM1UG8weFhPckZQNmNMYVBjS1g2WmNGcE45aURmWlF0YU9IT083aWow?=
 =?utf-8?B?T05IL1czQ3VRcWRVUUdrZUFwL1N4TTJSQmh4YXVkZkVHdmxqWWNGejZqb3Vs?=
 =?utf-8?B?Y0JtSzBVUHFLbEtHUFo4Rm9KMVY4NGRsU0x5UHpCbWlURTNndjhETlMxNURG?=
 =?utf-8?B?YzRRMWM0dS9URVNkT3RaQTYzdXo4S0JpZ3Bld1FQNTh1dDdwamhNZTkrNFlW?=
 =?utf-8?B?VG51dVdFdkphb0ZkOTZTdUtTTDFDVWg3RHVuSVFBTjFKL3MzYlNidVJ6Y0VP?=
 =?utf-8?B?eVM4aXFlUmVCY2lkajVXV1BTcU1iV0NubGJ5UGt0bzc1TDRTd2creVp2Y3J6?=
 =?utf-8?B?Y0dZV0c2b1FxSjllcVpDVFZGaWdpWkpxV1UyVEJwMTJDbDViZXRsRTNXSnl0?=
 =?utf-8?B?cGhGdWovbUxQSnlyWk9oMXpwZytxRWJZK2NLY01Za2FxdVhkQU9GUUpsaXd0?=
 =?utf-8?B?WTk1M2M3NUFTMWZSek4zaUR2QWJpcG1nUUR4RmJjWlNGZlA2S3puSE0zTjdS?=
 =?utf-8?B?YWJXRzJFQUtiNnFveG5DelRwUmQ0ZnRDR29YL09URjZpYXN3VXdHVEgwaHNt?=
 =?utf-8?B?QzRGaXVJbjBYTFQ4WWQ1WWZVU3luWnAvYnQxcGdEL3FwcTBBaldrdDROZFdW?=
 =?utf-8?B?RjFYYTJmM1FadGoydEZjNG9zZHdBellEdEpqOE5pYWhDSEhMTjYxZ1RjV3h3?=
 =?utf-8?B?SU9UTkRwMW1IL0l1TE0valJuSUFOZkM1dTNVYjcwMzhIWmxrTXduRmhiMFht?=
 =?utf-8?B?dVpnYjJIVmFGaDBncFpvY3B5WVU1ZGk3Z3Rad2lFeTh5TkZPWVVkWGZTZ0pv?=
 =?utf-8?B?KzRkVWFOQ1YwLytLOVdhWGZlT2xtdW0yRjVwZVg5Q3hWWXVlU3pTckNwTW9n?=
 =?utf-8?B?bDh2OFZvZWJpclRpTVJnRUh3dXpaUGFyOHpadWhHbUh0QUlLbzBlRzBvZXl3?=
 =?utf-8?B?blA2dmpJb1ZGYWQyR1FMZTY0UStGQUkwaXlrbW1JanpseWx1ZG1FMS9HbFA4?=
 =?utf-8?B?S3RFRkpETjFTb1FZZmtDaVl6RzZxb0pQZkZ0dXdjaUZnQXpocjV0WERHNUl1?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: va3MWOluo+V53IGVSWnDPgI2XTj7cqZobRU12LOiECx6lkRM46kQb2qgy0UZh3mR+WyVwExpZ56QkIC3uxLQOg8LBtdarnMz6yHRE2Sis7WBSgGFg7+PClla4/EnUCLc7ufrSPSVxJgTGsvdWKdDK6vTezIDQdniD1t5wkyxPrXc2NmnF+l0GPhlkQtHKeIJYlJZtMsTg4t4r1g/CMPzkMVDd3funxuXvfJ56JaWJeppioLs78VbB54JUu3apMiGSk8H1r4WbyN+fVbtYggnZ6SHcMNnxnPNbTP1GhDKzdWw1raz/CQlznrFlGzzLTvcT5YDrFxHWOBAoIahfhcJBjSPafPanuKU64iFvvMDIFCZvRONzfVYk3+QkgabuJ4n4n4Ncr9Q3gn7+tvwauW2WoioEKhAoxhYUAcA3GYt7leBdpXpgJehdIvlWhgqMWpJVeDOdSIlCneqonsAmHsbHePxKtDmTDj+yKFiorfPRkMFz84Uzt+OShLIH/6QyBcZWNFUKh1Pdu8SC+oXzdspVC2gh1SryrI3aZ3H0A7JgZc/nnYRE7J4vKiGO2/rzu1nDzAZIWdDFhwu3W1DZ/X2iFKu0dgZ+rpP0T7CcM/pza1/MSPmU+UphM71Z3zFutsB0xHGvLOj3Co24NM2Aa8mTUwtGl2KNbra1Z5RAT7yI7tnzaa5NUap2/yY7J7nhDzBzEAnQtcP6wSEGzlpwK7RuvEI5/ayElysFqv2AQgUmjUFfSJTCWFrO0WCJDNKGybTYY02w7lyeNsoiV40UNy0Wwal8dpL6ZTab+pKJZA+w2atkb+SyNFc8/ECRI7W/0EM4s7pyIfmYAcQkta2BMZVkWU31Ba3enqL4EMPRXPCrwiBbLRVUw5sKyEKFpcqx8WY
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad2e1da-bdec-4837-a7a7-08db36b3d3af
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 15:30:18.3505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bV4SEbjQtxBqmAx4cOH1LfrMRG+UqRUADLvx2EnUzKwAqgk+NMCM4EAGZdlrab2HJD3Wq8Y3sVK5TjkhwbicLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4252
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_09,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060138
X-Proofpoint-ORIG-GUID: 34RAs_hYKmUUu8mKrN_OLd61QsY0DhGl
X-Proofpoint-GUID: 34RAs_hYKmUUu8mKrN_OLd61QsY0DhGl
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/23 02:56, Chen Yu wrote:
> On 2023-04-04 at 14:29:15 -0400, chris hyser wrote:
>> Commit 6419265899d9 ("sched/fair: Fix division by zero
>> sysctl_numa_balancing_scan_size") prevented a divide by zero by using
>> sysctl mechanisms to return EINVAL for a sysctl_numa_balancing_scan_size
>> value of zero. When moved from a sysctl to a debugfs file, this checking
>> was lost.
>>
>> This patch puts zero checking back in place.
>>
> Maybe add a tag
> Fixes: 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to debugfs")

Yes, you are correct. I should have reviewed the patch submitter doc. 
Also seems like a Cc: to stable is appropriate.

>> Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
> 
> Other than that,
> Tested-by: Chen Yu <yu.c.chen@intel.com>
> 
> thanks,
> Chenyu

Thank you. Changes made and sent as v4.

-chrish

