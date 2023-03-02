Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25366A85E1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjCBQJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjCBQJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:09:52 -0500
X-Greylist: delayed 2166 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Mar 2023 08:09:30 PST
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC882DE61
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 08:09:30 -0800 (PST)
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322EolOF021526;
        Thu, 2 Mar 2023 15:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=message-id : date :
 from : subject : to : cc : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=SQ7q+5m7QC8vuh8KdrZLoYaoRcEZiM+cHPImqK7sU4g=;
 b=YJDf30Ca5q+2wGLtRbU1rHQMaP1tX+BOoF648sQNyGsoo+tM6RtHtq4Af4SqRPyI2BPa
 hx8WEVua3p32PnvUIrvzpQGnrqGEGjckYaNiGh+PrAR5R76E2Uv6P39Xnpajj+uMu9iP
 3Th9iShxWuV8x/griLBfCK3LeskQjtg729AqmLlJHeGjsHaCgXsCvOpxHP575I6ABiRZ
 lQlMxXz//+xU9pid/Ccxg61iqjg5A4J58hbLZdfx3DDTavcmv5jZWOKEOogx8cD4dxcR
 wKxRFzZEB1DufoSRxKXfhU6pwR7xtTnF8/yKrTo386uNe4FEWDkbVcp8jRwMVTWu5Efx LQ== 
Received: from eur03-dba-obe.outbound.protection.outlook.com (mail-dbaeur03lp2176.outbound.protection.outlook.com [104.47.51.176])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3nyb564yhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 15:32:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwxKVCdK3iKGt2QE7vHCyfMIUmVPNlMfF8eUG5zgaPOnC8aJKciRvNGKBgSxIBJBMWCmslH4JyXmZBgg5iV+5lYXqxODKqQiqzXR6K6gFH9jVYn+crgTBPDA3qAZPgpQGcDNBuFHUk28P2hJusttVDa2+mqUH/Myx3monrQoeiYcsdJcTqCwb3nV9oqAwLUOCprVdSa0AhiKS4NrWlIEK1nIop5krIT592CpI9XzxMVN36afg4GPMDCyVi5l/RXtX9+/6fKi9tdJg3vlUfJTo+s8SOO9i/K31yDmw2HJPsNEXeQQ2yoaHgprPWcT9QDp6d2/gca7npEjh1WArMHWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQ7q+5m7QC8vuh8KdrZLoYaoRcEZiM+cHPImqK7sU4g=;
 b=E9rp45x2hUeZlHvMniXnkiAmVyqCQ0bQQt6+30LwBJS37kYPVOZfDZ2YQb5e7Gmi4QUqa9xwo/dYS28jt51kh9GE1Q1EjzksSEmXDfQMoxE5X/HDFzp1vCq1sj4Rrg20x2A9qO+ol4M/06f5vLh7u/BZAlyP/DdSMLGzzniKMoMf5T40yPCFsmUWmi2kCqcNpz9LzAOLU47CjR8h/kLDTjL7HjgvGPUMZlkGr0TA3XWseaHvt9dYyIS5m+hbB5E5SCRYVDTedzRgJaqBGhVhCYcAzeiwrk345uNINoyWxY4p/0pOIU4lF+3KD8nRGRcJKEe4RDhmj0bbclS0afN5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1332.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:30d::9)
 by PR3P193MB0991.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:ad::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Thu, 2 Mar
 2023 15:32:46 +0000
