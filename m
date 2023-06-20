Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8767367BF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjFTJ3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjFTJ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:29:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDCEA3;
        Tue, 20 Jun 2023 02:29:45 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35JNRLMW004584;
        Tue, 20 Jun 2023 09:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=opq4Wrmo33nYhK7OAC5qfTDM0lYixGpPO5+1+727R58=;
 b=YySElkxF7MZ3f0VrppVkx+E0oLYzNr5MigK8exeU8J1+cNxlcPnm+EbkG5Ox0ggpEurz
 rncXxxlwV50YjJeh9QPlXTJbS4VQdOAZZx5O73dB61BXsBiKlppjKbWJ+ch3p41UgIsE
 8U6X52WrNIMrs5kKgPDDymg0fmOOJJ3EZ/i1/+y/H4OLel07EPLITyC71xLsvpgS9nvl
 pYfAAQtArXNv5RnIrl4GbuTTRPLTUYy8Zti3AUvGaWaGO/7P7YKi3WH5ASHjmjoznzKJ
 3wztpj5L7RgG/hSoAIRWIpVUWnKOC2NgtzKSNHQYidoMp8rrIafuakOi2o++YA2blHeu 9Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94etm8d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 09:29:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35K9DgfI005790;
        Tue, 20 Jun 2023 09:29:06 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r93943uy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 09:29:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvDdC2h/re/4xw1zxrkICEy+zLLOIfrCR93Nn/7mLHDOYTcFm2sQaRq6ebJxQbGX49lw7TJ5bVVIy+E2BOl2kcKwSOcb2liRfrRy3rmxZ8ECvlaESZfXZqb60PiFvUrbRsFOSV0lj7BMFzwedF/zzaxyvymDhrdlQ4inOKSm4lSuwn65tUBB6maiVDI0EFmoCKF3R/2TWPgZFhJ2V0KVm6uL/wVGxoHUvqceNIhQn4/LCGPhjYJxMYyGNuXeDLNDRjEOSCGKOeiT15Tjj0jcI/ruMRokFqdeFjBqp0bcqFW7JmYdT9hSkugDpjK9a/J34FdhEoeWNMFIsltD/x57oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opq4Wrmo33nYhK7OAC5qfTDM0lYixGpPO5+1+727R58=;
 b=jNnw0gN6r0KpTmfTKlNSq3HwfGM3KxUQs650rayJ8qgqKf6A+v4iVxTx2CYOUBxqsJr0kW6WKn795gERxvIWxHwVh5ePTLMRGKETxgMYC65qtQcpTOA5qIKlrkedfPRKMhXBEL4Nea3VNOu5bxYehqNlmP7EgV+/avhKK/Vm1gNwT1pOajmnwBQuTsf9fT75ZRWRVlSDeqMmNloJom3D06SgndY2At2VXrMuZqAVe1WTwrYXxU4oP8r1NNk+D6qejUZbfuCC5TVC7Yz7SJ9EgtaXHe9txArSHPHtC4/XN9hqwkKW1G7N6tsu+tIFGTbqogvKRCoer6LaZSZ+GwMxkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opq4Wrmo33nYhK7OAC5qfTDM0lYixGpPO5+1+727R58=;
 b=B5D3Xdtann2pIC1FkMKKjFKRJdjy5dTPDCqrVf57yUfV6IllSzCIJYmgDYpu0jJ1tY5s1Glv/bgNzcUDk2Eu0FAJvaXOorsxaWNDmZI9nMDhX7uKB9D5PhZ2yz+2gObhmGQLLmIzP2B8sQiDADckxbnJtJNAh1sLo88YuIMJkBo=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SJ0PR10MB4461.namprd10.prod.outlook.com (2603:10b6:a03:2d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 09:29:04 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::9bee:4705:4313:2532]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::9bee:4705:4313:2532%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:29:04 +0000
