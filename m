Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4B45BECBE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiITSZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiITSZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:25:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82B43ECDB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:25:33 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KGJTli021207;
        Tue, 20 Sep 2022 18:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wKJyZ9UEO7JuUZitz+MUCM0pHiXacZqeLtfNryJbqWw=;
 b=GlnDQUr9hPKEmAYoyUislXTytZtlAwBtqU1spxYTX6hupuTZhMNHGN9rEBk+1sOU0dui
 c3L8LO9ocd7Dsd9ASAVbasWLb1s07/YU8RjTeyrHY6HgcqXnl3vK5uWkl05LzSBjlgLD
 KvyrBwpalCqhcqPVOZ9EY2TsCUE0Bigz1jsyNenj3ebr5mc5qBYPkvRjD+6TnsoGIw+t
 WjeVbH7EDLGft16mN3pAH+i64af2ZEdXSE2Oi/0cyUqVwe4nhOlIO+jwiRDgsGy4lRby
 /VMQhCLLxlBJZ4V+gE61ouIothX6rlbb8hUt15lGmBu+wePbCH8AF+j4hTxMYCrNhT/F BA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn6stg243-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 18:25:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28KGEAdT009952;
        Tue, 20 Sep 2022 18:25:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3c9aq30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 18:25:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwqzTdQ0MY39ysXZ9axnmwCXVbFzsVcvI5I/j7mUvKKSY8zPloAmh/rr3nzlG19xaLHVyKEx8LUyZbIJveLTwgF6DmFojLwHFPpEwhyzhOLrdKVgAq3pMBRnPy6FLTGpon+B1/V3Ni5CNc54iMRl82NlAvL7o/P11ktWM/M7NE6/qLwv1PgGQwAjyxF+zkRCBUUgF8SIT3cG+etXvLSMsAXQtsS4B0c+ImXEroj18Apzw6NGO7/t2sjtT1cMmEI4eIzWbQEwpB0Zam92BOv3t6QYm2hIjv+ynyewjo8THSdyi5shgJYjhv9FXrbTjpsaS4yzjvoOckNna1SoKfvwwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKJyZ9UEO7JuUZitz+MUCM0pHiXacZqeLtfNryJbqWw=;
 b=fw7jgax0JbWtN/0CWTmXQqc8sYxMErwfZimnlAL3ih0NlIokYW+nS1ZGqRHeo3rhRop1ISH0aPMO8hDgt2g0bXSQfeYOcblv/CxmJHh7+KS5qB3I7Lv5IDM0rQ/0reVYfapnMN0kmHgOVH/Ui/XabfL3Wh1p4bBaPCwxsno5FxpR7OZ3nV+JPv+yi8rc942jQ1f7z1UZgRrt71Pw8kSG19tsL7hoXt741blvmZEo73SLPB0OGAsFwpFmNKiX7iZ64XkVSibOUDL822yl973NyixmeyaEeqCJgC2tPcTiYEMfzl+nLKhck/Md06JobVRkPr/iEoONCUA+jxqEnTYJDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKJyZ9UEO7JuUZitz+MUCM0pHiXacZqeLtfNryJbqWw=;
 b=ugvFpDk56hsZG1DziJeNE7EMKjWOVVR4fdo4tEXa4Dn6unaw0ALN94rWsEzPsINAEwtIT9YF6p684w9qHynm9xl4Yt+r0NY3xTvhl82ejBKbLBLKWQCfRcibNVSFnm0EstdaotbqN1l9gxgpZoJFon/hKJT4b7f546Upsh3hTQ4=
