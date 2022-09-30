Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25EF5F108C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiI3RMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiI3RMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:12:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F172CE13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 10:12:07 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UGx2Xm023258;
        Fri, 30 Sep 2022 17:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=KpKFRkAdGrH2xpFuPVlHLKJ6s/qVZeqYQsEMNxwrhoY=;
 b=jpcAHT0PRPjGDOHlx+4oChz06uuD0MLuuMC1911X9qRmUuvtUjjNaNf97HdaA2LMD7Pg
 kvl0SuMCUhawu6DS6LcogkrwucFNio3SXu8qqFWY48EmDjPdV7KBa9ybtsIowFn5xyAV
 fhTDffZfUaicUZSPoc9vNvN3qsmikKpJsjeRAGjKmuwZWxBSHlY30bdlrl2cTxYkMIef
 llvIozxMP1lsBnrBYgFdDDgAa5Qpi/hqrHxByuVIuheJjbeiracOdBzm2kNDnE3DV6j+
 6cEMtXj9DybOrLqKq1i3VnKdGItC5HqXVRHbAGSmNoOgR/KD2MA5k85LJlDl27330Pbx 7g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jsstpynvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 17:11:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28UGU70B022177;
        Fri, 30 Sep 2022 17:11:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpvj547w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 17:11:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWmVE2dpde7tmkM0lZ470x4uBOJw/wcKMlHxtxjarX6UzIR8AvYpmTD2y5RkTB3njWeyu5y7Ba//HDq2CTDLIFIRo6tUqplaRIVY/Flru/MFlwI3ia7XHV9sho4e8+1ejheeqj00IDvrbYN1nJ+27ufXe/iB8NcRXdb1Y8u1QbdZz8Nt0ic4LPr+3njaj9zf60DLNx7Wlmo5ZTHflEPQ3MPfWMYPRvk7k5hzgF6N2c7OcIWcd9VGYB5mkYDJHDoNe633FCjqQ9xcs0yhqpBYgbxTwM6aN5vmbaGNIBrgGsvktrXbUQy6/pwAe/gz20S1rDerE00osn4uO0CiO3ww+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpKFRkAdGrH2xpFuPVlHLKJ6s/qVZeqYQsEMNxwrhoY=;
 b=eJ/NaruaXZd/WvrfRnMhZMdT8xi/1oVrRf/6sFJLCxGpCQDHHqSrd3UgMT17hv35LEnNQf0PwSM+OrGsdBfnndPGm2rHFuVDHy9+asyxzr9eIbFpnHsDm9hKF8Q7Dh6GHwoGYAf8btpAEW92wMU2FKr7SEnbdlh79MKFBG6py0JDaphtB8gAVgPypvTqGN5nyIRUA3mMyOE/iFAfe66hD2ssqQqEJHT16tKLyQm4K+Yy22aTTnDEASj/9Pc6/aRT0nLfzqyosGSBH9syT9E0RQIAshyoI7j2pvcTQiXFrUZRwkX5inRfAOhV8H07cyRxrWqNmLBX+q8QmHx/QHRBXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpKFRkAdGrH2xpFuPVlHLKJ6s/qVZeqYQsEMNxwrhoY=;
 b=AgnLxyuF3K71yENOAOszmXJ01UBOMPpLqwgQPbQv7EGT0zLSEd9YswyK2VDNyKy8XEx48eX1k3GogAf8MVe4Rax88/M+FbVbq2SAxEsGwCMwjGBHMeJw2JcB40HjAmFumhzgsd6agDy2imUMz0J7YGuCX0K2o2kyIJuEDayUuLo=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH2PR10MB4311.namprd10.prod.outlook.com (2603:10b6:610:79::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 17:11:31 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f633:11c5:8ca5:eb40]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f633:11c5:8ca5:eb40%7]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 17:11:31 +0000
