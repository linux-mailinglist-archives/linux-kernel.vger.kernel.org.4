Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4FC7052E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbjEPPxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbjEPPx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:53:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA438AD07
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:52:56 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GEDpvb001524;
        Tue, 16 May 2023 15:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=BjhgLm/M0n18HsMQ+Ic2m07tqhAYl7dciLD9MuK4dGE=;
 b=jERSjPUijt9nuQCsuWf9LH38f8f8moe/yMot07kusTOIrLng6mFmJlOmin2hlZ7E/I9y
 XpJyEdajcz/72vPLPEYcV7x5pUDJoEEW2k2KQnobbi1vlLxf5+JyeAhEIBq6fxJgQsGL
 pcytJz3UIiWuBMEvfuDn3H3nki7W5/y8Y9wjegMMxQHeaLYRQjI0IKAUbuc+4VmYeSuL
 rqKHhve+cp8tPurhMsbbeWvFvx9ZW6rbApeWrzgirP2mTG65JI73ZA2QmEMIcLfjv2yc
 +lA9kZ5zkTt91myS+DuDiNXfWZ1zHPKxOf2oO0cXfBQIA3e8mZ8R5VPOo1M4QafR2B3C Rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1b3um7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 15:52:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GFLZHM033996;
        Tue, 16 May 2023 15:52:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj104rc24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 15:52:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hreadL4sHtbJBcavCPCjZHs5Xrp+CUbz/4FEfQsXFCdoytW3XoQ+HbzvGZFbCeYm2BUi+bvaigpp8v3Cy5dKvMNKsSKvo6HODEic/P9JW7Qrda/gmujtuCtEoq5okPhArRsczlqfQ2HZQ0MoDMMZd2LrAJ4L0TG95p+1fs+eg5l1ZbdZsvlc7eTCt0N6UoiKie+bLQcKOXRn6kMiBmL0FzMr4/R0o/LFxDg25zMHGgNxnXyby4lhW69fk2tjBcTMsTjG/+7f64v7aOOWKupS5pjj723Lar0O14sbr4BpJav0KqhVulVf8BVdCCRSPCEEvW4GtAgzo/WR/YruOp5MUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjhgLm/M0n18HsMQ+Ic2m07tqhAYl7dciLD9MuK4dGE=;
 b=iU5JlYDmDsQ1gigpRwkb9GOoQxVZQpGAD5S7YCyVFZZVnBnQ3M6dugHtIeCnmQ+xo1xvRbDLDdFXd+lLsEzqfIs2dsZEQTaS3LfC1mvsKvE1YJSv7lylUiyLeYHYKGmOy45N/W5Pvx/FcSbFstkHF2IuMIKnCdEBuv5ND528rbn1ND0wZvaye8OBK00S3EoXAhQRsO0NtMXZU2Bx0qvR3BZ8QRqcrR/em1i9svI5PtPsnDJ7vUlOhwePcdc9vcJ9zfMiJzuupeNpk9s+jq8I7AwEypgeVHkwJ7D9NAs0GQ+VnbQiS9hY0P1LCmFHYPsMX+CbZhNLcUPwTDxitmcLVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjhgLm/M0n18HsMQ+Ic2m07tqhAYl7dciLD9MuK4dGE=;
 b=b4f0Jky62d31PrulZBQhDdYfKME1mdc8Y2Gll9CjhjFMETS1M1B1kxf9o5geppVcBot6ialtwniuLxGWcyH27ltrA6+YS+IJLajeSFBBywory1YEuxKj0Nm2aES+LyJZxrRmOOKWZ3zaWo5p9yW0jy0/2iajmvPGdz8dYvHsn8c=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4798.namprd10.prod.outlook.com (2603:10b6:a03:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 15:52:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 15:52:24 +0000
Date:   Tue, 16 May 2023 11:52:21 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 10/10] maple_tree: Simplify and clean up
 mas_wr_node_store()
Message-ID: <20230516155221.rfth4jui5e5q6bwb@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
 <20230515131757.60035-11-zhangpeng.00@bytedance.com>
 <20230515185810.esnbqaybs5ivttwq@revolver>
 <c0530aec-754b-f382-3c96-35437d5ec762@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c0530aec-754b-f382-3c96-35437d5ec762@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0042.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4798:EE_
