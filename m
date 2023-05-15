Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3DB703004
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241549AbjEOOgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEOOgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:36:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02CF11D
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 07:36:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FD5Jr9009548;
        Mon, 15 May 2023 14:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=jEDnBWeRMffG65wNjPKX3MTePEq6IwDOlQY8tnCfjig=;
 b=iCNgXxTCjDQ06rot1CFTFXpgVKOp5xceZk0AvVJGtwrpuQtkBA5QgpGIDZ81BkTDMKKI
 de2+qfb92jW15rKjY8K6Rzgp8fZebBiADniSZiT+L8ibgtypEYjZadjI+YIW7ty1K3lV
 czXX83rF7Tq/QsUU2NUyGNiA0xx18kE2KqS+WFSSYPg2g/1JvB/pQBGgZmgqaCJ1RHdB
 7OsLS4Ey7PHqiD3BlJtc4l0L8c6poOViBfjkVy8Jx3BUl0f/8e5SYlMlDmbtsk5unm53
 hnoZwcjR8MrtvpKNrQL6kzW9rZL4dxT5104SCjSxQQh/Z28XGFYkHnpMdjEuHUHUDW57 ow== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye02kk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 14:36:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FDBNMt018055;
        Mon, 15 May 2023 14:36:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10381t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 14:36:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USozeC+tG3Cyh2CvbCf+XNqbNhpxH1/jzqquPmmFqewSIih3qIiDsjjeCXQkT3eQJyYa66hbYqr4sq5Z8fu1b8EQFhF/geAcp3g9EW9e0K4zv3BLdz5lXqZsy9lLLPzzbA4F96l+B5wVAjrrMqQlCmymnVntTnYQ1B26wQzJ/eux4i7OUG60nS/HMzKTA5Ab6hjmC9BPDyXUW3y14yX1tTkBWUIa1PscQBoFFQ5s2SOyB+RwbOh9sUdSPTnIWh6l9/6Y2e7NyngkElTIBv9X7a0t5GMUR3juFiBYWkPdmhWFBqTU6U/RhTILqsoJjZcmCx4Zkz9Z4H1AmwQTsA+28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEDnBWeRMffG65wNjPKX3MTePEq6IwDOlQY8tnCfjig=;
 b=ZXsnDnhN4I2zvSodc4keB1gFUZWtTb+ONp9mBT5xWtmh/YpithcfSPJfCJwVoZr33d6M396F0s01ARwDFEyoy0rNPBSet1C9//VywYEar+NG0bMiwJnYpeT9gzGiai2QxS2vAzg+S85M1AN/20Oq7wQfbjQgyl5cni/YFS+xoobE1fK8nUILj0E2IlTKR2IzjhvHtUIrDC4D/TtqHgNwlyk9Ww8tHuhe9DNUcaQ585TcuTIpXUwrPD/YlN4fFB49ROc/PvIMJRW8AyVCv7T7Eakt/dwkvXkv6aUYmbHDrX4zr8MOfMuuQGgoDjvmlJeNZ3NgI5VQraFmSLZG/R1igA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEDnBWeRMffG65wNjPKX3MTePEq6IwDOlQY8tnCfjig=;
 b=vtviV4rym34SFOZahb7oLJO35BtnvrQXUPeekuTAnFZVDWLhQNPEXpb6laNr3IHfA9sfuyGPulS+q52DMPP0/bdGHgWcS0qG+Wf6G5UdqyV0asjagrJ2gEGWQ28mw/k6K0qeYVY31bmHaXMRPlBPCWl18HSM73FlIZqSqiTgfIM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN0PR10MB4981.namprd10.prod.outlook.com (2603:10b6:408:12d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:36:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:36:28 +0000
Date:   Mon, 15 May 2023 10:36:25 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Juhyung Park <qkrwngud825@gmail.com>
Cc:     Michael Keyes <mgkeyes@vigovproductions.net>,
        Tad <support@spotco.us>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH v2] mm/mmap: Regression fix for unmapped_area{_topdown}
