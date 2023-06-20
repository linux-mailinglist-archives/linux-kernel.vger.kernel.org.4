Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19CC736496
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjFTHb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjFTHbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:31:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8867E10F8;
        Tue, 20 Jun 2023 00:31:03 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35JNLYKe006337;
        Tue, 20 Jun 2023 07:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=f1JxmKAiNZzEy5S1RMs5Mk9fRHNiy1pR46DCKOYvuoU=;
 b=ouYYJjT552+XT/hTUsKjl10Y6GpKGyqJY4DuXuvrLhBPwvKbATmUvT+7kn9DClcwBMIw
 Ddj2GMQRcrEfYgdIXESkfv/ljlxnjcarQ067iDkbvTbeJKh0a/vWl1fjAMqLkW8D9JJX
 WzHM7H/ZYSNqnSiQOnqPUICFVsYCjYAlmrfj913M58l+3dg+9E9NMiS9PfQ7ySbkRMhy
 93vsqmc837ave6mlOZ2u6fy4ud6F8PHidRElmfwFic1tOlcYPVAMCn8LXJug4zgrKoi2
 OGVtqoznfYD3hbxZTp+IbVIqqGAFiNpTKBlSeb4gUykTowQSAvtKlf0gMU+7xHim5f0f Gw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93m3m1nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 07:30:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35K5gEUv007745;
        Tue, 20 Jun 2023 07:30:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9w14jxkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 07:30:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpKycSgWTaan2GuJu2UJqReNAz9qlAbDtYy9nV8zjIs4JMSs+xrjaXE3gse3eYproAzm586gD7os7MRRUZyHVOau0byxHlolEnoue6YtLv1/iwr6HtfjfYkdKFabjUgO79u2fLLoiJ2OsBEBCt/yfImxxmFW3rqt8wUR3GmyMw6+ggF3I7xzAHWaouqnGYGDUxs3XV9lxEvStLsHXGKNuejzTeiqClGtcTh8xDqRu2V4T9mO1QpneLc+mJ76U6m+RrlmFY/127L4V2L+VcgbrxXyS7EwYFMIuXpxsnWyN3uB1NNMshMdpSkorZVuRgFwLHVDCaHrV0WChrMZgVbOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1JxmKAiNZzEy5S1RMs5Mk9fRHNiy1pR46DCKOYvuoU=;
 b=oCAhSXyIIqYW9NnQurg2WMZKLi5kBwAiByhbAlzDH0FF3KimTmdqNecc7jn4efd23B+IdtgmyYz20evmo4sMQYw60jbZbwinFRtDMAsNXXUSS3Hw+QyEgIlqAufiQnHSWhUu8TYkjCIqi5pumfnSJOjSPKh/ff9M+u42DLW/z0cucew7A2V1P3sqwhD8kd8OTBZsa0yiZQrNXfwzjw8609yp0jkc4Cj/gWneApHXKCL9+K4diTQ4nz2FoqMkFrR4fvp56m5R1g5nnzWdxTPYgkVulhBLPUX9YgQOo8D29UZDcb1PE13lrR4MT74lb2/xAcFFBi8DXXN+CVeLqWhIuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1JxmKAiNZzEy5S1RMs5Mk9fRHNiy1pR46DCKOYvuoU=;
 b=cYOppFyenqgNIcoN9FxwmkYMDzSSHjhUTuNiz4zgrGe4Wc/NenFQpQw31Dd8+cSwcy2ahhcbCZhk+6F4/Tp5hk14CEx/R1Vf2VbV2qb8JsKYVP4lat59vMkwuXPJYndb4IpKPrjdAQXnEW2crzmmh/Ivq0dwmdBZi7/HKn5Lp50=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5645.namprd10.prod.outlook.com (2603:10b6:a03:3e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 07:30:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 07:30:41 +0000
Message-ID: <776da0d6-d2bb-ea1b-2aca-13a2a3c8ddc0@oracle.com>
Date:   Tue, 20 Jun 2023 08:30:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 4/4] docs: perf: Update metric usage for Alibaba's
 T-Head PMU driver
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1687245156-61215-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1687245156-61215-5-git-send-email-renyu.zj@linux.alibaba.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1687245156-61215-5-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0222.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 5544627e-432d-49e6-5115-08db71604078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XMxqNuAjk5ZHai/hmSRjGmkBtnSek+ns0kGAMl5Oo1B65m4/1hr+anhs3L4i43Mjn399iLEnd9FCfN2Cseb5SGghZC1tHdu71z3nAkaT7AX7xtTKO/aWqIp1enFkWP9nTetMWZKclBYYkEyK5UW697Lif8HNTkZ8EU9e8OTHtJJEv3goKWEZT7CP0eYX0EVlg2c1XgiFa+LyE0f346y+baPlnr17K829SonNWIv1nmao2LudONJKjEh7sd+6bxWrJZoC9yTB9foHLiFWx346l+uSeoiFDGe4VT7PtyUk0FG+AgJQY7qp/Sg3GhTmxvR3aeVtuqJAXktZB5VSWZKEMLuKtevLxULJhQPF9T0SSdXHhDBQ0nGyyrQ4qESg0XWnAMRbzPMru1LnA1tfGlUqXMkt1eTeRnrnirGt3DSieE04kTUPHvoOFNTrC2QLRmrGARoYorA0KjTvU2Lr2hdJnTWpUzsNS3vUZ87Z1p+mmz2dHwGl5sIP8pJAUsJ8IceBb8xyEN8398aUJFPbt+i0wphGdojdG83+3ccWO47hB+VdxjgBNLGDmmGHbLZR+n+pTPD2cz4hFAnqdH9aTTdjfQLxuVNmyXhRU2zlvY7l4ktov2C6et0qfnGi02FL0/5SSxVzs+F9t1D+R9jowJB/0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(186003)(110136005)(478600001)(36916002)(6666004)(6486002)(31696002)(86362001)(53546011)(6512007)(6506007)(54906003)(26005)(31686004)(2616005)(316002)(38100700002)(83380400001)(66946007)(66556008)(66476007)(4326008)(8676002)(8936002)(15650500001)(7416002)(5660300002)(2906002)(41300700001)(36756003)(558084003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmJZSjJkUWU3NXl5WmZQRS9XclE5YzRsS2NCcFErblRwaWJGVnpYUTloMDcw?=
 =?utf-8?B?VEhRdHZuYnkycnZkNVdWa3lFVmNhUW9wSHhFQ0YxZTlWaVdDd3dWdjBqMUpo?=
 =?utf-8?B?emF6VnM3ZVlZTjhBM20yUEJnc2dXdCtSUkUrZlBoQkRaN29YQnZjSUk4MURP?=
 =?utf-8?B?T0dUbDhONFFZaXFISVZzWHpsNHgrb2tBaFlES0M3UzkzMDFBMnUrT1NCSUlx?=
 =?utf-8?B?SS9PbWx1L3VGV3d1MFd6Yk9La0YxKzNTdU80MHM3d05nTFpQLzdPajFmUnVY?=
 =?utf-8?B?K1RvYzFIQ3lJK2NxaUpleVdaZkcwenJaQUtNOGlxRDl5Qno2MXBvay9ocTV5?=
 =?utf-8?B?WEJocWQ3MGxzQ1R6NzRBTVE3aGhuS1pSd1VqUDRySlFDZkxFcHRjSTdZS1BU?=
 =?utf-8?B?NUZWUTBaMVNTZ2ZWN3IvUkEyUzNxU3A0UVFDVG0zSkpsYW5GbXBGYVgxSW1D?=
 =?utf-8?B?aXhTRTBBK29FNHpVMWU5N2pQREVJa0E3MTVXRjZQQXU5SSthZ0UvRmlQWEJk?=
 =?utf-8?B?ZzN3N3UySU1JUHhLelN5M3Z0N1ZzaTlLYUFIZFlNaHdPQXo1SmhvNGdBVjdz?=
 =?utf-8?B?SWNqK1hjKzFjSkw0T1VId01sWUFnZHVPczZFSzVrWDVXMjFoSzk3QkI3ZnFD?=
 =?utf-8?B?YnJNclM2ZDc5ckZsU2c3WkJ1QU9uVDFKZlI0NU1WU3RVQWNWempTMlZyRld0?=
 =?utf-8?B?Nk9FNVU2dDU3cEsrVlVMai9EVWt2d2ZBb3FCcU05TStYVGlKRHYwaVZZRlFm?=
 =?utf-8?B?ZkI1ZEg5a0VpSTdXMVFjb1V2MjlrWU5iN3RQbVdqN2NWTUM3R283UmpHeVJ1?=
 =?utf-8?B?Rm5XTitFalhkN1RXUUFsaEJ1M1ZxbUhBTHBDeFY4bUhtVSs0cC9IcEFidVpY?=
 =?utf-8?B?VTdYZ2pGNm1QZTlrc0ZzamgvSklBV2tMbC9ldWdXSzAyZWtzOEpSejB4aC92?=
 =?utf-8?B?dGQ0SkFNRFVyM2twbXlyZEhXR2RsZzVETCtOZTZyODJKaTl6Z2xtM3l6cFcx?=
 =?utf-8?B?V3NwQzRveUVWblZOdUllakRVOFgwc0FTQUd0blovZVZ0ZGtFbEtoQ1MvOHNL?=
 =?utf-8?B?UzlUTnpZYU9iMXhWU1lhYTA0UDJJekNGWGpacmlwNGovdnRzbnMwbS9xWExW?=
 =?utf-8?B?VDNoSlJXN21rYTVrbXRMcDQ4eHZLMUZYRzRRUjd5dUN0Q0ZsN0xMWFFWeWor?=
 =?utf-8?B?V2s2MjBLZE15YmFFR0hPWnFWanhnWTJUY3NSTHlPbE9GMkZSV3FEeDB5dGRM?=
 =?utf-8?B?MGRibHdUZWRHWVc3Z3h5c3FkeFZ4Qk5aZkdrT2FzcG0yMHM5NDdLUmpnZ2Ja?=
 =?utf-8?B?akt3N0Ryc3dxS2pPbU1od1ZmS3E5azhzZm9kVGprdDBwWjFZeGM2V01remd4?=
 =?utf-8?B?U1BEc3h1bmFkaFlLZjdNMk4yRG9wVktlcVY0S3hkQ1VQUnhSN3JGNWpZamZp?=
 =?utf-8?B?Z0NzVlNuL3ZqbW1RMUdKd1ltSDIzTkVYdGJ3cW5JUCtiQkl6MlB4bEh4eEZs?=
 =?utf-8?B?YmMzZktUQzF0VnZEejZtMHZaNENVSjE0cnhKVThMOTJUcVNHMWpTRmlhSTgy?=
 =?utf-8?B?RTl6aWxHRUN3NG1acU5GMG55MzlrRkRXQms3RW5zZEV4NXp2cDd4Z3VtZ3NF?=
 =?utf-8?B?cTBQT1RQdzcyWmdJYzZaY1RrYjNkd3owQ1FvT2NwYWVYR2xENmtVY05xbWZD?=
 =?utf-8?B?aXZndUN0Tkh0QWwvMTdsaUlvaWdCMFM3c1NTNmN6c2xLeXRpNG1LZmF2aS9m?=
 =?utf-8?B?TkI0TE5BWm0wOWJFUkx3WVcrbUVHUHlYejRwY3JzRWF5SWxBMVBFNFdlVlpY?=
 =?utf-8?B?eWVOS3lhbngvakZnNzZ5Ym56RVdtdnJZSk8zRTBZSldpSzdCL29MdkJIT3Yy?=
 =?utf-8?B?MDdsa0NGUDl1a2M2OWpLUi9OWnpyWCtBZ1B3eHVtRkJjOGEzVC8vTWk4OVU2?=
 =?utf-8?B?NUdTM3RKWE1kdWVUWGdXdjlPMUtWdi9LaXIwMjFIckhNWnR0aDA1bm5mdzZx?=
 =?utf-8?B?R3ZmakdJcDVLakdaZHFQUldUWjZER1VEUHluNWQrcmpsbEsySEVDdk1hSHVE?=
 =?utf-8?B?Szk5dVRSREJEUDY4UEFpYUpiVTc0bzc0Z2w4ajF1Qm44WlRYOXR1QW41UGxG?=
 =?utf-8?B?Nk5Vb3Q0VHk0dEZUQWhTNDN1RUc5SzFPcE5RakI0WTB5WnNJak5PZ2h5V3E5?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bUhBNG1iT3lkVC93UkFvWDlDalVoUkFXcUoyMEs2cnh6YWVnZTdFUVhkTkZa?=
 =?utf-8?B?SVdpUFA4b3VKUVJxNk5sdFhxeTBjb3h3b1drZHVMZWVPVUJEbncwak5FZGxm?=
 =?utf-8?B?TTVsT2pJdCtXdTN2N3JLbVkrejc0NSttdnNlU3JmRWZIZk9zSDJpS1dHWWxa?=
 =?utf-8?B?TUxUOGlOVnNpbXBrUWNsVGQzUGNQR2IyT1VmRDJ2SjJLS3NjWUYyejd3czY2?=
 =?utf-8?B?bjhrc2dDV0FDZTZ6RlYxei9mSWlCalZMdlRKcUZsR0x3YnZpdFBKYUd0OERR?=
 =?utf-8?B?R1o5VXNQUnRNWU9zZ1NkUjNMVlhGdm91eFNHZUpIWm5zU1hOL2kvL0FvTnFY?=
 =?utf-8?B?VVd2TGVkdERzMm9HeTk1MXpxL2xVUmQzWlg5cHlMTVI5WTl3ZzZuVjY3djdK?=
 =?utf-8?B?YVZCMVA3STd1K2c5TjNSNWtYSm1KWHNGSkpHRkRGZXc3VFc3L01Lck9aY3ZM?=
 =?utf-8?B?ZHJTQmNqT1VMYnJsZkF1S2Y4bEkxZ0tDS3Z4U2hNQVJYVDI2bUkxM0tLc3Vz?=
 =?utf-8?B?eG81bVZ0NU9nT0tuSUlJZVlTaTRDTDJEMnhJUU1wS0c1dkp0RFFrQmRqOFQ5?=
 =?utf-8?B?YnZMOWs1U05qaWRIRW85RlZOYjB3ZHFqM3hDQ00xZHZ1dzRPeVZaRmxyT09F?=
 =?utf-8?B?MzJ2RktxdDQ2Q3ZJRUxwUlo3a1YyMmVZWjlqeHlRaHdnVDloa1FOaDJ0Y0Ft?=
 =?utf-8?B?a3pSNnk4amlVbUNTMDNhSUtSaThxK3VJYVh0NmVTaTFHcGFEWWFuVWJXOEE1?=
 =?utf-8?B?bDNwYmRPd0xCR3V6a2JSdEU2dkdUTUJ4UG5BN1dneFhDQ2xWZm90QXVjc3Ry?=
 =?utf-8?B?eURBWWQ2enJZS1FRZG1ZMG5pdXBWTDI5czBtajlhd2lvcEc5Mm5YQzBySTZH?=
 =?utf-8?B?by9YVG9pVWFWL1UvaFVPeUcxVGtDcFZpRTRaaFJIYXIrSTVUSXpGaXFJTjJE?=
 =?utf-8?B?ZEV6RUU1SmpoNEY5MVpFS1NmR092QnZ5RTE1MEd6ajZtam4vUTJRY3lSZFla?=
 =?utf-8?B?UEwzUllua2RvODh4ZXRQRlJQd0lmemxlV0hKWEpoQlZ6MCtBd0lERitFUWIr?=
 =?utf-8?B?SUNDd3d1SndtZFdkNVlRQVg4WjN2MXRLTXNRWjR5enpsaVEyRXFsQlE5ZG9a?=
 =?utf-8?B?SFlad1gwOU1LUk9nWTZhSTluQ1FlcmxVQlJpOTI1K0FHYkppN2tFbXN0aWU4?=
 =?utf-8?B?Q052YzJxVzdmeDVuZkcrblQyZFlrVnhDUVBrRmVDS2h4aGtXdXNBNThIQW41?=
 =?utf-8?B?LytiQ280akdkT2VqZ0F1MTMxbDFvdGoyeXF1N2tqWDB6SjFMdUFZUXNTcUlL?=
 =?utf-8?B?aS9EeHRyMGZyYmRad0VDT1N0VGFUdnZUcDlJcHFxVW9uK3dsYVg5M1JxSXlI?=
 =?utf-8?B?WVl0ZW5CcmJYWXVUa3gyVHltaG1yQXh4Z0ZCTEt4WlAwVngwbDEvdklNeVBn?=
 =?utf-8?B?SXBDQ0JVQjhPRk91WVBDdGo0eDRyUHBNY29acWlwWk9FTWRqTWYxd0dNS1ZV?=
 =?utf-8?Q?i44vdD6JZTt8JdIPfzlx9qNA+Fh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5544627e-432d-49e6-5115-08db71604078
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 07:30:41.7430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZ6ikvQ2/z2NWdTVNRH+8yJcuGnY3t81B8MAFTcdHLXJ08kH4mDnX2x395z7Cv/AA/lkPFZGIluz1WIyUcgXgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_04,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306200066
X-Proofpoint-GUID: b-uNmkgTiHlPo7JeD8cE6dnyjKcm4YU_
X-Proofpoint-ORIG-GUID: b-uNmkgTiHlPo7JeD8cE6dnyjKcm4YU_
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2023 08:12, Jing Zhang wrote:
> Alibaba's T-Head ali_drw PMU supports DDR bandwidth metrics. Update
> its usage in the documentation.
> 
> Signed-off-by: Jing Zhang<renyu.zj@linux.alibaba.com>
> Acked-by: Ian Rogers<irogers@google.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>
