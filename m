Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1C6712FE8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 00:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjEZWU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 18:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjEZWU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 18:20:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7B51BB;
        Fri, 26 May 2023 15:20:29 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QLUcw5020895;
        Fri, 26 May 2023 22:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nIJV36erl/r1cayY6TacgBGJXWhSE1j0NP5yFwXIWKo=;
 b=JCn5FG+hwUQGduIhVvTPvtVIOlwW97Wa1PSsUclDhR1KZsxA73aIBJRTjaabLpcJxk6c
 ryy0TB+qKRbVl4u54X1N3bznRbq0UieyhyWOnCSSVjlySVBYJIGKUeHjlmUJxDJyLPBd
 ZoJbL57OqIZFbOx4QUMb8vbgYj/KdsZQuFeRQt53L5aNRb5jj1HQUyv9XKAsiLc3rctw
 15Av0oDvNIkKykTjIBdqZAtViFGyDUeCYKilVHActtah15mJSddzEIx2G7atshnu7d85
 Knrqsl0enxzSXH1ETffadmK17+rIiKctEhsguwvTUmQ1RgQSj63GxtFpWKbyPk56axbp Ew== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qu4qqr1ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 May 2023 22:20:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34QKC31H028615;
        Fri, 26 May 2023 22:20:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2vqb1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 May 2023 22:20:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ok+E8shoQc4Y4Uhz5+tU/JEFnaKGC/G1KpQ+k1FJeneyFugNHgFh7tftmIKOYztBgRl2V2nYlG8evMTJhXYWec2lx9VmlgyWsb7uvLGmU2GiVlxEoUxhGuzZw5sELvRbx9sdoCMThhkm65yS950QV5dEP7yC9pLrHe12cWzt4E+KnIoIIBnhL/eZrdZhY407OxlCxnxVJmgvj70q9UNegQhrgxImdSJU669Fx34LajdUQmMxTFUre+kGxJ8Wh9ZipfshC83yZgD6/GaOdQTjaSNI5WmknlwMZ2k3zwDzPtKRV97PBd65c0wxIRFF7YH07EREAoHl+M8tKFIGUz57ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIJV36erl/r1cayY6TacgBGJXWhSE1j0NP5yFwXIWKo=;
 b=gsq/2bVfIksIX+Ld5e1E2pHhDxfgNsUBhQ3FRHnYZC5el90lUODB36t4l/Ya2wBP4IxUHcRO1UxQT9BduFDVSMAmhwHN0vjzlEv7K45YtgT2w2bz45QaRiVmjj2RqUkOLq9gJ/k8AhRM+7JzPY4GdMCmkAplg9i3xmRwHuD2eJct9vDtFVtZayDbDe+hYyLd/ubML1sXV0X+3RQONiYCRRCIbKLSz0kConVtH/f2u9/djKvl6jGh2Jjv3DF5hgRSpEZ0yPKapYRg4TSw1oJzdymh9UeZVW2SmPiDq3Vc2zuOO8UuFB8qgqXXiPfHJ8Ek3CtgY/iHa2vKAk/hI6BY+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIJV36erl/r1cayY6TacgBGJXWhSE1j0NP5yFwXIWKo=;
 b=0OWOvPsufYbQ2/NqKmCgoMxZrkJKuZxm0DVc3+TXhKaQqovbNFs3BHj6qffNGnQTWzX28UdB+cPEqcMFDPo4YLkhe/9lWxtxAqc9Qk1tKFs44U9ZD9ubYPaePnxrveotRneUebz97Hlm0LZoqY/DjyTt2GURLOjcyBMd78/7M1E=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by DM4PR10MB6207.namprd10.prod.outlook.com (2603:10b6:8:8c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.17; Fri, 26 May 2023 22:20:15 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4a9d:b42c:57c7:b53c]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4a9d:b42c:57c7:b53c%5]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 22:20:15 +0000
