Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03DE742755
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjF2N0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjF2N0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:26:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456F930EF;
        Thu, 29 Jun 2023 06:26:04 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TAoteb007206;
        Thu, 29 Jun 2023 13:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Mmei1fd5hcPzZD68NDIaOA1/GqbWdzzfhrtQuA8T9ro=;
 b=h1QzXcz0SmTymNffJeuj87tsAftd+h5h2qADU+6/QGcfGZpdi+mfXT8puy8ZRPr6EvXT
 7pFRZOwUv8SyUnnCzgGZDehPsTn6ye86LZbDJcUnsZytSJzKW1ZJi/sFdr6kE8Vy7KBm
 Y+iAuGtVeDBAblsCQ6CacgQOhcNguvoDPJ5mApfR37fpx839VYtcY3fadlZCl031y8W9
 j1OElngLcv3YZWHND6cRFO2vjc6FeaYRBXbwTAsQqY9r4OWJ1qyDuF4MQD0K9tLal3qf
 3loyGdIR249KbNxDD2TJINGFs2rrhHX4+WWqTeALJMw6K+Pk25kSw2Ge6B3CzqGUnFOu bg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rds1uc5tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 13:25:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35TCijYa004146;
        Thu, 29 Jun 2023 13:25:28 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxddkbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 13:25:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4HQrwpVzi0KWWa1Q6h5R7nq9hZwAUWRDjdtVSrsn0cp39XyGLCO5quWYHE39BByEKpAVJU6Wr0JV2iOxq1FfRFK0jBCff1PePlQDcv06iS9SSOSIqNlfQSTTmgYLj/diXOrPTxVdon049sYfrt5s6t6wNvp2+5f9qjPPuzoQAxrlNDTwZ9JoBstRQMu/nQzg4zPVrPJ2BOodD2wfGVs9VSFxe8Bvo+Ko5+iAdB0UdkStbbGuKyBROyQQBcH/kvpsnMiak3Z7gZFe6YtxgoH0AxqSOX8u8ADG2B7XIhTMoDYMtArkSHkTEEu4L+q8p/J9IKZnlkrTPdZ+ZrXLHEOoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mmei1fd5hcPzZD68NDIaOA1/GqbWdzzfhrtQuA8T9ro=;
 b=cfccCAibGK9kIRNxWOx3Zn1UAZ0l/8La7h40n/ihY9OWtTKFIYLswyakmacmzqUKRo8ReDgVY1DtERoigwbV8GaIdCwffZn29CmMHI03Oud4ESnv57tYpZhbxpTMEp2vsJ2hcCohUfWz2xXJ2ZlPQJBCOxaX0h9XJBnaB8MKEFrSWsvF9AXWfNoR9wFdOF8IhLeBHSYfZYGDK0Y3LLavNc6vZkX+wSR0DstbwxTEfj/CaJ6kSBzeuP1N0AaSFCYXQJsLydaaEbAbsfZbM71LNahOLX/U0IPSnV2FDLpMxM/cFEgqGRpMZ9s2Zu8ZpnfOQ6JoEe3R/Ue6sa2EcoUxaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mmei1fd5hcPzZD68NDIaOA1/GqbWdzzfhrtQuA8T9ro=;
 b=pkIu8Mouu8BS9GHlWydzv/5eoIdbp72bIKHhwGixC46Xd6Zy0f8usFbGlF40SCAOWuERVrsCUes8wIf3WioLrKnsG+vyoQbQ/tmFLrNfcWuzzfrS7X7ESoDs6xrXigo61SqOOKeSdGg1bYE4bsoMCaPlPe/g6ZRcOVkRJvTtsPI=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BLAPR10MB5169.namprd10.prod.outlook.com (2603:10b6:208:331::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Thu, 29 Jun
 2023 13:25:26 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 13:25:25 +0000
Message-ID: <47ca905e-4431-6388-d1f7-1007a964811b@oracle.com>
Date:   Thu, 29 Jun 2023 08:25:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v24 02/10] drivers/base: refactor memory.c to use
 .is_visible()
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230628185215.40707-1-eric.devolder@oracle.com>
 <20230628185215.40707-3-eric.devolder@oracle.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20230628185215.40707-3-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::35) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BLAPR10MB5169:EE_
