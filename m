Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FAE695592
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 01:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjBNAux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 19:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBNAuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 19:50:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B478AC163
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 16:50:47 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DMNqCA001545;
        Tue, 14 Feb 2023 00:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tL+TIjGjIX2O7l1Rm7dvDoO7x9ymmM3PT/Jb0+NhD08=;
 b=dpsiLTLrMBGdcb0E4whv4mHk3Uq/s4vpO+SnKQ1SjEsryviM73xlbefvXV+8KT4J5taU
 230wvcPyld0aBifVjWYoCH1nOjomGUJqv1vxxJp8AW9EvDnlsydAHYxleehW+tlyDvHO
 eiDtb/y3eNBqcN1giIuX3K3uwxlspmdvGRiu8vcaIeFNvL9Izew/WXvruElmG01eBHzh
 jY8QLH4bKtfC+8qOJzqzFhgactnst27WMUbH1lmNP9JKbzaIEYNP32bhF4vJNQ3DfX/S
 rg80BXmHgd2OkXXD79pI3jToMYdTHZ/Qlizc+gq0t+BgG7NV/ioh59nF6eJnMw7hzCeY kQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2mtc708-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 00:50:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31DN5ehs013625;
        Tue, 14 Feb 2023 00:50:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f4v7m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 00:50:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FguyrCFn+xeUzocrL0zs7p/IIUXWnUk19o06Buzu1OdFVUq3lLZ0rS+MjbtviEOFfgOL+XvND/2cffXqYXdExzbM0UaThBe3/KmIV9Zi3U6uP+aTINlBym1vrOC3/uP0g43xi8Fs0aNakRuPpm3OMcjFfRlSvvgTmEfWVJNtI6unEtdQgZBlCo0PcV/oAHLW1Ya97jsgftMEmJv8raX6c0imMAy/1YOpbhkErZWpNTO6Ana4CbruYCrdfxMqPXoQHYcl2VdET53oMq7j0d60+/aFV66sOSxWbiXDRupdgyEmXNAeV5c2j3wqdniK6GBJVjpBediJO8EWAJDkrmZu7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tL+TIjGjIX2O7l1Rm7dvDoO7x9ymmM3PT/Jb0+NhD08=;
 b=mHzXQazUdv9MN5ygAfYx4EOmDPv6xxmHHRp2YdScNtMESRvKieRL4Z5mv2GPuSCiafYrESzJdm4iGFxFDImqYcC39E+rLgfyJad1pFtALmJ3kqwP9pgTgwrVkjf/oV+F1R+tBiHjiYlENmyfkFWN4sNlWuMMq6yIHLpSaNxrfDISvpZJ0e2QZ+rd8APLwUve+7Pjv8ioVAgRoXvIX+E9X0tBTFszXPaYCksfrhYR+82YxVFXrLn4n9FQW2pD3uLIVS3YBwlPcJwIF9C3ixquWoBZhSX/VxRQIPsGlv4lp8nju0h4V6Ok8p0Mj4l35uXjxQR7IeYkrC2z/X/+HHOnZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tL+TIjGjIX2O7l1Rm7dvDoO7x9ymmM3PT/Jb0+NhD08=;
 b=C3vTQ6NRGIZhnASZgKF0OJykcTfXtEH+JLbRbm3AdHqYu4wt2MVUdzbvitfmUR05A1LT7AUsBFYEt5Z8oalD2wPXidTh7iFH0GHY1lGndqzQK2GU/XmR8Vthp3zhbGsHQcXM/dkWT+GreLiSwECuAfZjuxZ/k8n5Pjq7KhCRdXk=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SJ0PR10MB5889.namprd10.prod.outlook.com (2603:10b6:a03:3ee::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.8; Tue, 14 Feb 2023 00:50:40 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f%5]) with mapi id 15.20.6111.010; Tue, 14 Feb 2023
 00:50:40 +0000
