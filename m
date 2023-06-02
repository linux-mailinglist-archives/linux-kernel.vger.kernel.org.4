Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8917207DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbjFBQoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbjFBQof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:44:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B3E194
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:44:34 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352CahGt030637;
        Fri, 2 Jun 2023 16:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=TQfgBwu1xoEK4/E05pXxX9e5fg1iH9uWSgSQhnopm88=;
 b=KViOOVmbwaL9TvgiO+9bg61KezKQnHQulIER4XPrFiHpMwSZUIpVYsiGbbq3hhm2YoIt
 91jCZoD3EkRQsVwriQ2zkreYULZPMvEAoLT27ONGeR/7Bxvmw6dHk1Naqwd/xmbrXCvd
 jqHdyYDGhajNWGV1tqn2uZulSqHIsPSUaXLEi7kYFIzKk2HuV6UrZtiBzrfeD2J5wYKd
 54BBiRA0AfybsyKjNmrYpIJV4R3BH+smlHMZ1XPpLD4PDIAl+69xbKwQwBbgnRrPkwuf
 lbLZufqX2GpMdN83Lkojgsnchg0Z8QJ94CUgr36AHd4a9LVGcYhXeWnnGGpUCfl0Dlua CA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmeub4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 16:44:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 352Ft83k035097;
        Fri, 2 Jun 2023 16:44:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a8tfhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 16:44:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcFDL1XLFfzJ9y2qzP78TbwY+B5FPz8ZJzOn5QEG7Y94+WPpNWPnmuZXHRW5HJKUJOTNQJjOkEta7VyJSzmHloknq2JgLl0Nu0KvOBV6UhVABI8SJOni+v+y1ncQdsb3WskuiKmvBRZgbAsuzuBoqALp1Csw6Pf1pvcZugl5g7IEvSWnG3bvrx1dvsD0czEFJGfpqAY5FxtT9xNa0Ck+wQF4QoDmYlru27YIOiWr2rqbOVGQXn5ARBGtd/bNi9B4LT0niURJQij422/jP94OARFhkuOnbmCGbPlthBVVqKnxD3hXS4V3qHigNFcfDySjQGBVO5/BpiPuZaxpxB2p2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQfgBwu1xoEK4/E05pXxX9e5fg1iH9uWSgSQhnopm88=;
 b=KhjqgEEf8PJWT29WxBupKJJX2pg8V8g4R0mEll4u5LrABaJQXYEeDjy9rhQwPGUaynDiDSfke8rSmn6vOYqFZYSNHy28hT8jI19CLdmW+hnfgStr/6avDCi4ByOQvXdKv9b7aoEmI5r/jTqd0d0AiBmbqk8YI6dJ/zZQsSnxFH+6xiL5d7BlSXVb7uWfJ0CWwm9cB/cXcRETxG9/o1CH497cv+dF3h6YQks9cU1ORcNxdGQkMAbCb+gdYrQBLh+XMgDiIwYX6uj35LVhUyi++KyhrWU/bDL5GsE7yAVSHeAQeO4ECzJtqcIniB3r3zUEQZovmmuz6LKYi5eUPP3c5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQfgBwu1xoEK4/E05pXxX9e5fg1iH9uWSgSQhnopm88=;
 b=SVIVTHMj/1iwDhIAWQtFYE+9MIF+Vj4cM01oX0wirv7XUSOe+BY9UR475+I3dRegdZMIrJxGIYt+mHgCoCaMiplqG3qKN1kwaNanuln3o8mkYl26J1fG+4838DLq07+o/ysdF1SwphYdyCx3R6OW3oQoj+TQEYkUwPb22kxDM40=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH0PR10MB5289.namprd10.prod.outlook.com (2603:10b6:610:d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 16:44:04 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342%7]) with mapi id 15.20.6433.024; Fri, 2 Jun 2023
 16:44:04 +0000
