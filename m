Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E7B6F45CE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 16:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbjEBOKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 10:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbjEBOKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 10:10:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CFF268C
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 07:10:38 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342AKeBc027285;
        Tue, 2 May 2023 14:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=VIlO7BQTj13MxFn0B/CKKgEd78w3fyz30xNnOUpc5jQ=;
 b=Iz8thI17fubJPJIY679BK6sMGYTIi9YLKgj/O4FJnsSLnn0jaHoULIyoa7+E47wQyIka
 qHHoAfBYUfM54szeAJueI07jwfwXWqWVgLvC+xyX9ovziwpOFKyhs+1UbIlPc8s8U9tg
 4O4+Q0HcFpw8NnWc4tIDiDcu1krOIBaE1CWLY9yGL19p7jA6gc02qK1hQC2qiUKyQPGW
 bbMGb6H3FNS8KObcqd0nW0oT1Y7apoX9oVkoTSDTNrqcKzp/KGuhFJWazHkUlSLEnq8H
 0n8DN4C+PE8GaOU/kXsORgH5ag0PxRayp6P8tZMJTpvbG5S5VzssfBFDiW1CngzrOb71 0w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9cvvk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 May 2023 14:08:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 342CofEK009853;
        Tue, 2 May 2023 14:08:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp69u83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 May 2023 14:08:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xz3Sht34rEz3fKurJy1vrhuLZDgQOmSmJTrmTaxrSJIttymG8KtZmH/fwRMhRwvpJgkhTHXUutb2tsiFS6nDmOiPnZ28U7RSlB5EtiSBZPAALMg/lEcZDT9MHoWZ5yn/Fb/zCJQFnDEKfLYsyIK1b38XCiwXFzhO5KTiPPoubW/UcPfcxg2zv+s6TGpjcUsRcwUhK6rNYOf+o82wgMZ9LJQI0voCWSePWMAw4gX+yjMePTPwef92EHzGP7YD+iAKfDupi8RZgqxZPCm2PpH3qZOLpXVV6K6UhgzivKaWDjDAaut0WI0dJ1nBo5zDZ30bQA2n7LueFX1wuZuDtfHWvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIlO7BQTj13MxFn0B/CKKgEd78w3fyz30xNnOUpc5jQ=;
 b=kAGjB+UjNUin5kQbwEf03zzgHQfPhj5wcYsRafyjm98XAxw1Hbpoqs/mfGOpHGohcBDIdPg4qV8YiGNbRFy4qohcqAatmmoT6e57IbZQbxzNgWCCCI01cHmHUN000Qov/rW2nke2Nk8qqDsysnDDT4cBriIkczuXLUBb02DtyTVrOyfrNw8TL/xEiqmHnbYRpOKU5/7ZpZKULsgRR1qPkxFxAsgxL3RdaZGn1lbIl8Xs/WZe/re5Pf3vgi6P7z0yD+z2yqoB7bcrHwHO4D/cmvkqnUQsFTK5NA3l0aE1jUj44YQf5vaNtnJ6wvNt/fOPGoocpF9PcsQq3Ym+qYwykA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIlO7BQTj13MxFn0B/CKKgEd78w3fyz30xNnOUpc5jQ=;
 b=TD/zMZ45ZQwsUx/KBy4Dbthf+w3ddCZfpGQ19utBia64dRCnrPtH5G2UhUdFRXYVigciP4NNdoOSpvwjCcn5uDStbQ5IwJMjelmnC2ZNT+2H7hYpKr8eJSFYqi/49zBUGbsJNRJHyY3kIRU30DGGZzeifhpcuLdftqARXBqAzBo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4250.namprd10.prod.outlook.com (2603:10b6:5:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 14:08:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6340.030; Tue, 2 May 2023
 14:08:31 +0000
Date:   Tue, 2 May 2023 10:08:28 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Michael Keyes <mgkeyes@vigovproductions.net>
Cc:     Tad <support@spotco.us>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH v2] mm/mmap: Regression fix for unmapped_area{_topdown}
Message-ID: <20230502140828.hilf3myxj6kpiunz@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Michael Keyes <mgkeyes@vigovproductions.net>,
        Tad <support@spotco.us>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rick.p.edgecombe@intel.com
References: <e6108286ac025c268964a7ead3aab9899f9bc6e9.camel@spotco.us>
 <90777046-a420-b19f-1847-d353b9938131@vigovproductions.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <90777046-a420-b19f-1847-d353b9938131@vigovproductions.net>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0109.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::29) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM6PR10MB4250:EE_