Message-ID: <84fb9021-8d36-4768-405f-8128987eb75e@oracle.com>
Date:   Fri, 26 May 2023 15:20:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH V4 2/2] blktrace: allow access trace file in lockdown mode
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-block@vger.kernel.org,
        nathanl@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        konrad.wilk@oracle.com, joe.jin@oracle.com
References: <20230420215331.88326-1-junxiao.bi@oracle.com>
 <20230420215331.88326-2-junxiao.bi@oracle.com>
 <05b3eebd-7a3f-13d5-1fe9-8f4ab3080521@oracle.com>
 <30ab7555-8f36-cfb7-9101-0ebb92af3c2f@kernel.dk>
 <6300a33a-9d3d-42a2-d332-81e02d52d310@oracle.com>
 <CAHC9VhT2uCc5ePi+ung+rLaDiLCCCF=fjq8G+D3FJf0i4E8_hQ@mail.gmail.com>
 <f016d747-c01a-c46e-59a7-13d0d6306827@oracle.com>
 <CAHC9VhSCjuJZ122EqdDxzJTU1tGq5nU_3+11WGKZ-WHjzU2FBw@mail.gmail.com>
 <afeb0ced-e4e9-6039-893e-b50268c1c148@oracle.com>
 <58172674-2e0e-1bbd-aff1-881c2096c5bb@oracle.com>
 <CAHC9VhQu5h6zfn8E5HKG3Krs-HfCXx5TJxTw_oRwr5HrNH1kiA@mail.gmail.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
