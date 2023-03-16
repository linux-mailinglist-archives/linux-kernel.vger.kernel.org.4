Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC976BC9C5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjCPIuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjCPIt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:49:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C99570B0;
        Thu, 16 Mar 2023 01:49:56 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G8XsKJ007399;
        Thu, 16 Mar 2023 08:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=GXUx7yh7NGDobtCVLElib0W8P4Sst3u7zGsqtqZvJiw=;
 b=UUyu7bdfaOagiAtlqSkYkFMqcsFAZ9c8kTw+i7P/aNdBy6Wrw6qsrTeZUzOv/9kpyjgy
 4Scmdca+OKB1VEEgABCwvQYBPhREMGw4gkSHsCSnUuNNzW4H2LZ8ptillUKWfulptSaM
 8i/KYicwKuziDpR9NGW4+72lPQYxqOkKMydjramz0S53ny37dUOP0ZUH75uZbogl1pV8
 gu6N6vrpOu+VjtM5ofjfx5sRxHzOv0OV25N4bGZuLDl2KaHdVBJjstmKsMURduUbE5nO
 IPnUMj7MaJunVSH0n0j3kO80IbqWwaD2aLOWkdEY58xH1KRVOfDrSuKkJBc5SapdcNfr FA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs260kcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Mar 2023 08:48:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32G6vmFf036851;
        Thu, 16 Mar 2023 08:48:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq9h7mkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Mar 2023 08:48:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuKdDJ0Nwr+d947Sy1CjGPs3tFtGE21isdAja13MF7fJ8La73FFE84WGxW+/W2DU/aT7rGen1nGlSaD3XvQ5QIuWO5i8NnmYCRBJkPiH7jg2Gn5IRd/inG0o7ELeMqYUkL5KoEQyfZ3QWJaFya13LCy8pdX974ruen1JP3TD76S9tQ9799eCVhxCCf5HLusCacL+oHgNwcEt/Lnwg60/w17EEdqNTNDAoOd6fwJZmxBMaxj7HVqk8r+IaI9MS4NQl8Y0shiIJnqs9fMVKRCiBYMv2/Y0coVX9WX7Er1MmJ9/446ieFFkk78BuWxEalSp1/TzMo/OYZdWeJwC6ur8Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXUx7yh7NGDobtCVLElib0W8P4Sst3u7zGsqtqZvJiw=;
 b=kml/j7ioIbv9sPgFKp39Tlx7EgXrljia74X9oDCtvrjhXhPKy8Td8OM5zZcv3UIvl0wWNI8hZSgUf0SnXouVc9gUxogyqfKTQ43HyvfQBLn/iqchvXP/r+7Hr96A0hvs1QQjAMqyMwtaFiG1mbMeSVjdAulTeMfXr8PvizBQcAzAsaq9ojGHtT0IWQ7X4aC8w7EDjc4wlthqx597NxSnwKrghKi3tXp9a660uLYIEl/LqazhEuHPOSx8gbZzxUAF7yIDwTO1ROoMrdkel/3B8vt0aawZpwR8xjILQJYcx+xTU1HXd/WvLOhOHeebmkBc9LyQ33ZsvYZXYhpP8+3+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXUx7yh7NGDobtCVLElib0W8P4Sst3u7zGsqtqZvJiw=;
 b=Ko8I1CE7JrVAWbFkCdgsGOtksW9n0BdtA2dK4OHXC9oJwxhVDQD/0HvpNUWdsH/Cdb9W408OZny8jZUwT4FjbaQ2NxX6dZID8kS/FCYR5wJOoFwNqxWrU2BvoM1oQB7yZStJps/mFDm9kYvLealy5rQe3i5IC/N7lMysDasHBQI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5697.namprd10.prod.outlook.com (2603:10b6:510:130::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Thu, 16 Mar
 2023 08:48:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%5]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 08:48:31 +0000
Message-ID: <ef646855-fd6b-1700-62ac-7efa9a0ad72c@oracle.com>
Date:   Thu, 16 Mar 2023 08:48:26 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RESEND v2 01/11] scsi: scsi_debug: Don't hold driver host
 struct pointer in host->hostdata[]