Message-ID: <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com>
Date:   Fri, 30 Sep 2022 12:11:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, david@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        sourabhjain@linux.ibm.com, linux-mm@kvack.org
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com> <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com> <Yzceb/y3SSFMuALR@zn.tnic>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Yzceb/y3SSFMuALR@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::19) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CH2PR10MB4311:EE_
X-MS-Office365-Filtering-Correlation-Id: 1877e2e9-8636-473f-53e7-08daa306d1dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUKkYXX7rySc+YQPx7NOwJMwkcNN+wxkqntgfiFImne81kQJ/n65ddDHf9HSDnHKoUDQgRCfpAuuQ5/a9ykX2ftcvAOIG5i8s8fM3HqbeA38/H2q4Jf3Ahot1/vRX12TqJc91P3cqF5bU7keD+fEgvJRRnvJYRcyX62oMp/9WCBfDCiEypa3SPZWCa0/QUF5PaVkbAotq9QHfcEaCs91M05pwpJhHrvqGR4nS4w67m17drgXpxaeDq6h6CWKTo46l75wrhEnlUmrFJcwG/+fb/8Oqio/4Ist1ZpDg3qIQ1g860NfXSXkYblLTGYAjcztMDQpKuv7JMIaq396Xmr1uYROLhXsZMncrexQEdOqnRBP7z0GGFl60GkhPzmhRgQjbTMmjB/moqkRQ2f3ntC2rb8wOcyjXr8oBL7vURqj1fC28hTUG+LWfUkT4Z/0ct2jph3lu3AIUORpIBKEnVv4OvjPuJ7fohDdyMhTEORjwk5VxZ8RJSKSNjzkVfeIFN/JQUJvVteVoL/6fZVPmyXEnhCtJADjpAICF4af1jI6WW87BSQJkionCXO+ZqssZnmXNsvbeG/pClH4HLW595AW02CULky0yn5ipCDDLu10LpSFKBIkCAZ6EkvxT39YEU8V23IIma72/PHkebMQZaMIg+gt/LsCruK4C7rRfSIGYiKN42J9KvkxYSlv+zkrBndanlyoQ5ZpCb7gzMSQ1jj2p6rPW6fETTJzd/XrwmO3SyApNnIUsjK0CXQECVhWEf/vE41KR8F0z+2H9WbuKP+niu7QguPPmEl2ryKbZiSqMxBhdDe8y9baiLeqGHEH28oXXvFD0NzPaoouSPpxUyr6bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199015)(186003)(2616005)(83380400001)(38100700002)(7416002)(5660300002)(2906002)(41300700001)(316002)(966005)(6486002)(478600001)(53546011)(6512007)(8936002)(6506007)(6666004)(4326008)(8676002)(66476007)(66556008)(66946007)(110136005)(36756003)(31686004)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG9tTnF5UWQxMTlDcWN3L0wxT0RaTmIvY0MwbGI4MjJTbjFVRnRhejZUYUV6?=
 =?utf-8?B?ZnBsS3VzK1B5dWwxMUhYVEw2R1NCUGJ4N21rS0xzeURBb3hJVkhLUXBFKzg1?=
 =?utf-8?B?S3lWb0JQWnI3dlNTOSs5YWFIYzFOZ0Z3VXloazRsS1ZWMm5VVjZMNUVremxK?=
 =?utf-8?B?WitoWDE1eU5tK3dxVng2cjdpTFpNVTQzSEZsQ1Y2L2hqZ2MyQTMzWnNvZWxq?=
 =?utf-8?B?OWVkd0JUdXc5eFZNL0t5YXRLZnBOMlF5Vmt6NDFuVHk3d1ZsYUgreWJZL2Rw?=
 =?utf-8?B?S3oyQm9obzRNTFVYRGo4ODNlRHNFZXc3VkhBUzZDVEZpclJTUEdrMUJlQXZC?=
 =?utf-8?B?dVRVd0dkZlZHWEFnOTNKaUUzcTVBaDdUcUxQNUJjRE5Gd1lUODMwbkNEbG4w?=
 =?utf-8?B?d0pPdTA0UHg3clBOcWFIRXk4STNVak1RVnQyZml3R0RLNXRJb0JVQnMxMU1S?=
 =?utf-8?B?dzdOZWRhVU0rRmE5YmtQeGo4ZFRmejlNYUthNk56bEJsRXFqUkxxVDJQSmpz?=
 =?utf-8?B?dWJFeUt1MkVSQnVqRlpkZEZMVjI3MW9VdmFTZTZ5RGJiQ2loMWVqSFZ0ZmFJ?=
 =?utf-8?B?MDhOYVRicml0cTZCZE9SNW8xcXdwNHlRSzZwYlBSbGttaHc0Y3hISFRzTERw?=
 =?utf-8?B?bktOeFNoanBhbS82RXJySWNDRjRnaWtxQVl5NDdLU3hQZnhOOEVZcE1WNkJu?=
 =?utf-8?B?ZUhJS0dNYmFxV3duQ1JiZDV6MlVGMzBSMlFiNDFuMUhiRnN4amd3MVBlT1FJ?=
 =?utf-8?B?T29rU3Vjai9GSktQb2pzWTN4eWRIOUhUWjBvYUE4cFNLRk9nM0x4K2FXTGpy?=
 =?utf-8?B?VUZPaWI1R242cmZPdVgvQ2w5cXVKV2oxd3BMMTBXTm0ycCtsaFNyNlFSbStL?=
 =?utf-8?B?SFhvTjVxcEo2NVllVXZYVllLQ0VyZDk4MW9zcDJrdGdrdjdMZVVtMWp2UzBm?=
 =?utf-8?B?cnRNWVgzNXlnRzR3cENJWllFU1VqU0p3YnBaTWZNWjBrQkRUaE5YZzJSLzk5?=
 =?utf-8?B?UWhYK2RVaGpPdjN4bTdQMnFnckFJS0wvdmxTTk9QNHVBMHdTSjlsOFRFTFJr?=
 =?utf-8?B?WVpOMUlzYnNKSUxTaHZ2SnFxVnNtcGcvU3ltcW4vYmFaUXYrdVliaGF4aTFL?=
 =?utf-8?B?eVAydE1IK0lHcXJSYllYbUlhemU2TGNkRUlWY1gva3lpK1pkYXF3THY1blNp?=
 =?utf-8?B?RGhqcUhXQUE5dEZqbnduSnR4elZ0VUFzMWdpMWZpWCtMYm1RcmhydERSN1dx?=
 =?utf-8?B?aWNMMGtwVUY5OXVUN2NmSVIwUkkrQmgzUTlEd3ZndGh5aGxlbU9WYzd5c25u?=
 =?utf-8?B?bjhSRGFUWFZEZzlBdWtBM2lWd2RQei9XOFJDOXoyYU85ak5pWGRzUlFBU3Rh?=
 =?utf-8?B?Q1JocEFicVU1eHh4aWhjTytOTjd1MjFNamYzdDVYRFYyNDE3OEdNVlFLcUdh?=
 =?utf-8?B?OUZGendsZXVuay9hbkJxc1dOUC82czdzVGpiZlZ1M1NaM2ZvR2FZc1ptVGN5?=
 =?utf-8?B?bmY4U0UrZjg5RGxqWmI5Q3c3b2dHTWJ6MVZOSzY5SjVnMUh5czJqR1VlYlNL?=
 =?utf-8?B?aXk0NWV0OHY4SlVJSncrQW9wcDFOUk9JK3JEY2taeW8rUHNuR20yMEVrMzJH?=
 =?utf-8?B?TEhJamlrT21SdE5WS21idEZCNlZ1TkM4eTRVNWhYOFBWL201SHRkYXkya1RI?=
 =?utf-8?B?Zm1EK1NCdW5VMVJIUHptRHd5RlpNcWV2M3BCM0RHbjVXWW85T0RDNExjTFIz?=
 =?utf-8?B?ckZNQWhlMVpQM0NMWU5NN0U3ZU1kdERlZXM0Y01FUm1iMnpYY2x2L2JFRmZa?=
 =?utf-8?B?aWkrbkxCKzlJQlFheFVTY2hHQS8zYXZIM295L29HNURRckJtK2pubkhMaTI1?=
 =?utf-8?B?RVRTdlRFNEdBVUhNNVJ1bERsbGRqbkdKb0ZaSGpuc1RMcWN6SnVHWXc3bEZO?=
 =?utf-8?B?YU1rcXNYd1B5L1BqeTNUVXJqT2tCZFlHNENDVzI1ZjFmNXNSTmpidFl5MlYx?=
 =?utf-8?B?dlJKTk80S3BueWhGQnRFRXZvS0F0cXY0N0NDOFRKUlY3cjhnWm1zbkxOdmF2?=
 =?utf-8?B?SWowNTlKSzNXb0R2R3h5UkZRQ1MzOGJWM0ttd3lEdk9MaUc5bitWN0ZNVGZq?=
 =?utf-8?B?dmdHc2lmVUprbXU3a0xrSUVqRC9lTnk4ZWhWQ3FVUzl3aGJLOXA0dG5PMGNr?=
 =?utf-8?Q?L7PYNM3SYiWiWOuKspFPZ+k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1877e2e9-8636-473f-53e7-08daa306d1dd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 17:11:31.5077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9au9YXi9bXalyNTWFP+T5lbHY5ndroV1fK9tGxTaRfcYrvt/cdhG0dbdWA446Sd6NBhMetmC/FYsgKOLtZmPaWdgOtIUpQ4EHhTOBgl9aY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4311
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209300107
X-Proofpoint-ORIG-GUID: 8SWWzgENewv0T4DtjOG1jmbK0inTr7mB
X-Proofpoint-GUID: 8SWWzgENewv0T4DtjOG1jmbK0inTr7mB
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/22 11:50, Borislav Petkov wrote:
> On Fri, Sep 30, 2022 at 10:36:49AM -0500, Eric DeVolder wrote:
>>> Your help text talks about System RAM entries in /proc/iomem which means
>>> that those entries are present somewhere in the kernel and you can read
>>> them out and do the proper calculations dynamically instead of doing the
>>> static CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES thing.
>>
>> The intent is to compute the max size buffer needed to contain a maximum
>> populated elfcorehdr, which is primarily based on the number of CPUs and
>> memory regions. Thus far I (and others involved) have not found a kernel
>> method to determine the maximum number of memory regions possible (if you
>> are aware of one, please let me know!). Thus CONFIG_CRASH_MAX_MEMORY_RANGES
>> was born (rather borrowed from kexec-tools).
> 
> Let's ask some mm folks.
> 
> mm folks, is there a way to enumerate all the memory regions a machine
> has?
> 
> It looks to me like register_memory_resource() in mm/memory_hotplug.c
> does register the resource so there should be a way to count that list
> of resources or at least maintain a count somewhere so that kexec/crash
> code can know how big its elfcodehdr buffer should be instead of doing a
> clumsy Kconfig item where people would need to guess...
> 
> Hmm.
> 

