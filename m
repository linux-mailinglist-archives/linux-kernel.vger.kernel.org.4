Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEE46A702F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCAPtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCAPtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:49:31 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B45A19BE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 07:49:29 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321FNp1a014156;
        Wed, 1 Mar 2023 15:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=OnyNx1putt5ECAaiTXjUL0xp/b2DUi0jjdx0zZOjOLk=;
 b=bzuFk23/UqXloMszswxQk759sQjvdhO7tTqSOy3vCfO4rPN3AdrJuQceV/Mofg3z3LM+
 VCjQlm3P6CuZJxdPgQzioicGZKNMBnMBmapRa3GpRuOFxg876zrNK0Qrzk3ArqzBhdg+
 UWbyJx/X9IjbFCwqf0lrXWZ1r9JQKq9kKRnvNwN8LgL/uhisO5J3bZq6kh6vyzQsQrOL
 yJ5/twbeAiHFt3vnrGhGRqelIIKPQiSUDEMe/+r1GiMJGB7+VElimEejIZMS/pUHrA5C
 MBcgYx4Bw1DPs08Cjpoimx6wf0Q08/dwXK59R842Ym3Mitd4FnglO+c084W4IHF9G8Nu qA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb6eharf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Mar 2023 15:49:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 321En1mn032294;
        Wed, 1 Mar 2023 15:49:01 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sffamc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Mar 2023 15:49:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qe9VOjZne9D9EphkIH/j9NQm3Gas6OwNbxOxS2+y6HiJLtL7XHbbLaq7fc3oqgiwF2kAx9Uh0n3X5yOzJYdi6hZC2hdQAEiQtSOxjxAoUvoq5vbAnv/aqqU3N/eJuq+qKkQcC66Ej6cgRSURsPVli3KhKiSFPrlHk5fSwq8gJizXXbz9KCiG0U+JbXgdvcIRd5DuCgX/9xa4s2aoNKmsUSF0yW+1o3XR4D/PQy6a9dqWJoDv7L2UIJb4IaW83MZ+4t421AzNkzvqLpL8rN7KG9h28dRo0Cia4Atk9Zxt01JVMOCkr83nELP50MGWHN3RrfKVTZDY5qnZYOx7ZAZfng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnyNx1putt5ECAaiTXjUL0xp/b2DUi0jjdx0zZOjOLk=;
 b=kjuPGD0mTmvqi3xtxufDOat7X0ynkxxqCzoPVM81x5D7j9SHI6qcFoelMt4m63lWDWtBYQQoIusNoxDKWWy+YT4LnpntBdkZD+tcEI0MUYFGm9d5Hqy7xr+lDSDmocIfdtJQxyT4oxyeTphfoKlO9PYr/EJXDYnl0m1/xzeEwbegh1f28Ff7V58t7yy2/WAhWMm/V+RZlFoHBrdUc5Q2KB5auYMOg2LYtJTYGjBL/INIjBPLnoWSyD5rtpx77dPfWJ1dDVrxSQFiwQ6yMo89Fclhsd5Fn1zwt9aulITmKMKqbkeDDQx1IvW8cOVTkI/KO9NcpAW7W6vUNRqr0cJxHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnyNx1putt5ECAaiTXjUL0xp/b2DUi0jjdx0zZOjOLk=;
 b=pn7ztjt9S+0e6/wyK2wuAY4KJNPe3WzQo2asdBvxm1RDjGNTxDiyFu/88j2PufwXUG53nJxQdrwVFeSyuoBNeZUZPn+hbHMK+cEytlwkMMl7SQcCyFZOhzuDyBCRpMhBJWu9/icAx3PASX6QM6F1LR2OZDcnM1S2GKA7T+f9w04=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH7PR10MB6060.namprd10.prod.outlook.com (2603:10b6:510:1fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 15:48:58 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%8]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 15:48:58 +0000
Message-ID: <536c69d0-9ebd-8356-ebcb-680562bcd277@oracle.com>
Date:   Wed, 1 Mar 2023 09:48:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
Content-Language: en-US
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     Baoquan He <bhe@redhat.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230131224236.122805-6-eric.devolder@oracle.com>
 <87sffpzkle.ffs@tglx> <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com>
 <87h6vw2rwf.ffs@tglx> <7580421a-648a-2c4b-3c33-82e7622d9585@oracle.com>
 <d465173e-a31a-c4d6-af51-59d9ff0c2edc@linux.ibm.com>
 <24034f33-739b-e5f5-40c0-8d5abeb1ad89@oracle.com>
 <18c57fd0-2ad0-361a-9a53-ac49c372f021@linux.ibm.com>
 <b3d5c730-60ee-8f1c-978c-e3df41e3a3f1@oracle.com>
 <f7c0269b-05e7-c706-f111-c768d4a13b72@linux.ibm.com>
 <Y/33OOdv22CEaTNA@MiWiFi-R3L-srv>
 <7b0e3676-40e1-3ea1-6d58-6d934970aa27@oracle.com>
