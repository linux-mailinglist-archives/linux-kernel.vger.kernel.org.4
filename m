Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35C7707721
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 03:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjERBEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 21:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjERBEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 21:04:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A2830F3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:04:30 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIGomr024508;
        Thu, 18 May 2023 01:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=TI7/vKcs0jYMKtdMqd+jeLsNmgWrmptsvmkENJYGQNI=;
 b=3i2shYTp7QB7x6QB66vrTaKPxZHiQmqp0fnrluq1BnbXrd4Tgm9yELa4m9UmSQ+7Dds3
 +Q5VPSh1QuoLXv3moUFzPoDgufJHhW8Sdlboc+QvbO30LfaCSOriPSD8doobAonpEhgD
 NZfbmTqbGKfnjybsRw0zqNjkBQia9HcV9Ndg0o916KFHDgRedOMGj/l7v2joGowPQfMl
 bBJIjpC+YKvmsSopy4HzcEqBgGhP8YCunb3YKzbDioy1XWTFUDMKUIAZjCHl2DQQPVcy
 oh8JbRAJOJySiA0GP1TQdJbLesrGbph91jVcM1GaMrqVDfSLb1MZCqeOtx4/j5MF0diW kg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxwphf8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 01:04:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HMeOiI025080;
        Thu, 18 May 2023 01:04:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj1064uu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 01:04:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvpW4jC0nZ72f5St3eiGfdu/nuir+GQLK81smGmWgBQZCUmftnWj/2fJyOpLtJYMhlptIWETbEdB1XkA+x3k31d+NpczBS3Cdc8QHWzKQ3qcr4BdIyiBO36wDDErSsenPIbHcevEBnuRtmqtkw4OPHji0hAzJ7cDk/sYshF1FokWCZF6JUnRpcf31NtbN/+odYMhmnWZ28Mzv4BveuGz0Q5RJVS1lNYYKIaGySOEA5uEn4oBB8PHly6caQRnJ1zzRVKO17HQ0RwV/0J3SaUMEyfDJ3aU2dwgdv29fvJp3YJQRcuKq41Vxgyt0/1EfWCJOIKEmXnOdt2tcJO1QBMR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TI7/vKcs0jYMKtdMqd+jeLsNmgWrmptsvmkENJYGQNI=;
 b=CYqo3uutT0t+A42mkslZ9mL8vvbisXOw4NHQI2v+XyLQFm/OyHWJylQWQFQI2qh9mPkEtyeVjpOk0Ijv6FZky/Xpsu7Ujb37uaY1Bivl5752/LrCiwSOC5c5OZFrWlHVkYxd0+jVIr3wFLjHCbzwGnRoJjhFNjhLRHwj/GkDoxls/5klryFiTZKjoLSHmaIbpAxyVuraYGNhleHFNnx5u5CJx4wItv97UM0aefsll1YchKZ7iQWyPXtGDMOnd8b7nwzi3gPmy88O7MckCPTJCanZtyNeBvrFuoSJBDPf/iVMmdYr94hB+OM7WICFzWgeoIBW4rGLgVh8LOLSDvbjKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI7/vKcs0jYMKtdMqd+jeLsNmgWrmptsvmkENJYGQNI=;
 b=TQt8lEb3cZj6qGLX6S4ZW7tQxND1sjvLDFoT36jd/NuB+FYKT2YL1enlL/7ifxLtBHsHIQ3DPAYTm9XVlhnTB/ynYZcs1UyiQj+K5zlWrq25DnhX3ef0IonIP1TkSUCArujPhzeqkQnEfMCsjHP3sH0ea9pVmskB8bGn/5GTdRY=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SN7PR10MB6594.namprd10.prod.outlook.com (2603:10b6:806:2aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 01:04:13 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 01:04:13 +0000
Message-ID: <4a0506c0-ebf5-8676-6082-22ddb45dab67@oracle.com>
Date:   Wed, 17 May 2023 20:04:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC PATCH 8/8] fork/vhost_task: remove no_files
Content-Language: en-US
To:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-9-michael.christie@oracle.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230518000920.191583-9-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:610:5a::11) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SN7PR10MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b2d0f4-07c6-4160-3677-08db573bcb78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6y34dbaglhK7sHZMwTOQe6Y+xmONTADj+xEg9S/lcZDliXKZut2cH3pQgEvor6UQFrdwJkJoRT0m2UZdmOpgMJwOMoy0HLd7ZEjSWTdBX1G4SGT1FgSSg03uAcwwgMkGS3hVyb7eaagZTGJrCFCRJMK1kviIzk7ouBjnoN7E3WGtjatj9RpVpyVDzsrDrx6mdbSGJEWHuxiRxehvy9h5OYOYvnjJkTxtD9QCCWBY3B1VTFao2N1CwhHzoDbDmll2AEVJu7S6mmVdRhDxyMXY5OuIy7KVu+gLOXWcDSKCnWAkg+sTonAldM0yTNaYqjIFg8AgYLa4zRDSsijHUaYa7RQMfp3ITr/eTfRr86OSOk9xmbwwi+/AGNnWh/kijXrkJwrvnM/pqgBZ+rxsH7ZHVPcwPW0g8agHW4wfybxWyd4SHsDaId7eFFFaYyzp/51Im06ofY1UNKqOjEBJetlfGjbC5b/utbljQOeSAh3kLU3cuQAfm6NaFeRKdwCOtEaNg4ixLOkkQxiT/YGXRUwz1oDocb2pCXGwPOM3QdZbxk+ugQwhQX3WwJZ1ZkYB4iR+9qoc/nLGcBQu1SNNhK2yQG5f/n2LdEA3Gqo/LTp2OPD7ETJNMr9SISNtQwwfJ4GEc7QvMfzp8ybNDvUDzgZEXZMgC2xRQjt0qeDlLMNLCyo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(31686004)(36756003)(2906002)(7416002)(8676002)(5660300002)(8936002)(558084003)(31696002)(66556008)(41300700001)(86362001)(66476007)(66946007)(6486002)(478600001)(316002)(921005)(6506007)(53546011)(6512007)(186003)(26005)(2616005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjJvdDZwWGRJS0x1ZjhNL3YzQUtRMFhaanFBbHlkM2ZTYmxRcGFDSzQwbW9s?=
 =?utf-8?B?T0laNnBWV3YyKzZYYlMzVFpRelNQWG5lb0p1c2NjUW1KWUhWWUdLSkpvOXM4?=
 =?utf-8?B?ZUhhZGRRRU94T3V4UVE0bDF0UUJGME92emNORXFPaVZxYlZkc3JsNGFvTWpW?=
 =?utf-8?B?Ymwzc1RhUFNYYjcxVUxhOUE1YWh4RFdFcnVDbXZrblg1ZldvZkxNNFIzQVZK?=
 =?utf-8?B?cjRxZ2FYTm9rVkYrd3V2VTJxdnV3QVRKaG1CZDRVSUMzKzhSOHluTnJ2MWxU?=
 =?utf-8?B?TlVLZlhJTllkZWZWUDlNVldCc2FTN2xob2pwcjg5RDBXemdtNXNuQjBwVStE?=
 =?utf-8?B?bk1NUU1OSjUvWTJXSW4vbTZ5TTY0MlcyQ3c5TEI2QXNOM3NVS01JbW1kYnpY?=
 =?utf-8?B?WjVHalYxY1BMMllQaFZpVnVXaTBQK2E1dnFCM3BVbXRLcUJEVHZCaFBYWGhK?=
 =?utf-8?B?bzJZVDBqa0pvZG1uQmMwTFVEb28vcHpCVnRkWEFlMFFOUGxGS241eTJPdng1?=
 =?utf-8?B?WUI1T1ZkcEEzZkY3MStlejQ3UDFoYzVSZHd4SXFVZ1RiV3BlcGptOXYxdUEr?=
 =?utf-8?B?VTd2b3FNWHJtNkJaSlNXTTdpMkYvckFndFNkVTllc3VnMDdUak1xaFZMeXJU?=
 =?utf-8?B?OWY5elJnbWpPK3ljeFlNWG5CK2ZQZ2swVEdBdWE1Y1pPZjZGMWtZK2U4NjFJ?=
 =?utf-8?B?eEZTN1NhcGRzZENqR244S3NKNVF2eExRc3JYeWwzcDRhNjFrS29CRHRnVnk1?=
 =?utf-8?B?cXlydFA0aUIxckZLVWpVYzl0YnBjcVZUN2ZQdTBhdmxXZlZyeWluWGtJOE9a?=
 =?utf-8?B?ZkZzdDRNOWVxN3FRcGVqQURpdW9jR2k0a2pnNTdrVjBNWTdPS3E1L1hLTUQv?=
 =?utf-8?B?SVhrU2YwSHgyZ1RZMzQvNTI4ZXdFUmo3UjZKeTBJUkd4dVI1R0NXaE9qZXlL?=
 =?utf-8?B?dnFaVmQzT1VkR1RpaWYvRVZyeWQrMGtNdTlNTzZCbWtrMGxzZDFVNHZKaXRs?=
 =?utf-8?B?emc5cmFIMXVpZk5yYUxwbjk3dVhSb1lsaTMrUUVXYTdxaERwOC84R0tGekxn?=
 =?utf-8?B?dUljSEJvMUJZb2JmSmNjRFRRKzhVWGJKcUoxeVJNdFFFUHhzY2hsSDFuQzFk?=
 =?utf-8?B?WWtsR3dYMXdTdFU5K1BManBOV3UrTUE5MzJPVVdhNTJZNEhKN2M0NnA2ZGZm?=
 =?utf-8?B?MERzbEhINkkzZVhQN2RxMzhrWGF0eWs5OEg3M1UxSFRwUjRKREw5aklPSEJk?=
 =?utf-8?B?eUd4ZTJUcEFCMGtqeUQvdkJGeU1jNGplTk50dzRvTG9tcjlsQVBPeHl4TE1B?=
 =?utf-8?B?SkRubzF1cE9Jbk93eDdmY0xiZnViMk5ldFJWT0N2TjJROTl5KzFtNzlOVWY4?=
 =?utf-8?B?b0xjMGg5WjlLb1JOTHlUcFhRWkF3VmdnMXdoeTN6Ty8yS2J3d0VWd3V3cGRW?=
 =?utf-8?B?V3RnajFLWWpsajNlVXJCdWpURWczM0NIK1JrTVdKZmM5c3ZiR2tXdnJsK3VV?=
 =?utf-8?B?VUo0QjhEM2NuSmpBVkR3YWJBbDJ4NHV3M1h4NUgzY2RieWUwYWZLMnUya0Nt?=
 =?utf-8?B?ZUkzWURTOGloN2RBSGZtY1lPOWVXMkNuY0RKL2RnRWNIY0twL1gvdllVd3p5?=
 =?utf-8?B?Q3Jxa3JqKzNHRGYwS3p4Um1KRm9hbk5sRTZmYVlMdEV3dUl5U0dDblRNNkFO?=
 =?utf-8?B?aWRrcm8ybE91TERKRTcrbmlWTWlGQ1h5bjJjUWZPdjZud0lNbnhKRXFNUGJH?=
 =?utf-8?B?UEJYajBwZENsQjhVRXYxVS96V3lJTW5WbzFMNU1adE94SzVnQy9FQUxFMmE2?=
 =?utf-8?B?K21UVEk3VEUxTWZkUVpuNUhmcWRTUWd4QUNQREJVYS94RDd5WFdraEhJeEpt?=
 =?utf-8?B?QjYzZlBsbnJWc3hWZzVhWUlmSmdRbjdjWEdMMjVuR0VUakFRRk1XZWI5YmpW?=
 =?utf-8?B?UU12M1M2TDIybXphNDlEdDAwZ1hKZUlDQVRkcEJBSVhDSUdhb1dpOExIVkN1?=
 =?utf-8?B?UWJLVkJRdFBsWUpBMFVaZjB5MHo2aHh5RDVuSmFjMFhobnUvMzJacVkzT1VF?=
 =?utf-8?B?S3JYMUdjK3hZbklzMzBYaUJMSzRvNHJnQmdMem1XUlFsS2J1UWk5K1FKL2Nz?=
 =?utf-8?B?YWRidHNvZXVqUVdDa2pYeXpLR1ZjRDNZd1RLWEYrd2xvem0xL1dSaGZLcEpO?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?S0NOWld3SHdEV2pndFFhWGkvYnVHQzR2TTFoNm9ZNFdaREN6eVQwcGlQTmJj?=
 =?utf-8?B?SGhPTWxxMFN3TG90UjBVd00vdUkweC95ZUtKK1Y4VDZzbkx1WmZBaVZJdm8z?=
 =?utf-8?B?d1Q2bmtFdXZjclNEZVJzajA3UVV2RXRrdmg2dGp0MkR4aGpRWXUzNjM3aTho?=
 =?utf-8?B?bCs4em11SnpkYVFuYWJNT25hSTN1T0l0cjVtTjhWQW5TTzAyeDVZS25LRFRI?=
 =?utf-8?B?Uml3UWhsNlpDemJKQlFFMTBTMUFwOHpSbGNFNHlRTjZ0alNhOWY1QVlVdCta?=
 =?utf-8?B?ck9SZGcyZVZkM3k5ekVLZ3NMbjZNaFlQYjNnQ1F1eUpDckVvWDlyRFZBZk85?=
 =?utf-8?B?NVVwMjgybG0xbDF6L3hFcW1jcC83R3BoL1RPZy9jK1B1eEJOKy9CR3NnSkRC?=
 =?utf-8?B?SjVYKy9ub3IzK29xejdBS2tkeFpxeE1RZ2N3K1orb0hFYTFMbFhBbWdFdTVD?=
 =?utf-8?B?Ynl0TVBLWG1GcVY5NVJndkFLQjVFT1V4ZzU1QzZSeks4UnExblpqS3ZlQTYr?=
 =?utf-8?B?LzNJU0RxcGdTNVpiZ3VvSmZzang1RTlqa0NGUnc0NnBHQ2JGNWhwZ045aEZn?=
 =?utf-8?B?a2puRmZGKzBiMlBOdzBlQnJOZTllYm01dHptcHluS1hVdGdyTDM0dW5RSVNX?=
 =?utf-8?B?dXZOVzh4Z3A0MHBRc25yb1lXOVEvL0pRL2J4NW4vUTdmaWdrMjQrOVMxSGJK?=
 =?utf-8?B?eG84K3BUQzNoL3pmaVowMTdubitST0UzVzJyOXpCY0Z1S3U1bmp4VFNLVVlJ?=
 =?utf-8?B?d2RNVTIrZ2xuRENUSDVJL0xpaHJ3ZmU0MExUb0hQSG5KWEx6cUFVR2wyb1Rk?=
 =?utf-8?B?M1AzcGZkd2s4TlBlejIwWmNiYmFCOVV2UzRsNHpLQ1RLcVlzREFUM3BDZDRH?=
 =?utf-8?B?QlNtOFpjejVsZHg2UURtOGRNS2taVWtJN2JVbkZqZXJxVFlzbzJpdkNaVFV0?=
 =?utf-8?B?ZVV2YldYYnBuQXpwZXpWWlpzK2FIL08yU010clZkOC9HYnVDNDRDbDJ6UWVK?=
 =?utf-8?B?SldqdWdqTll4UjBrcmdhQTFrL2FGOWYzYVNqdFRiaW5IdnBBNjdUMEVsWVQr?=
 =?utf-8?B?STg5L2RtbkNIRG5Jc21ETCt3YnZUUHpGelZIWnIwL2FUN29tYytwZCtxWHdG?=
 =?utf-8?B?ZGVkY0hUUzUvM05CTnR1YmtJZFcxcDJiV2ZkSUZYb2NTdHFxdDRqU3ZjVWdv?=
 =?utf-8?B?T2dsU1RhQUVzTW9Nc1YwZDNTcEc4d3B3L1liRU5PVkVrYmFrL1laR2Uxbmdp?=
 =?utf-8?B?dkVpcFVLY1M1ZEVCMjZvS3dFQkt6MWp5M3RJQXk3NzNyeHlzQVM2cTZJMGtn?=
 =?utf-8?B?RUo1Z3hWQWJTZFBKYmFGVlZSa3FVRGVMOXBhT0MxTDIxSDU3NitYcytqZWVk?=
 =?utf-8?B?VVN2N3BIM2E1UEZnMHRJdFF6akcyMHZFdmtEUDZXbHcyTHBLMHMwMXNaM1pq?=
 =?utf-8?Q?E/zvPNdG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b2d0f4-07c6-4160-3677-08db573bcb78
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 01:04:13.3660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zuHTjklZsyuBYspAPAEUn6opQ18MTnKabTUK7wmMGFLbTce74M83dhDjjbLbVkXtrGiRZCEozWO3uFZA2edOt3Ou9PZSy24oG6cuVN0Xh7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6594
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_05,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=772 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180004
X-Proofpoint-GUID: TzDwPEtC7r8r5nx7jW7eA3TBwfjPiZYc
X-Proofpoint-ORIG-GUID: TzDwPEtC7r8r5nx7jW7eA3TBwfjPiZYc
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 7:09 PM, Mike Christie wrote:
> +				  CLONE_THREAD | CLONE_FILES, CLONE_SIGHAND,

Sorry. I tried to throw this one in last second so we could see that
we can also see that we can now use CLONE_FILES like io_uring.
It will of course not compile.