To:     dgilbert@interlog.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org
References: <20230313093114.1498305-1-john.g.garry@oracle.com>
 <20230313093114.1498305-2-john.g.garry@oracle.com>
 <5f8c7ee6-fade-2060-d44a-8794d2d6e505@interlog.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <5f8c7ee6-fade-2060-d44a-8794d2d6e505@interlog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0067.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5697:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1af2df-d63a-4068-0b64-08db25fb37df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G6/eHYLv3FAWcJhNht0sTHW6NCgQ6557CegduZOkJ4ybGfduQmg9sCyQX2YhFp3B7GVwttYWXPWzCvhp0MNMKBnUYJYhjdPqPJKvvvxECXAtKke5fcwHE6zqtX2jPoUp93RTxXDYyXdr80GKCI3yC5/WM2Jbs/1HftrE3/1HdYNhNh/wP8Dh1oOod0VxZMew5qfv2GEW91v9EFZoGMi+PSGE8YgkRz58qspIFb2vbNG+ZwOSkS5qeMSGVW06MR0cII+1J8jin+/JCYSIn2LqgvSXz7BzmULJZe0BxoxnLY7sXjFbk7KwMzH1CFE1YZYTMT4ehUP2mz/1SgiCR1UpaJuqKOtWXydJAe891LCA9/qpKfJP918CeHT2X97R5lhdom7CJTs+M3Okpid6cx9WaEt+jh0OjiQDV9KkJqs0i0pNI/J9/FHsIwdyyDkNT6NsKFbES4qQfsQAfjp8bYLre7b0bwGKi3xQI08gfJdnqApRXkr3aNmOYIy9rUdITJe3L2am4iSs/8ZC4Mg3IjhIr7S0rGZYIcnfrPaZZAimAumH3MIkENuVWKCzHDNoSVWIubPUmnU/F1FewWSI9SEH/rLSBoPzLp9djizcmRqd0EyA78JqCbOeQyW9ztmX4KqJBVnA/xRfok8Q0mJ4+383jAZFKUBzBmgV7gbcD7NhtIJeugop0PeFfO+bsbhK4w72g1374RqYjs2DgoxGVOs+ytL+e4HVzVJpeY2u0Y9cfTY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199018)(6486002)(83380400001)(478600001)(6666004)(2616005)(31686004)(186003)(53546011)(6506007)(6512007)(6636002)(66946007)(316002)(66476007)(36916002)(26005)(66556008)(8676002)(4326008)(41300700001)(8936002)(5660300002)(38100700002)(2906002)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3RwWVdFaTgyUytRdlFOdEJDdmpLREd5M3J0bFhiVUxNMHdKdUpXM3UxUnBS?=
 =?utf-8?B?SU1LcW5SdmUrQjRxTW9LVnp2NWJUNmNxMi85ZmVMdHhZVmE4dm1lekZ2bXZi?=
 =?utf-8?B?OVNibjlyVmw3ZUpWb2ExdDhnT3M1WTZ0Q0FvZjRveE4xYS9hcWdYN0ZWOTNL?=
 =?utf-8?B?Ty83R3AxUVJWM0xielI1YWo1TndGTC9jcEIwa0tHMzVqSDQrUTA5NjNTQ1hr?=
 =?utf-8?B?dDRQejVDbHBIUWxabjlNS0w3VjNqOWxLYkFYTExicWtuREd0QW5kckhFYUdY?=
 =?utf-8?B?TzZtM1BvMTdIcUsxT3VoN3RkcHZHZjFVVUtJdXE3OU1wZGFsK3ladFVZVmNT?=
 =?utf-8?B?R3NTYjFtL2hoeTlzc3ZtY1RmN3I0aG9FMTMvRk5uT1oyZ2dkNVVIYUx2cXJa?=
 =?utf-8?B?Sm9nanFkMTlPY2NGQmF6VEtCbnBvcW0xc0VLamNKbHYvNlRFeFp6ck0zaVNk?=
 =?utf-8?B?cmt1RGV5UGszaFA1RmMwZUY3SlZaeUVRTlhncjRKblVDcDgwb3lvalVJckRN?=
 =?utf-8?B?OXJvbHRlQTl3aVB1REdxd1lyUlpyR285Z0hpcWk1c0doVnVXQWlrZFJEVUtP?=
 =?utf-8?B?ejZ3L08zV2VaaVp3RUNaUWYzRzVNWGlPa2N5SHp5dE1UTlZ5aXVqRDlqVGxQ?=
 =?utf-8?B?d2lTdHRadFdLN2ZnY2NLdWpPZHlhSXhmak9qY2RRNjlDdWxrTHFvZG4xRXd0?=
 =?utf-8?B?NFNDZGZKVEh1TitkTnlxUG00UWFYNk9TWTlSWkdUaCttQzF0bjV5eHVWaUZm?=
 =?utf-8?B?ZFBzWHZtdVA3SmhLeHQ4aG5Zd1ZnVzhYQ3QycjFLMGpMcmx5SDJNQzN1enI4?=
 =?utf-8?B?Q0ZSMFZVcmY4amY0dEwyRnpKZ2VtS20wZ2RLU21hUWdHMnloNFowd3AxTFhN?=
 =?utf-8?B?dGEwcTFkS0NUMVlkZ1pqMWNobkczTDlGbko0YzZKRnRuQURnMllOZVdaTkFJ?=
 =?utf-8?B?SUxxNURpUWlETUFPdHRqcXJJQVFsN0htY3JMYVloSkJGRHBENkdZNmlHWFBW?=
 =?utf-8?B?WEp0MDJyTXBudHhsRGwvVEpsZEVCbkw5bGVXa05CT1drU29Pc2VXeXlTb0hV?=
 =?utf-8?B?OXloRVlsRVAwMDR6dnFLc1BrS2prcnZWT3Rnc0F5Tmkva3gvbkN1bXZISFVj?=
 =?utf-8?B?ZWNQUWJUQjNsLzBoeEtnWmtPSW0xbnNSMlpZWk9aa3A5L09SWk1yc1NiNUha?=
 =?utf-8?B?Z3VKUkI0dm01enN5MC9iZDVGU0J0aTZpeG56M2JMMkQ0RjJRcmk4RXhMbTE3?=
 =?utf-8?B?d05DaVhzVmF1TzNJemh0N01ZdlQyQ3NLZjl3eU1BOVpjOFNRNzc4Z1RrM2Y3?=
 =?utf-8?B?Uzd3eHFUMG1HenZxL0VJODF2c3A2V2VnSHpYcHE0VjVtZHdtYmhqcUtOUmxt?=
 =?utf-8?B?WHlEN1cvS0N2Wk0yY3hZY3lQSjVQYTQzUXh5REJOVGJaTU0wWnVvVVVuWjBo?=
 =?utf-8?B?K2FiaVlBQVZZeHhXTGN3enB6cUhWMWg1T29lUi9WME9HKzAySnc0S2VPZTN3?=
 =?utf-8?B?TGpsOU5FN2RiNk1IdHhMdWQ3ei9mWE1oTUNHSWF4Y1hUa3F4MUxlcXdNL0Ja?=
 =?utf-8?B?eXlLa1dNYXdoYnQwZVZjWXNhQ3FNVmhTdnR0WnpnUTl3WkRlakd3Tk8wUnVH?=
 =?utf-8?B?Uzdqa0I0dk42RTRjUVgvOGZXOVBtcTRZalQrL1JWMXVSRkpmSnplc3FHR2c5?=
 =?utf-8?B?Wm4vZmNrY2tiT2hBOUJvemF4TVowT3NOQ2NGejg5S1lNemhqT0VPTFoxeW1H?=
 =?utf-8?B?bERZRlNlQ3A2SWR4QUxTOVE2di9STVJwb3FCMkdEQnBMbXo5SDhpNkQ5Smg3?=
 =?utf-8?B?dHZpeUdRTmk3OEZsUVBKQjFlK1Rab2FrL2JZM24wSGF5bjJzL1dla1RCb0ph?=
 =?utf-8?B?VmFEYk1pWmJ5OElPcDAvOHBMcDNHOGZWTEswS2pUTkt5MDdzYlBpdWxKWk5k?=
 =?utf-8?B?UU5KMC9PdHBvSndtbFZ3dkV1SDMxZSthckZvM3lJeWRZMEdoU01FUm04bVRI?=
 =?utf-8?B?K0pQa3djZmFqeEJTNzFGQ0JrQmhQLzFuaEpqM096VE5UKzIvZGlmMThCcDBt?=
 =?utf-8?B?MnZ0NTVBb0o0eWZQcXNSVGlLbUVnNFFKTHFlNlJBMVpLN1ppbGo3WnRESzBT?=
 =?utf-8?B?TjczTi93ZldyV0pmQkorcG8rR2xuenVMaDJsczdOVXhzUk1lSXFWcEdVYUVK?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Y0lq9k9JPZ25s1BaQc8/ATCZFRtPJzf/q82P1s25hlK4HUO7YF0HVwMau1Yy6pZrAqgCXqmMsC/3f4MTAZzXrSMJ+upRgNN6zswkbeTY9EOIJGhU/LzCTs9/3Q/72P7fgZYOJbZQR8zO/k+pEARsU9lSH6JiXJHWaVUZ/0ea8c4iiJhU1QXIFEtIb95C/MyP7HC5TSDHSS0QkAwaCCs9s9j5NJX4EqTOTijxzQK0rH1skdtz/GaHugf3jDgJ4kS8M7tRw1tt3BowCpmUsidjtHbbPmTaYelJdYkG1IOJnmZwcvALOFyuMiBWY/BTqig9FAoucAPFYQIdDjoInfTVQpn9k/PE8tm6XvmafWB0RFTNiRrUN2xwHtJArYEt7jdpnbITcFslHI03uLVAaBl6dWXeVVvjJvJMCI0TTqMIq7whJxILIAEMCCYLEqHjhf/w+/cIsspmwdnXgM4mo3B/RjgQYnyXzPlqTcjRzodLoJI7XQG5nmyu+2n73RYraLrzvPrbjGR+Nsi5QEJA3oyMJ3p1ToB3yXHfu+c7zUJJaAv8013jhHjIo+BaHbLTwQsIad0cecINaXR96okMCD3TCAohtP8gUHS+gWKxgvLJaNOyW2ogenM2fagUZvktJ9sHH2Zlr7ACgHw6UTmNfXgV4kVSghS0ijm1EWdw0PZeuJX9tjBo5PWNtzjw0oKNS1F+SEJXAcqif4Jpz4gXnSnRlAFqWVHQkaMXJph0K+41fcEHriOzds/eQYF8SNWzPiLJHqgnC6+lVFiJR4l7v+2SGyTBjwSvevzRHv4ivysVi7Dew18hVBqSO9SKGXNNIXV0Ccm7m7ENR1S0RDouz2QtoMeuheGYIaYhJXnIozTqJdI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1af2df-d63a-4068-0b64-08db25fb37df
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 08:48:31.0096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1us8/dsbIIonkKIulpyn7y0NXomBLJQaK/ZREuAobPBrKqRnM+h6xyWuByPoh6jP1JIs0TnTHIsGdpIG7TxUuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_06,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303160074
X-Proofpoint-ORIG-GUID: h4Ps8cOUVdj8IqyAyfqph5SKV-UARe4T
X-Proofpoint-GUID: h4Ps8cOUVdj8IqyAyfqph5SKV-UARe4T
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 02:34, Douglas Gilbert wrote:
> 2023-03-13 05:31, John Garry wrote:
>> This driver stores just a pointer to the driver host structure in
>> host->hostdata[]. Most other drivers actually have the driver host
>> structure allocated in host->hostdata[], but this driver is different as
>> we allocate that memory separately before allocating the shost memory.
>>
>> However there is no need to allocate this memory only in host->hostdata[]
>> when we can already look up the driver host structure from 
>> shost->dma_dev,
>> so add a macro for this - shost_to_sdebug_host(). Rename to_sdebug_host()
>> -> dev_to_sdebug_host() to avoid ambiguity.
>>
>> Also remove a check for !sdbg_host in find_build_dev_info(), as this 
>> cannot
>> be true. Other similar checks will be later removed.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
> Acked-by: Douglas Gilbert <dgilbert@interlog.com>
> 
> Please apply my "ack" to the rest of this series (2 through 11).
> 

Thanks.

Hi Martin, Please let me know if you would like me to send the series 
again with Doug's tags appended.

> Good the have other eyes looking at this driver and making
> improvements.

No worries, Please check the other series which I sent when you can. I 
am not sure how to solve the issue related to the last patch there. 
Maybe a solution would be to just remove all the shosts and then re-add 
with updated can_queue.

John

