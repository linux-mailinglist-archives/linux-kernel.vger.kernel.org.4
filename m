Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB99714DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjE2QJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjE2QJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:09:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC99B2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 09:09:52 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34TDO5Wl001745;
        Mon, 29 May 2023 16:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=0pv/fjxIooOWmLwjgsXqP6JZWJG55wKkTCpgtaiwNuk=;
 b=ODceqRZzsCw7935w5+V8U03KD5YCulAzxRCUYSn+XdxSOcbMYaYgEo7vGP846tMogzyi
 xdX+PopoLVIsGvAifLT12k6lsYisASpI00EimEAPTVhrGedi1d2JJKc3i3LVZXwuTExQ
 A2QJlhPXdzQHv5zoWO8b1BbFjrYM75+WS7So9GnmtVWFj2356S+FdeHY7YxP9VILBV5t
 H+Fpez0qLeIUxNjwWJjGpnNVrsfTAYF4VCu6CF1MS/f7xrBGy8inJcWS3PUqlztuY0WP
 Hgb/DZ2OKLYDEYfwnUXNG+uUmEezz/HHuHghczvELF3eCqkfR+Wi2k0KnNPOod3APyTq fQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjkh4tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 May 2023 16:09:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34TDbKdg003685;
        Mon, 29 May 2023 16:09:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qv4yaaxbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 May 2023 16:09:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlJIrPlB29BZM0WAKgGhGm7wTwBqhxrta4HIP4xUtJaU3NeimIKN9y2GYuR8bJGTJ03TEfz4yVeimJCU7QQoHsc2RP3+8PxWHwU72J3YnKRje6MWM8u4RS15Hl7eyrRB1bkq/LYNJHo/FaTPrTrvoTLzcxJU1YTXj20JjcM3FMa0bL6/a7kvb3yHzXHcrKyJR8zdrdbeS94BBI/RpMAMhs/EHfnmmfTWcA7xGyUsBtEfwgk/M/qr5RGDArd9R5qvnjURusa3ds5BZDEoFqCmn/VW1JtH/ATecuMbRtIZVdHvfonQV+KD0QorhmcxJMc5lopHc0B4Me5++qYUV6is7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pv/fjxIooOWmLwjgsXqP6JZWJG55wKkTCpgtaiwNuk=;
 b=cI4/zirsVu0RJbMuSesTRBcDJv8+nTOyHWQC9CBMMEOMNP+Kna1T2EiHYTIrVZE4MTUxfMJJFV6CRHOQKj6TlggZK81VdfWCS8p/oWCEDfHYdasjJum9PrQ9/OKGTwjuRdaJQ2x22XolvFOZw/4ff7GME+XWqMwrFhkkLuZKNBd2u7fkHVTs7vNcuOUc6+Y6VZuYR3HMARV+SnQ8UHRKfR1JHmSCVMaBuAxSRtXt7BCgkl3ZderwIYuF4yI7jDu0h/jVwK+RcMvHNKd6UGvcF0Sw7SulfUPG/LgARJjU7JQXX2PKLi9qiNHNdlV3ecKVq06MEsRpXDikB3zP4XbAjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pv/fjxIooOWmLwjgsXqP6JZWJG55wKkTCpgtaiwNuk=;
 b=SLapl9XFASwfPCIWZRX78kdnp3ftacOfmc3OwKZb0/SJ5R4QNLeZNyHpwD6DX1QDSV0uiJA2HE3HPAQlebpHM7HspM2cYArwEBA2EAK60o2H/OwyCakepIYN6kiwmXydmkLMiX64SmJlCkXigAVexwS3frUzk3aPLGd2B48jj1Y=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 16:09:32 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 16:09:31 +0000
Message-ID: <022f4de6-9eae-0a94-0f55-b84be4982fc3@oracle.com>
Date:   Mon, 29 May 2023 11:09:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
To:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Content-Language: en-US
From:   michael.christie@oracle.com
In-Reply-To: <20230529111859.GA15193@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0036.namprd07.prod.outlook.com
 (2603:10b6:610:20::49) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CO1PR10MB4769:EE_
