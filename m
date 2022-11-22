Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D47634174
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbiKVQ1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbiKVQ1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:27:04 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDD51DA53;
        Tue, 22 Nov 2022 08:27:03 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMGLt1V027284;
        Tue, 22 Nov 2022 16:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6LfSeBgviriyZjBJEh4a/Tcs0dxPBa0qre3vz7iqoMQ=;
 b=lA4wYMI7pr2rEDWjXGuoz9HS+TunPm6xzNBxMpTuAMtsqgCaiOoHkICYorKN1K5w0x7m
 4WNV64SGO7A7ILYuaEKQV1GFN2OSeos1fvsnnyxn8x9lUzXG5wEC1GZwal41E8qVKYwa
 0iuGGKHccoIxI9HY0JAXJncDg50PgmpiDpWDQR2tmgAHHNGa1BbO+1f9f/4xhYtHMjS8
 /niP8MAg/IZ4XLCOMs58iQZF6W0qngDpgyLNLsyIUfyO9aaOeY5zG4Vty19NRGTrcMHk
 kk47IaEwVlYhpbhbjB0MgB2yPpuW7K1r1tGsPVV67iUHtn7qdMY9Tlber2z+dFRx+TGL 7A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxrfb0rqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Nov 2022 16:26:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AMGDnq5039613;
        Tue, 22 Nov 2022 16:25:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnkbwg4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Nov 2022 16:25:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W30bCcRDKv/le4dy2h3aRSEnOoV9tClwFOEYwuldXxNsDFQAdfGEAxt9bs0ebBCRr3EfQoaMrHULb4y+RpYnv9I7qBth0Lz6Qn1B3FFQerL1BRHPDQRUZmOOCqjJXeqBS1Uu6iPJbJLcsoNVZNoOKWPu7Fe/qplc7dRBpIoaE5lM3XCYTiPbJ6CFVxzC0HT77EazpCd31f2i9vIJIQun01UczGXGFzw7KGkgD1QWWTwbZ4JbT/sJUQ1BExqP9o5TjGdi9xZOzimL7L9Z0qAjSupKtuHAv11oHnI0mFYpZHOdMoc67RnKciFW/C1F8mHXhk5OoOAboYWVSmmqtNkmVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LfSeBgviriyZjBJEh4a/Tcs0dxPBa0qre3vz7iqoMQ=;
 b=G+hY6Usoxizf69Wp/PCOKSrsDNxH6TtuMMaG+1ZbJOUQ6pnpGXxoCg7c4PSe68VpZyM0MduirePnXDNOFtPtiF5dJGNwPE1QSIG9H7aVW0H8BA4Sb9zz/RB7gwS1mrteeXUc+MxaRlcrzjvgrPkCgtgxlqOif9jKw2p4c/SvhQScrl1bNxbH2aJRv5XL5zBghURrDaf2cPWVGGEy60+jui57kiOvbelN8IhxsTw09QKFEGJx7dqv3hvZkxOtwbIkx1p9WQ8EjElZiSMUpR9k217MOdrkXAE4zK0Gt9GzXN2FlJ8q2OBu7CGPYfzwzgVa+HllPwAvlQ2qSXPsRZXJ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LfSeBgviriyZjBJEh4a/Tcs0dxPBa0qre3vz7iqoMQ=;
 b=DNKcbdkzSQ+VCWrdllJG8CVM2xZhC7i7Vw38Fu6o53yYNx9G9mQUpEGe5ZTxvCGy2k0+SIw7pVU+WZgn7EtrYZ5EZPJzSmSyR4SwEHfIQX1ZT6g8/vPRTBdnyVnHRwfzhmylPnEX/phHN304enlgklQKVcwGa06YgB31mPmQccU=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 PH0PR10MB5627.namprd10.prod.outlook.com (2603:10b6:510:fa::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Tue, 22 Nov 2022 16:25:48 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df%7]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 16:25:48 +0000