Message-ID: <20230515143625.jaipn7exqdr3ylzd@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Juhyung Park <qkrwngud825@gmail.com>,
        Michael Keyes <mgkeyes@vigovproductions.net>,
        Tad <support@spotco.us>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rick.p.edgecombe@intel.com
References: <e6108286ac025c268964a7ead3aab9899f9bc6e9.camel@spotco.us>
 <90777046-a420-b19f-1847-d353b9938131@vigovproductions.net>
 <20230502140828.hilf3myxj6kpiunz@revolver>
 <20230502140907.o7fznev4jthtgp4i@revolver>
 <9460b08a-7740-42bd-8784-d27ea038e87b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9460b08a-7740-42bd-8784-d27ea038e87b@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BN0PR10MB4981:EE_
X-MS-Office365-Filtering-Correlation-Id: bb15c727-a8f7-463f-22cf-08db5551c491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAVEHZJV0Mr0+/fnaeM3SLonPunZ0KHB8n18rfhZBoNmnxuJlZ4H6TWdMJVTHK0tG+uC1qJKYFClk/9mNhvGooyjNLjeG8Rnbtg4k6m1XLxkkMZKtmxiq7E1cKvkV8+wqDfba3cqqiS9bCZjKb72sMtQ8+6WxdndgFCQ37AJ1+oSWNlb+iyAMM9dHUmU1Flnk2H5FFsdp5DREhnRRVNhNzsjsNj/e/IXE6bCDt5IHXZkBRfmCULmj35Nb87+nIJqKcELiIra9UErVyfAo3tAEURVu+ptz8sKhjgPQMp9ZfNrYQRR38SHvMVeJgBJr+yD0s/zqwW+SN33LaKVXwvwnPZ1202roa+wtayXdpVo2msw6Y3qfGvJLm3ASVVPlbC1fuf/ucF773AAfjYx2elu7NPqlen+2j8mkiZSozGxdE+CXwrkKm6dNYFvL7snvHUG5L8NqTkyNGSLsiSKnybxh6ag5gwFAPWS0jy4Tr8dmUouuw+XhNxDShHJW/jrj79+qKGx+3MvNgAxRLiVEaiuyendgvy290O3P0IN5pNPjmMYMTAlelTbsb8STOcgCzfUNICSr1I6SowmAuW+lJ5FkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(38100700002)(1076003)(186003)(26005)(83380400001)(9686003)(53546011)(6512007)(2906002)(41300700001)(6506007)(5660300002)(8936002)(8676002)(6486002)(478600001)(966005)(6666004)(66556008)(66946007)(66476007)(4326008)(86362001)(6916009)(316002)(54906003)(33716001)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVc2eUFnalhiYWU2aTdNZWtWM1JBSTRLeDNJRG54S3UzSEZaY05IR3JSaS9x?=
 =?utf-8?B?eGI4b0FGNjIzaXYxcVZCVjBXclBYa1gyTmF5LzAreDhIUjl4bFRDak1UTDFO?=
 =?utf-8?B?eVNxNEFmTStSK25lMTk5YXlldGZObmh4ZXdHanBUVW5TM3NJcnFhWmJLZWZn?=
 =?utf-8?B?dUpXeWdFb1JJeDBGQ0Q0QUE1THVZeGJVc2llazAvR3YvU3ZYUzVyZEE5SkFG?=
 =?utf-8?B?QUx5WmRzVzR0N0RCU3d0eUJqS3NJSzNYQUVrZHJPWGVPV2VhajU0aU9wSDYx?=
 =?utf-8?B?aHAzVmJtOC9MZTdTVldObWVnS0xObGxESldwb3NSM1doajdmVmFzS011RzJn?=
 =?utf-8?B?MVd0d2FoT1U5aUVybkQ3dzZsbU13V0hYZUt3dnBJUEwwZGpWWmxtRUxsdDFj?=
 =?utf-8?B?aDdMK1RJUGIyWWY5eFF6SWZtOHZpTzFTMWV3MDlYUFFsZUFHSmw0Q2xxbVVo?=
 =?utf-8?B?c0tyODUzdlg1RmlNTVdOSWhrekR5MmYyQzlrNjAwM255dkZXTFNnenA1Tm8x?=
 =?utf-8?B?c0FrZ1pGZFdQdGJCU3AyZ3BTcjdiNE1lcVJ3NWNZQldHSExWZXBNWHBlS2hi?=
 =?utf-8?B?dWExRkNQS2VLSWE1NlR3K0MzbVV3K2d3WVh4dmdNWEprKzY2TUphR3hBb0V4?=
 =?utf-8?B?VVpPQkNwUHdnTGlqaEx5dEdpUmhxbmxWY0ptUUk4d3JlNVpvdUlZMm9ka0ll?=
 =?utf-8?B?NEh4NHpUZzJJemtDbzdrK0p5M1l4cGtSN0U0UFJGOXBjcUtmWmttdmpnUDh5?=
 =?utf-8?B?cEUrdHYzM0d4L2FKRWo3WU9QNzRjN2tzZ2JzY3VRMFhvbXU4L2dvL0JYZ1pM?=
 =?utf-8?B?Sk9PWS92Rkg3RFFHT0tQRnBPS3pFRWVycW14NW9OR1gzZWphd1oxcmZEUytD?=
 =?utf-8?B?ZTVjNkJqMkNhVnBScElOcmJQZXZ2S3RtMXcrN01wdURYc1RnV0Z1amtoa25o?=
 =?utf-8?B?eTE0bGdZa0IrVXl1WEdEOVVkT2h3bGtWakRqVTFQK2YzWUFyZDFWbkFoSnBr?=
 =?utf-8?B?cHhkZGY0Z1h2QTZDL2F0SFVlcUg3ZVFzN3VaVXlOZTJNZ2plSXFkMHhJeWpr?=
 =?utf-8?B?b2YxL1k4MHVReWJZeE0yLzg4emFCZ014SisyNVh4b28vTHhITmllUENoaHdZ?=
 =?utf-8?B?NmF6bE42akh5ZWlGMWtmNHJOSjkzWUpoQllxRlcwMDllWFIydGRLbkh0cEpD?=
 =?utf-8?B?TXNhYjltS1RtaDE4KzFuR1g4RUdkZ2RIMSsxcjJnbWtoZ091NTUyMTZYM1RJ?=
 =?utf-8?B?MlNLMlNjTXl0Qm9aTm90T0dVSndnRUJ6Ni9IbVJCQjJENDFYcWFFbHNxMVR0?=
 =?utf-8?B?aVdIM1dPblhwVFV0Q3FaVWtRQi9rYlBhb3ZBaThVWndvUWV3eXpDWkhnNENU?=
 =?utf-8?B?aFhoYlJSR0huWkRQTG9Odkl3MmtGbEl5MmpvR1I3bTdVNEZKWG1wRENJWkI5?=
 =?utf-8?B?bVAwMXArckhqYXBYNDlQWkw3Z1U4eEFhNmZxc0I1RGh0aWdZSS9vS0trOGNy?=
 =?utf-8?B?b255cklyd1pqZjhacGJlMHlHdEx0U0luK25DVDVWdUdBbkg2VFF5VjFuL1ZL?=
 =?utf-8?B?SFh4YlN1b0VvUGhJdjU0eUlLMXZ5ZmxqMWpYczlBMndjQzYxYUV5NmtRUlJk?=
 =?utf-8?B?dFNpa1IwZm96aGFaTm9GOXp3UEtwZmdlRlpoU3d5YUxQMlRMd1Irc2FQb3Na?=
 =?utf-8?B?c01XemhCOTY1UTF5d3dra3RITlI0MnNxQ0lVdU40UHhrc21QM0laalhDaEFo?=
 =?utf-8?B?eC9wZnpSNGRzazl2b2Eya2EycWtIdFZ3aFcyR0hLTGxzT0Q3SHFQdUx6bkxt?=
 =?utf-8?B?dGo4R2xGaTNTOXg5TFFqMW96RkdRN0RzQUVTMHI4UDU4clliWXI3VHhEWDF2?=
 =?utf-8?B?cGkyaEdTYkZrMm43TnIyV0tPa0JqWnNGMFdzbDRXOUFqZ0pEZGtLRnhzZ29V?=
 =?utf-8?B?VFV0ZXpvdVI5ZlY4TytXaCtmdkE0VW92M2ZrbTdXdi9KalZ4T2kvOE1xOTZu?=
 =?utf-8?B?eXA5cUxTM2h4OENLYVJ6ZmQ0Q2FneUtvMmZsOU5WNlNrMG9mdml0WGNsM2lS?=
 =?utf-8?B?eDlrR0tJK24ybTkzN0VCRWRXRnFIdk1lWnE2VUlZT3JOZUVmKzRhMTZBNFZW?=
 =?utf-8?B?YUhnK2NubG0zVkU0ZkJ2Y3VWNHVzZ3NpMzB5MFdJbnhkeDlPMlVYTHE5WTk1?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VCtsWnYvamRtVm5MTlljdHhEMzIzd3VlZ3g1dENmS2RTMDdLMnRTdkQ4eW5m?=
 =?utf-8?B?eFpOTHh1Y0F5OEo3VzZSaXkvUDBvRVZ0MDJvaXhHdmlTRGp5ZXB6OFprOWcr?=
 =?utf-8?B?N2hWK3JqM013ZHZ0T2tqczVqRkJtY0RuTWQzbVgrdFo4azBhdGh0S0E0Z3p4?=
 =?utf-8?B?M3VlZDRCTjlnUTQwRm1YdXRFT2hhN0ZxdC9PaEdtTjVRYlozZGJIQmMyL2tN?=
 =?utf-8?B?dkhTSTRhMFJtMjZDWjFrZTd3dndGTmMraGZWNDA4N1V4bEhpTEhUTk1ES1FZ?=
 =?utf-8?B?UHJLRk5DOGZyc25YcTZzeFhMRzRJV3RyRXJTenBKRUxSSTduRGZmWGRKNDNn?=
 =?utf-8?B?RXF3MmZ6QUlNTWEyc3orRmI4eG9oSmViQkRDajZuTUcwTkpEZU9UZlJpd0FS?=
 =?utf-8?B?aVMxQmxHYklyWGNwbE1JS3VXOEdIVks0R2ZXZlo2eWthZjZRbWh6WSthTHdq?=
 =?utf-8?B?SDRkTHlKVzV5QmJteWlicGNpMDdyd1dRcnU4N05IWnZ2dXc3R1N2aTduM08r?=
 =?utf-8?B?TnUrZnZGZjQzTEtCZnBiOWkrdFhPdVVLU3JDZmdpWDAySHFqVHRZQVhMajk2?=
 =?utf-8?B?RVZqVjNCb0dpZS94dEdtSUpZc3Y1Z0JOa2hpREFiL2lIK012MTJhTkRJNEhJ?=
 =?utf-8?B?MFhhRHg4cUpPWWhzdDFRZ0RBWk5pSXNTRXB4ZFhiTDdkcU94NFowY3VrUU5T?=
 =?utf-8?B?b2IySks5MDIzSHNJd3VMekRpd0R0SUd5WTZZb1FOb1VIbjJsUTFrWk9ySklT?=
 =?utf-8?B?RytVUjN1SUxjbDZzSStGNkJHN2Z6RTJkS1dFa1ZoK0UrTnBnS3VNTFFuQ1R3?=
 =?utf-8?B?ZCs3ems5aENmeFBnQnBsSkNlUGlTNmhKYkYzNG4rWGYzZGhTNGpuR2JkeVJZ?=
 =?utf-8?B?bFpjNWpRY1hkSGZkQWtPdXY2bER0cGsxYzVuRHFHMXdkc2NES0tkN2NKVmls?=
 =?utf-8?B?VGxybGIrQkUyMDlKS3Q1UGJadVpGM3RpbHkwcXQ2ZkU4NkVHdTlNaFluRXhw?=
 =?utf-8?B?RUJRZE9EcllSTW42S0tmcVpzS2tSS0gxR3pPcGlCZzNNanlhM2VqSWtnYURZ?=
 =?utf-8?B?SXV4c0NKRk45R2RGaGFmaDA3eDVXNkpzUTNuNkRTUXoydXBYVHdEaW5HOU56?=
 =?utf-8?B?N2oyMTlCa1NySjAvNkNsYmNLNjZBbjJpKzBGR21MT0I5eUVvYUNhL3dOQzJO?=
 =?utf-8?B?aFRza3l4NGgyY0J1S1dHU0Mza1pUanBtV29hdzdZSVlPLzZFamtZWFFERnVm?=
 =?utf-8?B?OTBLL3lxcFdpUlowMEd2b0NwOWh3dXBVWE5FY00yM2NxcjdZQmdERGFaa1pI?=
 =?utf-8?Q?hGLI/ThY5Z57o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb15c727-a8f7-463f-22cf-08db5551c491
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:36:28.3215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nsnabf/DUBQLdcHAaJU2+yCxt2BvVhCzTA10Bl5WjHDcGyiKJVuegfI9BajpYaLLoaJFGnU5LUK2Bel17eaMXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305150121
X-Proofpoint-ORIG-GUID: cQulLUzKu5FDZNNquMa8_zXOvubyj3dZ
X-Proofpoint-GUID: cQulLUzKu5FDZNNquMa8_zXOvubyj3dZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Juhyung Park <qkrwngud825@gmail.com> [230515 04:57]:
> Hi Liam,
>=20
> It's a bit hard to follow this particular issue on v6.1 as there are many
> email threads related to this.
>=20
> I just wanted to ask if whether this is fixed on mainline and v6.1 stable
> yet.

