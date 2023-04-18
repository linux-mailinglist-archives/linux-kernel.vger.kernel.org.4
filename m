Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A903A6E5E95
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjDRKVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjDRKUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:20:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41D4902F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:20:13 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I9dlpE015756;
        Tue, 18 Apr 2023 10:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=L2yAxZmrXKDBlQLvIp+OKkf9NqVRUiTUa/7o5cF5e5Q=;
 b=baSkULndm8iJD4SZl3YWj6mNblxjKVpCnywP2zEDLCLp9sLr+TXhiKHySd7xYCvUDIuP
 8u5nlHJV0i22NLRXCjYpQHg4z0OQo7lqIjgXU7VwGoj0SvvaZVly2a/7bpI0x8sJWDR4
 ZWJq/bEhHcOH45Ki3dW7lr35UCTZJFb3RYVFG72/L5YqujjumyL8RBrku9ep6uMOxcns
 CvsVgKyI9ASumPoWI7wpAjGIuMhZ9x1a8Xed72iZI0pU6oWS6ccSqc7o14yDpNM4TkRU
 1u66bFcBYZAQUUPUvvBbteydi/mgoOHkcdkUWWs0sVpK1GxGXSh9Hxf8ZlaWlnEDANiF RQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjuc5bm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 10:20:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33I8LINU031988;
        Tue, 18 Apr 2023 10:19:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcbax86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 10:19:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaXRmNXMfWAMe3/jGbhbTH8alXP+8qOaX7uy5cS1DWmW/yo4fCtDDccbkKFoPDvia3HUApTodwZdEm7DGD55eTNrfQxxMkaCLyXZUXJgV4uTHHmsKhiWKOeBpoxr3m3diKqNB2Dad0F5IPp+HYin3HGQyEslYvkdXRFmYoYBfnr1BeMlpAD+KQ+ChoxGtaH1TgwckBJpvqHcu7FxCzI7sDqCiY71P5v6Zkhp9/tx7J7GX4x63VFokSBuK3iiyEkWqqBpeY4idnjIIdfHFKk9wBVaCuDNsesy0wAvIN1MX+5fOQrOqsmDeozaY3VNoqqWhCj+veU3YRGu2THEGRwYeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2yAxZmrXKDBlQLvIp+OKkf9NqVRUiTUa/7o5cF5e5Q=;
 b=jL0u+LkDE6b3oI0Cfq2nnN4o+OnqkZrgxEFCwHSFcxRjXeECQ7xcWvsOlMMDa6iSfijGdOAU/w4nZkCdxVrkqUjPAgCZ4DLPftSesP2oqoHH3KvVnL3wlsjUZH5VSKVpsdbTgYjn/Z+7HAppzAD7AXIb+rE2PudFIV/5RbjgwUwdI8idZYj6S/x71BMlPIvp8VMz0fDlJVvhnCubWwhjehOilC/oWplLpKJLj5K3COyRUahQGs8mLKEB7vsNWMljw//FxUUUHfuOQIhmxYHD78a5GXbTAxxrKWt3vFSzIh9YbLqSxTeppjZGGxwMUU5JdW8GOFwnKu4lgQpLYbqk/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2yAxZmrXKDBlQLvIp+OKkf9NqVRUiTUa/7o5cF5e5Q=;
 b=bq/82f7fDrejH97koPbuRU1vlX49DjUCy2YGwOPmJmyzDzvlqMmDsoOw1reyq2Xg3tTqujLDrh2oUN8Q26iuFgVRhSWYXP8FdzD59N4D/BOej/tVrunaaX1T6lbdsNT1JIGGDDCzQNLNNnu+417e4bsq/ioMcidrMa6G4nSvFcs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB6071.namprd10.prod.outlook.com (2603:10b6:930:39::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 10:19:56 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%6]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 10:19:56 +0000
