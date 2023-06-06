Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5AC724E3C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 22:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbjFFUia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 16:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjFFUi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 16:38:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D4510C6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 13:38:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356IZK7S015473;
        Tue, 6 Jun 2023 20:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=M5TqjTWqMTcnkmx6Hj63sWMkiPFDHzxSg0f9U9xqIvo=;
 b=hkBc3ROFRDXGtVsjtnEXNkDNwowbX3PYHyU5vSq4nVhmCAikI2nluA+5mIjxqoI96WbO
 n7zKqOnEg5ZRkY4wmahGJL9npbE/HPem93Zgd9ZsgQqsKsMKQU9Z/gKJRcT+dIesGUjx
 Jm9UdmK8CT/mrNDOLaHYSk7gbSPd6Eu+NT96IV+hb/C03rR1b+RJ9nptbqJ+uPo5gndC
 JG1UnspAr9n0+lMwjXCytzbwvYNKHqN1GjfRnsJXjlm2apNyDq/nriZpgZKrtxBV0Kfd
 C56MkVU34uKJM+Yy11xxrSGalKNF7LhRrgV1c8CnZLwIPQygHlkvKtksJKRp6sGRDQR2 zg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6ur7h8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 20:38:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 356IY9dx010503;
        Tue, 6 Jun 2023 20:38:09 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6pm0fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 20:38:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtLABNqqzyz+vCWFpexcmlrznSlukR8OfKBWGVE5eRSAD+lItSoJ5Z3XIWTD4Uj4BayL3ZqozHAIj60GcFeXY4RW184x1zNvxuRFok0huCMConEq9QlvygbrJIKz0kLwVmwRodedOYiN0liyqW0Za31oNZaHextX/NxK2UGVXcUUt+1DnyvA/lUgdzs7GDGnkFQBG6/8ZodTMv0IzIMCUfzEqs/4+ESDSheuQ/ncoVT0jSe2J1PfAnuoRUtFLHt2t2mFSZkQfS4ykFw/Hmx9C1HXWDLyiBHgM6WganYd8/aG14TfA082LkJWlu151Qx7YqTNsCNMLlJWTuCYA8QY7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5TqjTWqMTcnkmx6Hj63sWMkiPFDHzxSg0f9U9xqIvo=;
 b=nzyoGDQ1SYNDvyfaMOsr+8FzEYIAZjb+IKEmAGcX3lYneF3XK+pofxYX5H1BY0559toYUPpaeWCPjml5VotHBds4s1YBwwJK7ff8wRPWXa2mYFxatkyI9itF0HhvvywupKtKZwcQmQpm0VIpYDxaLPAjeIsknI1kWqKvV74jCBgjZLklVVKOck7VLFAJ4sgvPtSPFUNi84wnjgBLsdwZuzQWDIQNo2YCxLWxYVcT/uueVSK5STZdLs3MvszbiDuKNd5poUP9aagcW5iI+p3US5tPh0fgTnTttoLFQO5PldkRywrXIwGHzqxD6EtIbkSKygfrna1SHlaQlHIqKVk6iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5TqjTWqMTcnkmx6Hj63sWMkiPFDHzxSg0f9U9xqIvo=;
 b=ma+joh8gdBWd9oZnKRT2OlMJ98aGBF7onAsT2a5POevqZ789RPh5fR/JaooNjOEUNCGrYTKac73pTYOa5C4q3ZB3kLjPwUH2dTPXj4+nXaQa4IF+GbhcqfbZvXR8e076sayQwoXzrIZYocNsbZzO5yK0iMxQkFA6SgEEc65bOYs=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by IA1PR10MB5923.namprd10.prod.outlook.com (2603:10b6:208:3d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 20:38:07 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 20:38:07 +0000
Message-ID: <cfbf1a0d-5d62-366f-f32f-6c63b151489e@oracle.com>
Date:   Tue, 6 Jun 2023 15:38:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [CFT][PATCH v3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230601183232.8384-1-michael.christie@oracle.com>
 <20230602192254.GD555@redhat.com>
 <87r0qt18qq.fsf_-_@email.froward.int.ebiederm.org>
 <ae250076-7d55-c407-1066-86b37014c69c@oracle.com>
 <20230605151037.GE32275@redhat.com>
 <03c07f48-8922-f563-560c-f0d4cc3e1279@oracle.com>
 <20230606121643.GD7542@redhat.com>
 <39f5913c-e658-e476-0378-62236bb4ed49@oracle.com>
 <20230606193907.GB18866@redhat.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230606193907.GB18866@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0010.namprd15.prod.outlook.com
 (2603:10b6:610:51::20) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|IA1PR10MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: b872081f-afb5-41d2-ea7c-08db66cdef0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fxhHwy23CXKJWw/mBQ38uXflsjw4R7dTZfLd8EFgf9K+4Vq9R0NHly8mHgyD0TP9KCicm4J5JUPq2Z1NAdkUOOnPsWCDDgf2JuXpRCpI6ieQCfCQGS0wNd2o5y9dlUKvxOOnUGbd8TFjvMY+bjucoVMamiyB8lesbK+mBQ+IVm1T00TFqsblJsxexnT00IZ9d5oMwqFb70zZroKsk8FchbxoJ+1xYBGPU2+DlbQwygaZcql8av/iPOIKo4NpkrFnNj7xZLkPX3Gof62xI7juMG+3rUqDIFZZNZwB6gp43Vp2rpL55hmZPwHS49x2QY0Phl0CFPqmMlgRN3M9P4OATE+vCRK0KVm0yU4aBBJY78UK2GkuJio5gge22QxfgaKYPSCPnDkzVG7alTQ2HUZy7bXi65EyBXlka5OhdIBg4ldn0uvUSUasXCrvXmPcYi5oCm63UxKDfIj7QaPbBsoL3djRS5IJlhxNiWIVZ2/Yfa1T1ryAt+uyZDJm7RCwvSyQEhTWEFlqHnZzx6Ld35laPK+6oKKIlxAZ80E423n0r7sW0OE2G4MS7nhULWcldic6Di5zyT3b9LR3g2myrEmuocSe+2hxFVmg745Z9Pmk4GKTTEsOXRwrUC6DHhPDuBYmC9MrU8VSvzJ7Ih0qTcKidQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199021)(8676002)(8936002)(966005)(478600001)(41300700001)(5660300002)(316002)(6666004)(6486002)(26005)(6916009)(7416002)(186003)(4326008)(66476007)(31686004)(66556008)(66946007)(6512007)(6506007)(53546011)(83380400001)(2616005)(2906002)(38100700002)(31696002)(36756003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3NMdm1PRnlWOWZPalRxWnJUUnRSM2NzOEVPSnErS2dLLzdhWXUrQjc3UExv?=
 =?utf-8?B?Unl2UnEzSFdQcERjMHBmQlptcGtrTzBvakRTWUkzV0NQVGR1OURyQVdoZGx3?=
 =?utf-8?B?Tk9mQTIxRC8vKzFiZXpIVis4UGlwODhON3RKWDBzT0MzcUE1ZnZUTXM4KytD?=
 =?utf-8?B?R3gvSnpsOE43ekRvT0ZRaGdqS3dkMjlJMm96OVUwa1ltWDk1QTBENnBqZ29Q?=
 =?utf-8?B?NXBGdEpodmdDbGllc1MwN3d3VVZJSk5wYVRiTzRSRmVSc01aL0F1LzN0NkM2?=
 =?utf-8?B?TWsrQXZrSTJJR3JTV0NVN0V3TWllMlVUMGdHcjB2YS8wRjl2TW5xNnc0M0dx?=
 =?utf-8?B?cmgreHFTMVR1S0YxSmY1U2xoVGNtM1VGeXhzZ2ZhbjlMUVVGMDR6ZEc5SHRF?=
 =?utf-8?B?VEtkQm5pQXpCNitVcWczbENJZndJRVpkWXJkaEs5MVlWS3BzMzJsKzNPNGlC?=
 =?utf-8?B?ZElMTnhoSjZmNmFsZWk1ZXBJYjl2azQxblo4aVZjK3dRK0c4UFF0OHhCdFg1?=
 =?utf-8?B?ZWxTWmhHa0ZsUTJpS2gvQWRpRzNrbjhPNkRWeFJoclN3cDg2OWkvVFFoT0NG?=
 =?utf-8?B?UjIyKytzY2NNTURDcmZuYXlzVnBJd0lVV1ptZUJtU0ZHMkpZZ1JESkR3L1FP?=
 =?utf-8?B?WC9Qc2xQelRrQlZFcmQyVVFnU0loKy9yUTlEeFFVaDNEQUVmcG81Q3ZOMmFW?=
 =?utf-8?B?M0tCK2FycFRES3hDWjRLSjBmU0p3SjNBZFRsUDNZd3JtUmJLQjF5UFhtWnFK?=
 =?utf-8?B?eEp1MnZ5SXc3T2g5L2p0MFJRRklHOE1pWkFGVllXN3R5SFBJMmRzbGNUclYr?=
 =?utf-8?B?RERDS0NpYkZPSmhud2lSYzdKVDM4bXRPeHZEcjA5Q2tQOThCNElORlhJWXVP?=
 =?utf-8?B?YTZUSUkwRHJVdjV1WlpFQXgrNmhkMTY0U25EaHVITkhuY0VYVm82S3dIb2tS?=
 =?utf-8?B?RmtRTEJwWlE1cjNFZ09lRUVlY1hBcXVoTXhwWHU3OXpzQUNJeE5QSG1aM3l0?=
 =?utf-8?B?KzF5RElyRmFFUTcvdVhWT3UzR1VuRG9ZclRzTHIyUDlVZE45NFpoUmVYOVJh?=
 =?utf-8?B?SFZKZ2JyS2hmOWNmUlgxd0lyRXBWTlB0eVNoRytWdk5EallHVnJQS2NXR1Yz?=
 =?utf-8?B?dEVNODVxZU9jRk1JZ1gzT3JHT2VlUXUrRGJyWHVSL1dpZWIzL3NnNktkYU42?=
 =?utf-8?B?Y0dRdGVQbThneCtacXFEUnAyUTJRME5SeDF0Njc1VnhTNmhsV3pCdzBuMXNO?=
 =?utf-8?B?STdkb0FVVTN2VVc4R0FKRVJjcC9Ib0x1NGZCTDZxUWN6Tk55NHcvQ2NPMEN3?=
 =?utf-8?B?c3BDMm4zUk9JaTJENUxqM0pEUHFMMlJEUXkrM3h1bEhqTWZDalZ0cHJhOEwv?=
 =?utf-8?B?Qnh2MFhIa3hhRnEwS1ZKK0ZDb3AybjZoMHBSV3ppV2ZndkpYTUwreHBPcURR?=
 =?utf-8?B?aXJJdFdDbGhSQXgzay92dHJHbTh1dFF2OGxQeHFBOXB5VzRrZFhTS013cG5I?=
 =?utf-8?B?R3kwWnR5KzNxOGRoR2s1eUp3RWNCc3dNaUVWTmJUSFJjTlhIVXVTblhValpY?=
 =?utf-8?B?dnFMelllNjhJZ3VhR1RwRjF2L09rdmhjVHFXUExuWTRLOUMrNHpXczAyeEd4?=
 =?utf-8?B?S1dGaDY2UjA1bERsOE85SlRBaE43eXdPS2QxcWlyQVJEOXAyV0hMaHJGbGVC?=
 =?utf-8?B?TXFWaWVYRTlFSTEzSklyYm9tVXAySXZpUG16YThtRS9MWUYxcFUyd0JvejRL?=
 =?utf-8?B?M3NsbGpSZVNxaWhYdm1TbGpkdTN0d3JHU2x5NzR5SzJ6K3hoRzYvSjF6S0Vv?=
 =?utf-8?B?SURQbFFKYVhkbGlHTWNUNHNhQXFjVlpUb1liMkNncmcxbUtadCtlRFQ4ejRE?=
 =?utf-8?B?RHdOUU5tNERuQUo2K2g3bXpjN2FoT2pGRmxnYnRDa2dFUWhkbDBBdnNJTW1k?=
 =?utf-8?B?dlNJNTUzMmxCWGxtRHZpRnc1Sm1jbHpaV0ZmVEdiZ2hVNDZJVWdIcVR5SUJB?=
 =?utf-8?B?NlVVVHRJU0JRdVpEdHIrdWR0NE04N1E0U0tlQUM4b0FPcjJuTERoUVByclFG?=
 =?utf-8?B?SHdWa241OEk2c2VvSElpc25GRUlPM280aDNMa25kdENrL2kzeTY3aUNUL2JE?=
 =?utf-8?B?Wi9mRXpUMUFSejFzNGFoK1hSZXlYVzVkN1NzeXJjYm5DMG5XY3lwUTJQKzAv?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bHkyWDJKTEdxeXpYZzNpWnJjV3MwemdmNGVyNlJzTlg0VDFLVFVGN3RCVTA3?=
 =?utf-8?B?eGQrZ2p2YldGNmRFdVB5MlNFdTdjMXMrSytYcTE1TVA2ak02NWR5dVF2enBs?=
 =?utf-8?B?NEY3V2xQaS8vUWcwODRtdzl1UFRRYmNXQ0w3dnhvcExLYzlyL3FibXRQTDQ3?=
 =?utf-8?B?MjNYY0JzS2RZR2xoK3h5aUNQNlBoRXZzaFpoMjE4ek9HNnpDMjBrQ2pQUld5?=
 =?utf-8?B?dGQ1Yy9NMmxYdW9XUFVHUWxrZWZKM3BLejBwTzhkeGplYnFpdFQ0aGE1b1lS?=
 =?utf-8?B?S1BzNmd2YmxoTlB4eUY5WVVObjRyMmpxUmRTZi8rVFhvWXlUd3dRZmZvOS8x?=
 =?utf-8?B?UlBaY1VxUHd4c1RZWkxFTDhkczlVb0J6UXZ0R0JVVFNsUmlvQzBUWmdDNjNw?=
 =?utf-8?B?YVd2ZndJUzNtR215VTM4aEdyZWhSbHBxZm1obmZ6VHhDMXk5VGs4c0dDUTBm?=
 =?utf-8?B?SlB1YStXTWVOWjF6djc0Q2s5elJBSFVWNHZSY2Mrb2c2aWNncVpqb1pxY2ww?=
 =?utf-8?B?dVlnYldjZEcyQytnQkpZMGh0YVJLT29FK1ZXWDRxaEp4SkE1TGg0WHNYVE9t?=
 =?utf-8?B?WnA1NncwMFlhelNoZUx6d1ZlbzdYTzVac0VxNElZVFlKMlg3NG1UaGl2amtU?=
 =?utf-8?B?a3E3cG1ualFMNGlKa2ZZeTN0NlNTRmRSMjk5YTVSM0ZscmpHZmxQNElKcHVr?=
 =?utf-8?B?RXE2ekI0d0NRdmJEcWR2UHhEWkFWSkkvY3dYTGdXWEJGVXlyUEhhc3h0OWlQ?=
 =?utf-8?B?Q0RqUHBwdTRuOUdnNGlZS2lGeDlaS2t0c2xBcWZSYkpBVkxrcFhJTGhkSHNE?=
 =?utf-8?B?eS9zbDdaVXBUbExEcVZUTnVrU0dMU3Z3d2R3SVdnRUJ6TUJTbnBiVEJKWVJz?=
 =?utf-8?B?MUdDcExvV01tczh2MkhOQjUyS05hRm43c1A5dG9RWitWZWVGb2c0Y2RJaEZD?=
 =?utf-8?B?YmI5T25MZ3BwLzV4RXhPaFZ2Z3RnbytleG9uMHJWWm96WEwvMVhaQ3Q3cHNP?=
 =?utf-8?B?T05GZnNMaDRNRDlQYUMxZmNCamhxRzhNTSsxekhWUERyWGVWWHBjcXo5UXZV?=
 =?utf-8?B?cmlnNkVaYTAvNndMRzRUSVVQNnlwVXB4SENibVU2cWREMGJoVkk3ZzJiZUxZ?=
 =?utf-8?B?bHA2RkVUTi9oZUttVXlBWUVsT2c2UHo2cEtmY0tSbjJrNk5na3VFMHRiVG5t?=
 =?utf-8?B?MGMvOFZYQkUzNGYreHl6VlVtRjJXSGNOdCtvcHppRS8yT0IvK0VvRGpja3E0?=
 =?utf-8?B?Tm9FTmtyQ00rL2EzNUp4dlhFNGJUZjJac1Y3UWpEWFJlWlVCKzZWWFFkaGVo?=
 =?utf-8?B?cVFBOFArOFZSOXZ6bTNrU3lLbXNBc2hOdW1SMkxQOXRoenNoMFpUZmh0S3pY?=
 =?utf-8?B?R0tQYUxnM2NoL0dCajFqVHFJMVJPb0N4akNZSVlqT3N0d2VpUTJmWVFOOFk0?=
 =?utf-8?Q?MpcfhY9I?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b872081f-afb5-41d2-ea7c-08db66cdef0c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 20:38:06.9715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WuvBKM/PSrajcu0m9w7SYedLhas4o3DugXxk/Az0DOQyHH+tL02Odg0l5sWLtD4Qf++ZNNzkInNg4DZQQA6K6dfv4AyRhHreTlXO93iw14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5923
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_15,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306060175
X-Proofpoint-GUID: DDXDw1ehVfkLBlnoWpfPUPARatcOrFgc
X-Proofpoint-ORIG-GUID: DDXDw1ehVfkLBlnoWpfPUPARatcOrFgc
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/23 2:39 PM, Oleg Nesterov wrote:
> On 06/06, Mike Christie wrote:
>>
>> On 6/6/23 7:16 AM, Oleg Nesterov wrote:
>>> On 06/05, Mike Christie wrote:
>>>
>>>> So it works like if we were using a kthread still:
>>>>
>>>> 1. Userapce thread0 opens /dev/vhost-$something.
>>>> 2. thread0 does VHOST_SET_OWNER ioctl. This calls vhost_task_create() to
>>>> create the task_struct which runs the vhost_worker() function which handles
>>>> the work->fns.
>>>> 3. If userspace now does a SIGKILL or just exits without doing a close() on
>>>> /dev/vhost-$something, then when thread0 does exit_files() that will do the
>>>> fput that does vhost-$something's file_operations->release.
>>>
>>> So, at least in this simple case vhost_worker() can just exit after SIGKILL,
>>> and thread0 can flush the outstanding commands when it calls vhost_dev_flush()
>>> rather than wait for vhost_worker().
>>>
>>> Right?
>>
>> With the current code, the answer is no. We would hang like I mentioned here:
>>
>> https://lore.kernel.org/lkml/ae250076-7d55-c407-1066-86b37014c69c@oracle.com/
> 
> If only I could fully understand this email ;)
> 
> Could you spell to explain why this can't work (again, in this simple case) ?
> 
> My current (and I know, very poor) understanding is that .release() should
> roughly do the following:
> 
> 	1. Ensure that vhost_work_queue() can't add the new callbacks
> 
> 	2. Call vhost_dev_flush() to ensure that worker->work_list is empty
> 

The problem is what do we do in the work->fn.

What you wrote is correct for cleaning up the work_list. However, the lower level
vhost drivers, like vhost-scsi, will do something like:

async_submit_request_to_storage/net_layer()

from their work->fn. The submission is async so when the request completes it
calls some callbacks that call into the vhost driver and vhost layer. For
vhost-scsi the call back will run vhost_queue_work so we can complete the request
from the vhost_task.

So if we've already run the work->fn then we need to add code to handle the
completion of the request we submitted. We need:

1. vhost_queue_work needs some code to detect when the vhost_task has exited
so we don't do vhost_task_wake on a freed task.

I was saying for this, we can sprinkle some RCU in there and in the code paths
we cleanup the vhost_task.

2. The next problem is that if the vhost_task is going to just loop over the
work_list and kill those works before it exits (or if we do it from the vhost_dev_flush
function), then we still have handle those async requests that got kicked off to
some other layer that are going to eventually complete and try to call
vhost_work_queue.

With #1, we can detect when the vhost_task is no longer usable, so we then need
to modify the drivers to detect that and instead of trying to execute like normal
where they queue the work, they just take their failure paths and free resources.

So the release cabllback was doing 2 things:
1. Flushing the work_list
2. Waiting on the those request completions

And so I was saying before I'm trying to finish up handling #2. I hit some
hiccups though because it turns out there is at least one case where we
don't have a vhost_task but we don't want to fail. It's just a matter of
coding it though.