Received: from AM9P193MB1332.EURP193.PROD.OUTLOOK.COM
 ([fe80::b1ea:2de8:5297:f6ab]) by AM9P193MB1332.EURP193.PROD.OUTLOOK.COM
 ([fe80::b1ea:2de8:5297:f6ab%6]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 15:32:46 +0000
Message-ID: <cb8dc31a-fef2-1d09-f133-e9f7b9f9e77a@sony.com>
Date:   Thu, 2 Mar 2023 16:32:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
From:   Snild Dolkow <snild@sony.com>
Subject: [Regression] mmap with MAP_32BIT randomly fails since 6.1
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
X-ClientProxiedBy: LO2P265CA0021.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::33) To AM9P193MB1332.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:30d::9)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P193MB1332:EE_|PR3P193MB0991:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ec6c08-f4df-4fe9-c5e5-08db1b335f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nOU9X+hsPyNMfpnLaHkpSBsyjWyKTJoPyqVTXMHxydBbP9yNx540ufgTtXbIFhuILKxjRaYY1asqBGxHk3VXONbSJRXyZmMJSsxZjAb6rAK4QrFi7/CgyJo8gLvABJVoDkqGrj+SHU9i5JqvkDwLWoG0Hb2yZc00ld4E97zjL+RvBHGapNiscaL0CBF4s0Xwwkq/qefgfHDGLVlepdb+ssQ34Pwsg9zuIzeTgnFtcilCn5z8iR6t36efDPCkiEqBMO6Zdyb7g6emdaq3oHxMxS9c74qOiL6XxgMY/Sfp6f4jMFZQOwo4OhT6vohYqUPsHpPdG+dSvbBJz1RasvYohmRb4TkHBeVhyYjnXSF6gv9/h6zpWhFxntC/68lvP8g5ByFa21LUrWBToJa11qRb9h1B4NRDbcfu84nQSFfFSDN8xAiW4FxID3LK82cy/F9jqk1f7J0XLQYPWhfVaeoXN0BydbosMT6A3v2BkEt4I7NlT9rMgRKpy16x8wpfgynCDLSQGMgYXkg353KmlOQXRvoR3UQ+B5wiGBpvlJ1RV+P0MYojgA0+sgj+q4l4mMdLLQ+ApYGr6x4CeryavzJkUIgfd4GnV10GiyRN/AuH4Cfg7n+zPCITZ45fc30Jwc8eTg9n+1CylMsmoLd6PgCMoXHN7l3FkZQv3QVaAWCk+Z0Bvz3dgx9mnieEhWAyFA2KZ456bIx9MZZKqtfC7bkbIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1332.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199018)(31686004)(82960400001)(2616005)(8936002)(54906003)(41300700001)(6512007)(6506007)(966005)(110136005)(83380400001)(478600001)(5660300002)(38100700002)(86362001)(6486002)(8676002)(66946007)(31696002)(66476007)(36756003)(316002)(2906002)(4326008)(186003)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEJaUmM2S3E0WEE5Sm05Ni9YTm82M2xJWHlKcE9Md25XZmphS3Z3M0d0REJ0?=
 =?utf-8?B?SXZGcVlzRzlzYm43QjIyV09GUVhkZ0gxMTllTFFqTVpFdHZXV09WU09nWHAx?=
 =?utf-8?B?djVNSktEMFQ2c0M5QXpIMzFaZk5YbnA4M295L1IrV1FZZEVzZDNVSlIvMmdn?=
 =?utf-8?B?WUhPTWkvUzJRaXN4L01oTFlKTytyQXVKK2RtbWtrRWltQ0RuUlh4M3dtWXly?=
 =?utf-8?B?bWdLclF0QXBJR2ZTSmJ0RVI5OFpWVWpHOXgzVlpaSkZydlY3ZGxaNmNDbmor?=
 =?utf-8?B?bzFaaHJtTHRONzdCRHJpK05rR1hGUTlMMzBrMXlnMDBrTVhGUXRBT3RKblFI?=
 =?utf-8?B?MjhISmVQUFluck9Kd3RmQ1FUTlZtRVQwV2EzNElwT2htUTJrc1BkTm5jczNL?=
 =?utf-8?B?QW9hVy9KY2k0L2tvWmFuUGhRREhKWmQ2VzEzOEh2M1BqaElIYy92NVBoVEdz?=
 =?utf-8?B?b2pZa2dSMlMwVVRwa2E1c25VNG5aSEZyZnphMmVhRXc3dTFXTDJXMi91dkVB?=
 =?utf-8?B?UFJmcldmWjVwQzhLN0s3MEhzei9pQnRpb0NuR214QkxhcmRHSGYwM0xiRFl3?=
 =?utf-8?B?QkdZVjFaejY5QmdIeUVkN0VZMVhSQnRxNjAxK3k4M1lsYURnUGg2YXY1UFpB?=
 =?utf-8?B?RHFvWCt4aU83US9oM2g3NXJLQ2VyMjh5QVk0MDBJN1NkY2NKM2pzR0ROeVpy?=
 =?utf-8?B?RXVMYkV4NVZTVTRad2lSUnc1V0N2K0p4SG1LeEJtU0pBaDBWZTJ5aVhhbGlP?=
 =?utf-8?B?a0ZCL3VRS3hSaXp2T3hZWk4yZU9SZlVYM0RiSW9vTlRNdUs2YUFCY2prdTZt?=
 =?utf-8?B?UTRLcFNpU0RyVkp3S3VOR1c5d08xWmMyTVg4M2s3NEx4RGRiSUtLenZqV25M?=
 =?utf-8?B?WDRCeTA4NTZVdXp1ZWlZeDIxaFJJdlJVODRURHNRenFLbHVQZEUyTy9LdGpn?=
 =?utf-8?B?Ny9ISFZCeVRKelpaT1hNZ3F0Nk5qTWRCNG40ZU5LODlkMnpYZjVhUHkzMjU4?=
 =?utf-8?B?RjVsK0YzTW9RUkVieERzRFd2U1R0Qkk1Vk9XczA1RHMvZkVzSVpOVXpGWnRS?=
 =?utf-8?B?WTNYK2p4Nng5OXdzOWFSbHNmakFXK2FLMjhSU2ZwYnJEK00yWUdaT3BrWU9P?=
 =?utf-8?B?WFFhM1BuUFVRMy9haTdxWVhNc2xhcHR6Nk1iRlVBMnpLKytNNFlwbWdXNGVq?=
 =?utf-8?B?SVZjY00zcXFycTArTDcxbHFYYTRDT200bGtGN0VSWW5KS29ZaHdDNnF1T1hw?=
 =?utf-8?B?RkpIaFcrNjFyMEpEUjhzUkVuSHIvWURBMUhCWUJBOWdZbHd6WE5lb3V0empn?=
 =?utf-8?B?YUxIRjZLUnNnaHJKc0FhS1k2YUF5c3VkbWVKM0p4RXhhZkVqWTZLVU9IekpR?=
 =?utf-8?B?SjIreUdPN0RZbEM4eFAxUC9pUzdlM2tNKzF5Ti8zNlpzSlV1MFZRUDVHRTVk?=
 =?utf-8?B?SEVlZ2w0VU1YRUsxcDdOc0NMeWxqRWVnaDF3cHBDMnJ6bVdaSEUxU1RvMWxH?=
 =?utf-8?B?RWxuUnRHelNPSGNGQzd6bHozU0hlRUpOclpZWDJMeS9vU1hhcC9HcCtQVmNK?=
 =?utf-8?B?UGFMZEw3amxqdDcrL0lXQmhwWWtHK0RuRWVqN2ZnTjh3NzlQc2xQZjBUZG9Y?=
 =?utf-8?B?MzQrMVozNEtSaUxBdnhUTlFRSXRvZS9KMUN4OUJpakJYeEZBZGFnd0t4M3U0?=
 =?utf-8?B?YUVIcERWQmo0RU9lV2lwTzF1OWhuUklseGdUYlNzaTRYREZxSS9ScXY5c00y?=
 =?utf-8?B?L1VQVUZzQmZFM0pEd0ZDRWJjVnZ1V2JNZlJsWXNpNGtzdUh5UkxYQnBkeXho?=
 =?utf-8?B?dHA5a1VpZHgyTGZxY3Nud1pSeG51VGJkVFFFSVBEZVFIYkVoUWxJSWsxMGl4?=
 =?utf-8?B?L3RuK2RibFA0VkRKMmNqRTZnTmZJdWVjOHBTSmo2RGVGT01icWxLSjlGOVlI?=
 =?utf-8?B?YVZuK01YLzdyT2RsYUZaU0xrOGlqRmFZY3B5UGM3Ukl1WGpwYnFoV3JJeE1G?=
 =?utf-8?B?d1JwWVdPL0UxdUZDMHRYS2RFblBIRmFkMEZlR3VJL1hTVmp4UCtKTWkzUGxt?=
 =?utf-8?B?RU9scXhVRGI1OUFKRURuV3dyWHVKZHJyN3FxZlhEY3I0TGoxWGw2Si9na2t0?=
 =?utf-8?B?SlBVM2VSYWhRL0x1Q2pQU2kwcjc4KzVEUzAzajFteUpkODN4SzA1VzVMMENu?=
 =?utf-8?Q?91KXhMLDxPEI6an/YxrpXtQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?S3N6ZUYxQ1EvMU5tLzhKT25oNjN6T0k5RzVGNmFsaDVySmppTERtSGdwQ2Z6?=
 =?utf-8?B?aitoNXVKVXpRN0NTZm04UHMrTEJ0MHBqdFVSSTI4aitXVWpKMEpZZ3pXcVFE?=
 =?utf-8?B?RkdPNEd0b0FWUFRycFY4NWl2MFBBUTJGaFdpUlZRNUt4ZnB4TEo1Y3dLdUVi?=
 =?utf-8?B?QkVrNjBRMExmQ2dzZnFxYyt6c3Zxc2V1YjNCM3hYQUd1UHdFYUp1VHlQeThr?=
 =?utf-8?B?SXdhbk91WFhPUHFQcSthdG1KRUI1Mjl2c2VKOXgvUmVGNmhWeUw2cEE5WGRH?=
 =?utf-8?B?dDg0UllLcG5nUG11MzZTaWE3TVFJLy9hbHYveGxEMFNiNS9talJ6RldnS25O?=
 =?utf-8?B?Y2RkMUNzQXNPSXU1NythVUxlejhYTVlqRmtrV21tQmRRU2RaczBkL0hJSVcz?=
 =?utf-8?B?bWpYYUlMN0M2aEltcWVYNzhmVEZBQ2VqWXFRd2crNFpDN2NEOVlZY2FpYUtQ?=
 =?utf-8?B?ekFBbmdKSDJ6cUg4TlNMN2I4aUVwQWtxZzZiZmR3SlJyQW1ZencwQkpvU3dS?=
 =?utf-8?B?VU8wSlpRbVlzdkhKS1hsUjJNWWtoMzhXdm96UEhsMUp3bitTT2lPd3hna2c5?=
 =?utf-8?B?QmV3MGYyRi9vUUhoUVpuQkUvdkVrcGtWVDFVdEV5dS9xakFKMjJzcXcrNXR3?=
 =?utf-8?B?ZlNaQlRjRXlqck5xUWJpdkMxc0lLV1BwdkdTOXUzSTJtMndLUjlKc0lJdmMv?=
 =?utf-8?B?WmMzcEpzclZYOTY0a1N6ZCtaa0ZyMTBNd1gwa20vL01oMTZqVVlKeE5qTWtE?=
 =?utf-8?B?WFFwLzlRbXI4aHREcVVEUG1xbStMNUdpVS9kcitLdHBVTFNHUUg0bElpMXo0?=
 =?utf-8?B?MUs3MDNPSzFYYS84N2ZpSVdrU29lTm9FNnNsc0pTT01aVTVwQTdMMUhDb1M2?=
 =?utf-8?B?ODZtVXIwTThteUVSTzlLcTVLUlh0cW5IQXhOOHFFZnh6cUp6TXFlZWZBa0xV?=
 =?utf-8?B?SFEvYVVKOFAxb25DODdHRS93ZWpUbU1LSExPL0oyUHNqa3BYV2RySCtEa3hR?=
 =?utf-8?B?WFpyTkkybSs4S0tEME5tY1N1ZldTS2NLVFowWVE5cXRjOXJZSnYwRWJaRjc1?=
 =?utf-8?B?VGRQcXBxNDBTMzB2cncvNm1pZEl1WTIwT2hJZkZKOVRGTlpia05IY1VvQmda?=
 =?utf-8?B?Z0MzdFY0ajd4L0hMcWFhMnJqT3RscENYc20rMm5MVWtQa0JKNTZhRGNWL0Fz?=
 =?utf-8?B?UzBRY3dRdU9SR24rc3QxOWZwRmFBbE1rc09kc2VMT1p5dlFHeksxbWhjVS9m?=
 =?utf-8?B?Mld4QXh4Mlg4VmhocVZhdU9sanNJdXFFek5ET1Z2R2hMdlcyRzdmZyt3cjJM?=
 =?utf-8?B?STAvS2JaOGw5b1VwajFNMXNRT1hVZzduR2tsbVJVd2c3akplanBtOXJzVDZa?=
 =?utf-8?B?Yzl3SWcwWGR0Y2c9PQ==?=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ec6c08-f4df-4fe9-c5e5-08db1b335f74
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1332.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 15:32:46.2764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUQYxAohBMrD9pjYdgRI2nSiUKkzT3iXjlT7/YZTQq+0XdRhqM120UmfnELLhv5V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0991
X-Proofpoint-ORIG-GUID: McAcrlOlKTMKULgzsjI5R-siHDGl_lzk
X-Proofpoint-GUID: McAcrlOlKTMKULgzsjI5R-siHDGl_lzk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Sony-Outbound-GUID: McAcrlOlKTMKULgzsjI5R-siHDGl_lzk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_09,2023-03-02_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading a machine from 5.17.4 to 6.1.12 a couple of weeks ago, I 
started getting (inconsistent) failures when building Android:

> dex2oatd F 02-28 11:49:44 40098 40098 mem_map_arena_pool.cc:65] Check failed: map.IsValid() Failed anonymous mmap((nil), 131072, 0x3, 0x22, -1, 0): Cannot allocate memory. See process maps in the log.

While it claims to be using 0x22 (MAP_PRIVATE | MAP_ANONYMOUS) for the 
flags, it really uses 0x40 (MAP_32BIT) as well, as shown by strace:

> mmap(NULL, 131072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_32BIT, -1, 0) = 0x40720000
> mmap(NULL, 131072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_32BIT, -1, 0) = 0x4124e000
> mmap(NULL, 131072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_32BIT, -1, 0) = -1 ENOMEM (Cannot allocate memory)
> dex2oatd F 03-01 10:32:33 74063 74063 mem_map_arena_pool.cc:65] Check failed: map.IsValid() Failed anonymous mmap((nil), 131072, 0x3, 0x22, -1, 0): Cannot allocate memory. See process maps in the log.

Here's a simple reproducer, which (if my math is correct) tries to mmap 
a total of ~600MiB in increasing chunk sizes:

#include <sys/mman.h>
#include <stdio.h>
#include <errno.h>

int main() {
     size_t total_leaks = 0;
     for (int shift=12; shift<=16; shift++) {
         size_t size = ((size_t)1)<<shift;
         for (int i=0; i<5000; ++i) {
             void* m = mmap(NULL, size, PROT_READ | PROT_WRITE,
                     MAP_PRIVATE | MAP_ANONYMOUS | MAP_32BIT, -1, 0);
             if (m == MAP_FAILED || m == NULL) {
                 printf(
                     "Failed. m=%p size=%zd (1<<%d) i=%d "
                     " errno=%d total_leaks=%zd (%zd MiB)\n",
                     m, size, shift, i, errno,
                     total_leaks, total_leaks / 1024 / 1024);
                 return 1;
             }
             total_leaks += size;
         }
     }
     printf("Success.\n");
     return 0;
}