Message-ID: <4bf04d5a-c45c-dac9-705f-c7a0adfd37f3@oracle.com>
Date:   Mon, 13 Feb 2023 18:50:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 4/5] kernel: Prepare set_kthread_struct to be used for
 setup_thread_fn
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     brauner@kernel.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
References: <20230213010020.1813-1-michael.christie@oracle.com>
 <20230213010020.1813-5-michael.christie@oracle.com>
 <CAHk-=wj0oA0VV77eAgMYFSJm7SBQ15vDLFjcFnNvWrbCRXXSpA@mail.gmail.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CAHk-=wj0oA0VV77eAgMYFSJm7SBQ15vDLFjcFnNvWrbCRXXSpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::32) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|SJ0PR10MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 7296b445-5818-4b68-52bf-08db0e257e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ScL17sMAZQ/hVeDYVKj78kpCqJKgej/l14SYl64GYvQBiGor10jtGTwGa5oH5Z2wkbg6mhhLB8/X6Q+ubDdK8Shq7HLf15NWkr5bCLMZhY0B8ai2bFOcLWMxFghOcF3hPfse4GVX1O4rgIBnW45TdR05YBzNL4aabbc44dTpZGW+kNhm+iSdsycg6zaeaOVaswGEc23BkMPOd8ERyHLwn4nfAX5zihshlR8zQHlvzKHEJRTSQgSv4HOfW/nv9/oW27WiZ38OPWzPssvFmXndm1zNcG4bCklldiUCmjK0BCo1e9hasL8cUcu2epn6Y0d/2DMdYPHIwamZq0Sl1W5T3kTj92LkeZmBD+plAerPdzyLK//38qhdk9rwELGvb1eKbdNvoT3I7GHfyASEwnu9i8z+GpFoBx7VeUHSkFjWn12mrtRJxo5RCNv583wlsjkWqZkN3igWh2/zxZYO3SWti1DiGVza+9MyWzixTH8KMKBOcogpSygUdzP7DdnQ9gkn+jYxMN/zuPGKKPe0Bnt2b0YFeJzSoJGUh0G8hrQALcMuww3C8no316tc/eDL3jgGToTFfkDLCvvOcYej2DKJbjDKIhusIr0wjqhwXmVHBqKa1ijygpc1eaMTjlGHM7ej/LN7z8xmvBXg+i0R21m0vR6OB7R7iWvKmA0zt8Fi2zRWCJblG5UNEtIdVpU/ocAepo0K6aw75rd8OG/tpEk74qP4x+oEeJrGoOooS3iYXwo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199018)(316002)(478600001)(6486002)(186003)(5660300002)(26005)(8936002)(6506007)(2616005)(83380400001)(53546011)(2906002)(6512007)(41300700001)(36756003)(38100700002)(66556008)(4326008)(6916009)(31686004)(66476007)(66946007)(8676002)(6666004)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE4yUSt6YUxid3hOL3lDVlYvVEpDTmYrdHcwVkpxSXhkZEtqS3BpQStqSEpH?=
 =?utf-8?B?Ky93S0ZXajdFTk01TWIySUNOeGhZK0c2Skt4ZlltVVh6ay9wK3M0U1gzSWw3?=
 =?utf-8?B?MXlqRGZRL2pndEdTSVo3Z2xPTFRHdFJqbUxVVmlPYzFkVFg5Q01oSEhhUy9p?=
 =?utf-8?B?SVhBUG1wTktkOEp2MDNrcjM0VmExQ3FTbEhTN1IvZDdIQ3BYbVc5b3pBenZj?=
 =?utf-8?B?c2ZhbDhBUnV5MGpSTzNzdE9vRGttODQ3bmtFVFlKRVRzbzFEcXkwbzZUL3lR?=
 =?utf-8?B?YUU0UGMrbGYxaG9USHhJU2JvQlZMVDliK1BBOWxuUnQ0bTJMZTZvenBLK2U3?=
 =?utf-8?B?eFMrWWV2UWNIQTROWnZJZTJZYTBDSnpFQVBJcmlhcG5ROGd1d1BFeWF3aWgx?=
 =?utf-8?B?TFVkVXRMdWY4MzJCYVFLdGJYY1VjcThGUUMwQVYxVktrUlVONDcrSWczeEZn?=
 =?utf-8?B?UlUwT3k5aCthL2tuTWpOcXFQQ3ZQN1dzeVRpTnllbUdON1lEUVRzV2IwUHlt?=
 =?utf-8?B?bE85NjMyQm1KOUR0MHo3Q2RFUDFicmVZYk1vdWVoOFV6eTVVWndETXNnTS9I?=
 =?utf-8?B?NVVJUDlVdHhtQlVEWDNKeUt0TXIwVXZyTW0rOXJQa1VCVTNHYkVEUUdTQWpK?=
 =?utf-8?B?K3pMcWF5UDBEMjNSUjU2SmdIVVpabThEaHlRK1Z3ejVZQkxERFk3UjMwU2lv?=
 =?utf-8?B?c3RVeFdkZXUyU0VGd0pGbzU1NHV2dFQ5QkpKQ283Q21uUndPMzE5TEFxaXVT?=
 =?utf-8?B?eWd4NUZNZ3VFZlJ3VWRHVllVM3VOTXBTeWFEZUEyNmt6N0RPQkZEcENURDdk?=
 =?utf-8?B?SGl6S1VzelF3a2V4VG5XMU5sZy9oMmNxdndhaUhxVnhrKzAwd3ZpVlFjeGY5?=
 =?utf-8?B?T294YlVyYVRmTncwQkhDY2JpTnZHVTBBRllyRVZBdVp4UGIzb3FEWW9weWpu?=
 =?utf-8?B?TmpBd2tqWUFJemgrRU0vRURNT1Q1TTEwRE92QVhqYS9WUHlUNkFsN0xTWWNl?=
 =?utf-8?B?ZFRLdFl5QTJuSDgrSnhCNGYwZmEwL1UveEhFTk5pdHRYZmw1cW44YmZMQzJJ?=
 =?utf-8?B?ZU91bVpzdERwd1NaY2tkMlVjc3pMcjZkcTBCa0l2dENzcm5oUW53eXJrOGFO?=
 =?utf-8?B?UXZYQ2RCbEw3TS9jRk1jQkdTenlhRTd5N0xYcWovekhVc0ZCWVczREhvZDVk?=
 =?utf-8?B?RS9BZWNlTHloejI5d2xZSXdkNG8vT1RTNnJjOTJWZXhpMlhjU25WcmRrNDBN?=
 =?utf-8?B?cTlhSDBRcEp0QkRGUDFHR2Jnd3QvR0FJSlNubHJhV0JXYXpQdzR0akV4WlpC?=
 =?utf-8?B?Z3lLeEIvaTNUemJGK2lLcEhydnVRdFhVVU1STzFkMzYyN1UxWHkrOUF1NExP?=
 =?utf-8?B?YmU5VTY1Uk9uZUlheGwvWmhtcHdjL0JqZWVDWXdtMTRISzBtV042aVNlN2pp?=
 =?utf-8?B?eDJ4Q1hIWldyRjRWYnRqR2tCSmFTN1o0NUFPUFpnck11OW01WnFSelVza1lP?=
 =?utf-8?B?Ujk3ZW5zVUJXcEpjT1pGa1hwSGdlRVVtRU5JRWlFYjdaSTFGMWJTditNNWV0?=
 =?utf-8?B?VVkraUJlbUFHM1RIU0NZVlBoWE5QYTU3V2MyQm44ZW9JaHVzYUdOcVIvRTR0?=
 =?utf-8?B?cnNla2VZajQraytMSm9IUjVNbDNCQnN2YXE2UlNWbnpuMk5HZG4yeWhTTGxJ?=
 =?utf-8?B?RFdVSHY5QUtTY3RnSHN4Q2xSSzl1MHhhYitWSThaM1RDVkpIUTIzV0Y3T0pJ?=
 =?utf-8?B?TmR4NTg1a0JUM0ZTUkZ0TTZoVW81WmQ1eEV5bHVsOVpUZFc4a2o3ekZscTZM?=
 =?utf-8?B?Qk9wckpQRFNTOVgyRjRkMk9HV2djS1ZvYk9jOE55K2R4Y0dvYkRWb25hZXlF?=
 =?utf-8?B?dkk1M0YvVUJTakcvNWEvcEczdjJqWmlWc1pOYjZDUHZIZjZycjR1UmZIUE5G?=
 =?utf-8?B?a1g4dUFzdnAzcGZROU5IYStMdmhqQkNudzgvbmIrN3BkY3IzZERCRUJjTW90?=
 =?utf-8?B?U3h3OS9UdWU4azEyYWFrS0toQVAvL2JNR0VVektrUmVqczA5bnl5SUtYZ05D?=
 =?utf-8?B?anRyQjV6cTkxeGw1K0o0L2pOU3RQN3JYMmVXZUNUN2lVZ3FESEhVb0c4Mnhl?=
 =?utf-8?B?NlpkeEIzSHh6NUNUcmc3T1lNMEV3VzBDYkxlNWpJRHlNNmRPeDZjQmpSUFdt?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uWwmn8Lmr9OtoQOhPzTpmcu3DyNKudTOi7EetVy7gAr4mzgwPwd313/8/S8VpreBjuhbV8eWvcjrtK/eIqx4MO3GFu12rxS/0oSHGnxS4bee2HToJPNYIWFARMJIm7U3nmhMST0sr8uuCNB/iVrpUZfyRes3njYpqGP1r3IzEt0nkJpdY4D/UqW1435AGVPxyss2xfyEl6PmW25i29fyoKruhG07b6lI0q0UAcaooyHHJT6/redR6EyqRXCjBc/JMpkGauv0wWKOtDd2XjAuerBhUm306MgMqa5jDL1OPvOowNG9nbdLkzHspGBhY1zWGDM0auqViVinCD/Tpg3KajRtIjNcpJUiD+2vVDMMWqewt+Va9eyhjF7wIjiLGMerl8gMqadN82M2CZOo1pINnAtobW3eq0k3V6ATq++yDobmzRihABv0p2NrYFCgHrTI6QKb+8j3lW8ZryAiATi9Rmdr2aysxoPd7n3Q9i39FzfYi7WC5iamyMevWKZGei05StoSMPvX3MUaaJGk6KH6Zqbzpvt8xeidQZyAxlAkZPwi241j1ew0Dn3OSqiRR9FKGurlZtwgBzguMkzYtU8ksLrw6lYh1Jc7NHNV2E9bXh1XTVhFT4517uV/yjwS3SaVuNwU/zgAFXgR3CdvYguUxGmYvoy+/kFPg2d/pr37s9m2AMXK/5dTFKU2uj5XcT5t4XWmHr848HViuXy7bLM2p7TddwhmtYghIfc6cUBNr/eVO/95BxMKAz9eminBzrSRrU1zI+2Ox34LP5COJwpUFnUWVEVayTtVRSw/OANHIN/jgc97gLR5X5TjcSXeTfe5ig7UriAtj0LWcESBkzKGr1TGtlf3I68YiIHVlyiWHxcY85bbrWsltcCca7o5KirU
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7296b445-5818-4b68-52bf-08db0e257e07
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 00:50:39.6076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdL+dCAmo4fIFLeVqXdDGvqHKzo+YrplA243XO4n5Ie2QfaZd5yJreV9VNkHpW01CBW9ECin1H2wl06PnpmaLoRpH3YB73ocd4z+ESPiciE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5889
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302140004
X-Proofpoint-GUID: ZTEPmh1DFy7_On8OYnKMzFEK9qFb6T_T
X-Proofpoint-ORIG-GUID: ZTEPmh1DFy7_On8OYnKMzFEK9qFb6T_T
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 1:54 PM, Linus Torvalds wrote:
> IOW, this patch is just being much too complicated for no good reason.
> The point was to make it _simpler_ to do thread setup, not more
> complicated.

