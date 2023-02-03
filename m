Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7A368A322
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 20:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjBCThi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 14:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjBCThe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 14:37:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DFCB759
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 11:37:33 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313HmrTO014446;
        Fri, 3 Feb 2023 19:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Go3V2m9/sJClHgfPBgGvP/mRa3nq1Sx9bI420Be7nAY=;
 b=wfKYNTRZbbupj9vvIF6zn3hqd1RCa8v0+2OqPUirJnTHwe8zI8FE7DaUYEWJBzIzVdXo
 Y1O2YsHhNjQBn7UumT/ih2C63AXY3qU1st5kesoLSIr4HJ+0Du+YxupdCezI+ITHALxw
 o2SqIXbcfgdwkvwQOsgr6VORwGrExivQN9t+ie4jPBXhU/z8g+p7aSIeZlsOzbrc/gOB
 5fSxd05WzCI1k8Cbd/wSaa/ZFgKriIoDC5/liIe847z84Flp/H39Q7C8iPLtm0yXafeI
 7zhD1ZB5UK1Y9dCKaA6GvR0Ewjjs3TVxN4O3hBNgaBhJvIle4QEPVgNCo2ZRig0Yfzl3 zg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfq4hph25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Feb 2023 19:37:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 313JApTj005969;
        Fri, 3 Feb 2023 19:37:27 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5b054k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Feb 2023 19:37:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQg/eLqAI5cA00q0bkuJCoCqdkwXAEGw3tD1i0Uw3ts3N6o5O7HUBK3J5cTS46dn554aLIQvTTNsDNLoUFyaZXQLliqQ/BQgMT0BBRvTE+/0KR3Q2kK5G8eqlRUZU4iH4xm/MypnHfO4KnVEgoYqMlqKgteCGa6I0rx5CA4Zr8rk0UilIUm0d55oelr55mtH/dXRGzINy/r5chKh1DL1fKTpfmUS0+hZnhZwOp7BnZiFH/VLr+1xhpyMxDNu8YgUT0tKxfRmUe6DpCkRZr1xS0dllOjWCmIMjnba5AXMqEMHI47JgLuZdyFc1k3zfd9aPRZuSsWMB83OeIq7qhmyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Go3V2m9/sJClHgfPBgGvP/mRa3nq1Sx9bI420Be7nAY=;
 b=HApMoswL+q+7MTe3extfpvH2kezft4SkEtD2aoqXTLxCa+5Dk7QuQs5pJQMHIeToS6AwA7rwzTAUMlm17Jmvx0PsfOu/WpIX8heEWuCB8Hpe0KbxiQ+FC3c4y7HQ8NhKPHeJvO5dl4yfCKL+syPzw/PqnZTPIfCnb6tLeJZ05+LSsmjF+TFLzQA1/DbBjx02IPFrUjO1QRS2wtCnxuWa2UWT5nKmUysYTjOuf6UOeQtrJHTt4dukZWgGOEUPs6Q7t3mqt+ptBl36UIZ4wsmlaU5QkvBJWmxaTnyV9i/xsuD9EA0Tu9xIvciYW7lYzP8SrMmyVv2TfdlJrfdkDcJQ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Go3V2m9/sJClHgfPBgGvP/mRa3nq1Sx9bI420Be7nAY=;
 b=r0JW1EJw9jVp9GJtlaSHraFWi/U8ZLkb5FZbBCxA67rPZhWrYIpPTCFCp1Jyedea9ixcAcPFhDyWa47zlW4hKnRyfLXoJDS4Vqep86tSH6I75OWxD9wZA7u1SoKFs/H+JVlpJz20hPIAhT4SOInhVAw66EzdOTaVIlc9GLYhv1U=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by MN0PR10MB5912.namprd10.prod.outlook.com (2603:10b6:208:3cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.9; Fri, 3 Feb
 2023 19:37:25 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b%6]) with mapi id 15.20.6086.009; Fri, 3 Feb 2023
 19:37:24 +0000