X-MS-Office365-Filtering-Correlation-Id: 0039368a-2c7a-4b72-a543-08db4b16b5d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yHmp1QLoUqUMy0ktJ6k2ZKPHBoikM2KlxSMAkLmiLbX+NqD8jd0A8iW4jJZGFKh2XiR7svoV+YgpSY2z1Gts9cEu1q/dTHn8gKJTwO3esIq9JlgOk8CHmLGtXI/V4axw5nY0izKFMveny6FEWhFwEjbIhx9pDG9zQSIFIisI6P8BsyfvEbM7XmScG/R8qEUI0XQtwmUWZE2yevLPhkznsPOY+Jxasr0nyVcA51SqdYvamwbBRKprq3VaZp45sNZFKxeq+uh1OjNmQnm3du+b9DFUNf/kCC4/LLi02WeLYCeXPSdvkze7G6kS5Ln6XX/hWkf+KMr+38CvDyBTgq53Y8kAJYoaom49Ri/uC6uOnk+0kdBbm8TqihmtErxUlsay1d5xPFFvBZecjquRxeTwaTCZjx3yewuv/NiVXvZDQaY+jvx8IQPPeWGTyXD3HgXC1v5JBlXypKtSBVX2JtP4kwK/0wzKcZTE8N+Q6wtfeznA1Mdsdr+sDWldRQup+/KGdXj5t4k8YzMqv9dFfr0g2o0YlhWH4VykGFG7VuJFZ5t5/yIHfejQhHqowtBpIXvDYkD6fWwIypRi2XM6ppkCYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199021)(5660300002)(38100700002)(478600001)(2906002)(186003)(6512007)(6506007)(9686003)(8676002)(8936002)(53546011)(66899021)(1076003)(26005)(966005)(33716001)(6486002)(66946007)(6666004)(86362001)(41300700001)(83380400001)(6916009)(66476007)(66556008)(4326008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGFSeUNGZUhvaUlIdTZUM0dMek5xZi8yZDVRTkVUQlA3YUZzcUJzQUVyU29l?=
 =?utf-8?B?elZGSzR6N2tqc3N1LzhXb29oZ25ST0ZHdFkrM2tkeTllMzZTTGpMUFdpTlVK?=
 =?utf-8?B?Wm1hY2FvOWZ2aHZYaUJJTEVpazVnNUJGdTlMNFFBRXF0T1VSbzRJcjlld254?=
 =?utf-8?B?bHc4UnJsY3ZsZldpRWJQcy9GMGZJcndVcEsrSHkxWnRmVm9DVDFjQ1p3d1Vt?=
 =?utf-8?B?ZE03OVFyRTF2R2hXenlnc3k3RHhWNyszOVFIb2dWNkxicVhsZTFUU2dpK3h0?=
 =?utf-8?B?WWJyZURRQWxYbi9pZUhkdFd0bFZuNkkvend6N2xMLzZ2b2FFb1N2cHFrUTRS?=
 =?utf-8?B?TndzZkRnbGkzbzBDaDlsNThQTkxTaG94aEs3SkNMdnZPK0JjT3JKaEVnZEVt?=
 =?utf-8?B?bW52WmpqUnhKbzZzdjloSDRCQW85L3Y0RjRORzBvYTNsbXI4R3NwamFUUWk5?=
 =?utf-8?B?UnhLek1CRFZydFRUKzBjL3pHQ1I2NUMvenhoc0xmWDA4MG13Qk9saTk2RXE0?=
 =?utf-8?B?RFJFQng4ak83c21ZS1krTUluT2xOOVFXekcyNVVGMXZBcU1SS0V6RHNMRVdF?=
 =?utf-8?B?dkwxbFRnTEhaSU02Y0F4OWFIRk9QNEMvVHpJOWF5UnduakV4dkRqa1lQZ2c3?=
 =?utf-8?B?SEp0VzEwMVI0K0tUMHRiRnlNWGl0czZKU0wwWVVTVit0NUtkWmIzWlNTOW9W?=
 =?utf-8?B?SmdlYTZkRi9KNmEzbkxoaldRSUQydFpiZDdoc1JqQnNsdkw0ZVJUYS8xQzhw?=
 =?utf-8?B?S2N1NE5PL3FkV3JlVzFWTERud3kvRHdKYWYzQUt4ZHpJbWxHclNBM1ZCYXJS?=
 =?utf-8?B?Nkh2bHRFMVpyS2VHM1hic1Nnak1iejhUMWxXczdmc1M1NXFXRk9hMjRDMFFY?=
 =?utf-8?B?YVZUVERJUHBZSTAxVGJZV0hhWEU4cFdNajZSRmhnY0RMUW05Z1pyUlFsWWVl?=
 =?utf-8?B?NUErZ2dQWkhpRnMrR2J6ZEtGK0s0Nk5nRU1JVjN5SEJlY3I5SHhaNUJ5cHYx?=
 =?utf-8?B?L2l2T2hQNXc5VGpGdlVHU0tjaG11U3VZRFRCVXBrMjdGWjgvUmhKZVRHaStk?=
 =?utf-8?B?ZzAzUkNMbkNNTERTOVdUWW5VQkwzZ2xkS05EelQ4UFRQVVd2NEkwMTB5MzBw?=
 =?utf-8?B?aUhEOEMzTkw1R1J2VHpKeU05T1BIaHpEOUxCZkpaSzl3WG1TbFpUVUc4U3ZR?=
 =?utf-8?B?ay8vSU9hT3NGdTZNWXhYMnlYaTZ3Z3BhWGhud2NTc0JSMDRCbDhLdDZ0d3pl?=
 =?utf-8?B?TnhqeXNxbytCZnlqOW9lc2NSbWFSWEsvbnhFWWcxdEdiSHlIMUt6N0ZUNVU2?=
 =?utf-8?B?d1kyQk9EeStMWWIwZnEvbjAzZnR1cVR2U0M1ZEhMTTBRVktHZ2RjcVFkNC9P?=
 =?utf-8?B?TWg1d3Bta1l5aS9DaldIbFdRYytjWDVXblFVN1RoWkthQnFrUzYyVWp6L1du?=
 =?utf-8?B?dCtMWjlBY3J4VmFvRUhTdlV3MzQxcVpKbFJqRWdBZkZZTWVrSVNFZGt4akxq?=
 =?utf-8?B?eEdRbWhzczRQZmp5Z0xEalVGbENuOEhzZ0FGZjFFdExPSVp3WFUybnpXYkpK?=
 =?utf-8?B?UVNhc3p5Zy83NmtXQVNsUkVac1pmRVJzWnhUZmtIMmZWR2lKbFgxSG1qQUJT?=
 =?utf-8?B?SHJwdkpSam9ab3ZuM2NwbmVvdFBWQzFNT25xR2FRUUE0NnE1M014T25yQThW?=
 =?utf-8?B?Ym1TREpma01WcmVXZjdGL2dBZXlsMllyaGEwdDFLVHpqNGFVdUdndmYvVFNh?=
 =?utf-8?B?RHBnelZ3a2NDMG5QSUlKSms1b1hqQ1h0NHBnZkR3VysxNGZuMGs1c3VsN0RM?=
 =?utf-8?B?WlJ4OWx3UHg5MkZMakVVMWRSUUp2OU8zSjd1U0hZWVNhWHJjQVlzZkRzVVNH?=
 =?utf-8?B?RUZweWlWVFo3VWdIUWZKTnZXS3lueFo1dnJrdW5WN2hpOEN1TlRQOXlGdVZv?=
 =?utf-8?B?VGpoWFlHclhWTDBQL1A2cDVVbzYxSG1QYmQxb3g2S1NHdThZSmk4b2tmTGdr?=
 =?utf-8?B?VU9heFZoS2xLalh0S3J1MTAweGUzdWljWWJvMURRVkU2TXRUK1dZR0xXTEwx?=
 =?utf-8?B?RUZHTlVsTHR6dm9OWVJyVlNGOEV5aTl2WkVyVU1nOENWNHJqQWJGM3RqNUZU?=
 =?utf-8?B?a0Y1WUtFTlZ3dlZHSWFQQ1hkaFl6UmFJelJSeFZOcWc4dnRwanhlOXVNOHBY?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NFVlTTN5Vy9Tbm45VVZZL3BGMkExN2FCSWFhazdXeHlXOEhSUDBnWEwvVkZr?=
 =?utf-8?B?Rml2NWxtU01sR1QwQ3VZOEdxdnQxKys4aUQ4elZlcFFnU3lJOWVoRC82dCtU?=
 =?utf-8?B?ZDIzeTlWT244SEc0MGVkMFFVeDJKbkI5U2hFZUR2ZjZlbjJpWE1meVlFSmpt?=
 =?utf-8?B?NTl4MWFIMi9sY2ZrUUFxR2g3R0ZJVkFRbmJPRVZCa1IzOFdFQnpOcnVEemJ4?=
 =?utf-8?B?M3pWUjBtcHN2aDZ1SmN1TldIR0JkVlZiMzBLU08zamdPNEJmVlM4SkszNTNk?=
 =?utf-8?B?SGJSaG0zVit1UjZUZHh2WENaZHJBZVZoelhkMmJ6R1RuUWdtdkZyT3RxVlNB?=
 =?utf-8?B?d1pnTSs4bVp0dUpIQU9LS0ZHallnMzlRbGlzQndmMUIvZmg0YmgwOGZ3KzZk?=
 =?utf-8?B?TVUwVW1nRFV6OENEblZITmc2eWhYa2Vrcy9Wd0hmNVRZS2IrdUc3SU9tc0Rz?=
 =?utf-8?B?cTNLY0ZkTTlYbEJacHNqTnhmdkZBU1BxeUlqOWVwMVJ2c3F2cFg0MzNycXZm?=
 =?utf-8?B?Zm9KRm5YWmU3VUVRMzAxRm5mUzEwNUZteHU3VWs0aXhHM3QrbzRYZ1QrU1Ns?=
 =?utf-8?B?UXpsRktqOGlDd01vQ2FNMEpFR0VlODJyeEcyU3g3U3oyb2dmMkl3VFF0VE0z?=
 =?utf-8?B?b3doOXBVc3doVDFLTUNodmc1WGI1WkkwTDJNMFRlNUF2dTEzbXpTVzU2d2t2?=
 =?utf-8?B?MVdyN0JHUDcyS1FCWi9lQ1gxQm1DdjlNUjJuZm00bXlXWGlnRjhqNnc4WlNa?=
 =?utf-8?B?V0FZL2ZvRkE1U1ZJUlZGcmpSdjJ5UkEwL1FrMCtHZ0tnZkVXb0UyRFNwTUJm?=
 =?utf-8?B?T1BuaFdjSDVESk9ad2E2TmdGRFErL3FScWNHR0hVK3NIT2svZ01ud1RsZ01Y?=
 =?utf-8?B?dFlTVUh0SWJHb3JVSnp4M0MzQjlSYkZHQWIvQVU5Nk9ZTzRCblpIS3ZZSlpX?=
 =?utf-8?B?c3BISStCR1AxY294Ukt3aDM1b0w0WllvUnNXM0dQYVU1ZzV0YnpiK3h6MXJX?=
 =?utf-8?B?aWZIRFdjQ2orZ0ZramFJTFI4dE00Ym1ieXovMEx4ZXZhTTJ4bGNsNjZRNTkr?=
 =?utf-8?B?SkFzOHlNSThTWGNPWDlDdEtoM01vSEZLUGwybytyeHEwR0tWaC9QZ0llOHd6?=
 =?utf-8?B?OXpnKzFtVDdtQUNDLzlXc29Rem5PblR4eGFUM2xLZ0FtR0lNM0JiOTFLb0RI?=
 =?utf-8?B?MEw0SFFnWG1LbEdDTEZLN3I3RGlYbUJYdTl1SThZWlgxZnZFNm5URTVPSDM5?=
 =?utf-8?Q?BgvRJzkJg+78OzX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0039368a-2c7a-4b72-a543-08db4b16b5d0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 14:08:31.6653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHyBw599qzU40qiN9aK6IoCaxRDmM0L4KFWUcc6P3LpWu9vWZV6yjjZE4KOZ8kZBndzraVgu9zhPaVnAHBiUiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_08,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305020120
X-Proofpoint-GUID: rE2mKM_I1Y2-p8mGjtUrosC2X4BsJ3WQ
X-Proofpoint-ORIG-GUID: rE2mKM_I1Y2-p8mGjtUrosC2X4BsJ3WQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Keyes <mgkeyes@vigovproductions.net> [230430 18:41]:
> On 29.04.23 15:32, Tad wrote:
> > This reintroduces the issue described in
> > https://lore.kernel.org/linux-mm/cb8dc31a-fef2-1d09-f133-e9f7b9f9e77a@s=
ony.com/
> Yes, I also ran into this (even though I'd somehow missed it the
> previous time).

Rick Edgecombe reported something similar [1].

This is probably to do with my stack guard checks I recently added.

>=20
> Apparently the issue arises at mm/mmap.c:1582, where low_limit is set to
> vm_end_gap(tmp). Occasionally, this returns a 64-bit address (e.g.
> 0x7fedea581000), which is obviously greater than high_limit for a 32-bit
> mmap, and causes the next call to mas_empty_area() to fail.
>=20
> I'm not sure why vm_end_gap(tmp) occasionally returns a 64-bit address,
> or if the best solution is to just check for this and skip the retry if
> it occurs=E2=80=A6
>=20

Thanks for the debugging.  I will look into it.

I am currently trying to revise how the iterators, prev/next deal with
shifting outside the requested limits.  I suspect it's something to do
with hitting the limit and what someone would assume the next operation
means.

[1] https://lore.kernel.org/linux-mm/32f156ba80010fd97dbaf0a0cdfc8436660862=
4d.camel@intel.com/
