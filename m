Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5994B704425
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 05:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjEPDxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 23:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjEPDxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 23:53:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485EA30F8
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 20:53:46 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FJsVSn010018;
        Tue, 16 May 2023 03:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=WQZ8QkL7ApO8QSX/9yaKpjSB6WSp2o/f2WMpizH+KFY=;
 b=0Ii0lMHv8VrmA2RD92h8d6MyA54TQIF3CzhrVmw2NjEoM8HK9PQlJERbRCA6IsYgVi5m
 Yr7EPMWT3iijBHMiNG0Ja7fT7nPPNDDR2Ju6epjchbAGiEukUP3dinpUiXQwpwfGPNtI
 zXTTli2pu2xEBf++nU8fbJSYdRRbgYS8ra1rTVKHqEfKQTWu9hVrgW4Z+T2kQra/YfKO
 UpjlZ0iNbcioid+YDMFEJYNIUmuVXWsHz7fP2yH1Mt/hQKZ7qsNMi1DAGJsArfjC25O/
 XDhxA1PcqDYLZl2CEfiP8uLn/opRXaTaoLp+ANnSEoROqCLFW9DX2NTrKl8mSC1Mzk2X vA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2eb1ek3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 03:53:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34G1amMf038917;
        Tue, 16 May 2023 03:53:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj109gb4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 03:53:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKpdjXvEwab0SL9SIc0xo9H0WSINBnHa/cTlB/Iww36HtpPuZMlvFGO0CMF8wx2PcOd7AYHeZopCmdk1et8QhljP89Hk2/X3wFOYz+BSCCYeNJXZViOefdwpZ5rGgwLti6cRwc6V0yfB0tr5A2KcS+QAs8vJ8lPhlQBCcB9hMAZHXlxG1gJfyiiR53WbPzuJBeIhyZFwhpeo1Evtj9eYFzcKD994QLQAksio2MW3Re7R0vfjy341WYqTRDFHLqWGYNlf01a5FFUlqhClkCbmrIJRoYspGqx5Bkkj3cJxQSKMoZkxvleHa2MmtOqlhdeqhWPo3nvjm9dWLVSzdut/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQZ8QkL7ApO8QSX/9yaKpjSB6WSp2o/f2WMpizH+KFY=;
 b=jg4T2O1XMhe96dbgooNQB68+ulLE1VUTOfr/mRWepX+djG6Xpg+J+jgkOhBkzRNT6j5ZzP69WCXCzWzKMj3oUekbD6drgPCSW7nLurIquC9PoESHwvc9XgeCW4hwq28k2VIeDw3S/GgpaIS7DQ8mFR56l7YAmogilzJPYPQIcj7r3mPspDdKsJH1Jym3BN/9Cq7QDDqt/wj9xLNpCVVuaOec31xgKANU+jFHXv9KpyHVAPgdt019IrGXnwK15RoSNnIuY6MAH8MXTDsJuvaKukJf5ldUIIywdufCLj5mH5z9qkKhtIbC7o3Smcb9b6/JqouLtPV19CZb4qVU+YYFPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQZ8QkL7ApO8QSX/9yaKpjSB6WSp2o/f2WMpizH+KFY=;
 b=JpFtSh7l6QRKF1PD1BrV2yikDaRjnKlZlSNRJfn4R5OSMSBcdZVHt5UZ7BlyNIqn+PJIxyuEsat148k4uvOKhZeuEKxyIGjC+f24cjLC+C3byW45FsJvQq46liReHbA1X0uiCUb7s7L9pCbEWeIO0vsTaFh4ZSO3isrFkIAlsA8=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by BLAPR10MB5105.namprd10.prod.outlook.com (2603:10b6:208:325::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 03:53:18 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 03:53:17 +0000
Message-ID: <8bfb7d1d-f7d0-94ca-4777-e31a2003027a@oracle.com>
Date:   Mon, 15 May 2023 22:53:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        nicolas.dichtel@6wind.com,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, ebiederm@xmission.com,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
 <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
 <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
 <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner>
 <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
 <122b597e-a5fa-daf7-27bb-6f04fa98d496@oracle.com>
 <CAHk-=wgTpRDwS+F0Gd6+bM+TEh+x4Aiz8EBDTnTm3Q4TFdWOww@mail.gmail.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CAHk-=wgTpRDwS+F0Gd6+bM+TEh+x4Aiz8EBDTnTm3Q4TFdWOww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:8:2a::12) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|BLAPR10MB5105:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9812c7-7acc-4c89-75ae-08db55c11526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JaF59JlLR9lcUvWwbEOAcdjLnJ4xaDckZCxr3jWEYs++pCfVMfM9S49yuGj8zyURpJDNxoApRlr+FtRcfI2b/S/z/WR8582FD2DSZ5uKAuSIuKRm9vKVcdHjqQEWXiAR0hI8SP4QlH5smKEo25G5k6JhvpsC55HgoTy4mdbk9vrhvFTPIvOT8uC4BjSZaRr4/4Uk+UF94d5IJz+cMgDzXF60FPjllzVfYA0fMjTmYUgB3JMIqY+GHfd7AAkG4T3DC19uMhbBX7UNJQmJBzL7JIY5nLnTRdZHertswP9B/wdEYf/8oEt+Om8ubIetRF+qfhuuSkJyTfnNQzsqsDtsLQ1ieGi3KbnPWaTzajEgG3kj/0truDg1ZNC5jKWwOx1QmGmbrb/ypyJcPt0QcxFsYSh1ktD5DP3M0bYZptHN4xJYI3HYYerqn/Z3EEm3JkBoQ3di+vzy3GBBAWl4zt4cBhH8cNULoGaHP9fWP2r4ipOIfI4vAjVWrYGYLcmrOBHmEklY9KJiglOv/S9YVgRMp65q1eQSNMQPd8BJkIqCw+y2kedctjLGV0TkBysyqmgs8C3AjhiSOtyQMxKG9+BuRrP+cg+So9hvOgv2qh/lDd6RKNT33eep0PUiMzKA3zzJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199021)(41300700001)(31696002)(5660300002)(31686004)(86362001)(8936002)(7416002)(8676002)(66556008)(316002)(4326008)(66476007)(66946007)(38100700002)(2906002)(83380400001)(2616005)(36756003)(478600001)(110136005)(53546011)(54906003)(186003)(26005)(6486002)(966005)(6512007)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHBmUlRqdEloRmpNci9Gck9YenpHY0FSb2FsczRMSUZsK01vSHVkeHh5NjNM?=
 =?utf-8?B?ZXNodCtxUTRZbUpoZGoxcHZkVURXQ1ZoNXM3VGxvRHRYSVdrTENyak1PRVlB?=
 =?utf-8?B?L1hpcnlsUWRETXR3bDRWQitDN0ZpYWswWStRZGpNYlE5SmVSamtIc3VKZ3dm?=
 =?utf-8?B?NkNWWU8rYTR4di9VWERNOVd0bFV2RE14bmlxR0UvT0o3NkR2Z0ZOaUVRdFdC?=
 =?utf-8?B?dm5CZW51Yk5ySkIrSXEzWUpzQ291aHh4elRkaDJtZXUzVElxV2RjSWdpMTRt?=
 =?utf-8?B?Si9STmthQmJZQml5YUdiWExUd3lja2JlQ3hEVC92bFRYc0pQdDNDcDdUSUkr?=
 =?utf-8?B?d21pd0p2WTViTmV6N2xwVE1QOGZUMi9mWXQzcXlSdVlnZFpaZmNQRkR2YTQ5?=
 =?utf-8?B?ekFiQlVrd1ZBRmNOZTlHaGh6Yy9YMHF1cksremNXbUZaTnA0R2cvN3V3ZW9N?=
 =?utf-8?B?NzJyNks2SGEwbDYyckoxeFNzZWF0UHlpUi85WnZabUIzMmhMQUtjeG5sYitr?=
 =?utf-8?B?R080ZnpTa2s3YXUycnVwbW9XK0tlbHdLUXV5MERYMndkMm5HRU5JOVpFR0RJ?=
 =?utf-8?B?ZE1pcGo4aU1EdjZvRlFMbVowSGFaVEhRd21LK2xzQVNhQ2JiVm90V1V6SzJS?=
 =?utf-8?B?SFZ1cXdsUEdZMmM2LzYwN0lock9hdXJZS0RhRldKN1pSejBzTUdNcUhQMlNT?=
 =?utf-8?B?dkNLZEZYWGUwdVQvNk12ZmROS0xzVXhQZmVtUzVHUS8wb1B3WERJMVpMWXk1?=
 =?utf-8?B?aXYzaEpIUFN0TUdPWS9FUWM4Q3BTWHd2ZnpBUDA5Q2pZWWJtUGdVbHg0N3VH?=
 =?utf-8?B?WWRqRTRHdWNIdU9zKytxT1ZUbXRUbU9RMGxFQk40bm5jbnJub21oZ25UdFpn?=
 =?utf-8?B?QW1OSGpTK0haaW9ESi9yOVA0aXMrWlRrM3ZjdHNMNHJKVGk0VHFiL29TQ3lu?=
 =?utf-8?B?SnFOMnpDQ1o2TDJqUVlPTmVHZTVSelNUQms1SW9HMnZYK3VrSmFDRjlqeS85?=
 =?utf-8?B?eTJDTnVlMVNQRzRhenpFNTRxOGdyZk04dWJsTmdvM00yZzgxTlBNMmdKZkdv?=
 =?utf-8?B?RWdmNjdBTXl1aUU0YktaWXB3MGYvWmxTbnA3K01nUHBQN25qNlJWdXpnOXhQ?=
 =?utf-8?B?MHFsK3NKL0YwcEFRZXdhYzNWVnhoZEU5QmpacG81bVdEcTJjR3VCeDI4N2JL?=
 =?utf-8?B?MjkrYStDTWk1S1hYakNNaForWXpQQVlMNFFUM0FTbWJFbTMyMHpDTjJmZjdX?=
 =?utf-8?B?dHRHUW01bUQvNk9KN0prbk0xVmorYVBQSWxJYnREUUFzZDNGaE5PYzUvK0dW?=
 =?utf-8?B?djJXRkNZTU13RDJJZE9SSWM3c0tCQlhDUUs3akN1ZkZlc1hwakg5SEZxSy9S?=
 =?utf-8?B?UlhkblVHK2hWbThWSHI1anFSbFk0cXdCMXdqNWtQN09GR2Q3NlpLUFdCVTVI?=
 =?utf-8?B?NE0zZ1VNYjlOQ01yZ1lMY3hqQ1o3U3JhVzhrTWprWVpQa2UvSGtUK3BkQlp3?=
 =?utf-8?B?cldGR01jbk9ibVhId0o3TlBEN29sN1l1S2lDT3c5ZjZTUHRZZWQyZXltc092?=
 =?utf-8?B?M3Ixc0ZacjBwejlaVkFmczRxa2JDcXluNzJyQmZ6YVNaYlZIVXpkbGxZQW5J?=
 =?utf-8?B?YUFtb1BEbWNrMkFQQWM1RVRmSCs2cTRSSUF0M3RHZ2QyMi9neDJYZU1ZRWVv?=
 =?utf-8?B?SlM5di9FajFMRjgzTVRnMXprUG5OakRIRkFQSFFFNlNLWkFGTDBPMFY0NmJL?=
 =?utf-8?B?bWczY24wNE9qUDJtZ1doY3YwOW5aN21QclgxUDY4Zzg2ZkprakFjSzJxd1Fn?=
 =?utf-8?B?Uy9JUHQybVNXM3VCbGgzWDF2czZ5SE5mZkR0RmdMY1BqbUd4WkxQZDI3cThC?=
 =?utf-8?B?Tkxzdld4OXNZbEdXa0NnVG5CVHhlaTVvOFlmWGZzUmxmYjdRVjNzakFMV3hN?=
 =?utf-8?B?VTZvVHViK2p3TTZ4UlNKTGpUMUNnOVVoZ0J3QU9Fa3A5a2g0Vi9jODZ5ZWZ4?=
 =?utf-8?B?UHkvTjNzRmJUTzFWcnhlSmlvYUtUd2F1K0xEaDljNWNrZ2NyVkJQejVEdndk?=
 =?utf-8?B?SXR1aXFBaUlOdjJoNVpUa1Z6K29tV0tFL1J0YjJFcmRHKzA4VXJLZnVjbDlC?=
 =?utf-8?B?cWFLM0VMK2V6aGwvOUNENklzY0tteCtXSVVxbm13bnVMWkFwSFgrSkVtRGVJ?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QUZ1WVR3SDNnNHZkb0tsL2sxOFlqVWxod01BZjFCS0hwRkVZZGZ6T3YrVHdC?=
 =?utf-8?B?MmRkb0FxdXEyUlB3TWtrOUV4OG9XRHAyQm1IdEFubXlOcDhmdWw1b3p2dThO?=
 =?utf-8?B?REphU2JBWlBTSFEwaU5welVpd3Z0aXVZUDhoTHBqTi9JQk5DWUR3NGR0QWZ0?=
 =?utf-8?B?REhkUVl6b0pzejkrRmNnTWw4WHN3SmpQN2JIdDA1N3VRcHBaVnpEYjAxMXRq?=
 =?utf-8?B?VHNKbUlSZHRSZkVwOHl5aXozZjMyQ1VjRy9LTUQzeXgzSVA2N0FGY2hoTlJi?=
 =?utf-8?B?WmJaaHlka052ajVycE9jR0JVOGZSQXpiTTRDbC94czNqUDZ5T1c2QXB2Rnph?=
 =?utf-8?B?bEx2b3pSMDhPcmZGbk55V09OR3pNb2xrWlgvQ1EvQVA1eWpIeVE2Uzc3R3d1?=
 =?utf-8?B?ZjlrSWdSZG1nK0hNdHVWb3lSSSt5b3dzY2FCdnFmclRGOVp3N0dwQlBNcEls?=
 =?utf-8?B?QnlZTjZpVnFlNXNvNTVmRGU2VFNjTk56eUtGN0QwL3VHUXhEam5mQUhxQUh2?=
 =?utf-8?B?UEZUYnljZnlwMStDd3pJdGVTWVVEQUJrbnRtdTBQNWtWSVEzeEV1Wk11RDVJ?=
 =?utf-8?B?c2czZHVJdzNxVTNQbUZoUmFLTlVZVktQRXFHQ20zek1OMW9QWWFVcGRwMEFK?=
 =?utf-8?B?eGwva0FLazMrNjMyZzh1VUVzdjgyUGpGNEZtd1dDQWVxSmpVRytaaU9ROVJO?=
 =?utf-8?B?RnVUU2VpK0tCMUJDci9ja2pmUTA2Sk9pSkdUR0svOU5UZFZYc3VkVVV5VDJC?=
 =?utf-8?B?SmYyL05ldnVjS0N4cEkrajJVd2JtYlkvQXZSNWRtZnN3ZjlJRFhqUitoczhZ?=
 =?utf-8?B?b2dDYVUzcUZFbEZhSWhxVzhVY0hONDdZdDJTb1hjVWdVWlIvMmJVQzlKYUdC?=
 =?utf-8?B?S3ZRSHNnL2haZHhUNjEwOU9CaDdpV1VnSngwZkxyd2FyQ3ZXTFRpQXVxcVhV?=
 =?utf-8?B?UExUakJ4NWlleWRBcTRRaXRvN2ZTbjdLSVpOeTlaN2lrVzl3d0EzN0duSTNU?=
 =?utf-8?B?eHZSVFFYTnRFUGl4eFY0SGttS1psanRsOHVDS1lvR3NLczBlUk5PSEdPNUdD?=
 =?utf-8?B?akl2YlFHV3N4OGEyVWpkR2Fvd3dwMzBMcE9YaTNoTHBsc01CU2cxV29XQUlQ?=
 =?utf-8?B?U2h0M0ErZnYyTW82cEJyUFZlQzQzRjFmRW9iMTNobVhRSW44NFhFYUlDelVw?=
 =?utf-8?B?ZGY4aDhSR2YvZy9aaE1kYmdTOG1xV3p2Z0RKUXdxWFBuVmZtNHc0TkNCSlNn?=
 =?utf-8?B?cDdoZHFRb3YvWjcvVU9FckRNUDN5NWlnUW8vdWV5em5DOUc1c01nVi9nR1Qx?=
 =?utf-8?B?SmNtM1NjOVdpamRvVUxMWUxkUHV6bVJieEd0QnU5dk5sSzQ3aktzQWVYdDU4?=
 =?utf-8?B?UVQyVnlEMjlOeG10YnpqUHEva09aREpTbUJucTgvYW9ST1EvRXJNaUFUL25Y?=
 =?utf-8?B?cDdCbE9ONVg2L0tZakFMeW9IaTNuYnZYK0Jzb3V5d3I3bkVBSXF5MWxlTlZw?=
 =?utf-8?B?L3l0SHBMT3NQbUZPQklFREh0MGFpWHJOcWhSaTdGell5cDB4Yk5EdElqN3VW?=
 =?utf-8?B?ZWdVZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9812c7-7acc-4c89-75ae-08db55c11526
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 03:53:17.7114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtyrpkobE8J5mU41VDsfoeHoDUwNHBF0YZafa+w/ShL5VWKWNQSp963U6er/3d4CHITqjnx0J5IU2RGnxqtdhN4VqK2dkI/3vMMXr0U5Htc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_21,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160032
X-Proofpoint-GUID: 5Mu5Xdfnq6jX86qOkX_sykFh21fcfERp
X-Proofpoint-ORIG-GUID: 5Mu5Xdfnq6jX86qOkX_sykFh21fcfERp
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 5:54 PM, Linus Torvalds wrote:
> On Mon, May 15, 2023 at 3:23 PM Mike Christie
> <michael.christie@oracle.com> wrote:
>>
>> The vhost layer really doesn't want any signals and wants to work like kthreads
>> for that case. To make it really simple can we do something like this where it
>> separates user and io worker behavior where the major diff is how they handle
>> signals and exit. I also included a fix for the freeze case:
> 
> I don't love the SIGKILL special case, but I also don't find this
> deeply offensive. So if this is what it takes, I'm ok with it.
> 
> I wonder if we could make that special case simply check for "is
> SIGKILL blocked" instead? No normal case will cause that, and it means

