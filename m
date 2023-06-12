Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC8972CB13
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjFLQLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjFLQLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:11:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459DE130
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:11:13 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CFwuG1017939;
        Mon, 12 Jun 2023 16:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=rvtpgN4y7UFaX73PSct8Bk63f90gLkt7VH820Hd0GO0=;
 b=cRFpLSBDO7mD6xASLdEfozGUkgNO/V2n6HHs3BGHQ31tT/W9by/S4R6y20mkl3V/OC7z
 vtFjBSqXR+dsi+MrkU3Otuxv6ppa6FhaF2IYXcgOr5S+hE9ZHnhEFFeCyPj/ysDwlcqA
 sLWbJMuzRdoQ6KDk7bimx/iKEcsJ+/nWCJ62cEqkCVwUsdzSs0qOSs/dXTs6Pbj/6Rl6
 PKr52kmJ14EuWNbonYQ+ZhQ0epOwMgqfPeBS6Trf39ENsdb2N5gr+wh6VNp2TOtMR6Nw
 exDoMXwgGaurVWVoL8fxdoPpfU9Z97KQLOS1YnerOAE0jNt2M2pBiGm6tvmZPqfUTtpB Ow== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h7d3a3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 16:10:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CF8ijY021622;
        Mon, 12 Jun 2023 16:10:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm2yu6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 16:10:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqK8COcLt+iIXS5Hl4gnAaAdEL6lYVSgIYVln7us2NnGddpg5E5elMA9MgjvK4foXoPqYTHUxFQo7UQSXmzVqtkoZvxTntjH6m4eeWGSNZ2G3OubkqCeNaG9DDk/WH9ZT5IFnVPsje4hTLVEzpQ5MSkHDh0szLMBmVXbY82HqrD4oQRiJ9+05Jjl44JRElPU71oDZJ1BEYeEn9MrVNtAeFtsi2OMOzK6QugpOHATFrUClJ2Iyjw24lhWh/DLtoA2USwP1o+HMX3itziXdGunu7q3mBDk4tTN8fCeWvyiSmLyPvmPNcLyFdLWfwg1/v33Y4DuJtEJFgJwiaWTaWRUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvtpgN4y7UFaX73PSct8Bk63f90gLkt7VH820Hd0GO0=;
 b=E9yU9dp3fyN7ehhv8iNXEKbKLbzStwOgY9/RBYu+XUW4jp5dB6jnpbtmbDl6Y9jI43JwKLROeUkftzVQYQ4TdJ9IcZnWuD7lSAYH53Z1aFCwwhHTddrwQOTJNCBXmLOla4I8l5fm8zFGGKrkQJsNmCSNCHyICZa7EwlF5GLeocS2ZoobBV3pc++L5tQT4AORnjUkd4cVRUGFUKvD7dWtjj1AfDsB5Ryx6FEAg5l1OOvrG99a7GKNx7c3jadkzR1nb6P3eyNxC60SxN3DciMig2oo1C2IRb65fDikTgenKR9mLezZnPv4FIMsy23Pe75D2GHuyGSuNhfvbyhlBwV27g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvtpgN4y7UFaX73PSct8Bk63f90gLkt7VH820Hd0GO0=;
 b=hIAjMFUnpO6EQyhteBpUmG4/H5nxSCXaVPoPKDEwPxx5UPeQg3v86LStBT71ziNJBKp+UHzzrYyDCrV3CKI9O1V/vKh3QlwKbpPpEZp1Z6Jl4EEIVHrxZYxp0kyyJQJkklhul2RkyPWDsxuo3uBJA1Cza3D1Uznvx5yXD1gBO7E=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH3PR10MB7233.namprd10.prod.outlook.com (2603:10b6:610:121::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 16:10:43 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%4]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 16:10:43 +0000
Message-ID: <4b2c749e-f201-8e4c-5012-074dc8dd2be9@oracle.com>
Date:   Mon, 12 Jun 2023 09:10:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] [mm-unstable] mm/folio: Replace set_compound_order with
 folio_set_order