There is of course a way to enumerate the memory regions in use on the machine, that is not what 
this code needs. In order to compute the maximum buffer size needed (this buffer size is computed 
once), the count of the maximum number of memory regions possible (even if not currently in use) is 
what is needed.

>>> +#ifdef CONFIG_CRASH_MAX_MEMORY_RANGES
>> So I think the use of CONFIG_CRASH_MAX_MEMORY_RANGES is not correct; it
>> still needs to be based on the cpu or memory hotplug options.
> 
> You're kidding, right?
> 
> +config CRASH_MAX_MEMORY_RANGES
> +	depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
> 	^^^^^^^^^^				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Oh, that would be an error of haste on my part. This should be:
   depends on CRASH_DUMP && MEMORY_HOTPLUG

> 
>>> @@ -622,6 +622,15 @@ static int __init crash_save_vmcoreinfo_init(void)
>>>    subsys_initcall(crash_save_vmcoreinfo_init);
>>>    #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>>> +
>>> +void __weak *arch_map_crash_pages(unsigned long paddr, unsigned long size)
>>> +{
>>> +	return NULL;
>>> +}
>>> +
>>> +void __weak arch_unmap_crash_pages(void **ptr) { }
>>> +void __weak arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action) { }
>>> +
>> I was asked by Baoquan He to eliminate the use of __weak
> 
> Because?
> 

Baoquan pointed me to:

https://lore.kernel.org/lkml/cover.1656659357.git.naveen.n.rao@linux.vnet.ibm.com/T/

Thanks,
eric
