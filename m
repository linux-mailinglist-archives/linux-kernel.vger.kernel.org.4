Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23958722828
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjFEOFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjFEOFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:05:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D79499
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:05:22 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355BuNjx006746;
        Mon, 5 Jun 2023 14:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=neKkuQPorc/ALTqF6poDxPZ2ifxpfuJRKUCThPtl9Eo=;
 b=e/hxizzs7UnBEph3xx6/wtKJI0deQi8/MHiyQ1EiHmx88fCP2AZ0Wm2MAMBxdKxU2JRY
 UV/jnXi0t5YGxHFM2dwsXe2ymbTolpHG/idf7G9dyYwx97tJbZZa2kKJ7A9vVOi5ee09
 y9rj9m/YBjI4ubGgn+I4Y04vWnX1je5x/YbqssdYaA5GjykdvO4r6wZuGRCbt5XsmZvm
 Y+R3YkDa4jHfNw+I/tikGpvHJ0XYFniPiz2j6kYak36zfNXxq0/s9Lk5S6RKFFnZPtvW
 duQJ/ocEknxhJkIKapfRjHALfrtzxkO5ZAJ+B3NnO4S544mNiTuMTXGsek7+m+T/Tvmc iw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyx2n30sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jun 2023 14:04:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 355CRVOT010452;
        Mon, 5 Jun 2023 14:03:52 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r0tqbhc4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jun 2023 14:03:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHXOQ1jgm9awj8HKHlQhbwY+lwCdbIzALLn4K1ZSxGoLWDwNSi/TSxqDxnARTJLSP7CK4CIIMDY1lWNnTsiRXRAdlRaoACb2KzUXl43c9P9YHDEuIXPJ4N0401i2G+EmGCfnNI0Kg3XhAFqeEdhIIZIHE4r5VYUhSa33nK1SDSDFCtGu/LCHRVQVpBRfDsm8uOfKJeocGqivJpUeIW0HE2C8CiaPkZ3avKS502HjirYiSRCdwJvq6e0ZuUBuOqusHzBd0kZ60yWvjDgJxvKPtIlXfzT5P3ztGr8V0DDuBAyNZ4y+ZJ4bJMOuqURL5U0CkqaqqzeWX0PpQ6WsL1sMAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neKkuQPorc/ALTqF6poDxPZ2ifxpfuJRKUCThPtl9Eo=;
 b=jvCOFrSPEIUQc85lldUIv5eP/2rY2CN8SugTQ2OPysCPJi1MzqWWQX2J5ygH3rYIFJECmlQutBsVtS8zE9Fm/zoYpgo7s2wXvtyxx7GhTp0P6TyBwOnnkI13IXg8aS5GZH6yHPcDrab8jKvryDH8RdjI/WA4jtXPyyxOoOfxKNl5DCDIxbaBRHHk+iczlV5dgA0/S3x4SLJ68JgzzgHOXwbI82hhExMD2sVgyvYEbfTuUzouqRJwhofN8ctFHYb6S5RGGPvrqvvc/tvhD+jO0usfUE6gvpzgRNgro1CZAQFGeb3ybVx6PuGOeq3TFwUUm4ToOiRCTwF/oPs4C6zgxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neKkuQPorc/ALTqF6poDxPZ2ifxpfuJRKUCThPtl9Eo=;
 b=zv/hhIUjF+pD9jdUFkFL+PmYsgtGcXRBD5tPVW6FiQ7ZRGjQybd+SYbZLuaw8yEIvC7LHAeOvGzoCZkN08NgVTbu+6vfyjIzuUMiZOPvX0c+lvdkA5rC0iNz+cJklJZ45ictKxFAchov70m4K9gO19eSEkznkpDc1olk+UyXjus=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5783.namprd10.prod.outlook.com (2603:10b6:806:23e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 14:03:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 14:03:47 +0000
Date:   Mon, 5 Jun 2023 10:03:44 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Liu, Yujie" <yujie.liu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 00/14] Reduce preallocations for maple tree
Message-ID: <20230605140344.66pwpdg5zgb6rfa7@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Liu, Yujie" <yujie.liu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
 <7a5dc9ce-b58f-e1b3-db1a-d00a8a556ae5@intel.com>
 <fad3c833-1ab3-2d34-aa85-dcc7c40c3587@bytedance.com>
 <a9d2ab1b-23a5-8c06-9f7a-6872c726db03@intel.com>
 <b5f2d527-8887-eb0b-d3f2-4e7cd8f3c022@intel.com>
 <4fb5f66d-c8c2-f857-7461-b974154dbc2b@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4fb5f66d-c8c2-f857-7461-b974154dbc2b@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: 8917c509-ce27-40d1-d540-08db65cdae4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JcXCYME97s4UMnJwiXqJWMWO8raVBd8ySGMQS9pn25jvIqBDZrqFMZUHAiG+sUUD9DxPpQwXrU3adu2cBcozMaVVRqFcXHAZv90yrtUBxJmnFTdJK2DviDCLY46zr+353kg23jJdc1y+wbh8dgWTEk1K65sZhykshUoZbhmvqPTb0Xcp3LDaTHj2jMN6b+4utDtpXKgR2xMIhOKk4co41MfdxugJd88mJ0vSyDlSgSTzplDZ29wtuWnK18+966lsYjzLYPuvyeIR0YVgzQVlsLFVO3+TLubphH669GETqw/jrqqAdIlXliOMdbOHKEGN7cRs/Zpctaqr4vssyJjqdNFagU4ZDTzMBGZnjOmZHGOnAoDjyvovuCvLmIjHk0dHty65WAeabPTLy6rBphKjipa8G7Je+8gpAL0xfC7YVI7C7S7TPpWQomlALVCR+Em/pN9JtLdrxNrxF8vTvrrCMXGvME3lVeyLdIDJYLPV5NYBahLE6WYqNK0ReTgx0MAlHtN1H0sJFyiVf2w4SDxih1xHkHNxPh+THBSlHcBdq2U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199021)(33716001)(6506007)(1076003)(9686003)(186003)(26005)(6512007)(53546011)(966005)(83380400001)(6486002)(6666004)(2906002)(8676002)(8936002)(54906003)(478600001)(5660300002)(38100700002)(6916009)(86362001)(4326008)(316002)(41300700001)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHl0L0VqWmVKeEh2MjBSUGpKNUJ1YW1reDRQb0RxaWhMU0ZGYzY1WUovZ0tX?=
 =?utf-8?B?NjROOE9IQmtvZGh0R0NZQ1NoTnl5MmxMZCtvbGFEdW91bHFPOWF0QWh1eis4?=
 =?utf-8?B?U0xTVnNZR0UraHBtK2JkYzBsY3VZRUk1cDI5dmpxWUd5TFBMWlZBelNYOVBx?=
 =?utf-8?B?aVRNZFJtZElxZVdmYXBrOGNDQzJaY0tKYmlrdmpaQUtiRHFMVksvRjJtUDlS?=
 =?utf-8?B?ZTRIU2wrd1EwdTkzeVNRejhmVDdlOUdlclorV1JyMkI2MEF0dWxKeXRBT2pN?=
 =?utf-8?B?Q3QyQTdSenNoR1RleDVBUWpTZHZ3a0thaWlpVFBWdEVRWjlEbURFL2twS0Zw?=
 =?utf-8?B?ZmdWYjBzVDdmYzBMazZySVFBODNtR3B1R0pYOE00TlVPVTRoWUx3RnJ3T3cy?=
 =?utf-8?B?bmxiMjROcjI1ODl4T1hQWXlVWnQrckYwZTRyWVlOWEpnbStSbHhtdlN6K2ZW?=
 =?utf-8?B?WTlVc3EwQmdYckRKdGptK290TFlZZExGTEdQbVc5TXZlODQrdjJLQUNZdzZa?=
 =?utf-8?B?MCt2b0MrMzBYRWRRS1ZPVmJZYnd5RjhLU3lhbENnZWl3ZFNjMlRqK2NsanZi?=
 =?utf-8?B?Tyt6dSs4OW4rLzFwOUhSaUpDaGl4NG9aKzVHcXpmSk5rN3pWR0lFdHFBWTcx?=
 =?utf-8?B?TnpGL3o0SW1zc1NrRkRSUGpXcTdCQXUwbUZiYkhjZDdhSDhCUkh5YlNCeE43?=
 =?utf-8?B?NFA4d3BjVnhSd28zN0JDaWVpTUpwTVRuQ2xWR0hQS0VOL0I3elJYUzNHc3BV?=
 =?utf-8?B?cW5RYXo5VXVDNWQxT1V5bjhlbWdFNVJLeFNHZ3JYS2V5TnRxUDVGdkVyL0Zu?=
 =?utf-8?B?WTdqbkcvZTI3QXA1Wnd5QjdraE14N2VaUVVkR0ZyRjAraHhwUUJtMlJYd1Rk?=
 =?utf-8?B?Q3NqL25GMzdFOGg3NDFrSHBQWlQvN3VjR01HS2lZUUVKaTJRVVB0VzVSajRn?=
 =?utf-8?B?Q0Q1K1NJNHBFcXNubzlBblJuNVVBdWNuL2U1Y01DMytuc0V5ZHZmNU9kRDVY?=
 =?utf-8?B?aHg3eHE4V3VmR3diRzZpeEl2MDBwVlFGY2YxQ1ZVRUtVZk1OR0tXNWxlbU1y?=
 =?utf-8?B?c2VGQnFPS3ZVekdQblFYV3ArSW5oWjJsSE83SE9KYjJZL0hhWno4ZXBGMWNE?=
 =?utf-8?B?cFdUMXBqR2pxbno1NVo0ZFc4MWtUL0xlbTJPQ2RiUTZsSUU2QmdsdDM2dVpB?=
 =?utf-8?B?TlV0MHYvZGpvVVpPb1JIbzh0cVRpUFh6Vm9vTkhVaVA2K3NwejlFWmdNUHIx?=
 =?utf-8?B?elVpQ0VzY291OEZxbkNnajc2MXpwazlZZzAvUFVWbUpMbG1qZEdKMHdITnZN?=
 =?utf-8?B?UVlsZW1UYVNWVGtJb0R5UlpKZWJ1VjhXZUY2R2VCeVBqOS8vWHlISXFNUHd4?=
 =?utf-8?B?ZnZqZHFoRWVMOUxCMjU0MTZpaGdHTWhpWTk4QlpiUUxVWUZVak4rVXQwY0FZ?=
 =?utf-8?B?ZzdBQWt1MkkzakNORm0vZWdJUWl6cEMvbHd3b2lPUVdqcTRDY0tWSG9pTDA4?=
 =?utf-8?B?RFRGNS9yZzdaakRHbGl0RXhHNHd5MXBRSmtHTGswZURZc2lVeHo3YVZPYWhu?=
 =?utf-8?B?TGt2Q1NCNXQ4cno1NEc2ajZLeEJvZGJtSnF4Ym1RRDBsOVRaRHRKazJHc0dP?=
 =?utf-8?B?d3o5elg5SDlCV2FzblN2V3I0VEQ0bkt1R0pDbVFiQlo3VDNGVUVReGxmWklV?=
 =?utf-8?B?cXgwa2lZNmkvK0c4aVoxSFlLRjRCQXE4d1JvU29Vak5MMkVqQTVDN0RZRnBt?=
 =?utf-8?B?MjM3Rk5oTjlMWnJBY2dPcUdjY3FINHl5RStiMG1QdlRiWDgwOThUVVQ2eHlP?=
 =?utf-8?B?VFo0MVQ1V2JTMnlaZEI3TnVTN01lN05sc2hFbEI0YmxtbUJlM0FUWnQrSlJD?=
 =?utf-8?B?Q2l3WmJVcE9uMDRmS3VaN2VFR2gvSEVGOENsMVowRU1Xdmk0bGFwMDduNjlz?=
 =?utf-8?B?b2lmSWxsdTZGUk0xa0xEVnMrYlJlbnVhSVZzSzRDcCtpMnNKQWtYZjlaLzlj?=
 =?utf-8?B?N3g5aFVmWktjUGMxZnJ5d0VHVTREUW5oWEY3RGFPWmp6VEF1V28zQUtmSk8x?=
 =?utf-8?B?N01lc0JPNnhacXFYNGxxUHBMQkcrNU9tYzV3U1BkajNlVnpwUmd5dkE4dnZa?=
 =?utf-8?B?bit0ajFHNlVSWkdpYTQ1Z01mMkhOOEplU0ptbEF4S1lSYWZTTmgvNnlGbnNh?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YlkvVjBCWVIwT1VkMFNKUjJWSXJ6Z2c5dk9VOWVyRm52NUpUSElUb09KQWpL?=
 =?utf-8?B?VWtvcXZWWXgwOVM4RU5OcGRlRkt3elArR2lJU1dHS0VNekYybE9DNFJXUnJX?=
 =?utf-8?B?ZFA2WlF6MlQ5MWFmOFlTTVB6Y3FFc1FjUGZ5ZW1xcmg3c3N6T2xDejNyRitG?=
 =?utf-8?B?UjlIcUpRQVlBR2xOSzZpUXVObzlIUmtNWmRWcjl5dkhsYUtCdW1xbEVpd09n?=
 =?utf-8?B?djdvT3YzZmROQ0p0S0p2SGRFOEwvZ1VDbFQ3ZWZEYS9BTkFzbGFEbW0zWGoy?=
 =?utf-8?B?Nm1DWHljYzVoYjQwMVd5NmN2bFI1MlA3Z1NJenhpWC9wMHpIeVhBbHljNjd0?=
 =?utf-8?B?dzMxV0NMWVlTaWwxVGlUbEs0L1JXSlAySHFtUmY3WFp3N0R6bDRCREJBV1dx?=
 =?utf-8?B?RXFYUWx4Q1lwcnFYRFNyZFhjYTF1WFRCYm5EV2FKZDd2SHV3OWYrcitQVmlE?=
 =?utf-8?B?b1YrRDJjYWFLZ1J1dDlEemNSWXI5QkFkcXZnWHlEZE8yeGVielVKRmx0b2dO?=
 =?utf-8?B?Zm1hRXBtSTdCR3p0Ykp5cDBuQmw5MTl3M1ZUdmdzcFBDMmRsbGF0bE1oVWow?=
 =?utf-8?B?emdyejl2bGN4RTlqd2pLTGR6WUpNdGUzNi9yK1ZPN2ZDdEZPcEpjSkJJUWw0?=
 =?utf-8?B?ellGN2djVjdicEJyLytISTJjeW9oOHFMNk55d0JWaHNsQW1nWmdVNGc2ai9h?=
 =?utf-8?B?NnRTZ0dBMWp6NVZ0YjAwQ1FGUzZDZ1ZvQ1ZNSmtGV3EyNURKeXphQWZZaDRn?=
 =?utf-8?B?L0xsVUZ6WUxuWms4R3YvQnZzUUxOVWRBN0hacENUdGJoWHlHMXFjV0tiNWZw?=
 =?utf-8?B?YzQvd1Y4VnJhRHllaWtCR3c4c3RsdG1jbHdFczRVY0thS3Y2N2tqR0hNWllx?=
 =?utf-8?B?dk5FaGZqSVZaNHA2cm1Vd0Qza0JpS2JDQUxRcjZnemwxZzAwblc1dVVkM3Ex?=
 =?utf-8?B?YmtIUko3akhtS0Z5TjUxOUFjdFR5U1VJK1NvNUZoVzYvZnJmSVlsN3BCWnRF?=
 =?utf-8?B?cU0vVzgyQitRTTdxZTZZNUQ1c3pvQ3ZnTU9DTGVwcXBlN3g0T2VnY0ZYTDBD?=
 =?utf-8?B?eHUyRXJyZDZUd2k2UUd4Nk80NndpVE5mbGtabXJnTWx3Y0lJNkhJdnZCeWY1?=
 =?utf-8?B?dTZUZWZORTVSbHlxUHE2WGdTeHBIa3ZkQmpNWGVXZUFKbWdXV2UvdmRSYXJK?=
 =?utf-8?B?RlU5eDdrMjAyMDVsRzFzV3AxdVFzV2hpWXlKMzNmS2piU1REZjRTUzVGQ0RE?=
 =?utf-8?B?SnRqUStYOFlIWEhMUWVhdkFwaWdxOVJLS1BmQkgrYXhsc01wUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8917c509-ce27-40d1-d540-08db65cdae4f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 14:03:47.2122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+UQBiSuoPvYHluQry+UQMwAo99mUXQxH35r7iYOr2Ik7MtGvymdD3cQcKest6JEPd1KwezT+Pk2zUcEG1c8jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5783
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_28,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306050123
X-Proofpoint-GUID: wrA6gLIFLZu71Tjn13NJPYKyAuA0-G1i
X-Proofpoint-ORIG-GUID: wrA6gLIFLZu71Tjn13NJPYKyAuA0-G1i
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230605 03:59]:
>=20
>=20
> =E5=9C=A8 2023/6/5 14:18, Yin, Fengwei =E5=86=99=E9=81=93:
> >=20
> >=20
> > On 6/5/2023 12:41 PM, Yin Fengwei wrote:
> > > Hi Peng,
> > >=20
> > > On 6/5/23 11:28, Peng Zhang wrote:
> > > >=20
> > > >=20
> > > > =E5=9C=A8 2023/6/2 16:10, Yin, Fengwei =E5=86=99=E9=81=93:
> > > > > Hi Liam,
> > > > >=20
> > > > > On 6/1/2023 10:15 AM, Liam R. Howlett wrote:
> > > > > > Initial work on preallocations showed no regression in performa=
nce
> > > > > > during testing, but recently some users (both on [1] and off [a=
ndroid]
> > > > > > list) have reported that preallocating the worst-case number of=
 nodes
