Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920CA6F0E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 00:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344231AbjD0Wjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 18:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjD0Wjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 18:39:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B882103
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 15:39:30 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RKPMxd017682;
        Thu, 27 Apr 2023 22:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MKWZ+SuRw7gWptD+NMS7tXgZDUBkcd0CK8OYYX6cLm0=;
 b=wQrtTlfq4qPQ2E7jkrAM4mAi3btnlPVSNfD78BrwjBvWctIjF7wNKwU/zX8Up7L4YOcR
 3wt2HXKUmMLoOmNpyHuDQqU4GSmYmd0LPW1jG0Y5Pxij1MJj0odRKDcjwy0ri6RvcyrH
 19Bwj4QUpNYgd/r4faAXFoo5wqoxqE+wo3RWWqW0s5vPltyK7lD7Oy+dIRzKsfeUzhBv
 eCBDpEOh42aDyZL33W8Dv8O6yut2+s9ABC88v0RS3OgHknKQ+cf8xQTYT2hYC6lvURMt
 t2yONoSZVSoY38ReSi/PkXzMnK9U16TEPd32von04+8qji1Apb9Fdk5ryMeT4eOqI3RB tQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46gbw5rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 22:38:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33RLh08R006753;
        Thu, 27 Apr 2023 22:38:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461a11ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 22:38:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaBKzGC3JkPWUak5E/GGtef1mAEl6eEMmFeYbZoySoiil3UeywxWyoasWE71HUH/CXV4jQexJg9mpq1hmJmAfIQ9owPFDX5JIpl4BidgAXqtg4n2K3hCzwHBoalCQFtPldKLsGb8cc/dZaab6kyxV3tkyYv1jLm2mcja+rgjYeg25IEFvevlY1nbL6sAK6zbEUxVP0N8VO6uB08tB8FI3t4OLDz+8L1OLBhXKAYKS02ch6C8HRjMAQGoll7/myxV0TiBqs35JRD0L7UQIxFFyD2ku8/CR57eJvle+C4xMwa5nRo0JVC9afjyZyumvA0PRCV5td9W4LkEpef5ivKqSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKWZ+SuRw7gWptD+NMS7tXgZDUBkcd0CK8OYYX6cLm0=;
 b=Sr+uZwGcEgMaNuFISnk3+VCOsB/bHESjtvelXMt08yIY0nu7HN1dMkcx2YzAGbkGUOqtoUmSm8302hrMNbeI+PJeU2zucf5nhiR0ynoU/20O6jMK7/T6p3OSK0r2xZeC3AtDC0oJAwb6m8R4Fn264OwUiMXdvwXvUTEETKaOUWb1XsksrQDF3qB3e566TzuEWcrkp/Ilk9tI7Z96hCbzrXMoTCoWx2Zt6hrCwD6ps3nWsb7o696l6Eu0LMcLaW2F7WKa5qhdR0l50oeMo5r0IA6LZ6Kmap4UyUbT2z4ZoeCPkznwg+fthGXryxCdCmWS87Vo8sobAUo063GwDX2rMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKWZ+SuRw7gWptD+NMS7tXgZDUBkcd0CK8OYYX6cLm0=;
 b=r27ok8F34wgmuLmKuitOC/WD64fO1QDICqxChRlodq6NicqheaIxhoJTGrdMnSOfO1I0NOGxJASpbiXghvIT4Ihu4Bol2g0XoYNSNnRea9+BDfWLGdjPLmT9tIqPvVM6szjrdbjxtpBvI2BmJUpZUZmBbUkf8g69WhQDZOmpXZ4=