Yeah, it's doable. Updated below.

> that a PF_USER_WORKER thread could decide per-thread what it wants to
> do wrt SIGKILL.
> 
> Christian? And I guess we should Cc: Oleg too, since the signal parts
> are an area he's familiar with and has worked on.. Eric Biederman has
> already been on the list and has also been involved
> 
> Oleg: see
> 
>   https://lore.kernel.org/lkml/122b597e-a5fa-daf7-27bb-6f04fa98d496@oracle.com/
> 
> for the context here.

Oleg and Christian,


Below is an updated patch that doesn't check for PF_USER_WORKER in the
signal.c code and instead will check for if we have blocked the signal.




diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 537cbf9a2ade..e0f5ac90a228 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -29,7 +29,6 @@ struct kernel_clone_args {
 	u32 io_thread:1;
 	u32 user_worker:1;
 	u32 no_files:1;
-	u32 ignore_signals:1;
 	unsigned long stack;
 	unsigned long stack_size;
 	unsigned long tls;
diff --git a/kernel/fork.c b/kernel/fork.c
index ed4e01daccaa..fd2970b598b2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2336,8 +2336,15 @@ __latent_entropy struct task_struct *copy_process(
 	p->flags &= ~PF_KTHREAD;
 	if (args->kthread)
 		p->flags |= PF_KTHREAD;
-	if (args->user_worker)
+	if (args->user_worker) {
+		/*
+		 * User worker are similar to io_threads but they do not
+		 * support signals and cleanup is driven via another kernel
+		 * interface so even SIGKILL is blocked.
+		 */
 		p->flags |= PF_USER_WORKER;
+		siginitsetinv(&p->blocked, 0);
+	}
 	if (args->io_thread) {
 		/*
 		 * Mark us an IO worker, and block any signal that isn't
@@ -2517,8 +2524,8 @@ __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cleanup_io;
 
-	if (args->ignore_signals)
-		ignore_signals(p);
+	if (args->user_worker)
+		p->flags |= PF_NOFREEZE;
 
 	stackleak_task_init(p);
 
@@ -2860,7 +2867,6 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.fn		= fn,
 		.fn_arg		= arg,
 		.io_thread	= 1,
-		.user_worker	= 1,
 	};
 
 	return copy_process(NULL, 0, node, &args);
diff --git a/kernel/signal.c b/kernel/signal.c
index 8f6330f0e9ca..bc7e26072437 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -995,6 +995,19 @@ static inline bool wants_signal(int sig, struct task_struct *p)
 	return task_curr(p) || !task_sigpending(p);
 }
 
+static void try_set_pending_sigkill(struct task_struct *t)
+{
+	/*
+	 * User workers don't support signals and their exit is driven through
+	 * their kernel layer, so by default block even SIGKILL.
+	 */
+	if (sigismember(&t->blocked, SIGKILL))
+		return;
+
+	sigaddset(&t->pending.signal, SIGKILL);
+	signal_wake_up(t, 1);
+}
+
 static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 {
 	struct signal_struct *signal = p->signal;
@@ -1055,8 +1068,7 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 			t = p;
 			do {
 				task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
-				sigaddset(&t->pending.signal, SIGKILL);
-				signal_wake_up(t, 1);
+				try_set_pending_sigkill(t);
 			} while_each_thread(p, t);
 			return;
 		}
@@ -1373,8 +1385,7 @@ int zap_other_threads(struct task_struct *p)
 		/* Don't bother with already dead threads */
 		if (t->exit_state)
 			continue;
-		sigaddset(&t->pending.signal, SIGKILL);
-		signal_wake_up(t, 1);
+		try_set_pending_sigkill(t);
 	}
 
 	return count;
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index b7cbd66f889e..2d8d3ebaec4d 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -75,13 +75,13 @@ struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
 				     const char *name)
 {
 	struct kernel_clone_args args = {
-		.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM,
+		.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM |
+				  CLONE_THREAD | CLONE_SIGHAND,
 		.exit_signal	= 0,
 		.fn		= vhost_task_fn,
 		.name		= name,
 		.user_worker	= 1,
 		.no_files	= 1,
-		.ignore_signals	= 1,
 	};
 	struct vhost_task *vtsk;
 	struct task_struct *tsk;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d257916f39e5..255a2147e5c1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1207,12 +1207,12 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 	DEFINE_WAIT(wait);
 
 	/*
-	 * Do not throttle user workers, kthreads other than kswapd or
+	 * Do not throttle IO/user workers, kthreads other than kswapd or
 	 * workqueues. They may be required for reclaim to make
 	 * forward progress (e.g. journalling workqueues or kthreads).
 	 */
 	if (!current_is_kswapd() &&
-	    current->flags & (PF_USER_WORKER|PF_KTHREAD)) {
+	    current->flags & (PF_USER_WORKER|PF_IO_WORKER|PF_KTHREAD)) {
 		cond_resched();
 		return;
 	}


