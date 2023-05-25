Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6337110B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbjEYQQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbjEYQQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:16:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D5513A
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:16:18 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PGEmir014582;
        Thu, 25 May 2023 16:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ARNoLPoIjfM/DOJDof3UYUbB7RYzkCl76w7KaTk5EMI=;
 b=iD6iRvR84Qy48uiPdSfzPF3uhiPL4iawbKjmCbN0gXYLEGTqSntPXxf2D1c+Cruc52KB
 fjM9MjFRZyKql0GVcol0mb0IEbOcpGKBP7bpEP4YrBe1zmL0NRDU8NZgNwGguw7zmQBN
 SBmBl/q8BT2ftyBZO+Oeaj0hpP0wsy4UmGwBV+p2lM/dV2yclXLXx+zysqT0pLtSp1il
 qojK60xms4ndnFh3NRz2n2gkkOmFa6cY02uHFuXoDgexYC1No5hgGeQPlkvMBF3u1rKm
 kD3s8mSazgsNtFTnK4gudvK4uZkw7wGuRIxlB7DzwesDsWRs6lz/RbAoKj6JBi//GUyM 0A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qtb0yr07w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 16:16:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34PG6tZN028591;
        Thu, 25 May 2023 16:16:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2u2ycr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 16:16:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9upnkLryuGERrjps84sQbRabMh9Qvorea5zgX6Zp0tNT5n9VD6hpLZKwdOUlgiKZPrd36FXrlVHdxe2JdxA5y5ycRVQKnEdwYg6CPttrM98TSx8wn5wC2n9hR4Ogdn+IQEaAaL1MPafl0PkWgTMonhz+EhjlTFAk6IJH6WoggC5iZs+UG5LkA0/RlDrjyM9bxqssqLUUvQtj4YUvJoe6uWcYQ39Shvs+VOItXndsM+qNY9lsvt34WvSdD7yn4Jmg0JDL8WVzlhbDWxVY/PaGDXgn+M/E5Ej0mInqSfrCC0hWYX5evJUCwrul4sOUbHnhbr70D0F27rCO9AhazEmOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARNoLPoIjfM/DOJDof3UYUbB7RYzkCl76w7KaTk5EMI=;
 b=Wr7yIl63TOc30I90JVdI3C8+BwS+1mUHpuU5YUsWqjY2g+e6065dn0zB1OvXEhMWziraOYs1V7GgpCstUP3MVrPv8W6NC8F4/t5RWaCD35h2p4tVpmKcoEWgdh4+jNqzt3O1hhtGJ2GPmFneePYB3zoSuV1/neT1Fs091sHVzZYHW/Tqec5bvMlhaA6VlJvsBSGa+TXC8BX+4ElPJsc/DSQgwbz/oF4GCFjHDe6eM45hpdTag8/hqOidCC0huoeXE/aht5aJzHq3BXqMNGnvGEaRKXHxqJKr6MZDBIGDu3BH1sOxg0Fhl08CSIWw86p/p8usiyC4b75i3rcqVRvhhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARNoLPoIjfM/DOJDof3UYUbB7RYzkCl76w7KaTk5EMI=;
 b=Fe8XngqAlVDNsjUGGccemQ5IpYVxt7xz2HjSjNVw3y1oau3Cp2ytSNW3W3B7cYI/9sCUYrHcsNoQ8M8fi9Tn+t330sZzX2y8me8SQ8UNEqliXk5DDJBohK6EhKcf/sYJGr9eJNJgYsBM6HZPiH5Euz6pn/WaY/3Kvuc0hrrGKio=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by MW4PR10MB6680.namprd10.prod.outlook.com (2603:10b6:303:21a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Thu, 25 May
 2023 16:16:01 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 16:16:01 +0000
Message-ID: <c6e9a5db-798f-fa40-5ae2-a41f2d8ebab5@oracle.com>
Date:   Thu, 25 May 2023 11:15:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com> <20230523121506.GA6562@redhat.com>
Content-Language: en-US
In-Reply-To: <20230523121506.GA6562@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::21) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|MW4PR10MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 7607cf88-57ce-45f2-d160-08db5d3b54fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hMO79hhNgU2dy8H5IhvnuVw7KUWj7MAOgITPAOUxN0RjFckS66jaoxlA3JGI3rVGeUTqr7LnH3CtsjMhzFtoTrJagdwTvkwU01Yi/COE3C6YxvsQbt+R/x69OyVVHbWvqsEBWhLe/7o5IS4Wp6YJvTlf3HMzsC2Tm+o6FZTH6imJN4aIX1cs+PgnwwrGUcQFtA9bR25XyRfflrSZ4WXd0fXuNM+hjzTMUjnzb7v+Ve4NC/vZoAUMxFrc8B7SP3ii29HmXSzfcDhzAtw8dgwCJC8vDaVc5RTPa/SrBGGlYQAdcSTxlJirw9HX0tJQ1sjB1Z2zGor1aR4Ia9gsqT7ni3+Qxw+9Bv/ZO+csz9eAcoJuxoP+xMhDeXioEsgrBGRYmK5jj46XR6rRymkxGa1W/7y2+JNt1ng7f3p6J65JnSTBbzPF5SULS+c+ABACPF5HH0L9S287toJRaPpyyE+HdGSlTRykwo15kohlXeFODLrW0JQpMiFb+Q3+PP3XICl05GcsNgFHuJQUYPd/AS4zDdZwbNmDz0Zrl+PHSvkATKmILk2wE1EjPZF0+RBvXHk1b2G6SYxb4PA3JcHKo7niGSXcfVpZ7yixa5FR2B1eeY3R5Lq+eABHAxk+hhDlfXqj/uTbK9PvRDtR2Mf9MpgDRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(66476007)(66556008)(66946007)(83380400001)(478600001)(53546011)(6506007)(6512007)(26005)(6916009)(31686004)(4326008)(316002)(6486002)(41300700001)(2906002)(186003)(31696002)(36756003)(38100700002)(7416002)(86362001)(5660300002)(8676002)(2616005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bExnUTFZSE5va1NkTzlvUXJKbkJFNkxlR0JUMUVWS2RqZTR2dG9Uay9nbEJo?=
 =?utf-8?B?aFF2TExRMjBLcUxTbG5FNVplYWF0enQ3VFBzQ056Z0dBL0JHQ3hSWmxFeTM0?=
 =?utf-8?B?MzAya1FYUXM3QnFCQ2xmWXB4MVNRdmJRSzN5dDQ1Sm5YRHd3a2l4RW52eG4w?=
 =?utf-8?B?ZXQ5SXFkcVBzLzdKaFZTaVdVak5WUmpwajdMVlN0UTJPZlJYcGpKVFhsNmlz?=
 =?utf-8?B?VC9zOTM2MXcxMXZqWGZOaUE5VVdqOUcrcUVTUlVpS3VncTVjUkRWSGJGN3hW?=
 =?utf-8?B?WjBOK1BSYklKUzhxbkNmVFllMjRUS1l2WEoxeUNpbzBEM0luUllIU0xoemFz?=
 =?utf-8?B?enZ1Ylh0bHF0SCtkaHRONFJzbXJVYm1kaU95bkNkNXdOblBvR3EvQjRNNEpw?=
 =?utf-8?B?SG5kYWE2bzJ4bllSeDhkVlc5eS9nK1AvbW16WG9VV3lzQmUrMDVTY3N1WnZa?=
 =?utf-8?B?WWpTb2h0VGlvRFdaQ3dtSldXZGdvOVlCcUpkRWxDZ2pPc0grR2tNM2xvRGhm?=
 =?utf-8?B?cjNENE9CU1ZiaXUvcXpsK3dBL005UEd6bE5aRDBXUXNzd3YwRFpOaUpLd09I?=
 =?utf-8?B?Y3BJdmgvNEpKNER3bzY2LyszWEdFSHVVcDNCNi9iNWwvYUJMaFBKWWkvRkVN?=
 =?utf-8?B?a3lKUXBDdFRZMDJzZUNsTU9qNGptRU9ReTBVU2JtcG1ydzVZdjVObExkb213?=
 =?utf-8?B?cHFNRHRsbDZhQXUvS25iTTdQMlplUnpXaU5nSXN2UmRkczB1QXdMOEw2T0p1?=
 =?utf-8?B?VDVGMEMrdlE0dktjYVpKT25leC9UVUx1djRvdnJlUENmTmFNYzJoZTA4NlJW?=
 =?utf-8?B?b1JOSW56L25TTEY2cEdWTW1LaURDY3VXbHhuTmlIMTNOR0pydTY3bDc3SXNk?=
 =?utf-8?B?SzYyVmYvbW9DS0tCNGwwM2lTR1Zxb0ZyaTJoNFhLWFRicGxjN21Ld2FhNVIx?=
 =?utf-8?B?NWhvdVZoTS9WU3FDdWJITzJPZ0Z5aDRCeGZWN0J2SFhVNFpuY2NoV0svSFFT?=
 =?utf-8?B?ekU4ZEhSUG8xd0h0endZeGpzRnhpbFpwSzRvRjlaVDMzcFJsSmpRSlN0ME92?=
 =?utf-8?B?Q0VoTTF5YzREYWE2cmYzUFJuOXpwcFRhZGtFWStiSllPVFR0ZEx2dTJZc1V0?=
 =?utf-8?B?TGFkL0xjdkd1dmtsS2t5L1AxcGs2L2tzbEJMNFQ0QTdlWnFpSS8wMWVBV0g2?=
 =?utf-8?B?NEpUSWxhVEFweDZaRVdjNGVHdWhMQXNwbHRLcXp6TUZDUlBEYmcyRzcwR0M1?=
 =?utf-8?B?ajhsckV3TmpiSzIreStFMElXbDRpRU85a3ppRmZCSk5SSHliTUNkM0YzZU1r?=
 =?utf-8?B?cStva2tMSXQ5ajcxK3dOb2c3SnFJaWREeHR3anZZdnVMcTdNVFFHdXpYTEJP?=
 =?utf-8?B?MnRtUVdnM0k4VlJIWG14TzRUWWpQRkVJV2UwOG5GbytCK1BpK2w0dzJpemw1?=
 =?utf-8?B?bnd0QlRxdXdJMy9PVm1uSy9CL3lEL1JldFhHUlhuNUZlT0JzTWJtU0dKNkVk?=
 =?utf-8?B?Ny8wcFFnZHBqT0lEUXdudFRSR1hGb3NkUFdreFdVT0V1RlFHRnpvbjYvNWor?=
 =?utf-8?B?YUFOQ2FyeWw2K2s0YzZKTzZXZ0kxaWVaR0hkaiswOHRtYzd1SnFuajNCU3Ir?=
 =?utf-8?B?TWw2RTJFazEyakZld2RpYW1KbS9lWFJvdjIwaXlYbDg3L2VQQlhuOUdTNWZa?=
 =?utf-8?B?cHg5eDMrbDJkMlgyS0F0MHIrQ3pibEwybkFRQnpuaVUzcFp3NlMvVk5qLzhy?=
 =?utf-8?B?aGZBeFNRR05mckpFTGJoK3RDWjU1dVUrUllNZ2hSc1kwNDJzM2ZFTlN4SC9R?=
 =?utf-8?B?MGwrZ3d3Q2hxMEFqaU84TXdNanJGZTVsaTdxVCt4eXNFQ1FZZEtReGFtTHlq?=
 =?utf-8?B?SVIrMnE1dXUvSFVHdzhmVjFkVHdtTVlGazI0Y0xTVkdtREptMVJFYnZsWmJ2?=
 =?utf-8?B?UURidEUrc3hvYVJlRTRRUzRGWG9kc3hocDd2TW9sTzlMT3ZaTFpzOHpTZy9y?=
 =?utf-8?B?bTVyMmFpUjdub2N0R0toc2s4WVdGNkdzS2UvNVlyOUZoWHZ4aTBpZFY4cUVU?=
 =?utf-8?B?aGM5U2ZqazNUdWwvcHJqSVRXWmtFWjI3Uk1WdE02VzR2VnV0OTVWbGhnaWRl?=
 =?utf-8?B?SGlqdllBK3JVOFhEdmxneEZ5OXZXaUFiU1ZxWVZMM2ovSXJubzZkMERKUFlD?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?T0tmeW9PajJpb0tuZTJ4NDZSUm0rV0lnN2F5eTVOeEpib0lLa3dNWmorRDFE?=
 =?utf-8?B?N0hWQnJpWmFKL1VKRjRrZkUxR3RFTHQ2MWg1RVFoMFdnNXV6ek1WUDhxVkVa?=
 =?utf-8?B?VmJNWWxqeHRpMllZQ0oxTVk2Z01EL2pJTktadWFEMGs5NzJFRDRQTDI5ZzNI?=
 =?utf-8?B?d1o0V2RwQ2lyRkpVc3FzMk1UbjdUNlh5VU9jUkZiNTRvNkE0ZGdzZS9uMUg5?=
 =?utf-8?B?VURtUTlDdW9objNXV1h1SWZ3T0kvaENjZDJBTmc5SWdXSm1ycytMSm9FWDlj?=
 =?utf-8?B?bTdkMUFWaFFGVlBidHYxNk15YVN6TjNTTkZOOTkrZnFiaXBkdlQzcFhlc1Bt?=
 =?utf-8?B?Zi9HS1R6WlpFQUhuZ2JJL3VXcWJXa2dPbjFpaldaZDFxekM5eHd0a0w4aVlt?=
 =?utf-8?B?bVArN0pLdlI1S0R6djR2Ukl2UDlSQXI5UTBud3ovajNOYzIwTm51S0dEY3d2?=
 =?utf-8?B?TkY1MHBFSDZBOHdNZmlQQ2hiZkEvbzYvdjVEdDR4dnNGME1pcjhaalcva0Ru?=
 =?utf-8?B?RUMrdXQwS09CRGJJZVh0RFBuc2xPaHZDdlduL3FEdDk4Qm1NQy9SSGlhWHZp?=
 =?utf-8?B?c2VQMzdha3ExMm1jTnN6YTlSeWUwYmRmeWZ5U2xpK0djbEh1bno4U3Y2eDdJ?=
 =?utf-8?B?V0RFVkcxd2dVWGhQdDBIdnR4UWVULzBIMDZUa2ZFNnFoaFA1eUhVZlozTXFt?=
 =?utf-8?B?T1lOV1ZFMSsyQlVqVHFmNHBWdUhFY1h6ekhqbkl2NS9yakhFd1dsazdjV0tN?=
 =?utf-8?B?OThHRDcxRlJ4R3M1cWUwU0JiNjQ3MjlLTlVpajJXTGVadE1WUDBZNjAySDU1?=
 =?utf-8?B?V3B4Wkxya3NPTy9ocXNNMnFoNDQyMTg5QmtSYy84clRidUVTODVqZXZxNUNr?=
 =?utf-8?B?Nm1JVWgzZFcraGZHTlFuN3ZWaE1tWkhBOTQwanc0YUUxNjJXTTVHR2VJdzZO?=
 =?utf-8?B?WkthTjVmUDEzZWVBOWMycE5QMXN5NlR6ZExQZXVkNUJhWjZoS1puZFBvekhm?=
 =?utf-8?B?bndreFBtN050T3FEbGhNd3hhNVhwcXpBalphWDh2Q3FhbDUySXpmcTdSUTli?=
 =?utf-8?B?and6dXFpU1U0bjR2MW11Zm9JRk5GbTA4UHVqUnJYNCsxdEVaZkE3ZmpuVjZ5?=
 =?utf-8?B?YTZWRkFSSHVtYlRaMURySE9JdFVCcDROY3dLVmtqWW1XTUJWTkZ4cmZRaVlB?=
 =?utf-8?B?RVJsODJTZG9aWHY0enlobmd1TEpjU2xHdnhWMTM4WGpxbXAyZFgrTi83eTcy?=
 =?utf-8?B?ZU9GNWhaSHlvOXo5K2d6YXN6cFdhT0FjMmwxQ09sY1VMT3RUVmRUUm9uWmdU?=
 =?utf-8?B?YTFHNzlLb0dQSE9QZ290MGtIT3JsRXZyazB1RTBhVUNHNFMzNHo5S3l3eFZ5?=
 =?utf-8?B?TzFvbjhySGNEQUxKUWdrbHBKSnVFMDFsOXhzSkFicklJcGRZSEpGbU9oTnp6?=
 =?utf-8?Q?6sBm/xdT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7607cf88-57ce-45f2-d160-08db5d3b54fd
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 16:16:01.6126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsYE6+zQXFN0r2KUvVFC3DqvbDEzoGOeCkL/nVM9dJ8g+GksEybKBdfUHCetX86zQoQMRoBOAwEercrNiUY9RICYgH8cY4MJH6eAkRZuvco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_09,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=806 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305250134
X-Proofpoint-ORIG-GUID: lqjMPB4dUQTywigd_Ap5yligxHQe-nxP
X-Proofpoint-GUID: lqjMPB4dUQTywigd_Ap5yligxHQe-nxP
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/23 7:15 AM, Oleg Nesterov wrote:
> 
> Now the main question. Whatever we do, SIGKILL/SIGSTOP/etc can come right
> before we call work->fn(). Is it "safe" to run this callback with
> signal_pending() or fatal_signal_pending() ?

The questions before this one I'll leave for the core vhost devs since
they know best.

For this question and the one below, when we get SIGKILL we think it's ok
to fail the operation as in it's ok to not execute it like normal (send
it down to the net/target/scsi/block layers for execution). However, we
need to do some processing of the work to release mem, refcounts, etc.