In-Reply-To: <7b0e3676-40e1-3ea1-6d58-6d934970aa27@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0556.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::6) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH7PR10MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: 648c035b-581f-4724-8b96-08db1a6c784f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4cKaTx906AM2bGIu+dDPuk8nUCsZRj3M4LLPySSXq7Gywg+dYRGjpc0h+eODQo0ZGJGCW3izjAN5Xu92W62nfqrttI3T3k8MSnP8SkbasLvRu4XACVKaU7twRIGNedos1x4PeFR6FPG9LAo3ycx3usQTAQqJevZD41vc2xmZhK166fud7iII/CEzfcGGU2ilDFpxoVgucrtQsfWvghet3PCfsh1W6wX0vOtelLCvpefKsMBQ1MwEYzS7W+FNHIOmVZAHbMeYOgV0yBFTxT3TmMpezX96SnMuctNsuclnwclKoW45zszkxrxPsra4yZg7lcJGQnII0Zmb1RwH6kjQ5D4LsbbSTduzmhuuDhkeMi5S2ZmrCW71mVvWkCwJE5GKcam5ip61c6QNNgih5rclGC0HIvf7UoUTXiPGdT43AnnrS3axfPPxpQycwx4/AYVLrhhbbz7vLuzoYY3eN9I6dwfxZmW7SJTrceMIVK9+Q836s0O5Ys6htFU1zrojRMhBaA4Al0StmeFOXGTtfaXWyXexASRMsg7uIIdRsKfEeNkDHnXkqOBUPaDHnDbZZx/pryN2plJUES3aPyY1r8FHUbTIhE+NtriGezwHBFF0C4EJF0+vlGH9YS/78rRn5tlXpzf96nHdxgumiQhxino025nCKhrOTb38Cf6mu04NLJaR+uRPWG76qZnvGU+2dqGEwskNeXPWy7Bu9CgDl3vEIaNJYXEo/vbnk/E+lkoBPbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(136003)(346002)(396003)(39860400002)(84040400005)(451199018)(38100700002)(36756003)(6666004)(86362001)(30864003)(2906002)(8676002)(7416002)(66556008)(66476007)(4326008)(66946007)(31696002)(8936002)(41300700001)(5660300002)(6512007)(2616005)(53546011)(6506007)(83380400001)(186003)(110136005)(478600001)(316002)(107886003)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmFrMmN3bHhNU1Q5VTFKOXdNa2YxakFWVUFra1BtSm9mV2FHQ0RJRjUvYzJC?=
 =?utf-8?B?Q3dmL3J0WXVGS0VaeFJUdjFRNnZGcHNHVzFWemI1RlJxSUxueU5ZWDVKRjhL?=
 =?utf-8?B?UWdNVGR4QzRsL2EvUzF1TTJnQUJlaldEMGhUQTZlWWpoTGpnd3dRbW1Ickln?=
 =?utf-8?B?bkdXTEw4aFl2UkNWNVcrVi9nMGZmNUlodGtteTZVeFA5NGxuNEhFYnJvM2Vu?=
 =?utf-8?B?Y1loSzFGeDRYRHlsMWM5b0NWTDBPc2JZT3NWb3JXbW9PMUhZRmJlRmsyM1No?=
 =?utf-8?B?RWs2WjI4WmRKaTk5czFpbzhPeEhnZXdMdDM4WTVzcnJiamVDNlVBbzVoZnBF?=
 =?utf-8?B?WWZLamhFTmhsV3VjZEd3cFVvdVVRK1VYQkxJTFJ6bkdaQW1kQjJZUzlFcU1w?=
 =?utf-8?B?R25qRDE1bEFSOUFST000TmJrU00yTlhEUFkrNzNkZzQ2T3ZubzZDUlV1YXhP?=
 =?utf-8?B?YTBPd0xuUmZubHd3MWNmaGJIRmdzTjRkZ1FLWXgwdXFOWFdNTGFRR2RQQkNC?=
 =?utf-8?B?UWQ2eHFRRkI0UDlKQnlxVjBKZlNiQWVnMUIxOEVWNEZETUkxQ1pLdVhlNnpJ?=
 =?utf-8?B?cklwOE1UM1VlMnUrcE9RNFY5NEF3MGVINjVLTUlqcUV0eDZjbWdzeGg1TUJq?=
 =?utf-8?B?aEFwVVlDT3EyUktSSC9nZjBiTjRxclk5WUIzSVR3RHhKempZY2pTSUxLVFM2?=
 =?utf-8?B?UExZMmRyaXgxUC9IT2pVZTMweWF3Y0NFMmVjbGM1UEUrRDlUZktvQWYvcHM0?=
 =?utf-8?B?dFN6cm9NeUoveVBWWTlvZEdhRVJ5UE84UGRYNmRrQnhVeFJIc3g5WVJDbFdr?=
 =?utf-8?B?YkNMMGpmWG56TVc3akJqNSt6ZUhIOG04WmgwVEVYaE5kcEFrZXcxMTFBTEUr?=
 =?utf-8?B?Z3NLYXlTUlY0aVZQbFJpbjBMcmxlcy9IckwrTlhFSHZBc0R1T003dlFzRUlG?=
 =?utf-8?B?SU0rM2R1SFNXWlJZOTNqSmIyN1R3ZGxmRVRFNmN3MWtaelZPWFg5aUd4c0NM?=
 =?utf-8?B?eEZMVE9JU3NpSktodjdLZHFYRmlWTFB6SXlYK1JRRDRIREJRYjNjOFUwK2wv?=
 =?utf-8?B?K085QUsxVjQyU1EwTHUyT1hENW9nRFFFL24yZnBoTnJNY3dGSlR1eHA4Sjd5?=
 =?utf-8?B?U3FUMjByUDgzdkFnUUhEalVZYVBrd214TmdRZUMwN2FnQnUvWWMvVFg0Zm1u?=
 =?utf-8?B?RElZRFlzQ2RYTlQ4SzA0bDF3M1FadXZRY2kwaTBub25JN01hQ2toOGNGWFk5?=
 =?utf-8?B?d0hXVUx3ZlhDSUxGTURKVnNiUmVwekIrWjJvM3p0ay85QzN0WnBDTUNnbUNh?=
 =?utf-8?B?Ti9tUk1UYXk0YWQzQi9uQU9BV1orWlhUd3RkNjV0QlgzdFUwaGdndXBHZDJq?=
 =?utf-8?B?eUpTRUN6T1gwMCt6d21xenp3KzBHbEZoQTkvVWhiZ0daRWs0ZC9makp6NlRh?=
 =?utf-8?B?QUpjNGxJYjcreHJ6ZGNKSjJmVlg2eFRIMlZaYVhjK1YvM3A0VUY0RjRZcGZt?=
 =?utf-8?B?YlJUQ2RWWVFFbkFhd0hEdnJraC9aV21NY0QreHdrOHJvd1V3emE0alZmeWpv?=
 =?utf-8?B?Zk1jK0hqUXQvWTRlZGg1UUw0ekFuZ2ZobTgwcytRVzB1Mms2YnRIYXU5T0RU?=
 =?utf-8?B?d0RwaEJ6ekxkbFBYNFF5WlVlSGYyTmRDWHZBaHFoQW9BczJKcm5uRmREdzc5?=
 =?utf-8?B?Z0pBUEswc1VCNk04a2p1NUpNbFNTbmpxK1oyUFlNS2NiRUlJWjVEaEY5T2Z2?=
 =?utf-8?B?YXN0OXdTMFV3bkV4dUc1U2dZazJIOEo5RFdUakhUSy9VaEhTOEltTHpaeERK?=
 =?utf-8?B?bXBGZjhZR1BNZ3pOeFUwa0xqa0xxT3ZabFdlOW5LMEM4RTdkM0xpKy9peVht?=
 =?utf-8?B?cEpoS3d2Q3ZaRzJWTnA5MmlYYzFZaXNIa3o5eWdJNnBKME81cXF4SXdvZm4w?=
 =?utf-8?B?OXRnY01jcDF6ZFdDT1RpVFNxSjhHOHArbjJPdUh3aUNYME1GVldhM0w5NkpO?=
 =?utf-8?B?MWRxZkR6QXpJQ0hXNmZDeGhSbkNMc2ZqdVJNZ3U0KzVDcDdVblRDcG5FOFd4?=
 =?utf-8?B?TjAyVVNsNEd1Y0E0M1o1TTNMR0M4UzdtSWJRZXhTMDhSTWlnTkE1Vms3cFBl?=
 =?utf-8?B?Y0FrKzVsRWpYVU1STEhGL0dGTjdkU1pQK1B2a1BGTXhyZ0crTjJTS0hiWEtC?=
 =?utf-8?Q?aTM3daHfw4Sstsw88t5pUFM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aC9qajRWT3dWQlJnd1pEZ3JmL0pIYmtGaGtzbjZ0NkhYRFdTckJZcjJkSWdO?=
 =?utf-8?B?SVRZRm91NWFqd01pblpUazZPN2VTZi81bytVL1haQjVUaFQ4WFVjVk9KVWFs?=
 =?utf-8?B?c0c4ampHVUhuWlJLWmhsZjFrSEJHVHQ5WHZ2MGZDQU1zZWFYd3B3c0xaQkFm?=
 =?utf-8?B?MVM4ZUNxNnFzTnlCbFFaS3FhMmNFOXB1VmRFamRGWkxXYXI0dlM1ajc1T0ww?=
 =?utf-8?B?ejVsR0dSZ3hwVjhGME8wNEU0a3poVDB1T2MrMXNBNHdlOTdGQ2VQcFYxR0Zn?=
 =?utf-8?B?ZEF2eWVMaHBGdGQzM2d3aXl4Mkt0NGY5Q2lNbStZY2x5K0pocU5ISWptQjJ3?=
 =?utf-8?B?NThPcGZWREdnazNjYjVuNkd2LzFydjFlZ09BUjJhZnA0dGo1UHYyaDFTU2gr?=
 =?utf-8?B?aWs3dkFreDB0b3V0blZvT1pRaWdYejJDblJ6WThsSi96bGhqbzRSVlNHdGhs?=
 =?utf-8?B?d2xPYUdDZ3h1YnplMW0ybjZTSmFyMzNYYkxMdzZmRjd2YlJrdFR0MHlvcEk3?=
 =?utf-8?B?Mkp3R1k5SEZPUlBsdXpxWmlTdVBSRm01R2M3QVZ2enNGSDM3blFMazF5ZXdJ?=
 =?utf-8?B?VER0bXZuL3E1Y0V5WCtsZWp5NjBKbFIrK2JzeHZkRWhPeUNvZkpmSDFmbXdM?=
 =?utf-8?B?QWh0RCtybmxybmY4RTVrL25jM1dsRGx4N29OTmY3bGRPY0pHakxWSCtmSU9W?=
 =?utf-8?B?K0dHWUVKVDE1bGt2Qi9TZHVlWjltK1lYc29hMjFwM0xHdkRjOS9TTlNzZCs4?=
 =?utf-8?B?SFlNTFBJaUxEYWo3WHlFb08yVDlQNW1KRDNQUGNvckkxZE0vblFyOEgzUmVE?=
 =?utf-8?B?MDJ3c29aekt4YitlZTdnbkIyQWN5UlpIcjBEajF3OUtkS1cvYlNESGlaQlZ3?=
 =?utf-8?B?WE9lQjdtcmpGTDNPKy83bnYzNjZZeC84RHBqSXpUMDdUU0laUDhyOWdUM3Iw?=
 =?utf-8?B?dGVFcnFQVUd2SW95eC9HbjAxM1ZxOWJPWnhHbXNxeE85bC85ZzBKN2oxV2Ix?=
 =?utf-8?B?NkI5RW9mb0lOSW1lQk9GUE90ZmZtdEpCNFRoanN2YjMvd0gwMXhvRVdGR0M2?=
 =?utf-8?B?Mm8wSm5lMzNuYXdZdk5GcHBtb2RUUG1QQWk5dDFrdjMzMld4ZzJMSURBZ3FH?=
 =?utf-8?B?K1lEM0xVY3gzYUFuM3NSTi9tZ0FnNzF1L1JRT2o5ME8xSDNGV3dLbWU5RmNV?=
 =?utf-8?B?ajZJaWFDbjFkL1NtVllEeENOaWlkNG95QWNZVm1OcExSclhYcVVnSll0c0Fx?=
 =?utf-8?B?SWNYWWRqQUQ1eGUwSFRMNEd4T3pjc1lsTkZaazNoY216YWxHc0Y1clBoazhS?=
 =?utf-8?B?c1JiY0dSQThaZTQvUldOakwwMStVZEVsZzhOdXRjM0ljZGphZGRWcTFVRmNO?=
 =?utf-8?B?QysxTkNaTTRoSUlyeHhzRXNmN0o1bm5mL3JUUWQ5c3dldklXTmU1ejVPK0VT?=
 =?utf-8?B?ZlI0WWRlTVR0TkZZQjNkSDFLVzl4clhpdXJMZHprU2FWUXBJSDR4SzVvcFBX?=
 =?utf-8?B?NkxrNHlHN2tvNXA2cHcvWWEwcnNGUVBydGZjNnh6Rm9yTVYwTlMwL202cVMv?=
 =?utf-8?Q?LaL06J1STt/SI/aZ53ebAuUCk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648c035b-581f-4724-8b96-08db1a6c784f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 15:48:58.4231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8YrMB8r9ASHWMWfbGLPispCYN3+c8PTU/mSiT5Joxw3u5JfuO+MOuoOoP8DSQEVapV8n5DzyyQ5pBxB1XY0IdbDVs//3aX3OicmtONk6u0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_13,2023-03-01_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303010130
