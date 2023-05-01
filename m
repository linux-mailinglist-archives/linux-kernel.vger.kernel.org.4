Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0786F30EF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjEAMir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjEAMio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:38:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53AEE43;
        Mon,  1 May 2023 05:38:42 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3410iN1V030646;
        Mon, 1 May 2023 12:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=f3aNel9c1gB/asFelR9Y/FvGErIkKRdamCvd0tOI6bI=;
 b=PAVP/OwEMxET34kSFF+PGuaeBs0b04itTpLvZl75Q/JOmVuriDNtaeQEqKxY9Ro5UKoR
 upYEtsCAsU+7MA4mJ5mP/sGMdUNUNL9RvEnbLwekMaASLwhWSkW4m8Lhe2p6sWa2IvF6
 IHH/OehoYxxFpVLu1I1O2wQrTVsdg3NXqu4gxCvd4TJQwXLdbaitSGbDyO7EGXi2zrFW
 eTR02VWRf8+2PaGa7ZpBQtnMCumQ4uBjJ06nV8DP3My5bQc/jbdH0t/K+JD8O4XrpHKH
 /3Qcx3tJzU1+N7v9vEXxEkWiXSnYbYNmM0AcdpfhDPIVUE0uMz9hjS3R7As0MGfzP1+y aQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u4aj8je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 May 2023 12:38:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 341CNdKG002467;
        Mon, 1 May 2023 12:38:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spanrr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 May 2023 12:38:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2ga/p0Z7U/+Ey8ULWNsROyJlrWuN3+2ZSIrTgSjdl8kkRnv1w8wZz4YTNwRis72EFBBojSD7iRZDNAlpUSuWRVgNwzh+Cewv1fU81O8YHr5JTN70J9oo4cwrf4yp/lWqkxD/rLEl8kbYg9QxxuzbwVW+bq8GvkIcOgIKTZlnwxz/JpXI7SNQAv7/b/qtnSZ7ywl7ZiQyWGv8U8PJqE75NCmPWYESAd+ak1993px1GBd8PrNhP5rRb+WjfHJz5s0zVLqbpby321W3+/IdVwm5GMW0g3YWcMkHrw1cJWstmRuQmIiLy6oiI5V/hSu60bHkZUmxxPeaG/yyD4DNbI1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3aNel9c1gB/asFelR9Y/FvGErIkKRdamCvd0tOI6bI=;
 b=ajbDzZHram3HuhGYhPT263wPTWnJkUe/JzJQTmQhMFaT0XxT/9lutpD4D9dUE6vBjoafxgO+MW6qrp2WYx+u0ntu8is9wOcsKROaZ/ExOQ6kgpxgfqwzBGQyWTG+1yrWhQKRliNF9eG+sCP9+8rWs/6fq2mMR6MJQRKsgyyaSxNfU4gSFiVo57khLUrAcbRVg6esp8Hjk1+XJjttBVh1ZqzjU0ZbC6ROYIRFmcI0xSXDHWGT0V+kN9hR4C7nsMUK6e1vEIcUlChBdkrX4QnwiJ0Scd5R9g9cyvWa4BjMnJEyA5v6wvvRG7x7sjVi8z3FSOpRTTolV1Ax1KDXMdvo3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3aNel9c1gB/asFelR9Y/FvGErIkKRdamCvd0tOI6bI=;
 b=OHdGBHDN6gML3/nWfkjEhrxD/Rutmce5zFbLOroIZv/DVe0EfFSjRtk6AZZZE4L10SWO1qAb1Jk3UVv/e0fEYV1lePt600w7wguq0skRdwGiO6AnwviTOsiEA2N+D6pv1znFOUnChd/s8O2GcXGwkISW/HeXgHOusg6W1VmY/X4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6563.namprd10.prod.outlook.com (2603:10b6:930:59::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 12:38:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 12:38:06 +0000
Message-ID: <df63b597-4355-b9fc-6002-5a390b1a56f5@oracle.com>
Date:   Mon, 1 May 2023 13:38:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/5] driver/perf: Add identifier sysfs file for CMN
Content-Language: en-US
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1682329456-19418-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1682329456-19418-2-git-send-email-renyu.zj@linux.alibaba.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1682329456-19418-2-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0082.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad064f7-f538-4f07-a5f3-08db4a40e99a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1L1UtnHHzE//GgBLGa9jC2iQy88yLRUUlk4Y5e1rLJrKeulmY/RpyRvtY2l6h+UgmbvIK0SNLGVMVMA/gwle/4YmI2P4OeS8jlZhpQDeML2LBFrBr6QI0lRaONPozOXiAZzpDSmWwZQQmL3S8s07ufWlOTbSYAsh24r6RZ3s82dVcITDornAbcHgLbNJVBLi/hTg5coADrA0iw/jPtzdzB7sz9FiEm0IZS5Rd9l9627rk8XY7kwJQO8sQXQtZUWzz17qq2o2Z8TFr8hxECRfMIzEugs/c+I1k3By+Sj9Yd6yNwg/ANt/KEPDao672lsQV9Z+gYXiT+BXyHTX1s0bfzIxCkIZG95pc+GIuj/+GOnSrC2ZDEI8k5p3QLtSuyYno4kn5Fo7MiLcMnOoYt7szd8cMiE0wlHUp4ogSYvcQAGXDofQF2v8NHUojz3N9nJ29/gl5rK6j4zlrphhSahpeci13NIwMtLB8As9u631gX65mnoj2hhyp2ZmR8mpncTEIKbuDFVJ08RUTtXF3ay4tEOd2yMBOcLqXOpJ2lUBbxksvWBoRNOfu2o8UfmrdnNiGfWcmxc6i/wg4ZTftls5oQoECIl8bWdwxDGOJHorI55UO5jhPxrlnEq/P9cP5npJMAmWAA6zmYzC79h0kXE0nA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(2906002)(478600001)(66476007)(66946007)(41300700001)(4326008)(66556008)(316002)(5660300002)(54906003)(8676002)(8936002)(7416002)(110136005)(38100700002)(6512007)(53546011)(6506007)(2616005)(31686004)(31696002)(36756003)(86362001)(6486002)(6666004)(36916002)(186003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDA3dVFMcmZlMUpacTRQc1NVMmFZVVhLeDkrQWRMa1FaS0ZjOXFpM2dVaCtj?=
 =?utf-8?B?dWlqY05JTEFnRVNPL0JoVXNDMzRhZEY2WUdlZXpwQkoya2RDa0xvODBNNXUv?=
 =?utf-8?B?NURvWUlBY1BNNmRhZTJ5MGExbitzQWpJa2dJSmt3SjdUNkRTM0RUeWdJd2xt?=
 =?utf-8?B?NFdiRDdrMlJhYjZyVVhibjRtUVlkam9pMmtaUXpQSFoxZFhQTWRRSnZmY200?=
 =?utf-8?B?aVdHbHBRdXhCODI0UXVZQlQzMmpHRlllZmxiNnhDYWVCUEhzWG9OYUlpTlpX?=
 =?utf-8?B?dXRwUGVJSDZ5cmRFMFY0TGpjdm1laXJHRnQrUzcyV1lhV1FqS2RySmdFVUtD?=
 =?utf-8?B?WFZmMlBIVDBLWVV5aGdOVXVTMkN4Y0FKZEQ4QTFUODJyZ0xuaUErN2w1VGk3?=
 =?utf-8?B?Uk5rcEhIQ2w5WFBxQUZkYlo3SkdPY3J5Ymh1OXJ5czNRdHB1UWFQMHg4OC8w?=
 =?utf-8?B?ODdiTzRrUmgrTHVXUTdCcTZNWkRLeXlrV0x0T2ZPbXhpZU1SM0ovSVk4bjcr?=
 =?utf-8?B?RjFoalNYTlBLR2JpRDJERzc4TGpKRy9ZWmZJdEl2Rm90RGEyOEJxQi82TEVQ?=
 =?utf-8?B?UWw3cHZxZVp4d1h2eHFRNW8wQ0hLV3BtbldNRzhzcmt0aEFpYjRTdlVXaSt2?=
 =?utf-8?B?aDNSM2hpOUdVOUV1NGRHKzFiYXBDMWpnOFJtVEtjSzVQRzd4QngydTN0cUtq?=
 =?utf-8?B?ZDEvU1hqeEI5Zi9RSXhWTlVTNWN3QndoY3A4OUdQRWVyTnZua09WbGlCNk1R?=
 =?utf-8?B?V3hrTlVTVzZGcVptWXBSZUF5NEQxemFBK3hCTkVvYm1NK255MHZsVlVqeHJH?=
 =?utf-8?B?a0thRzd6RTI2Z1JVaG5hR3JlNlhsdE5qRm0xS3Blejc2NTdCaTd2bU9qYnFZ?=
 =?utf-8?B?aUVmdjBWRStRWlBtL1A2MlpkUVNBd2E2U2JrdlBralhPZnlnZXJ0anUrZ3Fm?=
 =?utf-8?B?ZlpFRVYvVkhyd2swc1IzZWsxYW1oSXgzM0ZML21va0h2WEpYRlNOM0lnRmlY?=
 =?utf-8?B?S3V6NnlWbTFEVk1lYWVuaHMrMEp0c0Vha205Y1RlSzZJbzFiS1p6dWtqRk12?=
 =?utf-8?B?b2NJaWVKQmR1ZWdXT2JQMkR3SnkvSTdNY0o3ZGJlb0NyajY0TkhUOHdseVZq?=
 =?utf-8?B?QkJOd2tPTVE1RDNjaXlkeVpuVGFNYnB2alRUeEErN25MUzlpS0h0UnRsUElY?=
 =?utf-8?B?cThVanBiOGswVmpFSm9pV0gySjRRcjFzblorazU4KzI4dEFaeGFoZjNBUzQ5?=
 =?utf-8?B?SnROanJRVzFQOHJ0bC9pU2Vid2l4eDFoTlhCUW5ReC9FM3l1UVdjalRlWnpm?=
 =?utf-8?B?aXJJYnpITTAvZUI1a1BuMkpKZ1BDY2Y1ckh3SlNtdG0rYVhzbkhuTWxvVmZQ?=
 =?utf-8?B?M28vcDAyZW43MFIvT0ZHM3A3NzJ3WVJoMHc1Q3FLbGVwSktZNUQyaVRqSnA4?=
 =?utf-8?B?TVQxbU5IS3JUaEdJM2dMcnRvRjBwazJ5bGdTdHpGTlQ5WjRQYmVoaDRNVzI1?=
 =?utf-8?B?OFVGTC9heVc5UUlDNEhuTzZWazhUVzZtazVWOHBmdEplbUlnN1BldTZ4VWNp?=
 =?utf-8?B?OFBGd29xR1JTaUdPMXdPNTVEdnJXeWl2cndQWjc2MCszc21DZ1l3R0pvUThj?=
 =?utf-8?B?UmwzaTJpaFo2YVoxSjFBOUlIVTU1djl2bmdhWEgrd3hwZS9jdXhvaGIvWUhr?=
 =?utf-8?B?ZXdpOFBLZ2xJNzJhQ2lScTd2QjEyenByaGNJZktCazJIQXRBNFU2Vzg2ZVho?=
 =?utf-8?B?SFMwWENTRDJEVUlVb3hNSDBCbG1HMmt0Q0g0SUM4WTcvZUxuNFF6U2oraTdx?=
 =?utf-8?B?Qm9ZN2tqa3dGZ01UdCt2eXIzNm90OFpCNkpqQXRKaXAyTGZhalN5ZnRDd2NT?=
 =?utf-8?B?bCtER0FqVmFhTk1UMDRMYXZISDdWdWNVQlRGc1dhdE9mQnBxWDNUWC91Ui9H?=
 =?utf-8?B?aitQUHhQMHBIZ3Y4SEpEOExHTURiUUp4QU0zdFhMVVVwWDFtR3hkc0xmS0FK?=
 =?utf-8?B?QTRlQjJaN0hYeVZEUmdiOVVwRi93bUwyemwvWFFUSG1vb1hlQ0luakxYU0Fw?=
 =?utf-8?B?TkpCMzhZZ1J0bUc3Mkg2S2hxclFsc0hWRk1rbkZZeS9QbEcvdVRZdk40SnM4?=
 =?utf-8?Q?c3lB749oAtjn+GkW1HFyt8bSh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Ti9TN1kxQytzSTV6S3RKbnhFTlpCVTE3ZUZNTm1FTVRYa2hHRFBieUN6WFIy?=
 =?utf-8?B?N1RxYVQ3eldmTDFkcHp4cHlOUkxGZnlMMzRCREdkeTVwS1ArRmp2bWh4L1RF?=
 =?utf-8?B?SEJOS0p6ZTJFdXh0YUN2Y2JXK0VERkxqUnRjeXlmYllaaHZYQi9LaWNIMGlx?=
 =?utf-8?B?SlFlMDlHSVk4b3lnWXBqZm55dFpwWmoremhFNjY0VXlmUDhzcHQxY1hLZUpy?=
 =?utf-8?B?YXRsZHMyZWNnVU55MVVqZTNkRTRzT1NsTDkwWjFzSlhDMzRLKzlyMDJ3QkJQ?=
 =?utf-8?B?MFFCWUkyeTMwdFo1dy8ra0xjb2JhMjBUQXNldVozQXFVdXFNYkVwZ3k1NHNB?=
 =?utf-8?B?YzlGRnExMXZpZi95cU0vRmxUS3dwcU1YNjlqbG9hRThDNDZxVnJVTGZVdTEw?=
 =?utf-8?B?amtIc0NaZWtaY05DRmx6YmFzWEV0amUrWHdLaVl3UHNwZ1ViTHMwRFFNNTlw?=
 =?utf-8?B?alg4UkZLVXpwVzROUHRGUVVvZmVSUHgrTXl1K2ZFVFUyWmFEdGpBczJZa2du?=
 =?utf-8?B?UUY4cGdVS1F1NDRmajd3RTU5c2phNkRyR3VqUGU0bXZ3WlR2TU96T1FpTXov?=
 =?utf-8?B?akZqb2RFc1BHOGhxOXJTWXFKWGRzRkpXV1hJcUZ4RWFHRFBPaEs0QXBnM1hT?=
 =?utf-8?B?QnpOcXhsSzgrdHFjcVFsZ2NNT0dwT3VIektXbjRicThibXdrN2d4aU12RWpn?=
 =?utf-8?B?eFU4ZENOSFJRcWVNNjFCdS8rdnNVUnVNWUZRUW9NeEFoWmVkUmFiQU1YZE0v?=
 =?utf-8?B?bXBoWWEyaGh5c2dTeFNjbzUvZFNsZ2labDBWNzhhbXlDUHFXM2NxNUZTYlZa?=
 =?utf-8?B?RFo0YkxOOVA3Nklkd1BSTG9UeVFwR2t4TmdrV1F0WUpIcktrMmVtTWl6d3JV?=
 =?utf-8?B?bDJZZVVmTVU5aFJUZ3NobGtleUVDQlFDdFFuNWhQTTkzcCtCalNsZXhFRHYx?=
 =?utf-8?B?N2F5d25tNkdTZzNVaVJKZG41Vm10NmVKN0sxUVF0TURGME1qU2xmamQ4aUls?=
 =?utf-8?B?L1QzTTFHMElaSE9lYThMZW04UHFLZG1KMEhmZjRSRnBaSUJpVEQvL3dkNGFJ?=
 =?utf-8?B?Z1RTSHR0Zmo0YVlWaW93YW5udm9oaWRzeUNUSHN6aGhDcy9LQks1UXZtK1dp?=
 =?utf-8?B?OGNKb3NFeEhMNkFNMmYvSCtOVDB1c2JTWHdzT3NhVEtJQVhaWngvYmpIeHp5?=
 =?utf-8?B?TXNSOXplbGhCdmUxcTk2Nzl4eUkwVm9TazhnRTBvcENWUlpvOTZkRUNGanZj?=
 =?utf-8?B?NlZCZGluaDdmVUx2U2tTSENFdit4MDNhKzZhdE9EaXhDalRRVU1BdUxyNkpD?=
 =?utf-8?B?UUVqZ2p4T3MwbWdaM0JzS0piVUQxcGRyZE1BSW0zcW1MMmJ6Sis3UjkyQzR3?=
 =?utf-8?B?dzJXMjZtOXlqa2xESTBpbVB3UEZmVGNuRFp1WWkveFpZa2xqdTZ6TjE2TUk1?=
 =?utf-8?B?UC9Fa2hvcXVuMGwrT1FaeSt1OWloY1JuZWUxZUF1Unlwa1B4UjVlNitNKy94?=
 =?utf-8?Q?Q/KytU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad064f7-f538-4f07-a5f3-08db4a40e99a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 12:38:06.2784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VnnI10zSYARIA9oG8r/1gCR0LgwhofRsAS5X7TzVEAVbvh1576JXkvgiecTLOyi3/d292735o9sIQpwgrshiGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6563
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_06,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305010101
X-Proofpoint-GUID: g1uW13EdCxH8Jtoqr4taz9iOZAoUr4Aq
X-Proofpoint-ORIG-GUID: g1uW13EdCxH8Jtoqr4taz9iOZAoUr4Aq
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2023 10:44, Jing Zhang wrote:
> To allow userspace to identify the specific implementation of the device,
> add an "identifier" sysfs file.
> 
> The perf tool can match the arm CMN metric through the identifier.
> 
> Signed-off-by: Jing Zhang<renyu.zj@linux.alibaba.com>
> ---
>   drivers/perf/arm-cmn.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index c968986..f425610 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -334,6 +334,7 @@ struct arm_cmn {
>   
>   	struct pmu pmu;
>   	struct dentry *debug;
> +	const char *identifier;
>   };
>   
>   #define to_cmn(p)	container_of(p, struct arm_cmn, pmu)
> @@ -1168,10 +1169,41 @@ static ssize_t arm_cmn_cpumask_show(struct device *dev,
>   	.attrs = arm_cmn_cpumask_attrs,
>   };
>   
> +static ssize_t arm_cmn_identifier_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
> +
> +	return sysfs_emit(buf, "%s\n", cmn->identifier);
> +}
> +
> +static umode_t arm_cmn_identifier_attr_visible(struct kobject *kobj,
> +		struct attribute *attr, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
> +
> +	if (cmn->identifier == NULL)
> +		return 0;

nit: generally if (!val) is preferred

> +	return attr->mode;
> +};
> +
> +static struct device_attribute arm_cmn_identifier_attr =
> +__ATTR(identifier, 0444, arm_cmn_identifier_show, NULL);
> +
> +static struct attribute *arm_cmn_identifier_attrs[] = {
> +	&arm_cmn_identifier_attr.attr,
> +	NULL
> +};
> +
> +static struct attribute_group arm_cmn_identifier_attr_group = {
> +	.attrs = arm_cmn_identifier_attrs,
> +	.is_visible = arm_cmn_identifier_attr_visible
> +};
> +
>   static const struct attribute_group *arm_cmn_attr_groups[] = {
>   	&arm_cmn_event_attrs_group,
>   	&arm_cmn_format_attrs_group,
>   	&arm_cmn_cpumask_attr_group,
> +	&arm_cmn_identifier_attr_group,
>   	NULL
>   };
>   
> @@ -2241,6 +2273,22 @@ static int arm_cmn600_of_probe(struct device_node *np)
>   	return of_property_read_u32(np, "arm,root-node", &rootnode) ?: rootnode;
>   }
>   
> +const char *arm_cmn_identifier(unsigned long model)
> +{
> +	switch (model) {
> +	case CMN600:
> +		return "cmn600";
> +	case CMN650:
> +		return "cmn650";
> +	case CMN700:
> +		return "cmn700";
> +	case CI700:
> +		return "ci700";
> +	default:
> +		return NULL;
> +	}

nit: I think that it would be nicer to have this per-model string stored 
statically in arm_cmn_acpi_match[].driver_data and 
arm_cmn_of_match[].data, so we have a straight lookup

> +}
> +
>   static int arm_cmn_probe(struct platform_device *pdev)
>   {
>   	struct arm_cmn *cmn;
> @@ -2254,6 +2302,7 @@ static int arm_cmn_probe(struct platform_device *pdev)
>   
>   	cmn->dev = &pdev->dev;
>   	cmn->model = (unsigned long)device_get_match_data(cmn->dev);
> +	cmn->identifier = arm_cmn_identifier(cmn->model);
>   	platform_set_drvdata(pdev, cmn);
>   