Message-ID: <6b14b2a0-cf1c-fbfb-5028-d7a6974ef39f@oracle.com>
Date:   Tue, 18 Apr 2023 11:19:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4] iommu: Optimise PCI SAC address trick
To:     Vasant Hegde <vasant.hegde@amd.com>,
        Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>
References: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
 <21e49cd7-ee15-5ebd-7805-37d5f347635f@amd.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <21e49cd7-ee15-5ebd-7805-37d5f347635f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0071.eurprd07.prod.outlook.com
 (2603:10a6:207:4::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a7ec14-b4b0-4ba6-21ac-08db3ff67557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0rsl1D1lKzROAnp6mH3ZYnia/4ic1Z3aCeOGWCSeFJTyMV+cqBfQXn3czdXfnkop2CKjRehT5yEc572qK7iI/KTYz5ac8T1MTYW+VOwaqDMgvfItNWZ0wrsoT1x80BGs/RFvIEkxx2ttGDv4KTE1wjIsVi3S+vPDcq65jBTzRCikOjQDJUm+f8DIaO7Uv/kdt9KkPIQ38vKutM4ILc4aZDWlXAe/RgYX3Rg198qYTtVLasJ/4fDlduaY9n/ECVuD+wZx37uHbuveGImFi5xHwEt+6riQWh9um+ApRB2U7d6qI8h5lxU4DQloNrkBybIteUXVMQNhVHPQwYOfP9H9NsUckY0pVSzKxwII94Y1RrBe+o0kmK4XcuKHFOIz5XgrRsAMXJuF5qYOf73EXzxV+DkKAwg14as+18Ehy0udvLdrzNthOAYJ3qD2PlHWuNdphg2/FFd6vAIX0pwUaE+jOaBrkx3IQRhdew6n7DXryvA1tIO5Fa7zS3Tqo3AQIq3OZfjl9FGh/y7OMuTnLUbFkgtmzZMYIcHB3GuBr/CFPdgnmFQNp4A3hDTUi0PY53+JZYp5dsP3OpxIIPUkqubZrhuStWNZ2CdwHFTwHnk474OhJnwlfRPEQGkXltuvCuvox8iMWYfNQyc+9fHBHJow+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(39860400002)(396003)(136003)(451199021)(2616005)(31686004)(38100700002)(6486002)(36916002)(6666004)(83380400001)(6512007)(6506007)(53546011)(186003)(26005)(478600001)(54906003)(110136005)(41300700001)(4326008)(66476007)(66946007)(66556008)(316002)(5660300002)(31696002)(86362001)(2906002)(36756003)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEdTM3hMNWs4R2FCM0dXZENISDlRdm1SWmhMSWJBclBUaHFUaThIMWIxY0pH?=
 =?utf-8?B?WkNWeG5Rc1pLeDRhS2NCa1I2dElMU2dWcVh5S01PUmtrQWovbnQvSDV0dUZC?=
 =?utf-8?B?UDlMMnh3M1VNeW1Ba0tYRXh0eXo4MHdGdFRSM3g3TG5ORktwbElDQUR4SUZt?=
 =?utf-8?B?aHM3UzFQVGJlVjhKRWJwZnVFZUxQVUpOOGtOMDRpd3dOYlZBdFRqMjJrSjQ3?=
 =?utf-8?B?VVd4aFUrVTd3RExlNzcxQk4wTGRnbm5obUhRYVRMR1BRa25BQVpDc3VlUHVz?=
 =?utf-8?B?eVZpaDZ2bjNEb2IxMDN5V2EwTmZxNFFwd0IyS1Z0WGFaMTRody80WS9OdHo0?=
 =?utf-8?B?RXpJRDZxQzR2VTAvamFwTG1iaW1ycVNuRFdSMnlvWGxmOHV0ckRQWG5WMmVS?=
 =?utf-8?B?TmpKd3FRU1NQRTZTYS9aQkZOZjZQZkR3ckdDTFROWWRXZWVyb1d3R3FmQVpl?=
 =?utf-8?B?WUN0VS9kUGt4OUZUeXN0VUJETUc5KzNXWk4xQ0NOaHVqL1E1N28vaGhNQ2Iz?=
 =?utf-8?B?VzhPc2MwOUpFdGd2NGVZQkdGYlFINUg0NFl1UmJBWmRhYmp5WXZ1bVJkb0tm?=
 =?utf-8?B?OTZCN0JaTC9VUkNCbFVGL2xyQ2QvZFA2ZGtEZ0MzMUszdmpxNDhRYWNhcTVh?=
 =?utf-8?B?c2JXUDRzcmJOa1FJbUJCQ3ZaNFVJZ04wdXdaWjc3cEhxWTBaRmdEbDR4RUtJ?=
 =?utf-8?B?S3dVY0RLbXlOUTNNa3hxeFlUODZQck1nUFUrZ09qckdvV1VPUDBoSmJtQk9T?=
 =?utf-8?B?cVNrT1ZEVEkxZ2xHTCt3dVM4ZTlSOERYVFVad09RMDRoMGxraVJxWU0yRHBp?=
 =?utf-8?B?ZGV2a3o2Z0p5b3A5NmlLYUl4d2NTZzhONUxLSUhKRmg2b2drM3RISDFRMGRj?=
 =?utf-8?B?MkhKYjNBSmI4Z0txMmpGYmVwcXcrV3lmRlQvdVdRb2M3bm1uNFd1c3JRUERR?=
 =?utf-8?B?Q21pa1E2NmcvK3NqcldyUGtEbUR1T01CTjRTUVl6VURRcXpZUkd4VlJseGVs?=
 =?utf-8?B?ZG5tbk9YenRUUWNFcTUvWlI4bHdLNWVUdlFDL3JWbythUXB5cWR5SHlhclBy?=
 =?utf-8?B?NVdJQ1ZZWDhnL1VtNkZ6RytMcUdZOFBwenppdzBNSVFlQjNFZFo2NlRHS0pW?=
 =?utf-8?B?b1pEaEcxaGkyaXJNTGpsUmNwM25weVRWZUZOT1RBUmFTcnFnajdNYnNibXVS?=
 =?utf-8?B?eGRHMkdOMXBZQS82OW93UW1YVWo4UXBCZ3J6TVJLSzZ3S1hSYWRlRzFRVG5m?=
 =?utf-8?B?K0svTDVNM3l4ZnFGNW9xYnpxQzQrV3BNa2lWcmJ6UjZlb1RwQVllVEt4VlVF?=
 =?utf-8?B?bDRCYlZBWlhycmFVZE1HbDlkL0x2QlV6NElQckE0S2NaRkVZWDRjekdvNzJr?=
 =?utf-8?B?OW5jbUZzNlcyaGRJcUFhdzNGNkRuVncrNHlUNmtuQXQyYVRrS3pmVitKSkdl?=
 =?utf-8?B?dTgyUFplS3ZpVUVSM0FRaUQ5Y0FCOWpnWkV5eEZEd0ZWQ1RPTGlvcmpDdyt3?=
 =?utf-8?B?U1duWU9OY0p0WVRUbE5FazA1UlpaVk1RU3MvdFZMdGdQQkNITnZWQVZtZUMy?=
 =?utf-8?B?cFMzMmhTbWc3RjE4T3FUN0dPSnFPU3VMb0Q1Y1dzSU5pSHdlZVRVNUZVdHlM?=
 =?utf-8?B?R3VtUTRkdElidDZDcUVRL2swb2RrVTBERHlpT0F5K0UrVXJCajNiazhobDM0?=
 =?utf-8?B?VnhDaWIvb3lUTXgyZFJVVWpPOFJFcXN2Z1E4UUhHam1pRzNFSTc2dkd2S2hU?=
 =?utf-8?B?aXA4QlZ6MEtyMFpBeTNBSWpnU2lFOE5QdVovZkgycUsrMkFIMEloY2kzRUNF?=
 =?utf-8?B?UnB5UVMwd2NmR2F3cUxoYU53OWNhaTEvK1R2U1pvYW8vWFFuMVpUK2J6UWE2?=
 =?utf-8?B?ZDVPT1ZKeElxNTVMY2VhZGtrVUhLYmhzL0UvYStFeHB4UFRPWERZNW9CMXZS?=
 =?utf-8?B?WkdncldObUt3Yzh6eTNZYVJmSXpqc2VoVWorTFRqZEJPbGhHUVhQeHprWldS?=
 =?utf-8?B?ZnhaZEIrNFJ0SWJpbkMrRTErd3BLNG5wTXlOM2ZsWnhFT1A3R0xUQXlJbFJw?=
 =?utf-8?B?MWRGZm9mY2xoWmY4MlYxc0tsSWZndzM5QmVZWjhGMWhLdzdzRTdPbC9tMzhn?=
 =?utf-8?Q?KyPml+Piip5Q1MQmLn1YdjB81?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UDVkRWRxMDVkQmlhZDFmTzlINUlTRGdndDAvZllsSlFuNTRzQmovU3FoWXJ6?=
 =?utf-8?B?d25kVmFnUDdiQXRiUE5yZnFSbCtIS0dZNjlpUFJuQkhaK2lVOTVNKzl2aXFw?=
 =?utf-8?B?MWJSRUR1aTE2ZGljeUFBZnpNam9yOUhVZGlzM0V3dW9UVjBOdnc1dVVDUHdt?=
 =?utf-8?B?ZW1NbXdmWGFTcDkxQi9sekVPUzBtRUlpeVR1dUZkVjBxWm9iS0NzSW55a2kx?=
 =?utf-8?B?RmU1elFjN1Y3cVd2SHl0aXhUblpDS0JXeDNlZUNJR3p5U2F6dmJVbjJYREFr?=
 =?utf-8?B?NzMxWjEzSjc2bG55RVA3QlBUV2lVL0plblI0Q2JKUEVuSXpGa0VYNktQcU05?=
 =?utf-8?B?K1E4MC9vWHljMEdlYnBvVE85VXozMnc1bjNhZ0JrVGFlUVdLd0g3K2FkWm1R?=
 =?utf-8?B?UzE4ektpREhYZlZBU0luTkMvWGJWN0Vhd2RHL1RwTzdTTmExYWZXWENyR2sz?=
 =?utf-8?B?TWZRNndjZ29lNTdlN2NnVlVGNXFrRGQzU3cwdjd1eFhzN1U5OE1FOVZ0d3Nt?=
 =?utf-8?B?L0NEVkxOdEpzUUo0NkhiRWZaU1NOUmxxWWwyRThvTm1jeUpVUFpHbTgwKzBp?=
 =?utf-8?B?MmFyVTJML3VuYzQ2eGg0NkpReW0rMWxpTmpwVC9KTDlQSWh6OVlHeGZGOEw4?=
 =?utf-8?B?UGtWc28rUEd6SzYvektGL0FUbE1hRkMzU05CUVpNK1l5M05ZNHV3VW5tbHdH?=
 =?utf-8?B?cVkyWDAzbE9ERmVhbXFPUTdBaCtkNksya01CS012cmExVHVmZ25qN3dBNGQ4?=
 =?utf-8?B?UEdqdWlOYlVQa3RrVE9EckdvdWUzVTRibnVrdGdiMmo5L3Q3ODVIeXJ4LzJ4?=
 =?utf-8?B?c2E0M0tSRkJOc3pWVFR6RHFYUEpjVnYrZjI2Ly85VFg3QkRoV3NuVDVpc3F6?=
 =?utf-8?B?dEQyYm80TkhQYVlrS2hud3JmMjBoNFMwSXpWVDVQT1VuM3ZXdkRHQm43VE1Z?=
 =?utf-8?B?WXIxQmd0MCtHb0JQOHFNNHFWZlNCaUZjVGdnRlJoN2k1TDNZNVdTTzd5V0la?=
 =?utf-8?B?SDgzVEcrR1dqckJ3d29uV3NtZWtKQjdXMTJjZEFYbWdzdHN5ei8yUjE2VlFE?=
 =?utf-8?B?a05zSkhqK0ZFSlc2MEZXb1hpNHNjRDJSRHRXVnNtRDlwUGxtTHdxNzdKQzNI?=
 =?utf-8?B?bmNMeUtnbmIrOVBjSVY3aHZoSTE1QXkvV2lkbWJ6WEcyTCsvdlNGS1ZuYS94?=
 =?utf-8?B?WlRrUGNGUlI3NFd0M29nOUt1akgwdnRMUE5yaWZkY0FiNmhOWnI1bmJGcmI5?=
 =?utf-8?B?ZkJaRmVJWG82OGVETTFpSklYcVhPc09kck9VMTZWVmMyMjFEdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a7ec14-b4b0-4ba6-21ac-08db3ff67557
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 10:19:56.8325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x73VDPhxWphDLYStvd0W4I2XwgzupsuNtoBr556zBLrmQrOcqvCLh4MfGgoSMjCLHNLWiZtrHDD0NiRVtgTKDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6071
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_06,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=982 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304180089
X-Proofpoint-GUID: lwJ3xBwUsPHU8vslc3PiXLgSJ0yVLS9R
X-Proofpoint-ORIG-GUID: lwJ3xBwUsPHU8vslc3PiXLgSJ0yVLS9R
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 10:23, Vasant Hegde wrote:
> [  172.017120] nvme 0000:41:00.0: Using 64-bit DMA addresses
> [  172.022955] nvme 0000:41:00.0: Using 64-bit DMA addresses
> [  172.028720] nvme 0000:41:00.0: Using 64-bit DMA addresses
> [  172.031815] nvme 0000:41:00.0: Using 64-bit DMA addresses
> [  172.031816] nvme 0000:41:00.0: Using 64-bit DMA addresses
> [  172.038727] nvme 0000:41:00.0: Using 64-bit DMA addresses
> [  172.038726] nvme 0000:41:00.0: Using 64-bit DMA addresses
> [  172.038917] nvme 0000:41:00.0: Using 64-bit DMA addresses
> [  172.038968] nvme 0000:41:00.0: Using 64-bit DMA addresses
> [  172.038970] nvme 0000:41:00.0: Using 64-bit DMA addresses
> [  172.039007] nvme 0000:41:00.0: Using 64-bit DMA addresses
> [  172.039091] nvme 0000:41:00.0: Using 64-bit DMA addresses
> [  172.039102] nvme 0000:41:00.0: Using 64-bit DMA addresses
> 
> Otherwise patch worked fine for us.

Hi Vasant,

JFYI, Since you are using NVMe, you could also alternatively try 
something like which I did for some SCSI storage controller drivers to 
limit the request_queue max_sectors soft limit, like:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2730b116dc6..0a99c9a629c9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1814,6 +1814,8 @@ static void nvme_set_queue_limits(struct nvme_ctrl 
*ctrl,

	max_segments = min_not_zero(max_segments, ctrl->max_segments);
	blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
	q->limits.max_sectors = min(q->limits.max_hw_sectors,
+ 		(unsigned int)dma_opt_mapping_size(ctrl->dev));
	blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
        }
        blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
lines 1-25/25 (END)

dma_opt_mapping_size() will return the max IOVA caching size for iommu 
dma ops, so this would mean that we avoid alloc'ing and free'ing IOVAs
at such a high rate (which I assume was your problem).

Thanks,
John
