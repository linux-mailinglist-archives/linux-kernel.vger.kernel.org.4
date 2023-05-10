Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27A16FE798
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 00:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbjEJWxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 18:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjEJWxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 18:53:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ACB271F
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 15:53:16 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34AL4GrF032319;
        Wed, 10 May 2023 22:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4vZhD4Z4/2/8w6iQUaWXTIqS+1WEmVNC3T8VVkk7wxQ=;
 b=fY2rUzoBGQ9+SJAlzgkvYbFLyDFvcYbstIA9HxkjFqVYF5JhRcB1a9ix5X9ZmAYq5hjX
 K6327ndlGLhOJQERDYpAys+roWIcws2B08BV0ipgrn5f2EZz78NobTnlYAYQq+hr/+qU
 VqPgId8aob07i4SsjYPnyxA9itIr4IBpV2gXgIqBJahxnuv7zJD9JN5+FbrctAqjN2HI
 +2nte45Hwd9Y9QjVYX4kWRHfM9VNDNciuoz/5gua12xBVuD0M0M8XT3d90AB3HOO5XXx
 pBAO4zQ/I+vq+D6CsIGYqxN/oMLbYXhHNc6SL3u6wYSOQuLYez14+0fioLzeYfjmgJ+O 0A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77g5tsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 May 2023 22:52:56 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34AMfSTi014530;
        Wed, 10 May 2023 22:52:55 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf82xmfaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 May 2023 22:52:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZ762DMZnOpgi4HR+EazjbbXcLpx+JC+Cst/aka2yPlt1DzgHvb1adDQsYBN2oz6cZnnE57yrt+NHdgPTE3kTT2gbC7bpiukDd4Z3Rs0D9pP4u1xt41TND8UFiCCOND+ZaNHwGiP1qBzugvaBJOi92EGWWpEYWZyTAng6qFR5NdJy9KS71VqLAgDhLRfwu9Jk7O78ROadKexqfvhdbre+ggXtlyqe0aOyBpMHFjWlxGhSlbb+sxFth5HuKFj56VooeSp7iZGWoo4PHgyeVB+MF++rSHj4DezWVg1tlLmirpP4GF7nDhdBxDIxVkMngy+TvG/X6FgSpnAfK4WLx+5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vZhD4Z4/2/8w6iQUaWXTIqS+1WEmVNC3T8VVkk7wxQ=;
 b=FOPBgxIsskJ474pTXADflAcbHQX2idhUhiLCwAfm6ihFlC9lSB7ZU3zHsRbNXb3VIi1L4t6kxUV12hc9lGxmDCo+elomSHiwnDXRvlp0rDud5RH/xPPGBqd5ztn46zHl5gunvHyau/WQqQGGhEkQyeXQh6+UMh4cYLU1ghwXNXujCHC0oFVvjcVphUNRtomU249y82Z65CXjkHlDOovNE3+fYKXyrkgPuNWsJ7IyGKw06yARraijSkV6y9BnFMlE0o9beVMCHjDrBuohv4GRdpZ3sK4FWPJYRYQFM/rTLs1nwfv88hYPyJwj6qu3TRroZ0r8aBb0+62MWytQ67RFWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vZhD4Z4/2/8w6iQUaWXTIqS+1WEmVNC3T8VVkk7wxQ=;
 b=ARMl9EXUJwX0J+DvpB8VHO7WgIuOFnynThQMZPL3h1FrDJSMclweQl9w7mX1Sba1gm6kyLclltZ9VLrVMYWxlcmDSkoT0N8qRrqJCVr+uxgDa8xa0btw+z6HNW8l9luIgvWnSYOT8ooVGZLdUt+oJZUJZw5YEchFM/dnvefYgcM=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY8PR10MB6828.namprd10.prod.outlook.com (2603:10b6:930:9f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 22:52:46 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6387.020; Wed, 10 May 2023
 22:52:46 +0000
Message-ID: <d8642c50-4fcc-25dd-cca0-b6c3374da135@oracle.com>
Date:   Wed, 10 May 2023 17:52:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v22 6/8] crash: hotplug support for kexec_load()
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230503224145.7405-1-eric.devolder@oracle.com>
 <20230503224145.7405-7-eric.devolder@oracle.com>
 <99cb5ee3-da46-392a-e582-e64b479003e4@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <99cb5ee3-da46-392a-e582-e64b479003e4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:5:40::39) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CY8PR10MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: c9be4017-adc5-41d3-4b02-08db51a9456a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /q/43k/X+9o3d9he9t6Cud0av//Z0MTT4P4Bq0e4h1fJFI75hjkt3EjGR0klCfereqhvcHjUpbx9VtO4ff5868Jc8ygkTQJ8JxgKgRoeRYJRpYejKMRLZ6+hCTDSp/lE4pad6u+pKyowX/umsRpdcdwjeNGR9R/u3XRYwRLBTTSJO56A0adZttfqRwPCFNopodnk/wZCzoc4ZUVWz5PhgCTzKkTU/V5iz2rnELdEe2fiasNJrwx/+GthFYzOt3dFdU2RCFaPpLu0YHZTNRdm6hy/0CbOWnhGj92/VU3XCdgOWADNCZsho0Iyvl9tnyQSz/Mv8uAzFkJQb/ZIcexIm6v99ouusYWIUpNo1WW1G5ygweGVzL8j/XrqQ384pylLrXE8hgAcRHM8bXAKFMurXEEwVBxrMJBZCMOnMhbJ76Mqn3oT9TKY3Po7zoOWP0MJ+QBI9S1VwEMZAk2+6JFuORwAiBmDhdcn2yQSkyx2c37kp/01VcIhF4+5Xw7JUJNp0NkneJwiThB0OImJ/VPQONO79m5s5xXNVrYFNGs4a35HmLM8fdAVBseXpSfc09oMoZ32VfxDd5CVdSqTasP/tJ70QlVhMUakEoKSje0EhU7e6j5sHzDXCPeEJnAlJnbwLWdmH0wplCwcRVGu+qz8vA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(83380400001)(2616005)(2906002)(186003)(30864003)(38100700002)(36756003)(31696002)(86362001)(5660300002)(8676002)(7416002)(8936002)(66946007)(66556008)(4326008)(66476007)(6666004)(41300700001)(316002)(478600001)(6486002)(31686004)(107886003)(6506007)(53546011)(6512007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0NHSVNhcVBZdGhoZVdSMHYwZ3p3MEczZVM1aHVPbzBUWnViWGcrZ0FZcENE?=
 =?utf-8?B?TGxPeGJSdFJ5bUxXNXVzVU1nT0pGTjJISEhibEpoQ3RRaWZ5V3BBR1pSaUtT?=
 =?utf-8?B?WWRpRVhLVnpQTXRGdTg4cW9ZTEt6eG1JVkNuekREeHdsTHZMdTltTnpTSEVX?=
 =?utf-8?B?RW1zc1lFaTFvYTR3MXhmbVVLVWJjeHJwT0ZEUXZ6QTJTeEViTGo2dlU3ci9C?=
 =?utf-8?B?dHJoZzVqWkcreGhHcmVyc2JiaXNNKys2akNKODZIY0NOL29NWGsrRkJOV0Zt?=
 =?utf-8?B?Zis1VXAwM3RjTVg4alc5OTRDUUFHWjRPQ3ZMNlRPQlJST05lRmR2Qmo2TjhW?=
 =?utf-8?B?cHBqUFBLeUVzcXBDN1NMckZpRUlvSHViU1JoSlZveEFjNGJQdHdleGtLakJS?=
 =?utf-8?B?MXNiakxzMTFwZlZ4OUJ1eWR5bnJOOWxHMXJOT1JZQXVzcGxuTUhTYjU3ZHA1?=
 =?utf-8?B?NjFpZjVrMVVXTzErd1N6UHp3ZGtWcW1EUHlGdkgxejlUYzh6eDUySzNZY2ho?=
 =?utf-8?B?K0p5endrUTNGbnQwMVMyUmNCZys5bENQekZNYmlkanlhTk1TMEJpb3JObHh4?=
 =?utf-8?B?NThNVVlpYW9LVVVhOW93UWlzSnNuM252ckRCV01LOEs5a0xjRjJvakNEMVc2?=
 =?utf-8?B?djRyRExCS2g4STJoSVVrWEplNnczUFZyYkFIMHMwRllrVGtGb3hyL1lGUm9w?=
 =?utf-8?B?ZXZyRWM1UVFzdEJ6T2VsTThTYlBrSlA1ZTBob3VxRnFoNnhveG95c2VXU3lI?=
 =?utf-8?B?bS9UN2NFSVlQVUVwNWhVZHZWQ1BEa0hyWHE3dXdtVjkvMFk3MWlPeWFQWWpB?=
 =?utf-8?B?dlcyZkhBU2ozTzk5SkRDZ1c4bHlhZjFDSjZZNWllSVhZQWp2RFMyNkZWY2VI?=
 =?utf-8?B?UFF6cklTQ1loR2xqMlEwSnZkTmtKZGtEZzlKVTlxcCtKSG51dThyTUFJTmox?=
 =?utf-8?B?WTZ5NHNvL1ZQRlYvckhqUkUwbTlzMFh0VHBlUmIrRDFXSU1JSXJ6dVRDMDAw?=
 =?utf-8?B?OEYvOWNnWWJ1TDVpYWJtYzVVaFZLQXQzUXBrZnExZDMzSnRNZW85Q1lBL3dM?=
 =?utf-8?B?V3VrVGw2L0lENlFYWHIyZksvUnRUblY0YkdUN25SYVZaN2lCNFZua29tNXl6?=
 =?utf-8?B?UHFTWDBWQnlBYStjOVlUbmsxeTZVN2pKdzVBRk14K3BWczZGdkdTMnRNNWRZ?=
 =?utf-8?B?Zy8yQWNwOHFDdjBzTm1kTm9pMjg3RWNjdC94NzJKblZuVzlLSUJET3VzQXcw?=
 =?utf-8?B?V3lRWjRJS0ordWpqTXNSZnNLMTlkRlVBQUFNZFhQTUI4cCsrcnBha05wbEF0?=
 =?utf-8?B?NCtEbVFhQTlSa2tKUmQxbzdvNUpWV3VCRnFoUysxeUlOdGtlYVNiSllrdzRU?=
 =?utf-8?B?MnRXbVM5VnV4TlMyRWNQZjhhRDVtNXF6ankzT1JtdnlRRWszVzhaN1pqV1NG?=
 =?utf-8?B?amFQOTZ4L0pUdUVkNTBWOU9KTE1vczVTb2VFbUhjRlRFU2dVd1pjZ2V6RHI3?=
 =?utf-8?B?amRGY2x3RlBwbTlxMlh2MHpQU1JhUXZiVXQrajQ0dm1sMzIzc3hHMFRBdkQr?=
 =?utf-8?B?dEZQanBHWWkzUkFEUXk2MjZFdTBSVDN2ak5oZ3pGZUJndFQ5YlMwbk1jaDlP?=
 =?utf-8?B?L3JLYTJMVG1OZE1rM1JLNlIrcHRmdHR2WHNlMldJMjhSdkdkSit6cHdNUWc1?=
 =?utf-8?B?STBZOWF3TWlKV2lHZTRXcysrTE5LV0t1M2FUemIwSVJ0S0FhQ3ZvTXJCZXpS?=
 =?utf-8?B?WDhobjVYOHdaRDNZZUcyQzFXcFgwNDhBZkZuK2MrQ3oxR3VoQStUcTh0N1o5?=
 =?utf-8?B?ZCtmMTlqQTFrN0EzN0wrZkViY0Q0ck4zSjFWeDl2U080eDA4Z0RYcnF1amox?=
 =?utf-8?B?UTdZVU9EYklDWWJ6QjBiOGxnSnljcFY0ajg4Q0hua0NWNjZzR201Z0s1Yjlx?=
 =?utf-8?B?QTV4cGxpVk80WVZmd2hHc2VDN2xETHdvUnlwdUR1YllPR3R5R2dTOHNwaW45?=
 =?utf-8?B?d0hicGZPSWFaajJlQmNydTRoOTJIODJFZjFWUG45MVBFdzJBSzdOSUV6V3pj?=
 =?utf-8?B?MFFpR2VmY09YeFZBTkNiN3liRmNvMjlDTjFXUEQwUlR4QlBDZGpKUStQeEVM?=
 =?utf-8?B?bHl6NWNZQzU2VlZpTGU5MWQxc0M0OGVGdFRDcHdWdHRPVnBBY0FQdzFhTzFy?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eldPYS9YR2Y2eGlVS0FsLzdXL1YwMzJTbkZCU09MR3RqSHlLQThPRU91SG9z?=
 =?utf-8?B?c0FteDdqS25kQ2w0MmVkeUFzcVQ0bnRJVU15bzNjbW9sOVNlUEZGR2RJLy9u?=
 =?utf-8?B?YXQ2Sjkwdm5ZVEFKM1pEcEtNalBpUUxkNEZaSUYvS2NUOHVuQi9SaFdySDJT?=
 =?utf-8?B?OUF3b21pL3Bjb2pYOEVCQ0FPNkFza2V5U1lINDNwSDA2SFk0S3ZxcndzWUZa?=
 =?utf-8?B?OG4zYkExMnF4RHBrOEhMZEdwVTZFYjlTVXQrMFhIblRvemNaT3dkZ3RNcUZn?=
 =?utf-8?B?N3RRSWt2cmhkTWVoekpIVUhEaExQMGhKbjRETlBKT1c1ZFpIUzV2NHhoeVE3?=
 =?utf-8?B?QVMxVEVEZ1RyWEF2b3ZzNUN5ZjFVbFBscXA3T0hOUWtwTTRtbVJQQW1zYVZ3?=
 =?utf-8?B?VVFOUTV5YStPL0p6UDVCck1EWjBWV2pVQTVXcTB0Zk80ZDRqOW9CSDRqdjFJ?=
 =?utf-8?B?a3B3T0RwUGpXUkFTaHlmL2g5TmRITDZEVTU0TXZ2SjRwdkc0WTllVURHYzlo?=
 =?utf-8?B?T04xQi8ydU5seDRMalJHM09YSEJCMTJmNGZUOEpEWHNPVmxHSDZod0tXVE9o?=
 =?utf-8?B?WjBMNElvYjdyQU91UHFnRy8rWkZYdVg4Y254OXBuSVp2TmpaNnFZUHdEcEF6?=
 =?utf-8?B?VE5ML0Ywa1BjSGhLNDVUV3lSYTZMVlBCVG43UTVGZDJQMWN0SjVnVzREM2xP?=
 =?utf-8?B?R25LVWcyMGU5NzBydzBLeEJGRHpKM1kwb2dYdVlkb0RMby9HR3BxVFNYalVt?=
 =?utf-8?B?OXRBdUNzTVMzaElucHZpQnJDd3I3SXMwVk5xMUN0Mk9vMnNDbnBVWExlV3Nk?=
 =?utf-8?B?eG9NR1hvbHRqQUJ5U0E4Z0VpYkpNVXU4REZmT0tVNTIzaGU1WEJQMzY1VnRy?=
 =?utf-8?B?RTI3N3Q5S3FiMkk0T0xqaU83Y3VCU01uVDVNa0lRcERKM1FJUEc2aUhSeGFu?=
 =?utf-8?B?d1RRZ0ljUUN2a01XakhwcmlELzFmcWZDZWVpc3h2OFhGQVRjdEY5dzBZTC9y?=
 =?utf-8?B?YjBrZU9kWkNNOXdEUk1SNkNPRG42ekZWRjFkR2VkZE5oUkpmTHhUMTNIRjY4?=
 =?utf-8?B?ZWV2a2hVbWU3cmVOaGZiNHk4MGtwMVM0ckhFTmpDMTRqWjBoMU1TUnVqUm9x?=
 =?utf-8?B?MmVjNFptQ2QyQWZnQU5iaXJzRU9MaVV3TXM1Qk5HMGVKQU8xYnF4RE0rbVZh?=
 =?utf-8?B?djlpOWhPYS8vNFZqT1dZN1JvbWFRUGtKN1F6eEtCMXY5cjNML2owREY0VUdF?=
 =?utf-8?B?OFF4Sjc3TUJYYTFJSi9qa2o5RFUrckU1T0ZtRktld2VuRmo3aGEwT2N5SnFz?=
 =?utf-8?B?TnQ3QnY4cXE2WnR5L2s0MDA3NTJXTEY4TG4vc2RzRm0vRDRjRkJraG5qSTNV?=
 =?utf-8?B?MUk2Q1pGWC9RUmp4NHNabnNSZDdCc0xuRDQyeVh0SXBLKzRNVGN6ZzBRazEv?=
 =?utf-8?B?RWd1ZjRyZGhzVXF0SFNIUmVxTjNTT3FScmdtMTlHTE11cWZLWU5HK2hpSFdy?=
 =?utf-8?B?WVBTMEhkUHRnOVR4VmpSWUhOV0lhN21tR3lOTVA5QzdrN0xYRk5YVERhTjVD?=
 =?utf-8?Q?iVlybvi+uZTV0SwJbxno+FnNQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9be4017-adc5-41d3-4b02-08db51a9456a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 22:52:46.0762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/mEorcGel/vYfiYfty84uOAHtwmcEQ9YpRB9i/IFihgRSZ/2nXQNPJF0jpZT9+M4Z6vctdfXZoVgbHvDr50dooJrEAkX/FxfcfKVgHAZAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6828
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305100189
X-Proofpoint-GUID: G08cTt_rMTNm-OzGkwu-3ui6dM7omW0b
X-Proofpoint-ORIG-GUID: G08cTt_rMTNm-OzGkwu-3ui6dM7omW0b
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/9/23 01:15, Sourabh Jain wrote:
> 
> On 04/05/23 04:11, Eric DeVolder wrote:
>> The hotplug support for kexec_load() requires coordination with
>> userspace, and therefore a little extra help from the kernel to
>> facilitate the coordination.
>>
>> In the absence of the solution contained within this particular
>> patch, if a kdump capture kernel is loaded via kexec_load() syscall,
>> then the crash hotplug logic would find the segment containing the
>> elfcorehdr, and upon a hotplug event, rewrite the elfcorehdr. While
>> generally speaking that is the desired behavior and outcome, a
>> problem arises from the fact that if the kdump image includes a
>> purgatory that performs a digest checksum, then that check would
>> fail (because the elfcorehdr was changed), and the capture kernel
>> would fail to boot and no kdump occur.
>>
>> Therefore, what is needed is for the userspace kexec-tools to
>> indicate to the kernel whether or not the supplied kdump image/
>> elfcorehdr can be modified (because the kexec-tools excludes the
>> elfcorehdr from the digest, and sizes the elfcorehdr memory buffer
>> appropriately).
>>
>> To solve these problems, this patch introduces:
>>   - a new kexec flag KEXEC_UPATE_ELFCOREHDR to indicate that it is
> 
> Architectures may need to update kexec segment other then elfcorehdr.
> How about changing the flag name to KEXEC_UPDATE_SEGMENTS?
> 
> - Sourabh
> 
These seems almost too generic and vague. I get that for PPC this flag
will drive updating elfcorehdr as well as FDT, so the flag is over-loaded
in a sense.

