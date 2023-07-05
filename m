Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4320749159
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjGEXKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjGEXKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:10:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C330E57;
        Wed,  5 Jul 2023 16:10:09 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365Md4CM021131;
        Wed, 5 Jul 2023 23:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=r4X6QMVv7Srfjk96jl2X6Nh6bzc0RYxEV3OTS8HIMgA=;
 b=O+hIiPbXDi9YkSX5CQKX7l948odWeXD2iL1BkNjwzw208Dzg5GIm1wO6Pa60HID15kqT
 avECnsFuOwwx63bp1SsthcPecROuAhxGt2ISsKZNegVLuUdrzHcWr6XUYh5uV125X8qF
 pu97hnDc+AScviuxjrdu5JbqxZ5anClPTNRqBq/3Vo0ZCkorNlwB5ZxMvlFH863/Ytad
 4z/J+xtdewHZxqEZQ8AZVc455Rmniww1xlnX+fbmsP44LnPSvjcsgAk3y+JKiCYuvWvC
 EAfmjMs8TkSc7Cgwozbpvh0QcBbSWsIO2JOW/haiVkQVFZKjTyD8WMmm/Z+JsisPj66Y MQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rneqqr9tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 23:06:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 365Ko2sd007129;
        Wed, 5 Jul 2023 23:06:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjakc7cg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 23:06:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HH0zlkHM0tdu3PnTIdGUF5zRLcFPEi9oF/Oa/NkqZBH51PI5PEVtOpMWGe1VutemAqPzHu2qSRgBl2FRMTasTFgsulccrzScn8hAYhpeKvOAhFjwNN67+v7oVO9MaM6myYwSdlCCzSoJWA1pHawD3E/jrCk5QwH8gEK45VXbAzJPIVSH0Q6IN02d5cIklW4w+6WWK4fO469I3WEnH6/Tnbg5W3MPmr79P+rrO5jfQjMHu3eR4o44DMcRipF7EI19Z8q1GfeE+KG5HhU2NIYkPQtmJQfwuLYgn5bv1tVf82biZyDfBVedW1GMy08dHQ2KI5e1KxkbLxLuOKN2NrZ0YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4X6QMVv7Srfjk96jl2X6Nh6bzc0RYxEV3OTS8HIMgA=;
 b=JaHJKWJl0zZIoX7qI8bv+VL/1qhfw1q7hGIiUT0i29b49F5QxwAO/6VE9CkSV3Gsi9D85P/XdosrqJOeDwsxybVno8QEGPRvD88+2tq73tNyDkX5xiGwevTxVcE7gKdy3lXEZCZY3Qy03YEXJ+tzKxlx81JsHQQPm2XFJb0Kf/Bb/83MmvSnm3557fEI5MMI3zItHa4DRWozS/+a6b2/Nx77mFcpyJ7mddp/jXgva+mkxlp+1CQn7z9xYqj2kjJustQTmSFHmArP5EFvHik7tddZ+yP0HkopuFJa1BBAFb4sfA+ktEzZm2nrLG8RciqIE1D7t1dbvXaYdc/ekDcPjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4X6QMVv7Srfjk96jl2X6Nh6bzc0RYxEV3OTS8HIMgA=;
 b=g3AHjDCgeiGAAJiBIiOQDLdHG03IrhOU3XVnNM7hVNQs2f/t4u/Ybq1zDGo9CjnN9EjrqIQBXmKp7WSFXPXquW8I73yQRfX1R88SObNNiEIE1W2k8PFArpp32PU3NKDwNYRFZ+iCnNwgZ2eOLqxHzXBfMuV/2LON27G4jNTugVE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB5723.namprd10.prod.outlook.com (2603:10b6:510:127::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 23:06:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 23:06:52 +0000
Date:   Wed, 5 Jul 2023 19:06:47 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        jirislaby@kernel.org, jacobly.alt@gmail.com,
        holger@applied-asynchrony.com, hdegoede@redhat.com,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] fork: lock VMAs of the parent process when forking