Ah ok, I think I better understand your original question/suggestion.
I was thinking we couldn't do:

diff --git a/kernel/fork.c b/kernel/fork.c
index 9f7fe3541897..e94dd5a838d6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2109,6 +2109,11 @@ static __latent_entropy struct task_struct *copy_process(
 		siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
 	}
 
+
+	if (args->name)
+		snprintf(p->comm, TASK_COMM_LEN, "%s-%d", args->name,
+			 current->pid);
+
 	p->set_child_tid = (clone_flags & CLONE_CHILD_SETTID) ? args->child_tid : NULL;
 	/*
 	 * Clear TID on mm_release()?

 
because it would only support vhost and io_uring's sqpoll.c case which use the
parent pid in the name. I went wild trying to support every case and also kthread's
struct setup :)

I could balance it by doing the following which would support vhost, io_uring sqpoll
and kthread's name setting:


diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 357e0068497c..81179faa943d 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -23,6 +23,7 @@ struct kernel_clone_args {
 	int __user *pidfd;
 	int __user *child_tid;
 	int __user *parent_tid;
+	const char *name;
 	int exit_signal;
 	unsigned long stack;
 	unsigned long stack_size;
@@ -89,9 +90,11 @@ extern void exit_files(struct task_struct *);
 extern void exit_itimers(struct task_struct *);
 
 extern pid_t kernel_clone(struct kernel_clone_args *kargs);
-struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
+struct task_struct *create_io_thread(int (*fn)(void *), void *arg,
+				     const char *name, int node);
 struct task_struct *fork_idle(int);
-extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
+extern pid_t kernel_thread(int (*fn)(void *), void *arg, const char *name,
+			   unsigned long flags);
 extern pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags);
 extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
 int kernel_wait(pid_t pid, int *stat);
diff --git a/init/main.c b/init/main.c
index e1c3911d7c70..9dc816aa904f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -707,7 +707,7 @@ noinline void __ref rest_init(void)
 	rcu_read_unlock();
 
 	numa_default_policy();
-	pid = kernel_thread(kthreadd, NULL, CLONE_FS | CLONE_FILES);
+	pid = kernel_thread(kthreadd, NULL, NULL, CLONE_FS | CLONE_FILES);
 	rcu_read_lock();
 	kthreadd_task = find_task_by_pid_ns(pid, &init_pid_ns);
 	rcu_read_unlock();
diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 411bb2d1acd4..b399ef30882d 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -748,7 +748,7 @@ static void create_worker_cont(struct callback_head *cb)
 	worker = container_of(cb, struct io_worker, create_work);
 	clear_bit_unlock(0, &worker->create_state);
 	wqe = worker->wqe;
-	tsk = create_io_thread(io_wqe_worker, worker, wqe->node);
+	tsk = create_io_thread(io_wqe_worker, worker, NULL, wqe->node);
 	if (!IS_ERR(tsk)) {
 		io_init_new_worker(wqe, worker, tsk);
 		io_worker_release(worker);
@@ -817,7 +817,7 @@ static bool create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 	if (index == IO_WQ_ACCT_BOUND)
 		worker->flags |= IO_WORKER_F_BOUND;
 
-	tsk = create_io_thread(io_wqe_worker, worker, wqe->node);
+	tsk = create_io_thread(io_wqe_worker, worker, NULL, wqe->node);
 	if (!IS_ERR(tsk)) {
 		io_init_new_worker(wqe, worker, tsk);
 	} else if (!io_should_retry_thread(PTR_ERR(tsk))) {
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 559652380672..4b0388e15671 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -223,12 +223,8 @@ static int io_sq_thread(void *data)
 	struct io_sq_data *sqd = data;
 	struct io_ring_ctx *ctx;
 	unsigned long timeout = 0;
-	char buf[TASK_COMM_LEN];
 	DEFINE_WAIT(wait);
 
-	snprintf(buf, sizeof(buf), "iou-sqp-%d", sqd->task_pid);
-	set_task_comm(current, buf);
-
 	if (sqd->sq_cpu != -1)
 		set_cpus_allowed_ptr(current, cpumask_of(sqd->sq_cpu));
 	else
@@ -350,6 +346,7 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 		fdput(f);
 	}
 	if (ctx->flags & IORING_SETUP_SQPOLL) {
+		char name[TASK_COMM_LEN];
 		struct task_struct *tsk;
 		struct io_sq_data *sqd;
 		bool attached;
@@ -395,7 +392,8 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 
 		sqd->task_pid = current->pid;
 		sqd->task_tgid = current->tgid;
-		tsk = create_io_thread(io_sq_thread, sqd, NUMA_NO_NODE);
+		snprintf(name, sizeof(name), "iou-sqp-%d", sqd->task_pid);
+		tsk = create_io_thread(io_sq_thread, sqd, name, NUMA_NO_NODE);
 		if (IS_ERR(tsk)) {
 			ret = PTR_ERR(tsk);
 			goto err_sqpoll;
diff --git a/kernel/fork.c b/kernel/fork.c
index 9f7fe3541897..c566512281e0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2109,6 +2109,9 @@ static __latent_entropy struct task_struct *copy_process(
 		siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
 	}
 
+	if (args->name)
+		snprintf(p->comm, TASK_COMM_LEN, "%s", args->name);
+
 	p->set_child_tid = (clone_flags & CLONE_CHILD_SETTID) ? args->child_tid : NULL;
 	/*
 	 * Clear TID on mm_release()?
@@ -2613,7 +2616,8 @@ struct task_struct * __init fork_idle(int cpu)
  * The returned task is inactive, and the caller must fire it up through
  * wake_up_new_task(p). All signals are blocked in the created task.
  */
-struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
+struct task_struct *create_io_thread(int (*fn)(void *), void *arg,
+				     const char *name, int node)
 {
 	unsigned long flags = CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|
 				CLONE_IO;
@@ -2624,6 +2628,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.fn		= fn,
 		.fn_arg		= arg,
 		.io_thread	= 1,
+		.name		= name,
 	};
 
 	return copy_process(NULL, 0, node, &args);
@@ -2727,7 +2732,8 @@ pid_t kernel_clone(struct kernel_clone_args *args)
 /*
  * Create a kernel thread.
  */
-pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
+pid_t kernel_thread(int (*fn)(void *), void *arg, const char *name,
+		    unsigned long flags)
 {
 	struct kernel_clone_args args = {
 		.flags		= ((lower_32_bits(flags) | CLONE_VM |
@@ -2735,6 +2741,7 @@ pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
 		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
 		.fn		= fn,
 		.fn_arg		= arg,
+		.name		= name,
 		.kthread	= 1,
 	};
 
diff --git a/kernel/kthread.c b/kernel/kthread.c
index f97fd01a2932..20fdab8c6b25 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -38,6 +38,7 @@ struct task_struct *kthreadd_task;
 struct kthread_create_info
 {
 	/* Information passed to kthread() from kthreadd. */
+	char *full_name;
 	int (*threadfn)(void *data);
 	void *data;
 	int node;
@@ -343,10 +344,12 @@ static int kthread(void *_create)
 	/* Release the structure when caller killed by a fatal signal. */
 	done = xchg(&create->done, NULL);
 	if (!done) {
+		kfree(create->full_name);
 		kfree(create);
 		kthread_exit(-EINTR);
 	}
 
+	self->full_name = create->full_name;
 	self->threadfn = threadfn;
 	self->data = data;
 
@@ -396,12 +399,14 @@ static void create_kthread(struct kthread_create_info *create)
 	current->pref_node_fork = create->node;
 #endif
 	/* We want our own signal handler (we take no signals by default). */
-	pid = kernel_thread(kthread, create, CLONE_FS | CLONE_FILES | SIGCHLD);
+	pid = kernel_thread(kthread, create, create->full_name,
+			    CLONE_FS | CLONE_FILES | SIGCHLD);
 	if (pid < 0) {
 		/* Release the structure when caller killed by a fatal signal. */
 		struct completion *done = xchg(&create->done, NULL);
 
 		if (!done) {
+			kfree(create->full_name);
 			kfree(create);
 			return;
 		}
@@ -427,6 +432,11 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 	create->data = data;
 	create->node = node;
 	create->done = &done;
+	create->full_name = kvasprintf(GFP_KERNEL, namefmt, args);
+	if (!create->full_name) {
+		task = ERR_PTR(-ENOMEM);
+		goto free_create;
+	}
 
 	spin_lock(&kthread_create_lock);
 	list_add_tail(&create->list, &kthread_create_list);
@@ -453,26 +463,7 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 		wait_for_completion(&done);
 	}
 	task = create->result;
-	if (!IS_ERR(task)) {
-		char name[TASK_COMM_LEN];
-		va_list aq;
-		int len;
-
-		/*
-		 * task is already visible to other tasks, so updating
-		 * COMM must be protected.
-		 */
-		va_copy(aq, args);
-		len = vsnprintf(name, sizeof(name), namefmt, aq);
-		va_end(aq);
-		if (len >= TASK_COMM_LEN) {
-			struct kthread *kthread = to_kthread(task);
-
-			/* leave it truncated when out of memory. */
-			kthread->full_name = kvasprintf(GFP_KERNEL, namefmt, args);
-		}
-		set_task_comm(task, name);
-	}
+free_create:
 	kfree(create);
 	return task;
 }