Another idea for the name?
eric


>>     safe for the kernel to modify the elfcorehdr (because kexec-tools
>>     has excluded the elfcorehdr from the digest).
>>   - the /sys/kernel/crash_elfcorehdr_size node to communicate to
>>     kexec-tools what the preferred size of the elfcorehdr memory buffer
>>     should be in order to accommodate hotplug changes.
>>   - The sysfs crash_hotplug nodes (ie.
>>     /sys/devices/system/[cpu|memory]/crash_hotplug) are now dynamic in
>>     that they examine kexec_file_load() vs kexec_load(), and when
>>     kexec_load(), whether or not KEXEC_UPDATE_ELFCOREHDR is in effect.
>>     This is critical so that the udev rule processing of crash_hotplug
>>     indicates correctly (ie. the userspace unload-then-load of the
>>     kdump of the kdump image can be skipped, or not).
>>
>> With this patch in place, I believe the following statements to be true
>> (with local testing to verify):
>>
>>   - For systems which have these kernel changes in place, but not the
>>     corresponding changes to the crash hot plug udev rules and
>>     kexec-tools, (ie "older" systems) those systems will continue to
>>     unload-then-load the kdump image, as has always been done. The
>>     kexec-tools will not set KEXEC_UPDATE_ELFCOREHDR.
>>   - For systems which have these kernel changes in place and the proposed
>>     udev rule changes in place, but not the kexec-tools changes in place:
>>      - the use of kexec_load() will not set KEXEC_UPDATE_ELFCOREHDR and
>>        so the unload-then-reload of kdump image will occur (the sysfs
>>        crash_hotplug nodes will show 0).
>>      - the use of kexec_file_load() will permit sysfs crash_hotplug nodes
>>        to show 1, and the kernel will modify the elfcorehdr directly. And
>>        with the udev changes in place, the unload-then-load will not occur!
>>   - For systems which have these kernel changes as well as the udev and
>>     kexec-tools changes in place, then the user/admin has full authority
>>     over the enablement and support of crash hotplug support, whether via
>>     kexec_file_load() or kexec_load().
>>
>> Said differently, as kexec_load() was/is widely in use, these changes
>> permit it to continue to be used as-is (retaining the current unload-then-
>> reload behavior) until such time as the udev and kexec-tools changes can
>> be rolled out as well.
>>
>> I've intentionally kept the changes related to userspace coordination
>> for kexec_load() separate as this need was identified late; the
>> rest of this series has been generally reviewed and accepted. Once
>> this support has been vetted, I can refactor if needed.
>>
>> Suggested-by: Hari Bathini <hbathini@linux.ibm.com>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   arch/x86/include/asm/kexec.h | 11 +++++++----
>>   arch/x86/kernel/crash.c      | 27 +++++++++++++++++++++++++++
>>   include/linux/kexec.h        | 14 ++++++++++++--
>>   include/uapi/linux/kexec.h   |  1 +
>>   kernel/crash_core.c          | 31 +++++++++++++++++++++++++++++++
>>   kernel/kexec.c               |  3 +++
>>   kernel/ksysfs.c              | 15 +++++++++++++++
>>   7 files changed, 96 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
>> index 9143100ea3ea..3be6a98751f0 100644
>> --- a/arch/x86/include/asm/kexec.h
>> +++ b/arch/x86/include/asm/kexec.h
>> @@ -214,14 +214,17 @@ void arch_crash_handle_hotplug_event(struct kimage *image);
>>   #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
>>   #ifdef CONFIG_HOTPLUG_CPU
>> -static inline int crash_hotplug_cpu_support(void) { return 1; }
>> -#define crash_hotplug_cpu_support crash_hotplug_cpu_support
>> +int arch_crash_hotplug_cpu_support(void);
>> +#define crash_hotplug_cpu_support arch_crash_hotplug_cpu_support
>>   #endif
>>   #ifdef CONFIG_MEMORY_HOTPLUG
>> -static inline int crash_hotplug_memory_support(void) { return 1; }
>> -#define crash_hotplug_memory_support crash_hotplug_memory_support
>> +int arch_crash_hotplug_memory_support(void);
>> +#define crash_hotplug_memory_support arch_crash_hotplug_memory_support
>>   #endif
>> +
>> +unsigned int arch_crash_get_elfcorehdr_size(void);
>> +#define crash_get_elfcorehdr_size arch_crash_get_elfcorehdr_size
>>   #endif
>>   #endif /* __ASSEMBLY__ */
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 0c9d496cf7ce..8064e65de6c0 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -442,6 +442,33 @@ int crash_load_segments(struct kimage *image)
>>   #undef pr_fmt
>>   #define pr_fmt(fmt) "crash hp: " fmt
>> +/* These functions provide the value for the sysfs crash_hotplug nodes */
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +int arch_crash_hotplug_cpu_support(void)
>> +{
>> +    return crash_check_update_elfcorehdr();
>> +}
>> +#endif
>> +
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +int arch_crash_hotplug_memory_support(void)
>> +{
>> +    return crash_check_update_elfcorehdr();
>> +}
>> +#endif
>> +
>> +unsigned int arch_crash_get_elfcorehdr_size(void)
>> +{
>> +    unsigned int sz;
>> +
>> +    if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>> +        sz = 2 + CONFIG_NR_CPUS_DEFAULT + CRASH_MAX_MEMORY_RANGES;
>> +    else
>> +        sz += 2 + CONFIG_NR_CPUS_DEFAULT;
>> +    sz *= sizeof(Elf64_Phdr);
>> +    return sz;
>> +}
>> +
>>   /**
>>    * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
>>    * @image: the active struct kimage
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 6a8a724ac638..050e20066cdb 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -335,6 +335,10 @@ struct kimage {
>>       unsigned int preserve_context : 1;
>>       /* If set, we are using file mode kexec syscall */
>>       unsigned int file_mode:1;
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +    /* If set, allow changes to elfcorehdr of kexec_load'd image */
>> +    unsigned int update_elfcorehdr:1;
>> +#endif
>>   #ifdef ARCH_HAS_KIMAGE_ARCH
>>       struct kimage_arch arch;
>> @@ -411,9 +415,9 @@ bool kexec_load_permitted(int kexec_image_type);
>>   /* List of defined/legal kexec flags */
>>   #ifndef CONFIG_KEXEC_JUMP
>> -#define KEXEC_FLAGS    KEXEC_ON_CRASH
>> +#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR)
>>   #else
>> -#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)
>> +#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR)
>>   #endif
>>   /* List of defined/legal kexec file flags */
>> @@ -501,6 +505,8 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
>>   static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
>>   #endif
>> +int crash_check_update_elfcorehdr(void);
>> +
>>   #ifndef crash_hotplug_cpu_support
>>   static inline int crash_hotplug_cpu_support(void) { return 0; }
>>   #endif
>> @@ -509,6 +515,10 @@ static inline int crash_hotplug_cpu_support(void) { return 0; }
>>   static inline int crash_hotplug_memory_support(void) { return 0; }
>>   #endif
>> +#ifndef crash_get_elfcorehdr_size
>> +static inline crash_get_elfcorehdr_size(void) { return 0; }
>> +#endif
>> +
>>   #else /* !CONFIG_KEXEC_CORE */
>>   struct pt_regs;
>>   struct task_struct;
>> diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
>> index 981016e05cfa..01766dd839b0 100644
>> --- a/include/uapi/linux/kexec.h
>> +++ b/include/uapi/linux/kexec.h
>> @@ -12,6 +12,7 @@
>>   /* kexec flags for different usage scenarios */
>>   #define KEXEC_ON_CRASH        0x00000001
>>   #define KEXEC_PRESERVE_CONTEXT    0x00000002
>> +#define KEXEC_UPDATE_ELFCOREHDR    0x00000004
>>   #define KEXEC_ARCH_MASK        0xffff0000
>>   /*
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index ef6e91daad56..e05bfdb7eaed 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -704,6 +704,33 @@ subsys_initcall(crash_save_vmcoreinfo_init);
>>   #ifdef CONFIG_CRASH_HOTPLUG
>>   #undef pr_fmt
>>   #define pr_fmt(fmt) "crash hp: " fmt
>> +
>> +/*
>> + * This routine utilized when the crash_hotplug sysfs node is read.
>> + * It reflects the kernel's ability/permission to update the crash
>> + * elfcorehdr directly.
>> + */
>> +int crash_check_update_elfcorehdr(void)
>> +{
>> +    int rc = 0;
>> +
>> +    /* Obtain lock while reading crash information */
>> +    if (!kexec_trylock()) {
>> +        pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
>> +        return 0;
>> +    }
>> +    if (kexec_crash_image) {
>> +        if (kexec_crash_image->file_mode)
>> +            rc = 1;
>> +        else
>> +            rc = kexec_crash_image->update_elfcorehdr;
>> +    }
>> +    /* Release lock now that update complete */
>> +    kexec_unlock();
>> +
>> +    return rc;
>> +}
>> +
>>   /*
>>    * To accurately reflect hot un/plug changes of cpu and memory resources
>>    * (including onling and offlining of those resources), the elfcorehdr
>> @@ -734,6 +761,10 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>>       image = kexec_crash_image;
>> +    /* Check that updating elfcorehdr is permitted */
>> +    if (!(image->file_mode || image->update_elfcorehdr))
>> +        goto out;
>> +
>>       if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>>           hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
>>           pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
>> diff --git a/kernel/kexec.c b/kernel/kexec.c
>> index 92d301f98776..60de64bd14b9 100644
>> --- a/kernel/kexec.c
>> +++ b/kernel/kexec.c
>> @@ -129,6 +129,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>       if (flags & KEXEC_PRESERVE_CONTEXT)
>>           image->preserve_context = 1;
>> +    if (flags & KEXEC_UPDATE_ELFCOREHDR)
>> +        image->update_elfcorehdr = 1;
>> +
>>       ret = machine_kexec_prepare(image);
>>       if (ret)
>>           goto out;
>> diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
>> index aad7a3bfd846..1d4bc493b2f4 100644
>> --- a/kernel/ksysfs.c
>> +++ b/kernel/ksysfs.c
>> @@ -165,6 +165,18 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
>>   }
>>   KERNEL_ATTR_RO(vmcoreinfo);
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,
>> +                   struct kobj_attribute *attr, char *buf)
>> +{
>> +    unsigned int sz = crash_get_elfcorehdr_size();
>> +
>> +    return sysfs_emit(buf, "%u\n", sz);
>> +}
>> +KERNEL_ATTR_RO(crash_elfcorehdr_size);
>> +
>> +#endif
>> +
>>   #endif /* CONFIG_CRASH_CORE */
>>   /* whether file capabilities are enabled */
>> @@ -255,6 +267,9 @@ static struct attribute * kernel_attrs[] = {
>>   #endif
>>   #ifdef CONFIG_CRASH_CORE
>>       &vmcoreinfo_attr.attr,
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +    &crash_elfcorehdr_size_attr.attr,
>> +#endif
>>   #endif
>>   #ifndef CONFIG_TINY_RCU
>>       &rcu_expedited_attr.attr,
