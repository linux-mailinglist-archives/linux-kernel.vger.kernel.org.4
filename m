Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68AE717465
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 05:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbjEaDbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 23:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjEaDbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 23:31:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06073A0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 20:30:57 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UNO009020056;
        Wed, 31 May 2023 03:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=FP8/Y0qFVzMrX6PCmrKmF0MPokHoQIk5/s8lvB9xnZY=;
 b=OQFpn59C1rfvwYPTXT5PXFObiHGOwfTQvaXhv3ImH76LLlkUvPJ0RUrlDreQQP+i3+4t
 GD7hB+efpIB3TejE1nANu1zpVjCf7a8pikaivdxUoi1K9ZE0nGrilirmRlZFPDniPOig
 4dj4VRAGSqoAWFozJ1EZYg4C6r3vQgjDLkfrq4wf/tP2Of6arJMqg2aevF9ceqnFpv+5
 KwOGtVscnJL8l/hwzW6DJjUACK9zylSqI0ucQGh8vUosdsHIA1CoeoTDnwa1j7dE0nmd
 gVG+5b7sBq5un7Db8iMcXqYeIrbKVa6puvuMazhdc8jxFgvr/DwLehDX0SxrXaIxs262 /A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhd9vn76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 03:30:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34V3SQdj004438;
        Wed, 31 May 2023 03:30:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qv4ycek8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 03:30:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mt3RvzKNppXez7gTaHiXeJ99nPfDY1SvP1zUcgnZYgQADGvi/sEgJ6ws9m0MEmWe2qzJGRQe+KWHtWY1z8UJPGMABT4DsAnDIiKJP6wmBbx1v+ZVyxdC/dn0wX2+8lfZL3ToEZqJg5ouVnNFYmcb83lwyaDNBNmhjqIJmGR0OqllQ0hOHSqD7Y6D/iJCx3kQbfIdWmx6mLpqFoxF+d5RI8tNbPaoR3eLc+7iYjTihueE+u1FZ90DVRNMRZmiH/llsNK3O9RMRt35gAoNwhm2BdK83gOI8eTrIaF2EfxqUhejRtG5sbFze6tdnvSOVmp/jYQu/YVifQowU4sEY+NeJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FP8/Y0qFVzMrX6PCmrKmF0MPokHoQIk5/s8lvB9xnZY=;
 b=BNz2ZzOwShIk4+dig0z1/b66VqIKGZR4out7+J9pP7pEuYiOQA8QBEpgE6AhujwlsspGMSYFkkFdMyHG6iBj0xeDTQonFkVrhv5Z+s0YuqRBnJ8yhhrl4ebXkMm5vH/Us9u2AtTES6SR2d8N3+UkIEAdX3Rg7ficVICOgn+vC+XHmFsazo8g6Ky3/HjGPJBVs1uCSjpEOjJabosGjMUNhg81f1myMBINxBLL9P41lI8Syey03vAyDuMQVaIeEED8e0aJrIjkax/3M60xpWdNwKmdne/zjhR3lI8jDGL9k0f4XqzQyH3GyMkyEAhMp5gpR2Kzg4iUpR89STM5UvT3tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FP8/Y0qFVzMrX6PCmrKmF0MPokHoQIk5/s8lvB9xnZY=;
 b=X8ZCznPM+QMdp5zs6G7VSVwEOhgJa+qFu40FT/sk9LLn8lQIxIyBtGc7JDh+vdBwwual9IJCC1lQlOw9fgMnciE1zJNyPoQh8SzUKZlIKDu0Ir2wXrbmAFzdCRCrjZ4ok4s/fHentnj1O4f2JVqWMO7Ywlm7fP641TwinK0KjPs=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by BL3PR10MB6164.namprd10.prod.outlook.com (2603:10b6:208:3bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 03:30:40 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6433.024; Wed, 31 May 2023
 03:30:39 +0000
Message-ID: <ad128a2f-df04-ed1b-f444-24c1754bf80c@oracle.com>
Date:   Tue, 30 May 2023 22:30:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230523121506.GA6562@redhat.com>
 <87bkib6nxr.fsf@email.froward.int.ebiederm.org>
 <20230524141022.GA19091@redhat.com>
 <87ttw1zt4i.fsf@email.froward.int.ebiederm.org>
 <20230525115512.GA9229@redhat.com>
 <87y1lcxwcj.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wj4DS=2F5mW+K2P7cVqrsuGd3rKE_2k2BqnnPeeYhUCvg@mail.gmail.com>
 <87cz2mrtnk.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whsi9JFP-okH3jXHrA8rh8bMuuSt6ZgkmPwiDMAn437qA@mail.gmail.com>
 <87mt1pmezu.fsf@email.froward.int.ebiederm.org>
 <20230529111859.GA15193@redhat.com>
 <022f4de6-9eae-0a94-0f55-b84be4982fc3@oracle.com>
 <87sfbeh7b5.fsf@email.froward.int.ebiederm.org>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <87sfbeh7b5.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0038.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::12) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|BL3PR10MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c8d4abf-b95e-4fbc-9b6e-08db618767bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Js/5S1oDv4rgJWzJ/cv6ZSOm6e1Jm4qBdRG9MY1V3XcJtSwihilGZwDkVNyhxvnXvQYW4cdf5ley6Yh7oGZxJ17OmwAm6POD3VWZ9nqxP6D9nM+Ie+sbtevrFQN0Qtyf0Xx5obGrt9Z2zAvBo/15fskCHtRLiNoptJsPuzD1Sf/zv4pVkX9iATvw25eqBJ19G173XoPnijcGKkSKulbX3sgHBy8OcCQY7A7R2Ig/z1eZRKuMpxFRUf04pisNvQ8KygXpkwkX8WuvMzSp9ZbRw3IgXc/cLlZy+lavvI/ZNVba2W0xdmBEEhsglO/J2ABprBQwkn4qTW16Ykf8FZX9GlcaqL4IBDoL0y8tcmnzm5iPkuCLq1H2idcc1ftKZL3ULat1CL0TVIpqvkodF4RwCKtkcU/nJplrctK63sfu6edfs+YqIAbPcEG7gVqLH0frCcm0dcmoHhdV8+lmHsnUIA+oO7yo9u+SrZHtBVwKEJ0hEPpJbUX42s2aLmUHZGGzM8DFhjLlrN/tCmDYtOI2Cr6v08km9LnV3yLos86X2ZRj9JEwCnYotWwlUU1guN7W9poTaBqTZFC8ryX+tD5DSrH9a1EXG6C6g9UnVvRv3PZLKxCUGGwKMFkZ+MHto0mR1rjOe+E4pydeII9BQfn+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(54906003)(5660300002)(8676002)(8936002)(2906002)(66556008)(66946007)(6916009)(4326008)(66476007)(7416002)(41300700001)(316002)(31686004)(478600001)(6486002)(6506007)(6512007)(53546011)(186003)(26005)(83380400001)(36756003)(86362001)(2616005)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXc4aGFKS3V4YmwrS3JJTUI2V21sNzFkbEpSMmdGc01HNVkzeXNidUxvdk1x?=
 =?utf-8?B?Y2RTaVM2ZVoyZXdsNm05bytEaUNjdS9rSjVoeGNEVzRiWkFTcDluMVIySXlM?=
 =?utf-8?B?VWg2SVRlSkJaR0dUdzRKeTdjNHpKVTg0ZEJScHZDajd3bHVZSlIvQTVBaGlP?=
 =?utf-8?B?OVBmNC8wWmZ5aXVsbGcwZ2ZyM1NvNkt0OGlLTmE5eS9KeWJZUzlpWmhGS1BL?=
 =?utf-8?B?NkVnbTNlTTE4ZGlUWHIzdTRJbTg3U1dHcjBpUkpQOGFyeFZETkk1VFVvWXFF?=
 =?utf-8?B?cHlhMVVESTM2MUUwdXJpSGRjdDVDL3hwSzJYY3NtM0xYMklQRWllNzA0RlNi?=
 =?utf-8?B?bEw4Q0JnR051cFU1THJyMFg2bVp1RzB5Z0lEM2dtc2l5Z1QxM1BkSWNoVWFW?=
 =?utf-8?B?cUlmazBpYyt5YkpjNVdXTldUbXc4VlBMWllCQmQ2U0UrK1ZkRkd2TW5yWEJi?=
 =?utf-8?B?RmJjN1o0aDllOHJhQTBQeU44UjV5WHhJRXNOSGxrMzVxOWplMXFqT3NYWWdp?=
 =?utf-8?B?L1hvSER4VTBLMzh5Q2xYbmxvZEFJaDZFaGRTVnAyaThwczhUN1EwbmZZOFAz?=
 =?utf-8?B?eHN6WDdObUdkTThVR3lPSUZNUllYbFd5WDRHSzJsNk9obUlNcmVaMlhkbGFN?=
 =?utf-8?B?aGdnaVJESEErVEdoZ0lmMXRaWWdqMllUNEFPcUd1UmFLWGNacENmZERBbXlh?=
 =?utf-8?B?K3Q5NmdNYjJvTUdGSVB6RG9IekxucndQeGZMMDVXZ3dBNE80WDFveVFDTjZ3?=
 =?utf-8?B?TXpEc2FkajF1dDAyWGtBQ3dCenlaSUdqNk5BaTVaQnQ5MkVTY2xQUDRRSWlP?=
 =?utf-8?B?WlYwT1JUc3JGQkxwYmVnVEoycVc1a1ZwaFllMkF1dnJ5M205S2pUWEltRnhw?=
 =?utf-8?B?M1hhSVJDcWR4dlFQMnVUdE5FaXBVOHpKYlVCS2tQY1VSdUJMRkNlTW0yS0U0?=
 =?utf-8?B?alFwd09uSlRDaTQzL0QyMW9NakgyMDVIZmVrYUdSSXFzZitHVlNWY09ncVY2?=
 =?utf-8?B?YTAwMzg4cEs4Qm9BVkFleWwyWWRsMHpyeTVrQXEzcXNob09jcHlZTWtNdE5I?=
 =?utf-8?B?Y2JGMEdCRENGYVVqcWQvNkt0QzdlNlkwVEpPc1ZKS3QyYVlSMTNxQ3B6OGZE?=
 =?utf-8?B?ZGhiZ0t6Tm1Cd2t5aXNVc0xPaEhuR1JEVUZ0MmRWZ1JMWkxrRFFQV3NVUHVn?=
 =?utf-8?B?RC95L2N0MmlkOGpJa2QwdEhkNTJuUVZjNGlQU0RGNVduWHovQlFxd0VTZy9k?=
 =?utf-8?B?L3ZnNmM1ZUtZWkdqL21iL3V0QWUzSWg0aUZyM0IwdzBsYjFUSkZRa2pBVVFq?=
 =?utf-8?B?RHBjZTJLYkEvTENmT2ZQcS9yUnZqNFhLbG9tZzdtdjVjN2tzTlJhazdXaG5w?=
 =?utf-8?B?V2ZwaG9ET1A0RnBQUzMreWhudUlxSUZVU0NXY2kzVU9GM2JDVG8wQ2FybHB6?=
 =?utf-8?B?QU5lMFdCdTU0cXR2V1Rud1A3SUIxZkt3VzZvU1RBSW0wYjN5cnB2aUNidkdk?=
 =?utf-8?B?MHlLVVNMZ1Q3WGpmOU5kSS9NOENFMlNGKzJwbW90c0owSkJFR3R2Zm9pNWVE?=
 =?utf-8?B?SlZ1cGVIcmlPWG4wekhYU0U4Vjc1bVdzNVc5OS9LTXk4RVk3Wnprd1hrQTdK?=
 =?utf-8?B?dVB0Y21OZyt6N1ZESFdldlU2eGJnSzl4Ylp1UXVsWHIwR0JndyszTlh0Ym9V?=
 =?utf-8?B?RnlVRjNkWVlkMXAraHpoa3VxTjZLazRzRm5QNzIrdlB2dHRJaU0rRHhmc2tI?=
 =?utf-8?B?Vnd3WTg0alFtMk1sM1A4OFBycmtTOHdIZDJiUmdvNWRaWFN4RFNxRFVoQzhu?=
 =?utf-8?B?ZGtzWDFpcFdpcE5aQVgwczlEeGdCNUFTWkZBM0dpaHhxejBrRm5NUCt5ZHMy?=
 =?utf-8?B?UFlHTURGMXVPN3oraXg1RnFBQzRROThmeWI0RGdkbXdaeDd6RjFLRmlreDY2?=
 =?utf-8?B?VUxFVjg0Q3lCMjN6b3dFTHlnY0J5ZkxaSW51VzltVjBFcTY1dm1TdHBFblZi?=
 =?utf-8?B?V2lrbWc4dEY3dENBNW1ONUJpNldjRTZ4VHBqcHpHU2ZTRjAvU2hWZ2xnVDBM?=
 =?utf-8?B?c3piaTJkWXJkaTIySmRHalJQVXh2SExuOVBtbVBWTm53dVZLMVlzcTdCMExt?=
 =?utf-8?B?dGE3OEVMaHBkRnh5dG1PNnUzN3BBNmVTK3czRU1kMHNjeUpIbVhydVlGRjNk?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NW5pYXdhZkoxS0dDRDB1M0hhdFVEL1dJNzVtMkFydEpzVVJLRUdXOFZNc3RJ?=
 =?utf-8?B?RTk4Q1V0eEI4WDZKbmxHVWpEdDhXUlZEbmxmcEpyemxmWHZkb09NcEZzbGg4?=
 =?utf-8?B?YVcva1FETlBlRTRLcXVXcWNjcXBBM3BrRDlzNnF4d3h3YkFTb241VjVxbllt?=
 =?utf-8?B?ZnlkeHN4WC9rUzl2SXZ2Ry9EeVUyNTBNNTBzRDlDY2Q1dFFmVU9oVHk5Zk1m?=
 =?utf-8?B?Y0ExZ0ZtMjNYNldvVklGdWprcTRJZjhRWHMycSs1L3VEOEs2RS9Yd2ZybmtL?=
 =?utf-8?B?YVdlSXd2S1haejlHRHV5NSt6RTFVdGFnN1p5TU45dTNaNjA2OEU3d1VpR0Fu?=
 =?utf-8?B?cWRzd1pVeENVM3hxVHdHRWl1ODkzTEczTXc4dFl4TlorWjltUEhlVUd5aDRq?=
 =?utf-8?B?Z3UvTDArK2VCZGdNc1JqQUpOTkNURkt1T253czc0bGNuOHNIZUxNQlRWUk96?=
 =?utf-8?B?UlduVXIrYTlmdUNWdkwxWDNuWDRYeUNlWUJlVmNVanZJSC9CZUF2UFlZRXFw?=
 =?utf-8?B?NUtNcFhTVmVxdkZBRmcwY3ZOWlVPTEViWEhrM3B6NHNBUVU2Y2NicFdlMnB4?=
 =?utf-8?B?bncvck9ZR0w3TmkzNHFGdVhPaXZUVUtPSEtzbmhabGVUUm04MXFNT1kydlJn?=
 =?utf-8?B?M2FEdUhXOTdxajEvemlFRWJSSytMS2phQzJOUjgzUnBEZWtJR0NLcWNaMVo3?=
 =?utf-8?B?UU9VR24yc01rUS9qMWcrZkpTRk1vMzRaaFlqWHo2VEJETHRxMDFFemNlTWM4?=
 =?utf-8?B?NFFrNzhHZi9lejZGQmROZ3dRVFhEcndJMXZWNFhjb2JvZFNNdjBnMzc5d2Fs?=
 =?utf-8?B?YkRoT0U3QXBqSzdkQXpFa3dFYU5UdHNyTXpCSUxkbFUvME1FUUIrOFFzbExz?=
 =?utf-8?B?STRBaDVuR0k4UlBXd09JUFNZS0xGNzRQY1c4K3lqK1o5T09saWF1bGk5Y3JL?=
 =?utf-8?B?S3UxZGYzMXRONTA0cGd6aDlaQjlPd2RlL25tdFhwb1pZc29uTysvM3kzK3ZH?=
 =?utf-8?B?Nll5a3phV1dOUkdWSlVubzFla1I0VHpLSEJiTDJvR1c3RElYalB5VG9kU2V2?=
 =?utf-8?B?M3dWaFVhczNKRHEyWkpqK1Z6OUQ2YnJJbkZSZGJYMGlKSnNoL2M3aXlucGFo?=
 =?utf-8?B?OWFCQUZXeGRRVm5HYjFQUnlicm5RQVQ0K2NOTVIvWEhwa2NjODdQc0xSd2RF?=
 =?utf-8?B?QVhQZFk1NlYveXUybTRHRjRhUUR3ZjBKcnREM1BySHRLZy9DNVNJdy9xQjQx?=
 =?utf-8?B?ekc4VjdJR3hZS3YxVmFFSmoxd2FzZk5CeEIrakFDVW1MMENHWERyYUpJd3d4?=
 =?utf-8?B?R3RvNUNtTFZwSnhUQXB4N0I0bUpJRnJ2bDRhZjFMWUhwL21lUEZPN2JJOWtu?=
 =?utf-8?B?QzEwUGJNOWE1b1llR1psdFN2UDA0UjJMY3BzM0JFejNUSGJ1Snl5WU9FMjFj?=
 =?utf-8?Q?pQB3Go6k?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8d4abf-b95e-4fbc-9b6e-08db618767bc
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 03:30:39.5073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00doL3134Qfrh/8ntPZKeH+WzANxlbZ/Dxs1L+VD30Oy02EbG6kK3m65H0DXSLI8qNjc3UVBo2uv6ibUYonxAj5GxO9LrdL+r8BzWBsawcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_18,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=970
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310028
X-Proofpoint-GUID: 50ypoRpH60sEsLEah2PDxWk_uVt_0lhf
X-Proofpoint-ORIG-GUID: 50ypoRpH60sEsLEah2PDxWk_uVt_0lhf
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/23 9:38 PM, Eric W. Biederman wrote:
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index b7cbd66f889e..f3ce0fa6edd7 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c

