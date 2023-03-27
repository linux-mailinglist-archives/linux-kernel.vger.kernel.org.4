Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A0C6CAF6A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjC0UIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjC0UIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:08:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E38B3A85;
        Mon, 27 Mar 2023 13:07:53 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RK4Jlf011004;
        Mon, 27 Mar 2023 20:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=06ekHFRxvk9/OxCqv4NGvySFN64UeXddsOS6BW6jjII=;
 b=wvWvnLQR6+YKZlsU4Qk/hCaJXoyFP3qG8lp4BslLWWVAJz4S+aj9n7GmCJtAWCV2I+i0
 9MK+GI2ctadCdKp1HDb7a0/BSJ5FWR0vzbsph0GT0/p+VKcLJtmWOMAbg95B4+Lm/MpV
 O5kkTlpClsnZ9+NoMmZ1ixXUOqSI4LcsngZIQGA0lJur7lyxzUXqw5FHpvE089cvqCyl
 TSRxDbjYKlxymz+VYYNNvWRdFpjHcaSwxdCViHg2j/uiKgt4D3dIo0W5sUlBszMYnBzf
 bIQXI7jPsavuHgSogNJNIqETGf2ZoK0hR8T23kHNaL3aACKzfBODcIkFtBJjM1zdqCJf kg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pkhuw806g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 20:07:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32RJMQx7008677;
        Mon, 27 Mar 2023 20:07:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdby75n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 20:07:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsD6Rdk7xif3AEsr74Gv5T3YhHjaaVc/47eJ8C1PU5jptwpMLeKVAZb0NkkIYw4Zv0mP170JQ/+qSxP0bgHC5OOJk9Is4pvTaWUNyN4i4nw8qUCylkMq3JoLBpZNxhgO3yZHRFen+W5R6ci+JouEch3pKbnUcCGetYWj74BICSgh9iX7qUrDDJVjw2FM985po2FD3IcdVau9Lt56B1wPfyaqraJBVU0uy1MXWI8uQUXqRNs6H21coHWgqPG7UP8VwmEX9wtinelh/SZvFVsgrmvUgJVi19UQ2F1hXxSS3NWN0IcIgZ0nwR18LeEVOfDDqCbQ0FjRAQ5oLqUxYKvVag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06ekHFRxvk9/OxCqv4NGvySFN64UeXddsOS6BW6jjII=;
 b=SLmMciYGiv99ODQj6zQnLfxSAJD7MyszBeQDrA/ET7tvc1hYZCSSf7bSnj89LhZnlIhSvybiDTzeomjBWSuoO8E2SkbAJMVtgIzA18GcZ5lufo9znIuYtU0QIhXeGlqnhWVrlqxJQZ//AmQE81Fs3GFUFvXaZ2vzmBsLG2iGlXT2WZWndEL/RaKivBcBo5lmX6uOi9HIOZI2pQg7AMLZoJx4p5FFgy10OW/dYkCfFQ7tN6KimE8SvwfoRvEWiPxyE0BqVT3psMjji6DzrH8ZWtEK9tQhoTDF6NCByQ69eV0qvDZHdqPCjWF8ol8tuDpUfXXb70/6ZTy4JlNUIuFBHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06ekHFRxvk9/OxCqv4NGvySFN64UeXddsOS6BW6jjII=;
 b=zMuhg+j0YwnZkf2SHlxmv1/FXRG232XGyKY9LBrsVwZqTVc1jdDL/odO2CcSUZdfr51sl+afM0KoJ6kjQPNTLovm+BmaZka7zKN6oLnZDKB2B3HatXY9ZvAIdtpV4sUeM5CUo21h3Rkyk5HfzsTbskXH06uqNSycli+Hjmlg5JY=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM6PR10MB4123.namprd10.prod.outlook.com (2603:10b6:5:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 20:07:28 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3%6]) with mapi id 15.20.6222.028; Mon, 27 Mar 2023
 20:07:27 +0000
Message-ID: <a4efd5cd-cab1-b204-1395-670495bc33cd@oracle.com>
Date:   Mon, 27 Mar 2023 15:07:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/1] x86/acpi: acpi_is_processor_usable() dropping
 possible cpus
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, mario.limonciello@amd.com
Cc:     rafael@kernel.org, lenb@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvijayab@amd.com,
        miguel.luis@oracle.com, boris.ostrovsky@oracle.com