X-MS-Office365-Filtering-Correlation-Id: 810190e2-aa84-4b5d-b4fc-08db78a44c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rluCiGe96BCKTef9Ac8CUt+z5Lbs4he6SOnoSyeQixketMqeDbZ0vN3yXtbSR5YwWTqAyEc/NQlsHC9pPC0VRibML542VxyaCq6gTRVy5xcMiw5aFn2jLH9RLJV4Ybdy40eW1dsMgVcQOtE3lX/pmi3hw4h4M3yEaTMas0YzinI3za65dv/bsu+44r010+NI8LnAHwob2JPoDXgF71G/v7AM+FYD5+vUB35b1RE2f2Ys7aCfWWebxswHFooEWMZ0Fa8nRwiAaCn5Yc4MqCJnCIAMVd8E4mO7Dn7qx03iXmOvmTbEa55Kk3tsJkuH6/L5OeinRIdmSLJgtFRmZ90QFpZdTokLZqC3+4UN3YGTwBfc4HsA1GSxkIFk8wqRddXQOAsYopCH2/KtvUVV7fxPCWjTbBxQ3A34XGaOuTOeKQqMrHtKxEYIVYUwlRx3HaoNZvDwUAmPjv74kxUMcNOgcAtT/eM/kQmV/9p16PfkzOEALqLhWhU18a78tjuYJBZ/SNmkibjW3BHTrPa/ev0CCDD9pK4J3HsTW9EKCkCfOYd1sOtUd7y8tuGMCwuqLzsUhfgcyEbHIfWQWso7Y4s70mQv3heczrTi8S/LowPOd4eJkluuqKQFHF58ATRSqQ5gB9WjG4LJiAbjcV0ziYy9zNfobvcI7SGaAwwzVJo8lPX67NHCsXMpDoCcWTF4GkMs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(2616005)(83380400001)(31696002)(86362001)(2906002)(38100700002)(36756003)(8936002)(41300700001)(921005)(6486002)(8676002)(107886003)(5660300002)(478600001)(316002)(6666004)(66476007)(66946007)(31686004)(66556008)(186003)(4326008)(53546011)(7406005)(6512007)(26005)(7416002)(6506007)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHRJQUIzYXlhVS9VN2EwSjNzakhQakNLTmQvT1RJaE15eXBvZ1lXd1hmL2dp?=
 =?utf-8?B?QTN4QTM4Y0NrcnRMVmJZa0pLY2FnRnpobXdFS1hHaXlRd3hYbDZnRnZ2VUJS?=
 =?utf-8?B?TGpvcnFJV3RkWnVPcTl0M2FLR2tvRTdrOVFNT01IZmhXUGF2SUtGanp1L0FI?=
 =?utf-8?B?TE5XeTEyTEFZQ1RuRHZHNUNwTEYxWmVGalhTWVZoOGo0S0ZuTEk0bGlrZWNo?=
 =?utf-8?B?K0k4QnBEY2JONXZTcnZqK3lLSVk5WVRVcjArRkdkcU5GWFkwUnFPZVloM3N6?=
 =?utf-8?B?U2ZGYTY0TG5hMWlSUGpqUGFSekR5K3E2bkR6WnF0c2lsTnFlanNlRUVLWWk0?=
 =?utf-8?B?UHlpaituUENTOGxEc0hsM3dta0JYOUJJYm00UENtckpIVXBoRHFyQ0x4cXlW?=
 =?utf-8?B?b3FSTGppTVR2M1k1ZDFrL3JXbkZEVTZIU0Z4WnhIQXRTT1JRTlh5bWE0d0RE?=
 =?utf-8?B?bWRCanNjMWp1UWpWS2JMdjg3M1lsT1lFaGxRTWs0Uy9HdnpzQmtra04zOXFZ?=
 =?utf-8?B?R0h3QjR0SThhd1N6WXZBWUZyYmlKdmlNQmVYVkttVHljcTFSZTdjOGdLaURt?=
 =?utf-8?B?Rkl1cUUvZTkxbjBWNlU4ZjgyQmE2U3VrbURZZy9GTTBIRHYySnYwSWI2NjZs?=
 =?utf-8?B?N0VuVHlYYnJnbVhkWTVyNDlUZUxKd3duakErbCtVM0tVWkxEV3JaaWI0dFZW?=
 =?utf-8?B?eUlXYy9va3pZQVFXT2FWWlh3RXRTWlZWMXVTV1pTN09xS0t6d2Z5aldGS2Iw?=
 =?utf-8?B?Wmx2bFR3aG11VThnYjV5UmozKzVtT0plbUNZcFBUWnpYL2xkdUlDV05pSUZG?=
 =?utf-8?B?Ny9hVjdPNjFvWFRKbFVJcEpOQzQ2T1NWNkNFTHVYdTMyTkhRQzhpcDROaUdN?=
 =?utf-8?B?UVBWMHkyZTR4RjBZS0sybWdoME9YanhoQVZqU2xvbllnaHVUb1g1TTJjNHp0?=
 =?utf-8?B?emIzTjM3RVBiQ1g4MjUxSDVZa2lsKzNaaVVhTHdBK3VSdVR5ZFIyZjdtcWJO?=
 =?utf-8?B?OVFUMFE1UTJuS0s1QmZydENBQWlFM0VaUEZObmNSalBvdkxySlZobm03Yjdo?=
 =?utf-8?B?U28yczU1QzFBREJrOG4ydTFhRSs5aHZBTVgrU2JEWW54V3V2Q1FIdW8vQitw?=
 =?utf-8?B?cHVNb3Q4MmlxNTh0TE5kTytrbDFxQjhzVEwvNnRHRS9RTGRxa2VDTHJBSExr?=
 =?utf-8?B?eGFNM2dxV1lKa080WCs2U3VUVWdqREM0S0RhcldTWWh4WVB6V2p2NnNPQlIv?=
 =?utf-8?B?SFVjS2Y1WWdiOEVJRktPNzdBc0ZGVzMxL0Q2eFV2TnZ3ZlYzQ0poZ2lqTmNS?=
 =?utf-8?B?d2tTV0Zkb1BzZlR4MUNPbzJiZnFnY2I1cGJ3UGRBZW91OW5oMVdKdCtha3FS?=
 =?utf-8?B?M1k4Z1JPNjE2R3N2WXFPckJqdHlUV2ZvZzZ6MkhRYjc2OHphendiRSsxUFho?=
 =?utf-8?B?b3E2aHQzOFdwYlhObXJTWHZxQmYxVmNoVTBnQWtpWUhGdUZTZVNXZEZ1YVdC?=
 =?utf-8?B?Z3A5SnVQRVpTS2JiemxubjgzdGR4TkZyYXVrYlJXL2QydlFUd1FQZ1BXUWRK?=
 =?utf-8?B?K2FMTElIWDlXdnBDYmc3VExzbW9XZjduZ1lobm1zbUJ6cVp2enBUbGRSTWFn?=
 =?utf-8?B?MWJ0clJXWEp2eHIycUJkd0RSRWMzMEkvSGQvVnExeTFGcGwvY0QraURmSSsr?=
 =?utf-8?B?bm1rbXRjL2pTU0RtYkYwSHRvUWtQYUlHRzBVcU5Mam5xME9ncmlreGdIdzlQ?=
 =?utf-8?B?TVlQSnNLTTE1SUlpQk5uVWdJSXNLWSs4WDNkbXR3dnVPSXRLK1hsekh6eXJj?=
 =?utf-8?B?dkNzUit4MmZmUGtEclA2QlFlQzZEc1pxckt0bU4xMGxvbnl3Vlh5VGdzNGNZ?=
 =?utf-8?B?VEt2bDUwa2c2T3o1aS9oVUw2bDFGa3dncC9HUml3bWtDNlhWMFJVVlF5RWhx?=
 =?utf-8?B?WWZFSjUvQXdSOG15MzdaV2hueGlNcWJBdjI4Z2d2TjVZb3RjUnJiODJUV080?=
 =?utf-8?B?U2RrTWgrMzM1RFlCK0laZGtPS2tOUWJ4NkhDRm56cVRKL3hjWTA0RG9yblFT?=
 =?utf-8?B?SGp0dTQ1bHVqdUp2T0tqRzFDZEF2TTgxdEFqWmFVcDVGSUF2MjI3ZHgySnBM?=
 =?utf-8?B?dUZrVVhEaUZIVW5JbzlEK2t1U0pXYWQ4Q2o0S3ozeGVmcWxIVXZteTg5VlZF?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TThLMVVZM1F2QVdyMVc3OWNNSzhvMXNsVUJFOGpMand4WEtEbmo4aWpTa2tZ?=
 =?utf-8?B?a1BHYmxPZHRkMDRsa0NIaGZQU2dvWGhZdW9mOXVnMmhITjFrQ3c0VGdNSTFr?=
 =?utf-8?B?a1dKWk9idEVCaDdNeUdVSk1KNmc3WUtRT20wR1FkWi94b3htdGMyWml3Nzhj?=
 =?utf-8?B?b3FRVUp1NnowdmJIRjNGMW1QZTVVRXk4OVJmWG53ZFQrL2ZmdmloQkFsM0tq?=
 =?utf-8?B?Vm9jTWtrZThtM0ZsNWduK0ZwL1ZKWktwQ0xoNk80Z0VZN241R0dnLzdNZmNN?=
 =?utf-8?B?anlVQytKT3pZRVorQ1ZPVDl1N25oSGZURVgwVUxDUUpDT3kxTVZrV2N5Wkoy?=
 =?utf-8?B?Qldqd0ZsK3gzS0ZCQVpPL0F1eldyM1ZyR1FuMWxiVXpwOC9paHJuMUtZWW5r?=
 =?utf-8?B?TnNnT1drZTNDeFpWM0pMNndFemY0eE1nbmdrYUZQMk5aek9XQnBpZEhHemtP?=
 =?utf-8?B?RDNrRWMvVUlRWEdTd094TWZqSXo0Njk3aHhWNm5JSHFDT3N2YUFKTVpVcUl0?=
 =?utf-8?B?UndjVGhtZUE0QUpkQittQjN3QzF0VGVKSHBVOFRCbXpOYk1PeWtFdFlYV2pz?=
 =?utf-8?B?WmpaR3l6WFRoL1VWN0owWkg5ZzlmNm11a0wrNlF3Wk8rRjJiSklOWEF2aU5h?=
 =?utf-8?B?S3pzQzQ5TzlISXZjWlBXZW5kaE9odWd5UExpVGtFN0pHZ1Z2UzlmQTg3MEdw?=
 =?utf-8?B?ZEU5SkFWTVhybVJDMFJUT2xYSXBsemdVR1c3ZEhWNjZjVXcwN1RjVkVrMm1i?=
 =?utf-8?B?UGN6b1NGRjVrUXhxYVFpbDRFbkdURUdENytZOWRvekc3R2xHc1FmTEpsdXB3?=
 =?utf-8?B?SUtZSHYvRjdLbmFEcmV3bldjbWpSTzgweHFsSnB5M3Yxem5YeVplbTV2My8y?=
 =?utf-8?B?NU5ZSWhXWWxVRzJFcDdDVG9vL2MyNVFGVGoxaGRKRGNsOCtESWZLNDRybm1C?=
 =?utf-8?B?aEx4bDRBczY5cTY2dzU2Ny9SVDVwbUhzYWJTRHFKVFpyRVBXOG9KMlZadlRk?=
 =?utf-8?B?MmFDTDlNNFFFbURYTjJXZCtzeEQzZDZqTnVKVng0bWp2d3IrY293bWx4TWVt?=
 =?utf-8?B?dDZkaDJVeDZ0WXBnWk9qcnhTNDhFaEx2NFVsNHdlMnFUWW9Zc3dmendwMkRE?=
 =?utf-8?B?d1ZkUDhzV3RXbU16YnUrWGJWay9qdkN0L3ZZVUZhMEJXZW1DUDJOR1lsMnE4?=
 =?utf-8?B?L1puM29aMkdXSGNESnRvYWJDZmVlVkdBQkY0TThvZE1IcmM1Z0NUS3ROTTRH?=
 =?utf-8?B?a2U4RXU3WWZkWEMxMUpXZmx6QUdsNFMwWi9QemF2TDF5aFFyVWZranVudGJh?=
 =?utf-8?B?QkxtcWkvdXZKRjNxK2pkWERscms0RDdhdHV6NU5pbTJRTDZJMXI2UDVzWCtW?=
 =?utf-8?B?RUlUVUk5a0VlQjVzUlhKNDZ1V2V5bzJWN0I2Zk1RazdHVGJSUE5OaVZqQVRr?=
 =?utf-8?B?YytqNm5paTcrQ1dPeldHY1hMVE9FbzI2dVY0Y1pCczg3RnFqQ1pJbVlRWU85?=
 =?utf-8?B?SWtTZkVkTW93bVRNVkY1eFZNaXNUcnI4VXprZDdRRkZ6NU1yeGdmVUZGaHNa?=
 =?utf-8?B?UThBeTcrOUtsU3F6YlBHWEt4YjFEeHg5cDJaT0tHK2NuTm9tK2F0TTdpZzlD?=
 =?utf-8?B?WEF2SEJtaG1FMGRSZTlnOU1Dc0hta1hjblI0K05lYXRWbkNtS2lJVEZqU05r?=
 =?utf-8?B?QlNldE14dWNKcHd1OGpZRG5LakRtVWxvdnBNVzlCWWJMRTFtR3lpaCsxL2tK?=
 =?utf-8?B?SldRU1hwRm1qa29TOVl0VUk3UGkrYzhMMVpqU2NiYkx6T3JkdFduZFp6VTc4?=
 =?utf-8?B?K29lT3VEZ1Boc3F4N2hGQXdaZ3pCdmZlMVFxK2tMZjluL1c2VHI2clNmVTdl?=
 =?utf-8?B?czYxRDRXY2hJU0RJckZzY0psVmdlM3R3NG05c0FOaHQxYXo0RG1jQnVqVXhu?=
 =?utf-8?Q?Xs30JybVC14=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810190e2-aa84-4b5d-b4fc-08db78a44c92
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 13:25:25.8961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JR16Ruqmr8abB3Xraj3QPlQuuk3B+5rljBNxYTFeZUzMdK+MVGwZ8j6aRH+4+qZaqHKLc8uYvG6QadgHguB+ZebM/l+dx73BhAJf5K5LiWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306290120
X-Proofpoint-GUID: WqWHW3LPL0gxKYIMEr5dZEHAmC-LwHdY
X-Proofpoint-ORIG-GUID: WqWHW3LPL0gxKYIMEr5dZEHAmC-LwHdY
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I still need to convert the ifdefs within the functions to IS_ENABLED(), my apologies.
eric