> > > > > > has caused some slow down.=C2=A0 This patch set addresses the n=
umber of
> > > > > > allocations in a few ways.
> > > > > >=20
> > > > > > During munmap() most munmap() operations will remove a single V=
MA, so
> > > > > > leverage the fact that the maple tree can place a single pointe=
r at
> > > > > > range 0 - 0 without allocating.=C2=A0 This is done by changing =
the index in
> > > > > > the 'sidetree'.
> > > > > >=20
> > > > > > Re-introduce the entry argument to mas_preallocate() so that a =
more
> > > > > > intelligent guess of the node count can be made.
> > > > > >=20
> > > > > > Patches are in the following order:
> > > > > > 0001-0002: Testing framework for benchmarking some operations
> > > > > > 0003-0004: Reduction of maple node allocation in sidetree
> > > > > > 0005:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Small cleanup of do_vmi_ali=
gn_munmap()
> > > > > > 0006-0013: mas_preallocate() calculation change
> > > > > > 0014:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Change the vma iterator ord=
er
> > > > > I did run The AIM:page_test on an IceLake 48C/96T + 192G RAM plat=
form with
> > > > > this patchset.
> > > > >=20
> > > > > The result has a little bit improvement:
> > > > > Base (next-20230602):
> > > > >  =C2=A0=C2=A0 503880
> > > > > Base with this patchset:
> > > > >  =C2=A0=C2=A0 519501
> > > > >=20
> > > > > But they are far from the none-regression result (commit 7be1c1a3=
c7b1):
> > > > >  =C2=A0=C2=A0 718080
> > > > >=20
> > > > >=20
> > > > > Some other information I collected:
> > > > > With Base, the mas_alloc_nodes are always hit with request: 7.
> > > > > With this patchset, the request are 1 or 5.
> > > > >=20
> > > > > I suppose this is the reason for improvement from 503880 to 51950=
1.
> > > > >=20
> > > > > With commit 7be1c1a3c7b1, mas_store_gfp() in do_brk_flags never t=
riggered
> > > > > mas_alloc_nodes() call. Thanks.
> > > > Hi Fengwei,
> > > >=20
> > > > I think it may be related to the inaccurate number of nodes allocat=
ed
> > > > in the pre-allocation. I slightly modified the pre-allocation in th=
is
> > > > patchset, but I don't know if it works. It would be great if you co=
uld
> > > > help test it, and help pinpoint the cause. Below is the diff, which=
 can