Message-ID: <eabf6fff-93da-6d01-0abe-2f29602b0afb@oracle.com>
Date:   Tue, 22 Nov 2022 10:25:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/2] scsi: increase scsi device's iodone_cnt in
 scsi_timeout()
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Steffen Maier <maier@linux.ibm.com>, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
References: <20221021235638.1968832-1-haowenchao@huawei.com>
 <20221021235638.1968832-2-haowenchao@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20221021235638.1968832-2-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0195.namprd03.prod.outlook.com
 (2603:10b6:610:e4::20) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|PH0PR10MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af8476a-8fdb-4aaa-569e-08dacca636ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uvkMGdz5Za8N+2XVacHnsZDjkMliX++1QB4VnsY+EIYGKORa3Mx8gv/R0BQtROmJE9hq81K0Ie1t430G1eLHLi46GFCcHfJaAEeQOiVAhy+yrPWNlg5WzBZO7mxb4W5g2EfnLoYlWLLLnGY5pWXmPKUBi1+m58c5jD0xTw+RZ2Z/1rPtDyxWCWL8HPt1je1FGU3cfGf7KQINFTMVjJBJkPjFXBENTtrnk/L83vA4En2+pkpDBcivaaQX5mn4RJdxVQP+IK16ci0eKD4lOzLgdAgRCIj0GN5+IxMLZWxkw9jEN1vIqlLxkKoTzzRe9JMamV73VkbIuAm4pIj+r0rH2kyU1xY96kyZOoQ/RMtwNWtp6LIZXYcX01FiKYKSPhQ3M6k1zbrHwF/pVzG2YyATSK8l8Mo212YIT/Lkyq7E81M4vOSJO56nzYNlbPj5CpCcmfSm8I3JiluoJvGuWDonnYzBeRz296n9yWWM6BhcHHMeS0HRYgDVLX89gFLOgNOQI+Bnq/PZvnVIuidhal9P2KZlKcB6IIp59w12S/XsTnlfydLFBdkJnoVK1HTWcVInxGRdzqhNOLNlgjnvVI/mUF1O+9iXght+pYo4S4V/18LT0CdGXZZBqXk7A/RK+xrJUXk+wz5Ggm5PY40GEUE0obiF01Lrr9stb0WHzrD2kO/ek9sLbW6mtjG9l583D0yzl940pF/+FzX4uysBhfyry6OMNTM5bkMjfIGj4bOTIt0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199015)(2906002)(31686004)(41300700001)(36756003)(478600001)(8936002)(5660300002)(8676002)(86362001)(31696002)(66946007)(66556008)(66476007)(4326008)(110136005)(316002)(83380400001)(2616005)(38100700002)(6486002)(186003)(26005)(6512007)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3hlUnU1UjBEK3JMZFM3OVk0REpSSkF2UzhnSk1VZkdmYmlNZzJjam5WM25Q?=
 =?utf-8?B?VEtaenlOd0RaRGxneDhLODlzVThvOWdsM0lwRExSMTlvT05tSjY5Snl6RjFm?=
 =?utf-8?B?WVRTd2QrcTdHNVVvbCs4ZDN4WkxyWFFTek5PR3hhdlZvTEZnKzQ5QzlxZnZE?=
 =?utf-8?B?aFRBOUM4ZDZCWVFKT3dIWjRyNjAyTldOaWJ3Tm9ZdW5zaFdsMkl6WTBPbEg4?=
 =?utf-8?B?MHhlV21sY1VXVmpYL3J0Rm96UjdEb2VsWGgzM1d4dU85dXNpbGVKQUozcU9C?=
 =?utf-8?B?Rmd1V1JiUUR1WjRZSk1mNlNsWFlNQS9xWHdzakt5ME1YSS95aDFtZ2NJZnF5?=
 =?utf-8?B?SDYyREY2dURacDZwcW9JOTZRL05yUVcxTWhxMnUvQlBGTWJhQjFrcnJpZ2pZ?=
 =?utf-8?B?MHpmMElRZDIxYWZmcW1DNVlZWTBENFU1bHI5bWVmNXdXWU94TFJuVWZLcGxG?=
 =?utf-8?B?Rjc3U1BXT0hMSHRFUVU1ZTB0U1JMbXhUZm1WU1JyQkZ6aVhRV0JseWdpa3FG?=
 =?utf-8?B?T0dZeFp3QVd0SGdDZDVPYmEwTzlQNUxxT2hXOHB6bzVScmNlOTF0SEhVREtF?=
 =?utf-8?B?UHBEVjVrQVFlaVcxZnd1QmUzT1JlL3EvZGw0TC96NVc1akdibDdtRXA2ZWtj?=
 =?utf-8?B?NWdtRVVrTUVvWEw5MEhsMmVwT0tNditxSWF1ZiswNDZwRXhIRVBxeXNMQlVK?=
 =?utf-8?B?V0dBVFlnMlhlN0xHWGNYRFBaa21LR1o1M25HUk5LQ2tTUmowbGQ3aFZSTTF1?=
 =?utf-8?B?UVNPS0dKRTIyZzBCZ1RrUjJSVkJEWWYvSURIcmNHZFd5dzg5dlZibkZqWk1y?=
 =?utf-8?B?Ynk1OUdNa3hqQUJ1Lzl1Skx1UWo0TDVxcU5lK20wWi9rSWN1RmtxNy9rUWhO?=
 =?utf-8?B?d3o2TFRXUU5OZzgyZEtWVkFnYUd0TElrRWlMN1c5WWxNb1NqRHhsUkMvRzM3?=
 =?utf-8?B?S1hOeDVXS1N0TlhIaWRMYTF4Y1B1RHBmV3hIdmJJM29KTkQzWW82MGNyZmli?=
 =?utf-8?B?NmtZSy9sd1BDNUVjZTRMbURyWFdVZ0laamdxZVFjUEMydzFSZ0llREcwQkpJ?=
 =?utf-8?B?NndsL1NmViswb0g2UHRkUUU2L0V6aU9FSWNmcmcxTTZhdWZyakYzN1pGdDF2?=
 =?utf-8?B?akFhV2RjRXVvQWRNZE1XbmduREMrMEpBUHV3QTRaMFVsblBINkdwLys4Y1U3?=
 =?utf-8?B?djk2QmtOSmxhSWQxVEJLQlZwUW84VDFqRlM2S2NVN1VpQmFLTFRLZjAxSVlL?=
 =?utf-8?B?c25mNCtvMjl4c051NlE0QW9pZ1YwbnZRRUl1YnZwKzdkMGpyQWRub1BOVFpM?=
 =?utf-8?B?bTQ5c1Fmbk1XSy9UZC8wNnpqWlFWTk02ZWVFQjlZVTRrM2pGZWVQQUttQVcr?=
 =?utf-8?B?dTFidi9MSkhPNWo2L0oxNzlQVWtIUlJpb2h4cDFhQTBKNkpGNkdRbWMwQ1Z4?=
 =?utf-8?B?TTc3dDc2T254alRNUDhoelhRc0MxVndjUkQyM2RoWTU3Q09BMlRENVZKYVc4?=
 =?utf-8?B?S3ovZlpEMGo4L3BZOUdWQ0pnRm1EankyMU1YQ1p0Yk9YTktOajlYMHQwMHhv?=
 =?utf-8?B?eE0xNlZLRGVzdGxWWEdpU0RmejlEUXp4Z2YzRzlYZEsyaW5Ic2NHOVhlSzlU?=
 =?utf-8?B?NTJBamZ2YVhuTklGamdDUUVXbkRWOEtPQXl5U3RFTFhLcGdFZDBiaERZcktu?=
 =?utf-8?B?SWF2SFlaNmdYbVhoQXJJaHRCbkl0bjEyOVgvYTVKUDBrczdEYkxSTFMvb24x?=
 =?utf-8?B?RTBsRDlKNklDMXNvc2YvWnVqTzhxVS9PUXRxUE96ZytFUzcwUjdlbGtwY1pV?=
 =?utf-8?B?c3RYNGJ6LzJhV1NFTjRiWUpBbyt1RmN1Tm5lZTJUb3NLQllNMFpWaklJSk1T?=
 =?utf-8?B?VlVmMncwMDZBQWRQak5GYlc2MUk3ejQ0bFF5aDZRd0pKbnBrK0FBcFNHc1M0?=
 =?utf-8?B?V0E5TnNUWkZDbUdDU1R0MzZMSmsrd2dMZVdhMG9FNzUyczZQamNXQU1yL1Qy?=
 =?utf-8?B?N2hjam9iVWd5blFOOFBWL296NXNhMXJVZW05cEpheEhNOVQ2TUpHcVVYQWEw?=
 =?utf-8?B?UnRJYkRMOWZwZTJkMlVIaVl2WGpHZW52YmZ1b2tidWFEZVRDdWwwd0RtQ3R0?=
 =?utf-8?B?VDNaNk4xYnRCeEIwVnRYZmpBbkRRSWdaZFhRTXJ0YzNPeE5zWUVPQVhINVJi?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?S0dXNk1STVhRV2h4VEZNak5pd3RlN3ZNUlE2YTFPallRUy9GRW56U25TZ2Z3?=
 =?utf-8?B?ZDR2Qm1uc05kdnFsM0xiSWoxcDF0VjVnaXUxMHVxVkc1ME9DVWIveHk3eE9V?=
 =?utf-8?B?N3JqbFFnTWtSblVYeENGaGhYRW5IYllpNUZIbVpmT3VuYXFaQlhnOWdmVmVX?=
 =?utf-8?B?RzRLOERiZGkrQXlHb2lwby82cXZHSTR4aTAreDZGVlF6Y1hFOGhpVS9EdjZw?=
 =?utf-8?B?UlFudjRidisyVldzay82ZDVyY2xRKzVOUVBkbVhZakM1L2U3QnJLTng5VHNW?=
 =?utf-8?B?NVZTM1E2WU9XNTBSSmgvNlNGeHZZSlg2K0ZRNUFmT3UwRE5oMWlRcmlQV2NY?=
 =?utf-8?B?QXhJSzFsRXdZMUI0UHhOWndHa2o5WUU1QTg3dVFTSUxWemVhbzVYL3hHMFh0?=
 =?utf-8?B?MktqMlo4cW5XNTNqd0xZZ3ppdmxsMUFGdG9ManMxdDg5Y1YxaURucTl5aGNz?=
 =?utf-8?B?STNGT1dIK1hWWExSWjhWVE9oODZZdk5uMTJGVmwxU0FYU0l0cWhnMkJ6RWg5?=
 =?utf-8?B?aElZSmN6RjRjM2Z0MTdTbWNSdkZkaTdIWWlHZDVzTENhN2hiV29RUi9EdE9w?=
 =?utf-8?B?RFhoL3FhRDA0SGNYaERndStBN2E2YWg0bDMwWXd0SXhVMXJzdkRLNEJvckpJ?=
 =?utf-8?B?VVhvWFdrTXY3ZHRvV2F2MW5sL2grZ25oeWUrUVc2YUQvN2JCVWwvRlBRMytC?=
 =?utf-8?B?S0Z4dUpWcTh6Y0VRVmFDSXRsRThxRW9aZ2JxY0lzLzh2Rm1rU2ZPRHc3QUtm?=
 =?utf-8?B?ZzdlczhRLzR0QStrRTRGYkhqL1NRNzZpZkJ2dlhlY290anlkMWFUb0hKV2ZM?=
 =?utf-8?B?bHlDek5wL1NnaTM0M0I1a29PMndDOVBXME1LYnZ6QVFHOExyeDRtdkJ2Ulls?=
 =?utf-8?B?S0w5c3V3V0kxQ2Rreld4aTJJZi83aCs0OWYyaXJtcjZ1M245YlN0VWd4Z1Ft?=
 =?utf-8?B?Sy9KS2hvWGhnNzVOWENXUXJESkZKVUkwQ0dvOWtCZGJ6eXZsaE4xb0xTemtt?=
 =?utf-8?B?a3FhVUN2R3J1OHJReDFlWHVwSDgrMzJLTzlYdSsycjUwZnYvMFZDQlgraDNh?=
 =?utf-8?B?dlJaRWdvSi94NktOaU43OTl2OW11YTBCTVdFalE5d3pZdmhuNUlxOTlVeWhS?=
 =?utf-8?B?NkpSZzhpUjkwRTZpZTN3Nk4zMGlOVnpCM0Jac0FFU0RLOE9CNTVlN0ZtNGhn?=
 =?utf-8?B?dExwRldMUU5YUm82WFBTenBaNHZMMWtrSDZYZEZUQkExNlFjZkJ6V2o0TzFW?=
 =?utf-8?B?V0hpaVgzd25kV0RYSkkvVk1FTFRkSyt4aUYwL0F6T0JVb21BZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af8476a-8fdb-4aaa-569e-08dacca636ab
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 16:25:48.2057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQMMxT2myPikN87wqxBrLq9g+Pr/5Wz9wj+voogPjFrrfWdusmcveGUokZNSiUoWDMteE8TZGG1Pe69CXVM4Oi2dmvc9jtJcYUI2bFyTX6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5627
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_10,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211220124
X-Proofpoint-GUID: NCf86gj02e3mGHbIIKeQGGEWDapmyZIx
X-Proofpoint-ORIG-GUID: NCf86gj02e3mGHbIIKeQGGEWDapmyZIx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 6:56 PM, Wenchao Hao wrote:
> If an scsi command time out and going to be aborted, we should
> increase the iodone_cnt of the related scsi device, or the
> iodone_cnt would be less than iorequest_cnt
> 
> Increase iodone_cnt in scsi_timeout() would not cause double
> accounting issue, briefly analysed as following:
> 
>  - we add the iodone_cnt when BLK_EH_DONE would be returned in
>    scsi_timeout(), so the related scsi command's timeout event
>    would not happened
> 
>  - if the abort succeed and do not retry, the command would be done
>    with scsi_finish_command() which would not increase iodone_cnt;
> 
>  - if the abort succeed and retry the command, it would be requeue,
>    a scsi_dispatch_cmd() would be called and iorequest_cnt would be
>    increased again
> 
>  - if the abort failed, the error handler successfully recover the
>    device, do not retry this command, the command would be done
>    with scsi_finish_command() which would not increase iodone_cnt;
> 
>  - if the abort failed, the error handler successfully recover the
>    device, and retry this command, the iorequest_cnt would be
>    increased again
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> ---
>  drivers/scsi/scsi_error.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> index 6995c8979230..052b00f57b56 100644
> --- a/drivers/scsi/scsi_error.c
> +++ b/drivers/scsi/scsi_error.c
> @@ -356,6 +356,7 @@ enum blk_eh_timer_return scsi_timeout(struct request *req)
>  		 */
>  		if (test_and_set_bit(SCMD_STATE_COMPLETE, &scmd->state))
>  			return BLK_EH_RESET_TIMER;

You will need to rebase this patch because the above line is different now
so it doesn't apply.

It looks ok to me though.

Reviewed-by: Mike Christie <michael.christie@oracle.com>

> +		atomic_inc(&scmd->device->iodone_cnt);
>  		if (scsi_abort_command(scmd) != SUCCESS) {
>  			set_host_byte(scmd, DID_TIME_OUT);
>  			scsi_eh_scmd_add(scmd);

