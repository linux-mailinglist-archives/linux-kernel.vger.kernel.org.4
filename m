Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15DC6C101E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjCTLDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjCTLDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:03:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA712CC45;
        Mon, 20 Mar 2023 03:58:54 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K97Xwx019443;
        Mon, 20 Mar 2023 10:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=IaGAowpd/GJCHzZWTLIPwGMSuuveredDQMGwrgjZYSY=;
 b=0JGZhZM3qRU5oqstTPo9WTZSAT4UG/AGh3gkm4WEeU0/AZU8E6htv0MrXqrGc0FvZ6y6
 CIZuTv2l+FFdOcZk94t8JCWYFuqXOac8xW527OQgbvcpaViZvgTR67uCUkU2dVUkolZe
 2S9qPtKLP9RsUKx5K6GJLLXyQggmxsNtvivVMKfgMY70UvzHTjK4wIT/s06fUiw2A8w2
 4kmfClljhufMKsHZLaJIfXzqlANs4zif/vycGA6r+xvjFeNIZJSedraxON+S76Bm/jRX
 /0CqJlD5CALvG8iRwrwwZOKTb1WD2KsHHkooz/moZymtYSa5WIdJXhQg6hSxCXSRZ38E Pg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd433k5sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 10:58:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32KAbCig030734;
        Mon, 20 Mar 2023 10:58:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3peg5n4cqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 10:58:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2zdYsALXte9sElqyribB+mNgtEV+/EQY+EaZ9QxAjPKO9rLEertguzkz9G9peCwzti+UZGCsh00nJPJJcB1xt2B6Mg/exMEUXVtqINZDEFuka55y0UOdJchKIu+XbrxyIuTGNoBcrjD1JJTsb6iFtViJjC+4itke8XySDNu5yX0o80eW/UnjVywQfeKUhHBHIYynvvW7yUlkjMPuGn1Swwr90gFxZsBzSSv7Yw6h2YrsK91SOg2XMPGZ6VEOdxPbO1/mZz65svNCuwDa5JKBvB8o9/E4CS1D9wX9GFTzAPrDUT340a1FjXYrQTF1NmhAXgmYIOoS5laLFgPHR7loA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaGAowpd/GJCHzZWTLIPwGMSuuveredDQMGwrgjZYSY=;
 b=eru5MYRiEOkH6gOWGK19UGaY0Q3yRTvAR366cOkVnPe0TtifWaP17xmMIL2IxylJ2xV1bMkZzYcQCjU26Qqo4E7KvQpINf/d6Flw2ukIJReVm0osejIE4oOrSs42KG4a22gd4DkWxB8n9q6CPMa3HXfeY5Dy74x3WdXNRUKRZlka29TgFjBGwF+7bUBpRZ2lUqQhaiSoBpD18IIAaB4YECbSokBBBRXHousvEj3dEEmtPDEq/JSVAT6R/cf+XJM4XgrgX2QhuvAerN269Bvdk4CHf7eUWCHpnKox+j2lsyQjI8AePNOZYcAoyZq+S2XXTDF4Nprf0ww/N3/b/QoPWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaGAowpd/GJCHzZWTLIPwGMSuuveredDQMGwrgjZYSY=;
 b=KH5yUAHfx8i9uB5p4d+C3g9HNOpWYShVz6EaWqJxBl07tlYQCp0dofQb+jg2YU3X5XrjwHncb6YeYEsV9hOH0Sp3PwIU2Cdquz1r4YaYZ2hyKcm/TQ+D+jqMN7yYA50jWiyPb5k/h8yomp3p5urOClhHzhifdUEWoQCYJSEml5Y=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SJ2PR10MB7057.namprd10.prod.outlook.com (2603:10b6:a03:4c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 20 Mar
 2023 10:58:18 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 10:58:14 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Subject: Re: [PATCH 05/17] drivers: bus: simple-pm-bus: remove
 MODULE_LICENSE in non-modules
References: <20230302211759.30135-1-nick.alcock@oracle.com>
        <20230302211759.30135-6-nick.alcock@oracle.com>
        <CAMuHMdU2pCbOngWpeQOFYOmyLgSyMD-GCzsU4fQoafAvZchX1w@mail.gmail.com>
Emacs:  it's all fun and games, until somebody tries to edit a file.
Date:   Mon, 20 Mar 2023 10:58:14 +0000
In-Reply-To: <CAMuHMdU2pCbOngWpeQOFYOmyLgSyMD-GCzsU4fQoafAvZchX1w@mail.gmail.com>
        (Geert Uytterhoeven's message of "Fri, 3 Mar 2023 08:52:30 +0100")
Message-ID: <87mt47u1tl.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::17) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SJ2PR10MB7057:EE_
X-MS-Office365-Filtering-Correlation-Id: f4aadaba-c33b-49ee-4c0b-08db293200db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /7Y/AS76J2L7RYhuD2zH/8lzcBcRiL4mHxFim7eJV8Oe9XKGVB7qZnkgPq2zpm4W484EXIvXY5CbVc9Q6Kd29a0uvBuG3uat8/vYU8XI054ejBNV0/a+ANuWP+ym8C88wF5CWsvfHNDfplFHjgK1PUI7JEsGWZJkYLLtY3knYp5ukWjUDjTaszXy9Q1h65i/qnkolXbRUhH6R68NjIq4aiGo8oO+NqPLW3WLMkO5Zrv0L/F7C4+i/SdqY07oeWITYlyZo/znLWYVkBUhTizqdXS17C7xbE7+0US8iAy9Ux/ey3MUlFfIxlj9H7qS313sB8ct+iWWZ0oFz3fb76z7ylWd7vL8F5CYnXGOK3XbIKW8KQEjADVj6K94I0nLbd5fpw8kI7ims7JGK1Ol91qYY9twPB9XqfTdNrtC5V8wAPVsitBdlZPC+jkM4dkhvicHhEtIPJWzPmpyQjSqFk13nNfyU9cgnRwR1+rtr67ACLEgX/fshb6JeniHcMO8Wfqh6HSusBSPsdH1fBjMVsPDjXPnGl42bJgu+PKMKduhaRlKcLOV0O3jiR6HRmTBv4JUjVoKF/v1EqWhkVRvVvjfyhHWSLy8wt31Gu67UVPp8y61L0st+ozr69j8JG0ICD5efbRkKqaufkEHmb2JE25LEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199018)(4326008)(8676002)(6916009)(41300700001)(36756003)(86362001)(66476007)(66556008)(44832011)(66946007)(5660300002)(8936002)(38100700002)(6506007)(186003)(6486002)(6512007)(2906002)(478600001)(316002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?msot3oQDzwiRjQtaiG231rkuJ+hQWEXyRpZ1VEjE9z3rZ+dN8/78tOAP3R+L?=
 =?us-ascii?Q?xMQj/AbkR7eMW8jreP+nZ5uePUW5ot78q7fnvHDA91S0IBCAtcwDueCtj5Sv?=
 =?us-ascii?Q?XJrz5dl41fJ+8ahni/rCMMbX9QySKgd1lb1ZH3xLJla9mvt+LFzfRKARPzUr?=
 =?us-ascii?Q?CZTVWSgNamSf1Z5+5si1uqRiXIiwHj/hCYaMNCXPa+uYSJ/TX5uspyOW6UNl?=
 =?us-ascii?Q?F8wWXveThIXaE0KKQmfZ/VnBGlAePOLjDLg14KAL05eABqcG8TzcZyJ0Jc5A?=
 =?us-ascii?Q?//e/Q2mIu/udlwleNDv0KOP38g1iAzDIw2HK9Mq/Lj3OUb4OuZmzrSGKJMcM?=
 =?us-ascii?Q?v22HM5FYHVBANybPUpW77Rr4WmMM8y4hrAKri0C43WJouPRtIQITWab3UEOY?=
 =?us-ascii?Q?oPuhYRlEigRqyrC9xXQXQqKMQGZ0UXDI0JBrOt1cDz0l21BpXaTDcIwjkcSZ?=
 =?us-ascii?Q?J3pI1HX/4RlQyWfAA6vXfzfSSwAv3mvCA3vo43N8W3LvSNnv9s6EEZDhuI5z?=
 =?us-ascii?Q?ATiniG8+24D2m6oN4HXKtdoC1SdkneIQHxnB8YYfySZXGLeXP9yv1IPcETn1?=
 =?us-ascii?Q?+pRSJ5vAZh1k6s2AwSt/RVcXG8gl8QV1E8iS01oPWQHTHx6BMz7yJf5GdWMZ?=
 =?us-ascii?Q?+UzUmcBVJmY9HGk1HyJ0LVR/yIbfZsEkt+V43M4GydNfxMsOKiUzlKZEJUrG?=
 =?us-ascii?Q?ldFDhHYyG6rL/12b761Oo3EE04anaUXIPDSta5jxaya70rlzxAJBLmBCs84S?=
 =?us-ascii?Q?Pr8k6IaXDoKikpMFZX4JZGJlQ/PbZAy3wbbC5a5dQgcjbddqEfpXHRlRlIVA?=
 =?us-ascii?Q?JtcEbKJrt98OoHAmegX9UQXMkvqwqMX4m+f8tq/eyRTmpLflgCBK4mKgSWHH?=
 =?us-ascii?Q?9lQjGdYXbAhTKNZFXo5LWWyxaXCT8/grkWtSHEXsDOdTUBYYJvNC6Zo5Jn3w?=
 =?us-ascii?Q?sX97MIf5uuKJ5FCcXW8JBpc4iGGjKja+f3leriwGf2iqDH8G69vGUYoI3QXt?=
 =?us-ascii?Q?/6AneRn2/RmJ8K6jE2UuILmsNfnu0SOa/sxEsRzyycralQ0leKo6Sj1DGHXJ?=
 =?us-ascii?Q?4t7t7tkjMSMpn4vOunLjGK7uj3/VdgCwbkjOERysYVJ/F53ZVIAdRKuH6Iwg?=
 =?us-ascii?Q?pubwoeIWsUhDneGMHjvj3RKj7z2vGbyFcxfMzfxrH3eAl05rBv46GZAOdnNJ?=
 =?us-ascii?Q?f9c9pLFUcETLP8DtKjuxEtoFadPAVmVLCupa/A4sJeThTumx/Nx9Ol454wt+?=
 =?us-ascii?Q?p6LJWHWaVjUFlLs2MlWWkXuiWxXazDGpd206vsqdxu4i/e7BQl80PnYukM7v?=
 =?us-ascii?Q?a+pHfk7vSBxluV31uXipqGZdUDIO+kxlq/+rYBYfdZma3QwnKY2HM9wzj3em?=
 =?us-ascii?Q?bdHBMcQ0d4Yb5Nem9LxEBK1aMpUY5vMzR895cS0v2cwotkWIUGuLvApPMtnw?=
 =?us-ascii?Q?eKIR1Y+lB+DjgULS3ymgJdPhwCda1zSqouDONQbFU9nK8+tgQAVPrYeacrPK?=
 =?us-ascii?Q?Ujv2HBmX4zC3Zezbde70ZGGXICWh36xttc2EiDPQhjTn91Nm7dQ15rcyW15/?=
 =?us-ascii?Q?GzEskLllIBhoa9jKDa0VkfC49EPpdjjx/uPt+3xR5bxY8TAa6jDdHhQ6xp3V?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: H9LRbUnojjOjxsyR+GZQ8ivqgnS29pArsQ/DkWiHXeQZIaZOyy+gmrVJfYpSv8Sye8S1xXT8c1TWyqEOQ2OfrS6RlJWgzkUUjNUi2B0sru7g2q+kDThAw00GTzhZ4T45T1UM+NkUd4cdzv/lcnicqKRE86pHHdA/JqF3hZ490Wo/0NzGgzMq6HGO/zqNedMfJcmPjVT84ljE6DZ5ldH1bY4cViJRwB3pBsRKGTiLKZ2cU+HGQaxhDUUQ0N0SyW+ugdvnP9zlVsb59C502TAGFF7nLiW7ZuauimPqH2G1QRsyfc8nWhJe09qsvGzUA7UBiWG9Ocls4wGOHyAXTWrSbnize11bRdahi/q7U67n1OFOTuwRmrySf1FT7Qrd5HiOhwHHLF6QrzBpQrR2QDQdeE9JRGZgavs5HKgn8hoWX0LtZIXs6Pyt1ZF9ggjsm6qZRMeq+x0Cmq2B2XTJZNyl2Bcy+FGvD2ZfTMQ6iggK9QwJP+ySrxrBurIB1h07NLJogpQ6sfsuqKNNOD63At7vtGl1AwnD8nzQmI2yqb2RAfwdgfKFxDoPfTdNqLvoSmZv2CROZSB85kWllZ1ZNOHSPvQ/6TGEaqnOTixk3KK6mYTcjYiVV/KQk1Yo5SJZA85v3jVD8uaED7p6FrAfKUEdg10vPAiQGBuf1ntfaPvZPzWsmUm34Kxk7QQ1x6fxajg7qzqv2XLuq5vHrchkF8/h/xcmy7KDYB1TmKxwCrBfYpInmSXed56wwTqOHGSrkA4dc7s3HP+YKVaP99jG94CtGYrkBOVeTXMNum/QrrUS4YZMr5JY9wbWqe0FnQiP59LzRuhk8VipS0Ql/so1Own8a8Zk/17H8KAvP7LsmI6h/T8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4aadaba-c33b-49ee-4c0b-08db293200db
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 10:58:14.3782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jua7PtwihjkHKxX/60pAbOH9/wrBZIhCG/eiXRXxMbiN+yZxJoRP2ZGxiw6Ty40ejLJJVaf0rZ5iFxYEULzIWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7057
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_07,2023-03-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200093
X-Proofpoint-ORIG-GUID: 7MlaBszDUh-Efsmrwg4cjx-7qJENbiyl
X-Proofpoint-GUID: 7MlaBszDUh-Efsmrwg4cjx-7qJENbiyl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Mar 2023, Geert Uytterhoeven told this:

>> --- a/drivers/bus/simple-pm-bus.c
>> +++ b/drivers/bus/simple-pm-bus.c
>> @@ -92,4 +92,3 @@ module_platform_driver(simple_pm_bus_driver);
>>
>>  MODULE_DESCRIPTION("Simple Power-Managed Bus Driver");
>>  MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas@glider.be>");
>> -MODULE_LICENSE("GPL v2");
>
> Please do not remove this line as long as the file has no SPDX-License
> tag.

OK, in the next (final?) round this patch will have what I think is the
right SPDX:

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index 7afe1947e1c08..4da77ca7b75aa 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Simple Power-Managed Bus Driver
  *
@@ -138,4 +139,3 @@ module_platform_driver(simple_pm_bus_driver);
 
 MODULE_DESCRIPTION("Simple Power-Managed Bus Driver");
 MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas@glider.be>");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303