X-MS-Office365-Filtering-Correlation-Id: f04f335c-54ed-4fc0-6373-08db605f160e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fpZLppwaQu71KlzN3qcgeKbHKqSExZQtDz8JZEUHyPEQ8PywW7fvLHiKn+ou+FD6hLkelvew0KWfj403DPdU60gwGapuFJ2xnoKWGmcZ+lc21WmNGpAJm8t0tW0xfOi/ZzqjmhCGocZ/nNGBDyKhaa8bbqKA20ar2q1ziB+XUU9SL+BS8go02RrvC5tepzuOQL1LpPUt58mBUpImtDQ8y42qX3WxkiNhsdKC2RBy5S+ioSj2cNesenkcS4kZN9Zx3nYfWI9TblD2Er4L3GnVQgH7QZZr5EuRykbBRXvF1FvcQdTFcuwjENUBjXlJJdwLPFHLGunQ+xP79dtSscBPHshPzgLe4Go93N9sNF0BsqqCdsYAwPqXIvaH83MuaHdS5ZfSUs166CKv8pyVa6LL/jxlvRVU70UM0yLp68tYlU6bD/6mkeFt+mG/z/8GthEr0CbXrS7YdUtDqZE8FtN5sUNlJb59w/xVxkX+wFbjOySPUATbtmGs+LKm0h3l9+GLiiDW8OfF2QmvtJSe/eBZEUoIWK1tS8bdqggpW7zx6eaLGxkW3873g85zlRAAxsbGAuciOyBHk8Ve9hvZ+iZ6ouQX6GPxCxkvb/eR45aa2Zyk6BukYD/NI1e3fUFfLFAm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(53546011)(186003)(6506007)(6512007)(9686003)(26005)(41300700001)(38100700002)(2616005)(31686004)(83380400001)(6666004)(6486002)(110136005)(478600001)(66556008)(66946007)(66476007)(4326008)(316002)(7416002)(5660300002)(8676002)(2906002)(31696002)(86362001)(8936002)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm9xemRsTENKcWhXbEtYd25PSTZvQzN4L1c1VG1WWnl6L3RIMnhzc0N1VTha?=
 =?utf-8?B?Q3gwRURWdlZFRlhUL29EYVdEelhnVjVWOHRESWY2b0EzclVoMEV6NzhGcU1k?=
 =?utf-8?B?b3BmZUlTRnpJVGtpSEZqUWgzRGUyZzR4VzRpeWZKSGZIMEJLY2VvSXFQa3VJ?=
 =?utf-8?B?S1M1NGlKN0cwK25WcGQrYlFvYzVTQWY5THhrNUZJUTQrQ1dVSnZzWWpKM3E2?=
 =?utf-8?B?L3dVcThqWTM2ZFUwTEx3Y3Btck1COG1Gd21rSGFMRVpxQitGUjRjWEw5czdr?=
 =?utf-8?B?UmNPOHo5V09oWmMwdDllM0J3ZUtyRDJBNjNFWUh4c3FBVWltS1NrdGw5S3pT?=
 =?utf-8?B?cTRjbXJ3NXRYQ1Q5OHAxdHNaSXpHSzY0WE9sTGYxRU9JaWMrMlFYU1Z0Z3E0?=
 =?utf-8?B?bmk1K2lzdEFVVU5uelV3VXZUSTBJYXdHbXZGanUrZi8wMm94V0lvblczekVl?=
 =?utf-8?B?RGlXY00xL3gyVm9Xb1J5YXVNZWI0TDVIVWdZT2RmTUtJbUdKNU1hU3RmTDNB?=
 =?utf-8?B?c2E0TkZabFpSRTgzdDF1TWlvM0VVMjV3Wm1ReGhLMC84RUwrVThnWWYvelFs?=
 =?utf-8?B?STFKeVVZemRnRTliRFAyYmpNcjVmVXFNSEJaeEVScFUxakhtRXA5bFVBQmI2?=
 =?utf-8?B?TGNVcEdPeTZwQjNPYUJxSlNmNUQ1SUFKRDBwVHdPWStmVU4xKzA5NjNxVGJQ?=
 =?utf-8?B?OU1ibkhVTk1zRjlrcHZZeHhqMG52ZjQzUmxJaHdyc2FkR21zYmJSSXc5K2ZH?=
 =?utf-8?B?cllodHU2UDJ4WnR3VkFMOG5NdEJuUnQ2R2crejlhYTg4dXJpUzZSVmlKclRT?=
 =?utf-8?B?MUFlWTRpUDhSZm8waS9HTjVCZW1wdlg3NEtOcUl4MUVjMGlWWGhlbDNJSDU3?=
 =?utf-8?B?d1JYZVpaNDJTcGVqNWx4T3RzUVAxWnRqOFR0empFazN1KzQ2T2trTXV1cDhW?=
 =?utf-8?B?UUZpeWRXYVpjY2E1TmtpeVVGb1BYbjdXaDRpdkRjR1pRTU5uVVFuY21VRkdl?=
 =?utf-8?B?eXpPa2FyQ3hKcWJlUWtYZThUUGFOZGJ1YzZORGhDOGF4YVhPZElZUVlOdVFC?=
 =?utf-8?B?TllZeEJ2cllacVlUTXFUVUExZk1NMDl2aXk5cE9WcTluNThlM2NTZ3N6RUNo?=
 =?utf-8?B?a1FGTWw3Z3pkMktHRXg2dkxIWVl0ZW9PTlVPTFAwcVd3a0lFWUJlRXVBZEg4?=
 =?utf-8?B?Vzk5K3RnbGloN2tnOWV5aWVVTkpNdS94eE9ZZnI5Z1QvaWl0VEt6b1Z6Ny9K?=
 =?utf-8?B?ZEZQR1lOK0RUV0Z4T1pFREJGVmVRK2NlU0VMOHRVaWpZVmFqQmh5QWpWdldp?=
 =?utf-8?B?aUpWTGo3MEg1VjlYNTlKdTlweVUvSWpCYVFleXRtYnJDejcwb3RsZ3lrMEJL?=
 =?utf-8?B?cng0TStlZzBaaktNbWlIc0ZYU0hLTXVvc0JrelZTcXZ3VGg4cEhpcGVSdW9o?=
 =?utf-8?B?Nm9SZ2lQaGE2eTBKMWIrZllxUlN3NFlPWjdVRjdGUVhkaWk1WW1OUlpQTm92?=
 =?utf-8?B?ck5TcjVtcDRoclp5bjZXY2V3OS9HL2t3Q2w0aVNpK2U4dGpRSzl2MTI4NXJW?=
 =?utf-8?B?aGYwZWQ3ZXZ2OTV2WlkxUlVkRjB1b2lIK004M0MxR2dDdlh6eTEvMyt1RERw?=
 =?utf-8?B?V3JzaUlUcm9yczVXT0ZPTGkzMC9QYU5sYnpNVzVhdk1pOHVVTmdnV2RJOU12?=
 =?utf-8?B?NE5sWTF5VVlERGJqeEYzd1pxdHI5aHpoNWdseGUvVHBtUkRBS25GRGo4WUxI?=
 =?utf-8?B?MXBpcGFsOU02Z2VIR3dpTkxSOEM1QXZFU25LaXFzQWtmMDEzTU9jWlhETm5y?=
 =?utf-8?B?YktQdlZxUTNZLzArMytxWkl1enlCQWZ1YktrZHczeXF0c2xUbStmWHBRMmdq?=
 =?utf-8?B?VGRuMmRBbm83T2xRSDVJSC9OeXRyUmlpeTcxbC9Qb2pseFpkOGRiTVgydlcx?=
 =?utf-8?B?K2RqVzRmS09tWU9XREtPcGtVUndLRTlUWFluM3lKR3VyQjZOMUNtSm5tZnVh?=
 =?utf-8?B?T3ZOMU9JRzRVWExYVnkwbjNuT2hXV1g0SjlRMmlJR0RXUEFpWmo0WTA2VU02?=
 =?utf-8?B?Q2NuZXFxNm5Zd2F3N1lCNHFXc1puNC9VbUhYTWsvVVprOWhFS1dxekZFYmIx?=
 =?utf-8?B?amVoK3VCNTNIS1JOa2hNMUw5czZNVHE3ZmtHUFJobFhFSFJ5SzNqaHNBcHpp?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Y1BwK29SNnBxUjdPZldtYTFranRtZE9kT0NXZmtsUENZNkgwREU4VXJYQno3?=
 =?utf-8?B?bElVQkhKT0grUVE4SzVqRWVGTlRCUkZnSmNZVlAwaWpLOVpEV2s3NndIRFEw?=
 =?utf-8?B?K1dzRE5obi9mcDU0eWV2S3V6eXZabzBJbFVscmpqTTdXVVBwYjhUdTVYTWVw?=
 =?utf-8?B?M0VoaEtpVGFkdVNYbVpYRTV2bVRoMGZibE9VRXV1eGxvUTUwQ1UrS20yLytu?=
 =?utf-8?B?ZnVNMWxxcUZ5UWREejJLeitobnJwcDdrMkpseW02SXZ6bVVlb280djBLQm5a?=
 =?utf-8?B?UXd4YWEySzF3V3BQTVZ0YW9hZXNVSjBuRDZPY3B3ck1NM3ZJY04rQU5oUWcw?=
 =?utf-8?B?cWl6djcyVUVBTGY0VnR6d1Q1YU5nMHk2S2hmYmtwZVRpelBDSkZRd3JXUmw4?=
 =?utf-8?B?Zzh4T2V0M0VkbEl2dHJnWUpSbG1kUWxvU3JpQmtwTHAwaG1ac2FSZTBpbkN2?=
 =?utf-8?B?M2NyaURMeUhaQkFFUExpSnR6YVhtZVhFVE9od3FFekZKNWFZRlduLy84azFO?=
 =?utf-8?B?TVNNMVg3Z3oxTXl3Ty9rRThWcWk2ZERuTXpYcEh0K0oydlgveUxIM2NEMWw1?=
 =?utf-8?B?dzdZekNrZWQ4cWNoVXpZWTFiemdyRmQ2OWZMK0lIWkd5WVVvUjVabXBHNC96?=
 =?utf-8?B?QVYwQ0VXNlNPd0hxa1VIVlN1WHN1bWFhaGpmd0wzYlV2V0JDaGttMW1oUm4z?=
 =?utf-8?B?eEhHSjhnOXh5SzFMWlAvdW0wS0pxT0VzcWpRNUVjTncyK3EyWjI0a1hUSHpU?=
 =?utf-8?B?VUIzTU9JM0lNYU9ZVzFXM3JmVmRBeTJacGgxdnY4Mm10TGQyR3BBVTFtOUlD?=
 =?utf-8?B?eGR0QWtBTnVDcmZyTCtBTzUrSzZKMEZqL1dGRXpHM3Rvb3Z5ZlBKWDRRbER0?=
 =?utf-8?B?WFdBTGF3OHBNRSs0UlVkUnp0dU5LcUNGY2pVeWtTSjhaMmx3WkVoZWJoa0tw?=
 =?utf-8?B?YTFNNXVYVllXdys5S2lrV1puamNxMFRxY1VyUlk5N1FENU9pQXBIaWZ2NS9j?=
 =?utf-8?B?N1l1ZXJUemp3eU1UaE9LNmcrbmNnU1Y5WG5XSHd1T0JDWXh0dVVWSEgweWRE?=
 =?utf-8?B?eHgyUGFaTThxV2twQ09LTW5Vd2FqSzhieXd6SDk4VWs1SlpnMXZlZ01raXdj?=
 =?utf-8?B?ZlhnOTFsZ21DR29PLzRnMkVrUFpjbEt2bDd2MkZPdXhiSmJQb2V2Tmxibk9u?=
 =?utf-8?B?VElscnZkelZlQWY4cUd0K0thNGJaK1dzaXNOalNKUEEzZTVaWHdhLzNZVVZN?=
 =?utf-8?B?ajhHOEt4OGVJYUN1SDZ4QXhKQTlFYWo2azk3dTYvSzIrTVJhdWFRMGdhVXgy?=
 =?utf-8?B?SHdBTUlYeWZZb2s2NVYwK3hHQWpITFhQbWVrWEV2TUFzbExwNFhqK1dNelVm?=
 =?utf-8?B?MTYzVVFMdS85OEhoajMxRVArTzVGNE1TU0hoYSswdlZzTGRPMHJodlNiMjUz?=
 =?utf-8?Q?eC6tu5qX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f04f335c-54ed-4fc0-6373-08db605f160e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 16:09:31.3299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0NMNqWAq3CnQ+3ZX8+BuomgD82bWJycd9aeUcMjokNJBrw431kKj33oNQln29YoZIora6zoiirPgBXMS6+njiMrGu6386HiNY7Ua3MRxP8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_10,2023-05-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305290135