> > > > be applied based on this pachset.
> > > I tried the patch, it could eliminate the call of mas_alloc_nodes() d=
uring
> > > the test. But the result of benchmark got a little bit improvement:
> > >    529040
> > >=20
> > > But it's still much less than none-regression result. I will also dou=
ble
> > > confirm the none-regression result.
> > Just noticed that the commit f5715584af95 make validate_mm() two implem=
entation
> > based on CONFIG_DEBUG_VM instead of CONFIG_DEBUG_VM_MAPPLE_TREE). I hav=
e
> > CONFIG_DEBUG_VM but not CONFIG_DEBUG_VM_MAPPLE_TREE defined. So it's no=
t an
> > apple to apple.

You mean "mm: update validate_mm() to use vma iterator" here I guess.  I
have it as a different commit id in my branch.

I 'restored' some of the checking because I was able to work around not
having the mt_dump() definition with the vma iterator.  I'm now
wondering how wide spread CONFIG_DEBUG_VM is used and if I should not
have added these extra checks.

> >=20
> >=20
> > I disable CONFIG_DEBUG_VM and re-run the test and got:
> > Before preallocation change (7be1c1a3c7b1):
> >      770100
> > After preallocation change (28c5609fb236):
> >      680000
> > With liam's fix:
> >      702100
> > plus Peng's fix:
> >      725900
> Thank you for your test, now it seems that the performance
> regression is not so much.