In-Reply-To: <CAHC9VhQu5h6zfn8E5HKG3Krs-HfCXx5TJxTw_oRwr5HrNH1kiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0036.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::49) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|DM4PR10MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c923e2d-bcbf-4c19-9038-08db5e376167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UlrzDLi58vC4U7UuWyzQigqvRTOF8BzQ50qB8AFGQ3wH2EmEbzX2bIzo2m7XMVTPKkgA9TMVh6Ec9txIcw0fH3BYspkMAY4o09jPp3xYaDx9Cq5Fll0t4HgtqUTPCHMYaiaXPngBBT0wQlAp0LOTTfpXw+JEq1Iv0pLPJrGCux/+5LZV2YfxoXpXQYtlukWWAroBI4MLZ6xj1vT2fMj6jmm1UNKQnZHffLtRsuUOGMS/6FqtfIo3EpOR2broKctaz7K7reB2LfPRF5I3HMHfH9VpAwU80QHRBecjkD9YrWgt5+cr6YJvUm/nrbYs2OuOJBZ93NzQnucdvxXX1cm4YPEJK4cytC7cTv2Tb2o4CZkaZZG202YkBoDaTn9H+QE6TMztUg7Jiw8YkujIf48ONv1auKuDkB99dTng9Iz1HOOVD7G7fPGLynyjM2bwe27/753E3wnwcvaRCIQPCWRJq4FAKir0inz4J4xNjoHRp2Rd8A9qDQAcO+IrK7qmnsMP4sEpXo6nwFjlIxGQ+6fWEi2qVjZu/OJL8TCyeuyE78j2UHHMSuNd4lRX1sceha9pukw9j6aj3A/mwQIKDFkkJffS/21tuCn95NM0xy3tMjb60rz7MSTgAyw9Z2hULpCtkVG7r9nol60OXZF186xSHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(84040400005)(451199021)(36756003)(31696002)(86362001)(316002)(4326008)(6916009)(66946007)(66476007)(66556008)(478600001)(6666004)(8936002)(2906002)(6486002)(8676002)(44832011)(38100700002)(5660300002)(186003)(53546011)(107886003)(6512007)(26005)(6506007)(2616005)(83380400001)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzVnM0VkbTRsa2NCMXkxWlZrOVVjbG1tUTFwME9hQ3dzSE12Q1B4WnMrNERI?=
 =?utf-8?B?OE41UTQzcUhjQnZRSk42SnhEbmszWlBmaDl6djgwNzhFWTJFNmd3SlhmUWV3?=
 =?utf-8?B?Yjc4TmFmMjRCZjVtQStrNVZDT3l2VkRTTmRzTnBkWVdDOGF0MFZGOUpwTGhT?=
 =?utf-8?B?TEZ6cEcwRDU3ZlpBVGMydytKcTljVE43Um1mZzlGcFFTbDQ3WUJjYnE2Z1Bi?=
 =?utf-8?B?a3lRcUlTdUJFaGtYM1FacFR5UUo1NHdtQTBHcFNCakphejhrNU56Wit0VjJZ?=
 =?utf-8?B?L2NydXp4Q1RiWlJ6OFRVaGVBazRPSGhxYTNrU0dwK3FlYUpaaitHdEhheHNI?=
 =?utf-8?B?SFdKSkFGVW5UQlVSc3BJaFRXRElwNXc3V1k1K1RNYzJUa0Erc295OU1oN2lM?=
 =?utf-8?B?U2UzVGJEV2xQVlBDRXJ1cTFGSkF1ZmRhMDAwNGQxWExPRzh3bi9GUmdseUVi?=
 =?utf-8?B?elFRSDcxTkFYVEhlYW5CYXZVeDd1enE0M3pIelhxOVgxTDY2MC9qbHR6NEQ5?=
 =?utf-8?B?Rk9rTGJGTDNuQ015MUVpM3V2U3M0NVN0aHpZenZ6eUo5bjFjY1ZxelBqSnlD?=
 =?utf-8?B?N3dzaVRpZGZrNVFZZlNtc25vVGFtRFlJZXJNaE41MFhuSGlCdUoyM2JRSVZn?=
 =?utf-8?B?VXdPcVQ2QnBHUUNPbUtVRDVScTZHK2JFR3k2R2RPQnI2NVc4SDVzczBXMWdX?=
 =?utf-8?B?THlhYUkrQXlDdllrVW9nYVlRbFU3dHEzc1FmZG41YXdEcmFDS2xXYkg5T25q?=
 =?utf-8?B?bGRCM0kyZUV2N2kxbHhnQkxvalZpSlM0c2FlS1d6UFkzbnlFQWJCSDl6dU50?=
 =?utf-8?B?ck91Z1hUL3dXcWRaNXQvVmpzc3lQWU9aTFNCTXlrVk5YUGw3Y3hsenJST1Q2?=
 =?utf-8?B?STYyMkthbmppRGFkUG9BbzlIaFJ5cHJ3NFdPZWhmWjhCQkRla2JBMldodnJ1?=
 =?utf-8?B?YnRnNDZ0UWYxMzVZa09JL3JveW5mYjQxZllkN1NrbmRQcGtKTUpneXdLR2NF?=
 =?utf-8?B?a1U1TUJCK0RnaGlrYXVMNDdmU045NWRBRUhwbmtENVA2N0JkRHdabzlTSDRM?=
 =?utf-8?B?WEdOQ1owQlhkZjRRNnd2cU5FM1pySC9QNkxJSUFKRCt0ZFQ5TXpIVm1BSlFD?=
 =?utf-8?B?bExWbW5WSm1xLzNvTkVpREVhTENTTWVKZ3dOUldWVURMRVVHYnN5RW9jWjR4?=
 =?utf-8?B?Q2UzZ24xNVFkR0xvYytYNUl6UUFMTEsrRnpzdWRRR3g2V0hOazlYK3pUdUFi?=
 =?utf-8?B?ZTV4UHRDSEtyNVB6Zk1XM1ZxZ3Q0RWpiZ2xRTTdncUF3TDNNM0JFR2dZL2hH?=
 =?utf-8?B?dTBCZ2FsRkJyRVJUTTFMQlhOOFZ0RkRiZ1Z5R1dCNFNCM3dLTThoVDg1Z0Q3?=
 =?utf-8?B?TTRoZm4wRjNSNTlwRWczVGV2RmphWFVzcjRmdi9SMDhZMmVLMkNrY2VWbndE?=
 =?utf-8?B?emlid1ozUklqRm5jTFFTandlcHoyZ1N4V0d5cDVVcDA0b1JLYlFsZjU2UnVR?=
 =?utf-8?B?YVQ4bmlwMG83eVhqdEFYektNR2d2Z0xESlJ3K1hsVGk2RzQwa0I2NjI3bnRi?=
 =?utf-8?B?aHhiNW9lL0UxQmpndUlocDdmUWpZZ0NjZDhZNXpsRUVTcEdreDBtdHo5eXl2?=
 =?utf-8?B?VFVNVy9aQnAvcmlyYllqMnJaRHhTVk92bHFXYi93R0lQUkI5TGlVTk81VDFW?=
 =?utf-8?B?SWdzMnJwUlhXMjlXeVdrM25BNXRBZzR1NElLcHpPenZzZy9SSlBEWFJST0tj?=
 =?utf-8?B?cnZkekNEU3d2VXYxZjVFUU5MQjRYdllpMXZKNjkrbXhBQzQza0ZMc21MK0dC?=
 =?utf-8?B?OStQcE1iYldGZkZQSUdQRGlHb2dFMjNtak0xUWIzL2J3TGlVcVdLT2VnZTNu?=
 =?utf-8?B?Q0dXMm1XVlB3SkxWczFhVVZ4MXRha2NGZ043T2FLWXhidGF1Nm5KeGhWQkJi?=
 =?utf-8?B?ckNiVGpaWStMekRJNkdSTERKRlZiUEN1WWFlMktoR2ZKaGhkeTlyWXc5a1kw?=
 =?utf-8?B?cVhsa0tVTitsSFRPL1gwQU1UTGs2emsyUVdnc0s5ZjdRdDhXM1FWb0lWUVZj?=
 =?utf-8?B?eGlOZXcrRk5weFRtT2lVSVVGSUtaR0JpaURVTVY3M3JvVnB2T3ZxOWRUekY5?=
 =?utf-8?Q?w1qrkfqS6WZScZW2TMpRnJQ3l?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +gOGxmOAH2Bv+Md4vQoSNc2HxUGc/UhOrx57Y12fpjkk8HR5HxindBpKHlxGoBu6t/ckPQQ14D8zueD+QP5sMf5y4BWLYr9gxDLx2rBP+efZXHEj3TEnZAa9h72dnw2TZyT2eG/4099EgyVilKvH8Njq9BfgyN07tf6iubQVWofENi+32gUKW87VxUZRBY0G9TDS5i921xCGmDzfr3fjHn8+B2BLoJPMk5Ts3gT1Io5/zK6IVJxmvdETfankj16CFW7AavCanBiB/XW8TTB+iWeO82NibWUy46uLX6l59jPVriZxmSkTdE2TpeAKXV056Adz8dOXVPsu39FD8354FEeFIv/hxSkXAayn4M9ihf0K0VFtz0MR4HSkseMkWYiMSMKAGQF2mKYGF4mcK92ZOgZTM9AYC5QXPhjEIHlYlyVMUT/HZAXNJvtChT4R4fpKSgX2RF1FTVmg8wCyV+KBOIoPSGuNzWV9Cr1QkHkiOn1reRKClD+OSDiqzgducX+iRkO9k5fzHeDyvyG4o8eLLFsdobMlsFmY52XEIuaT24xwFNM0OTYkkpt1fQxkC+QYla81bRRbr+entxN+5YNKVUAK9/NaogwNQBiP23A5OBrvneyltt1rOTB5c8PTXW9OqIwXdnfPJz359w35GKPv+VPzkipp+Jxwkl9IMUYUG+VzGY1wBmwT/M+aGzHb0WQ/Hl5NM3dCBYODIWsbjsSf1d8M2s01kZ1hYkD0LDclprZIRyFHH7WebXdeCUGeYWi27xelFsF9UM1mQLvZ6Bcz+VRSUfgG8mxoRL0wyku8hv9eEa5EbwXxqAUMkrpUtPqDyYsZQNqDC/0TILuqYAGUoHbjfKS5Khf5ZRzgtvKUaJvjdu7LK0JG/b1QoCjd9Lv2upmXDzp6rO2qayhF362/GBTeJR2RxKVW7lcfvJtk9hA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c923e2d-bcbf-4c19-9038-08db5e376167
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 22:20:15.5154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QtiYF0WGquRWLSpjhVSeG9fxsMq8n0VVVHuaKMmsQGhDyNb5q82SE6puW+ikDGtZJKhmVF3U0lbIJbhUkBs35w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6207
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_12,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305260192
X-Proofpoint-GUID: l2YTiVx0i-M4o-fBBg35mJr6Vp3-ab0d
X-Proofpoint-ORIG-GUID: l2YTiVx0i-M4o-fBBg35mJr6Vp3-ab0d
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/23 2:37 PM, Paul Moore wrote:

