Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E074B707720
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 03:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjERBCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 21:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjERBCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 21:02:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E5735AB
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:02:07 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIGm61024473;
        Thu, 18 May 2023 01:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HBAWJ8shORXuyQLGZiBknHOhUsjawMieK2cKLGXgtVU=;
 b=ex1mbMSIGii/ziPiFsi3xoM3nprOvNCWe7B/UNOU4/60+3wncsWDh3uSGOc5is0c1ToO
 +efQyfxEjt17rKlaLiqOEV/AV8k+v7mRmiWM9/WEaOZlTLDdl+wpkkfaLcPv0P3RS/Ld
 UxT5Rveq0pdBGVPHJ7/2x/A52obOKI9P/wI2ou73M5YbvkVQvRE52wzbYEupBbWqNjXa
 ardKjQSroWpWCjV0PUcuy6MjWALMtsFejIDhl7MPStkOn8pBU1IoZShIE9BxyZa3wZsw
 VtOENaFpZbC5b4ApG12ln7jvmENWP2Yt2QoEqk2/5Bs/qxeUFG1GSQsywQa1XftgrbaC fQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxwphf4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 01:01:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34I0TLKq036376;
        Thu, 18 May 2023 01:01:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qmm0354fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 01:01:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwTo4Hq2PADBBGp2X+qWVo8IREB7iRzPstS7gudoM2lkZ3IYpsQOPJ5FHBke/fuVSTcTqRFjX7/Bd1RZ4Bkufc8I018RTTX046EgPpMzKZtF4laDaY1mllD6DAQdZEB1+no+63DAtE4QkrMYLP5WHAZndFuWwnBieMHeRR9tUons+WfMmRq5reY+WibPXQecE0ErrkjfvlKu+tLz/dStWJLkmJfQkjP1fkFRl6nGa8/wdZEGdSE8g4oZskTJDNT+/e0wY7dVsUZI2EffhNHLJEujSupiNTiGvuPUGN8kAUgkMRcRi9TTPM0IFEB5zivYXt9m7VI15t9NUljQsaJ/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBAWJ8shORXuyQLGZiBknHOhUsjawMieK2cKLGXgtVU=;
 b=F+cU4esZ5yYSmLqmgbTBp/SZWH3svRRYDwGydysdrcmw0m4zX3P1hEA1yEw+7DhVbthAtaHsTcs0Fi9NeMrbjUpNAhkL6mDJk0LPRJvx7SQBM8uwmpXrPQpHR8CD1HG2sViELyMEQ+MFW8zojKjWGsQTE3yLKMsZFYzZmqa54gYsXfL7UDgWAZ0zhvJvnp8S5ikB6VgBmHuyzgX0Fh+ArbNm52LE1bdTrK4nkFK5EK2P9XwtyE1Qrv+2U9Fq2jmYT7JpWPvVil/EMju1+aaSRbed/3cvpa1VN0TLigiF1thrZOn0maZDnGzWwvzKo6baWyMPze3qFRg/l10LjvXr2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBAWJ8shORXuyQLGZiBknHOhUsjawMieK2cKLGXgtVU=;
 b=MSUy6aANrec4vhuSGkHim+jBsXYGQvHvpG7UAhMPs8GcId2oBpnkM7h3GwIA82ltcSnD0eu3XQvbEinH8XgxVa9RFn9wjRPuddQeAoLdoHmBePbTgoJym0gfUv2SGzuBmC/UKlfbpChmAIJgdl+03w9TWKTHaIwDvJv2L/btUSI=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by LV3PR10MB7818.namprd10.prod.outlook.com (2603:10b6:408:1bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 01:01:49 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 01:01:49 +0000
Message-ID: <3c2adf29-c201-9534-cc07-d35c4dead948@oracle.com>
Date:   Wed, 17 May 2023 20:01:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC PATCH 2/8] vhost/vhost_task: Hook vhost layer into signal
 handler
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-3-michael.christie@oracle.com>
 <CAHk-=wga+96PqV4x8EwFAMfi--m9essdX+3uPE-AoOSAQR1ddA@mail.gmail.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CAHk-=wga+96PqV4x8EwFAMfi--m9essdX+3uPE-AoOSAQR1ddA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0265.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::30) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|LV3PR10MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2089bf-aa9f-404d-1aac-08db573b7597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Wf5DDKJ4P6DxkcxLY1IlSkfTKn99mDgKhen4cYpOuK0BfiILhlij9vnhRFsPNMMPuWRjtcv6J9DNcIX83yp4UHdEt5YGDGzzz7OfrluTSe+aVquJhAZzQylJeoA9W/C2lob5gHuBBTQgZmA1l2KIxcBiuzu2DTETeO9y+dir251OE4gPaUZcPPnE5OWvw77TfBF+jqa6x/oHSRwYwHtxDsFnV8+qT7GmLrWl3aPnx42JQ4bMQMPGSxNkVFIpwcVSpmLtvrjvZNzMO4WAfnqYk0FmyxuziFmLunLQCc2uGKRpkZsp9oDMKgh2yvPPc05jJTl5LuEIHjOceZ5e22iZxTjHSht/7sToo5IW4kPAuDq5UVsk9NBxHpnJQnUaeATdfoKf2+cdKAADEXLegHTyNCNVNWwD00OQLHl7N34H8fE1gMFrH7UG1M/YjG0tjU4GtMZM95vZlWht/otMit4O9j0GZd9+ZtYw6hFf9YY6e6VQXnK8++jNFdr36JotRyXgJVRibicEdEtZzN/6qOkIbfK2+1SwCdpV9ZqEJN7VzAT90Hcd9NHffYsWi/EV9zWuaxaNsLLcek3nMlRBJfwKb/JRJ0mM7fwH9HVomoZhvYTU4k5PDormZWJl+Hk0oDmzl2F00vYII/lv12bvfv55w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199021)(31696002)(41300700001)(86362001)(31686004)(316002)(5660300002)(7416002)(38100700002)(4744005)(478600001)(2906002)(66946007)(8676002)(6916009)(66556008)(8936002)(66476007)(4326008)(6486002)(36756003)(6666004)(6506007)(26005)(6512007)(186003)(53546011)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlJnU0hTd2JYWkVJVnFlUHNJeS83MTFrd2RJTVVjbWViQXZaSUdKSkVWeDlT?=
 =?utf-8?B?RTNoQ0syOTBETmpZZUV1U2NjektVSnFNNGxQZGYwdGRON2R1RGZVT3d2bjdn?=
 =?utf-8?B?WWl2R3gvdkZmSCsvNWY5dzROL3R2eTVlLzNvV2lvSEZMeEtqQjdwNjRHN3Uv?=
 =?utf-8?B?c1l1a3pRK2Q0NWw4VnhkT3lzYTNBaU0vMnhLamF5eDh0VG9zQkc0SzJqSDFV?=
 =?utf-8?B?OHM4SFBXeEdvSGQyU3RMTWhjOHAwSTNsbmI2STFiTUhZWW56a3hocDNVc3FF?=
 =?utf-8?B?U1FOQlgvM0cwOUQvNEpqL3NsV3FZSVltbk02OEZhZGxUYSs0L0QvQi9UajY1?=
 =?utf-8?B?S3pFQkEvL1cyODN6STJEMEdKTDduYndaMkFKUFh6Q3dQME5iUGc1cUpvVmVP?=
 =?utf-8?B?RDNzaTh2bk5WYjFCT29rTnVLbS9MU1NOR2V4SWkxa094Z3Y3Z1JrRnJVUE5p?=
 =?utf-8?B?VjJKMktwcDgyRDh1TVFxZldMSmh0TGUvaVNSYUpXZ0FaTEt1QStwR0RaVUtY?=
 =?utf-8?B?QXFGUDVYZC95aGx6R3lWMXhjYlFHVTkyLzFYei9DYUhmcytCT2x1Sk5PVlNs?=
 =?utf-8?B?bWJ4akZUL1VSWnpPdGRTNGRDaXFWbVdKOXhKc3VBM2YraitZNkNSaVU1T21o?=
 =?utf-8?B?UDBDamxDS3laTzIvVXF5b2p4eHZveFhOWFcrbC9iSkFrWjNmQzNQenlocWgw?=
 =?utf-8?B?QkNZR0l2cXUzNHh6N0YyV29QN0FNcnB2Z2dkTzNaMGM3UlEvc2ZVU3RSRnVY?=
 =?utf-8?B?VCtJZTMyUXVKbzN6em5XVktnQmhKUUFHRkRzVFhISUhJcjBTTXViN0R2ZE1u?=
 =?utf-8?B?WERwWFFTUHg3a1NqMXNlSUcybXFDV2hrbDJRRmN3elRvQmM5YWM3TklPUVJS?=
 =?utf-8?B?ZXpJVnVYWmtoRnBtcC9qM2pNaXZxTmZrb2ZrS3oyeEVPK1FNN3pqZVNLQW1m?=
 =?utf-8?B?K2RUTGV0a1dUSEJFRVoreG1oOWZXMjdYMDZ6VGFkOTBRYUk4V2x6VjhpRGdT?=
 =?utf-8?B?Nk5Md3BGUWlieDZ6Ymh4N0x3NnhUOTJlNUtiSTFRdkxPTFk1cHNvcG9DRHFy?=
 =?utf-8?B?c0xpb0dzcTBJT0NIb2xwK25aZkVWMkZhNE1LcEk0ejNFbExlZGljWTFZS2s0?=
 =?utf-8?B?N1ZJTWsxUXFKNmI4Si81T05HYWJGdlhWcnJnUmRpMEFDM2h1bFZneGUvbFFR?=
 =?utf-8?B?QnJ0S05WVVBMUUNDVnpteVRxRk5PM0Q0TUNBOVdPK2dPbnVlb3Ivc0V2Yy90?=
 =?utf-8?B?Rk8rbnk5NTRHYW8wN3hmaUtzRmZUUTJVYTM5VTBjd1ZZWHZBRUJ6Q3dlSUQ2?=
 =?utf-8?B?UWRrNFZKcXgwemJuQ3pPU2h3eUJzSGF6VzN3YnNHbGw2N3VqWVRTbWMzL3Rl?=
 =?utf-8?B?KzB6amhkd2RudC8yMWNFSVZZcHdMT2lPaTF5SUpCWUNnQnpoZHlsa2lMSUhH?=
 =?utf-8?B?RUFaRy83ZjV2YmJmYlRVN2NIUC8rWWhMQmpvZEdvZlZFZktzRzBuZ0RLZTNx?=
 =?utf-8?B?N3NxTHBMRUlCME10YUg3aWc0TVk1aFZ0MlVaSi9jT2hEN2lITVFRRG1ZM3lC?=
 =?utf-8?B?dW1RV0xCMHhhT0Q1bExqR0I4VzB6ak1vWFZ2ZklsaEpiZmxoTXJ2NjhodWQv?=
 =?utf-8?B?dlU2VUw5Y2tiS1M3RnVITERSZVhha0VKNHZsQzVmZVpCKyt5TTZ6MHhKclVz?=
 =?utf-8?B?K3BCc1hIVG9LUGxzWGVQNEFaaEVPWXUyaDJhVzF0NzNnVis0Nk1ranVCT2xz?=
 =?utf-8?B?UWNsekdIQU55Z2hLUUdUODJOM3F1cllqM0dXVVIrVDZnZ3N0YXU2Y0dFclVz?=
 =?utf-8?B?bVgrbG5PR3BnUlFpM2ZkUGRBU3dCTVhHcWlqb0kyNWZwdEdUZ1dGZERpaEta?=
 =?utf-8?B?Rm8vcDJJNUFESkJUdzZQa3NMVXlJWHl5a2xBdmZzejgrYTE3bW1IQkQwWjR3?=
 =?utf-8?B?bHBES1dXbUo2a0N1eFRjckRXMGRIZC9KS0tpaG51MW12NWVpYTZwMXJUbjVS?=
 =?utf-8?B?UE1US1VRRjJYM1JOdDl2U1puN3JyTmZLTkR5N1dJeEU1RTR4MitIV1RVbi9m?=
 =?utf-8?B?RWF1S1hNQ0t1U2tPV255OVNkUHZPRy9jR3RhNnNoN1pGSm1sTGkxdVlYU2Va?=
 =?utf-8?B?a3RDOEsvdnFtK2JDK3VIT1J2ejZBbW82SWMweFFSVjdSYnJrdWRHRm92N1Yz?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Zi9NVE1kVkhLVVNRWmxUMDJCTzBHbko1QzZkSDZPK29wWGpMMWE0L2k4Y01s?=
 =?utf-8?B?MVlSQnVCZGVqS2RTdnoyRnJVYndCZlIzUXhUemYyWHZBQ2F1dHhJeVlacjdi?=
 =?utf-8?B?dWx5cHViUDNxVVA3T0grTi83b1VOMHJuNHdQaWxBeVVUUWE3SmVaalcva25l?=
 =?utf-8?B?cm15NmZ6NkJ3Uk1yRG1DNDMrKytZK0lkeUJpM2UzcmRFRW9mMFpQNm1mYkpw?=
 =?utf-8?B?L1Y3YUNmcTBRNXcxVjkxdDd2UHF4SmtiKzNuQTh2UGNGc0ZMVVZMdGN4VGUx?=
 =?utf-8?B?SUdCMVkxR3ZEeTBUZzE1OFlsN2NKZjlTVTJ4eHFFcTAzNWZBQ2pSUTR6SDA5?=
 =?utf-8?B?RzV3RUN1L2REQ1lxZmZ1Q1FYcUhIK0Q0MVByZE9vVW5XMnl3WndWYlR3RTRS?=
 =?utf-8?B?MENwZmxQcFpDZ1JGQ1NoZW1MeTRSOXNJb2phb25IU3R4d0N3b2dhV3UybE5J?=
 =?utf-8?B?NkNwdHlIZDgyei9SL215cXFrWlZEWDNtbEhtcXcxOXFzbTY1SjFEWW1xTkVO?=
 =?utf-8?B?YmFCVFYxWHUrWkJsNTRVSGkyVFR0Q2w5QVlzR0JJY2tEdDd0dmNTR2ZvY2xQ?=
 =?utf-8?B?SHNibUZVVkFiVWtQSXRxbkEzb3VyRmtUdjBaeVNSc1JORVNxNW8yNGcxQit0?=
 =?utf-8?B?YUp2ZWJpbkdtaFk0WDF0MUdyeTZWclFnbnk2ZXZyV2t1MS9hYUVlREJocnFw?=
 =?utf-8?B?SnN6Z2I5Yys3T2lNRG42NXJDb2ZwSE9GV2hyQk5KNDI4VDNsdUxXRWRHWWVW?=
 =?utf-8?B?NkdpdFNMeXRrZGdkZDFha2V4MmJyR1dURTZKdGJDZEtBVHBGR09WbW1qaVF6?=
 =?utf-8?B?ckZpOWpkeU5pU0RuR1NyN3paZXBEQ2lEdU5rYXRFWi9lQjBYY1RMRGFzSzZS?=
 =?utf-8?B?NkpHa2tQM2RrSkZUTWNQTmN3TjVzTGJhVEdXMmx1VElZS3hxQTN0VndlUWl4?=
 =?utf-8?B?MnZoNDZvbEpYK1NPWWZDT01zTlBTNUsrMmNKODFEYmxWRGNyc0V1Y2lpWFNz?=
 =?utf-8?B?emVIQXNLTzlER3ZNdUhjTjlHbysrTnYrWkZmZ1QvcGVvdEhRcEU2MzdkVHAr?=
 =?utf-8?B?TzNOdmpKQ1JCd0dlUlgvVENNelVHVWhuTTc0Tmp0RFhmQXNyNlMvZEhKQ2RL?=
 =?utf-8?B?MUl4aDdOdy92NzFiT2VOaVBQZWRLTERQeG5NYk9iUkVMU0Y5ZUhXZThNaXlh?=
 =?utf-8?B?MTN3YmNqVjA1T2FqbzA3UCtKMXR4QVVhUHlDREdpcTNLUlgzYXM3TTdjb1g1?=
 =?utf-8?B?NENzc0xjTXd4VjRHYmJVY25XK21xblhDdWV0MUVFSWp1K28vZ0pJMllMRC9p?=
 =?utf-8?B?VlJNRUtIcFgxQUJkVXo5TVVVbEpIekJxZkxBSmlVYkF5YlNUL3RncTFqNTBY?=
 =?utf-8?B?ZFE1dGNYUW5VUnd2emwzRnZSR3B2ZzVGVnEvOEhvZkQ1M210azFENHRRUlNN?=
 =?utf-8?Q?XqtG72BD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2089bf-aa9f-404d-1aac-08db573b7597
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 01:01:49.4859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxYORe3PQP/6c1cwXodfTfEMO8v1vR/H5hKdJ/EYlpwGBJB/n96ej8SvMXER2bc56wF/Iy/hTmV88eZNtKgPKaNkGBNctpu6A5NZa2KoQuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7818
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_05,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180003
X-Proofpoint-GUID: GXdAE0ttNmAzCeS7YAsPvyLQBPJ5Gxbb
X-Proofpoint-ORIG-GUID: GXdAE0ttNmAzCeS7YAsPvyLQBPJ5Gxbb
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 7:16 PM, Linus Torvalds wrote:
> On Wed, May 17, 2023 at 5:09 PM Mike Christie
> <michael.christie@oracle.com> wrote:
>>
>> +       __set_current_state(TASK_RUNNING);
>> +       rc = get_signal(&ksig);
>> +       set_current_state(TASK_INTERRUPTIBLE);
>> +       return rc;
> 
> The games with current_state seem nonsensical.
> 
> What are they all about? get_signal() shouldn't care, and no other
> caller does this thing. This just seems completely random.

Sorry. It's a leftover.

I was originally calling this from vhost_task_should_stop where before
calling that function we do a:

set_current_state(TASK_INTERRUPTIBLE);

So, I was hitting get_signal->try_to_freeze->might_sleep->__might_sleep
and was getting the "do not call blocking ops when !TASK_RUNNING"
warnings.