We are also too strict on the reset during mas_store_prealloc() checking
for a spanning write.  I have a fix for this for v2 of the patch set,
although I suspect it will not make a huge difference.

> >=20
> >=20
> > Regards
> > Yin, Fengwei
> >=20
> > >=20
> > >=20
> > > Regards
> > > Yin, Fengwei
> > >=20
> > > >=20
> > > > Thanks,
> > > > Peng
> > > >=20
> > > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > > index 5ea211c3f186..e67bf2744384 100644
> > > > --- a/lib/maple_tree.c
> > > > +++ b/lib/maple_tree.c
> > > > @@ -5575,9 +5575,11 @@ int mas_preallocate(struct ma_state *mas, vo=
id *entry, gfp_t gfp)
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto ask_now;
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0 }
> > > >=20
> > > > -=C2=A0=C2=A0=C2=A0 /* New root needs a singe node */
> > > > -=C2=A0=C2=A0=C2=A0 if (unlikely(mte_is_root(mas->node)))
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto ask_now;

Why did you drop this?  If we are creating a new root we will only need
one node.

> > > > +=C2=A0=C2=A0=C2=A0 if ((node_size =3D=3D wr_mas.node_end + 1 &&
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mas->offset =3D=
=3D wr_mas.node_end) ||
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (node_size =3D=3D wr_ma=
s.node_end &&
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wr_mas.offset_end=
 - mas->offset =3D=3D 1))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;

