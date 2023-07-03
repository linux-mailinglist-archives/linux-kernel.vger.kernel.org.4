Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F40574612C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjGCRJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjGCRJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:09:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B80CD;
        Mon,  3 Jul 2023 10:09:27 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363G8QJP006055;
        Mon, 3 Jul 2023 17:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=GX5gd8L8SrETX74cuEyRS5DEs89ins2dp7LqLQWtKP4=;
 b=LJlWGIL3aU9Va2PKdiGcTbS+xG5jBHfaV7Sd7ucmBr8KXu220xRNfshpvI40oOvEh4bP
 0daPne/XJbptb0lcWAnjOVBZz1xT6L5w+BRp01CME2T2sVr96e+OcciINEDxfShO3t3P
 7JL9m/3JhMB8DeFonHbwIe2+PazBh0lTMuX4yO/YAEvpmY3zybTMhiyiMLA/T5KAVfWN
 f0LXC5SvPToFNRNjXTr1JND+NrgrFvoX3PlilQshwinHjbDzpNezAxv7wawAids1ZLsQ
 +s9UjtRzYaLGDMfRTOCuclcJTzRcNpXSTURXbgsogemvKEmiP6i6EkWs5ZEnqN6qb/J7 HA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc1ak1s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 17:09:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 363FGoaI009032;
        Mon, 3 Jul 2023 17:09:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak9b451-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 17:09:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knKMnvSg47qIbEfG1lPZweHiIoRK6+TZDvZ7SWh/j+KjFiTlpLu16WsvcGS05hpFLv2RpMpE7JxToNFl8bbd8KiTwiJ6YrhyoExjmaapEp6iRZNmrN7G3FlwrfdRmFfpqeUiM7WFhvduc50AiDkKUEgD/nMwWUrE4CGWh+KUAUzLBWn09Fa9BGeUDfXAvyfb6wV9sNyrAKw2V5LBNXvM0FpheKzWKtcN2nBinWI8cErFAcq7170bamrwjq6Os0K3M8ShbiXxRUhfmuDPrFJeXDvk4/CueJPmyOPVGN5iehxDIOnAiVk7oNCb3Z/yXYm45wXQDklzI7Klz5tVi6fkNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GX5gd8L8SrETX74cuEyRS5DEs89ins2dp7LqLQWtKP4=;
 b=WT0KILlHoCX4RkkUN0J5Sd2wSnF5R6OUcQTqGzCBCLj1dkpavdmEZzgFJ9poAPLchamSIavMfT1GDZ/p5scMtJAiNStgja+rSZvLMts5yvK/z938NIjhG29wYOPXyBr2LX8cfvwwNOKvuPHNwNfPb/N/PnaCWkYc0Y1281yL9PCwyRaQ+txZdIZayjoWVeIUrUlPndhGQbjV15aPUShj/O+CKa1ANEwYP1B2T3Kqh1Djzc537tCRaQlP5I5h+Fc8hJGO5iOMzPB48WdfrlURIbUqlXpLjiUSnf3Df3DWmovOL90muavVhGDlNoLXi3dvuEIzSkvGf+romwo0JZjccg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GX5gd8L8SrETX74cuEyRS5DEs89ins2dp7LqLQWtKP4=;
 b=joLSV7y/1BhSiPoNWAU9foFWOOjEysSzTjU4nRkqsNG3j5P5+PiSKGoyMI+kQra3QvZ7eUwy1lKFMomIXgl3H5MQgIBVcdCOtHbWif2y+J8mghRaM+olp6wSvn/AI4z4HOS/I1xOpf2WaHwf5FPhDojfSsLnCCcHdnto97oxcTg=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CYYPR10MB7605.namprd10.prod.outlook.com (2603:10b6:930:c8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 17:09:14 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 17:09:14 +0000
Message-ID: <69eeacda-d59c-bec8-d115-4bf7c97d7690@oracle.com>
Date:   Mon, 3 Jul 2023 12:09:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [GIT PULL] first round of SCSI updates for the 6.4+ merge window
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <23bd2eafa9b9a23e4a8a96fc0180bba9e77e42ca.camel@HansenPartnership.com>
 <CAHk-=wjgnB11KzroXS+Gi1TQO19uf0FvkMBn=V7mcQ8q78ucnQ@mail.gmail.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CAHk-=wjgnB11KzroXS+Gi1TQO19uf0FvkMBn=V7mcQ8q78ucnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0009.namprd06.prod.outlook.com
 (2603:10b6:8:2a::28) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CYYPR10MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: 3456a542-3a25-4e7f-fdc0-08db7be83a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lid8AXihqQW8aPUxVkvlvDEGXG0LRm+2rfkzeMBmg1XVBGGMA21+2xO9NPK44jsikqcIxmkpnKOCJxz/EKEOLdreIbZc+auX2JmsMPe2GjELjvw3P8e0ofHuPqCJOer3dscDwCrpVqDFEGlCFjyNc6csVQll5oQkz6yd4bl4w43C433qFLjzjxcHdwRrLp43sBPjE/igV2aNz4qVw+uMDH91o8LpcZsgbEJqFKRCi1PyqIpvsqfpwiPJznuZ+BmwnErVv68MpjIeCMFYw1Pf62O6yqycVs4R33niWPMJ290wCMvqgkQjZQC6ErZezz7eQNvUzvx979kF+zAJzXvPtjsuwRNYKVTGpL0GE7ICJeK0k2Y9XyknxNCnH2+KWGC7qpRyxLaJB8Ww56ldoEMoeGJI36Y0tB+4Vx9wydqHG2rPme6b0xOLv+54PWSfLxPOiSyIvU4cXXOYJ3to8dKf4PnBrMZjLDBbwsdIdZwgddIE8/5x78Xr3LS3dO8CUtCnaxD0NCLggPXHLqcMBjb/1FnYVIaphKDnRkmhx5w9C6KnfpjwLDA70o8mborjtzZ9VS5/Rc/H0D8cI9vPaChTCQ1l5Z050hFVZzSryApRTOY+ZGMoUSQ8DbDdpyDfr0I9QZgqxUbwrpxtjjtyAAZI0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199021)(38100700002)(2906002)(6486002)(8936002)(8676002)(110136005)(54906003)(36756003)(41300700001)(5660300002)(478600001)(31696002)(53546011)(66946007)(66476007)(186003)(6512007)(26005)(86362001)(6506007)(66556008)(4326008)(316002)(31686004)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjZxMjE3T1Q1NkNVSGxaWXVNYklBWDF3RUJ2dHQ0UzUza1M3bzR3SUhFVXZR?=
 =?utf-8?B?Z1ZIL2dvYVdOY20wcGJacjdxZmM2Y3FxdncxSE0vYTk1N3JtVXhBc09QTHZl?=
 =?utf-8?B?d1k3dGRpSzdLOUUzT2t1Zkd2NXhuOGw4SThLbUMvL1ZJamN4RXAvNy9oQnZ2?=
 =?utf-8?B?TUprRlRidXd0NXFpL0JROHVnRWROQWdwR0FxNC90N2M2QWxFSUF6MStQK2My?=
 =?utf-8?B?NW1FOCt5Wi9JekxCQkRPZGZNWFo5eGsrdGM2ZVVGRjI2WWdGZ3k0NC9GQnRG?=
 =?utf-8?B?K25sR2lmUW1KN3pCdTZQNjhEQ3lXNUo2OXE2V0xmSEpnQ2MrTXZDb0xKQlJ2?=
 =?utf-8?B?dEVxNjd0WlRUREpGVGdOWkl6SS84RExUbW9FMDlBMnk3dXR5VUUvWFJiV0Vr?=
 =?utf-8?B?YmtnSXgrcnd1WHhWdkx4UUo5TFRSWXhnRE9td2M3ZW1tSWJvbDcvYXBYU0l0?=
 =?utf-8?B?MnVMS2tFMDJWaGlBYWNlZ2prYnBjaGI5cDFrZllkRFFQaDhnVWREa3oycjRZ?=
 =?utf-8?B?VG41WG1ZNFc5RkN6Nkw2MTZxdnFKeFZNRytoWUJsZVBDUlE0MC9PSGJYVUtN?=
 =?utf-8?B?cWhBWDNLVjh2Uy81d2pMcFVZdFJpdmQ5aHZ4QjJtUUZaZEw1SkI4MDhjQ3hm?=
 =?utf-8?B?Ymh4QzdobXRXeVJDUGlveTM3dlhFRkxaWUJLcjYzNVFBV1BwWUlsL1Qvcm1z?=
 =?utf-8?B?M2RFWHQ1cDcwcjh6Q25EM1hoSm84aTdIc2ZURzBIM1JHYWRhMEh6RzFJcjRw?=
 =?utf-8?B?NDBseElOZXlHZkJYUWk5SmM3ZGtmalpzVlBhNTdiN0lIdHJtcHhkeGRreXlF?=
 =?utf-8?B?YU14b1dxbUh2SVErRlNxWVlCSXY0UUYza1gxdEZIejZkNDRPQVhWdDc2ZkFh?=
 =?utf-8?B?elFta3FRdGtQd3ZkTUNoMHBvcXJrc0NGQVhDK1ZFcGEyUk5sdm12MjJ6SEhm?=
 =?utf-8?B?WURMUmlTclBqOURiQ1IyMmdHLzU4ZXFaRjN4UEV1aTErNXArQ2pQbldUYUJi?=
 =?utf-8?B?S3FINkxEVlVueWJtclc3azFSVkJQRm1aUWlnNTVVTHBacGlkUlYyMEhBYnhU?=
 =?utf-8?B?ZFhWaVpUc2xFZ1JQa21xUzJOYnJHVW45aXFQMnlWbmxtU0kreEZ2QmZuazVn?=
 =?utf-8?B?Y0ttdHVxczg1MkxHMjJOVTdlQzhpeml3aWptdjJrMjJkQVlNU2dVcHVJUW8w?=
 =?utf-8?B?SmZPMFBEM09hd2RySkovU2R4Snp0dlBHY2F0MHRXVmpSL0F5b3QwenhZaUlC?=
 =?utf-8?B?eUpPMnBHZTRBRTRmYUhsSG1wanh2b2lhbGJiOFdLU3pEVG5DR0FDTElCa25P?=
 =?utf-8?B?QW5rS1lBelpRNFlPREltUzR2bEgxN3hhSFVLcHVCNUVJdG8wSXpjVTg3RURs?=
 =?utf-8?B?aE1MZHJTOFMxUCtvMCszVWNmR1FLbC9WTFZNamZlOTgrNlp3dThxVDBlVjI4?=
 =?utf-8?B?SU5XaHRRZ2tlNEY4SUh3b0RjNVBnR3dEbTQ5TmxPWTMvOG56ZzRSN3J0N0dt?=
 =?utf-8?B?Y0Iza25XL0lBamVwR2d4dzBKaEFtZ3JPZkhnM3JXdllpZk5iOUw2TjYrNHJJ?=
 =?utf-8?B?NzFicFRGZW1uUVNzem5xditIbDVzSUZPWkIzcXNldktOcjAxektLMjVSMk9u?=
 =?utf-8?B?WHhabmNJWllUYVpFUjdrdFdpZ0h3dWVDQ1J2c0toVWp6bVJpcGtxb0UyS0Zw?=
 =?utf-8?B?TDBnaEtPWGNZbGtDbzk1dHpORlpycHVYbVFURnpFOWRLSHZpVEZ0ZWlBNVhL?=
 =?utf-8?B?RS9ULytNWlR5OEdNaFFDbTFjcWFmZWVxeXo2eEVJdjAwMmFGU0IvSXNUQzRN?=
 =?utf-8?B?ZmgzSXh5eWR5ampOVzlSc3F1b3pna3hrS3FqZFlEUUsyOEhvM3JqaWlvYkhm?=
 =?utf-8?B?eHFQZjVETFVWRTQrNjVFRFZVamkzK3p5Y2pNWkVaa3d2cWpNcXN0aDJEdXRs?=
 =?utf-8?B?M1FkZnhwalVyNVllMlJUOWlMdXUyNVFiOENJcE8yWW51M29EQ2J1aDI3T0dY?=
 =?utf-8?B?WUMvMitkU1dQQXlhbVZhaS95MVpxUk9wWVVsYjBUTGluKzMyNmt1amJ5SHhO?=
 =?utf-8?B?UjZZTGtzMHhpalhwMWpqdjZ0R1Q5akJ0VVNIT1lSYUNMNk1tNmNjZ0V3TndR?=
 =?utf-8?B?bEVZclp4R0hOcWM2ZW15MTk4MHdxd1NFYWZKeFZwRVJHY1RQcEVhSmdyWit1?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rP2ikzlAxsmOFB5GlNBOtDNOzFZ9j/nBxlBIjk+tNuSK9Ri/Tyrcj694/WvPl/5c574HFfsbWT/bIPUmaGSDKvZW+2rqcVd8teJlACJ1I79S1ozkdMMQ4MaZtXh4UHzeb0xt1wfVfjsgsOHy8P/d6FqeY4m5nzzkxjoSmaauf+3qPdqXGRnb+wP4ASBUeSVicU8w5eFSOMyBn7awIFN3o3t5Wequ1Vg8pcABHH9Pcu3961LLOO7C+55HKaRypDbxBwlhM4VZr4mPSiSNdiJycFZPLyHOL61Hs1+wzXvUhVPDMuEsODbShK4Lnyu5ODuipPWLEDArHz6TeOtJXYHktz/fJdH4T9rCstnq2DGC27FMqi4wiEbjCFRcazy8Y3K5RxAs9zBnR349z+gwI+43YNe8AvuVbsXyEMWnT+TaQBJbO6en8EtCE3cRiKPDc9GKiczoYTBm8qLBTG4m61HgPQbN8+lKlopFhjA7sDYIe0SgnN7gT4zPLTbitC4ZrfmY5sg97YcsOb7TkKXPUZJ9yGFPcgZ57RJGE7Lfmv8DISQizhn2qpb1sYHba7YfzFWQW6vWfJl8P/NJjgL0A/2yVJlxYFbHhQuV+AvSSCUaMFBx5auVPSwSLBT7HE6iCA6WmQEEF44poOsBEck5DsW3ESVuI5/MWwFj8OrCiTc77yvujMT8xBf0qxAF/8t5CPnEVf/8QrBv4mKobiR0eGY16XxcS72Oax9Pg4/l7x1ZyjoytylsRvUXMskQejGgprwUrdYfei52jOr4lGhKhuLiY5jnH5vLFDI3xgN12gZCznLGtE5yhcMQyyHst58peNj/f5rKtW9/Q/OFxjfpiCtyOLS1wPtCY+h6jD68k4vRr4dGvAvu7Swwcfvg6q98Q7Z+bKyyQvIlu1UUI4vfQWFLJRRQAcbW3ZuPAMBDOXtEk1k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3456a542-3a25-4e7f-fdc0-08db7be83a50
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 17:09:14.5429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ktcElDatggRO9Z0jn2GuiRkoB/XcDhYpiUp3Er2Lxmd9v4BjpG0qKRSvRbMHhQkjpWR0CLYvMiVrMH6kRF9/GIB3YIl6SCQ1I7JxMJfvM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7605
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_13,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=847
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030157
X-Proofpoint-GUID: gmi-q9GaIP-yLNifRip34YmA343B6yTB
X-Proofpoint-ORIG-GUID: gmi-q9GaIP-yLNifRip34YmA343B6yTB
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/23 2:14 PM, Linus Torvalds wrote:
> On Thu, 29 Jun 2023 at 05:48, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
>>
>>    We have a couple of major core changes impacting other
>> systems: Command Duration Limits, which spills into block and ATA and
>> block level Persistent Reservation Operations, which touches block,
>> nvme, target and dm (both of which are added with merge commits
>> containing a cover letter explaining what's going on).
> 
> Random side note - as an outsider that then sees a trivial conflict
> due to the split of the nmve side into a file called 'pr.c', I can
> only say that my reaction to that was "what a horrible filename".
> 
> Maybe it makes sense to people that are very into nvme, but honestly,
> considering it's a new special thing, I kind of doubt it.
> 
> We really don't lack the disk-space to use more descriptive names for
> files. "pr.c" really is pretty horrid.

cc'ing the nvme list because it's their file.

PR stands for persistent reservation. It's from the SCSI days so the
term and abbreviation is common to SCSI people and nvme developers that
used to work on that. I can see how a new storage person would not be
familiar with it.

Maybe name it persistent_reservation.c, or if people think that's too
long does persistent_resv.c make sense since we use the "resv"
abbreviation for reservation in nvme and the block layer.

