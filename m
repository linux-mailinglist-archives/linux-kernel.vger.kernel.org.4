Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF30D7053B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjEPQ0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEPQ0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:26:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD67A19A
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:25:42 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GG4HHQ024776;
        Tue, 16 May 2023 16:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zMiy3wc6+2aah3369sgh6Hof2vKztLSRE5c9HDt6kHU=;
 b=m7/kFZiWNk2XcVLo6T8lCIfx0zh6M2alWeZ3PTK0Rzx+N+mMFfyULAwjYNoBp1DNLnSc
 IiQclr9cUu9Czu78whDwHDMBSPpsQsdM+YK1rENKT2iLrs5cgly7VhZ6uFQLWuaZTTRm
 39usvj0o2/As3NyirOgSoMMibeHmIvg2J6jEAd/Jj2KESwnv76gOfllduRcVSvviEMVw
 JJlpewVZuOsuu3Yxd0RFUxp5FR25b3vC0YCupixoxwYjnLODIfGT9GQRIgHQ0F/3ldb5
 AYhf4LconHxOT7gWlhjqw5+V8RMW+DWBVhCi552+s+6hQw6dHiz4Uy+wnMUHplw0Rxm3 pw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj33uu7k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 16:24:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GFMs4Y039953;
        Tue, 16 May 2023 16:24:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10425hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 16:24:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShItUuLDfXw1HEJddlkEGkN/QjBP4SEZbm+6QJowO+/3hWA/BBEZ7ZfBFFj3neb8+sIvj9PC0Zn4+C+U3o3wExkRTBfzoNdone9yZYHZ9rOWE0c2f3fAZ/jIEDeeYJ+HXI/A2YudyQ2gAslvLfe/l6ddLg7H2qbOU9TUoyKz/WLVBLedEL1Pg1JBLAF5sVtuZrq+olpUtJUmY+9igiLGUQJBEofw3ACI/JRLgZr73L8HfL7Kol+2Z8QQ1yikOJu85+z8fyec58sRS4qD6oSKdPuR3QM5nHDQmaispq91ze64nqm4QHGVJgk9h9V52PU0pWpctx5NnRqt3/W5bEfMfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMiy3wc6+2aah3369sgh6Hof2vKztLSRE5c9HDt6kHU=;
 b=UCFxC68Q5d5kZjfxvC+lCHaMqHRc+fIZ/Dq8JlPEsSzPO0j/sd+uUetCW3vanDNi1gT3N7IOyD8hmHj3YGa5U+Usn615B4hZtq99kxRKw0sWnFCtFHUy8aMWHDuLDz09+FEAA/OrooQM2/NRji23k1qc2p4KJAyCkWBQsYpsqQR0qNEUJ+IgQ/6UjgNC4dKvfBu+Ln0J88hhMFHxknrUz2YtLqKpyYlLYDPxli5Aaxts/AH9Fv4BgF+pXd0V+7EF6SHwZPum8lFjL/28fL4778Yptkq4mu25v9j5eWNJfYDqc5A4/R3at8GerJ7xugPjVowWZtu3ONVGG5i2DRvheg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMiy3wc6+2aah3369sgh6Hof2vKztLSRE5c9HDt6kHU=;
 b=hx1eedQjLsLx0vHf5nVumdm1RgHR3Gp3N5O/ar9jQ7LaRwrQ6ffVCDTLUw/q4iBTcEmAKxpjg/iJ/eBzOmKsAobqSakwl5i8M0yHyP5SHrEnC63ouQjwUPdSdRp6D9flLf2OQGvgI/q/+VJ8JDDtrirpJIbyJucWnxTbMY3jMg0=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SN7PR10MB6641.namprd10.prod.outlook.com (2603:10b6:806:2ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Tue, 16 May
 2023 16:24:50 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 16:24:50 +0000
Message-ID: <683d0c30-4aeb-3547-49a9-90ce6eb1a7d0@oracle.com>
Date:   Tue, 16 May 2023 11:24:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>, nicolas.dichtel@6wind.com,
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
 <20230516-weltmeere-backofen-27f12ae2c9e0@brauner>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230516-weltmeere-backofen-27f12ae2c9e0@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR08CA0032.namprd08.prod.outlook.com
 (2603:10b6:5:80::45) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SN7PR10MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b9e564-7c34-4956-1568-08db562a1281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w9kCo6lbOE+pjQzcFyOgKGl4mY3wD/C2+cdKb/mBMVuYUIqHqauQJ1iGyUBfGhy8PfcpTWOg7A7xCHLizz1QwNIdHeVW3azTuUaiXFZ06UQVqdhzFj/5skQjtmRtR2TWPf8xPexJ+61wmy0ZXcxDeY8Hc0X7Bmdbn1D65Itk7yfwTKMA6iYxj3BYuVGiR/oR9tZu8ZA01LTS3yuuQhsfIFpTeph0CdFX3ktXAInY8MUIbWwyClXiPE2Z2Zuf+4PUt46t5qZX9kGTCb5SLiMULkQUgvcK6Cm2cEbFQyCyClls/XT1wHA+o/3rYM1bO+vp3k73qFcZp+QwKqvdkhBUYYwVnajQKJwVQba1OX1nW5kBuJiRYQMIXIuPNGXTU3nifaWt0jFgrrYWBLZh/MqAlFBDqX7bpvStzovA59a9jlFBPhs1/wasZ7lN1C7oz1ATsA/JybGW2U71HS44KnL+j/jXsVjTbl/eelSoe4c6K0fyMyR+dEt+yb+OWeQ5RRPPgFkzb6K+wH/TNWpQGnDRBAzkmEvi1lsOYkq8Gj7EY3WyZR58YJNhu/r5cdx9T4WIPa16cGhJopRs5XulmBu+qmxEXndY1jFU9IkZt0Ej9+dtmSX9qAEb8TTKRtLj/pJCK5G3pJ5sadecGpeQmnJzJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(38100700002)(36756003)(31696002)(86362001)(5660300002)(7416002)(8936002)(8676002)(2616005)(316002)(6506007)(26005)(53546011)(6512007)(66476007)(66556008)(110136005)(54906003)(66946007)(478600001)(6486002)(31686004)(4326008)(186003)(41300700001)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzhzdXNCRmNkcUJvZitRc28zVk1FNFNSN1FxTm83OElCY0FJVkN1NEJZK25R?=
 =?utf-8?B?K2o5Y1piVnpiYTZMNEQ1L0w3amlObUxUL29KN1RWbTdwUHBXcmtkZlVkS0Rn?=
 =?utf-8?B?T3p0b1pBUHhqMEZXWWdPZ1RFdXh3a3lYRERwNkFFZEtJOG9lNWZkU0lqRmJ2?=
 =?utf-8?B?dEJkS2lPVzltWVZ6SFlsamJDYyt0RHpWSGN5SjUyMHU1d3IzK1ZYc2RtR0Vq?=
 =?utf-8?B?YlR6YUZNRDBOcEpWOGRvcXhkRERsa2NFWUdiY0xEQXRxdVpxelhMSnV6WmQw?=
 =?utf-8?B?eS9sVnFoUklsWUNKVFN1Z1h6T1RYTTlLT3FoUDlmRmVUQllBcDByMlBFbUdV?=
 =?utf-8?B?NEZGQjBMNlNIazFRclpmK3A3QUFSeUFhelk5K0J5NE9MUzY0Y3p2M2J3eWph?=
 =?utf-8?B?SHBzZ3doR2NCbVJtNHBTcWdudHYvM2F3cHRWVkh5REVRU09GMjlLakVDbzh3?=
 =?utf-8?B?bGE2UlNUZUhqdTJFZ1REZTZJVXpOelBpb1dyaEF2ZnRkc2o1Rm9mZXZlanNF?=
 =?utf-8?B?emFFNldzalNuNk8wTmhFSCtnb0MxdHZ4dXlIQkU3N09vS3lmQmR1RW1KSHdZ?=
 =?utf-8?B?Y2I5aUF4T2ZoTllXOEFhTDY5MG9QSlF5RExIeWY5b2ZCOEdxU1ppMG1heUVr?=
 =?utf-8?B?c3hGWjZGaFo1V0ZTcjM1Zk8wNmMwOXlhUkh1ZjAxMXRjVVF5RmdQUG82bUdk?=
 =?utf-8?B?QXRwVTRkV2xMaHpSd0xRbWJEZkNaaGRLYnFuY2lOT01WQ1RYSmR1YTF0aHNm?=
 =?utf-8?B?Z0QyRklIUGdoK0VXWmNJb3ppVG1aLzRxbzVJdlhGZWw3bWN0dkVQSiszMjBy?=
 =?utf-8?B?N0NSd0I2WmFXRlJkYWdTUUs2VWk4UFBRL1hqeTRDRUVhNGkvVWVJamowN3VP?=
 =?utf-8?B?ck90SUwwcUVnUHJrVHlwMVF5N25kZGIzUkl3Q3JnbVBtTU5ZZ2FTdEpaWk5t?=
 =?utf-8?B?L1lKK2F1ZzcvUStpdGxCcC9KYUw2TG9RdXJoZTdUZkI3UW9HVHJHdWNEQmdK?=
 =?utf-8?B?R3pOQnBZNkJQQWREUDg2NXNsSHFNeEZZTHdpRWl3SmlJL2VFM1I5ejh1NFY5?=
 =?utf-8?B?WTFlMGRvdDZQQWtuV1pBZlFvczQzcUhiWWRIZkVTb29PZ3NlOFQ5QmNBZkJB?=
 =?utf-8?B?N0xXQmVvWmQ5SDVYL1ZEam5HdXBvcStlOW9OZERObzdTb1FURVFqR2VWYjZa?=
 =?utf-8?B?R2VQZzE2aGNrVXJsajJYTEFVaWpSb1Nra0wwVFA1M2dxYWJ2R0kxWjhEdnFS?=
 =?utf-8?B?a3YxbmhMSVZTa1BGNk5EL29Iem9IdFUwWWRwNzZBd0V1d0JPbVQ3bFIwajJq?=
 =?utf-8?B?Ti9SUVhhZ1FvcTJTWGZWMFdXR285TVVoRFBkdEpmaEMxcVlRa0trbCtKcEow?=
 =?utf-8?B?cDBFU0lwTC9YQi9YR01pUEdVeUt6MmsyY2pGdnk5QUFGaGFmdTh3LzhMRjZF?=
 =?utf-8?B?SEtYelVUbGlFcmhqei9STnhJczlqb3dSZ2VKcStyOTZSUkUwV3h5VHJ3bFE2?=
 =?utf-8?B?Q0gxKzFGUFVLRzhra0FvZHkxeW03cU5mV1B0NFdyU2JEYzFjRS96R2IzbEZV?=
 =?utf-8?B?NHNyVWJWYms0MUhjM1FsUlFldWJlK3Nvd0E0STkrU0JibzRocFdSQ0VrOEJz?=
 =?utf-8?B?a3EvSzRUdi81d09EbzU5bWZQRWZRamd6Qko5YjNra2dkcVd4bGFRaUFBWW9i?=
 =?utf-8?B?MmtianF3NWNMc2FSRFlHVFZhTVF0L1krY0JxbmFhU0N5MVQxWmp2UVZaRjRv?=
 =?utf-8?B?ZXlpanFQeGIxeWdVSWJHbUx1MDgzek1YTURkeGFNY0tLWjBHRVVXamFreThk?=
 =?utf-8?B?K0czYXZFd0NkYWM1UHFpOW9obEFJRk9hYUxUUDFDVTE3S0NjRFgwdUtpL3lK?=
 =?utf-8?B?bXRCQWZWVWlKVEJTUVJDd1JCaEVzZGRVMXFIMFhKRlRBT09VOFJid3RxU0RO?=
 =?utf-8?B?NGtPS3dkQ0t6M05pNWlKSEVXQ2xsSnZNRVVjRzFPSk1PM21CSkRETUYrSk83?=
 =?utf-8?B?ZW5raUdjbzBWQjQwdGZVTHR6cTd1NGVXK2VUMXlqSkR1Z3ZHVXV4aE5hcDZy?=
 =?utf-8?B?eW92WmtWZDU5WGFEZXA0UENmcEdtVTV5NEtqbkNDQlFrcWxhcWdqdnFzY3Zw?=
 =?utf-8?B?b0ZTSUh0WENBMHladlhVanNYQ0NLTUtUWlFuUFlPT3hicHhPT2ttVVZpSFFl?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dWxZQm5aY1ZmajlVNHlGZmZZYkRnUVRhSGRkd0p3VUdxZThyTkRDVlZtYjAz?=
 =?utf-8?B?N0Z4QlpkNDdFV21MTXN3citsejNzaW5qZTJRcXhoWGM1bUJLZ2NDOXhHQ2Ez?=
 =?utf-8?B?WnlnSlU3RTVzcDF3d2dLZTcyT1l1MW1STE84MkF0MlBrbVBCekNJTmtVdEp6?=
 =?utf-8?B?SHVNMFloUGNMbFBIdnpMQk9MZWkvM1l1YWtwR1RhNEg3MnQyVnY1SHQrMFkw?=
 =?utf-8?B?ZUhCVkVUc3c2dXdpY05STUhpSTBKVk1DZnd1SlpsaEpUUmtkU2Y4U2lvWlBo?=
 =?utf-8?B?MTJmaHoxQ0ZBbHNBM3JqQjhHZUpqQytHUFJtdHZqU3lOMm5PNlRMaE9mRFNE?=
 =?utf-8?B?Rlk3djVBZTgyelBoSGp3YTI3RVlGOWlLYndybGkxeE81dEFiTWpsQ1F6b09H?=
 =?utf-8?B?Q1YrMzZOak1obGpKbTM3TDNmWnM0dGo3RXYzVWJsd0ZNZDNFZWE3OTlLbS8w?=
 =?utf-8?B?OThjWnJmVFpqMVErQ0ZFdW5zSHZlUmNWZUNxTDREQUxXbldkYW0zQTlONklK?=
 =?utf-8?B?SE5XV0E1ZzRMWUtYVGJhUkZlWGNKdjlORThHNklkUEJlRVhjOFR0MzNYWTg4?=
 =?utf-8?B?bzF0QktJTHQ4MkpDS0lValhjc2ZxMVl1WXFKemdOR3NpL0NGNnRMWEdvTGha?=
 =?utf-8?B?K2FvUVhmU3FTOTdQcXpZektIek5xMFpjVk0wZzZyd0JPY2hwUWtuQXZwcHVh?=
 =?utf-8?B?c1R6elNlQzNybHowY2cyb3RxUTZiSmtndVAyN3JtYUxLRjlrNXRvWnZyS0No?=
 =?utf-8?B?YzFDNzlaSGlBTmhsemlIcVBmbDJ1eDA1dGs2eEVJZXl1cmJGcFlKakk3TDQy?=
 =?utf-8?B?K3ZOM05FazV2N0VBUHpjRXgvNU95ZnAxbjhNV1Q0U0tQb014K1JKQzdDdUdp?=
 =?utf-8?B?UHdZUURLZkptZmx0aHdVa0J0QUJTUFZqajhOem5GcjFKUWJmdW80V2ZIbU1u?=
 =?utf-8?B?cUZwOGV3Ly96eXlTODJUL0JZc0xOZ3NaSG12THcxc1JDK25xdkFQY1o1Mnho?=
 =?utf-8?B?dnlhUGZWMkRMUHVzdnpZbTYwbXpBam1sU2dESmZMYXp3WVlFNXhpYkYvV0Jn?=
 =?utf-8?B?WWZzOFlrbHhCWWxlTG9vellLRkFFaUxieHp1SW9XWVZnMHFYYTByWTdSRGdu?=
 =?utf-8?B?ZFFoSFo1QThXZ2lqNmJZL1A0cUZVMFIxNE9ZVko3OFhrKzg4em9adCs3M1gx?=
 =?utf-8?B?Q2IrU2NONHJSWmdMRE5ITC9xeXpPaHEzaDduK3Rxb25Hd1lnZ3V6V3E3Mnls?=
 =?utf-8?B?OVVqQ1NWTU9XYkxwbklnc0FSWW9YeVlaSVN1QUNLWWZjK0xmUWF2SnBNclFJ?=
 =?utf-8?B?Z3FIRTRGazZkSEQ2elhZVisxWk4wVDEvSEJjaHZCa2k2OWxoVWN0Ujg4ZGJL?=
 =?utf-8?B?K2VKNWhLZFRFdkdxMG1aTmZKcENPK2gzbkd0TDJUdFpaSElVd3crWlNHdCts?=
 =?utf-8?B?L0I0bEpUYzJ1RUhtQWVPbGYxMDR5T0VRdzRuVmQ1M0M1TENuMDlBMnEvNTdV?=
 =?utf-8?B?bDdnMWpjTUxVVXNSKzhKRndaYjNtOXQrMXZNUWVwVzA2d01rWDcvWFN3M2dm?=
 =?utf-8?B?elNrQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b9e564-7c34-4956-1568-08db562a1281
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 16:24:50.5509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLYC1o0KJO/TmeP6V7FT/MUyEE89nFEXhWRgiR93d2nY7L7yD7JbN2uuw1glvDfT/piqFEsXB1Yfh5kmJhVvXVONucNfLkHjq7u4S1BpCBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6641
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_08,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=614
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305160139
X-Proofpoint-GUID: 3gRKZsDPWCF0oeKywT_2lB0eZZPhD0dm
X-Proofpoint-ORIG-GUID: 3gRKZsDPWCF0oeKywT_2lB0eZZPhD0dm
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/23 3:39 AM, Christian Brauner wrote:
> On Mon, May 15, 2023 at 05:23:12PM -0500, Mike Christie wrote:
>> On 5/15/23 10:44 AM, Linus Torvalds wrote:
>>> On Mon, May 15, 2023 at 7:23 AM Christian Brauner <brauner@kernel.org> wrote:
>>>>
>>>> So I think we will be able to address (1) and (2) by making vhost tasks
>>>> proper threads and blocking every signal except for SIGKILL and SIGSTOP
>>>> and then having vhost handle get_signal() - as you mentioned - the same
>>>> way io uring already does. We should also remove the ingore_signals
>>>> thing completely imho. I don't think we ever want to do this with user
>>>> workers.
>>>
>>> Right. That's what IO_URING does:
>>>
>>>         if (args->io_thread) {
>>>                 /*
>>>                  * Mark us an IO worker, and block any signal that isn't
>>>                  * fatal or STOP
>>>                  */
>>>                 p->flags |= PF_IO_WORKER;
>>>                 siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
>>>         }
>>>
>>> and I really think that vhost should basically do exactly what io_uring does.
>>>
>>> Not because io_uring fundamentally got this right - but simply because
>>> io_uring had almost all the same bugs (and then some), and what the
>>> io_uring worker threads ended up doing was to basically zoom in on
>>> "this works".
>>>
>>> And it zoomed in on it largely by just going for "make it look as much
>>> as possible as a real user thread", because every time the kernel
>>> thread did something different, it just caused problems.
>>>
>>> So I think the patch should just look something like the attached.
>>> Mike, can you test this on whatever vhost test-suite?
>>
>> I tried that approach already and it doesn't work because io_uring and vhost
>> differ in that vhost drivers implement a device where each device has a vhost_task
>> and the drivers have a file_operations for the device. When the vhost_task's
>> parent gets signal like SIGKILL, then it will exit and call into the vhost
>> driver's file_operations->release function. At this time, we need to do cleanup
> 
> But that's no reason why the vhost worker couldn't just be allowed to
> exit on SIGKILL cleanly similar to io_uring. That's just describing the
> current architecture which isn't a necessity afaict. And the helper
> thread could e.g., crash.
> 
>> like flush the device which uses the vhost_task. There is also the case where if
>> the vhost_task gets a SIGKILL, we can just exit from under the vhost layer.
> 
> In a way I really don't like the patch below. Because this should be
> solvable by adapting vhost workers. Right now, vhost is coming from a
> kthread model and we ported it to a user worker model and the whole
> point of this excercise has been that the workers behave more like
> regular userspace processes. So my tendency is to not massage kernel
> signal handling to now also include a special case for user workers in
> addition to kthreads. That's just the wrong way around and then vhost
> could've just stuck with kthreads in the first place.

I would have preferred that :) Maybe let's take a step back and revisit
that decision to make sure it was right. The vhost layer wants:

1. inherit cgroups.
2. share mm.
3. no signals
4. to not show up was an extra process like in Nicolas's bug.
5. have it's worker threads counted under its parent nproc limit.

We can do 1 - 4 today with kthreads. Can we do #5 with kthreads? My first
attempt which passed around the creds to use for kthreads or exported a
helper for the nproc accounting was not liked and we eventually ended up
here.

Is this hybird user/kernel thread/task still the right way to go or is
better to use kthreads and add some way to handle #5?


> 
> So I'm fine with skipping over the freezing case for now but SIGKILL
> should be handled imho. Only init and kthreads should get the luxury of
> ignoring SIGKILL.
> 
> So, I'm afraid I'm asking some work here of you but how feasible would a
> model be where vhost_worker() similar to io_wq_worker() gracefully
> handles SIGKILL. Yes, I see there's
> 
> net.c:   .release = vhost_net_release
> scsi.c:  .release = vhost_scsi_release
> test.c:  .release = vhost_test_release
> vdpa.c:  .release = vhost_vdpa_release
> vsock.c: .release = virtio_transport_release
> vsock.c: .release = vhost_vsock_dev_release
> 
> but that means you have all the basic logic in place and all of those
> drivers also support the VHOST_RESET_OWNER ioctl which also stops the
> vhost worker. I'm confident that a lof this can be leveraged to just
> cleanup on SIGKILL.

We can do this, but the issue I'm worried about is that right now if there
is queued/running IO and userspace escalates to SIGKILL, then the vhost layer
will still complete those IOs. If we now allow SIGKILL on the vhost thread,
then those IOs might fail.

If we get a SIGKILL, I can modify vhost_worker() so that it temporarily
ignores the signal and allows IO/flushes/whatever-operations to complete
at that level. However, we could hit issues where when vhost_worker()
calls into the drivers listed above, and those drivers call into whatever
kernel layer they use, that might do

if (signal_pending(current))
	return failure;

and we now fail.

If we say that since we got a SIGKILL, then failing is acceptable behavior
now, I can code what you are requesting.