...

>  static int vhost_task_fn(void *data)
>  {
>  	struct vhost_task *vtsk = data;
> -	int ret;
> +	bool dead = false;
> +
> +	for (;;) {
> +		bool did_work;
> +
> +		/* mb paired w/ kthread_stop */
> +		set_current_state(TASK_INTERRUPTIBLE);
> +
> +		if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
> +			__set_current_state(TASK_RUNNING);
> +			break;
> +		}
> +
> +		if (!dead && signal_pending(current)) {
> +			struct ksignal ksig;
> +			/*
> +			 * Calling get_signal will block in SIGSTOP,
> +			 * or clear fatal_signal_pending, but remember
> +			 * what was set.
> +			 *
> +			 * This thread won't actually exit until all
> +			 * of the file descriptors are closed, and
> +			 * the release function is called.
> +			 */
> +			dead = get_signal(&ksig);

Hey Eric, the patch works well. Thanks! There was just one small issue.

get_signal() does try_to_freeze() -> ... __might_sleep() which wants the
state to be TASK_RUNNING.

We just need the patch below on top of yours which I think also cleans up
some of the state setting weirdness with the code like where vhost.c calls
__set_current_state(TASK_RUNNING) for each work. It looks like that was
not needed for any reason like a work->fn changing the state and the old
code could have done:

                node = llist_del_all(&worker->work_list);
                if (!node) {
                        schedule();
			continue;
		} else {
			__set_current_state(TASK_RUNNING);
		}

So I think we can do the following on top of your patch:

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 221d1b6c1be5..074273020849 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -346,7 +346,6 @@ static bool vhost_worker(void *data)
 		smp_wmb();
 		llist_for_each_entry_safe(work, work_next, node, node) {
 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
-			__set_current_state(TASK_RUNNING);
 			kcov_remote_start_common(worker->kcov_handle);
 			work->fn(work);
 			kcov_remote_stop();
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index f3ce0fa6edd7..fead2ed29561 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -29,12 +29,8 @@ static int vhost_task_fn(void *data)
 		bool did_work;
 
 		/* mb paired w/ kthread_stop */
-		set_current_state(TASK_INTERRUPTIBLE);
-
-		if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
-			__set_current_state(TASK_RUNNING);
+		if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags))
 			break;
-		}
 
 		if (!dead && signal_pending(current)) {
 			struct ksignal ksig;
@@ -53,8 +49,10 @@ static int vhost_task_fn(void *data)
 		}
 
 		did_work = vtsk->fn(vtsk->data);
-		if (!did_work)
+		if (!did_work) {
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule();
+		}
 	}
 
 	complete(&vtsk->exited);