X-Proofpoint-ORIG-GUID: xEkKuhDx3HvoKjRwJmnQFGIIZXIXmfzO
X-Proofpoint-GUID: xEkKuhDx3HvoKjRwJmnQFGIIZXIXmfzO
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/23 6:19 AM, Oleg Nesterov wrote:
> On 05/27, Eric W. Biederman wrote:
>>
>> Looking forward I don't see not asking the worker threads to stop
>> for the coredump right now causing any problems in the future.
>> So I think we can use this to resolve the coredump issue I spotted.
> 
> But we have almost the same problem with exec.
> 
> Execing thread will wait for vhost_worker() while vhost_worker will wait for
> .release -> vhost_task_stop().

For this type of case, what is the goal or correct behavior in the end?

When get_signal returns true we can code things like you mention below and
clean up the task_struct. However, we now have a non-functioning vhost device
open and just sitting around taking up memory and it can't do any IO.

For this type of case, do we expect just not to crash/hang, or was this new
exec'd thread suppose to be able to use the vhost device?

I would normally say it probably wants to use the vhost device still. However,
I don't think this comes up so just not hanging might be ok. Before 6.4-rc1,
we ignored signals so it would have worked if we are concerned about a possible
regression if this was a common thing.



> 
> And even O_CLOEXEC won't help, do_close_on_exec() is called after de_thread().
> 
> Or suppose that vhost_worker's sub-thread forks a child with CLONE_FILES...

You mean the vhost_task's task/thread doing a function that does a copy_process
right? That type of thing is not needed. I can add a check in vhost_task_create
for this so new code doesn't try to do it. I don't think it will come up that some
code vhost is using will call kernel_thread/copy_process directly since those
calls are so rare and the functions are not exported to modules.


> 
> If we want CLONE_THREAD, I think vhost_worker() should exit after get_signal()
> returns SIGKILL. Perhaps it should "disable" vhost_work_queue() somehow and
> flush the pending works on ->work_list before exit, I dunno. But imo it should
> not wait for the final fput().
> 
> Oleg.
> 