Message-ID: <20230705230647.twq3n5nb2iabr7uk@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        jirislaby@kernel.org, jacobly.alt@gmail.com,
        holger@applied-asynchrony.com, hdegoede@redhat.com,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230705171213.2843068-1-surenb@google.com>
 <20230705171213.2843068-2-surenb@google.com>
 <10c8fe17-fa9b-bf34-cb88-c758e07c9d72@redhat.com>
 <CAJuCfpFBh647trAjgPfr0Wcd=7V2gbHUnBe8mR4Pgdmrzh6Hxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJuCfpFBh647trAjgPfr0Wcd=7V2gbHUnBe8mR4Pgdmrzh6Hxg@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: MN2PR20CA0034.namprd20.prod.outlook.com
 (2603:10b6:208:e8::47) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a5106f-f388-4fa5-1f94-08db7dac84e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zmidAvYrLwis8NZkVXr1o5c46AeuOEbsZ2f9lxEQALEnqtoof/FZ9q3eswTUbGlsdJdX59gzGbHPfK33BYeWk6/Zw+d6MpIWBm3tR862z4IAB/OPoHVnop2CBUTl+VTBIgklDs1WYIIC8De19p5EDKTYpPULyZXDmGnKlG3xHZhGUiUSffEyFgQzpa2GDqzzrAoGWNrU0o2jHlth9CzefYURwbHbt+37eb7JcJXPNXVvnZp3bVOTm26LCHpLE3hZuAVV4ys5wSGyqZR+prdMIaQe6+UlD/4vpZNKgvWj1NxfGkTx6GWg5ziNERM5Yx5iAsaqony3IKoV2JiQxJFeuLbeqA7Xlnyh+yEFgOrhfs5iYrMpF7VmC90WsJen+Roa4Jrm/yt+8fk5zKAU2C8QcbxDslEXFe2a9FcxDfSvh21fZuwvoGDBeCSg5md6vjat4M+R8JH3R3iDn+uUgir/gl20EPHTGdod1JViEATAkVRqOnU8TWSs0YPwwzdKnX8jMpZOHfS5qZQvRdZ2AX9wn0ZWkRfw9pumsCLhlbReZx5U3BsE0RmI6CwxsVxoGHMZ4/92wZANQ14B02L9n7pW6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(6666004)(6486002)(478600001)(83380400001)(66574015)(86362001)(2906002)(33716001)(66946007)(186003)(6506007)(53546011)(1076003)(26005)(966005)(9686003)(6512007)(6916009)(4326008)(38100700002)(66476007)(66556008)(41300700001)(316002)(5660300002)(8676002)(7406005)(7416002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anhhZGw4eHBhOVJ2RkdDb2ZpY2ZlTVhaWjBCUkhTOWlMRExpUi8zdGFydDlQ?=
 =?utf-8?B?NGFub2IzeG1Rb3NxS2lpM0tvNkFMdGZ5Wkh2TlU3Wm1JUm81UGZ3dVVpOXlR?=
 =?utf-8?B?RnRmQ096NHd4UWtQWnNJTHY0SjZWb2ZqVlczTC8rRU1Tc241bEQ1NWhpbndW?=
 =?utf-8?B?bVBqc2FSY0NPQTNVWm5ybU1TT3U5RmJVMVltamlvekxzVFRiWGFzbmFMREhu?=
 =?utf-8?B?eUx0SzNaQjM3NC9PL2lnWXRtT0MyUWxReE4vRXIvd3o1by9xMlFNUjZZLzZh?=
 =?utf-8?B?UnZ5dlNRam8xb05XOFNUT3haSWVhRVl1WTdSS2xGQVFiL1Z3RFhwU21uWXRp?=
 =?utf-8?B?Sy81TnBzVkl6Q2QwdkZVYmxjR0FHUXRJZGp3RlFsajNsMWxRU21xQi91cWtM?=
 =?utf-8?B?bGErbTlMWXEva29xTk8zeW1YcXNONTdzREFabGtQYituTFJBQ0pxbDdUU1Nm?=
 =?utf-8?B?TXpoTC9LRTFSVHdzbUdxLys5NHhVN0d4QldibFM0Zm9jdUtjN1NNM0V3U29t?=
 =?utf-8?B?UWVpQTJKZkNOOEtnUEM2L0dwUUQ0SE5ndktObTJtSmx5SERTRFkybFBiNzBz?=
 =?utf-8?B?M0ZyQTMyNEFZUEt3cEZPU2ZpeExNWXBJckd1TTVNYWlIWGxVNndKZHNMZ052?=
 =?utf-8?B?NW0vNTU1aTZJUXhKUXlqRFFHaytXcm5qcHFabFlhWHFOc1A0QWJOMW9uV0pr?=
 =?utf-8?B?anJ4NURwT2R4ZlI1a2hjazU3NDdIS0lRUURENldLcjM5OGRJZG5mZ1BNdnpN?=
 =?utf-8?B?ckJZMFJLMk85S1NMMWxzdE4wWDk0SEExaDRVZmdEVWcvMkN5WDlpR0VibWFS?=
 =?utf-8?B?VHRXcEs4bU9JenFleitnV3hWWjJpTUp6dHUxdnJjMjhDNVpML0NDZ21semt4?=
 =?utf-8?B?Nkk3Nmd6UjRXa0NYbHNQVE43RGNtNzhMb3dLbmYwYWsxOFRDWjhHNXFQVFZL?=
 =?utf-8?B?ektmOGhIZXFxQkFmMVpWOXJzZ293T210eWg3WUV2eUhTbHpiT1I5Szlmdzdy?=
 =?utf-8?B?L3E5dE4raGlIbjlWeWR3RXNHbU5qMlN1MXd5Ymx0NDZtY1hRMmowd2NGOW5x?=
 =?utf-8?B?YnRlaG9jRjExNk5RbE9rMG5GdkcrUFAyaHB3VXM3WlB1TkwyaXBVN3NRYVZK?=
 =?utf-8?B?anBkLzdIS2J0dlkvWk1mNmV5L2ZHbysvcnhIMWdRYytwNGhiRmI3MEFoZjFJ?=
 =?utf-8?B?Yk5pSGtsamwyQkdPNUl6cU9HcThIQ2l5NS9GMWRleXlicUFXUTVMaVJsVmxE?=
 =?utf-8?B?a3Z1NmEvRU5xNU5mWFBJa1lnYUd0K011K2ZTSWczRG9yYmI5ODhEdEdXeVRk?=
 =?utf-8?B?bWx4TWEyWXhaYjVva1NzUm1tYnQrT09TWEVySlVFSEtzMllMSmFYekhJT1lT?=
 =?utf-8?B?TUtYajNlY1A0dlZXWGl0VVRraW93czdZUkw4RjVmNVBZMy9OcEN2bWNqT3N2?=
 =?utf-8?B?d0IvNjFFZWpXdWRIV2lsTEU2WGFXcFp6T0VaZ1MyMTUrTkNBcnRGQ0VFN2p2?=
 =?utf-8?B?Nzdlb1pSYW15dThzS3JiUVdocmNIRS9qS1BCcjhmdVh6elRhemc3QnM2QVBS?=
 =?utf-8?B?UDlBUEJZNXNZWkhGazdYMSt4T1JLZ0UyZFRUeXN3ZDdjZ3dyaTR2cjRIY2NP?=
 =?utf-8?B?Nmt4QTQzZnovS1paai94bWdKZ3djaGlRcDBRRzdLZm5Cb3NQY2pVNHozSENV?=
 =?utf-8?B?UisreC9zdUIwaWVUVWtQV3VpT09WKzRLSFpTd3FDNzBXcE9IM216aElxanBW?=
 =?utf-8?B?dUhzNmhzWTBORmVzSmhoN3lIcWZyYjYrNVE0RE4rTHA0V2lNTGFJQ2N2Ryt5?=
 =?utf-8?B?WUpYckdwUGJEdVRQVXBEbXNlQXV3TlFISkxYZUYxQU9TM2l4R1Z2MjlhaGNB?=
 =?utf-8?B?RE9rVFdJeWtXYmxOOVpQWGFYb1FBc2N6ZFhXdHQzSmRlREdpRUZrSllGb1NJ?=
 =?utf-8?B?dm1ZYmdZNmg2bFY0UE5RZFNmOVFYUHJHZnBVNmVlQVdwL1lzbXNDTVVDTExn?=
 =?utf-8?B?OXZmaXIvZWcvZ3VUd2UyNHJyMWZnMjdkWkxCVnU4b3QwWHIvd3psOGYzWG5n?=
 =?utf-8?B?aHQ2LzdzT2RpMExYU1VXNVhQNVc3SWpEemtka0FSUTQ1ODdpVmc5OE9ZS3pW?=
 =?utf-8?B?K05Fa3MrQXJWL0RKMTJra3daRGtDWSthY1BGbThwZGRRSUdyZ2lRb2xyS0hH?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?czdTdGdOSkU5N21ReEdQeFhVdEVqU09FU2sxOXZEbVIrekZUZ1prMWlxSGFB?=
 =?utf-8?B?RDg0RUJXb1N0Z1F5MjVYUFFhT1FVVEprWU1CV3k2Z21kNW10LzRBOVFERlhi?=
 =?utf-8?B?NWdDamhyZFMyQ1hRdVJIUnJGcmNmZjA0WlU2N0J3OElFa2E2RGsyWUt1VExU?=
 =?utf-8?B?NjJQZkxsZ01rY1hnWFliQ0lUMEZOdnhYS09kU1RqWmJHZldnNjR3dVF2ZnJS?=
 =?utf-8?B?L3JCeDNRcS9zeUk2cEE5OTZKOFpJT3FOenVZMUc3MmtJb2RKQWE3MXgvakJ4?=
 =?utf-8?B?a3ExbU1xR0hXb1dncmpzOTFWZTR1NFBuY293Y1IrNlhidmxxWmlWRnFYK3JJ?=
 =?utf-8?B?WU1TcUJrQmlrS0RYME5sRVZPM1dHUlZWRGgwZFd5ajNONmFQL1BaNjE2M21H?=
 =?utf-8?B?Uy9pNDNWWHcwVUNMY1I5TzY2cmNwOE92QkZWUTRuZEc1U1A3bXBqTmdOUDFY?=
 =?utf-8?B?NU5nVTdONUkvYUUxaFRQZHc0M0s3czFmMkllL3R4VUtlaU9sRUNhOS84SnJw?=
 =?utf-8?B?MFlJRER4TjRGdzNtVlowUjhHMFhMV3E3cmlkM2NyTy9XQUNvNW1XRmdJV0Fq?=
 =?utf-8?B?Q3hpYTE3bEQ5V3JhNjNNbFRWN1l0M0VKUjdXUnNBNnpWYkJ1RHc4cUlXQ0Zk?=
 =?utf-8?B?YStEemJSNmFtQkVLTVlsNG1EZWp2dDkxTTlRTlNZZmgvMGJUZ0tqSHRoYlVX?=
 =?utf-8?B?cHBjdGdRM0tRNCtVKzVqNThSRDJDLzFWYllPbHhzd1JtellSSUtLU09oNFJR?=
 =?utf-8?B?akE0ai85Z2dLMFAxYnM5eUNGWHVXZEloMzFtZWwvYzFCRC91QjhvRitmN3Rm?=
 =?utf-8?B?cERyN3NCZWFoQTdkRFRKTXpSUWc4dUZHK25OMitRbVFpZ1F0VnRaWExSQWQ1?=
 =?utf-8?B?U2RsT1hDWXF3V0pGRC80ZlNBcUQzK1gybFF5QWJrSHBxeWZVV2lZSjVZTld3?=
 =?utf-8?B?dWMxVnA1dkQzbzMyUVU3ZDdpN08rcjVaYUhCQmhlNS8zZ1VOM2M0dmF0SzYx?=
 =?utf-8?B?Rm1SSTZaTVZjTmJhZmo4UTlIODVmQ2JwUTA4eWxXWEJ5d2Y5M1BaSlJzYkww?=
 =?utf-8?B?RGlQMENCUGJkQnJ3NlhCaFVKSjBMR3JZOXZoalJwWVdsNTYrUUp6V0ZmN2hj?=
 =?utf-8?B?dVJvTGh0ZGJ5N2FKaXVmeWNUamViakFwR252Y2txa3ZUWE5vVGNoYjhjejd2?=
 =?utf-8?B?aG5MZHJjeHg1V0NrcVFycC9TNzdlenVSUnQzdThnMmc0b3I2ejNCYW1TQlZq?=
 =?utf-8?B?Vk90UXNlNGdLWGdIalR5Rnd0d3Q2Q3U5MVJyVlRNUnc0dTdaMFcwV0JzOURy?=
 =?utf-8?B?OWk2N2J6a3ZNZTIwU0ZXM3hhYnpCbUhGaVl0ZklzSjhtUzdHSzIwSVdoOG9j?=
 =?utf-8?B?OXhZN2QxbzBxYmo3SERRUjFYRk9INWtTaldDdWlwcmFZTzJERUVtZTRGNmZp?=
 =?utf-8?B?ZzlXUjJ6OU9VMFgxRG5jSVQyc0dTczQ3QlhlMGRBUmRwZ0pKT0ZvV0g5eG9u?=
 =?utf-8?B?NWxlMTN4cmMvc0JLaXZ0bTJUMjhGM042T0diUGgrTTcrTitRV3Rsd0tlZy9h?=
 =?utf-8?B?a3BiM3ladHBOcUxiM3BsZldGdVJJZWNQYnFISDF2YTNnclFIaUFhd0NFVk9S?=
 =?utf-8?B?RHptU0taYk9LQ3AwcnRuYmVzZHVmWjlGb0xCWjRiQ3M0c05WS1lPbkZYdEdq?=
 =?utf-8?B?M0NEWmE4R0RKdnpxcVQ2aVBFYWF4YzRIc0NWTFd2MUhhVEk2cDdyNCtjV1NR?=
 =?utf-8?B?dHIxSEZmNWRVY3Z2SlNLcmlDZnBWODVGWTM1N0ZRRExZcGhUc1NGUUtnN0dZ?=
 =?utf-8?B?RUdMdjNkY0lDUlFucGdBR3QzTDNtcWErTjZkSUVGeHRESmVaK0VhNGZrV3Rz?=
 =?utf-8?B?T0E3bThZUXpHYktITjVBNzkzVnYxd3FNV3pOU0Q2QW9KMGhXanFQNm1vaEgy?=
 =?utf-8?Q?8B/OEyKwY4I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a5106f-f388-4fa5-1f94-08db7dac84e2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 23:06:52.1766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHzuwDa80vL5CstTesGrW0OAldvezAU8IobsvPMkzpq3r6sQMbvpe/LtpiyNBTuYCQ5XioqL0591DgYrRzwP5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5723
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050208
X-Proofpoint-GUID: JVfB50Dize9eCBPAUes83y5QyV4HX-AT
X-Proofpoint-ORIG-GUID: JVfB50Dize9eCBPAUes83y5QyV4HX-AT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [230705 13:24]:
> On Wed, Jul 5, 2023 at 10:14=E2=80=AFAM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 05.07.23 19:12, Suren Baghdasaryan wrote:
> > > When forking a child process, parent write-protects an anonymous page
> > > and COW-shares it with the child being forked using copy_present_pte(=
).
> > > Parent's TLB is flushed right before we drop the parent's mmap_lock i=
n
> > > dup_mmap(). If we get a write-fault before that TLB flush in the pare=
nt,
> > > and we end up replacing that anonymous page in the parent process in
> > > do_wp_page() (because, COW-shared with the child), this might lead to
> > > some stale writable TLB entries targeting the wrong (old) page.
> > > Similar issue happened in the past with userfaultfd (see flush_tlb_pa=
ge()
> > > call inside do_wp_page()).
> > > Lock VMAs of the parent process when forking a child, which prevents
> > > concurrent page faults during fork operation and avoids this issue.
> > > This fix can potentially regress some fork-heavy workloads. Kernel bu=
ild
> > > time did not show noticeable regression on a 56-core machine while a
> > > stress test mapping 10000 VMAs and forking 5000 times in a tight loop
> > > shows ~5% regression. If such fork time regression is unacceptable,
> > > disabling CONFIG_PER_VMA_LOCK should restore its performance. Further
> > > optimizations are possible if this regression proves to be problemati=
c.
> > >
> > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > Reported-by: Jiri Slaby <jirislaby@kernel.org>
> > > Closes: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf=
51b@kernel.org/
> > > Reported-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
> > > Closes: https://lore.kernel.org/all/b198d649-f4bf-b971-31d0-e8433ec2a=
34c@applied-asynchrony.com/
> > > Reported-by: Jacob Young <jacobly.alt@gmail.com>
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217624
> > > Fixes: 0bff0aaea03e ("x86/mm: try VMA lock-based page fault handling =
first")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >   kernel/fork.c | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > >
> > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > index b85814e614a5..403bc2b72301 100644
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -658,6 +658,12 @@ static __latent_entropy int dup_mmap(struct mm_s=
truct *mm,
> > >               retval =3D -EINTR;
> > >               goto fail_uprobe_end;
> > >       }
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +     /* Disallow any page faults before calling flush_cache_dup_mm *=
/
> > > +     for_each_vma(old_vmi, mpnt)
> > > +             vma_start_write(mpnt);
> > > +     vma_iter_init(&old_vmi, oldmm, 0);

vma_iter_set(&old_vmi, 0) is probably what you want here.

> > > +#endif
> > >       flush_cache_dup_mm(oldmm);
> > >       uprobe_dup_mmap(oldmm, mm);
> > >       /*
> >
> > The old version was most probably fine as well, but this certainly look=
s
> > even safer.
> >
> > Acked-by: David Hildenbrand <david@redhat.com>

I think this is overkill and believe setting the vma_start_write() will
synchronize with any readers since it's using the per-vma rw semaphore
in write mode. Anything faulting will need to finish before the fork
continues and faults during the fork will fall back to a read lock of
the mmap_lock.  Is there a possibility of populate happening outside the
mmap_write lock/vma_lock?

Was your benchmarking done with this loop at the start?

Thanks,
Liam