> On Fri, May 26, 2023 at 12:56 PM Junxiao Bi <junxiao.bi@oracle.com> wrote:
>> Hi Paul,
>>
>> The patches have not been merged yet, i would like to resend them, just
>> want to confirm i can add your Reviewed-by in the patches, right?
> Hi Junxiao,
>
> I haven't personally had the time to verify the blktrace claims that
> it doesn't violate the Lockdown principles so I'm not comfortable
> adding my reviewed-by tag at this point in time, I'm sorry.

No problem. With Jens confirmed blktrace only exposed IO metadata to 
userspace, if any more query regarding blktrace, please let me know. 
Thank you.

Thanks,

Junxiao.

>
>> On 5/9/23 9:13 AM, Junxiao Bi wrote:
>>> On 4/30/23 2:46 PM, Paul Moore wrote:
>>>
>>>> On Fri, Apr 28, 2023 at 6:41 PM Junxiao Bi <junxiao.bi@oracle.com>
>>>> wrote:
>>>>> On 4/28/23 2:26 PM, Paul Moore wrote:
>>>>>> On Wed, Apr 26, 2023 at 12:33 PM Junxiao Bi <junxiao.bi@oracle.com>
>>>>>> wrote:
>>>>>>> Paul,  do you have any other concerns regarding blktrace? As Jens
>>>>>>> mentioned, blktrace just exported IO metadata to Userspace, those
>>>>>>> were
>>>>>>> not security sensitive information.
>>>>>> I think this version of the patchset is much better, thanks for your
>>>>>> patience.  I don't have any further concerns, and since the lockdown
>>>>>> LSM doesn't have a dedicated maintainer I think you should be all set
>>>>>> from my perspective.
>>>>> Thanks a lot for the review.
>>>>>
>>>>>> Since there are no changes under security/, I'm assuming this will go
>>>>>> in via the tracing tree?
>>>>> Should I notify some specific maintainer or mail list for merging?
>>>> When in doubt, the scripts/get_maintainer.pl tool in the kernel
>>>> sources can be helpful.
>>>>
>>>> The results for the debugfs and relay files are fairly generic, but if
>>>> you look at the results for the blktrace.c file you get a more
>>>> reasonable list of maintainers and mailing lists.  I believe Jens has
>>>> already commented on your patches at least once, I don't recall if the
>>>> others have or not.  I see you've already CC'd the block mailing list,
>>>> so that might be enough.
>>>>
>>>> Keep in mind that we are in the middle of a merge window so it is very
>>>> possible this patch might not be merged in a working/next/etc. branch
>>>> until after the merge window closes (every maintainer is a little bit
>>>> different in this regard).
>>> I didn't see the patches in the trace tree yet, maybe better to merge
>>> it through block tree since it's a blktrace fix.
>>>
>>> Jens, can you help merge these two patches to your tree?
>>>
>>> Thanks,
>>>
>>> Junxiao.
