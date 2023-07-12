Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A2B750562
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjGLLDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjGLLDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:03:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D393511D;
        Wed, 12 Jul 2023 04:02:58 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C710Xj015518;
        Wed, 12 Jul 2023 11:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=hgEVVQVsxDk5e3npabC8ZdO7P9cxhWK0s59fcr0ubK0=;
 b=TX5s6Cv4D+VcndWX8ppChDml9c6t33LVJdF757B7eIr1+7Lcs42oZGVzN30mSzgh//rx
 WtxhgnEpDhG8aih9KRGnxwVuh7/cZSwgLHHJw4GH68pVTk4sTj1UyxeQIwGFFhDnmfy/
 7lxHCF9EOMdJkoFiUNt+1ibDzvc8uj8pRAbn9jldVikxRdo3xFVhVrFTQiCM/fWeoBVR
 4cM4alfOdKnaNQSRh3DC7n/16+N43YzFFfE0jpFqbjXie84nz1onofYOchNwCuT4LcHt
 058fM0CQxYibzf/W401knF3k5zngwLe6O+CvoiiIMOSc+vG8Aj2PxwYJYqA0hIlp1ixj ZQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrea2vyw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 11:02:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36C9opIL008283;
        Wed, 12 Jul 2023 11:02:47 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8cmun5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 11:02:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acXTC/jdBQJeQDxsue2gd9x/0cSQyM7sPoOrtI7RZ1URUwAcNKRNDmpgTuO6JYJKtwpeoi5v7dBWr2DdMTAmbs34BKMwI7lfeMN7SUVRrwZQX0413rWatncL2oFlc1mkGVg6ytE6n8svveP+JQGkHtcxMqfT9tr2CvaLK2X6L6cAOZlYB4V+OxO2I52uYUTMdbqbFJ2Ydl2TFjf+ETfgvDWVKswiGwq2CIPEGzDqcLmBWAB5ufgeZWxgVCWYeQNxcbAPaTHKlfXduHhyz6gdaMENBxwEWUH7ywZPdF7co2MZzmoGPPkr+uy4Jcu0FPS8oEsfi8XzZ93YdIg800ZirA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgEVVQVsxDk5e3npabC8ZdO7P9cxhWK0s59fcr0ubK0=;
 b=b2U4vlhE07FYdOSfkVUIc5nw5AIKo35q3j7xxUwYeu0RPIr4iJWm8WoEPWVFzW/1mtvmbQq94sV9rcv3uZAJEpGuupeksekmspyqNEv8PXmIyBG0UjAyHoJrczZWUHRzR6LhdFwURURDL5mUGCsn6TYuccbqQbeMvhOm9lT6R6ZwVXMETahwsCYDsRKGPfOk8cfMnthpvfD7z0xOrgE+HtALdmpZuADVXpowjQbkQydPKS4MYJZHlE6PD/GSB4wl9vMVVCNL0BHyxi4reWmiBXGCVfMmtJIXVkU/3OMYVJ8vpITEB7N+OaLWDzoySY4/rCVwxZyQCWwJwBwrHlM+yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgEVVQVsxDk5e3npabC8ZdO7P9cxhWK0s59fcr0ubK0=;
 b=VuzxwPmwsJK9c7sYlDFrg7gTt5+bnPwzFY64jvy/+gt/ezQsVFeR5xjRFjQnZG6MKq5m2VsLYyBh3Y6RfiSW41G73IBRyY1jGWH02i3cxHcg6Z6KSXit65z2Ifc2UDZId8MakmA8pIPmoiWEtUJizVIsnm14b/K8NA9EJuZzC2U=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4527.namprd10.prod.outlook.com (2603:10b6:a03:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 11:02:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 11:02:44 +0000
Message-ID: <35256e49-2a34-1334-698c-161d443ab3fc@oracle.com>
Date:   Wed, 12 Jul 2023 12:02:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/14] UFS: Add OPP and interconnect support
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0057.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4e4041-cb7a-4bce-35c3-08db82c784be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QXcUnorhcxv6j7woh4u/dL4QCmxe1kIKru5kmpb3TE0xCYtcd/HVv4i0RhRfzJWCprjx8uxt97FzUSMFl3aguSS7mbeJlfp348psFFmHZ9/KctRZE6Ci56LzgLq9d5JNvR+9wCKIpuajrqId4VXoOqBlniOjJ72F/I1S/17/brUDH52mkHul0MSauB2VWAZQ44oW0zbPTZMhM6U+KH3vWle90mKJS3ugt/82+5iRWGtsJJ217yFNRIvFqnab/QroVjquW1hVsQzin6uRyTXfQtzMRoG+xM7hPx7eKmchRnUvmoukxI9ptks35U/tw2JagSg63XYGs9V71nRhzDBnip5LhZxRBc0FTY5J6PjOB6cG5EJibOx1U+SwoFiKafb64qMKSWrPkrOGA3qoE9rGfRlY1ax+a2xSNZlR/lzkIHT9kN3b/YFrLklLIsxKkl9RFpoVmwKWQaoRalawwHzdeIPtVBQrBmS9/0uUlCnYfdbGzJ5TqXLgu07LcShLWdMqLlsT9jLllgdsY3vshmJV5X/Ui7jZ+TK0MjBpL0ej5bP+7Kiz4MtrnMrLa4rQNfrebmUtFV8WzotlKN6CXDtTHWPwZ6YQhXmhEwcbKT9uNdooC///VmFD8QHOZs0OlE1AX0t66w7XdoMaIdj9w78lA6Lig/2E/JlurROKZnyH9VQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(478600001)(6666004)(36916002)(6486002)(6506007)(26005)(6512007)(186003)(66946007)(2906002)(316002)(41300700001)(66556008)(4326008)(66476007)(7416002)(8676002)(8936002)(921005)(5660300002)(38100700002)(31696002)(558084003)(86362001)(36756003)(83380400001)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGZFK3E4c2Z5NVh2M2J2dktvdnNqOXZUSW14WDNRK3dQYVhCdnpybDJwSnRH?=
 =?utf-8?B?N3BLWEZXTzVSclRIajEwcCtVbThFN3NhY2REVVovUWtUWXZpK3l0RHhhMFB4?=
 =?utf-8?B?OXhpL0hzaEpRanhIL09hV1VIZ2k3elFhVHRBWTNiVzRnZ2RZdmpWYXlPeHBY?=
 =?utf-8?B?emFRd3VCVTl1a1NuU1FkaVgrVTArQUdKTWpzRHZnWXdwSzAvdTE0SDFQRklH?=
 =?utf-8?B?YTJIYmcxKzNEMUN3Nis0c3JUbnhYbUxaZ0RoaWRpeUM1OXI0Z0JGM1VtOUtn?=
 =?utf-8?B?eUFzcnJFN2xPVklTMEFHU1ZQL3g2d3YxWHVQblNUTHp6SURod0lOVkZHaEwy?=
 =?utf-8?B?OFN2M0ljZ1BQejQvdm1HRVhiUFJDd2VaRzRxdGlIUUt2cTJQZkpDL3dvR1NR?=
 =?utf-8?B?Y2lYOCthY3hYcU5FVnU1S25JeFhNZ3IyWnNCSFY3N3Y4Ly9ORndsMWQ2d1dt?=
 =?utf-8?B?QkJlVms2clFDR3kvbUgxOFBmQlNsY0NNYjBudU9rNVdTU0FSaFRRTmV3L0xz?=
 =?utf-8?B?TlBnY2VuQzNjaTFDRWNra3RpaWMwdzJHd2tJUHFPaFpKaHkwVnltSHZET1pl?=
 =?utf-8?B?Vms0N2ZIWmxVMzhsdGpjdXlQK2xQK2Z0ZzE3bGg3cExZVHZ1TGxhQnFYc0N5?=
 =?utf-8?B?RGVtcDVzaFF1MGNIM3BJUE9vQXE2ekhLTXJOZXk2Nmg4cUJPbFFmRFZSZVlN?=
 =?utf-8?B?aElpTjJreGoxcDIxdzAzbllTQTU3OXVFQVpyRmNwUDBzSkdZUS9MRU9qM1Iw?=
 =?utf-8?B?SEpCSk92a0cvMk1BeVZaTVpHbjFjYWVRMDB2eEtGbWhVdGdJcnk5aGJ5SjVO?=
 =?utf-8?B?eWthUTFucXkvaUhUd1FBVkVRZkVzV1RxQjNNQnRTZ3FIbmE2M2NvYWJPK1cx?=
 =?utf-8?B?VU85NmtSUU5KOG12VDc4eXJTd01aaksrRHhra1pNcmJRWG9QL0MzczIzU0Fm?=
 =?utf-8?B?b21GaU04VU5URHVUUnFPci9lYVYzd0xDWWdTNFdMSkVkTnEwcjE3ZEpWancx?=
 =?utf-8?B?R1EwbXVaNEhyUVNqS3BKWVZ1YVFyUnR2d2tZNVAxaHRKT3dmRWIvdlY3aE1N?=
 =?utf-8?B?VUUwM3VEN2dlR29ld3I0aWhtMnlMajB3cUdEME1UQ3RTNENyMjhCb29WVFlw?=
 =?utf-8?B?QTR0NGNndUkvSU1Ed2hPQzZBSDNhQzFvN0JWalZNYXQrclU3KzdmTURwSEt0?=
 =?utf-8?B?aGZ5NUN1WUR6Mjd1MlVYNlM0eWtBemFIMlErNjlyNzdIMFNJTVFCTWg2UUFP?=
 =?utf-8?B?MUtDa2dyV3lOWHQwRTlSclRxTFdIaXI3WlBQZFJhVS9oNUg1dlJJTjdjdzZx?=
 =?utf-8?B?amtoNTc0WU0wL0FWRzVqZGlpblgwcllXK2dNRkxuQTA0VHBrYWxicDhoaVVV?=
 =?utf-8?B?OW1vZUxVRFlpYWlNa2JYS2QrMytKaFhOTEJXVG1yMXBsQ24xWDRPSmdCS0s5?=
 =?utf-8?B?Um5hQmpWcWFZY1BrZHpySjFvbHIwcXhrR3RyYzN5Y3Ixcmw0NTdmcmRIb2Fj?=
 =?utf-8?B?SlhmRVZRVUNzV042RmFuL1BFOFNCcFNJUG9zcDRJaXRjckFjVVNFd0prbUc0?=
 =?utf-8?B?MXFYNUNsdTR5VGVQdWlmeUhPZG51N1pGVm91Yk5MeDhUajI3NWNobktGZjJm?=
 =?utf-8?B?S1FYcVJuNnJLc0JETnFNMjY5VkZVNUdoczdlNXQwclpVZ1JOdHNhbk51amlM?=
 =?utf-8?B?ZTZkRWRVV3h3ZHkzeVZxMkxQN2UxSDBLUnpqZUVaWlkrVnd4TmVOQjhGTHVL?=
 =?utf-8?B?cmdYcmFvK3JJazBCR2ZpdEtoZXRHdmF6RyszWU0yZ0lqcE44TUtZTE03MEdJ?=
 =?utf-8?B?bElkWlRUaWgzakxHZ0dEUTh0RzJzWVhLdnFaQnU5bVI0Z2NQMTJOYm1raEFy?=
 =?utf-8?B?Rjc0cnhFS21lVnB6QXpYVFE2dXA2QXV6TjlXb0UxNEFndG14TFFOaWJMR3g1?=
 =?utf-8?B?K1o3UWhaY1U1RkFKSWtuSllUMVM3dTBNcWZXdWF3VWg4UWkrRk12d0g5U21X?=
 =?utf-8?B?RThPVjd2ZytMV3pGZW1XZllKR1phc0ZTTU80YnJ0T21pZHVyN2orYnRMUDg0?=
 =?utf-8?B?bm9rZU1zSnVibXhRRnpVVXhhNDQ1NEJnaTRpaUNIMWErdkdDRFRPZTZFcGNa?=
 =?utf-8?Q?BrvCRfUHMafDROSoQ7oYPODiv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NWovTzRwRVBOTlFKQ1BweThWOENYMUNzeXFCbFdNcXo0NmFmWWZJTFl4NFlZ?=
 =?utf-8?B?am5UbnpISjV4Wlp2Tms4blVsV0xmOW9YRjJyc2FjK3hjN2dPV2JWL3l1Yjhw?=
 =?utf-8?B?TTBCRVl2ZGNwam8xQVZmTFFFMVN2bWVSWWR0cy9mYUJudVZjZVRWNXdDMVhp?=
 =?utf-8?B?UzhaUk5xTEJSaE5ITndKZ2tLMkVjUzRSR2ZHSWpUTUpGS0FQVFJlZEdtL0NB?=
 =?utf-8?B?REVNRHg1Y1Fpd1ZWdUR5UTlmaUpJZzRLSzZLNG1ycnltOTRtWWVabTVNeUk5?=
 =?utf-8?B?S2EvNmIxaU1vY1pLcDlHMWRiQ3JPenh3QitWMXl1REV3a3pQR2VLREFldnFl?=
 =?utf-8?B?MkJ0YkdLaFY5bkxIWmFVeFRJUWwzSUU3S3lpVkFTSDJQeGwrNCs2Yy8rRTc3?=
 =?utf-8?B?c0pnOEdmMER1cEc5WkpzbWdsV1Y0d0diZllzc2FobWYrN1hmOTljdFZiaURP?=
 =?utf-8?B?cnJ2Uk5BakVLSWxZUDB0Wjc0R0hSZ0NqNEpmcXcrVmFJaG8zNmJWVjlJM2Fq?=
 =?utf-8?B?bVpPY2YzdDB6RmZ5UFFSbytLNHJKZzN6QklDR1lvNXVwZjlWazg1N1lPVkFN?=
 =?utf-8?B?VUV2SDJqejBBaVhBZzZGR2FuZUs1RDBaMUkzMkF5Y3hlYTA3NnhzV0FCeDVJ?=
 =?utf-8?B?ZkJmb1RQZW1KNXN3SXFGOW1LUmsvQzQyYTN0eVVKaDgrWUJvUTQ1YmRaZWg3?=
 =?utf-8?B?QUNjdW0xU2ZkajA0Q2gwSFVmamF1YkQvYm9pY1JBSEM0OExZUHFCa2FLaDRY?=
 =?utf-8?B?bnhPTitYRTZ2OTRBdVhrcmFEMTFmNXVXMmlSWUVGTzRsNldvNXNWNGpHYlQ2?=
 =?utf-8?B?b0Z5VDBuelp5TENDUW9yYlZzNGc1WTIxM0RxMC80dTZDL2I0V3V6SGdQK244?=
 =?utf-8?B?NjAvS0o3a1BacE1xNWJ5S21rVHVoQ1YwUEt5V2pKUjYySUdtZFJaaWt6dmdv?=
 =?utf-8?B?YmFkQ1p2TlZ4MXBvUG5pbGFaaGJFRUx0ZlFMZUFZSitZd0h0YTNsdVA2MW9X?=
 =?utf-8?B?ZC8rWHdGY0Y5cit3VEJFU0IwdDFCQk0zVVlmNllxSTRIZ1dGUmpFemhlbjZI?=
 =?utf-8?B?eEZmdU1LWk1veUJTdUZ1dlJjNUFvVk9EU1VseEhsOTZCMTVLanNmaDRRTVZk?=
 =?utf-8?B?ZEY2WHd6YS9IVHBtblFqZUY0Sit5dXNzK1p6WWRSZnlsSk9BbnlVQStENDZX?=
 =?utf-8?B?SjFNLzVzUmFScElQSGV6ckJockNmTlI3cnVDTkUyWFU3WFhZSTFWaGt1YTg3?=
 =?utf-8?Q?JbJTB0YnlXhvgnx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4e4041-cb7a-4bce-35c3-08db82c784be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 11:02:44.2401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCBNVSyWlM/ACeBKN4gKj9bD0iy+WfteHnnyga4O7+IUcnL4yAA7lx2nScJ6W1xMpfkdXtVpWo5HwPwfwkmqog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4527
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_06,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=882
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120098
X-Proofpoint-GUID: f1Nj5aCn83AWKvRoJMYZX7eYGjzv3Xq3
X-Proofpoint-ORIG-GUID: f1Nj5aCn83AWKvRoJMYZX7eYGjzv3Xq3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Did you bcc linux-scsi on this series?

I am just wondering why it came directly to my inbox and I am not the 
to: or cc: list. I also notice replies in the archives which I have not 
received...

Thanks,
John
