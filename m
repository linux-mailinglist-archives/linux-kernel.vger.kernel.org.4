Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E24707583
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 00:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjEQWe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 18:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjEQWeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 18:34:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEB2E6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 15:34:23 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIGT3h006345;
        Wed, 17 May 2023 22:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=COxpRqssJcu+PP1kQq6xaDdqcJS4nyZwBwFcA8mnOwo=;
 b=lk8J850NIX1VZ1I1uzvH0pdYbKaxT47k8bL3m4WQCcLGEPjEmtXKuxjX+cPwu+xKFezH
 aTJWrNj2vnF2ZDDTY6Vz/YeOm1hVjxI5c1xjRbidQGmqYiwAMPmIT1eHzo1DQM+S11SV
 rnf8zf0Ss3/nO+n90GbudgvRPICU53iUfp2w37ISvopS+f16oPA4zooYgSfTD8wmYXKm
 zVeNiWS7R1+XBSEeOme1TvEZr7Yy8H+h6idkJ2bAQBZnyBDcXFuwceOJuwv67lwXw5++
 CpWi34n9FT+CzE3dEEY8+qVrzOcwh4QOtwT4ux7Z98AK7SWr5Cu0K2+tHgMdgVyqIluO eQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdq2u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 22:34:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HLhptO039975;
        Wed, 17 May 2023 22:33:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj105snv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 22:33:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOguWISJpqnz1kk0/gis7WQEB0BqOkKDH2pDqY6t7fU0sUiSOgvZIcuTWHe7bMo7qzw7oBbowHCN5GzmCTlP5nrCI3tlznTYHyLbo38UlEYQfJm3MUoHQ68TDPzpn5Dj5rxwdo7V++tzGAgX9bHOhgcYoUpbzw9NIngMwpg16U1tBQnkdDTkhb9iP4uxJfwKSGYXHbPH22tdR4e6gCMDpwCnb3kIvG5Wlfgf73eM/wozqHCfrdYQg9oxcu98YGB8qQXUb6dVG6KA+sEfrlWfSlS3v7fhNalDJ4MPu01lSyMQjN5JDxosqZDn0lDmrJK49mPd5vvIDFh31NbNAayUrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COxpRqssJcu+PP1kQq6xaDdqcJS4nyZwBwFcA8mnOwo=;
 b=DueDpqlhjKDFSysE0Vmj/Ss5tiaEDsdmG6o6NdkddLM55nTJIdhPLMCPOxxrxMFYc9C5+VfvjR6WbmFFaL8pUxJmv9HIhzzjwAG65hhcvOx2GcEWCOng8cur091u05+/M634Yd7ztQYc8ONoH7j7AxEPZaEbh2VaiirZ7AJYosxl0T7ujvVrim+XZT0PnQhmtckyho/7IeJM++Q32JvJkSZ83htw1Y9n3w55utspo5nyqs2muok9aVhaVX+ewwRHCNEyqEnUoeDQWwl6pkxZhMsxDsr+R2DUn+W4azRiYVAMPLTaQNMxSyYtx7d7MJ/FTbk+eO8qbTyHufrf2lO1RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COxpRqssJcu+PP1kQq6xaDdqcJS4nyZwBwFcA8mnOwo=;
 b=UBXKCcloV9OpVFnVyWRa5ZDao+fsnXMrnKT2gfkrypdmze/KgDD+XoazcpxIU0vvNVBWy8ylXIKMpd+wFbLN9SRr4L1NDflM3F+Cvk1PAtv6evnHLjo37wIGc+lf+TjosDAbvPlSv9sBN7Cxf28CA0ndFMNeizuFp0a/wmVtBng=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 22:33:57 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae%6]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 22:33:55 +0000