Received: from SJ0PR10MB4461.namprd10.prod.outlook.com (2603:10b6:a03:2d8::15)
 by IA1PR10MB6026.namprd10.prod.outlook.com (2603:10b6:208:38a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Tue, 20 Sep
 2022 18:25:01 +0000
Received: from SJ0PR10MB4461.namprd10.prod.outlook.com
 ([fe80::cc3c:bb37:d468:dbf5]) by SJ0PR10MB4461.namprd10.prod.outlook.com
 ([fe80::cc3c:bb37:d468:dbf5%5]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 18:25:01 +0000
Subject: Re: [PATCH V2 0/5] Uncore PMON discovery mechanism support
To:     kan.liang@linux.intel.com, peterz@infradead.org, mingo@kernel.org,
        acme@redhat.com, linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        eranian@google.com, namhyung@kernel.org, ak@linux.intel.com
References: <1616003977-90612-1-git-send-email-kan.liang@linux.intel.com>
From:   Kin Cho <kin.cho@oracle.com>
Message-ID: <eb289ebb-1d9f-a5e9-6c03-4ddd3d343547@oracle.com>
Date:   Tue, 20 Sep 2022 11:25:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <1616003977-90612-1-git-send-email-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:a03:332::9) To SJ0PR10MB4461.namprd10.prod.outlook.com
 (2603:10b6:a03:2d8::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4461:EE_|IA1PR10MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e565e3-a2d1-44d5-a672-08da9b356e73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pLAT78Sl9ExsCrjj5E160JjDoU3SDNlkWFy9yYuOr7ZuV1Fh/9YyHuZDqDOmdDx+PbBKqZURw6LlLN6gkBekpaqrsCkFS363Ftd4oi2cGyD/QQ3T+gRaoU1qwk2WysyqbloTrBcoORfbeKUDCshCt1YoRXO82hEnMRXh+N9qa/GCwDkPMgc7tPkqUnw0nBH5u2lkt0fFoHVza2CkaOSJRUCqgTAjiXwYQup80KLLxQ4wUpZ2gVGYXXeV1d989kVG++R0oFUzEwpwgx8C3GR/xg1ZCp8e0KtORCJfc3ftzVdK3NKZgzYsdbsGSyN5ESeHlJiuBCV5LUziePo93awWlHa3i7LgUlbCxdMa7wj59hF9WWbT8cLQwVDy/bwagLrZGmwW79n34QKjsdKHz4ZHK8smMYsYupqCiQymNe3HnDm4M4QOiPdpUh9PKW1MkhXRqNxlQPAKR8n/MhhTChjg+cJcegz21Ryh6EeX0bgfp4/5StKyP8RG0FXmHfukTbirlmgsFmWPA2b7Es0LsipkZGWw6ydUFHqEWFO4EewUtADhwa9tZ1acIaFczQdq59UIgRXAXzYR+aF36KC64o4wztXvupmYdBq1O72ByMXtB1DuX2gXOLi1ta0QPPvprFtTEDgaBzQSwioTXWEyujw0m3u/r02/JhHasoR7p2ERhpsHs5jDL9fbeiIaMsB7z/0rYZJoJlznuceCBsFM2tHRIaZ/qjKKLjXaz6f/WGPgPholBRTZyAbjhYwAXJvRkrSjxeVKAH19GqYNmcEXISiX7hWbiCD2jg4U5C+RFwm2irdawAN/3tfXeiPI0GCrl/m9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4461.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199015)(31686004)(38100700002)(6512007)(6506007)(8676002)(4326008)(45080400002)(966005)(44832011)(2616005)(2906002)(41300700001)(53546011)(31696002)(36756003)(5660300002)(86362001)(186003)(7416002)(8936002)(66556008)(316002)(66946007)(66476007)(478600001)(83380400001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUg5Rmpqei9IYTFmdVhOUkx2d2dzYzk0RnVhdnByRmZDekk0RWNkdHN4dldI?=
 =?utf-8?B?YjR4YmlnTmIxSTFyYWJYWEJ3UEtzTVNRVWNEWmYyMWVGbjhjaHpUeGFTTmxB?=
 =?utf-8?B?WHE1b1ZjU1Erc0xaN2FUcVVQbEliYUFuOUpTTUY5WGVZRWxZaTh3dDZCTFdj?=
 =?utf-8?B?YmloL3lsbFliZXI3bjg2QkJoYkhwdGlYV2lmWldueGlWSE5PUzNDYndwL3JX?=
 =?utf-8?B?VHRpd2I1bjRqMEd1TElCQmFHa1h5SGlQT1pTVUxkYkFKRlEwdUxUY1YvY0lj?=
 =?utf-8?B?eW8zcW11NXpmdU9HdTFFa2dvL29HeHRRaFRtVmVPeWRZZ0xjVjY3S0lSRzhV?=
 =?utf-8?B?QUxnckptNDlQSkszbWdHbzg3dmNWb2ZEbjNIOENNWWJwZGZ3dnQ2SnZQNjE2?=
 =?utf-8?B?VGdCaDhocFR1enczek9CZzArWHJkZXFzZzRPMzdhQnp4amZnMExEUGdyMURs?=
 =?utf-8?B?QTVrTHVhcFlPYTBNQllodGFYNFBndEF0OHlXeFlzclZJVDd0VUhoRUIxY2Y3?=
 =?utf-8?B?WnYzZUMwdGo3cVhPZDZDZDl4aUY5anZnM1BVWjNVbnV2aUZRV2hqaUtlNU9X?=
 =?utf-8?B?cDJBaWFibWNEZS9qK1hPN2FpWEhYeS83R213UEJkNVdIc3FjNlQ4RXN5ZHgv?=
 =?utf-8?B?YzZ3OXhuRWVCMjN0WDM2bmZvOTdkdHB0bXEvT21rc3ExK3hnaDBNd3Z5blBn?=
 =?utf-8?B?OXNOOFl1azNUWHBiTGV3dURobVJJZlhnQVh2VWNLYXRCcjFZQmVyaWg5V05W?=
 =?utf-8?B?SHdKUXl6ZDdnNWxzT3dMeW9vWGVJdnF5akVvcUdwYTBFQms4SUZBWGduREgy?=
 =?utf-8?B?SWNVV2ZaR3htTEZDdzdJYVFScDNIWlhUeUw0a2I0NTJFUWZxTnRIUXErcHNO?=
 =?utf-8?B?Y09hdGtTNStOWmlnRUd5ZlBlWUFINE0xWEt6ejYvbXdsSVp2Q2wxYzhQVFgw?=
 =?utf-8?B?N2hlMHM5aVlUR0VlZ0JXUms2S2EvUjhBaFFiN294UzdGaCtTbjY4V0k1ZzAv?=
 =?utf-8?B?ZkpHZ2hQdnIzUjlWYkhMM1pqcWJsYXZKVncwYVNCZk1SRFU4blhhZW5wZ1VF?=
 =?utf-8?B?L01hdTFhdGlnb2p0b2dGblh3WFVMMGVUWkRZUzVPZ1hqNGFWSkpseFJCd3pw?=
 =?utf-8?B?YnlUamkvemZUclJNdm96VTVVV1JTeDVCamxrK25UUndMMXI2b1lNUFlsUldr?=
 =?utf-8?B?UjNCVHp4OXNocWtsU1BKU3RoTHNjTStseVBKQ1ZSTnhYRHRrRGtuYVkxOVYv?=
 =?utf-8?B?VktJUlMwN1A3VUJGY0NzQ2hZSnZYQzY1SXZRWENBTXFLbDF1Q3RpM0NEeHp2?=
 =?utf-8?B?bjJQdkxTcGlETENWaGg1RUpGcDRka3VaTWlYRzVHRmhPbDM0dXJCVnJ2Nm1a?=
 =?utf-8?B?b0lzelhta0F1dUpPQzAxdWl1czBuMmxNQ0d1TDgxU1VaWmlTc0dsaW11b1Uz?=
 =?utf-8?B?UDhvR2V2SVV4a1gwakxqb0dvVUZLTVBlSFdONzdOYk9EUHZsSDRFQXc2U2pn?=
 =?utf-8?B?bmdKeWpWeVJ2TGhSa0NLOWwrSmR2dmVtazRKRFZwU0RxbVg3RFljdkJCZmE3?=
 =?utf-8?B?djIyVDlBTUNSRFJOT2VBT253L09xcTM0anI5YmtYQjdNd3BMcnVyQTk5bTNv?=
 =?utf-8?B?VlU3VkNFOW8rblNxQWFCdDZaMyszbVFZbmxoeG5hWWlBd2tBUStHaDFYbjFQ?=
 =?utf-8?B?cW56T2J1Z1dKS3QyU2h4TGp0bGdrRU5IQ3YzMnErZk1Zb0tzNHcvcG0wSEJi?=
 =?utf-8?B?WVRMUG1aTDh1THVpbWVod3lYRGJxYWRaeEE4VFBqSVVLdFk0YjJkbm9vbjF4?=
 =?utf-8?B?eXR0OENwZGJ1WHhiRVVyaThOVi96eHZCaXplaHdtRXJUeElGMERZVHVGWFNa?=
 =?utf-8?B?R0trZHJTUkwzYnBkU2dNejBpd21KUFBhVXF5bXBPL2lxL25ncjZIMWs5LzNY?=
 =?utf-8?B?WG9QTkdUaVNyQXU0NnpoNERnUzBJNDltdW8rcFJoQjVTZkFaVEx0SVc0M21i?=
 =?utf-8?B?MnJocStVSmJQM2hKRHBnM2dIRXBmbHRPK25JRkkzd2MwVUd5YU5NREt5anQw?=
 =?utf-8?B?QWlZMkdxSnVxRUZZOXdRVzhteE1YN05KZ29SakpBWlBsRzYvcXhua2J3N0FX?=
 =?utf-8?B?V1BDSnF3S0V5RWp5U2hsQ3FPc2k1LytFSTlVakNVTGc3UWNzMmVXTWRLZ1d6?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e565e3-a2d1-44d5-a672-08da9b356e73
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4461.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 18:25:01.6866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xbtmd9NsuiV+Vlcv4Io/YlZlrGs2xSubPAg2k4pvwmKRfC+8uYp2li0IBafkk2rJfvTRaFD6AqWQa/yjYXU1mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6026
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_08,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=920
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200110
X-Proofpoint-GUID: bHTgZX2YX60nD3GiG_qKja9UFE54geYe
X-Proofpoint-ORIG-GUID: bHTgZX2YX60nD3GiG_qKja9UFE54geYe
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kan,

We're seeing the warning below from uncore_insert_box_info on SPR.
I added a debug print:

     /* Parsing Unit Discovery State */
     for (i = 0; i < global.max_units; i++) {
..
         uncore_insert_box_info(&unit, die, *parsed);
 >>        pr_info("%d 0x%llx\n", i, unit.ctl);

and here's the output:

[   17.758579] intel_uncore: 0 0x2fc0
[   17.763117] intel_uncore: 2 0x2010
..
[   17.935286] intel_uncore: 65 0x87e410a0
[   17.940308] intel_uncore: 66 0x87e21318
[   17.945331] ------------[ cut here ]------------
[   17.946305] WARNING: CPU: 65 PID: 1 at 
arch/x86/events/intel/uncore_discovery.c:184 
intel_uncore_has_discovery_tables+0x4c0/0x65c
..
[   18.161512] intel_uncore: 67 0x87e410a0
[   18.166533] intel_uncore: 68 0x87e21318
..

Any suggestions?

-kin

[   17.945331] ------------[ cut here ]------------
[   17.946305] WARNING: CPU: 65 PID: 1 at 
arch/x86/events/intel/uncore_discovery.c:184 
intel_uncore_has_discovery_tables+0x4c0/0x65c
[   17.946305] Modules linked in:
[   17.946305] CPU: 65 PID: 1 Comm: swapper/0 Not tainted 
5.4.17-2136.313.1-X10-2c+ #4
[   17.946305] Hardware name: Oracle Corporation 
sca-x102c-107-sp/PCA,MB,X10-2c, BIOS 79805101 09/13/2022
[   17.946305] RIP: 0010:intel_uncore_has_discovery_tables+0x4c0/0x65c
[   17.946305] Code: 38 48 63 f0 48 8d 3c b1 45 8b 04 b0 44 89 07 4c 8b 
42 40 45 8b 04 b0 45 89 04 b1 0f b7 75 ca 3b 37 75 cf 4c 89 8d 68 ff ff 
ff <0f> 0b 48 89 cf e8 c6 4f 2b 00 4c 8b 8d 68 ff ff ff 4c 89 cf e8 b7
[   17.946305] RSP: 0000:ff4b04f60006bd08 EFLAGS: 00010246
[   17.946305] RAX: 0000000000000002 RBX: 0000000000000044 RCX: 
ff43a98a4ff1bb30
[   17.946305] RDX: ff43a98a4ff294e0 RSI: 0000000000000003 RDI: 
ff43a98a4ff1bb38
[   17.946305] RBP: ff4b04f60006bdb0 R08: 0000000000018000 R09: 
ff43a98a4ff1b310
[   17.946305] R10: 0000000000000005 R11: ff43a98c7f7fe000 R12: 
ff43a98777d66000
[   17.946305] R13: 0000000000015240 R14: ff4b04f61b286000 R15: 
0000000000000043
[   17.946305] FS:  0000000000000000(0000) GS:ff43a90a7f840000(0000) 
knlGS:0000000000000000
[   17.946305] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.946305] CR2: 0000000000000000 CR3: 000000967e00a001 CR4: 
0000000000761ee0
[   17.946305] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   17.946305] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 
0000000000000400
[   17.946305] PKRU: 55555554
[   17.946305] Call Trace:
[   17.946305]  ? uncore_types_init+0x25f/0x25f
[   17.946305]  intel_uncore_init+0x64/0x50c
[   17.946305]  ? perf_pmu_register+0x2cc/0x403
[   17.946305]  ? uncore_types_init+0x25f/0x25f
[   17.946305]  do_one_initcall+0x52/0x1e1
[   17.946305]  ? trace_event_define_fields_initcall_level+0x2a/0x36
[   17.946305]  kernel_init_freeable+0x1fc/0x2a7
[   17.946305]  ? loglevel+0x5d/0x5d
[   17.946305]  ? rest_init+0xb0/0xb0
[   17.946305]  kernel_init+0xe/0x123
[   17.946305]  ret_from_fork+0x24/0x36
[   17.946305] ---[ end trace d9131e47b8a615f4 ]---


On 3/17/21 10:59 AM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Changes since V1:
> - Use the generic rbtree functions, rb_add() and rb_find(). (Patch 1)
> - Add a module parameter, uncore_no_discover. If users don't want the
>    discovery feature, they can set uncore_no_discover=true. (Patch 1)
>
>
> A mechanism of self-describing HW for the uncore PMOM has been
> introduced with the latest Intel platforms. By reading through an MMIO
> page worth of information, SW can ‘discover’ all the standard uncore
> PMON registers.
>
> With the discovery mechanism, Perf can
> - Retrieve the generic uncore unit information of all standard uncore
>    blocks, e.g., the address of counters, the address of the counter
>    control, the counter width, the access type, etc.
>    Perf can provide basic uncore support based on this information.
>    For a new platform, perf users will get basic uncore support even if
>    the platform-specific enabling code is not ready yet.
> - Retrieve accurate uncore unit information, e.g., the number of uncore
>    boxes. The number of uncore boxes may be different among machines.
>    Current perf hard code the max number of the uncore blocks. On some
>    machines, perf may create a PMU for an unavailable uncore block.
>    Although there is no harm (always return 0 for the unavailable uncore
>    block), it may confuse the users. The discovery mechanism can provide
>    the accurate number of available uncore boxes on a machine.
>
> But, the discovery mechanism has some limits,
> - Rely on BIOS's support. If a BIOS doesn't support the discovery
>    mechanism, the uncore driver will exit with -ENODEV. There is nothing
>    changed.
> - Only provide the generic uncore unit information. The information for
>    the advanced features, such as fixed counters, filters, and
>    constraints, cannot be retrieved.
> - Only support the standard PMON blocks. Non-standard PMON blocks, e.g.,
>    free-running counters, are not supported.
> - Only provide an ID for an uncore block. No meaningful name is
>    provided. The uncore_type_&typeID_&boxID will be used as the name.
> - Enabling the PCI and MMIO type of uncore blocks rely on the NUMA support.
>    These uncore blocks require the mapping information from a BUS to a
>    die. The current discovery table doesn't provide the mapping
>    information. The pcibus_to_node() from NUMA is used to retrieve the
>    information. If NUMA is not supported, some uncore blocks maybe
>    unavailable.
>
> To locate the MMIO page, SW has to find a PCI device with the unique
> capability ID 0x23 and retrieve its BAR address.
>
> The spec can be found at Snow Ridge or Ice Lake server's uncore document.
> https://cdrdv2.intel.com/v1/dl/getContent/611319
>
> Kan Liang (5):
>    perf/x86/intel/uncore: Parse uncore discovery tables
>    perf/x86/intel/uncore: Generic support for the MSR type of uncore
>      blocks
>    perf/x86/intel/uncore: Rename uncore_notifier to
>      uncore_pci_sub_notifier
>    perf/x86/intel/uncore: Generic support for the PCI type of uncore
>      blocks
>    perf/x86/intel/uncore: Generic support for the MMIO type of uncore
>      blocks
>
>   arch/x86/events/intel/Makefile           |   2 +-
>   arch/x86/events/intel/uncore.c           | 188 ++++++++--
>   arch/x86/events/intel/uncore.h           |  10 +-
>   arch/x86/events/intel/uncore_discovery.c | 622 +++++++++++++++++++++++++++++++
>   arch/x86/events/intel/uncore_discovery.h | 131 +++++++
>   5 files changed, 922 insertions(+), 31 deletions(-)
>   create mode 100644 arch/x86/events/intel/uncore_discovery.c
>   create mode 100644 arch/x86/events/intel/uncore_discovery.h
>