For example we use the vhost_task to handle completions from the layers
we interact with. So when we get a SIGKILL, we could have N commands in
the target/block/scsi/nvme layers below the vhost layer. When those
complete, the current code assumes we have the vhost_task to handle the
responses. So for pending works on that work_list, we can pretty easily
kill them. However, we don't have a way to kill those outstanding
requests to some other layer, so we have to wait and handle them
somewhere.

If you are saying that once we get SIGKILL then we just can't use the
task anymore and we have to drop down to workqueue/kthread or change up
the completion paths so they can execute in the context they are completed
from by lower levels, then I can code this. On the vhost side, it's just
really ugly vs the code we have now that used to use kthreads (or in
6.4-rc looks like a process) so we couldn't get signals and just had the
one code path that removes us.

From the vhost point of view signals are not useful to us and it's just
adding complexity for something that I don't think is useful to users.
However after discussing this with guys for a week and going over the
signal code, I can see your point of views where you guys are thinking its
ugly for the signal code to try and support what we want :)



> 
> 
> Finally. I never looked into drivers/vhost/ before so I don't understand
> this code at all, but let me ask anyway... Can we change vhost_dev_flush()
> to run the pending callbacks rather than wait for vhost_worker() ?
> I guess we can't, ->mm won't be correct, but can you confirm?
> 
> Oleg.
> 