Message-ID: <9704cc32-3bb6-bcc8-896c-688d2112102c@oracle.com>
Date:   Wed, 17 May 2023 16:33:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] mm, compaction: Skip all non-migratable pages during
 scan
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, steven.sistare@oracle.com,
        ying.huang@intel.com, mgorman@techsingularity.net,
        khalid@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230517161555.84776-1-khalid.aziz@oracle.com>
 <c34e3768-8a01-d155-1970-8eada8c80ba7@redhat.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <c34e3768-8a01-d155-1970-8eada8c80ba7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:806:24::12) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|DS7PR10MB5117:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a7800d9-9541-4d18-01c8-08db5726cc75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8JOxzOdkCbl59lvOyCNipqVs1qlaAPNwAQClntZiGdk2Pmuz2adspaA1FOvEnNquYe5n+MZC06NRfYVRzA67a6DV+qlZ25/6Jxn5ioxr39Fp46bUitjFCNNc89WuoaApv5C5QbwSHBIJJatfO2diy4MVblfsiGEe3UQYHNVc2pBy66HmYPZZ+aKTuuPRGBTkh/7a5p8uhYsB4VQUWtbMakPQYzHYfCNacNmcUDxyr4pJJbK4Yp6F7n3AhalNMVpCMOuyYfvER8vwV3opKuyWfjWMSJVBx3oYKu/pMLGE3r4bNqro9wkGtPSkoB32riMIcq2oZ+Y+cwXTkVimLSxn6l+3g2DLvNZhSIzQ2RayWIAoN56hlkJ0UUiSy97DPu2KCKhKoIT2YY/8E8TqmnmFV3L/aC44sJ2kMr/z+gAmEcIFrCbHBUEwSNkCQnHESN+Z9i3qUFWi25zrk/pNaRKPIEEFvQGgjBvodzKGIMxSXlhOVVHZVOMKhI/YygQG0DhoTTI6bwxbWnssF5GRRAyUbguBUIUvowcPK7a3GmiCxkmIdIcu594YyXV8bHiMit7VfZtO3TZCr3/1qiDH+99YIECDzIXyys58X73Ip7+n5sQ/9M0UsQ3JYtxxmvY9lvoV7Eu0O0KkE3UEUBv6nU9Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(31686004)(66899021)(86362001)(83380400001)(41300700001)(5660300002)(8936002)(36756003)(8676002)(31696002)(316002)(66476007)(4326008)(38100700002)(66556008)(66946007)(2906002)(6506007)(186003)(44832011)(26005)(6512007)(53546011)(6486002)(2616005)(6666004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djg1aXRvNUdJSHYyaG0wZlI5YjBmeTlQb2l2a2dsUmY1Y0RYN2ttMjBRVjdl?=
 =?utf-8?B?WTAxUjBOZlgxRGxpb1VhTVJ1ZUd3cU0vVkVNT2ZvelI1bXF5TjJOdXZycTRt?=
 =?utf-8?B?WThGZzBKbFNocW5MVERXdDVGYnhXWjhoV3E3MWlpVGpRNGwvblVEaS9qRi94?=
 =?utf-8?B?a0g5eXZIdEY1K3VDWU5GUVNkSk9ZNWVab2ZuY1UxTG94MjZyV2IyU1hrc3Ir?=
 =?utf-8?B?MXQ0cHJMRDd6alNFdHVqYkVadk9ibmlhNG52QlRGTmhGamlhQVg0RXZpZlJ1?=
 =?utf-8?B?RXIzM3dsRjdURDhPT3BDem9zb0tQMVlPTDAxcmFLMHBHSzhBbGhKeGhKaFZn?=
 =?utf-8?B?OUNJNFRCckVhY2VVdllzTXNKcFdWNG1RS292c0NYbzBiK0NGbG9ncmhUQkY4?=
 =?utf-8?B?bTVKWWx3OE1pZi9HdU9uTWhGbFJ5cGFtSzkxbWY1NFArV3VkM01HanVENFUy?=
 =?utf-8?B?Q0hHZkxDWDI3czFiQmFLdHIrb1ltdkFRalNESmRiTG5Qc3BhMGloVUV3MEhu?=
 =?utf-8?B?YkhPeWpnaFAzdGdGN2RJYzMwMUJLb045WXJqdkpSYmlnVE0ydUMvTGREUmsz?=
 =?utf-8?B?THF5ZW1KWDE4UnpLdjAyQnNqTmJEOTNyNFh0dzJDaDhHb2M5Vm9aclNkOHZD?=
 =?utf-8?B?dStaRXE2MjlSclNlNW9Cb1ZxY0llUDNzMTZVZEhkS0ZVcFFQSjRKZlI1WEpo?=
 =?utf-8?B?RHhETGpoVmNyWTVYSlVZd3VpV1FOcmtkNklJNEhpS0tEMXZkNy8vc05KbzdU?=
 =?utf-8?B?YTJiRGdnU0JnRlAvc1hTQlduSGcva2o3RkNkUUI5eDRkOWMvbEJCVHFFbnJw?=
 =?utf-8?B?WjNjR1R4dmlsWmFzSlU5OWhISDBxVThJOHVXZGJFUzBuZ0tqN05hZGh3SXpo?=
 =?utf-8?B?Nk9wbGtuSVVHcnFJSVhKbEdWZWF2cmE2R1BvaFFJaW01UnJQaHVSa3orS0sx?=
 =?utf-8?B?NE5NZ2RLQ28wQ0RraHNiajBzZWxoYnNyTmcyS2pxMG9NNUNFUzQ1UGRNNzY1?=
 =?utf-8?B?UmZ1Q1NaU0VoTCtUZm5VbUNWNWRGWUFMeXBGVk9KWGZPM0dvcGZKQ3IzT1kx?=
 =?utf-8?B?blpLMmZ1N0RRazFUdXQzemUvc3ZZRERqTk4wVGpUL0pqWnVWd3U1eWJFdXBY?=
 =?utf-8?B?NWRsd25tZEQ1SEVJai9FYXJGR3hranR1SEtlOTNnL3ZCTUhyajZQMGVIRXo2?=
 =?utf-8?B?SXMyZFdyVVBVa1NEYlRwR2s5dmthTllvSWJPY3VvT2tYZmpjZHpJa04rUUZj?=
 =?utf-8?B?TDdvaVFEMnpjZWVTbjU5SFNoamlpT2w5THlJbHN3NDRyRmliSWpxaFBwU2VK?=
 =?utf-8?B?V3ZaYUlMeTRpK1o3RFJ6K2pvVnA4OE9iWGZXRk5lNVovbXlXV2xXZ2Z3WmVC?=
 =?utf-8?B?TGh5YUJzTDl2QWdoN090dTlUL2JhZTJKRFUyaWNvWDcyVTZVWGVkV1ZUTU5s?=
 =?utf-8?B?di90Y2srYzh2MUNQQXRET0FTMElubFUxRUxheUVqUEJ0K1dNbFpSVkJYOVEy?=
 =?utf-8?B?MkJmTEM2NGhacTVERHVZRHJucnd1UFRHdTJyTFZhUHRoQVk5dkRkRVpmQ25t?=
 =?utf-8?B?Qlo0NG1yVVZ5WTZ4N0lMY2k4VGE1Y09vQy9NVzBEVi9WWVE0djFVcU9sZy84?=
 =?utf-8?B?elhGUS9XdTNETkZpQlZrMG10RmE0NHM0RFJGZVd5KzJwMFBYUzd1TFh1NWU4?=
 =?utf-8?B?ejBqdnorRFZDQzhuNU1JckdiNmtMeU92aXlRS2ZVUENWUldQSXRnSlJXZGlw?=
 =?utf-8?B?Zjc4alVtYzZULzAxK0JTQWRPSlFPOUQ2R0xxSE1LTHpmdEx0RlFRY09VV3lt?=
 =?utf-8?B?UkMyQ3drR1VXTmRraHI5RU9Cb2tXclhQVWxtRjVNbzlTVUYrdU12VnpwV2V0?=
 =?utf-8?B?ZmVjVExGalZxTHpIdUhPWkxxc3NNa2FBUzBzU2ovR3IxYzR5cWxzRkF4a2wr?=
 =?utf-8?B?Uy9vNkRRNEU4eHk5bTUyODNqLzlrT05lYWlvZ1lEQVZYZld4RTBrcDVpYjNC?=
 =?utf-8?B?QlVDVU5LeGN3Q1VWTnZmWWVNd1RkWDlsQVVTUXJJV3dyWjcwNUd4aTdGTlVz?=
 =?utf-8?B?YVFvcHJIRnJ2bjNDV2NPOXYwajZqdTBmU0R4bUtKUnFqZVBUQkhsN0ZlZ1BE?=
 =?utf-8?Q?GN4DhZpnwZmsSh5F6iik1XuWM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bFdXVUJIckhGU0hheStwU0ZQd0FnSmhtNzNQWXBjekxRWXBETisxRUFhVFRB?=
 =?utf-8?B?QTlGMHdPdVJKRldNVXlTa0oyR3B4a0trVWhFby9qSTZOcCs0c1dtOU53YWpQ?=
 =?utf-8?B?Ym5EclRHanFlcEZrcStVQjZpOWxXNStsQmhnbHVNSmdlQjI4UWxVZHZOZmd1?=
 =?utf-8?B?d3hXakVadWlnbWVVb3lYYVRnNFBYSEJaQjU3ZC9iMWNaRXdqQUZHUFlFR1FC?=
 =?utf-8?B?OUp4RXFkQnVrTVdEN3Z0Z1hHUVRRV2dldTNyN3FsMHM5SkhrcEZvdnB5QUtQ?=
 =?utf-8?B?T05Hc2REclpSbmRIMytwVDA3Vm5VRGYvTzF2OWFFbXNYOWpaNDZIY0orT083?=
 =?utf-8?B?cFNTVUpiRVp0eWF3dThEY2Z1cDRxS0ZVaVN2VFNTN0FKM1UyM0ovWXdaMUhJ?=
 =?utf-8?B?RkJ6R1pKbkdJVTlUZmk0cm1zL2UveUduczZZVCtXQ3czc1gxQXlPZVc2Ymth?=
 =?utf-8?B?eVRnS0xDTnlKdlJKRGttNFhDZUNUbWRpMXlTVzY0cVN4SjNtemN0VEVsSkZM?=
 =?utf-8?B?TU80SHFpaGZ5QXNWc2J4N1dyd29wMDNsdTJkOGFDUVVWbTdVNHZ0akNwcysr?=
 =?utf-8?B?SUJ2K3V4ekpmMGMyd1BsalVoT0k2VEtKSmJ4RTc3VGM1eU9qR0dqQmt0Zlls?=
 =?utf-8?B?K3EwVmNoWXd6THFlMHVrRTNyYTVHRmxpMEYxcWt0VjE1WjJQUVJlK0ltSWNJ?=
 =?utf-8?B?NmlLM0MzTVRlenhNWCtHbmpKdDNZdGtKZkljSmpEeFJCQUk3bFRPWVF2UTlo?=
 =?utf-8?B?N2tLaHJ4L1F0cmJHK2dLZnVUN2NkOUhDaWNtQlk4SHlkVk1DVWRkZHNSMVBi?=
 =?utf-8?B?L2ZnZkI0SFdlZWYvelVBdndmSjJhODRrYlRnbUlJSExMZDZZdUZSa01lbkJx?=
 =?utf-8?B?SjBKdEVIbmNRQmR1eitCTHhESllheTB2ay90ek9mMEIvZThkQ1RzK3pzRFlo?=
 =?utf-8?B?VzhHMTRjZnlrOXN0dHJ5NmpmV0tvT2VXWUhXQUQ4VWd2ZmJDSUlBZXhicG9X?=
 =?utf-8?B?L05iK1ZYYUd3R0R6Uk9LT3gyL3dpVHpWYVlJQlEzRE1mRDBJZGp1RjFDWWhI?=
 =?utf-8?B?dUhBcFVKRUc0UTF5L3pNajJXVXhYSmxpMkVwVHhoUWwwN081b1hvdlJIRU1k?=
 =?utf-8?B?czlBQ0NVclRsT1p3enBhL0ZuRFZHR1cwVmRGUUJkalZBU09oMWFjR01UZFEy?=
 =?utf-8?B?RzJGUmVKWS9EMWNVK0U4b1BzKzZYS3h3NURkMy92WEl1Wk9kSHFGZHVMRFVW?=
 =?utf-8?B?Sk5hck5KaUZSVThNS1Z4WmtmK1lmRVRPSnNST3c5Z256RS8rMFdsbHJRZUhQ?=
 =?utf-8?B?RmN1bUdMMXZ5YW94aU04eC8zWmZMbUZPOTR0Y05pUGRyZGFkazlCWXZqUWp5?=
 =?utf-8?B?WkVwVkxYeU5aUGc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7800d9-9541-4d18-01c8-08db5726cc75
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 22:33:55.6612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OclJnGAwPI+jkIE2Fjj0U3UqbjBQpzKs3QgUyMm62FYMQcmm1squqa/Nv4Npfct6o+p8Ga5pf44AUxV8aq25uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=871
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170185
X-Proofpoint-GUID: ftLBhpKtAgoPRAB6ksLfz7XzyBh2_h19
X-Proofpoint-ORIG-GUID: ftLBhpKtAgoPRAB6ksLfz7XzyBh2_h19
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 12:32, David Hildenbrand wrote:
> On 17.05.23 18:15, Khalid Aziz wrote:
>> Pages pinned in memory through extra refcounts can not be migrated.
>> Currently as isolate_migratepages_block() scans pages for
>> compaction, it skips any pinned anonymous pages. All non-migratable
>> pages should be skipped and not just the anonymous pinned pages.
>> This patch adds a check for extra refcounts on a page to determine
>> if the page can be migrated.  This was seen as a real issue on a
>> customer workload where a large number of pages were pinned by vfio
>> on the host and any attempts to allocate hugepages resulted in
>> significant amount of cpu time spent in either direct compaction or
>> in kcompactd scanning vfio pinned pages over and over again that can
>> not be migrated.
> 
> How will this change affect alloc_contig_range(), such as used for CMA allocations or virtio-mem? alloc_contig_range() 
> ends up calling isolate_migratepages_range() -> isolate_migratepages_block().
> 
> We don't want to fail early in case there is a short-term pin that might go away any moment after we isolated ... that 
> will make the situation worse for these use cases, especially if MIGRATE_CMA or ZONE_MOVABLE is involved.
> 

You are right that transitory conditions can be problematic. Wouldn't that apply to anonymous pages as well and we do 
skip pinned anonymous pages today? A retry would be the right way to handle transitory conditions I think. At the same 
time, by not scanning long term pinned non-anonymous pages repeatedly, alloc_contig_range() would be helped as well, right?

Nevertheless, we certainly do not want a change that makes overall system behavior worse. Do you see system behavior 
getting worse, or would the retry in cma_alloc() be sufficient to deal with transitory pins?

Thanks,
Khalid