I will add this to v2 as well, or something similar.

> > > >=20
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0 /* Potential spanning rebalance collapsin=
g a node, use worst-case */
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0 if (node_size=C2=A0 - 1 <=3D mt_min_slots=
[wr_mas.type])
> > > > @@ -5590,7 +5592,6 @@ int mas_preallocate(struct ma_state *mas, voi=
d *entry, gfp_t gfp)
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0 if (likely(!mas_is_err(mas)))
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > >=20
> > > > -=C2=A0=C2=A0=C2=A0 mas_set_alloc_req(mas, 0);

Why did you drop this?  It seems like a worth while cleanup on failure.

> > > >  =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D xa_err(mas->node);
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0 mas_reset(mas);
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0 mas_destroy(mas);
> > > >=20
> > > >=20
> > > > >=20
> > > > >=20
> > > > > Regards
> > > > > Yin, Fengwei
> > > > >=20
> > > > > >=20
> > > > > > [1] https://lore.kernel.org/linux-mm/202305061457.ac15990c-yuji=
e.liu@intel.com/
> > > > > >=20
> > > > > > Liam R. Howlett (14):
> > > > > >  =C2=A0=C2=A0 maple_tree: Add benchmarking for mas_for_each
> > > > > >  =C2=A0=C2=A0 maple_tree: Add benchmarking for mas_prev()
> > > > > >  =C2=A0=C2=A0 mm: Move unmap_vmas() declaration to internal hea=
der
> > > > > >  =C2=A0=C2=A0 mm: Change do_vmi_align_munmap() side tree index
> > > > > >  =C2=A0=C2=A0 mm: Remove prev check from do_vmi_align_munmap()
> > > > > >  =C2=A0=C2=A0 maple_tree: Introduce __mas_set_range()
> > > > > >  =C2=A0=C2=A0 mm: Remove re-walk from mmap_region()
> > > > > >  =C2=A0=C2=A0 maple_tree: Re-introduce entry to mas_preallocate=
() arguments
> > > > > >  =C2=A0=C2=A0 mm: Use vma_iter_clear_gfp() in nommu
> > > > > >  =C2=A0=C2=A0 mm: Set up vma iterator for vma_iter_prealloc() c=
alls
> > > > > >  =C2=A0=C2=A0 maple_tree: Move mas_wr_end_piv() below mas_wr_ex=
tend_null()
> > > > > >  =C2=A0=C2=A0 maple_tree: Update mas_preallocate() testing
> > > > > >  =C2=A0=C2=A0 maple_tree: Refine mas_preallocate() node calcula=
tions
> > > > > >  =C2=A0=C2=A0 mm/mmap: Change vma iteration order in do_vmi_ali=
gn_munmap()
> > > > > >=20
> > > > > >  =C2=A0 fs/exec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > > > >  =C2=A0 include/linux/maple_tree.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 23 ++++-
> > > > > >  =C2=A0 include/linux/mm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 -
> > > > > >  =C2=A0 lib/maple_tree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 78 ++++++=
++++----
> > > > > >  =C2=A0 lib/test_maple_tree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 74 +++++++++++++
> > > > > >  =C2=A0 mm/internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 40 ++++++--
> > > > > >  =C2=A0 mm/memory.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 16 ++-
> > > > > >  =C2=A0 mm/mmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 171 ++++++++++++++++---------------
> > > > > >  =C2=A0 mm/nommu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 45 ++++----
> > > > > >  =C2=A0 tools/testing/radix-tree/maple.c |=C2=A0 59 ++++++-----
> > > > > >  =C2=A0 10 files changed, 331 insertions(+), 180 deletions(-)
> > > > > >=20