Older kernels fail very consistently at almost exactly 1GiB total_leaks, 
if you change the test program to go that far. On 6.1.12, it fails much 
earlier, after an arbitrary amount of successful mmaps:

> $ ./mmap-test 
> Failed. m=0xffffffffffffffff size=4096 (1<<12) i=1500  errno=12 total_leaks=6144000 (5 MiB)
> $ ./mmap-test 
> Failed. m=0xffffffffffffffff size=4096 (1<<12) i=620  errno=12 total_leaks=2539520 (2 MiB)
> $ ./mmap-test 
> Failed. m=0xffffffffffffffff size=4096 (1<<12) i=2408  errno=12 total_leaks=9863168 (9 MiB)
> $ ./mmap-test 
> Failed. m=0xffffffffffffffff size=4096 (1<<12) i=774  errno=12 total_leaks=3170304 (3 MiB)
> $ ./mmap-test 
> Failed. m=0xffffffffffffffff size=4096 (1<<12) i=1648  errno=12 total_leaks=6750208 (6 MiB)
> $ ./mmap-test 


I have checked a more recent master commit (ee3f96b1, from March 1st), 
and the problem is still there. Bisecting shows that e15e06a8 is the 
last good commit, and that 524e00b3 is the first one failing in this 
way. The 10 or so commits in between run into a page fault BUG down in 
vma_merge() instead.

This range of commits is about the same as mentioned in 
https://lore.kernel.org/lkml/0b9f5425-08d4-8013-aa4c-e620c3b10bb2@leemhuis.info/, 
so I assume that my problem, too, was introduced with the Maple Tree 
changes. Sending this to the same people and lists.

//Snild
