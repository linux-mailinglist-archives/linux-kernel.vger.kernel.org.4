Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD946A6E27
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCAORZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjCAORX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:17:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A632302AA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:17:21 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321DE06w028779;
        Wed, 1 Mar 2023 14:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=u4FyJbg0PIpHDRdSc38vLK390RGYp9Lll0LcXASEK/U=;
 b=KhRcqQeeQ0gp81nRclPNTZk4m75ELmS3y7MZn+hzThx+mRDGIgSrxwLtAwBCA3DD9iQZ
 b6h5FQpxfDNSutCTuv/6UeTdt3y42D1Fmknwj9j4qES7skfpxEw8beaJ76xEMm5iLnhq
 mazFQHiEUAGzfV3HiKwHl8OIOCY/ecIOt1KjXrXW4KtK2ahD99BSBOLbHN6/+kr/UEIw
 yilOC8bgqPepWYYz9txZKmrP5WZ5el1kB1YdyFLLBd330lKob7FXeS/WI7fMqeBiq2eL
 /uf2FnkIdYfr98QKe8ibHLsQu7OKR4QoqUkQsrePapOaNShEnHwsPeSod8+nmXdnjwBS Aw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb7ws35a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Mar 2023 14:16:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 321DIYQg031614;
        Wed, 1 Mar 2023 14:16:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sfasg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Mar 2023 14:16:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbH6AIRhhCElWh7fPNdgXVFbwhKMnk1r10QXd6LLtI3zfpe2rKTeJ1BFAYHB3dgyfO+IbTRSz7fqXp8CcSYievtg9azf/9iCGxboR+r415nNK0jG174GoZaSg2DYGQTxuvzoazTyAKigc83JKdNlltWMWYAB3recyM7Z9Q/RM9Un0jbCWM9LG4kRj9F/IfRmOxc0rl53qMu/MuA+whQExqRKuRVCNwNo2a4oRdewVcRY+Qsy5qyp241vcN8+T+zkRv2eFDamujJohB9WQ5lUHpZFiwR5aXPFEs15ytUqZBys0wWKWWLHke/+LCs6jjDtlFLamcAI9T29ec/9kuZc7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4FyJbg0PIpHDRdSc38vLK390RGYp9Lll0LcXASEK/U=;
 b=GjGjGODweKXja+ux92/erkfRRKQ6WVT0uNTzHaWcQPD2xQxFvTcL91P+LXKK6WNNv3/TK5BKbwpCUrEExGC/fYpu9+hnej0AcvetpVrV3FHAspNm+NwCn3VMl1faUxOunTEiTCOCeCh3KrvxgyXP5o9otCna5TTsoHfXalqMxML09msld1m3fDwgIjD5hdJLOlV87aS2r75znAYQWfVcimP9/1uWTovHm0VzXA6phi+S0gPWK03AfXtVk5zs8m/4SDZawMRq8xSgPDjdNobtsQOCwXcpA/4MnBrNvL9AZ7d/PXl1SzzRkHNpmsPMDOauBWvxP3J11F48wvE8txvSkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4FyJbg0PIpHDRdSc38vLK390RGYp9Lll0LcXASEK/U=;
 b=oTsVyt/Cml0Xberb6R27j9jz1YbswIHj3X3LyuIPwX2VWq4givD+p9li2vVgDLbXoJQLHVjjo5RT4bo77qlhZ76fN1csO3+FnX68B7NBQGyfIp22xIE9htkyXYcW7xUCDwXdSlqGYVHLSGqgn2raFLfNEhCT1AHa2Svj8Rmc84s=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH3PR10MB7164.namprd10.prod.outlook.com (2603:10b6:610:123::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 14:16:39 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%8]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 14:16:39 +0000