On 6/28/23 13:52, Eric DeVolder wrote:
> Greg Kroah-Hartman requested that this file use the .is_visible()
> method instead of #ifdefs for the attributes in memory.c.
> 
>   static struct attribute *memory_memblk_attrs[] = {
>       &dev_attr_phys_index.attr,
>       &dev_attr_state.attr,
>       &dev_attr_phys_device.attr,
>       &dev_attr_removable.attr,
>   #ifdef CONFIG_MEMORY_HOTREMOVE
>       &dev_attr_valid_zones.attr,
>   #endif
>       NULL
>   };
> 
> and
> 
>   static struct attribute *memory_root_attrs[] = {
>   #ifdef CONFIG_ARCH_MEMORY_PROBE
>       &dev_attr_probe.attr,
>   #endif
> 
>   #ifdef CONFIG_MEMORY_FAILURE
>       &dev_attr_soft_offline_page.attr,
>       &dev_attr_hard_offline_page.attr,
>   #endif
> 
>       &dev_attr_block_size_bytes.attr,
>       &dev_attr_auto_online_blocks.attr,
>       NULL
>   };
> 
> To that end:
>   - the .is_visible() method is implemented, and IS_ENABLED(), rather
>     than #ifdef, is used to determine the visibility of the attribute.
>   - the DEVICE_ATTR_xx() attributes are moved outside of #ifdefs, so that
>     those structs are always present for the memory_memblk_attrs[] and
>     memory_root_attrs[].
>   - the #ifdefs guarding the attributes in the memory_memblk_attrs[] and
>     memory_root_attrs[] are moved to the corresponding callback function;
>     as the callback function must exist now that the attribute is always
>     compiled-in (though not necessarily visible).
> 
> No functionality change intended.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>   drivers/base/memory.c | 78 +++++++++++++++++++++++++++++++++++--------
>   1 file changed, 65 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index b456ac213610..f03eda7e1c9c 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -405,10 +405,12 @@ static int print_allowed_zone(char *buf, int len, int nid,
>   
>   	return sysfs_emit_at(buf, len, " %s", zone->name);
>   }
> +#endif
>   
>   static ssize_t valid_zones_show(struct device *dev,
>   				struct device_attribute *attr, char *buf)
>   {
> +#ifdef CONFIG_MEMORY_HOTREMOVE
>   	struct memory_block *mem = to_memory_block(dev);
>   	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
>   	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
> @@ -444,9 +446,11 @@ static ssize_t valid_zones_show(struct device *dev,
>   out:
>   	len += sysfs_emit_at(buf, len, "\n");
>   	return len;
> +#else
> +	return 0;
> +#endif
>   }
>   static DEVICE_ATTR_RO(valid_zones);
> -#endif
>   
>   static DEVICE_ATTR_RO(phys_index);
>   static DEVICE_ATTR_RW(state);
> @@ -496,10 +500,10 @@ static DEVICE_ATTR_RW(auto_online_blocks);
>    * as well as ppc64 will do all of their discovery in userspace
>    * and will require this interface.
>    */
> -#ifdef CONFIG_ARCH_MEMORY_PROBE
>   static ssize_t probe_store(struct device *dev, struct device_attribute *attr,
>   			   const char *buf, size_t count)
>   {
> +#ifdef CONFIG_ARCH_MEMORY_PROBE
>   	u64 phys_addr;
>   	int nid, ret;
>   	unsigned long pages_per_block = PAGES_PER_SECTION * sections_per_block;
> @@ -527,12 +531,13 @@ static ssize_t probe_store(struct device *dev, struct device_attribute *attr,
>   out:
>   	unlock_device_hotplug();
>   	return ret;
> +#else
> +	return 0;
> +#endif
>   }
>   
>   static DEVICE_ATTR_WO(probe);
> -#endif
>   
> -#ifdef CONFIG_MEMORY_FAILURE
>   /*
>    * Support for offlining pages of memory
>    */
> @@ -542,6 +547,7 @@ static ssize_t soft_offline_page_store(struct device *dev,
>   				       struct device_attribute *attr,
>   				       const char *buf, size_t count)
>   {
> +#ifdef CONFIG_MEMORY_FAILURE
>   	int ret;
>   	u64 pfn;
>   	if (!capable(CAP_SYS_ADMIN))
> @@ -551,6 +557,9 @@ static ssize_t soft_offline_page_store(struct device *dev,
>   	pfn >>= PAGE_SHIFT;
>   	ret = soft_offline_page(pfn, 0);
>   	return ret == 0 ? count : ret;
> +#else
> +	return 0;
> +#endif
>   }
>   
>   /* Forcibly offline a page, including killing processes. */
> @@ -558,6 +567,7 @@ static ssize_t hard_offline_page_store(struct device *dev,
>   				       struct device_attribute *attr,
>   				       const char *buf, size_t count)
>   {
> +#ifdef CONFIG_MEMORY_FAILURE
>   	int ret;
>   	u64 pfn;
>   	if (!capable(CAP_SYS_ADMIN))
> @@ -569,11 +579,13 @@ static ssize_t hard_offline_page_store(struct device *dev,
>   	if (ret == -EOPNOTSUPP)
>   		ret = 0;
>   	return ret ? ret : count;
> +#else
> +	return 0;
> +#endif
>   }
>   
>   static DEVICE_ATTR_WO(soft_offline_page);
>   static DEVICE_ATTR_WO(hard_offline_page);
> -#endif
>   
>   /* See phys_device_show(). */
>   int __weak arch_get_memory_phys_device(unsigned long start_pfn)
> @@ -611,14 +623,35 @@ static struct attribute *memory_memblk_attrs[] = {
>   	&dev_attr_state.attr,
>   	&dev_attr_phys_device.attr,
>   	&dev_attr_removable.attr,
> -#ifdef CONFIG_MEMORY_HOTREMOVE
>   	&dev_attr_valid_zones.attr,
> -#endif
>   	NULL
>   };
>   
> +static umode_t
> +memory_memblk_attr_is_visible(struct kobject *kobj,
> +			       struct attribute *attr, int unused)
> +{
> +	umode_t mode = attr->mode;
> +
> +	if (attr == &dev_attr_phys_index.attr)
> +		return mode;
> +	if (attr == &dev_attr_state.attr)
> +		return mode;
> +	if (attr == &dev_attr_phys_device.attr)
> +		return mode;
> +	if (attr == &dev_attr_removable.attr)
> +		return mode;
> +	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE)) {
> +		if (attr == &dev_attr_valid_zones.attr)
> +			return mode;
> +	}
> +
> +	return 0;
> +}
> +
>   static const struct attribute_group memory_memblk_attr_group = {
>   	.attrs = memory_memblk_attrs,
> +	.is_visible = memory_memblk_attr_is_visible,
>   };
>   
>   static const struct attribute_group *memory_memblk_attr_groups[] = {
> @@ -878,22 +911,41 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
>   }
>   
>   static struct attribute *memory_root_attrs[] = {
> -#ifdef CONFIG_ARCH_MEMORY_PROBE
>   	&dev_attr_probe.attr,
> -#endif
> -
> -#ifdef CONFIG_MEMORY_FAILURE
>   	&dev_attr_soft_offline_page.attr,
>   	&dev_attr_hard_offline_page.attr,
> -#endif
> -
>   	&dev_attr_block_size_bytes.attr,
>   	&dev_attr_auto_online_blocks.attr,
>   	NULL
>   };
>   
> +static umode_t
> +memory_root_attr_is_visible(struct kobject *kobj,
> +			       struct attribute *attr, int unused)
> +{
> +	umode_t mode = attr->mode;
> +
> +	if (IS_ENABLED(CONFIG_ARCH_MEMORY_PROBE)) {
> +		if (attr == &dev_attr_probe.attr)
> +			return mode;
> +	}
> +	if (IS_ENABLED(CONFIG_MEMORY_FAILURE)) {
> +		if (attr == &dev_attr_soft_offline_page.attr)
> +			return mode;
> +		if (attr == &dev_attr_hard_offline_page.attr)
> +			return mode;
> +	}
> +	if (attr == &dev_attr_block_size_bytes.attr)
> +		return mode;
> +	if (attr == &dev_attr_auto_online_blocks.attr)
> +		return mode;
> +
> +	return 0;
> +}
> +
>   static const struct attribute_group memory_root_attr_group = {
>   	.attrs = memory_root_attrs,
> +	.is_visible = memory_root_attr_is_visible,
>   };
>   
>   static const struct attribute_group *memory_root_attr_groups[] = {