Message-ID: <fb4a3d16-cb5d-0be5-9fd6-04b5709ff27a@oracle.com>
Date:   Fri, 2 Jun 2023 09:44:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] mm/hugetlb: Use a folio in copy_hugetlb_page_range()
To:     Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, mike.kravetz@oracle.com
Cc:     muchun.song@linux.dev, vishal.moola@gmail.com,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20230602015408.376149-1-zhangpeng362@huawei.com>
 <20230602015408.376149-2-zhangpeng362@huawei.com>
Content-Language: en-US
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20230602015408.376149-2-zhangpeng362@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::46) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH0PR10MB5289:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da61f07-d421-4b3a-ded9-08db63889339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s0fbquuevhMPXxdDigGL582dSw3VBIM8/LIxOzLR4hZ2qTTv9HpNvmtsRgCbF8Qk585o88DefvIJJpBlmMERlKBdvXbr+hMSA4itTlT7jc1bTWXCefxEH1EIzzBygkhRHBVf2r4B4Mt1VNx8dSZqi0a3D4TeygKAUi/2x3NEzMugxYml/PhMNutgsrt9w4fPpmJmHwd6fafuFRaHzbIxkHCojhtmsDAWZvvzYSRilX1ZyJYs0qUMul1rBlYt047u22yvRit+uvXjQ+aPlSsp4JFo4LlLZCVEf/Y5BjwxR9edB6g1KuA8djrtjlv7IfaEPOQBNdLREh4nxfBlZ6aciE32OnH5azxw8eFlXWrimP0aszTMN5GlMUHR70QesN3ci1tsu/GqeQb2HFAV5UgVVRQ1GmiBpp99xH9N17Vcy3T1pwfsMkxgqcDWcrSKfdVNOgxIY7CFf2aTDXtTFDozAeTqGlJCzrprVMbGlwrbz5jtCoKV3ymTS1Y6koe+XuPQcafkImRTdMNBlSoAygWPITBu+Xk3FQAyml29bkxrl8gs7UVKGGyPxq72KsBelv0qBtQtY7GOZ41z/39zBcvFWLsFmDIPXWfZrMbMD7HGyNoc6W6FWouHPtbdHNXs6IArGT59TpDMl3IqpBuV+llNfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199021)(38100700002)(31686004)(86362001)(478600001)(66476007)(66946007)(66556008)(6636002)(31696002)(36756003)(6486002)(6666004)(4326008)(186003)(6506007)(6512007)(53546011)(2906002)(8936002)(8676002)(316002)(2616005)(5660300002)(44832011)(41300700001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em9NcWhRSms1VGk1RWorU3c1d1BpTHowN2cxWExrcy95TnFBYkxmV0cyRU44?=
 =?utf-8?B?TXNzcnZGSGxoWmkxcmswQk9YVzM2WVI1ZlhYUTNkTzVRTkkyTVhHdVozT1cy?=
 =?utf-8?B?d0Y1SldSNmFQNjBaZEdldXNKbVFmakRCR1gwRENsOWRDb1MrNkRwTXJGM0Yx?=
 =?utf-8?B?UkJIdHRmeEorYVdKNGloN2lscE1hMC9kckRob1FtejdkTmFNQ3d6WVgyUWFy?=
 =?utf-8?B?VjhBVmdnUC9oUHVjOTk3TDBzYW94QzdhMlpyUEIzVXo0YkVxdlRZb3oxOUs3?=
 =?utf-8?B?TDVIQWtpYUYvVG5JSTR2K0dBTVJvRjZXeVIwcjdxUDRZcXRHN1ZBU0dESmRw?=
 =?utf-8?B?TFBXL2JvQUNFRXdTWFl3L3hBK1Z4WUk5aDlBbjg0dm12TWh6QWNocGlmOUV5?=
 =?utf-8?B?aDRiTnVPMFJJUVpVaGhOaWpOcE1acmJHSk5PdlB6QW1YWUY5TGNkb2RUWXVE?=
 =?utf-8?B?UjJxZkJKR3NObmhPU2htT293eTVtdnY0MlA5c0FhMG5kVGxpeithbUhjcnQr?=
 =?utf-8?B?OHptREFkUXQ1R0MxdGh5MTlCdzhjcyt3elBldWY4Rkh0YWk3L0Q5MS9PWmJ6?=
 =?utf-8?B?eWpOMWNPZEZjVDRtUHh5REwvc0Q4YlhPWWVGNWZMVlNpU3dkcUh3eHFKMW9m?=
 =?utf-8?B?Z2M5b0s2R29WLzdvb3E4VVh4S1VoR1dZUlMyRUd6U2QreFZnaVVXMjhIS1RQ?=
 =?utf-8?B?WnFkbC9ML3p4UnJCQSs1bDF3SzhOSDcwWWhPL3NHdk5RZTREbXVOVDFoeTND?=
 =?utf-8?B?Y084bk1BbFdaYUFUdWgwSTFaSGlzY3VTZDRDeTdkSHVCUVIvMGlDK0p4RTFM?=
 =?utf-8?B?SGRnVnk0K3AyV3Q1V25tUGRzeFhjOVFDc015Z1ZHTkk4RzMzUkk2VDNuZ3d1?=
 =?utf-8?B?NFl2a0loU0hQZlNIMUE5V2ZPSFRqR2ZObStjRWR0Q2JlQy93ZkhIVlVMT0dP?=
 =?utf-8?B?STBnUmNyVTZzNCt5b3Z4Y1RibHFMVDgxOUxGekhvU1VYWlFzeHBKZFBmVFkv?=
 =?utf-8?B?Wk9VU1BxR2J1bzJpdzZVNmV6UzMxMVQyUkxEb0lBT09MOXdJYXluNFA5dmpE?=
 =?utf-8?B?UDZFa21aSzN0MjI5ME5ZdndWNTEwT2Jqd3dQd1p5Um5QWk5mc2lrVStycVpW?=
 =?utf-8?B?TzcxWXZWWGNVWldrWHlmbHlKUTMvMWI2YzFIQnlzcDA0c05aWEhNaXVxTXNK?=
 =?utf-8?B?NG1USzZwVTc0c04wazJxZTRTeUVsYXFyM0JvcDZHMTlpQlhrK1Y2VnN3QVVr?=
 =?utf-8?B?bDZjZFdZUU12UTIrZWhRc3lWQnVUY0hYaW9GVU41Y0xPT1lYRDdqUFJNR0kr?=
 =?utf-8?B?ZC9LcVFvbnZsNjRGS1gwbkp4UTdPM3hvMDRpYlRXQlZUZlkxU0o4alVraW44?=
 =?utf-8?B?OXlUQVN3RlpCM0NyeU9BODJpOXBMMCs2b0VBVkUreEYwR2NoQ2kwOFNlVTNK?=
 =?utf-8?B?YVZtUDVrcFZ5Y0kzWm40ZjBUZThmN2VNaDF1ZEFjd0hmelkwbHUwQWs4REQ2?=
 =?utf-8?B?dm8rS2Y1SEcyZldWVkxLVU10TUVDdWpmSVJ2TWZHeW9BdzdtRCtHa2NJYTBw?=
 =?utf-8?B?aXkwM2xxemdkTEFsSHV4cGUxS1UwSUVKR21PR29EanNMMFB6cFBSby9HMm5t?=
 =?utf-8?B?ck5WWm1PdUpHU2ptUVpTa3BnQnNkOFZnU2YramFTYUE0K3NJOXlqdmlkaGNk?=
 =?utf-8?B?VzlNM2p4WHM1VWVqQ2YrRGcrVmRFWGVUUDZVN0R2bHl6NU1BQ1kreGd0Z3Ny?=
 =?utf-8?B?YkhzOG96d1BEMW90M0RITVhIS0Z0eEVqN0lyYnB2SXFOZ2ZqMGd3ek1mb055?=
 =?utf-8?B?cExNNU1FQzhuVUZGUzNsRVAxMGhUYjN1bHZreUMxOHhJTGlxdWptWWlRYnh0?=
 =?utf-8?B?ejJndmNsOGszSnd3bW5DQWcyeEtvVGtKZ0syM09mNU50ZFF5ZE96UjRzY00v?=
 =?utf-8?B?OFAvc3BhMHJVZ3NjUEVKVHNCK0VpNC94cVQvd0ltSVF4aG1YNG1yUS9mQzJF?=
 =?utf-8?B?WGZGRHdBMGN2eGVISFc1YTRvVmFLckVITWN3MGNoVGZ2M2RTUlM5ckpuL3l6?=
 =?utf-8?B?TE5KdHhxeHI2YkJETHRyYXNlNm9SZzVVdzF0UmpBU1NOTXNXUVpTTjBERUJM?=
 =?utf-8?B?UFdBMlBYS1JENWxJdDdVKzNDRUNGUmNuOWsxWVlUY01TS2lHYktXZFFrS2Zu?=
 =?utf-8?Q?b3e+Wwmdpf+JZ4Bb7cIbOAY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MDVFKzcyYjBrMkppZDd1VGNkaVpsaU1XS0JFbitNdjZ3a1R1NEROUkx5akJX?=
 =?utf-8?B?TDdRV3dtY1lObmRmZHZrSHZPb1RUd2NiNUFCU0ducVlqT29yWWtmNFlMemwv?=
 =?utf-8?B?QUVCUHgwaWhoRGtaMjRzRDRkVW0reExja1dtb3dPUTVCalJKZHAyYkY0bWh1?=
 =?utf-8?B?SWN2YTRWeU05TDJWQmxuYUVRNVp2YkFCUk1zTXpJNG1DZFBzSkYzZXFBSUQv?=
 =?utf-8?B?Q0tQZUozeVdNQ2FxcVMwWnUvZUFZMUlFVmVRQS95Y0EzYTJhU3lia1ZqTUV5?=
 =?utf-8?B?aTYrblo4MkRPWE5XczJ3K0VVL1hxdGs5OS83NUdrdS9VNjZhaDduUDltM0RZ?=
 =?utf-8?B?OHZ5NHJjWUFWeWU1eitIUXZDeTFWSVFiS2M1Y2VDY21nY05mQUQ2SzhwWk1s?=
 =?utf-8?B?RWI4bDcwaXpIeGY0RG05OXZNVktCV29zTGlVdmtQbmE2UWllbTMraWpRVm1E?=
 =?utf-8?B?U1FNRHBRWW81VkJXeUlJQk9ibHlHN2lYYllXbGVSS0pNSGI2NlZsVGlBVE0x?=
 =?utf-8?B?eFVVMGZtRDMrK2liaW9vYzBneFM3cjA2TEtvbG1iMS9sZExva21IYldBQkN6?=
 =?utf-8?B?VStWU3F2bEhrRDJKQ1NlMitHcXNjS1ZrUUtlaG5RelB0bDBobjZwSWtQREVS?=
 =?utf-8?B?Smx6YlN3ZWNNNXRYK1laWFBWa1ZmdDhEKzVGYzNhbllQQTR2QVN2RkhsN0pH?=
 =?utf-8?B?aCtjSzhMZk9xY1laQUt2K2ZiOFM4a1BGbjAvaWd1dzJyUlhFWE5Td0RxU3Jy?=
 =?utf-8?B?RmNRbHdyazJIRkdQS2dZTzIxZkd0UXpaQTZaS3lHS3QyQnJHZEVVcFEvZThz?=
 =?utf-8?B?NHRKR2pxSW5EejJMQzhJd0V2OG9jVk84Y0R5bGt3WDZ4QVlKalhHSzJUN0JZ?=
 =?utf-8?B?REtkWm94ZnAwVlVpdDdBSStRRlNnSGtMQlRDY3hnaXFzcElCZVNUbnNIcEdU?=
 =?utf-8?B?QzhQNlh5YUdsM25HbzhrM05RUjNCT0FpTGtOQTBpTTVkLzR4d2FwMVdRVWJB?=
 =?utf-8?B?ZGJpeC9zWUVtRU5aK0xEWXJvOGJLNFpzTWsyNnJWRzc3cmUxMFFQNjZiWlUr?=
 =?utf-8?B?OGdBUE5TV3g0T1VOOVZKV3k3VnBoUFk3amVCQ01ReFVvUEZ2UFhXd29TZ0VW?=
 =?utf-8?B?bWt5dkROdzYrVHF1Q2FmY2c3NGYwbkQyTlYxeHpPcEtxSSs1ak5BdjdhMTlJ?=
 =?utf-8?B?enVBd0YvQzhVQndLRXVJRmFFUm1GSnNIVHNJY21YOXp4NEVDTG85b2tyN0dq?=
 =?utf-8?B?QlI5TkpSeWl5czBqcThhaUtPaWJvMlJ3aForY09iUHNEZXlOdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da61f07-d421-4b3a-ded9-08db63889339
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 16:44:04.2236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKKGiohBaiZfFPp6l3TaFXug4R/8JeEwylV7J80HpmRXF/FUuhZbqjDESuwZp2aEombKzZJtDbSvBhu27oXHcSrdLAizTsQ1w33rcQeeD48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5289
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_12,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306020127
X-Proofpoint-ORIG-GUID: zBgm_pYb1JG6244NYcYLFvYpr4nuUUB6
X-Proofpoint-GUID: zBgm_pYb1JG6244NYcYLFvYpr4nuUUB6
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/23 6:54 PM, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> We can replace five implict calls to compound_head() with one by using
> pte_folio. However, we still need to keep ptepage because we need to know
> which page in the folio we are copying.
> 
> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
>   mm/hugetlb.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ea24718db4af..0b774dd3d57b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5017,6 +5017,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>   {
>   	pte_t *src_pte, *dst_pte, entry;
>   	struct page *ptepage;
> +	struct folio *pte_folio;
>   	unsigned long addr;
>   	bool cow = is_cow_mapping(src_vma->vm_flags);
>   	struct hstate *h = hstate_vma(src_vma);
> @@ -5116,7 +5117,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>   		} else {
>   			entry = huge_ptep_get(src_pte);
>   			ptepage = pte_page(entry);
> -			get_page(ptepage);
> +			pte_folio = page_folio(ptepage);
> +			folio_get(pte_folio);
>   
>   			/*
>   			 * Failing to duplicate the anon rmap is a rare case
> @@ -5128,7 +5130,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>   			 * need to be without the pgtable locks since we could
>   			 * sleep during the process.
>   			 */
> -			if (!PageAnon(ptepage)) {
> +			if (!folio_test_anon(pte_folio)) {
>   				page_dup_file_rmap(ptepage, true);
>   			} else if (page_try_dup_anon_rmap(ptepage, true,
>   							  src_vma)) {
> @@ -5140,14 +5142,14 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>   				/* Do not use reserve as it's private owned */
>   				new_folio = alloc_hugetlb_folio(dst_vma, addr, 1);
>   				if (IS_ERR(new_folio)) {
> -					put_page(ptepage);
> +					folio_put(pte_folio);
>   					ret = PTR_ERR(new_folio);
>   					break;
>   				}
>   				ret = copy_user_large_folio(new_folio,
> -						      page_folio(ptepage),
> -						      addr, dst_vma);
> -				put_page(ptepage);
> +							    pte_folio,
> +							    addr, dst_vma);
> +				folio_put(pte_folio);
>   				if (ret) {
>   					folio_put(new_folio);
>   					break;

Reviewed-by Sidhartha Kumar <sidhartha.kumar@oracle.com>