Content-Language: en-US
To:     Tarun Sahu <tsahu@linux.ibm.com>, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, muchun.song@linux.dev,
        mike.kravetz@oracle.com, aneesh.kumar@linux.ibm.com,
        willy@infradead.org, gerald.schaefer@linux.ibm.com,
        linux-kernel@vger.kernel.org, jaypatel@linux.ibm.com
References: <20230612093514.689846-1-tsahu@linux.ibm.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20230612093514.689846-1-tsahu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:a03:255::7) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH3PR10MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e97f093-3f0e-4bc1-f3ae-08db6b5f9288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OsvWJPnPVd1c0jxsB8ty7CFAam1NMvthap6MNQrZovRck1NXlQkdYaol3yChoUlUtnCE27ZFJSAUF+1tUuPVHTpyvjVD5w35vYo0ZQk++PV5Po2x3sfpBFMpn4HR8q9s2JxCkH2Xg19TKcRVbU1OCaSGx7nHKHKMeKJZ1lTR7+P9ZK9UCcVnO411tImIQ+1OPqW8LlxPCtk1rewqj0no9KXxSXRwDgOHKA/pc+znP/jUaPTL5QomM2HuOLLTV6GmXKvCCLkMaFYbGW+1e2PlnBobFxuYrwcaPS6XvaoPTIctRqURaVU5wG/fyRUfIZyyES3s5VCUuuhdV1auQUYccVrmLX3NYJf8Lh0lXHCqeZlxTkfxbvVfFOr7+b3p2P0zw9RrGzqKPrIr6n46RZ99nNEIhmaoKJOIUN31zxMvE19KB5gxZYgTQvu70mghNjMgllppM4Uk0G3tZ/ikY3D7tcROXNQWM/GnBcPoStTs+/3LjPnz0D2Z4vdeTgc0JazonQOTiVJiLCsNMQD74tYR13+FeC4MgyB8/gB+iK5f7zaF6a66EINzcO8h1fK3eCK+Bw3hEle3T7pgperqZ8DOl9YdjcfdTu2ypXzuzeaF+QVTiU27JuGF4g7P402vzGxJw/Cjopr/RYn1cCQ5dkqSOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199021)(31696002)(86362001)(36756003)(66556008)(4326008)(478600001)(316002)(66476007)(66946007)(966005)(6486002)(8676002)(8936002)(5660300002)(2906002)(44832011)(41300700001)(38100700002)(2616005)(6512007)(53546011)(6506007)(186003)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFo4T0psUjFMVHNkV2VKcnZhcC9BRDZmdzZSaFc1UDVhZXZWWldJaU5TdjVJ?=
 =?utf-8?B?SllaUmRZUHI3bkhBSXdaejI4dE5yZnlLd2h4YXVvY0dVN1RuMDVZNzNIMURN?=
 =?utf-8?B?T3VTdTBoLy9aUGwyVm0zVDd1eUkrRCtzSFJ2UjVVR05icVRvTThhem9CVU1B?=
 =?utf-8?B?SEVGZEc1dVI2TDhvRUorS2ZyMFVFT0YvdTJyRFdWY1g5OGY5MWh4eUovV3hz?=
 =?utf-8?B?ekF3d1NONDZYRU8xYkFSWVpudVRDZWhvWWRlYXROVFZ2bElobVJIUExTUG9T?=
 =?utf-8?B?QWU0WUdQVWxwRUVySmYzVWJaYXZhbm5waldYWXE1SExLSnRJNHg3OW1FV3ZI?=
 =?utf-8?B?eHpNdW82VjhFN21ET3FaRjB1QnZseXFoRE1BdWYzbXJITHNpRWdlR1E2c0NQ?=
 =?utf-8?B?d3dVYzR5Z0hBbmVENnE1S2x5Vm5KZHlQczFHdDhIZFZuUTN2NGRDdE1rQXA0?=
 =?utf-8?B?U2p3ZWNIcUhSZnB2d1U0cnlhVUpUVTNLZVNjY0dMTCtqY3V1NHM1U1JjMXdM?=
 =?utf-8?B?b3JzNngzRGxEQWVTazNrV1ZZYWlFc29qa1lLRDZ5TE5HWmpBa1VUaTRBTlA0?=
 =?utf-8?B?OWJTTDhvNmQvRTUwc1dSeFF4eFRIWTZjak1lb1d6LzZsZ1AvRE04TTBwZnY2?=
 =?utf-8?B?VGhOZktsZmJRWlM3dHRiSUpwOHVtMFdCcVJvRGdJSURtVDZZc01TRkdUdEhy?=
 =?utf-8?B?aW96aWdFYjBhVU5KcldWcEUwTEVzWkcvcFJWNE5lZ0ZNdHFJa1dVZmZpRGRG?=
 =?utf-8?B?cXN0MGhiWmdJV2oySXU5cnpZN2JSNEZISjlrdGZDYnpPUWY4elpPeVloOE10?=
 =?utf-8?B?ZlZJVUkzUGZ2VWxlaFlmT0VjSERGUGtlNTg1TjVtb1V3aHA0T0IxZCtnY0Rv?=
 =?utf-8?B?WXhOZkJ4SVRLR2grcWl6KytYRHN3L2RTSlFoT3JwdzdFR0s5VHJMNjZLUm90?=
 =?utf-8?B?L2hIL2F6WDJQUFIyT0QyUTc4azc0d1pvVHNqUUVWWjFNbTJBSXg5S21Mc0lo?=
 =?utf-8?B?ZzdmYWp6SGE0Y0lKMGl3M3UyL09lalR4dHRRK2ptMW5VOXlIOGQ3ZVJybm80?=
 =?utf-8?B?TjV0K3kwTVdGT3dWU2NPODRleFZBbkJqTXhHcjQ0SUY3NzJLd2pVTHdlU0NI?=
 =?utf-8?B?aS9GL2JNKzBPUHpjQkhMajFpZC9hNStkcy9aSmNRS0VoZVZsTXMrSHZldjVk?=
 =?utf-8?B?MUJuODN4YnFmbkFKYnBWUExtMG1heHNFb1FIWHNmaEV5d2RoemN4bXpjQmpj?=
 =?utf-8?B?QU56YUx2U2RJSWIrUjZ2N0tqeThYR2tzR2hxSkdtd1l6dTUxbXJlTktJNUVj?=
 =?utf-8?B?azJ1NTZUbnFJejByUUNneWlDbkhXekZLUHk1eWhsSWYrT2FOc09XNHYwdWxa?=
 =?utf-8?B?bzBKS1ljT21JWHFaMytsNU9IMnpnaWVrMnArVG5pZDNVd0JEck8vSm04NmVV?=
 =?utf-8?B?QTlNNzJ1aWJRS3VlV2UvNGpiQUVuYmh1OWVnRVJRc0NKTkdYQW0rZm4yZmNG?=
 =?utf-8?B?ZTlwVXMxbUlFMnNPcS95dVV2NXlsNTZoUVAvRmQ5bG9seFV5VXI5UnZnNlZX?=
 =?utf-8?B?VjdTRkhnQmhPcUg2a1ZhdmNkNVl3c0RxWFVTYUtRbmFQOW5sSzdGRHlYdWR5?=
 =?utf-8?B?MEplcmNFQmpvTFhqUS90cVprL1JON3loaWNKQjdtazFHSTFJREUwUnVuSkVS?=
 =?utf-8?B?NU96VUZLaERjZDFSSk1nQkZLSFZmcDhNY1dNWDB2UGkrUHJ0S2p4dUR0djBr?=
 =?utf-8?B?ODFOaldGR1A5M2lTTmNTVGd1T3BGR2RpMnhUbVpUTXk0V3FIU3l4eTNZNnNy?=
 =?utf-8?B?U1MzSmFBa3lGeGY5eUlraDR2TXRvYmVHY1FzS1A3TG81RGNxRGxSRDZsaFZG?=
 =?utf-8?B?aTR3T3pLRnhWS2RXQitZS3MrSEZrcGI4WFBJUFBIZEhFQWNSNFM3djNzVEZv?=
 =?utf-8?B?YlQ3VVZtdjA2bjJtWXMreERiSnRpNWY2Vng3RXlIUjdySW5PSmRVSXRxdVZV?=
 =?utf-8?B?d281TnUzSFAzRW8vTnM5UWo1SkZhYnFaV2dHeU9PSHJ2WS83d2FIWjl4bE5U?=
 =?utf-8?B?SGNZbVQwbkpsY0F2RHBBUlBmSlgvZkVRL1lObmJ6OSs1Sk5zZEpFWUVCZzJ3?=
 =?utf-8?B?Vzk4Nkx4YXhJNUVRdjc2UlpVR1Q1VFdQOUFRbUpyWnNkOEp1bXJOQUlxdXU2?=
 =?utf-8?Q?bz8Dk76wkVxcn/K+cWp8xz0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dytOWEVrZURSejlPZUFjTjJUQ2I5REQ4TVkrbzA4d1h0b0Fmc0RldEFSV29S?=
 =?utf-8?B?Q1IyVERRaERDZ2w1TzFxUUluRmJvV0dQMVRPck9icHNyZ0ZkSVczc3ZMR0J4?=
 =?utf-8?B?eksrNFlNSWRTdUtuS0ZXbEVyaGxsTjFGZDJaSjZUWTRWT2VTcDhkb1QzOUk3?=
 =?utf-8?B?REpoM0c5QVgwQVZwOC8wSkdlQkJLbWt2TGtsaTgxVzQ1WWhlN2QrVVhHcS9y?=
 =?utf-8?B?VlJpRGtUREJlY3hVYTlsQWp3NlZhUktxMTZ4aG42T0xvZGw3dVk0NmluVk9O?=
 =?utf-8?B?WTZkcWd2KytBRDZCMnJ0ejlmQ1YybktzOUs2NFk5dENJQVpCdlZ5bE1ZL1FR?=
 =?utf-8?B?Smx2TUFXWVIwZVRsbmUxRWRTaGIrL0xJdEFGZGZudzdMNDlxZlVadFRYWEwx?=
 =?utf-8?B?RWw2UVVneXlURlNEYjdsZm1CQnFIUFc4L3p0eEJyU0JVSkhjYUgyckhHc2sw?=
 =?utf-8?B?QkhPcUlBZHAxZDZIMU9SeURjcWJBOVd5N1JBcUc2ZnUvL09MNnJXZFlJZ0Zj?=
 =?utf-8?B?TTI2ZTdGNmpPdzdYbVRNanBiQ2RNK0hOL3JveXYrZWRxQlZrQVlhZXBaK2ND?=
 =?utf-8?B?c0Rxdk1LNFBicHU2VGtVWUZWdW9vcHBJN1ora2J2c29JN3owMEc4RS9CclRu?=
 =?utf-8?B?T2VnTk8yVnFMNlRGZVdNeHZaTTdja3l0Tm5GMFpCcW9EQ0ozUjFkVHkzVmZZ?=
 =?utf-8?B?cUNaK08yeVhTc09KTHBGU2ZaV0hZVFBXTkRFVVdoaS96clRXZ1U5bEtoYmpq?=
 =?utf-8?B?MzRoOEdNNnJrWHMwLzE0TjA4NkhvWjVkWWFGbkFrRjE1WitVYjJoTjdZMTFl?=
 =?utf-8?B?aG5HR0VRNE9jNHBwZ0VyRlROck1FMUk2bXpaK29kVjMwcjBRbkpOcVFUNlNh?=
 =?utf-8?B?NjY0VDBwd2VuNUVFT1NrSkx2UDdQL2cxZTBKWHhSdHhYYm5YeUl1S2FZTUF4?=
 =?utf-8?B?Z3RaMXNxUGxsWnhmbE0rdEdZZi9vMjEvclBTRVhpblFjU1ZEZEMzTmVMN0lW?=
 =?utf-8?B?ZHJGODNtWTNIK0lvb3BPQmxub0Jna00rU04ra0IrdzBUQXV4cFFyckRhNnNP?=
 =?utf-8?B?NnJSNzBnSDRaSUN3UkoxdHN3aktmUjdCbThBUTBLTnV2eHZkdUVFRzdYbjFs?=
 =?utf-8?B?Yk1nSnc0djVLTWFxenNaaFg0a2Y0R1A0NmUrSDgyUk8xcXJlRlVYNGtUTVpp?=
 =?utf-8?B?d2t5d3lnd2tEMnFBZTZVS0lSa2hreTlCVDRYZW41TzBVcE5QeVFVc3phVVph?=
 =?utf-8?Q?k7tv89QJqTOSHP8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e97f093-3f0e-4bc1-f3ae-08db6b5f9288
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 16:10:42.9681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPlPyieP3A2mP3RZMsC+X3d5+kXja94MJXECIaBt0BGW+DJi7P820xONnRczokYpzN7XH+q+0cz97zD0AWByzMBNH5nUsXGCBtaYo+WziR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_06,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120139
X-Proofpoint-ORIG-GUID: mVY76K3laZAQmYyAM5o_JiRsBqCMUnha
X-Proofpoint-GUID: mVY76K3laZAQmYyAM5o_JiRsBqCMUnha
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/23 2:35 AM, Tarun Sahu wrote:
> The patch [1] removed the need for special handling of order = 0
> in folio_set_order. Now, folio_set_order and set_compound_order becomes
> similar function. This patch removes the set_compound_order and uses
> folio_set_order instead.
> 
> [1] https://lore.kernel.org/all/20230609183032.13E08C433D2@smtp.kernel.org/
> 
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
> Moved folio_set_order to the top instead of moving prep_compound_head below
> to it so that git blame can show the proper change in prep_compound_head
> which is replacement of set_compound_order with folio_set_order.
> 
>   include/linux/mm.h | 10 ----------
>   mm/internal.h      | 32 ++++++++++++++++----------------
>   2 files changed, 16 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 27ce77080c79..61d75e0e5b40 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1229,16 +1229,6 @@ static inline void folio_set_compound_dtor(struct folio *folio,
>   
>   void destroy_large_folio(struct folio *folio);
>   
> -static inline void set_compound_order(struct page *page, unsigned int order)
> -{
> -	struct folio *folio = (struct folio *)page;
> -
> -	folio->_folio_order = order;
> -#ifdef CONFIG_64BIT
> -	folio->_folio_nr_pages = 1U << order;
> -#endif
> -}
> -
>   /* Returns the number of bytes in this potentially compound page. */
>   static inline unsigned long page_size(struct page *page)
>   {
> diff --git a/mm/internal.h b/mm/internal.h
> index c59fe08c5b39..c460b2fde977 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -378,12 +378,27 @@ extern void memblock_free_pages(struct page *page, unsigned long pfn,
>   					unsigned int order);
>   extern void __free_pages_core(struct page *page, unsigned int order);
>   
> +/*
> + * This will have no effect, other than possibly generating a warning, if the
> + * caller passes in a non-large folio.
> + */
> +static inline void folio_set_order(struct folio *folio, unsigned int order)
> +{
> +	if (WARN_ON_ONCE(!order || !folio_test_large(folio)))
> +		return;
> +
> +	folio->_folio_order = order;
> +#ifdef CONFIG_64BIT
> +	folio->_folio_nr_pages = 1U << order;
> +#endif
> +}
> +
>   static inline void prep_compound_head(struct page *page, unsigned int order)
>   {
>   	struct folio *folio = (struct folio *)page;
>   
>   	set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
> -	set_compound_order(page, order);
> +	folio_set_order(folio, order);
>   	atomic_set(&folio->_entire_mapcount, -1);
>   	atomic_set(&folio->_nr_pages_mapped, 0);
>   	atomic_set(&folio->_pincount, 0);
> @@ -419,21 +434,6 @@ extern void *memmap_alloc(phys_addr_t size, phys_addr_t align,
>   int split_free_page(struct page *free_page,
>   			unsigned int order, unsigned long split_pfn_offset);
>   
> -/*
> - * This will have no effect, other than possibly generating a warning, if the
> - * caller passes in a non-large folio.
> - */
> -static inline void folio_set_order(struct folio *folio, unsigned int order)
> -{
> -	if (WARN_ON_ONCE(!order || !folio_test_large(folio)))
> -		return;
> -
> -	folio->_folio_order = order;
> -#ifdef CONFIG_64BIT
> -	folio->_folio_nr_pages = 1U << order;
> -#endif
> -}
> -
>   #if defined CONFIG_COMPACTION || defined CONFIG_CMA
>   
>   /*
Reviewed-by Sidhartha Kumar <sidhartha.kumar@oracle.com>