Message-ID: <6ad71aea-b09c-2e40-9d36-11cb4a6a9f31@oracle.com>
Date:   Fri, 3 Feb 2023 11:37:19 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 6/7] vdpa/mlx5: conditionally show MTU and STATUS in
 config space
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, parav@nvidia.com, elic@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1675207345-22328-1-git-send-email-si-wei.liu@oracle.com>
 <1675207345-22328-7-git-send-email-si-wei.liu@oracle.com>
 <20230203030944-mutt-send-email-mst@kernel.org>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230203030944-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR12CA0009.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::22) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|MN0PR10MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: 4175e10b-5cd8-45fb-d718-08db061e133e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZAZuS9Q4oNzRHqJjitQSEtyjcXG2ZHOB+HNh8IVOHJvXQqa2vrzcL7XWO9248AMLW1K7wQ6/tXJOhHwxGXdjmdih5QCbwcb1YCt+DZ4BKX52C3X6DglWom1NusYFUtJ488IP3UmfQRRadCG3OUqS5slNcx5ZoG9hPBvd0DVNluwJRF7YOef9oVFjzoMu3P9OJFFqPh+F9MqnZ8hZ1weSzjVLLp6Ci/ySbhptXUNbgRhBcYW6mZ32zDWPXnllO8J1p5pVNZAqDAHf5LzwKEqoYMwneY/pZqYtZdIKHVjPNXzK7EC/f0Jp/e6AZfi+nCVGAUf0oR90BRr4My+oSIi4Ye79pSAVQgBKvLg5dSmUt3u8I3fGXTPvtiS/vWMbV/jl9Z51vsBSmWL/6EClYLEYT+Nca0vpHp/Qt0XuvC71JtQFj7INhYoH+vLGx4ecKB2oFAQ7F0X1ZgK0UbyW0+RzPUB9lMsrrKHtiDammnzQR2fY7aqx/PNu2uXh81h3ToVZfTPuXQgl93Gk+1UATTjWcINkfNryZskmfKp1gP8JET4YzUEBGZZBXQzHyR0NsBdFRjmLyDPb8Em2KPCljPhM7s4DchXnVggiGopVILdXAw5SYLyspAoY5FwcMGJtGfMuThaYivLIXgjpDUXXvm4nE85k3XKaswcchpN47rnrt7HajSDTJMPkVWQadqzrgS7p79Uzq9o5Jab2NEHpXJtWkZBUC1TiNiIzIuxGykLG8TE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199018)(31686004)(2906002)(478600001)(36756003)(6486002)(5660300002)(6666004)(6512007)(26005)(186003)(53546011)(2616005)(31696002)(8936002)(36916002)(86362001)(41300700001)(6506007)(66556008)(8676002)(66476007)(83380400001)(38100700002)(4326008)(6916009)(316002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHhHeEJHMEV2Z3NBV0NuL2pJc2NnZXJ3anl6UjdMLzdKTU1XRzNzL3RTbkJJ?=
 =?utf-8?B?amdwSVo3cHlXL1dLVXp4cnFWUkdIdEQ0S0gxdVlWUHV0Y3AyRFM3Nmc3TlBq?=
 =?utf-8?B?dE5qYWhkMHZZQXZEWWV2RGVrRkxaSWlnNk50L3hCU1BmNC80VnhjYjhSUVhB?=
 =?utf-8?B?UXpsbHJMYmtOTzc1VXdmUWFVQktTMDdjT0w3UVlaSW8zYXJ5TWNFQjhYVjdM?=
 =?utf-8?B?TmgwVFlWYXR4aFNXdERjSk91N25MUGhMNlIwM0dCLzNWc1VMWjRSMFJteno1?=
 =?utf-8?B?WjlrMXVGcSt4YzVpZE56QTlHUUsvd3U1cEI3QTV5SFc4cVFmSGtUVWZyVE00?=
 =?utf-8?B?Qk4zTmgrQVh1VFVtcnlkajFWMktBWHkwWTNxN3lLYnR6QW5WYmFHV3pqdFJi?=
 =?utf-8?B?QTFlVHNHWWluand4R2lySFZ6SmIvTDZzdVpTdGk0T3FhYmRaN25aZ21weThi?=
 =?utf-8?B?UVI3TFdWcjUxSjQ1d2ZDMzZMNU1Xd1FyQmFRYXZ6aGFlN2F2cjdac2I0d2Jt?=
 =?utf-8?B?dmFtSzg4UnFJcmk3UjBsdnJGaXNNUFZOb3ZuWGVVdHF5YWJvWkQrWGE5Vkwx?=
 =?utf-8?B?T3ZWZ3A5NkNGR1FmUnhtRno2c1hhN3ZGRjVsV2t4WC9wL2tRSW02TGxHbllq?=
 =?utf-8?B?Z29iektIeHJQL29NNXhTbkptTkIvUDdYYzloOWpGRzlXbC85MVM0c1J4eUtl?=
 =?utf-8?B?ekZjV1VLVFZrSGxCMXpjOExPUi8rSEJjM3R3ZEY1YlVyalV2MERVa0N1Vy9I?=
 =?utf-8?B?S3AyUDI4R2tKYXk2SGFvTjY0cTZ4OG4ycmVhL2lhVXlRVEUzZk1xVldxNVZk?=
 =?utf-8?B?NWJZUVRUcXBPSWI1dTZUNlJjTmYvamVNS0tlM0NjRk9LOHlnQXJyZ0VpbHQ0?=
 =?utf-8?B?dTBCQTdCMTdybmFSL3pWZFVCcE5VdVd5Y05ITXRhejlPQkRTSVJzb01CNG96?=
 =?utf-8?B?Z01jcnRabWI3bE5UUktnRGNWWnMyS2ovZTN1T1ZoSjBJbkw4dlhrb3JZMTRU?=
 =?utf-8?B?bmJkb2VCYm92cFNjOUJpdVdWd1lNbGQ3MG9NdVBocjM4NkRLQ25lVXNJNDdY?=
 =?utf-8?B?VFFlQjNNMFJmUjhZa1NoSTk3Qjk4bWRnalRsczJOUWtNR3V5UnVaTVRGMHFt?=
 =?utf-8?B?YXF5VkYwY3VGTDUvYWlUS1pZV05IcVZraUUzeXFiQ1J4ZVArVnBUMkFmVTVz?=
 =?utf-8?B?d1Q4VnNkT0FmZGdPaHFFTVJlYm9nMmhuMkVSNUluSkgyandwQ0JiOGtyWVVq?=
 =?utf-8?B?TGNIa01vQmZLamJERG4yelJNK3h0WTBoeWxlUFhuQ09BSmthY1YzTkRsL1Jp?=
 =?utf-8?B?UVpmSnNMb2s4dTlyNDRFdjBvN3VtNHdMbzg2REVoQ0NWYVpwNEgwaHIwa3o4?=
 =?utf-8?B?UlFEcmhGYXN3aU1nL2JjTnA1c3BRa25Yd1lYdkVoYWhaOGRTUXVPNk5IS3dD?=
 =?utf-8?B?dkVCM3hic3hYemF3OGl6dU42Z1NaazZrRExnRGNHMGI2ZklrcTlVemJJVlZo?=
 =?utf-8?B?UWdNbFpteHZVdXFzV0FWYVdzZitmQ3V4VEl1K1pIUVBuMUlYck5hSFNvcTFt?=
 =?utf-8?B?RFg2U253YzRyTnhTU2NPblBCTmlmeExlK2JqN1dJNUV3VmNtNytIWmNWVFYr?=
 =?utf-8?B?K0RzWXZlaGZjbmVsU0NtWFowc3Fhb2g1L242T0xGc040alhWTFNqNk9pRU9J?=
 =?utf-8?B?UndLdWcwUVN2Zmk3NnkwSTA3ZnpocjlCN2ZJWlplQStSeXNnc2dhaDBDdHZl?=
 =?utf-8?B?Tlc0V3JyTVQ3anpKclRkcnd5dnRkMDNhT0Q1dUVOZlA2eEhWUHJSNEdSUERR?=
 =?utf-8?B?YVZZd2NsOEMvTHRIMVIwSU85VE9IR2RXZWd4MjY0aGJYVGs4WUlNV2RHT3kr?=
 =?utf-8?B?WlNSVjlFNnNHQmYxbkdQejJOWEw0NjY3ZmNHRTdKektCOE9GN0NLY1FwQ1ZX?=
 =?utf-8?B?Zys1ZEhoMGt4bDBpdlBCRVlWc0J2b0NuS2lYdjFyTjQxcS9GNWsvWDBOUncv?=
 =?utf-8?B?VWRIMEhDWDdUSTdpRUhyUXRxOWZtbG9ucEVGbHBKM0RRRklteXowem0yOTRq?=
 =?utf-8?B?akozdTk0R1U5SVFkN2ZTaC9KdUZGd2NZS1pvNEJSRTNoQWZtZmthS1lXYnQ0?=
 =?utf-8?B?U1lLeGFwQWhmRXNlcUxhOUlPYzdWNzlOUVI3aE4rZ1BKZUZ1dFExQStQbCtG?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jUFIbSomd1fOUPGr/8djbkP40GSuxYcu4SQYRYK4yZx7F0DGlCNMoNLWMZGGToSeUw/DSyTTMz0MqZ+ZKuQFJajHK0LBd8En5RYm8FRH9NpG/KGZTSP8Tsy49WlIb82gX/WE/lGZwcLI3GE9S78A6RU3Xk0Zp4CwfPJ+CUUENG5OOi1Wwj4zDCNnIX6gv0vwxqANbZhxO80teClIPaLiw37oYqKBjuJvoFpojVSXDi2r+zxb3+L/AhC3jOdeAGmWrAo9Sgw4iIEu9tMfjAOOs0VaC+GbL54aGnS5jcqYAMhwtKEJE8zHu5Tc7ZdWmCLHOuFQhwclLYvLId+Y5IYFftFqufM6h70BixGX44axLf2dnfG7pIg7twQhQ1uO1KcTAjePH7k3Yp8Tuxc4cZRszYmDJlqaSysBjgrHuZ3t/J06tbplEymJ1z7qPFqM6+O4LbK1F91SF7wFA4tQk9G9gpQW99o9A8fhhz2XXjFmgEZVdx0Xf+l1kLDsiA3Qbhx6BGocKnslcOcY7bekSAZPZXDxUxcNUMYeSvOyGz3I+69YY8+dXw9oA0IxS2tDSqZ0jmjUtr/z/ol/aPiNp1UOznUBEubLGd0UPBgWz6b9g+K4DpkTsCA5vpxhLwNmrDp/vKs0Svc4M5L9T7zk9vA80ALmFnNYuBvjel4yo43ZeKawfTp8oaa0TbhAaC3pu1U2nmLlu1YaFRwouRK8KtpPyeWKZzf0DxZBUSLureehiIHPXRgW5KHVvJqA5rpdB71jtA6sG2y+VFWN8WklZumrCJtrdsWA640rr9QkRkoIuZVnlmsI0bF/ubbOSnFy9YboZaD1JDntrfCA2toDgWqbRr/xiLuVFsaDY5d8VI0N2+V1uZzDnSyM/wq4rcpYoutltjI06AQixqs28BwdnnIv1g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4175e10b-5cd8-45fb-d718-08db061e133e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 19:37:24.6290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYEMcn98gQdxmIYRZZ0KIHE8/QeW8d5/bOFIijoq7bSi2VkRBZHbStDaCWxBIsDZXCxuSjut5I0NChItNcdmYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_19,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030179
X-Proofpoint-GUID: DXP2Hsl9QSdYVxSx_rPx-_d6TxbBVlIu
X-Proofpoint-ORIG-GUID: DXP2Hsl9QSdYVxSx_rPx-_d6TxbBVlIu
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/2023 12:14 AM, Michael S. Tsirkin wrote:
> On Tue, Jan 31, 2023 at 03:22:24PM -0800, Si-Wei Liu wrote:
>> The spec says:
>>      mtu only exists if VIRTIO_NET_F_MTU is set
>>      status only exists if VIRTIO_NET_F_STATUS is set
>>
>> We should only show MTU and STATUS conditionally depending on
>> the feature bits.
>>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> so change the subject pls. it seems to say you are showing them
> when you previously didn't, what's going on is something like:
>
> 	make MTU/status access conditional on feature bits
I ever considered something similar as I wrote it, but there's no actual 
config space access involved, and what the code is doing is to prohibit 
*presenting* the related field to config space subject to feature bit. 
So maybe this is more accurate?

make MTU/status presence conditional on feature bits

Thanks,
-Siwei
>
>> ---
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 22 ++++++++++++++--------
>>   1 file changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index 3a6dbbc6..3d49eae 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -3009,6 +3009,8 @@ static int event_handler(struct notifier_block *nb, unsigned long event, void *p
>>   	struct mlx5_vdpa_wq_ent *wqent;
>>   
>>   	if (event == MLX5_EVENT_TYPE_PORT_CHANGE) {
>> +		if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_STATUS)))
>> +			return NOTIFY_DONE;
>>   		switch (eqe->sub_type) {
>>   		case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
>>   		case MLX5_PORT_CHANGE_SUBTYPE_ACTIVE:
>> @@ -3118,16 +3120,20 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>   			goto err_alloc;
>>   	}
>>   
>> -	err = query_mtu(mdev, &mtu);
>> -	if (err)
>> -		goto err_alloc;
>> +	if (device_features & BIT_ULL(VIRTIO_NET_F_MTU)) {
>> +		err = query_mtu(mdev, &mtu);
>> +		if (err)
>> +			goto err_alloc;
>>   
>> -	ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
>> +		ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
>> +	}
>>   
>> -	if (get_link_state(mvdev))
>> -		ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
>> -	else
>> -		ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
>> +	if (device_features & BIT_ULL(VIRTIO_NET_F_STATUS)) {
>> +		if (get_link_state(mvdev))
>> +			ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
>> +		else
>> +			ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
>> +	}
>>   
>>   	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
>>   		memcpy(ndev->config.mac, add_config->net.mac, ETH_ALEN);
>> -- 
>> 1.8.3.1