Received: from BYAPR10MB2438.namprd10.prod.outlook.com (2603:10b6:a02:aa::22)
 by MW4PR10MB6536.namprd10.prod.outlook.com (2603:10b6:303:22d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Thu, 27 Apr
 2023 22:38:42 +0000
Received: from BYAPR10MB2438.namprd10.prod.outlook.com
 ([fe80::5271:bf6c:adb9:6299]) by BYAPR10MB2438.namprd10.prod.outlook.com
 ([fe80::5271:bf6c:adb9:6299%5]) with mapi id 15.20.6340.023; Thu, 27 Apr 2023
 22:38:42 +0000
Message-ID: <a0948545-1d2b-fdd2-3f7a-1f6a255162f4@oracle.com>
Date:   Thu, 27 Apr 2023 15:38:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [RFC v3 21/21] x86/boot/compressed/64: use 1GB pages for mappings
Content-Language: en-US
To:     "H. Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@kernel.org, akpm@linux-foundation.org, ebiederm@xmission.com,
        keescook@chromium.org, graf@amazon.com, jason.zeng@intel.com,
        lei.l.li@intel.com, steven.sistare@oracle.com,
        fam.zheng@bytedance.com, mgalaxy@akamai.com,
        kexec@lists.infradead.org
References: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
 <1682554137-13938-22-git-send-email-anthony.yznaga@oracle.com>
 <70EB1774-A782-47FB-A8EA-534E66A551F6@zytor.com>
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <70EB1774-A782-47FB-A8EA-534E66A551F6@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0066.namprd12.prod.outlook.com
 (2603:10b6:802:20::37) To BYAPR10MB2438.namprd10.prod.outlook.com
 (2603:10b6:a02:aa::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2438:EE_|MW4PR10MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae8a433-796b-4d40-a0f2-08db47702729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o6BzP6zBiNHVhfsn6n3VRZbTJfdZBPlBv5wRYuqNHZJFKoB/9qNb5t9PEVJ8KKo0RbWVLUvLIo3DCOatDbOZH5qhBXwh3QL14GbdQvXNZwHWSAp7A8L3CVFr/bHvpRiPGigHbtcUETAIkwNZyJPqXXKgI0jw5OnmZKqjYWl6WlMZAmzki9vWyBNDSU7IbkkPSoPEaFa8HC8YSbb7pL6XYClkby/Cdus25tBCLXzb9Ht0BhF9bY0B65KXYg7PJjF9EblKEutCV9b3hGhdF41av0ckphRA3UlrbaEBw1AjVeRd9ToEiul3G4UE8Fh1GqiVx+rEm+3rQDqwmIUsFhX56P3lEVYQ4b/2VE+C5liurFGeZ6zIeK1VZHCGsKcJzePrpS38Q/3t2Uuz7kaaxJYVajy9zmijlTmk4+0DIwS5snVOjKc22fT9uHkUJo+vgpJhDiJJ7aNWDrQQHNWhzfuGObe5mgRdJRSK/y7s/5DRTLZDsC+EPE64J9+T4ix+eBBIQDXsYa5O0rCDHDB/D7/jE0DGyKqJkk4lH0AYSaxYqQYKDb6SthE2Hlhlo1Wl/dnyWQZ3sJQ/qN7NwkgKBVF7ccTgkiW70hfC5khw2++4MblBTGyW1N4Q6Vb1ONLw2+5U3Xxcat5OhEtxcLlns1734w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2438.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(66556008)(5660300002)(8936002)(8676002)(6666004)(6486002)(38100700002)(66476007)(66946007)(316002)(478600001)(41300700001)(2616005)(36756003)(31696002)(26005)(6512007)(53546011)(6506007)(4326008)(2906002)(31686004)(186003)(86362001)(44832011)(83380400001)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2U2dWUyV3FpNWt3c1BOckJTMllZd09qUWhQMVZqd2NVOTJKVFZzZFBQMG15?=
 =?utf-8?B?ejdwLzVWZmlPZnc0VFA2RStzbUZvRnZJQXpieWdqbFRmS1l1elErYnpNa3pn?=
 =?utf-8?B?VlUxQ3NMbUlRM2t0bC9KbHFtYWpUVGN1Mlc4Nmt2RE5SZ05ZYmNoZEo3UVZp?=
 =?utf-8?B?TTVKcVJYRFl4L0hYb2pmSWgwczZ1aEVGb2doWWJKL2JMQlFmZi9kNFBQSWgv?=
 =?utf-8?B?NXZaa3ltWHVBVWx0ejU0M2dOMnM3TXBTVnJ5RzlQZGx6ditkdUVBZHNXUk04?=
 =?utf-8?B?NmNRKzBqZThQMzdBbm5aazhndkpxUVFqQXdXUzFJRmswbUZGRUQrSDFmYkhP?=
 =?utf-8?B?aVhwSTFHcDlhWSt6SUpuZ3B3RzQyOWpxUHB3WW1TcHhKbGNaQkFHcnIxQ0Fi?=
 =?utf-8?B?ZDgvSVFjYURWdEdISHNZRzlPaG9OclVoVlVMY0VTQk02T2podkFmYTcxdDJI?=
 =?utf-8?B?d0hnV012dldkREJ2WWFUQ2tGQzFmeHRuNG9uaSs5cnl5a2VrY3Y2akpTVTlL?=
 =?utf-8?B?S09wek5rUGRPV1gzbndtWDFMUkt1L1Z3V2YwT0YvenBZekNHaHRQRHArZUp1?=
 =?utf-8?B?NjlZNHZvdEhSWjRGN25OYW9NUHdQaXh2SzBIdlFXaXhxbTBoVTRiRDN3aHY4?=
 =?utf-8?B?cE0ya1dQQ2t5QUFXNTJBdkQvMDE2SDlBSmFjWVRhRTFZdVhyMzNBQTBYS2x6?=
 =?utf-8?B?Z2JCYms4dWtYWVZMWk1IZFNaeEJsa1lZL3RUOTdjb1JWNFgwSnRoU1FrYzV5?=
 =?utf-8?B?OFU5bjJKZ01HVDFvelJOR1BCM3R2ajI1bFBhOWV6ZE53RUNQejFpTnVjWlN2?=
 =?utf-8?B?aTBrY1FsWmQvU3lqRTZNbThkUjFMRzFDbmcwZjZvcWNRY1B0cDVhaHRmVkdx?=
 =?utf-8?B?NnNvWUxnbnM5Q0NrT3hLazhhcUJXRXJKL3FYUi8zVUVFOURXSFlvZHpwRFcx?=
 =?utf-8?B?N2NvZm1QVFBHWjNJSkM2TmJDTmhhY1pieFdkSGhKUmtyU3JCNzQvMFpHN3hz?=
 =?utf-8?B?NkJaWFB1aElERU5DTWIxQlYvSU8yOVBCc0JuSWp6UDJMZ09pRW5SMzJxMTZj?=
 =?utf-8?B?MDdQZ2pTeU0wcHdrcFJ0Y0xQejQyVnJnYkdWUk1Hd0x5RzVGWDZaRms0M2tM?=
 =?utf-8?B?ZWJFdEhrTG5NUFVuY1E5ZUlhb1RhM1dieWs1N2I5ZXJJNUM1REo3Y0RrZmVx?=
 =?utf-8?B?dmx6WitJcUFZdjhJL2hLdlJucSttd1RjNDhXeDRKWEN0aDZweDB1Q1BwaC9R?=
 =?utf-8?B?aG9CWEZmNktyTERlVHVHVmx0cnNSeCtaZC9IWm1ZQzVTUlJpYVNVRmZNTnp5?=
 =?utf-8?B?M0x2UmZhWnRHOEx5TGNMMVVEclI5Z2ZmWGE5VkpKRXU3aE1mWG1waFJMNkhp?=
 =?utf-8?B?NUEzRFBsSkFBanhKdnVsNkxTeGNXUk9PelBpelBEaTZ5T0pCL1AyT2lHejdD?=
 =?utf-8?B?RmdPVU0wTk9RQnAyZXRiWGhJdHZTVHZKK05PZEh1cGhNZnQvOEZSc3lpdEp6?=
 =?utf-8?B?WFhiUWhrRTFoWHpGR09sU2tzZmRkWFlON2VobTcvaThmWEVlMGZ4RlhwZVNi?=
 =?utf-8?B?WGZOU1J6dVBvMHdyNUVJY3NhU3ZZTzM4OEJFNUMxNDRNVVhrRlBJcE5BZW5s?=
 =?utf-8?B?d1BjdVBPdzRmcGFGdENJSy9pL0xycCtJQUY3WWZQWVB2K1IzelNreHdPUVRo?=
 =?utf-8?B?N3J5MzRUR2RuMDJ4cld0WHZWWnNCczg3ZHRwaEtxQm15WE56R1c2V3A3cVU1?=
 =?utf-8?B?Z0s5WTVyOTNWODQ1ZHB3MVR5cXArMEI0aDY5NTMxY3BQcmJKajQ1cFhRNDJU?=
 =?utf-8?B?ekRHMmJHSm1BTUg3bzRQNkVwQzNCZ28vbnc5UDVaSzBvZFVLVmh0aTNwTXFD?=
 =?utf-8?B?Q2JTWmMvQWpVdlFhZE9PUlFhTkRpMFFUMkNjSlNkdlJicE43clR0cjdhYnZP?=
 =?utf-8?B?SVpsNDYyMHJRNFpoV24zWEROelFBaXRlR1pBTXd5UkxobnRJd0FUeFVodW5y?=
 =?utf-8?B?WmV5TWtCQW1WMzRJaVJlZEs3WjdvNFRETUVlaUpyT1BuNEo5aUZzZ2R1ZHFH?=
 =?utf-8?B?V3REam1LcG1Pa09YV0pmS2xiOWxWQ2hDYXVGQVVSNTQxZzdYKyt2UWFVclZK?=
 =?utf-8?B?cUZyK1JuVEJZOS9aelZWNnMrRDFJMi9xa29UbklrTWI1L2hHcHVzT1ZqTGxI?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?U3lxejZZWTJ2aW1RakR5UklDQU1ieVpCYytSSVp6KzFqVkNja25YUmNQUzVX?=
 =?utf-8?B?S3lDVWh5c0p3aFhhODlCWHBvSkZYbGtLZjMvNnJBRHU2N2N2S3grbXI5TTJv?=
 =?utf-8?B?V3Q1c3VoVkVMSUFGdlZCOHdYRFpYMy9BVUdrQlBVTFk0TVJiTnQxVWxxYWJD?=
 =?utf-8?B?UWZIZnBaR213VE5HOXVsK21xWk5EcUtlNHc4NTdVYUU5c3lLZkh3UE5GUHkw?=
 =?utf-8?B?WURMTVNuNXNmMHdQQmhRejF0SE4zRUdENE13Z3JXVVBTYlpJNmw1SWpvREdm?=
 =?utf-8?B?blFUUlc1endOcmhPL3B5SXFCMWcxTXhtQ1IxdytpMnVCd0tuNW4xTjJHMVcr?=
 =?utf-8?B?bU02Y2pmaUhic24xTE0xNFkwMkE4TFZKZHhlUS9nc3ZoOVJlZFlRNHZ5TGha?=
 =?utf-8?B?MGxEUnJDbVd0VWZ0T2pFU29mbmFtWHdSaE1ZQ1NadHFXWktWYlVyaXo2Zlpz?=
 =?utf-8?B?c3o3T3E0bDh1Si9mTmxibXZCSUZRajZPMC95NVI1dEVoKzE1eEd4UGpQb1c4?=
 =?utf-8?B?V21hc2FncmFHaERCcmNuQm5jM0RXd0o4cHhZS2owblEvVC9FWTgxV2lGS1Ay?=
 =?utf-8?B?dERuZXg0emxHa2RWbDZLQnl3bVNGVWZmcEgyMU15VHpOWDhPTnpxUUlHZjVM?=
 =?utf-8?B?UmJDQmRJMHhuNXI2Um9wbTB4TzBxL09DRkRBYmtsZFUvV1prSDAraFdhd0Ev?=
 =?utf-8?B?bExlSUZvblhoTUh0aHl1bkZEa1F5SzNWeFRuQzJvRUN2eFNFdEhaQklqbS9r?=
 =?utf-8?B?SWRxYWRPSjZvTXZ5dW5MZDlEYnd5cDhLeFllcmNDcjNCUW03U1NIa1ZPeVZI?=
 =?utf-8?B?UTRBSUdWTGh0dEY5S3ZhemNtWlZsT1YyY3RzMlRBbHh2bFo3RkEyaHBpTlJB?=
 =?utf-8?B?OE9mcHZrUkExN016UEJKd1JVd0RNNGcxNENwbWx3VHU2ZHphODNUdU53MXFS?=
 =?utf-8?B?UW5ScEFyWmtSRE5ENzVCYVovWFkyUkptTkl6c1BWbmlyTi9EMTZRVlVTbUFs?=
 =?utf-8?B?MHBJa1ZwNUFkV3BPdWYwMk5VdjR4OW02dDdIdDdIUXkwMDVWTStvbkU4aE13?=
 =?utf-8?B?QjJ4elpsV0RLM0tkQy9aZVBUc0VuRkhpOERlc3BzOGtXWWlGMDA5clIzM1RB?=
 =?utf-8?B?STB5bVdFejN2c1BSZ2NGWHBJM29FQzNRTEU4N3l2RGtHTjFsY1paM2pTemVy?=
 =?utf-8?B?T1pTaEJjRTFodG1jS3FCbVQ0Q3Y5aStuMkhLUXJsTzFjeUs5NVFpWitqMXdw?=
 =?utf-8?B?aGtHSlBaeFBiQmNXYmg3d0RnL1JtbnUrUUtTUkZvbzFKdjBFdW5TZC82aFg1?=
 =?utf-8?B?dEoyNVY0UFRob0xaa204L3N3S2JoZVN2WXd6ZmIxVElrZUhEQlBOWXNPWTM4?=
 =?utf-8?B?TE9EMjZ3NWI3OXRxMGcxNEppUmtlN0p2dXRLaUdpc0dmTW94UXFvS3hFMzV6?=
 =?utf-8?B?SU0xYVdsdk5PQXlkRnRzOWNYaHRUZHA2Qm9qLzdvTGdLa1FWMHNsODBuTG5l?=
 =?utf-8?B?bmprMld0QlNOYnJlWlNoRUhzK0ZFNWJrcm9LOU9DRUx4WCs5aFRudUFsYm9G?=
 =?utf-8?B?OHEzVmsvTFA4ZHhES3lhaTJ6SUJCSHlITGd4ZXQ4TW8wVmdyTEtFUlprMFk5?=
 =?utf-8?B?dmgzT1FpczFOZVppVTVRWkhBOHllMEh6NmMrWXhOL0c4aldZdUNrOEVmTlVs?=
 =?utf-8?B?dXZQZTJ0Z0txWTI2T1ZqMXo1SFF0OU1LclVlK2dGUnJMRUdvbTFUNWFEdVg2?=
 =?utf-8?Q?w+Qo8bsKR9ejYtA0fjGZp1nbw1nxna5noz9lkzC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae8a433-796b-4d40-a0f2-08db47702729
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2438.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 22:38:42.3802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7Zplnb5y1ETnzO9SboTTUvAAOdeM3PXjZFAximp815OIjk3D30Ar24Hoc9cgaSIdrf9PpNXZO6QQLLC9TMXc2AmsDKZ1AkIfQtAd49O9jM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6536
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_09,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270200
X-Proofpoint-GUID: rpupowy-FKtqEkReBNRwiWNFqJDhLoNu
X-Proofpoint-ORIG-GUID: rpupowy-FKtqEkReBNRwiWNFqJDhLoNu
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/27/23 11:40 AM, H. Peter Anvin wrote:
> On April 26, 2023 5:08:57 PM PDT, Anthony Yznaga <anthony.yznaga@oracle.com> wrote:
>> pkram kaslr code can incur multiple page faults when it walks its
>> preserved ranges list called via mem_avoid_overlap().  The multiple
>> faults can easily end up using up the small number of pages available
>> to be allocated for page table pages.
>>
>> This patch hacks things so that mappings are 1GB which results in the need
>> for far fewer page table pages.  As is this breaks AMD SEV-ES which expects
>> the mappings to be 2M.  This could possibly be fixed by updating split
>> code to split 1GB page if the aren't any other issues with using 1GB
>> mappings.
>>
>> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>> ---
>> arch/x86/boot/compressed/ident_map_64.c | 9 +++++----
>> 1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
>> index 321a5011042d..1e02cf6dda3c 100644
>> --- a/arch/x86/boot/compressed/ident_map_64.c
>> +++ b/arch/x86/boot/compressed/ident_map_64.c
>> @@ -95,8 +95,8 @@ void kernel_add_identity_map(unsigned long start, unsigned long end)
>> 	int ret;
>>
>> 	/* Align boundary to 2M. */
>> -	start = round_down(start, PMD_SIZE);
>> -	end = round_up(end, PMD_SIZE);
>> +	start = round_down(start, PUD_SIZE);
>> +	end = round_up(end, PUD_SIZE);
>> 	if (start >= end)
>> 		return;
>>
>> @@ -120,6 +120,7 @@ void initialize_identity_maps(void *rmode)
>> 	mapping_info.context = &pgt_data;
>> 	mapping_info.page_flag = __PAGE_KERNEL_LARGE_EXEC | sme_me_mask;
>> 	mapping_info.kernpg_flag = _KERNPG_TABLE;
>> +	mapping_info.direct_gbpages = true;
>>
>> 	/*
>> 	 * It should be impossible for this not to already be true,
>> @@ -365,8 +366,8 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
>>
>> 	ghcb_fault = sev_es_check_ghcb_fault(address);
>>
>> -	address   &= PMD_MASK;
>> -	end        = address + PMD_SIZE;
>> +	address   &= PUD_MASK;
>> +	end        = address + PUD_SIZE;
>>
>> 	/*
>> 	 * Check for unexpected error codes. Unexpected are:
> Strong NAK: 1G pages are not supported by all 64-bit CPUs, *and* by your own admission breaks things ...
>
I strongly suspected that this was a no-go. Thank you for taking a 
looking and confirming it. I'll look into alternative solutions.


Anthony