X-MS-Office365-Filtering-Correlation-Id: d65ad602-961f-4bc0-e158-08db56258a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WiAM4XvW9otvAgDNFRNdAFhWkHQHV4yiunwz14ZEVKxMUzlE50Qqlazm7M1xL2+VKg3fA1V7aQh/pUwkjMTRXNPsih9MMrgx4oR5iU5QZ/Xo7Np+KsaWTe27FWL/Tv2LQ6KKlLCzX/LnmSwl0cpRQGg39KhgedhxBweyGNeOIe50V4jS8UhWYp6barOkD1t4h/iYtgzvVlkneltUpL+MM3Z6q5Xd8VGU1h3xpERBbappT+yU3XRGpPlrCLg6yaDfBqaKuFs2hukk0QzPFjjFuOqUgIWooYy4GJ53Jt6XxH3zIehxqqsZSmlGucCi2d5BdJ0boRYTpeVDXOSw+AeDTtebvDLX9oEWCSNNIP9DaNRAt0awUUswJ8d1zKTqyfvaztklwxkvDrS5VP36nfhvxt85yVuWQECn9ve2loPgLiaAXCi8fYDV8uJvqXNbDnNCRbakdLJe0+l77l7SOHQUntQVrb8OJT98qPpqd8sbYfxhDAE5ZozLhmdc/Ir59l7TyMIKCzy0OPei48gN7MaMWH8gPQq1prWAttPqE9viJaRK/RFoVjJADqq13+Ls21UC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199021)(1076003)(6512007)(26005)(6506007)(83380400001)(41300700001)(38100700002)(6486002)(6666004)(9686003)(186003)(478600001)(66946007)(66556008)(4326008)(6916009)(66476007)(316002)(8936002)(5660300002)(8676002)(86362001)(33716001)(2906002)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OS9vNjdERWo1bkZzYWwzdGlYc2FQWHRKczZ6bm5ROFVFaUVFMEp3QmkyT0li?=
 =?utf-8?B?UEEvdG5nMFlSTnE2ZXhra2NmUDI1RjV5bXl1SmJGc2NER2x5MXFEZ3NXM2M3?=
 =?utf-8?B?TVNURkVtT2NsclZ6dnJqNGJUZXhpSHVOTmJWYXh0VUpkcUV1NjZjMXdUMXkv?=
 =?utf-8?B?UVArMWxTK0x1M3BxS2haMG9UTkltV051TzJ3M0Y1dnF2Z0liMlRMN2pnbm9w?=
 =?utf-8?B?UzA0d0lZbmZ2WDAxOUhMY3pCZkFxWGlvMUhHa2V5Z1NpbGVxSlBuWFVNQldB?=
 =?utf-8?B?VGNkOEdpdlVVeXcvZFN2NmJFWUtJbzZjMy9sa0VKRUdTQ0FDVklCZ09QRmp1?=
 =?utf-8?B?WWpYY0FLTkNINFhybDlwcTRvUGJmanFFSWRKNFByc1RXQkdVR3ZOMHZsaHVa?=
 =?utf-8?B?azFyZklFQ0h5RHpVeE9JY2J2ZDhRaExLNkZORFRDU1diZ05lTU1uT2NEaGdW?=
 =?utf-8?B?S04xS3RocE5ScisrUkZZYzB2S2tRd0tpdkN2dG8rYmkwR2dIdnh2Ym5BM0Vn?=
 =?utf-8?B?VkJESVhjN2FBODNqdS9XTVFTYnVEYVZPNHhicFg1TUJvVGxyWlk3ZFVIYml0?=
 =?utf-8?B?QkhIZG5SUmV4OUZhT1FJWk1WZzE4VXAyRkRqRCtHVisrZG1wZmxBYnBhUlc3?=
 =?utf-8?B?QWVCMkRwNEVEN1d6UFBtcEdGY0ZqRmhlY2lsZUYyalFSczNONkpDSm9xWndi?=
 =?utf-8?B?NHVmd0RENjFIaFRISzlHR1V2NDU2a3RZdHdGTW5ZWU8vbWtjQkF0TXE2NmZ3?=
 =?utf-8?B?Y09YKzNZWG9KVnJPalRqUUlLYjB2R2x4d2hxM1FmQWhPY0NoaGg1WmN0ckVy?=
 =?utf-8?B?UXVoNmNocHAxWFZOWVo1NElnelRqSHB5dVhIWFVubWozMXVNK1hMZWtmbW4w?=
 =?utf-8?B?QmRhd29Na01RYmRYVXhvT2o0OXprMm9iZXIwdEw5NjBKcG55L0c3OHJyampt?=
 =?utf-8?B?VGd6dElYUjBCeG00VHpobFpxWkNmVDRyYlNYQUl6U0ZzTCt1TFpRM0NGU2d2?=
 =?utf-8?B?V2Z4eXpKWXJlS20ydDB0RXJjSjF3YzdFVS9hUS9Gd1RHVFg3R2VLSElxSnF1?=
 =?utf-8?B?VFhCQUg4OWVpYzRPK0pJZnVsTHh5NFhIR1pIR3BqQ3BlWEt0amJLdnRJK0Jv?=
 =?utf-8?B?QW85eHNyTGpqNDJ3T0FBUHY0SC9lTFNKNDdTNitKTlJhR3hEakM0YXErZHdh?=
 =?utf-8?B?REEwbWZkSVU5QlRoQnFvMmFUZlAvMUhCbmYvd3Fnc05MQ01XZk5pUWIrQ0Fj?=
 =?utf-8?B?SXFrZHJpQk1sOUcvUjlOQ2lhaGIwQ2RNS1ZIdk5UdHkvZmdlRkZtM0JIZGQ5?=
 =?utf-8?B?SHVKejNudUZBN3dhcGtDK1NWV3hHakZTaVU3UWdVMkwzZEgxcDV6aE9nMmpl?=
 =?utf-8?B?MWc0Q2xYTDIwSmVFRThmQ2Y5L3dNb0tUUmgyZ203MFNMaFlicDVUQmlxTldq?=
 =?utf-8?B?T2pqWjBFUy8yRkhjOWN5Q1JheWlJbUpSWmx5QjZiS3ZMK3d0WGowUzQwSEVI?=
 =?utf-8?B?c0FlclhNenh4WlpMT1BJVURBcEUraG5SSFpLYmR3T1ZoOW43OTdzY0gyU0NE?=
 =?utf-8?B?ZWM0MFBLK3ZhME05R0d4N3JMeXZ0M2Ntd0tNU0RMQjBEZGliZ3p5ZlBUSXFu?=
 =?utf-8?B?dWw0bU1nc3pvQ3NzZm1tNHl5Zm05NllwejFXbElENUxIZ2ZmZTFiK1Y1SFVP?=
 =?utf-8?B?dGFza2hFUE9nRERpbzdXZEkzMlNCdDkyZW0xSC8zR2FYREFteC9YNU11Mldx?=
 =?utf-8?B?dTduN2plYit5dm10dTYxUHVoejQrUmZLcm4vSnUxdmtrZXB5alhaeExWMkNS?=
 =?utf-8?B?VHBRYnVldm1jUXNQaElMbThpd2dCUjE1SGlHS2FSR0h3MzVpZU5GdkwySE4w?=
 =?utf-8?B?NW1iZDM4Y2R4dVdqb1d3Y2pFMDU2NTRpVFI3cW1zMm9mSDZUWlM2ck8rU01v?=
 =?utf-8?B?TU9aSkcrUUVwZ1B4Uk9wUVRpallyWlFYVEZCMWY5QWFrRXJic3pJYWxiSVl1?=
 =?utf-8?B?UWVhaCtCYnpNZ3JnYWlYRkxmVGJQSTg4ZEFMbU4zYWJrRXZwT0Q1R1EzZzRM?=
 =?utf-8?B?M1k0WFR6ZWdXWGpnL2xWRnBPNTlQZDVZR0p0YjJnRzY2Ulc2eGR2SGpBTzJt?=
 =?utf-8?B?SlNRUDBRNHNKK2hYSE56eDA3NnVuK2hvdWx5cVRJc3E1OGxoRS9aTFl6blI2?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?am5FOURRNUREUnFCU29pV3daYU5hOUJPdHV0QWtRNFdmU3lYTTlhREg3amxq?=
 =?utf-8?B?ZlQ3c3B5SXFzRDlrdG02ZVY4YWFmNXdhUWprREFqdEFPbVlXQUhuSGoxQStU?=
 =?utf-8?B?cXhUWEYrb0tiMGpnYTZ2OUlPVVNML0RMRVpxdmRhOHdOZTUzamxBa3FxdU54?=
 =?utf-8?B?dGxkdjUzR21RSng3VUx5VlRrRFdSZVlzcVVLZXhmWE9pSHhmMU9qWHZPYkww?=
 =?utf-8?B?ZnN1eVhBM0d0dVlwNXk2WUl2NkFVUElMWXhOck8yTHI2WnNIZ2wvRkNhTStp?=
 =?utf-8?B?S0k2RWxsbG9mZXVaVTU5UkVGN2tHc015NDBUbUFJUjJDK3drWjhBMWY1R0hp?=
 =?utf-8?B?Wk11UkYzQmhXNVM1Rk41eVZ1Tkl5elZUZHVnK2t2RDkzL1NjQitDeUo2bit0?=
 =?utf-8?B?ck03dlFNYk5nV3J0bkZGYlJNYnc5UGpnUE5heEhLc3FEeWJSMlVPWldxc2JJ?=
 =?utf-8?B?VGVaM0tZRTFQTE1OaFhkRUJxcEI2eVJRb2hKZWFCSHJTS0ZEWnFnakh2VlhB?=
 =?utf-8?B?dU91UGpjREJZWURpald4dTk2L2w2aUswNnp2R2k1dHRVdGxCcXY2S1UzdTYw?=
 =?utf-8?B?ZmFQSVRmajNaaTg3MmhXbURSRWE5b0xTbkFxdkhqS0FDM0h4R3k3andlRFFP?=
 =?utf-8?B?cktDcVlDclR0eGZPRGJTeDRodUxPMDVpUkFUSFUyeG1JNGw5dDVpbGZxMXhj?=
 =?utf-8?B?bWlmbUl6UU9sazE1TUJETFRhazJBYXQzKzF6SDJKS2FVb0t3TEdwais5OVV2?=
 =?utf-8?B?emU1VjJ6d1VyWG5oeTVXVDA2dUU2QnI3akV1QlVEcmJvaFNnRzdVejBpWFNZ?=
 =?utf-8?B?S3Jxb3Q3VytJQVoxQlhKckZEM0xYbXA0RUZYcGlzUVVUZUVaZjlFRk1ucWdX?=
 =?utf-8?B?OU9UMzRIU2E3NytyWm4wTFJIajB5eEV0VVcrcUlORXJ5M0dPcFNIRTBXcmJm?=
 =?utf-8?B?WHVIMWNjSlhpS3k1UksxYk9rYmx5QWxFU3BTamFKOE0yR2RmbUdwTGc5bGxF?=
 =?utf-8?B?UE1MSG91VEYrc09RNzJPNkRYbGdGVmQ3T0JZL2ptQ1UvN1pIZWVkSTd5dWxO?=
 =?utf-8?B?NWhZQ1Znb2NOaG9YdHVZRWpCVWpHTGxWUXBKZDhXaXpMRXJQb2dvU1I4TEp3?=
 =?utf-8?B?Mkk5WklXREFrVWh6aXY5aTB5dFFBQ3BQS2ZmenlZR2tCTVEzbXFTUUpCRk9z?=
 =?utf-8?B?OW9RbStYazFubE9UQzNZUi90aERjbnJyb01VaWhXL3JjeDJ2a2U0WU5YQUI2?=
 =?utf-8?Q?ECDDhHmFG01J7OA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65ad602-961f-4bc0-e158-08db56258a65
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 15:52:24.0480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gqwiWXnZGu7z0ozw/26Tr1DTEW98Pqs+YyVuPyBk7x0jPaheWv8xfTCE3WaZD43hkUmlUSi7sOoFV8zV2NnBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_08,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305160134
X-Proofpoint-GUID: qmCES5L5QBHGGpoKAt_A-NcOK04Cyp4C
X-Proofpoint-ORIG-GUID: qmCES5L5QBHGGpoKAt_A-NcOK04Cyp4C
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230516 06:53]:
>=20
>=20
> =E5=9C=A8 2023/5/16 02:58, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230515 09:18]:
> > > Simplify and clean up mas_wr_node_store(), remove unnecessary code.
> >=20
> > This change fails the userspace testing for me.
> >=20
> > >=20
> > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > > ---
> > >   lib/maple_tree.c | 75 +++++++++++++--------------------------------=
---
> > >   1 file changed, 20 insertions(+), 55 deletions(-)
> > >=20
> > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > index d558e7bcb6da8..ff4aa01cf88b6 100644
> > > --- a/lib/maple_tree.c
> > > +++ b/lib/maple_tree.c
> > > @@ -4066,46 +4066,21 @@ static inline int mas_wr_spanning_store(struc=
t ma_wr_state *wr_mas)
> > >    *
> > >    * Return: True if stored, false otherwise
> > >    */
> > > -static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
> > > +static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas,
> > > +				     unsigned char new_end)
> > >   {
> > >   	struct ma_state *mas =3D wr_mas->mas;
> > >   	void __rcu **dst_slots;
> > >   	unsigned long *dst_pivots;
> > >   	unsigned char dst_offset;
> > > -	unsigned char new_end =3D wr_mas->node_end;
> > > -	unsigned char offset;
> > > -	unsigned char node_slots =3D mt_slots[wr_mas->type];
> > >   	struct maple_node reuse, *newnode;
> > > -	unsigned char copy_size, max_piv =3D mt_pivots[wr_mas->type];
> > > +	unsigned char copy_size, node_pivots =3D mt_pivots[wr_mas->type];
> > >   	bool in_rcu =3D mt_in_rcu(mas->tree);
> > > -	offset =3D mas->offset;
> > > -	if (mas->last =3D=3D wr_mas->r_max) {
> > > -		/* runs right to the end of the node */
> > > -		if (mas->last =3D=3D mas->max)
> > > -			new_end =3D offset;
> > > -		/* don't copy this offset */

Can you re-add the comments that you removed?  I know the code was more
lines, but the comments really help follow things through on what is
going on.

> > > +	if (mas->last =3D=3D wr_mas->end_piv)
> > >   		wr_mas->offset_end++;
> I guess there is a problem here? If we modify wr_mas->offset_end,
> but this function fails to try the fast path, it will enter the
> slow path with the modified offset_end. But it also has this
> problem in the previous version.

I don't think we can enter the slow path if this is true.  We must have
enough room, right?

>=20
> I applied this patch to linux-next/master but it passed the
> userspace tests. I need more information to confirm what the
> problem is.

The failure was pretty consistent for me so I thought it wouldn't be an
issue reproducing.  I tested against mm-unstable and it happened every
time I ran the whole patch set yesterday.  Today is a different story
and it isn't happening for me now.

Here is the failure log:

$ CC=3Dgcc make maple && LSAN_OPTIONS=3D"report_objects=3D1" ./maple
gcc  -O2 -g -Wall -I. -I../../include -g -Og -Wall -D_LGPL_SOURCE -fsanitiz=
e=3Daddress -fsanitize=3Dundefined   -c -o maple.o maple.c
gcc -fsanitize=3Daddress -fsanitize=3Dundefined  maple.o xarray.o radix-tre=
e.o idr.o linux.o test.o find_bit.o bitmap.o slab.o  -lpthread -lurcu -o ma=
ple
CC=3Dgcc make maple  5.10s user 0.18s system 99% cpu 5.283 total
maple_tree(0x7ffea7d35b00) flags 0, height 0 root (nil)
0: (nil)
maple_tree(0x7ffea7d35b00) flags 0, height 0 root 0x1
0: value 0 (0x0) [0x1]
maple_tree(0x7ffea7d35b00) flags 0, height 0 root 0x61500000010c
0: 0x61500000010c
0x61c000737100[14] should not have entry 0xfeadfeffe001
BUG at mas_validate_limits:7110 (1)
maple_tree(0x7ffea7d35b00) flags D, height 3 root 0x61e00099551e

....<lots of tree stuff>...
      7f56ecffa000-7f56ecffafff: value 140011320090624 (0x7f56ecffa000) [0x=
feadd9ff4001]
    7f56ecffb000-7f56efffffff: node 0x61e000989500 depth 2 type 1 parent 0x=
61c000736916 contents: 0xfeadd9ff6001 7F56ED7FAFFF 0xfeaddaff6001 7F56ED7FB=
FFF 0xfeaddaff8001 7F56EDFFBFFF 0xfeaddbff8001 7F56EDFFCFFF 0xfeaddbffa001 =
7F56EE7FCFFF 0xfeaddcffa001 7F56EE7FDFFF 0xfeaddcffc001 7F56EEFFDFFF 0xfead=
ddffc001 7F56EEFFEFFF 0xfeadddffe001 7F56EF7FEFFF 0xfeaddeffe001 7F56EF7FFF=
FF 0xfeaddf000001 7F56EFFFFFFF (nil) 0 (nil) 0 (nil) 0 (nil) 0 0xa
      7f56ecffb000-7f56ed7fafff: value 140011320094720 (0x7f56ecffb000) [0x=
feadd9ff6001]
      7f56ed7fb000-7f56ed7fbfff: value 140011328483328 (0x7f56ed7fb000) [0x=
feaddaff6001]
      7f56ed7fc000-7f56edffbfff: value 140011328487424 (0x7f56ed7fc000) [0x=
feaddaff8001]
      7f56edffc000-7f56edffcfff: value 140011336876032 (0x7f56edffc000) [0x=
feaddbff8001]
      7f56edffd000-7f56ee7fcfff: value 140011336880128 (0x7f56edffd000) [0x=
feaddbffa001]
      7f56ee7fd000-7f56ee7fdfff: value 140011345268736 (0x7f56ee7fd000) [0x=
feaddcffa001]
      7f56ee7fe000-7f56eeffdfff: value 140011345272832 (0x7f56ee7fe000) [0x=
feaddcffc001]
      7f56eeffe000-7f56eeffefff: value 140011353661440 (0x7f56eeffe000) [0x=
feadddffc001]
      7f56eefff000-7f56ef7fefff: value 140011353665536 (0x7f56eefff000) [0x=
feadddffe001]
      7f56ef7ff000-7f56ef7fffff: value 140011362054144 (0x7f56ef7ff000) [0x=
feaddeffe001]
      7f56ef800000-7f56efffffff: value 140011362058240 (0x7f56ef800000) [0x=
feaddf000001]
    7f56f0000000-7f56ffffffff: node 0x61c000737100 depth 2 type 1 parent 0x=
61c00073691e contents: 0xfeade0000001 7F56F0020FFF 0xfeade0042001 7F56F3FFF=
FFF (nil) 7F56F5FFBFFF 0xfeadebff8001 7F56F5FFCFFF 0xfeadebffa001 7F56F67FC=
FFF 0xfeadecffa001 7F56F67FDFFF 0xfeadecffc001 7F56F6FFDFFF 0xfeadedffc001 =
7F56F6FFEFFF 0xfeadedffe001 7F56F7FFFFFF 0xfeadf0000001 7F56F8020FFF 0xfead=
f0042001 7F56FBFFFFFF (nil) 7F56FE7FCFFF 0xfeadfcffa001 7F56FE7FDFFF 0xfead=
fcffc001 7F56FFFFFFFF 0xfeadfeffe001 7F56FFFFFFFF 0xe
      7f56f0000000-7f56f0020fff: value 140011370446848 (0x7f56f0000000) [0x=
feade0000001]
      7f56f0021000-7f56f3ffffff: value 140011370582016 (0x7f56f0021000) [0x=
feade0042001]
      7f56f4000000-7f56f5ffbfff: (nil)
      7f56f5ffc000-7f56f5ffcfff: value 140011471093760 (0x7f56f5ffc000) [0x=
feadebff8001]
      7f56f5ffd000-7f56f67fcfff: value 140011471097856 (0x7f56f5ffd000) [0x=
feadebffa001]
      7f56f67fd000-7f56f67fdfff: value 140011479486464 (0x7f56f67fd000) [0x=
feadecffa001]
      7f56f67fe000-7f56f6ffdfff: value 140011479490560 (0x7f56f67fe000) [0x=
feadecffc001]
      7f56f6ffe000-7f56f6ffefff: value 140011487879168 (0x7f56f6ffe000) [0x=
feadedffc001]
      7f56f6fff000-7f56f7ffffff: value 140011487883264 (0x7f56f6fff000) [0x=
feadedffe001]
      7f56f8000000-7f56f8020fff: value 140011504664576 (0x7f56f8000000) [0x=
feadf0000001]
      7f56f8021000-7f56fbffffff: value 140011504799744 (0x7f56f8021000) [0x=
feadf0042001]
      7f56fc000000-7f56fe7fcfff: (nil)
      7f56fe7fd000-7f56fe7fdfff: value 140011613704192 (0x7f56fe7fd000) [0x=
feadfcffa001]
      7f56fe7fe000-7f56ffffffff: value 140011613708288 (0x7f56fe7fe000) [0x=
feadfcffc001]
    7f5700000000-7f570c7f9fff: node 0x61c000737900 depth 2 type 1 parent 0x=
61c000736926 contents: 0xfeae00000001 7F5700020FFF 0xfeae00042001 7F5703FFF=
FFF (nil) 7F57047F8FFF 0xfeae08ff2001 7F5706FFDFFF 0xfeae0dffc001 7F5706FFE=
FFF 0xfeae0dffe001 7F57077FEFFF 0xfeae0effe001 7F57077FFFFF 0xfeae0f000001 =
7F5707FFFFFF 0xfeae10000001 7F5708020FFF 0xfeae10042001 7F570BFFFFFF (nil) =
7F570C7F8FFF 0xfeae18ff2001 7F570C7F9FFF (nil) 0 (nil) 0 (nil) 0 0xb

...<lots more tree stuff>...

Pass: 609373594 Run:609373595
maple: ../../../lib/maple_tree.c:7110: mas_validate_limits: Assertion `0' f=
ailed.
[1]    855591 IOT instruction (core dumped)  LSAN_OPTIONS=3D"report_objects=
=3D1" ./maple
LSAN_OPTIONS=3D"report_objects=3D1" ./maple  128.63s user 66.12s system 444=
% cpu 43.818 total

The middle node in that output has the issue.  If you notice that slot
13 and 14 have the maximum limit here (7F56FFFFFFFF) so the verbose
output of the last value/line is not printed.

The line "0x61c000737100[14] should not have entry 0xfeadfeffe001" is
telling us that there is a value beyond what is expected, and it is at
slot 14 of that node.

A bit of context for the test may help.  During the development, I was
seeing odd errors and discovered that I was not clearing old data from
free areas of a node sometimes.  It was not detected because the maximum
value of a node is hit, until another modification caused that data to
be re-introduced into the tree.  This test detects data beyond what is
expected to be the end of the node.

This would also happen if you copy too far, but that shouldn't be
intermittent, assuming the test is okay.

I re-tested today and it isn't happening for me now.  This is probably
an RCU error that is intermittent.  The problem may not even be in this
patch - if it is RCU it probably is not this patch.  It seemed to fail
consistently on this patch - and I reverted the previous patch and also
saw the failure because I suspected it had a potential RCU issue, which
you pointed out was not an issue.  I wouldn't expect the issue to be
this patch because we use a new node in RCU mode, so the node with data
beyond the end would be in the tree for a longer time.

The failures I saw were always the same.

Could this be an append operation caught by RCU?  It might just be a
test issue and your updates change the timing?

>=20
> Thanks.
>=20
> > > -	} else if (mas->last < wr_mas->r_max) {
> > > -		/* new range ends in this range */
> > > -		if (unlikely(wr_mas->r_max =3D=3D ULONG_MAX))
> > > -			mas_bulk_rebalance(mas, wr_mas->node_end, wr_mas->type);
> > > -
> > > -		new_end++;
> > > -	} else {
> > > -		if (wr_mas->end_piv =3D=3D mas->last)
> > > -			wr_mas->offset_end++;
> > > -
> > > -		new_end -=3D wr_mas->offset_end - offset - 1;
> > > -	}
> > > -
> > > -	/* new range starts within a range */
> > > -	if (wr_mas->r_min < mas->index)
> > > -		new_end++;
> > > -
> > > -	/* Not enough room */
> > > -	if (new_end >=3D node_slots)
> > > -		return false;
> > > +	else if (unlikely(wr_mas->r_max =3D=3D ULONG_MAX))
> > > +		mas_bulk_rebalance(mas, wr_mas->node_end, wr_mas->type);
> > >   	/* Not enough data. */
> > >   	if (!mte_is_root(mas->node) && (new_end <=3D mt_min_slots[wr_mas->=
type]) &&
> > > @@ -4128,47 +4103,36 @@ static inline bool mas_wr_node_store(struct m=
a_wr_state *wr_mas)
> > >   	dst_pivots =3D ma_pivots(newnode, wr_mas->type);
> > >   	dst_slots =3D ma_slots(newnode, wr_mas->type);
> > >   	/* Copy from start to insert point */
> > > -	memcpy(dst_pivots, wr_mas->pivots, sizeof(unsigned long) * (offset =
+ 1));
> > > -	memcpy(dst_slots, wr_mas->slots, sizeof(void *) * (offset + 1));
> > > -	dst_offset =3D offset;
> > > +	memcpy(dst_pivots, wr_mas->pivots, sizeof(unsigned long) * mas->off=
set);
> > > +	memcpy(dst_slots, wr_mas->slots, sizeof(void *) * mas->offset);
> > >   	/* Handle insert of new range starting after old range */
> > >   	if (wr_mas->r_min < mas->index) {
> > > -		mas->offset++;
> > > -		rcu_assign_pointer(dst_slots[dst_offset], wr_mas->content);
> > > -		dst_pivots[dst_offset++] =3D mas->index - 1;
> > > +		rcu_assign_pointer(dst_slots[mas->offset], wr_mas->content);
> > > +		dst_pivots[mas->offset++] =3D mas->index - 1;
> > >   	}
> > >   	/* Store the new entry and range end. */
> > > -	if (dst_offset < max_piv)
> > > -		dst_pivots[dst_offset] =3D mas->last;
> > > -	mas->offset =3D dst_offset;
> > > -	rcu_assign_pointer(dst_slots[dst_offset], wr_mas->entry);
> > > +	if (mas->offset < node_pivots)
> > > +		dst_pivots[mas->offset] =3D mas->last;
> > > +	rcu_assign_pointer(dst_slots[mas->offset], wr_mas->entry);
> > >   	/*
> > >   	 * this range wrote to the end of the node or it overwrote the res=
t of
> > >   	 * the data
> > >   	 */
> > > -	if (wr_mas->offset_end > wr_mas->node_end || mas->last >=3D mas->ma=
x) {
> > > -		new_end =3D dst_offset;
> > > +	if (wr_mas->offset_end > wr_mas->node_end)
> > >   		goto done;
> > > -	}
> > > -	dst_offset++;
> > > +	dst_offset =3D mas->offset + 1;
> > >   	/* Copy to the end of node if necessary. */
> > >   	copy_size =3D wr_mas->node_end - wr_mas->offset_end + 1;
> > >   	memcpy(dst_slots + dst_offset, wr_mas->slots + wr_mas->offset_end,
> > >   	       sizeof(void *) * copy_size);
> > > -	if (dst_offset < max_piv) {
> > > -		if (copy_size > max_piv - dst_offset)
> > > -			copy_size =3D max_piv - dst_offset;
> > > +	memcpy(dst_pivots + dst_offset, wr_mas->pivots + wr_mas->offset_end=
,
> > > +	       sizeof(unsigned long) * (copy_size - 1));
> > > -		memcpy(dst_pivots + dst_offset,
> > > -		       wr_mas->pivots + wr_mas->offset_end,
> > > -		       sizeof(unsigned long) * copy_size);
> > > -	}
> > > -
> > > -	if ((wr_mas->node_end =3D=3D node_slots - 1) && (new_end < node_slo=
ts - 1))
> > > +	if (new_end < node_pivots)
> > >   		dst_pivots[new_end] =3D mas->max;
> > >   done:
> > > @@ -4429,7 +4393,8 @@ static inline void mas_wr_modify(struct ma_wr_s=
tate *wr_mas)
> > >   	if (new_end =3D=3D wr_mas->node_end && mas_wr_slot_store(wr_mas))
> > >   		return;
> > > -	else if (mas_wr_node_store(wr_mas))
> > > +
> > > +	if (mas_wr_node_store(wr_mas, new_end))
> > >   		return;
> > >   	if (mas_is_err(mas))
> > > --=20
> > > 2.20.1
> > >=20