Message-ID: <e1215ac1-ff59-bdc6-20d9-639a4162943a@oracle.com>
Date:   Wed, 1 Mar 2023 08:16:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-6-eric.devolder@oracle.com> <87sffpzkle.ffs@tglx>
 <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com> <87h6vw2rwf.ffs@tglx>
 <7580421a-648a-2c4b-3c33-82e7622d9585@oracle.com>
 <d465173e-a31a-c4d6-af51-59d9ff0c2edc@linux.ibm.com>
 <24034f33-739b-e5f5-40c0-8d5abeb1ad89@oracle.com>
 <18c57fd0-2ad0-361a-9a53-ac49c372f021@linux.ibm.com>
 <ee58fcfa-1734-2992-d6b7-83f365a9e16a@oracle.com>
 <fc9f8ba4-967a-6e48-df73-67427c145141@linux.ibm.com>
 <4eeda077-c578-791b-8e48-e418744a7615@oracle.com>
 <8aa21721-6951-80d1-ae20-db4198b743ff@linux.ibm.com>
 <4fbdbb3a-dcab-cbf1-0d24-a7be1858b048@oracle.com>
 <38b4e70b-00b6-8e9c-e98a-77df4454aee7@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <38b4e70b-00b6-8e9c-e98a-77df4454aee7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0228.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::24) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CH3PR10MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a2a6d9c-cca5-46ae-3452-08db1a5f92d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LF8A/uIUwhNAFC/HGjXcTw5yfYrWi21KID5+BHdaVZPjhwsrDd2oIsusF4B3mEI70biaVj+ZnnmYEarjLCizAT1mO1AV8gkNqAYmtaPt3hfrSXC1eCjZhDpyBHJy9K2Ji4cnRIL2bKgegM3F6mhDsAK2kx2qenIwySqIPkQJ3jNXEljBQIp1bq4DTkCWYg01qaykz851EBLZu2Z7yUr9M1iB7llZ3eFV4YVp4K5bsEvQNRe2SD8cUbcq0HDyVPVIKbwnAsjVFebB8FTR2+QJbsFQHqF4q9AOgMEfyCIN4ZFHyaN7UiWkSq7InRJ/foCx4Nol6fW5mZbFUMu28lfELk0ahWaHujqovLdvx/RORNdKU0KsrwR/p9SkdKejLk6vzUKeFhGIo5Fb2jPt/Hk5KYgkaAtMUI25xcnnnlT6YNBzdm1aAWmLUdNzFfm70r9h8BJs2LdLA4Boqz+7vkjDqWqzH8AkySptseme7Z0q8rsu+LeqrksuaUV4T04DhV/bmlDT8ihMM9BLbGrjJFuOM4WfdCtE5a4Q/8VcR7DW8t/Ciy6aHBNBwccxj3il5DtR49evTqJh6FnY1+hCWah0oEiAgM5RrifTc31FTmc410efu/2rnjpif5rxGCuXypcV1cEG3ihAQAJUdDygxh9zUBj+aE45TSj0vYzV4LXtaqIQkGEd6KkSZP+Szq1rWvWDvMdfLRs7QN56c5YN+16Qa43Pdc2N7r0v39OfhYq+AqY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(366004)(376002)(39860400002)(396003)(84040400005)(451199018)(2906002)(6512007)(186003)(107886003)(6506007)(86362001)(6666004)(31696002)(53546011)(38100700002)(83380400001)(2616005)(316002)(110136005)(478600001)(6486002)(36756003)(31686004)(30864003)(8936002)(5660300002)(7416002)(41300700001)(8676002)(66476007)(66556008)(4326008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDRZWmxGNEVUZnBBaXM5SEkzNytqZktGVTZYeFNMNXRLK3dzazVDMWtWMkZw?=
 =?utf-8?B?Mi9MSndDb2w4blkzV1hMQk4yMXIvL1IwaUorZ0Z2SzcrdXphd3ZCRHZlb1ht?=
 =?utf-8?B?akFOT0w0UGRrOHRhR0tidjdTSVRJd09paEVrZnFERUQzMEoxWmlpUkswVTRV?=
 =?utf-8?B?RjZ6QWN0c3lFdkxQMEx6RFZwbnN1bzJDVjlJZ0FOOTRya0dkcktMcGgyR0VB?=
 =?utf-8?B?dGQ0dFdCNDQ1UGpRWVl6VDNWaW45VXdMNnJheW9IK3pJWHpuRkFEUmY3K1RO?=
 =?utf-8?B?SyswUCtlOEhjOUMxam5lTHhTN2RNbnNxZ050bVhua0VTaDhNbmpSK3lDTGg3?=
 =?utf-8?B?WlZnMUtPUHpEMFEwMGthMTN3QXk2elpYaHdJODJISGJZckFQT1h2UGVwaFhv?=
 =?utf-8?B?ak51RVpuQTZDdm1YRVU2cmUwZ2hGYWJIcVhKOEZXcHVLbHdva0RGOFhiL09h?=
 =?utf-8?B?Y2s0ZlN3L2hkOHdOOS9hQjZIejVPcm8vM0VuZkRWbnV6T1RrMlIxeUFFTlVq?=
 =?utf-8?B?U2ZCOE51ZTdMYXlRWk1LczAwalp0eHBocE9ycmw2Sk9FdGNGSnhNcWlXV2pn?=
 =?utf-8?B?cHNYTVFYN3VRd251bzhYd2s3dTJQR3BNTGxIUkw5SkJ1SVBwSmIvL3VFeEJR?=
 =?utf-8?B?SW9QbjB0YWJKT3ZZd3ZKRDhMdDNJSkNlNHdHN3RqSjlxWGpqL1dmWGE0UHBt?=
 =?utf-8?B?QVV6VzJhUDNNWGJHTllMcG9ad0dTMFJhZnh1RkhyWDNIbHZoQllnMEhXS1ZG?=
 =?utf-8?B?emdidlFjZXF0VEljejhCa0J0MUVvM2tZNTdtdVBWWVpYVExaRnpiRTQrUTFW?=
 =?utf-8?B?ZzFzbnBvc3ZjNTFEMW96L29LT0ZOREVlVTZQUm8xUGdMVEVadVJ3QUNrQTZF?=
 =?utf-8?B?OExSQ3VaVDFpTVorOWVsd3FMOEZBeWJCSUxhS2YxR0p3NW9DVzBTOVRySDBu?=
 =?utf-8?B?WFIxZWl3dEFIQ1NjVFd3MjR5Tk1zcC9WU3RFTFV1L1JrYThNeko5eEg0Q0hC?=
 =?utf-8?B?UXk5R1JjcXZYM2JRUDlDUlRxbkNZRTQxOGNVbkRSajdUbWhMeG16NGdsZ3ZI?=
 =?utf-8?B?WXBWMWp0akNHMlY1WkVENStKRkJlbjFvQXdtb1dmdUdFb2tWdDduS0VWbnJY?=
 =?utf-8?B?bFI3QXQ2NVlEVDVZUmh6T0JMbldwVW5EdzlubHRTbkt1L0xvdSs0bEVGVUVi?=
 =?utf-8?B?Tk5KcmxCMU9abHN5NDhONGZGanNYbGUyampKNmxtUnA1dFlGdW1JSXdtNGdm?=
 =?utf-8?B?RVlYbldhbGFhNk9qQW1yZ0RXVlY5d1FZSmIvUi85OVlBZklWZnFNYzd4cEUy?=
 =?utf-8?B?SWJCVXRDN1BEUEU4cmRhdHVzYlpkS0FDRUJseGZKNXowTTBWUkVmWHRLcDZY?=
 =?utf-8?B?V1VybUdRdzZ0R3hXdlRaMXhub3AycGN1bW4yV1RndGpiMVhiZGxvSDhYQytP?=
 =?utf-8?B?QVkyMkRlUDhlT2NoM3N6Q0RBQzdVNHFqTFk1VWZONUVQTFNyS1FqUWt5cXpO?=
 =?utf-8?B?SXFpajhPOU1UTlUwZ1JHV2hRdnNBWEVKdFlRUFd6THFGQXAzSVhVNXlBbGhE?=
 =?utf-8?B?Z1U2T0dEUHZkcElLR041emFLai92dlJRQldLc3FZTERwNmFhVytxSUROVjBE?=
 =?utf-8?B?eHhhbk9iMGkwNkNJLzlDU3JRdGtacDZWKzNhUEhOcnM0MXRLaE1Gak1WU01y?=
 =?utf-8?B?NUJ5cjhMOTJEZFZlR3Yxc25GLy9aRHozU1FuYk43NHRIVHRZU3F1Zm1SMW83?=
 =?utf-8?B?YXE2ZjZKQlk4RytUSDNndHUzWk1mYitmWHRNU1JzVm0rWE5sQ3VoK1VoWFpr?=
 =?utf-8?B?d1R2TzV2MGlaSWVJNEdhMEdmWDlyNmIvamhQaTY2TGRnYS9memMydG0xbzV4?=
 =?utf-8?B?M25MVHNZOTJmRmdCdTZwUmc0bCt0bEFCcC9ZenlnaHpXYTM3SzVkdWxtWUdo?=
 =?utf-8?B?VTYzNmpqZkJ5ZVFOL1hWTk1xUXh6TDRTeTJZQ0ZGQ1ZoN2g3RXVxM2ZkN3Mx?=
 =?utf-8?B?dFVOZkZNVWZEL0pRczdMSVk2eGY0RDA4eTRGbU5vb29TK1RDcldUNkQ3Y3N2?=
 =?utf-8?B?Y3JnNktkSm5mNFJwNXBPbndUL0pTWXI3TEdrSUFpUGZKSzMvdFFYSW8xMDZi?=
 =?utf-8?B?ejBWckcxUVo4RnlqbFJjTU5xcmtkUitkS2VQYWlZbU1SdmNKajRSbjYxVHl6?=
 =?utf-8?Q?eSD7t5iVKkEiOD1jvYsigvY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Tmt5VmVhcmM1eC8xTDlhcmlwb2hQa09ucmRXOUdmSlhxd1pEd1hpUGFVRkxY?=
 =?utf-8?B?Ky9sWm5wZXBtUkZmemNzK25QYkwyaG15R2F4Q0d1SHZtWjZoWUtYVTJWNWxG?=
 =?utf-8?B?alQ4RWQzbk9aQTUxQ3FlQzc3OExvT0hxQkZ0b0Z2R0VueWRodDRoTGw1WXBs?=
 =?utf-8?B?UUt0THJKQzRwbnVyRFZ1K043aDF1SGMwOGRRTVlLS1UzNnVGQVNISUxaa3dw?=
 =?utf-8?B?OHE1eTZPdEhDUzFzdS9lSmUyTTdzcmRxcGJXTlQ5UkJiRk1aUDhTVzNPRndU?=
 =?utf-8?B?MDlJSlZTQ3Bnc2tRaTBob3JuR2dydmlUWXhTeVRWR2tGeWRWUDh1T2V5RUZV?=
 =?utf-8?B?aWhyVEFJQ0ZhemFrQXNJZ2w1UVBubldNUTNIcUY1aS9URCt0Z3d1SXYxSENI?=
 =?utf-8?B?OG93U1h1bnN3dmdJQzdUc3VoTVNvaEcxS0JOYnFXVDFtQm9kRkhLR1cweGlR?=
 =?utf-8?B?WjZWMm5hM0ZhRVFEOU1iaVNKMERoVmEvU3VvMTVLQWVhTjlLR1JLS0gxNHF6?=
 =?utf-8?B?TzBOMmVuUkVoSXdIeVQ1c2lNSkZpQ2hyQ3Q0OFptb1Q1aTdGNGFzZFNXcmZT?=
 =?utf-8?B?c1JpUTc0R016bmNwYzFqN01qUkh5TlR4M0o3bEtZT2hTUmxyQ1A2aHdGVjFk?=
 =?utf-8?B?bUo3VDBqZGdBYklVdncrME93TVR5bW1UWmR4OXN5YWFxUGNkZUVMQWpGNXpi?=
 =?utf-8?B?M1dta1BqRm4yd2pobUJjYTdReHp3N1BGWFllMkZEcThub3ZiQmZzQ0NydnhJ?=
 =?utf-8?B?UUR4TlhTaHFWUEwyUDc2aTRsbVZtSUNpN0FQMnQ4M2h4QmZLUWJBVlpyRzFU?=
 =?utf-8?B?T004SVo4VjQ5OFZnREhiczFKcEdZVFlsSFA0MnEycWRwMTRuR2VrZmRXNEJy?=
 =?utf-8?B?SFJHMnVSNmxwOXlleEZZT0hQbkZUOXVqYmNyc2V6TFhCdFk2VnpjR1E4ODBI?=
 =?utf-8?B?OXBINGNrNFQ1VlVYRjRybXd6N1E1eHRqM1VFL2ZpNjM5TU1VT1lnaVNwN2FZ?=
 =?utf-8?B?WTJTZ2xTcU1BSUU3ODlsZ09rR1ZVVEdlM1hyemxjK0pMbGZZNnk4d1VmWEhS?=
 =?utf-8?B?eFVrK09RN2V1a1Frd3RjZCtTeUlmaHVpelQ3bUlsZDVURjVvVVo3ZU9SUjV5?=
 =?utf-8?B?UkwxZmlFSXRVN3M3citRVFdOanZUcGFoVy9sbDBGdnBZNXZMcTU5bkJKUnh2?=
 =?utf-8?B?Mk1ITk55Q3ltNWFVSEtxUHVuL3JqbUxSUHhkRjdpNjZWQjkrZm80SFRkTXBI?=
 =?utf-8?B?RHFmaElkdXMwVkpJODlhZEZSdGNxK0xJVlRhaUo0S3ROTFRncmdmM25ic3g3?=
 =?utf-8?B?czl2VjdzK1d3RkZqanVCWUxYU0Q5ajBZU2xQQ0dpVmpHRHhCRGpnTUsyTm95?=
 =?utf-8?B?MlZqeHAvampHZmIvRG9kUVRSa2hqYTU0aUVLL0JtL3I1czY5M1NkcGYyV2NR?=
 =?utf-8?B?MGxEYndmY1k3aXF1b3ZoNEx2SjAyYWg2cTRWak9sQ0dxVGlLZkFwRjBxeWt5?=
 =?utf-8?B?QWhPQTNPUXV2MGMyYU5kNkkzT0d4cHl5a1pIQWhjNmJmVUdzcjJrWkRjdFdh?=
 =?utf-8?Q?P6G3pE1IDKjqYKE9Jh0/Ajg5c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2a6d9c-cca5-46ae-3452-08db1a5f92d3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 14:16:39.6055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9f5jTJOVY+fpQOCvlSO1NQnOHwsTnawwQEUzwtFV5kzUIZi54K347cw2qxd8nwV2i0c6T/DrOoGwrUxa7dUHmp16ivIVAKXnHaRkKCqi90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_11,2023-03-01_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303010119
X-Proofpoint-GUID: knPxqMAw3e-gIS7Ahiz6wbZuuKN_X1W8
X-Proofpoint-ORIG-GUID: knPxqMAw3e-gIS7Ahiz6wbZuuKN_X1W8
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/23 00:22, Sourabh Jain wrote:
> 
> On 01/03/23 03:20, Eric DeVolder wrote:
>>
>>
>> On 2/27/23 00:11, Sourabh Jain wrote:
>>>
>>> On 25/02/23 01:46, Eric DeVolder wrote:
>>>>
>>>>
>>>> On 2/24/23 02:34, Sourabh Jain wrote:
>>>>>
>>>>> On 24/02/23 02:04, Eric DeVolder wrote:
>>>>>>
>>>>>>
>>>>>> On 2/10/23 00:29, Sourabh Jain wrote:
>>>>>>>
>>>>>>> On 10/02/23 01:09, Eric DeVolder wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2/9/23 12:43, Sourabh Jain wrote:
>>>>>>>>> Hello Eric,
>>>>>>>>>
>>>>>>>>> On 09/02/23 23:01, Eric DeVolder wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 2/8/23 07:44, Thomas Gleixner wrote:
>>>>>>>>>>> Eric!
>>>>>>>>>>>
>>>>>>>>>>> On Tue, Feb 07 2023 at 11:23, Eric DeVolder wrote:
>>>>>>>>>>>> On 2/1/23 05:33, Thomas Gleixner wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> So my latest solution is introduce two new CPUHP states, CPUHP_AP_ELFCOREHDR_ONLINE
>>>>>>>>>>>> for onlining and CPUHP_BP_ELFCOREHDR_OFFLINE for offlining. I'm open to better names.
>>>>>>>>>>>>
>>>>>>>>>>>> The CPUHP_AP_ELFCOREHDR_ONLINE needs to be placed after CPUHP_BRINGUP_CPU. My
>>>>>>>>>>>> attempts at locating this state failed when inside the STARTING section, so I located
>>>>>>>>>>>> this just inside the ONLINE sectoin. The crash hotplug handler is registered on
>>>>>>>>>>>> this state as the callback for the .startup method.
>>>>>>>>>>>>
>>>>>>>>>>>> The CPUHP_BP_ELFCOREHDR_OFFLINE needs to be placed before CPUHP_TEARDOWN_CPU, and I
>>>>>>>>>>>> placed it at the end of the PREPARE section. This crash hotplug handler is also
>>>>>>>>>>>> registered on this state as the callback for the .teardown method.
>>>>>>>>>>>
>>>>>>>>>>> TBH, that's still overengineered. Something like this:
>>>>>>>>>>>
>>>>>>>>>>> bool cpu_is_alive(unsigned int cpu)
>>>>>>>>>>> {
>>>>>>>>>>>     struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
>>>>>>>>>>>
>>>>>>>>>>>     return data_race(st->state) <= CPUHP_AP_IDLE_DEAD;
>>>>>>>>>>> }
>>>>>>>>>>>
>>>>>>>>>>> and use this to query the actual state at crash time. That spares all
>>>>>>>>>>> those callback heuristics.
>>>>>>>>>>>
>>>>>>>>>>>> I'm making my way though percpu crash_notes, elfcorehdr, vmcoreinfo,
>>>>>>>>>>>> makedumpfile and (the consumer of it all) the userspace crash utility,
>>>>>>>>>>>> in order to understand the impact of moving from for_each_present_cpu()
>>>>>>>>>>>> to for_each_online_cpu().
>>>>>>>>>>>
>>>>>>>>>>> Is the packing actually worth the trouble? What's the actual win?
>>>>>>>>>>>
>>>>>>>>>>> Thanks,
>>>>>>>>>>>
>>>>>>>>>>>          tglx
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Thomas,
>>>>>>>>>> I've investigated the passing of crash notes through the vmcore. What I've learned is that:
>>>>>>>>>>
>>>>>>>>>> - linux/fs/proc/vmcore.c (which makedumpfile references to do its job) does
>>>>>>>>>>   not care what the contents of cpu PT_NOTES are, but it does coalesce them together.
>>>>>>>>>>
>>>>>>>>>> - makedumpfile will count the number of cpu PT_NOTES in order to determine its
>>>>>>>>>>   nr_cpus variable, which is reported in a header, but otherwise unused (except
>>>>>>>>>>   for sadump method).
>>>>>>>>>>
>>>>>>>>>> - the crash utility, for the purposes of determining the cpus, does not appear to
>>>>>>>>>>   reference the elfcorehdr PT_NOTEs. Instead it locates the various
>>>>>>>>>>   cpu_[possible|present|online]_mask and computes nr_cpus from that, and also of
>>>>>>>>>>   course which are online. In addition, when crash does reference the cpu PT_NOTE,
>>>>>>>>>>   to get its prstatus, it does so by using a percpu technique directly in the vmcore
>>>>>>>>>>   image memory, not via the ELF structure. Said differently, it appears to me that
>>>>>>>>>>   crash utility doesn't rely on the ELF PT_NOTEs for cpus; rather it obtains them
>>>>>>>>>>   via kernel cpumasks and the memory within the vmcore.
>>>>>>>>>>
>>>>>>>>>> With this understanding, I did some testing. Perhaps the most telling test was that I
>>>>>>>>>> changed the number of cpu PT_NOTEs emitted in the crash_prepare_elf64_headers() to just 1,
>>>>>>>>>> hot plugged some cpus, then also took a few offline sparsely via chcpu, then generated a
>>>>>>>>>> vmcore. The crash utility had no problem loading the vmcore, it reported the proper number
>>>>>>>>>> of cpus and the number offline (despite only one cpu PT_NOTE), and changing to a different
>>>>>>>>>> cpu via 'set -c 30' and the backtrace was completely valid.
>>>>>>>>>>
>>>>>>>>>> My take away is that crash utility does not rely upon ELF cpu PT_NOTEs, it obtains the
>>>>>>>>>> cpu information directly from kernel data structures. Perhaps at one time crash relied
>>>>>>>>>> upon the ELF information, but no more. (Perhaps there are other crash dump analyzers
>>>>>>>>>> that might rely on the ELF info?)
>>>>>>>>>>
>>>>>>>>>> So, all this to say that I see no need to change crash_prepare_elf64_headers(). There
>>>>>>>>>> is no compelling reason to move away from for_each_present_cpu(), or modify the list for
>>>>>>>>>> online/offline.
>>>>>>>>>>
>>>>>>>>>> Which then leaves the topic of the cpuhp state on which to register. Perhaps reverting
>>>>>>>>>> back to the use of CPUHP_BP_PREPARE_DYN is the right answer. There does not appear to
>>>>>>>>>> be a compelling need to accurately track whether the cpu went online/offline for the
>>>>>>>>>> purposes of creating the elfcorehdr, as ultimately the crash utility pulls that from
>>>>>>>>>> kernel data structures, not the elfcorehdr.
>>>>>>>>>>
>>>>>>>>>> I think this is what Sourabh has known and has been advocating for an optimization
>>>>>>>>>> path that allows not regenerating the elfcorehdr on cpu changes (because all the percpu
>>>>>>>>>> structs are all laid out). I do think it best to leave that as an arch choice.
>>>>>>>>>
>>>>>>>>> Since things are clear on how the PT_NOTES are consumed in kdump kernel [fs/proc/vmcore.c],
>>>>>>>>> makedumpfile, and crash tool I need your opinion on this:
>>>>>>>>>
>>>>>>>>> Do we really need to regenerate elfcorehdr for CPU hotplug events?
>>>>>>>>> If yes, can you please list the elfcorehdr components that changes due to CPU hotplug.
>>>>>>>> Due to the use of for_each_present_cpu(), it is possible for the number of cpu PT_NOTEs
>>>>>>>> to fluctuate as cpus are un/plugged. Onlining/offlining of cpus does not impact the
>>>>>>>> number of cpu PT_NOTEs (as the cpus are still present).
>>>>>>>>
>>>>>>>>>
>>>>>>>>>  From what I understood, crash notes are prepared for possible CPUs as system boots and
>>>>>>>>> could be used to create a PT_NOTE section for each possible CPU while generating the 
>>>>>>>>> elfcorehdr
>>>>>>>>> during the kdump kernel load.
>>>>>>>>>
>>>>>>>>> Now once the elfcorehdr is loaded with PT_NOTEs for every possible CPU there is no need to
>>>>>>>>> regenerate it for CPU hotplug events. Or do we?
>>>>>>>>
>>>>>>>> For onlining/offlining of cpus, there is no need to regenerate the elfcorehdr. However,
>>>>>>>> for actual hot un/plug of cpus, the answer is yes due to for_each_present_cpu(). The
>>>>>>>> caveat here of course is that if crash utility is the only coredump analyzer of concern,
>>>>>>>> then it doesn't care about these cpu PT_NOTEs and there would be no need to re-generate them.
>>>>>>>>
>>>>>>>> Also, I'm not sure if ARM cpu hotplug, which is just now coming into mainstream, impacts
>>>>>>>> any of this.
>>>>>>>>
>>>>>>>> Perhaps the one item that might help here is to distinguish between actual hot un/plug of
>>>>>>>> cpus, versus onlining/offlining. At the moment, I can not distinguish between a hot plug
>>>>>>>> event and an online event (and unplug/offline). If those were distinguishable, then we
>>>>>>>> could only regenerate on un/plug events.
>>>>>>>>
>>>>>>>> Or perhaps moving to for_each_possible_cpu() is the better choice?
>>>>>>>
>>>>>>> Yes, because once elfcorehdr is built with possible CPUs we don't have to worry about
>>>>>>> hot[un]plug case.
>>>>>>>
>>>>>>> Here is my view on how things should be handled if a core-dump analyzer is dependent on
>>>>>>> elfcorehdr PT_NOTEs to find online/offline CPUs.
>>>>>>>
>>>>>>> A PT_NOTE in elfcorehdr holds the address of the corresponding crash notes (kernel has
>>>>>>> one crash note per CPU for every possible CPU). Though the crash notes are allocated
>>>>>>> during the boot time they are populated when the system is on the crash path.
>>>>>>>
>>>>>>> This is how crash notes are populated on PowerPC and I am expecting it would be something
>>>>>>> similar on other architectures too.
>>>>>>>
>>>>>>> The crashing CPU sends IPI to every other online CPU with a callback function that updates the
>>>>>>> crash notes of that specific CPU. Once the IPI completes the crashing CPU updates its own crash
>>>>>>> note and proceeds further.
>>>>>>>
>>>>>>> The crash notes of CPUs remain uninitialized if the CPUs were offline or hot unplugged at the 
>>>>>>> time
>>>>>>> system crash. The core-dump analyzer should be able to identify [un]/initialized crash notes
>>>>>>> and display the information accordingly.
>>>>>>>
>>>>>>> Thoughts?
>>>>>>>
>>>>>>> - Sourabh
>>>>>>
>>>>>> I've been examining what it would mean to move to for_each_possible_cpu() in 
>>>>>> crash_prepare_elf64_headers(). I think it means:
>>>>>>
>>>>>> - Changing for_each_present_cpu() to for_each_possible_cpu() in crash_prepare_elf64_headers().
>>>>>> - For kexec_load() syscall path, rewrite the incoming/supplied elfcorehdr immediately on the 
>>>>>> load with the elfcorehdr generated by crash_prepare_elf64_headers().
>>>>>> - Eliminate/remove the cpuhp machinery for handling crash hotplug events.
>>>>>
>>>>> If for_each_present_cpu is replaced with for_each_possible_cpu I still need cpuhp machinery
>>>>> to update FDT kexec segment for CPU hot add case.
>>>>
>>>> Ah, ok, that's important! So the cpuhp callbacks are still needed.
>>>>>
>>>>>
>>>>>>
>>>>>> This would then setup PT_NOTEs for all possible cpus, which should in theory accommodate crash 
>>>>>> analyzers that rely on ELF PT_NOTEs for crash_notes.
>>>>>>
>>>>>> If staying with for_each_present_cpu() is ultimately decided, then I think leaving the cpuhp 
>>>>>> machinery in place and each arch could decide how to handle crash cpu hotplug events. The 
>>>>>> overhead for doing this is very minimal, and the events are likely very infrequent.
>>>>>
>>>>> I agree. Some architectures may need cpuhp machinery to update kexec segment[s] other then 
>>>>> elfcorehdr. For example FDT on PowerPC.
>>>>>
>>>>> - Sourabh Jain
>>>>
>>>> OK, I was thinking that the desire was to eliminate the cpuhp callbacks. In reality, the desire 
>>>> is to change to for_each_possible_cpu(). Given that the kernel creates crash_notes for all 
>>>> possible cpus upon kernel boot, there seems to be no reason to not do this?
>>>>
>>>> HOWEVER...
>>>>
>>>> It's not clear to me that this particular change needs to be part of this series. It's inclusion 
>>>> would facilitate PPC support, but doesn't "solve" anything in general. In fact it causes 
>>>> kexec_load and kexec_file_load to deviate (kexec_load via userspace kexec does the equivalent of 
>>>> for_each_present_cpu() where as with this change kexec_file_load would do 
>>>> for_each_possible_cpu(); until a hot plug event then both would do for_each_possible_cpu()). And 
>>>> if this change were to arrive as part of Sourabh's PPC support, then it does not appear to 
>>>> impact x86 (not sure about other arches). And the 'crash' dump analyzer doesn't care either way.
>>>>
>>>> Including this change would enable an optimization path (for x86 at least) that short-circuits 
>>>> cpu hotplug changes in the arch crash handler, for example:
>>>>
>>>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>>>> index aca3f1817674..0883f6b11de4 100644
>>>> --- a/arch/x86/kernel/crash.c
>>>> +++ b/arch/x86/kernel/crash.c
>>>> @@ -473,6 +473,11 @@ void arch_crash_handle_hotplug_event(struct kimage *image)
>>>>     unsigned long mem, memsz;
>>>>     unsigned long elfsz = 0;
>>>>
>>>> +   if (image->file_mode && (
>>>> +       image->hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>>>> +       image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU))
>>>> +       return;
>>>> +
>>>>     /*
>>>>      * Create the new elfcorehdr reflecting the changes to CPU and/or
>>>>      * memory resources.
>>>>
>>>> I'm not sure that is compelling given the infrequent nature of cpu hotplug events.
>>> It certainly closes/reduces the window where kdump is not active due kexec segment update.|
>>
>> Fair enough. I plan to include this change in v19.
>>
>>>
>>>>
>>>> In my mind I still have a question about kexec_load() path. The userspace kexec can not do the 
>>>> equivalent of for_each_possible_cpu(). It can obtain max possible cpus from 
>>>> /sys/devices/system/cpu/possible, but for those cpus not present the 
>>>> /sys/devices/system/cpu/cpuXX is not available and so the crash_notes entries is not available. 
>>>> My attempts to expose all cpuXX lead to odd behavior that was requiring changes in ACPI and arch 
>>>> code that looked untenable.
>>>>
>>>> There seem to be these options available for kexec_load() path:
>>>> - immediately rewrite the elfcorehdr upon load via a call to crash_prepare_elf64_headers(). I've 
>>>> made this work with the following, as proof of concept:
>>> Yes regenerating/patching the elfcorehdr could be an option for kexec_load syscall.
>> So this is not needed by x86, but more so by ppc. Should this change be in the ppc set or this set?
> Since /sys/devices/system/cpu/cpuXX represents possible CPUs on PowerPC, there is no need for 
> elfcorehdr regeneration on PowerPC for kexec_load case
> for CPU hotplug events.
> 
> My ask is, keep the cpuhp machinery so that architectures can update other kexec segments if needed 
> of CPU add/remove case.
> 
> In case x86 has nothing to update on CPU hotplug events and you want remove the CPU hp machinery I 
> can add the same
> in ppc patch series.

I'll keep the cpuhp machinery; in general it is needed for kexec_load usage in particular since we 
are changing crash_prepare_elf64_headers() to for_each_possible_cpu().
eric

> 
> Thanks,
> Sourabh Jain