X-Proofpoint-ORIG-GUID: uMCqFdYiOXykSsSs0fy_Lswa3Z00crkw
X-Proofpoint-GUID: uMCqFdYiOXykSsSs0fy_Lswa3Z00crkw
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/23 12:52, Eric DeVolder wrote:
> 
> 
> On 2/28/23 06:44, Baoquan He wrote:
>> On 02/13/23 at 10:10am, Sourabh Jain wrote:
>>>
>>> On 11/02/23 06:05, Eric DeVolder wrote:
>>>>
>>>>
>>>> On 2/10/23 00:29, Sourabh Jain wrote:
>>>>>
>>>>> On 10/02/23 01:09, Eric DeVolder wrote:
>>>>>>
>>>>>>
>>>>>> On 2/9/23 12:43, Sourabh Jain wrote:
>>>>>>> Hello Eric,
>>>>>>>
>>>>>>> On 09/02/23 23:01, Eric DeVolder wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2/8/23 07:44, Thomas Gleixner wrote:
>>>>>>>>> Eric!
>>>>>>>>>
>>>>>>>>> On Tue, Feb 07 2023 at 11:23, Eric DeVolder wrote:
>>>>>>>>>> On 2/1/23 05:33, Thomas Gleixner wrote:
>>>>>>>>>>
>>>>>>>>>> So my latest solution is introduce two new CPUHP
>>>>>>>>>> states, CPUHP_AP_ELFCOREHDR_ONLINE
>>>>>>>>>> for onlining and CPUHP_BP_ELFCOREHDR_OFFLINE for
>>>>>>>>>> offlining. I'm open to better names.
>>>>>>>>>>
>>>>>>>>>> The CPUHP_AP_ELFCOREHDR_ONLINE needs to be
>>>>>>>>>> placed after CPUHP_BRINGUP_CPU. My
>>>>>>>>>> attempts at locating this state failed when
>>>>>>>>>> inside the STARTING section, so I located
>>>>>>>>>> this just inside the ONLINE sectoin. The crash
>>>>>>>>>> hotplug handler is registered on
>>>>>>>>>> this state as the callback for the .startup method.
>>>>>>>>>>
>>>>>>>>>> The CPUHP_BP_ELFCOREHDR_OFFLINE needs to be
>>>>>>>>>> placed before CPUHP_TEARDOWN_CPU, and I
>>>>>>>>>> placed it at the end of the PREPARE section.
>>>>>>>>>> This crash hotplug handler is also
>>>>>>>>>> registered on this state as the callback for the .teardown method.
>>>>>>>>>
>>>>>>>>> TBH, that's still overengineered. Something like this:
>>>>>>>>>
>>>>>>>>> bool cpu_is_alive(unsigned int cpu)
>>>>>>>>> {
>>>>>>>>>      struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
>>>>>>>>>
>>>>>>>>>      return data_race(st->state) <= CPUHP_AP_IDLE_DEAD;
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> and use this to query the actual state at crash
>>>>>>>>> time. That spares all
>>>>>>>>> those callback heuristics.
>>>>>>>>>
>>>>>>>>>> I'm making my way though percpu crash_notes,
>>>>>>>>>> elfcorehdr, vmcoreinfo,
>>>>>>>>>> makedumpfile and (the consumer of it all) the
>>>>>>>>>> userspace crash utility,
>>>>>>>>>> in order to understand the impact of moving from
>>>>>>>>>> for_each_present_cpu()
>>>>>>>>>> to for_each_online_cpu().
>>>>>>>>>
>>>>>>>>> Is the packing actually worth the trouble? What's the actual win?
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>>
>>>>>>>>>           tglx
>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>> Thomas,
>>>>>>>> I've investigated the passing of crash notes through the
>>>>>>>> vmcore. What I've learned is that:
>>>>>>>>
>>>>>>>> - linux/fs/proc/vmcore.c (which makedumpfile references
>>>>>>>> to do its job) does
>>>>>>>>    not care what the contents of cpu PT_NOTES are, but it
>>>>>>>> does coalesce them together.
>>>>>>>>
>>>>>>>> - makedumpfile will count the number of cpu PT_NOTES in
>>>>>>>> order to determine its
>>>>>>>>    nr_cpus variable, which is reported in a header, but
>>>>>>>> otherwise unused (except
>>>>>>>>    for sadump method).
>>>>>>>>
>>>>>>>> - the crash utility, for the purposes of determining the
>>>>>>>> cpus, does not appear to
>>>>>>>>    reference the elfcorehdr PT_NOTEs. Instead it locates the various
>>>>>>>>    cpu_[possible|present|online]_mask and computes
>>>>>>>> nr_cpus from that, and also of
>>>>>>>>    course which are online. In addition, when crash does
>>>>>>>> reference the cpu PT_NOTE,
>>>>>>>>    to get its prstatus, it does so by using a percpu
>>>>>>>> technique directly in the vmcore
>>>>>>>>    image memory, not via the ELF structure. Said
>>>>>>>> differently, it appears to me that
>>>>>>>>    crash utility doesn't rely on the ELF PT_NOTEs for
>>>>>>>> cpus; rather it obtains them
>>>>>>>>    via kernel cpumasks and the memory within the vmcore.
>>>>>>>>
>>>>>>>> With this understanding, I did some testing. Perhaps the
>>>>>>>> most telling test was that I
>>>>>>>> changed the number of cpu PT_NOTEs emitted in the
>>>>>>>> crash_prepare_elf64_headers() to just 1,
>>>>>>>> hot plugged some cpus, then also took a few offline
>>>>>>>> sparsely via chcpu, then generated a
>>>>>>>> vmcore. The crash utility had no problem loading the
>>>>>>>> vmcore, it reported the proper number
>>>>>>>> of cpus and the number offline (despite only one cpu
>>>>>>>> PT_NOTE), and changing to a different
>>>>>>>> cpu via 'set -c 30' and the backtrace was completely valid.
>>>>>>>>
>>>>>>>> My take away is that crash utility does not rely upon
>>>>>>>> ELF cpu PT_NOTEs, it obtains the
>>>>>>>> cpu information directly from kernel data structures.
>>>>>>>> Perhaps at one time crash relied
>>>>>>>> upon the ELF information, but no more. (Perhaps there
>>>>>>>> are other crash dump analyzers
>>>>>>>> that might rely on the ELF info?)
>>>>>>>>
>>>>>>>> So, all this to say that I see no need to change
>>>>>>>> crash_prepare_elf64_headers(). There
>>>>>>>> is no compelling reason to move away from
>>>>>>>> for_each_present_cpu(), or modify the list for
>>>>>>>> online/offline.
>>>>>>>>
>>>>>>>> Which then leaves the topic of the cpuhp state on which
>>>>>>>> to register. Perhaps reverting
>>>>>>>> back to the use of CPUHP_BP_PREPARE_DYN is the right
>>>>>>>> answer. There does not appear to
>>>>>>>> be a compelling need to accurately track whether the cpu
>>>>>>>> went online/offline for the
>>>>>>>> purposes of creating the elfcorehdr, as ultimately the
>>>>>>>> crash utility pulls that from
>>>>>>>> kernel data structures, not the elfcorehdr.
>>>>>>>>
>>>>>>>> I think this is what Sourabh has known and has been
>>>>>>>> advocating for an optimization
>>>>>>>> path that allows not regenerating the elfcorehdr on cpu
>>>>>>>> changes (because all the percpu
>>>>>>>> structs are all laid out). I do think it best to leave
>>>>>>>> that as an arch choice.
>>>>>>>
>>>>>>> Since things are clear on how the PT_NOTES are consumed in
>>>>>>> kdump kernel [fs/proc/vmcore.c],
>>>>>>> makedumpfile, and crash tool I need your opinion on this:
>>>>>>>
>>>>>>> Do we really need to regenerate elfcorehdr for CPU hotplug events?
>>>>>>> If yes, can you please list the elfcorehdr components that
>>>>>>> changes due to CPU hotplug.
>>>>>> Due to the use of for_each_present_cpu(), it is possible for the
>>>>>> number of cpu PT_NOTEs
>>>>>> to fluctuate as cpus are un/plugged. Onlining/offlining of cpus
>>>>>> does not impact the
>>>>>> number of cpu PT_NOTEs (as the cpus are still present).
>>>>>>
>>>>>>>
>>>>>>>   From what I understood, crash notes are prepared for
>>>>>>> possible CPUs as system boots and
>>>>>>> could be used to create a PT_NOTE section for each possible
>>>>>>> CPU while generating the elfcorehdr
>>>>>>> during the kdump kernel load.
>>>>>>>
>>>>>>> Now once the elfcorehdr is loaded with PT_NOTEs for every
>>>>>>> possible CPU there is no need to
>>>>>>> regenerate it for CPU hotplug events. Or do we?
>>>>>>
>>>>>> For onlining/offlining of cpus, there is no need to regenerate
>>>>>> the elfcorehdr. However,
>>>>>> for actual hot un/plug of cpus, the answer is yes due to
>>>>>> for_each_present_cpu(). The
>>>>>> caveat here of course is that if crash utility is the only
>>>>>> coredump analyzer of concern,
>>>>>> then it doesn't care about these cpu PT_NOTEs and there would be
>>>>>> no need to re-generate them.
>>>>>>
>>>>>> Also, I'm not sure if ARM cpu hotplug, which is just now coming
>>>>>> into mainstream, impacts
>>>>>> any of this.
>>>>>>
>>>>>> Perhaps the one item that might help here is to distinguish
>>>>>> between actual hot un/plug of
>>>>>> cpus, versus onlining/offlining. At the moment, I can not
>>>>>> distinguish between a hot plug
>>>>>> event and an online event (and unplug/offline). If those were
>>>>>> distinguishable, then we
>>>>>> could only regenerate on un/plug events.
>>>>>>
>>>>>> Or perhaps moving to for_each_possible_cpu() is the better choice?
>>>>>
>>>>> Yes, because once elfcorehdr is built with possible CPUs we don't
>>>>> have to worry about
>>>>> hot[un]plug case.
>>>>>
>>>>> Here is my view on how things should be handled if a core-dump
>>>>> analyzer is dependent on
>>>>> elfcorehdr PT_NOTEs to find online/offline CPUs.
>>>>>
>>>>> A PT_NOTE in elfcorehdr holds the address of the corresponding crash
>>>>> notes (kernel has
>>>>> one crash note per CPU for every possible CPU). Though the crash
>>>>> notes are allocated
>>>>> during the boot time they are populated when the system is on the
>>>>> crash path.
>>>>>
>>>>> This is how crash notes are populated on PowerPC and I am expecting
>>>>> it would be something
>>>>> similar on other architectures too.
>>>>>
>>>>> The crashing CPU sends IPI to every other online CPU with a callback
>>>>> function that updates the
>>>>> crash notes of that specific CPU. Once the IPI completes the
>>>>> crashing CPU updates its own crash
>>>>> note and proceeds further.
>>>>>
>>>>> The crash notes of CPUs remain uninitialized if the CPUs were
>>>>> offline or hot unplugged at the time
>>>>> system crash. The core-dump analyzer should be able to identify
>>>>> [un]/initialized crash notes
>>>>> and display the information accordingly.
>>>>>
>>>>> Thoughts?
>>>>>
>>>>> - Sourabh
>>>>
>>>> In general, I agree with your points. You've presented a strong case to
>>>> go with for_each_possible_cpu() in crash_prepare_elf64_headers() and
>>>> those crash notes would always be present, and we can ignore changes to
>>>> cpus wrt/ elfcorehdr updates.
>>>>
>>>> But what do we do about kexec_load() syscall? The way the userspace
>>>> utility works is it determines cpus by:
>>>>   nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
>>>> which is not the equivalent of possible_cpus. So the complete list of
>>>> cpu PT_NOTEs is not generated up front. We would need a solution for
>>>> that?
>>> Hello Eric,
>>>
>>> The sysconf document says _SC_NPROCESSORS_CONF is processors configured,
>>> isn't that equivalent to possible CPUs?
>>>
>>> What exactly sysconf(_SC_NPROCESSORS_CONF) returns on x86? IIUC, on powerPC
>>> it is possible CPUs.
>>
> Baoquan,
> 
>>  From sysconf man page, with my understanding, _SC_NPROCESSORS_CONF is
>> returning the possible cpus, while _SC_NPROCESSORS_ONLN returns present
>> cpus. If these are true, we can use them.
> 
> Thomas Gleixner has pointed out that:
> 
>   glibc tries to evaluate that in the following order:
>    1) /sys/devices/system/cpu/cpu*
>       That's present CPUs not possible CPUs
>    2) /proc/stat
>       That's online CPUs
>    3) sched_getaffinity()
>       That's online CPUs at best. In the worst case it's an affinity mask
>       which is set on a process group
> 
> meaning that _SC_NPROCESSORS_CONF is not equivalent to possible_cpus(). Furthermore, the 
> /sys/system/devices/cpus/cpuXX entries are not available for not-present-but-possible cpus; thus 
> userspace kexec utility can not write out the elfcorehdr with all possible cpus listed.
> 
>>
>> But I am wondering why the existing present cpu way is going to be
>> discarded. Sorry, I tried to go through this thread, it's too long, can
>> anyone summarize the reason with shorter and clear sentences. Sorry
>> again for that.
> 
> By utilizing for_each_possible_cpu() in crash_prepare_elf64_headers(), in the case of the 
> kexec_file_load(), this change would simplify some issues Sourabh has encountered for PPC support. 
> It would also enable an optimization that permits NOT re-generating the elfcorehdr on cpu changes, 
> as all the [possible] cpus are already described in the elfcorehdr.
> 
> I've pointed out that this change would have kexec_load (as kexec-tools can only write out, 
> initially, the present_cpus()) initially deviate from kexec_file_load (which would now write out the 
> possible_cpus()). This deviation would disappear after the first hotplug event (due to calling 
> crash_prepare_elf64_headers()). Or I've provided a simple way for kexec_load to rewrite its 
> elfcorehdr upon initial load (by calling into the crash hotplug handler).
> 
> Can you think of any side effects of going to for_each_possible_cpu()?
> 
> Thanks,
> eric