Not yet.  It is in mm-unstable at this time.

>=20
> If there's a new thread tackling this issue, I'd appreciate it if you can
> link it here.

https://lore.kernel.org/linux-mm/20230505145829.74574-1-zhangpeng.00@byteda=
nce.com/


>=20
> Thanks,
> regards
>=20
> On 5/2/23 23:09, Liam R. Howlett wrote:
> > ...Adding Rick to the Cc this time.
> >=20
> > * Liam R. Howlett <Liam.Howlett@Oracle.com> [230502 10:08]:
> > > * Michael Keyes <mgkeyes@vigovproductions.net> [230430 18:41]:
> > > > On 29.04.23 15:32, Tad wrote:
> > > > > This reintroduces the issue described in
> > > > > https://lore.kernel.org/linux-mm/cb8dc31a-fef2-1d09-f133-e9f7b9f9=
e77a@sony.com/
> > > > Yes, I also ran into this (even though I'd somehow missed it the
> > > > previous time).
> > >=20
> > > Rick Edgecombe reported something similar [1].
> > >=20
> > > This is probably to do with my stack guard checks I recently added.
> > >=20
> > > >=20
> > > > Apparently the issue arises at mm/mmap.c:1582, where low_limit is s=
et to
> > > > vm_end_gap(tmp). Occasionally, this returns a 64-bit address (e.g.
> > > > 0x7fedea581000), which is obviously greater than high_limit for a 3=
2-bit
> > > > mmap, and causes the next call to mas_empty_area() to fail.
> > > >=20
> > > > I'm not sure why vm_end_gap(tmp) occasionally returns a 64-bit addr=
ess,
> > > > or if the best solution is to just check for this and skip the retr=
y if
> > > > it occurs=E2=80=A6
> > > >=20
> > >=20
> > > Thanks for the debugging.  I will look into it.
> > >=20
> > > I am currently trying to revise how the iterators, prev/next deal wit=
h
> > > shifting outside the requested limits.  I suspect it's something to d=
o
> > > with hitting the limit and what someone would assume the next operati=
on
> > > means.
> > >=20
> > > [1] https://lore.kernel.org/linux-mm/32f156ba80010fd97dbaf0a0cdfc8436=
6608624d.camel@intel.com/
> >=20
> >=20