References: <20230327191026.3454-1-eric.devolder@oracle.com>
 <20230327191026.3454-2-eric.devolder@oracle.com>
 <20230327195737.GDZCH1MWNvFQrXdY9M@fat_crate.local>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20230327195737.GDZCH1MWNvFQrXdY9M@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0133.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::18) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DM6PR10MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: a7f1b2a0-3c40-4df6-5f54-08db2efee34c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vHDFBSqMx6LOyFrUtNVFhe4thKuWbKhlQD1ZKubtuDW1lu7G0z/WoV1Z2tzxSQIiUnYSHIpyPPkd5FkvMogA/KnU/bjoWSeqaSRkAScMBWtLlYHsYAruDE7QbQMXINA+ZFbd7ZBkN4fY3omO96Caz/ZEca3ICsD0seY169T/QsxRoeFjA8yP3z7fTntCkYS9B42MNWjJ31Mx9DKM5je9lW373yJGwcqsCytHJNoYH0Y/ttSkzk2mnQDmgtdnPOElRBYKP/2qupLJanUxrKVUBYC6D7p1OETbHdO/kz20RHZ5p/DBk1+tm9LwX8DCHjI2mWBB2tcBL2estX2nO1we7/QW289pyyswA3QTocSrYWAOtIzxieC6NmZ+G9CcbhjUwsxnJkPvh25yzyAQQWywSGKVLOFIXu2soX9e8FAguC3bF/Sf5S/4BfVfyyczwQ/nUiLEPy0wyQNQUyl1cRNwDOvkNgTTkCAqQhRk7cEiaWglkPuMy0kqOAAMI2RMSo7DsfpNLatiORdtliPzsBWF5sZ/QfB5c1/xVvPSNFFBrkEHU0FF/GK5dhyzK3cj8IPFMAgswZSp+dHCUDJObgVjBeyUkN/oS6Va3Mq6iSOZYJA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199021)(6506007)(53546011)(6512007)(41300700001)(186003)(6666004)(107886003)(966005)(6486002)(83380400001)(2616005)(31686004)(478600001)(316002)(4326008)(66476007)(38100700002)(2906002)(7416002)(66556008)(66946007)(8676002)(36756003)(31696002)(86362001)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUFuMTFxKzdUMzVXdU5OSWwyYy93Q00za3JPUWNJSnYxVUhLSnQ4dDlDOFQz?=
 =?utf-8?B?Mlh2ZDlBclovdGZsNjR3dWhIQ21sNEdmQ2Z1akpmd2dHVGJ3SGg4NHlOZEtU?=
 =?utf-8?B?eEdzUjJ2ZTZVZVYwcTNhcWozV0RmQ3VpaThjZkhrOHR2TkdTVDdwd3lKZDNR?=
 =?utf-8?B?KzhlblN4QkgwTU4vem1rSGVhV2ZLMStzUlZSSEQzb3VFZ2NHN1psSG9KWm5s?=
 =?utf-8?B?aFV2WTZuUG9KNmpoN1psbUUxdE4xMG8zUUFiRGxUK1ZieG9KTU9BL2g5NU4w?=
 =?utf-8?B?L0sweTJ4aHZFQitSNjI2b0hwd1M3b2lsNG9xeTE5dndacjI0MmpTUk9DRURh?=
 =?utf-8?B?SmVVVTc3VXhMRlp3SC8xdnVHYUJySmNnbW5SY3NQUDRTWmtpVDhmVnRFTlNP?=
 =?utf-8?B?aG1GM2hvelBRc2pXaEJGUlQzSnpjZVNZSjRFYytvSmdWQWxvT2xKZUwrTzFl?=
 =?utf-8?B?b1h4RldqQW8veEV6ZVYvVWF3dW9USXhlK0pVQnVOVXo5ZTZXdVBqc2hROHV4?=
 =?utf-8?B?N3REM0x1dWJDREFOSXlGT0JRckQ3MzI5TC9aTjdpeG9FWFNVQy9FZnkyNTAv?=
 =?utf-8?B?UWZlYTBvOUxZcGREL3Bmdk5FOVRGa2xJK1F0b2xvVDM0cVQyUmQ5cndoRlNm?=
 =?utf-8?B?aWh2eDQxOWVPWlFkVzBXUy8wdForTk53cHZqS3ROVE52WGI2RmdvTWN6MlAy?=
 =?utf-8?B?am9nZkxnYXQvWStRWFlVNmJFUS9LVXliQjZYNktqVmRGM25OdnVVOTByM2h4?=
 =?utf-8?B?NkZ6TisxOS9UR0ZFbjYwMnRFR3BNRzNORW96TWpRU0dsUG9xWTAxR3k0eG1L?=
 =?utf-8?B?cklrRVFaL1FEblZxM3psc0lJMXdxNlQ5NU83SUJBc2pmYThoREpVT2J1YW9z?=
 =?utf-8?B?eHRJNm53WDI0bW5HL1Fma254NlcxbE1MNVRuQzMxdmtRY0ZWNDlLTHMxT2Zt?=
 =?utf-8?B?S3RneE9SdnVFTngrc3BoaW40NzRFa081SXZHMUtxSlRFeUpQMVFCTTdFaEpC?=
 =?utf-8?B?RjhrcXVDSUhMQWgxZDlyQXg4L0dteVBGNzNaeWhiRFZGRlBhZUZLYW5JOHRY?=
 =?utf-8?B?Sy9lc0hTWm03WVhmS2RvRGhGNDNmM2NTQ0hMQno3M2RYVHRLRWpleDYwQitI?=
 =?utf-8?B?NktZVlAxWk4yTVpabFQxQy9kOWdyek95bWh1bFZyVm9Tb1hENDR6STd0TGRi?=
 =?utf-8?B?eUsya0pEcXQvNGt5cTY1RFU1d0lnTXYzSjdET3J0THMyaklQSTNYTUFVUUJ1?=
 =?utf-8?B?Yi9pRnorVXRTU1B0ZXhqdzQ2OSs2TWtyazFESWxVcGNCeGNrV1dneTFHaFZs?=
 =?utf-8?B?ZEZub1ZUU1BabWtYNUN0alVGTWJ1ZHVySDQzczZEbnk0NWlPL05MVEhhaldh?=
 =?utf-8?B?NHNzWUJRUWNUWWQrVW1sRGZIZkxVbnN3cVpkdlJyd1EzeXhjYnVWbVRxUnZ1?=
 =?utf-8?B?RnVGSmtpU0FuSHRIcXg4TFA0eGFTeDZFMlZiNHZsN2tEUXlOUFA5ek0yVjdI?=
 =?utf-8?B?ZGR3ODFoSU5BSDZvMFloTUo4MXp4TVJ6eG8zOUR4RlVOR1VhZGs5V1UvQkFE?=
 =?utf-8?B?cksxdk5EemxtdUdaMU9vanpuNGdnV1RpYXlFWWFxTkh4eTNLOElQWDRQbENM?=
 =?utf-8?B?eCtzT0laN01JTEhPRGFiMXJHTG9TOTF5NTNRdmRIQ0NwVG1lc0ZUSkZqOEJX?=
 =?utf-8?B?UUhqZ2Q0cmMxVm5uSndYcEdzWEx1aGdCZmo2ckhQL2xUWHNpVkRHREY2c0NP?=
 =?utf-8?B?ZGtOeDFEclFRRjZBUW5sVFNVQ3k3TmJkdW9sdDlBcnhxczRLRzhhVnZRaVdT?=
 =?utf-8?B?dS9GRU55SlZ6bEhWYUtERk5lU2dKMFgrQnVHK2tJMWcvTVpBd0ZmQVBFTWJY?=
 =?utf-8?B?SDlnL2JNVlNSL2lYRkM2TUFOZVJUeHVxdFF6OXdFZm0vR1dMejQ3UTRtcExl?=
 =?utf-8?B?ZUNzbzhHNWF1cEdncWl1NVQzQVlFZU1HWFJackQ2L3lhbUpHNWVVSGNHS1Fq?=
 =?utf-8?B?aWtNY2xGZkJvS2p5dWwvV1kzSC85d3JFZlpZYVR1OWdrM0xhOWhFZzFmeFlx?=
 =?utf-8?B?Nm53MnVBUEkzczFqR2xPRFE1T2xuSHpmS0xoVzRSRCt4MFc0RjllcnBiVjNv?=
 =?utf-8?B?T1MvV3gyMFJxUW5acGs2QXRCbTFBaHBCWWFZVEVEQTlVVW1aOVVCT1pXZXhw?=
 =?utf-8?Q?6pK4JebF/iuCdojkRXQS3dY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WTRjbm1yWWFxWWdiOC9MZUZMUkJqUDBHVFNOdDNXOE44QjBMZlJhVTlITUs4?=
 =?utf-8?B?WFNORlEzTzZhOXFmQVF3QkxmR0lqWDcrNjcxcDhodGM4ci9yRk05aGtIY1Vu?=
 =?utf-8?B?YXR1RUlmZzJmaFBaYTQ2V2hhcjl2T2hsazc0QTdBQmpjSE9KZzE0KzVkRHA5?=
 =?utf-8?B?VkVDbkN0ZEV6Y0R0WWJHa0UyVXc0VlNJdkNLT21CME5hc1RBbkxaWUJhT2Vu?=
 =?utf-8?B?RUhFN3lUb2NuSFIxOXpySW5teUxtSExuWTBkNlU3RExXeDlpcjRFY1JKUmp3?=
 =?utf-8?B?UWlNM1VjdVBHdEIrd25sLzlaU3UrQ0lPaGNBNS9mVkdKcThhQkNiL05hUTZL?=
 =?utf-8?B?NDBhNmorcmcrTjhWM1pqR3R3K0JOUklpQ2xnSWdEcGM1dWZvanloQ0JrbUNB?=
 =?utf-8?B?aEQvalloQzA4M2lmSDFoSElScFBYOUxsSFRYN2ZSOGpZcWxFSWh0T04vbWFK?=
 =?utf-8?B?OWFtQVdwWUtsRzJCd0poMVFWNndJbmhpSWpYV1kvYjVSaDRFbzdvM2pCcDdV?=
 =?utf-8?B?aC85dUY5ZjhsV05TTUpRWEw2U25IRksyeHc0YlJvNWtDMTIrYW8wd1VzNlhi?=
 =?utf-8?B?TGNadWxSK2VJSGdKYzJ0T0twQ3BhcTBFRWwyeEhwTThKVnh5WXBUUEdpcVZJ?=
 =?utf-8?B?bDlDZjIxd2lQUU1KNTFhNFVYT05CUlREVmNBTTFjc1JWTmxxMk5JQVlaRGpS?=
 =?utf-8?B?Sm1ZVnFLRDV1REJPbWFpOUJieUdqdlh1ZnM4SHlZckNuQWtzaEd2eU82bHA4?=
 =?utf-8?B?eWhvdkxNbmVCd1NUR0JUNXRsemlvbks5UVNRTGZtUDdxY253V2NFZlFFd2FC?=
 =?utf-8?B?NmZoK2lITytJUEFvWURGdlVmMjgxejBGSkhmSWIydVg1OTVOL0NFT1NVSFpt?=
 =?utf-8?B?dGZJaEUreDRpelVRQlcwaEJVVzZmN284YXlsemQ3a1dxZEs4eldvZWlEK2Qy?=
 =?utf-8?B?b1RtQ1JXalU5K0NhUXl5akRFbk9mczF5Z01JVDA0bXNZZ1ZONWFRQmlkV2U4?=
 =?utf-8?B?OHNpWklpZU9ZQmEvenpBcjJsRXJlbmVQaU40SWVZSHlYNmNwNE1tTW5lSEVQ?=
 =?utf-8?B?bTJGUlZhZSsyWE1TeENnTmJFSmtEbTJnU1IxQXBOSnhQeFZHUm40Y0MwYWpa?=
 =?utf-8?B?VTRjOVhNTGo4V205OHNxNEswUzBtT2FlTmVHelRlTUYzVmVkblNJYlBlTXlI?=
 =?utf-8?B?Umhsa2xhV1ZmVEVJNGtQT0R2MmZFRUUyN3gvZUdscUhZbEg1ZHhqNTR0aE8z?=
 =?utf-8?B?dWdQb3V0T05STlgwcVVsNUVtZ2IxWU1zY0w5b0FXaGdhNEFESkM3b3d1YVZO?=
 =?utf-8?Q?9eHuWTO/aqQoc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f1b2a0-3c40-4df6-5f54-08db2efee34c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 20:07:27.4268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SioWfk47sCSc61qO5EvrNXTgLw5R6sE2bqjFhhWkI0Gbo8bR+HQGkZfmiQmON431SdIzc+sshUV3BdxxXkpVJb1F/1BMMamA/ip1LKDJ9Og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=888 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270164