Message-ID: <9761ae4a-49b9-22c7-a44e-553cfe1990f4@oracle.com>
Date:   Tue, 20 Jun 2023 14:58:49 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 4.14 00/32] 4.14.319-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20230619102127.461443957@linuxfoundation.org>
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230619102127.461443957@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0012.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::10) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SJ0PR10MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: 034a49c0-a590-48f2-b4b8-08db7170ca2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xh11OtpD+W/bN7LPjk8VoHHDoejJY71nHCOploGMEPI2u9uYcHcIcEB5iIs2gp9S75FrwyfMZWCN0JsqrmCV7TtVtxOZiDRdSKT7ndtIs3MGwp399Rj+ZLZVw2GRJJ2+48GCjHuYYNWKGUXv4A9H+vCpesfiSkkiRh/KrfUmPtxHFBvuaIeNnquhVD5KC+iwW21JDpiv0lxoJtQsyMM5hVGfdsCIuMJmPiR5Lg6uTiDuYJtiLL/o3JBtFibQBoFmtv964FkozX8FQhctcwkn/5aPO1kq01KL1aZgbxk2w523UOGWalyuBsBALjdBZpUhMzhySDFdBj0ECBfxV44OhyAt3s9+Bu/DrSWR1dPXyNDy4HZ9Tria+FicJ13hbHCz2lPSvB/CwRQAVV9WuAJMDVgttsJXEB2WQFVtUi+3pYfAcDuUxL75/BFceHU1e4UTkyq7Q5gMIWgGQLtLenkeYA7aLSzjNIoeCSzJsBWyMdausgrSG86uM4a927oHGS2C7aGdhgfG8+Ek1H5yInO+3ncwzRiJZtXrcIxAGsZbWPqjh3KNLw4jg1c0zCbbkSblPngdg1a90Yei4z/RaVCkdu1tOSdpzBfrkofI9iNUliyaniHdDFP0N5+MEBNNQSbplZMrDjp4nXjBDUyzJ2ExXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199021)(5660300002)(31686004)(66946007)(4326008)(66476007)(66556008)(316002)(36756003)(4744005)(7416002)(2906002)(8676002)(8936002)(41300700001)(6486002)(86362001)(31696002)(478600001)(38100700002)(6506007)(53546011)(107886003)(6512007)(26005)(186003)(966005)(6666004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFRyVjM4amhHVjlZZTk4OTdpdkVHNjRlWmtLeUFwdXUwN0pBSW1lV3ByS2J4?=
 =?utf-8?B?OTVkdlkwLy91VXRJTVA3c2tGb0xSZXRRRmE5K2xOck1Cc01EM1FQWStmQTBn?=
 =?utf-8?B?YVBqYlRYaSt0cUdSZ1F4RDVLSGZ4cjNoQ2NXOEtJVUt1OXdFbDJyaXVVQ01p?=
 =?utf-8?B?aHdHREhaRTNDTHZ1aXoyY0FiZUR0aEl3dXJjV2pCbEwwVGZ2M2JhOWViUkhG?=
 =?utf-8?B?Zk1tam9LcC9kZitRSDJOMjc1c2tQUnRRNE5uR1BtekdWWXhiT2VlRE13QVBj?=
 =?utf-8?B?KytaVWdzaFRacUJiZnNPckhnZlk5L1oyOCtKRXNDZXlpZlVNdjllczQvVzF1?=
 =?utf-8?B?Q0lCbndCYUQzSnh6cWNPeTVJTEkzOW1HMVNRc3ZGVk1DNG5yOVlHYm5DbTBW?=
 =?utf-8?B?elB1Y04yT1JBeTA5d1BWUUd1YmRnUjNQazFadVhSdStTZ2l1eEF4S2NkMDhL?=
 =?utf-8?B?QjJ1blBCYmlUZUdmc0NGMXR1RHV3UEVuRkZDVllZTDhRbWN3N0JEMFBmNG1J?=
 =?utf-8?B?Y0swbDY0Z2JJL1FOZ2FjOWtBeUZnZllxcDZlckh0a29mZ0R1SmJtVGQ4MGVl?=
 =?utf-8?B?VDY1NEdGbzhObkdGMURoY3U5eEJ4SVZXNmhQWElTUWhGd1RlU1dXbXFCdkF2?=
 =?utf-8?B?Y3hpa1pqNjFqU21vZFErQ1VlM1gwS0NUd0QvdW5jRzFYUVNQWkZnRWZIZGdR?=
 =?utf-8?B?WGE1M2NmZ1ptblE2aVpKcHBYQUtVUnZRSER0c0lkdmRsT2x6cTJ6eDVUdmJa?=
 =?utf-8?B?S2s1Q2h3WWtaNWhwYnNOQm1Qa0NFU0Z4d25FZS9CMUI5Z1duUEg5SE1WaHR1?=
 =?utf-8?B?L2VyVHV4c2k2QjV4UmZ0QWxVQ2VaeVkvblNYY21ISXRJYkVSbU1iTkk1SEdD?=
 =?utf-8?B?L3lCMnVza0s0QUVwQXpuV3JacWIxZHBoTXFvVGhyQWRxbC9VeHl4TXozMU1L?=
 =?utf-8?B?U2hRbnFkamdmai9lREJCQ0xpVmlQVmdTYWszaVplRUlBM3hjcWlpY1FqWVN3?=
 =?utf-8?B?R3gxUmwwMnJPTGZ5Njl3a1plRkp5eWVyZ1FXOVE0SVNXNHV4S2I1cmlBb2ww?=
 =?utf-8?B?YmlWRUJidlNYdE5qT21JYmVEUHk2Vk9vZlhvbS9hejBJVzh4OXBNY3Y3K1dp?=
 =?utf-8?B?WGQ3cHZFdlFzY0o2OHpwODlzNk1qMkVBckJuekxKTVd5QzYxbmRycmFOaUtS?=
 =?utf-8?B?a1gwakc1WGJqY29NdmJiTnNvRDQ5TlZ6UlkyNzNEUndPN2dsK0ZZQk80VlBm?=
 =?utf-8?B?VS9vNWt4VFhoeHhlaGpBQVN4MHBCZU1ZclN0RzY0bURBc2dadDNRWEFDVlNS?=
 =?utf-8?B?eU43MlFXd096NXhhbkFtcVJHNE5JdksxTVlXWk12Z3lYanh5RGNJcm9wcFZF?=
 =?utf-8?B?MVFyUU1EWHAyQUVsdW1Bb1pNQXczaHY0VDh6ZWJZeGtqV0lnVW1KazZpSzh1?=
 =?utf-8?B?d1RyUmJ3dEIzeWFoWnNIaXdMOFJkQmEwQ1hkVUZrN0JDTGN5eUxXbGF2Y0xu?=
 =?utf-8?B?NmdoUWZ2VUtseXJDZjRCOEh3U29BSHMrNEt1Nm1uSEhjS0tCY1lwTytLMU9t?=
 =?utf-8?B?a2h6MTAyZENPTDYxU09RUkVMUjY3MW01ZW1DOTJ4M3NhcloyR1ZsR1pQOGc4?=
 =?utf-8?B?a0tEZ1FFa1E2Z1pxa2sxU010ZWxSVG1QWGFaMG12dSs3WmlJbUFseFBlRncy?=
 =?utf-8?B?YkUvTHlHYng1dG5DQXAwTFkwb3kyZHdsZTA5aTgvcVRUbjV1QVp1cEIwdHZv?=
 =?utf-8?B?RFBQaEVXVW80VE91RzN2NkZhM3NlcEJXNDVGTnhkM2p5ME92R05ZMHFtbER5?=
 =?utf-8?B?M1JIWldFVFpTVG4za0M5VEg4ZjBZNWVONHlGZVRtelp4algyU2dkTm0yNWZO?=
 =?utf-8?B?OUxaTUJRdW5ubXRpRUVaL3VrWnY3ZEdmLzE0a3RBNit3SVcxQ3NFNHoyaXZ0?=
 =?utf-8?B?MkcyRHliS3ZsYnVNN0ZPdXlnNm1jT1lOdnJKU1RxdjRVcklROGxQemY3emdZ?=
 =?utf-8?B?WExVSUo0NGlzUVF5UUREdUtVQlhnMGNISXpIOHNhekdFQkwzN0FiVzVWbldw?=
 =?utf-8?B?a003bUxCRmtaU1NCelZ5UlUwQVFUNGx5RHJUcVNDTHcxVlBESVFCaFkvSHo2?=
 =?utf-8?B?TVRCWHJ0UnM3UGZBbStvSW5iTkdOTW5DeDdnWENZMDFrVTN1RHFCU0NzVGN0?=
 =?utf-8?Q?kEOe5miayBSej7Jc3jR4VQ4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aXg0QUJocXk3eWY3am1SMm15aHB6dnRNYiszcW9WVTYwV0E5MU5lVlFPemlp?=
 =?utf-8?B?NDVrNTZyTnIxTUJOWFJyWGhQNDM5dEg4WjMxVzgrVEtmYTBwQXJkclYzNmRE?=
 =?utf-8?B?ZzhIUldBa3BabFJJNjZ1cDl5MWRyYlczQytCeDdTbG9BeWZ2NmI0SHdhSWhK?=
 =?utf-8?B?aFZHL242UzR5VVA5TlpOekZ1WHhReGV6Q2tuMlhZbll0TTBZbkVTVFIwN3Rr?=
 =?utf-8?B?clNsVks2a0RVVlRBdllPc09sdVVxQU4yZ0dwamZCck54Z2gyWG8ydU5WdFgw?=
 =?utf-8?B?dUNkZnB4bmRWZTVLMG5UWWJrUWtSa2FUS1Y2aWVkUzZwTjg3T2M2bDVTRXhJ?=
 =?utf-8?B?TVJQVzVlbHNlNXU4b3VMalFmdjBFUVQyUGJBZFFkVjZQQWlSKytCMEhJTzZJ?=
 =?utf-8?B?bk5FbDErc1o1TFo1emNTRFE0TVl5VUtJS0xxK1MyY3JGZitJS09Zc3loUE5X?=
 =?utf-8?B?Qnk5VnZFVGk3TW15QVdmeWNHcEdnZG8xUXJhWVplUUUwb3JzZHlLelRCUWxV?=
 =?utf-8?B?anlzSUR1MFNJQmVmaEtLN3BCLytwbWNUVndEL2s0cVUycndQU1h3UjY4UVdY?=
 =?utf-8?B?L2E3TmZQQTBYQzZMMkJocEpmbVVhcUprQzlSdFRISVVmSVZodkt0V1hRTkc3?=
 =?utf-8?B?MWlrVWMyR0gweFQvRkpwZkFRbnU2UmtpMGZ0WDlPU0ZIV3VsUlc3NjlrSTZy?=
 =?utf-8?B?OExYd21oSHA3d0JwY1k5Mmx0dTFxMGhWSitycElML0hGNTlJdWtHRDdOd3Yr?=
 =?utf-8?B?NCtIYXAxeXFkcXhWY2ZLOGdiL1YyMi9ZSk1LRVRCUTBhZHExb1RFTWxNYlFI?=
 =?utf-8?B?VitRTXR5S3Y1SEl4UG15SjJuRnl6c0RuZmFQK2JBUTNmNk1WNFUyZ1R6bUMz?=
 =?utf-8?B?YTNIS25wTnVET2hRVVZZTjkvdEtCYkhuaDJXcmI1TVhSVTQyT2Y4SlZ4WmFn?=
 =?utf-8?B?Sm5TOUdWWEVraTB0Z0creXJvUC94OUtWbkFZL3VHTHFxR3NCczE1WVJoWlBJ?=
 =?utf-8?B?VHFsOExoakxhSVBzVmJEU2RBQ0JLYlVsTUVoMm9oTE9abkZ1TFNmUkltTzNh?=
 =?utf-8?B?Y3k4a3lFZlhLR0VaT2ZISXJTS0RxVGg4QXI2SEJ0REN4Z01UQjhyaThvOUZ6?=
 =?utf-8?B?dlhad3FvQU9RREFVWDNEMzdMd0oySlZ3YzFDNDBsYzZNVXZ4VjBBemZOMlpS?=
 =?utf-8?B?TDhwaWlvUC8wM1Zjd2tpZFA0R2NpL24vNGdvMUx6ZVB6aTZIWVhDbTljUGpL?=
 =?utf-8?B?TUE1VkJ6Zm1yTVdlRENrdy8xaW9ta2FmM2xyMkU5Vkt5OXhVSFZjL1pobHFY?=
 =?utf-8?B?VEgwN2lKRW5mcm04bU0rcDU3MDh1anRXZjF3RW11bjR0U3ZTeUxNQzhUSFV3?=
 =?utf-8?B?ZTVlNDMxdllDcDdTc0ZRSjU1S3B4M25VVGNwQVAyQXB2M0FwMXBuZU84RDZv?=
 =?utf-8?B?SXRqdkQxOVVDbzdlTC9NdDZDdVlmK1ZLQTlZN01GanF4RmhCZm52VXVDalgz?=
 =?utf-8?B?dG5FQ3c0djBUa1k0SFpTWU1GU25ubGdkRkZvOEhPcmg0Y1VUT2NENURJOHZm?=
 =?utf-8?Q?gX3H8In4Pb4tLJYyyJMcBtiMJPwqBu1I29PKnB9le8j6T3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034a49c0-a590-48f2-b4b8-08db7170ca2d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 09:29:04.7593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFRpQqBdhwlhgYlZsK+e/JkaXjlPu6AqSN54CB1rZAP0/9utY6VMLQaJKDOG4/vG13xRTwG03l2Bi8TQgv3778GqtBbY716XFa8EHY+UuDTBRKmeCmS+uH/NvndQbfOl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4461
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_06,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200084
X-Proofpoint-GUID: 1BCujbk3bJiljq7CKThqXdbehF5jvswo
X-Proofpoint-ORIG-GUID: 1BCujbk3bJiljq7CKThqXdbehF5jvswo
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 19/06/23 3:58 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.319 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 
No problems seen on aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.319-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
