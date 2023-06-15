Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F09D731157
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244009AbjFOHue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245220AbjFOHtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:49:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66524123
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:49:38 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EJjiGu009857;
        Thu, 15 Jun 2023 07:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Pm9ZU2x4lMk99hy/+jjjyCNRCERnzIkCFUchjyqd6bU=;
 b=hvUXCPIFdFmlDNhbCEIKeZtUKiR5b+YqB8m+4HG2U5LdNcvCOUyBizbLvIWJUmgjYLL2
 pJtU5E79qhxI1tY7ynFXDn2KigzahE35xaDC0C0NJmKaYB9vup0ANiH5YZlTbuZs2aSw
 I7tBDHNESJyi/kDM1WW2Y/LNaWPZBbGg+DsFVrvcFiDGi5ZWO+5SbF4jr7Wdpot4cf7M
 LcVb6I69oFkLsUl3F6VU7ihKYqQAySTPDOmXCguO7xPZSaMx8ohMIC8XWRuM4ZtGaTFl
 RXIwPDf+849SN4hR9vxLyOC3T4dit/HC8jYhA+5DyVcVJcJ/jOferexoiBCnvbKfNWDl Zg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4g3bsf53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 07:49:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35F7CRAm017814;
        Thu, 15 Jun 2023 07:49:26 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm6aupe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 07:49:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BG5yDxkuUws58Bk5G7l0RRwjnaanA1/TGBID8/x+Bs12ezEj1UA5By7yLUUpDrHZo+3YHJ7OXAmtv9dFnQ+Yob8LW0eDYXf26oPPplU1VxdtFw/kx1Ow5mLohatPQ8tHv23IKSzYaoOHzydelA6SIoekPKtRJ0X8hli7m9abnzcRUpvfhzgZwIMzkoPA5Ztv8WwHevEJmmgZtMPpCBkJvW4q07C2U1h7/cD5R/9GLvnKDfSqu74dI58YCLJt/wdXvY0i1sS9eeOXQilnCdDLkMzZ/NErr5MBLEygM9IFbYVEhqrYptmBHEVQa+GktPHSpcPEnaRV8ujFyKdmP92NvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pm9ZU2x4lMk99hy/+jjjyCNRCERnzIkCFUchjyqd6bU=;
 b=DE+BKrY6W7RjGzDf7FkQ5+urgS2c3yrjk01UYcumkP2HBUNzjc89JmliTCCi8XR1JkvFOWxNB9JjdGZaFuiKyH+DTULTNoICglGBT6Kh0m8WmA/59UQdKzNEcZf+Lq3S8gUVdkw5SlOx3DEWz6AgdH7SGOfUjLnJyZg6MNXeG58GrfkU0vwEGTC36yFlBJwY62nj5c7fEpv94CqM9BXV2p/TuM6wNjebTNkQL5cSHeOSYJPc+thmnNoEJF2bvX94tSA098gUnxvpxha50dmMDkXEX4sjElr3VKBfFunQ0iFft8+CN5Z1wExdNKe6wXQ9K4unhh14b+YP3xKfT1aVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pm9ZU2x4lMk99hy/+jjjyCNRCERnzIkCFUchjyqd6bU=;
 b=zjQTLK6c/noF2drgfB+tpkR3h5zloO/0fr7HVE0pCYaF0km2Lq0v1xWbaD7hef8OLe/G35gyRHSMRvac0gSzYd5QlCMXFZtcuUxlBbcFr0xNZ2NrJN1jSIpzFnwjyWVgLlaab20iT2NziFDzwQkHf5C5Vs1LPRESu5L6c6P/E/Y=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6801.namprd10.prod.outlook.com (2603:10b6:930:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Thu, 15 Jun
 2023 07:49:24 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 07:49:24 +0000
Message-ID: <4f9184c5-e6a2-08da-f44a-3000b6cdfe35@oracle.com>
Date:   Thu, 15 Jun 2023 08:49:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4] iommu: Optimise PCI SAC address trick
To:     Jakub Kicinski <kuba@kernel.org>, Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
 <ZDk83vpIarQ9jWa7@8bytes.org> <20230613105850.30172085@kernel.org>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230613105850.30172085@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0060.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: bdbb2cec-a7bb-4c46-b872-08db6d7509c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F9qFygbEdA+eJZImZwtKE3Mj9UQSXA4pxCxNKx48oK8mTrFZTBSOP6T7dyXfCS9bDDpt/ticwQl3FC0Tvkh/zrJN6bdwX1HUxpvqg5CHfSFlARbp1agUZv7gkEVfs3Kjh5eUpU2/KChxNk42fR/dvZaZ1SMkgwiAJABgC60DgbafwH5aAqGn1x7tYSlEt7yesK4vRf/f6tEZlmtytGk8fp0SdsPW78sIFHb3cX+97yn6PyYN1PBlrsZnlmHYz+LfMsoK/FycLSfEJRwumsLJIf9yTQX2TYJgddnlnKlj6Gv77C+dqs9lObZV9LQkkwP9o/AVuB0GRGn+cz4W5+ivb0ABdlQ9OFzRq05VlsoVDE6RKcnrlD1MCjahbhDI71gdEZBslZ7K/fwyygnaBZxRIsjv6WECFxMmfJ5GOngvwd/DnKSzVquBNfpUC59rHeP8YxTLDXhdJx2INDO41HgldgZR8WJtEXdvr8t7gUeyAi4S3XRLtqXSYaWhpWRu5woIHL2hjQJQesi+jvVv0N6KrCtMxGjNl2gCvwzm5t5zkS5qeJN0fCtN3Gqw0pYQdEy/U+hera0Pd00/ZGsxNJBMqTiQ5OiVYNXJeYsHX7U/1Kcz2mT61+fUCdooIAUavT4eFrnpUW71cWh3C68nZuVVjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199021)(31686004)(66556008)(31696002)(316002)(66476007)(66946007)(6666004)(54906003)(4326008)(478600001)(110136005)(36756003)(86362001)(53546011)(26005)(6506007)(186003)(83380400001)(6512007)(4744005)(2906002)(8676002)(8936002)(5660300002)(6486002)(36916002)(41300700001)(38100700002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEpZQXNMSEFqbHN3aWJMODBvbXAvdlhYcmtZcEpTTVhNTVM2RnRMd0owSUR0?=
 =?utf-8?B?MGdmTW1ORElWb0ZDci95Z3FaREpUZnF4bENrVDl5emZMOGVBeTNSeW5oL0xn?=
 =?utf-8?B?QVVGR2NDTlkrOE9kVEU2dVdKWDZsNGF1eVJGOW5IcGFIN1BhUXhCcVZDNDBY?=
 =?utf-8?B?RFNjc01RdjQ2MkRBL0lrdlBIMjY4ZWVPWHgzWEZTV0J3RnZEcG54ZGNkVjg5?=
 =?utf-8?B?MVhGcGRnU0EwTElreFFaZ1pLM081S05VK2toeFk4NVczbFViQ2tZakRTMXZa?=
 =?utf-8?B?MnBKbWxpcmdUOEMwOUFLYjlndkkzNnFDRUcvWnkzVnZSRDkrRHRYak1aeERv?=
 =?utf-8?B?T0hDK3I4TGpMTTFyMkVESm5jdDl2WmM2YnBLTEpxWi94V2k3ZDNWbmp6MTdw?=
 =?utf-8?B?OU1xajIwZHNzMndEMmkxLzA2RzA5ejkwRWhWWWQrci85VnBBdnNUMHc0aDJ3?=
 =?utf-8?B?S3UzK1pKVmlNdFVBYXc1Snk0MG5RS3A3dHBjRXBaQWR5YjZ3TDkvTnIvQVRW?=
 =?utf-8?B?ZTNQTGxQOU9PVXBYcGlzSURMOTBaTDFkVkJmZFkxS1lxTWxIVTc5ZU9OdTNN?=
 =?utf-8?B?OXNaZzlwd3g1TUlvNCtiaVYvUnhkOVJmbmx6cWgyUkhoQmVINEVwazF5ZUFw?=
 =?utf-8?B?NDZEdFN2d3dYUnV2VjZyc3llTHpLMVBJZlNVUDJqWGN2ampvMUtoK0JkT2p2?=
 =?utf-8?B?WC8xcDA4ZjNyQWtzeHFsMkVBb3RPRWIycGlVdGhRSmlQNXJkZW1nTHQyRHU2?=
 =?utf-8?B?dHNyRlFja1laZTYxWFdEL3pJbGIzMWl4c3BFUFVJUm9jK2g4TS85ckZxbWp1?=
 =?utf-8?B?aDJXK0VkU05QQXhNUW1XNE42VEtIS1ltMXZFb1liaEhITmppKzl3T05pSEU1?=
 =?utf-8?B?SS8ybWRPcXpKR21DMmQ0QXo5dmdEeXk3UzdFT2pnZXF6YlNkbnFnQVdmSG1W?=
 =?utf-8?B?L2RvY2p2WC9jMlYxL1FsR2I5QWlTdTVpT05WenpWNHg5RkJkUllvaHo4UGs4?=
 =?utf-8?B?cEdBWFpxcjlzV0RNbVZJYk9LbTQ0QlRrNTJOMlR3eHpLUTg0NjFBbGppYU12?=
 =?utf-8?B?MFNhb0NNb2tXeG02Zjg4aGxGN3JVRm5jTFFabXRUUUJUQlMyaEFKZXlzc3hZ?=
 =?utf-8?B?UWp6eHl1cWZLMXBDdXlQSEZwT1ZSRTRvTnhRY01KbjVPUC9xV3J3dUUwTnUr?=
 =?utf-8?B?dHZHVEU5RjZvS3NUN3YzamRldlNMZVc0WWRQVGt4eEpNVGpBWHcxbjBPb1dN?=
 =?utf-8?B?TFdzUTlCMmlDWUYzWHp1by85N1VLL3kzU2t2dFlMVmYzUVV2eHozZlFhTEw5?=
 =?utf-8?B?MHhRMVdjNEZkYSs0SE94UzlxWDBzK1hWV2RvV0c2dkRkdlZZTXRIUUIzTEdP?=
 =?utf-8?B?WGF1Tkp2K2h5UGRuM2E3cUZHSXQ0cUxvTGo2dFRWY0tURmFiU0tvZjk0R09y?=
 =?utf-8?B?QldoVXJUa0VYUEFOQ1VSKzIybkN4TldjOGFlbEZqQUh3UUJVN1dCajZPcmNM?=
 =?utf-8?B?TjFVMFhQVzNOVzZkVTRTME5vVTBjbU03MUtGNWdkTFY0cFRrcTlQdnpYOWFO?=
 =?utf-8?B?ZVpuWUV1L1Y3SWt2UUYrMXI2Q0FUaC9NaGtPUEtvbXpnSVBFallWc215Q3BJ?=
 =?utf-8?B?Y0prTVFGeDBURU8xVExqMkd5KzdmcTNRVmwySzByY0pSYTlnellRTXJ4M3NB?=
 =?utf-8?B?RWhJYnFGeG9MdkR1Y21FVzN2R0t0R29WNytaZk5JQWdzd2NnanRMdjFSQWNH?=
 =?utf-8?B?S0Iybml6NTh2Y2hVeVhYdkQwN2ZhcFRCU0xCT1pIbDNlYzI0bk5SYnBTbzMy?=
 =?utf-8?B?NldOSHQ4cEZReXM0RDQxTGNWTTcwNzB0clVRaXpVS1JTZXFsQzZLWXV5eFk4?=
 =?utf-8?B?K20zV0lvMDJGSnNuUU5mNmdFODNIbzc4Y1lZTTVWeURhendtK05iR0lVMktN?=
 =?utf-8?B?b3grVzVWcTdVWG5seU54ZEtGRnJKQkJoTjNLUlBWNVNWVXk5ZlFueHc1WHNL?=
 =?utf-8?B?d1Q0R1VRZFAybHJDeDlpaktjdmhUSHpESmoxcldrclNFT0VyOWZPRVVhT2VS?=
 =?utf-8?B?cEZSak5iV3VoT0R2dDV5d0VDblA5RDhTdTJaZkh2ZXVIYjJiYXBDSlJYdXd3?=
 =?utf-8?B?dGQ4eUdQTXR6SEFEZ2NUUm9SZTA4SHA2SlRCQ0lMalRwYmZrWHNGaE5ydkg0?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dkJUemxmN2R5OTQwaDByaEk3cnNhSTdWVENOcnFEMHp5azVaOFNUSVA3blE3?=
 =?utf-8?B?dktIK09Gdm0ySDVwZnRzS3h4TTBubzBKWGZHTmxwR0RDRmJpR1gwSkVJdlIv?=
 =?utf-8?B?WDJtbWw1UXpEcEdMVDFkbHUrcGloSEh6TjR4Q2lQSTUva3FQT1hoZ28zTG9o?=
 =?utf-8?B?YmR1eFhwRmlBa0Z2dXI5K1U5NS9WM0hTc01xQzFvWFBad3d5YVV5ODVNRStO?=
 =?utf-8?B?VnFyc1NPemVBTlNqVW8zaHBZMEgySS96cU01clJ3MEFmREw2Y3VnalZEbW1O?=
 =?utf-8?B?c0F6RnNMMW5wQm45bmZDb2tpVjJuaFY3Zm8zcmNOLy9ZdnpHTDRoVDVtOUxZ?=
 =?utf-8?B?cnRRbmNzUXkrd2d0NTlIWGlJd3BTWjE5d1c1bm9hYWU0eXFKd01nNUtNZmdZ?=
 =?utf-8?B?OW12MlJmSFJWNll3RDFuaFVxa2ZjU3RBWE1FcHdxL3U1dm9SMllLSi81VHBJ?=
 =?utf-8?B?ZllNYVRtcVhrWkxSRmdJdkNtak54WU9WRndFNCtkUzdzV0FqWmY0amFTYmlu?=
 =?utf-8?B?dlJLZFV4UkpRaVdlZ2xzTFlBVHBjbFo2YURBaGJZSS80VUJkSVNodnVSWmRj?=
 =?utf-8?B?Y2kvaUNUYldJdDVjZEFDbDNwKytFYXYvVjVLR0lzcWU4dVZoM3BaV2JBbXZ5?=
 =?utf-8?B?K1JPZmFGNlBvTXcrdGordzRRM3BHS0lpdWVLMmRXeEM3Z1JYRXpMWm1DUFR4?=
 =?utf-8?B?cUtLeTNXaDFDN0JHZWZvWHhnL2tLNVZ6NnZyZkJhMmtxYkZKNzRnYk9GSjdv?=
 =?utf-8?B?YXV5dlQ0SFl2aERXQkVIajIxelMvQnpveE9Felk1eTUvTGY4YTVQMVdxY1Nl?=
 =?utf-8?B?NEVuQnZ0Ti85T2dBRDhKaGh2b0ZaWDlzY3dybUtLeER6QlZFaWFac1lyZ3RT?=
 =?utf-8?B?U2ExeGk2cFNnZWJ5V1EzT0RvWk1Wb3RzdWFiNUtDS0FkbVlNRkxCbVBaVCt6?=
 =?utf-8?B?NFhCWWswbC9QRThmOGpOeWwwbmNwdnEzZk5kYk9FRHdyaG1ONUt1dVQxOHRH?=
 =?utf-8?B?U2JRNEd2Z05ITlZ5Yy9ZeWdydTNUOFZSQU1VSnNKOTZnY1d1NjlsNGI1UE9Q?=
 =?utf-8?B?T29aTjVsUXhkMkYzUWtJNTEwOHUrKzRqcXVKOG1GdHMxYXliRU5zOG12ME9V?=
 =?utf-8?B?WCtxS0FlUUVDZnNIL0cyanU2NUtHL2cvOWxQbTdtTk9DQ2wxaEkreEVneUlk?=
 =?utf-8?B?TktHWm5XL3FWUWVmQzJXREZCMTVBaExZRjI3K1ZHdFdwc0xodVppc3NrNGhu?=
 =?utf-8?Q?kKMFp7NOsLbIdnU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbb2cec-a7bb-4c46-b872-08db6d7509c1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 07:49:24.7256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2U+0BbRIXIWJs4qBmA7zRz2YlXuysgEORyskNrMu+9GSV54OdTlJzYTJhwZVdge26096eapXSic8f0CYW45C9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6801
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_04,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=763 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150065
X-Proofpoint-ORIG-GUID: 36WqDo0S0qOaovU3_ghjSfg8UGUER_m_
X-Proofpoint-GUID: 36WqDo0S0qOaovU3_ghjSfg8UGUER_m_
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2023 18:58, Jakub Kicinski wrote:
> On Fri, 14 Apr 2023 13:45:34 +0200 Joerg Roedel wrote:
>> Thanks for working on this, I think this is good to go. But given the
>> issues we had with last attempt I'd like to have this in linux-next for
>> a few weeks before sending it upstream. Therefore I will defer this
>> patch and merge it early in the next cycle.
> Is this patch queued up? I don't see it in linux-next and we keep
> hitting this issue in production. After a few NIC reconfigurations
> IOMMU starts consuming 90+% of CPU time.
> 

Since we're at rc6 time and a cautious approach was wanted to merge this 
change, I doubt that this will be merged for this cycle. That's quite 
unfortunate.

Please note what I mentioned earlier about using dma_opt_mapping_size(). 
This API is used by some block storage drivers to avoid your same 
problem, by clamping max_sectors_kb at this size - see sysfs-block Doc 
for info there. Maybe it can be used similarly for network drivers.

Thanks,
John