Well, this won't be shorter sentences, but hopefully it makes the case clearer. Below I've 
cut-n-pasted my current patch w/ commit message which explains it all.

Please let me know if you can think of any side effects not addressed!
Thanks,
eric

> 
> 
>>
>>>
>>> In case sysconf(_SC_NPROCESSORS_CONF) is not consistent then we can go with:
>>> /sys/devices/system/cpu/possible for kexec_load case.
>>>
>>> Thoughts?
>>>
>>> - Sourabh Jain
>>>
>>

 From b56aa428b07d970f26e3c3704d54ce8805f05ddc Mon Sep 17 00:00:00 2001
From: Eric DeVolder <eric.devolder@oracle.com>
Date: Tue, 28 Feb 2023 14:20:04 -0500
Subject: [PATCH v19 3/7] crash: change crash_prepare_elf64_headers() to
  for_each_possible_cpu()

The function crash_prepare_elf64_headers() generates the elfcorehdr
which describes the cpus and memory in the system for the crash kernel.
In particular, it writes out ELF PT_NOTEs for memory regions and the
processors in the system.

With respect to the cpus, the current implementation utilizes
for_each_present_cpu() which means that as cpus are added and removed,
the elfcorehdr must again be updated to reflect the new set of cpus.

The reasoning behind the change to use for_each_possible_cpu(), is:

- At kernel boot time, all percpu crash_notes are allocated for all
   possible cpus; that is, crash_notes are not allocated dynamically
   when cpus are plugged/unplugged. Thus the crash_notes for each
   possible cpu are always available.

- The crash_prepare_elf64_headers() creates an ELF PT_NOTE per cpu.
   Changing to for_each_possible_cpu() is valid as the crash_notes
   pointed to by each cpu PT_NOTE are present and always valid.

Furthermore, examining a common crash processing path of:

  kernel panic -> crash kernel -> makedumpfile -> 'crash' analyzer
            elfcorehdr      /proc/vmcore     vmcore

reveals how the ELF cpu PT_NOTEs are utilized:

- Upon panic, each cpu is sent an IPI and shuts itself down, recording
  its state in its crash_notes. When all cpus are shutdown, the
  crash kernel is launched with a pointer to the elfcorehdr.

- The crash kernel via linux/fs/proc/vmcore.c does not examine or
  use the contents of the PT_NOTEs, it exposes them via /proc/vmcore.

- The makedumpfile utility uses /proc/vmcore and reads the cpu
  PT_NOTEs to craft a nr_cpus variable, which is reported in a
  header but otherwise generally unused. Makedumpfile creates the
  vmcore.

- The 'crash' dump analyzer does not appear to reference the cpu
  PT_NOTEs. Instead it looks-up the cpu_[possible|present|onlin]_mask
  symbols and directly examines those structure contents from vmcore
  memory. From that information it is able to determine which cpus
  are present and online, and locate the corresponding crash_notes.
  Said differently, it appears to me that 'crash' analyzer does not
  rely on the ELF PT_NOTEs for cpus; rather it obtains the information
  directly via kernel symbols and the memory within the vmcore.

(There maybe other vmcore generating and analysis tools that do use
these PT_NOTEs, but 'makedumpfile' and 'crash' seem to me to be the
most common solution.)

This change results in the benefit of having all cpus described in
the elfcorehdr, and therefore reducing the need to re-generate the
elfcorehdr on cpu changes, at the small expense of an additional
56 bytes per PT_NOTE for not-present-but-possible cpus.

On systems where kexec_file_load() syscall is utilized, all the above
is valid. On systems where kexec_load() syscall is utilized, there
may be the need for the elfcorehdr to be regenerated once. The reason
being that some archs only populate the 'present' cpus in the
/sys/devices/system/cpus entries, which the userspace 'kexec' utility
uses to generate the userspace-supplied elfcorehdr. In this situation,
one memory or cpu change will rewrite the elfcorehdr via the
crash_prepare_elf64_headers() function and now all possible cpus will
be described, just as with kexec_file_load() syscall.

Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
  kernel/crash_core.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index dba4b75f7541..537b199a8774 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -365,7 +365,7 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
  	ehdr->e_phentsize = sizeof(Elf64_Phdr);

  	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
  		phdr->p_type = PT_NOTE;
  		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
  		phdr->p_offset = phdr->p_paddr = notes_addr;
-- 
2.31.1