X-Proofpoint-ORIG-GUID: Og_HRrJlYVZ1uoUb8a8ibNrsBqjr1f1c
X-Proofpoint-GUID: Og_HRrJlYVZ1uoUb8a8ibNrsBqjr1f1c
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/23 14:57, Borislav Petkov wrote:
> On Mon, Mar 27, 2023 at 03:10:26PM -0400, Eric DeVolder wrote:
>> The logic in acpi_is_processor_usable() requires the Online Capable
>> bit be set for hotpluggable cpus.  The Online Capable bit is
>> introduced in ACPI 6.3 and MADT.revision 5.
> 
> I can't find where in the spec it says that MADT.revision 5 means that
> bit is present?
> 
> I'm looking at:
> 
> aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not online capable")
> 
> Mario?
> 
> I see in the 6.3 spec it says:
> 
> "1948 Adds a “Hot-plug Capable” flag to the Local APIC and x2APIC structures in MADT"
> 
> and the MADT.revision is 5 and in the 6.2 spec the MADT revision is "45"
> - 4.5 maybe?
> 
> But I don't see the connection between MADT.revision 5 and the presence
> of the online capable bit.
> 
> Anyone got a better quote?

Boris,

https://ueif.org/sites/default/files/resources/ACPI_6_3_May16.pdf
Section 5.2.12 MADT. Table 5-43 is the MADT Revision is numbered 5.
However, ACPI 6.x specs got a little "sloppy" with Revision, as this
is what I uncovered:

ACPI    MADT    Changes
6.0     3       Section 5.2.12
6.0a    4       Section 5.2.12
                  Adds ARM GIC structure types 0xB-0xF
6.2a    45      Section 5.2.12   <--- yep it says version 45!
6.2b    5       Section 5.2.12
                  GIC ITS last Reserved offset changed to 16 from 20 (typo)
6.3     5       Section 5.2.12
                  Adds Local APIC Flags Online Capable!
                  Adds GICC SPE Overflow Interrupt field
6.4     5       Section 5.2.12
                  Adds Multiprocessor Wakeup Structure type 0x10
6.5     5       Section 5.2.12

At any rate, Section 5.2.12.2 Processor Local APIC structure, has Table 5-47
which is the Local APIC Structure Flags, and this is where Online Capable
is introduced for the first time.


> 
>> However, as currently coded, for MADT.revision < 5,
>> acpi_is_processor_usable() no longer allows for possible hot
>> pluggable cpus, which is a regressive change in behavior.
>>
>> This patch restores the behavior where for MADT.revision < 5, the
> 
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
ok!

> 
> Also, do
> 
> $ git grep 'This patch' Documentation/process
> 
> for more details.
ok, will do!

> 
>> presence of the lapic/x2apic structure implies a possible hotpluggable
>> cpu.
>>
>> Fixes: e2869bd7af60 ("x86/acpi/boot: Do not register processors that cannot be onlined for x2APIC")
>> Suggested-by: Miguel Luis <miguel.luis@oracle.com>
>> Suggested-by: Boris Ostrovsky <boris.ovstrosky@oracle.com>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   arch/x86/kernel/acpi/boot.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
>> index 1c38174b5f01..7b5b8ed018b0 100644
>> --- a/arch/x86/kernel/acpi/boot.c
>> +++ b/arch/x86/kernel/acpi/boot.c
>> @@ -193,7 +193,13 @@ static bool __init acpi_is_processor_usable(u32 lapic_flags)
>>   	if (lapic_flags & ACPI_MADT_ENABLED)
>>   		return true;
>>   
>> -	if (acpi_support_online_capable && (lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
>> +	/*
>> +	 * Prior to MADT.revision 5, the presence of the Local x2/APIC
>> +	 * structure _implicitly_ noted a possible hotpluggable cpu.
>> +	 * Starting with MADT.revision 5, the Online Capable bit
>> +	 * _explicitly_ indicates a hotpluggable cpu.
>> +	 */
> 
> In all your text
> 
> s/cpu/CPU/g
ok, will do!
> 
>> +	if (!acpi_support_online_capable || (lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
>>   		return true;
>>   
>>   	return false;
>> -- 
> 
> Otherwise, the change makes sense to me.
ok!

> 
> Thx.
> 
