Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BF2716F95
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjE3VUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjE3VUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:20:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD82C0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:20:35 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UKPONL022420;
        Tue, 30 May 2023 21:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ji1k6DMW+pL2yLK+UsODzOedbTQKYhmMdzIHHWzzzUE=;
 b=0ekcHJwLuGSoaTRRc5NGBuLVMGXFjA9XJlin5BDMUS4J+HAdsx4uvDnMeupgwN7vdO9G
 Quzp8mcx4YcmUQ4vM0cPJQ/zD+DGZDoB9Pc+a3IaiqnTGEiHBPGGoxpy90WLp8poeX07
 DhIbTf9oyKQQ/p4wWgABVJ1CUUNWFDxsEfH2qP45e1B2buEcWQf4ZhNBT4kH23ptq7CY
 7h6Bbaj1MdU/flEIJ9ef8I86DSnP+QhMumF5oKh5Qbj3o9gM8HWc+fMLZMs8mArIF4cO
 M57fJ13HiyRxw2qSn6PUD0W37W0QntsIVvzr9XVzQDr/IyWjn4yL26BJ1Lv7HQE2GBd7 hw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmjky2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 21:20:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34UJnXZf019723;
        Tue, 30 May 2023 21:20:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a4r46k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 21:20:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIiG/63s52yQME9Dk+Zd/Qv7f0VInOayAocPGV3uuOns71efWlfCLN5k3eaxEFrvczY9emf3LEQTd1oZPUMMUteSf1bA6bck/kHLuei4wU6eVxQpsf6CcrACDj8cA/NU2Y5otg0qOOWjKWjq9zQjbzrP41orW9/oxFoXdyLgHicjKeibUYSGJkhqsE0uW5rFKpkqnP/Ubey/LeLYzez9yxFw0h1m2pob0osUKbVxizs68/DKikv7hSeUtj+0E8XRTC1fwfbCwDNSWjytpSy90FX53mFNA03YE+2xFwX/i1f49P3VZR0hKWX/rRLc1QLyg89i6lb1LH5Cd5CB1PkHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ji1k6DMW+pL2yLK+UsODzOedbTQKYhmMdzIHHWzzzUE=;
 b=Abt/XPe2mCWkbB5SYcZypc5Ezvjr/A+6O3gKSk1ugtjw/Ui6ExwcNH2+POKfoYkkR2x2Vd3pmHovsebtVSMRu2vMN2EsWDsG3gQr0PQT8k2Rh4vMfbXXF+Kthm5Jng8krzzDer9feA1YkhnDnPxmNkyiYE1O91qQmWKlQpg09ZkkyfV7VJDXZzSYhzciS2/ejd2Jhhz00NjgzXUxmv0wE3qUn1R+tLPQvI5e9PA5NGyH4IbMABs1E3APyhRgy/6n3+x6puTUs8WBbR051YhputnxoIy221LteQ1QVcaWvZWjK1pUk9G9WBC5I75Rfv+5jIk0Ql6PDR4NOop8gvX+4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ji1k6DMW+pL2yLK+UsODzOedbTQKYhmMdzIHHWzzzUE=;
 b=YrPvx4hJwCE+vt26l0DJhXjfWRwadPlFrHHhSSK2lAMYGT9jNaInEzUZf1TkgyN4SfgDgVvSxon+jNTBM+bgW5W/Ommepzh3SZmsLVurcMDC+dI2QwhOOYJtqwd330isVgqs49Udsg6Xkmes9EO9qmwjBBxtuRRRCM1ENAB4BIA=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by SA1PR10MB6320.namprd10.prod.outlook.com (2603:10b6:806:253::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Tue, 30 May
 2023 21:20:20 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::11b8:4b2e:26c5:1bb3]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::11b8:4b2e:26c5:1bb3%2]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 21:20:20 +0000
Message-ID: <71d90716-b6ef-1e08-98da-74f8e6295460@oracle.com>
Date:   Tue, 30 May 2023 17:20:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/4] debugfs: return EINVAL if write to unsigned simple
 files exceed storage.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20230530194012.44411-1-chris.hyser@oracle.com>
 <20230530194012.44411-2-chris.hyser@oracle.com>
 <2023053058-favorably-snowbound-39eb@gregkh>
Content-Language: en-US
From:   chris hyser <chris.hyser@oracle.com>
In-Reply-To: <2023053058-favorably-snowbound-39eb@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0032.prod.exchangelabs.com
 (2603:10b6:207:18::45) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|SA1PR10MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: e3bd08d4-bea7-4c5e-08e8-08db6153abe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +mWjAvyHWVoTHuldCxUJqORJfDicdkW6RquafMLbWFVpJBVvUgkTGh88diNgrmzwzGu2hbU4lS7xPUFotwF3CvqKxS02OWBbQSvY9DxcOI+k5x4ovF62lg7VsN5hPpnzie8NouHOeA3OZuar7hTu/nqNwoGGoThZyaBxsk8FZbHSXxWPgUgBgYhBvpEfWiv4xQK9H0BulHJ1+CFUGLrOjDQi5648Ic+/hsxJHZ1joUmWo0KZnPOYPDfibBvIQOamF6o34H2Ja2e/6tKmCXCv5NxT+5wHQZmIIfKVoFhVrz281C93ZiZmVeix9CXd+yjdcGmh/wo38WAuazLpitscMc/qmBk21IG94aHsZH2YUb31KLMjz5B40fYDsfL+zWLkIu41un1KbAiSWOIzsW5p9tODztkb5zeecEW9MfOEjwWNt6QsaVjRwzWxF6AxoS95a+dDoBdppuwefxcR3QIuXnwjDeUdVsZPoZx0ab5xd5LoObvtbpRmA2BuINh7kQ7L5z1Xm5937cRxcHmeNCzeduGMkQzp3Bm2ie/mGHXrCrud2U0yDdAdhM5xaJyrHzOYv3dy0ZDo849vhrMSHXaDNIg+YtMQuT1Q06JpYYg/Gee3TKLL24k/gjX2Mb5EiyKUZpZMMptw3GWBunHWRZtqZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199021)(478600001)(83380400001)(186003)(5660300002)(6916009)(86362001)(4326008)(8676002)(8936002)(6486002)(2906002)(316002)(31686004)(38100700002)(41300700001)(31696002)(6512007)(6666004)(6506007)(26005)(66946007)(2616005)(53546011)(66556008)(36756003)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDJoN2FwdmVWeVkvWnBIZmZ1VnFPQnRHTnJQTzlZTHIxUkxBVlhRa3pCWkNO?=
 =?utf-8?B?RlVqb3R2WnJDNytvVU0ydWVxUWc1QkNFMUtac0JQdjRqVXhsWTdkUjlkUlJW?=
 =?utf-8?B?Z1REM0xQTGhOalI0WWVMZGFzU056YmVpMTZLcFRkT3hnVmZSN0l2eHNtWU9U?=
 =?utf-8?B?eUpIc0JxS0NUbGxhMkVLYUZ2Y1Y0MjQwaERFKzYza0hvNEpPcE1BZmhFWm1s?=
 =?utf-8?B?NGtDMWwvK0JaSDZqNWdVd2tYOTBoZW5sK3REZFlqTFN5d0hkeWlObTMwcjRC?=
 =?utf-8?B?dTg0ek1YWDh1TDRRaVdtSUR6eThpVnNHdDlXNlpTMyttWVNRaW01Vkt5T0Nu?=
 =?utf-8?B?SXVkN3ovM1k3Tnh6TUdNTjhPcExYeUZ0Y29yUThHRGtRVmJiWXM3MWN0TFZ5?=
 =?utf-8?B?VmdGMXFJZFBtbllqWmh4Tklwczh5bEJndkF1c0VSVTVLRzgxRGpWSll6Zkpw?=
 =?utf-8?B?aHR0WTMrblUzRWpaNFJKUFhSWDZlSm9Rb3F6OVN3b3RhSW5sTDJ3SGJFM29O?=
 =?utf-8?B?YTMzR01tRVZhTmlNK085azFQaTVLMUoyZFp1MmlYY1dHa3dqOG9RbUNPYy8z?=
 =?utf-8?B?VFkxWWZVVmFXSnNqYm5mUE5mcUsvRUJmQlJnbFpXNnNWZm00clROQS95dFBR?=
 =?utf-8?B?bWMveDFJdWNnZ3dDN1VHT2lZVzdGeExhbExlR0xtUE4vcloycXh1LzRXS2Nm?=
 =?utf-8?B?aFB4Vk9sNVZoZ0dMbUk1VTFxcmdsR2ZUK0FmdCtvWDU5SUt1UmZLOHRhVHBz?=
 =?utf-8?B?NGhwZkZZK0ZrK3RZdUVjTy9iejVqaW1XaStqT2VJTmdLM2d2UjBpZStEL2NS?=
 =?utf-8?B?dlI2OXlMYzRrRE5DZ3RrcG9tcTY2UW9QTzZhN0hDbzAxdXVGOFgyVVhjRmdv?=
 =?utf-8?B?WjYzR3dRNHgvNkNkOWV1UWp4UEVRY21MSEt3M0NrbEh6Z2xGOFFxamVJWHZO?=
 =?utf-8?B?QWUyNzgybjEyaTRRZ2ZYUTJkV1lnQytyWmJ3NHVPVTNnM0VxUUtVR1d3Snhv?=
 =?utf-8?B?STRhN1ZPaFRtMjZQN0tWbE1kcjBFZWVKYXkveVF3WmdJNHA5Q1Jmd0NFZTdQ?=
 =?utf-8?B?NGdqMFpNaEZlckQ1RlJKaVFGQ0R4R0dXWFhRQVl2WEd5SlNLMnpmaFdsMVpk?=
 =?utf-8?B?QUZVRTJNYUgzTGdHb0hWdVg4cE1UUWZidFFCNkxYZTlxME8zNkZpYWJMbzF0?=
 =?utf-8?B?Yi9iQWtlbTd3YjJGVDIwejQ0dlExTzVERG50ODkyVC9sWEJJYWpmOGRGZlh5?=
 =?utf-8?B?ZUFvT1M1RlVRK3QrNzFYNU9YcVE5c0hldlNlMGNhTld3UmQ2cHdlL29pblJi?=
 =?utf-8?B?WXFVajJSbkNLTngrY0RFYzFITkUwcFRXa3lOa2FxQ3kwUm1rNm53VTcrU3Jv?=
 =?utf-8?B?TlBGWEJvWldKTHlGcXVCUklQZlppMHNiZzljbzhqZnYvcHNjSTlqSy8wSnQ5?=
 =?utf-8?B?Tm9UaU5BbXZTRXhUSFg5djJUeSswS1JxYW5xQjR2OFhTVlV6RzZzcm0rVEsy?=
 =?utf-8?B?OURndE5Eb2RZZDJtVVhaN2xHVzBJNzBjT0s4NWxNd2kvY2JXelBqa0M4ckd3?=
 =?utf-8?B?R3p1T2ZsZ002MUFZZm9wWWNyMjMvZ1VDT0drQVQycHo3Vm9WMEp3eGVaWHVu?=
 =?utf-8?B?Um9JbDdTVVdSaExtaUU1QU4wY0kzdjBXdmV3S1dZd3ZWbmxtRm5reERLTVdy?=
 =?utf-8?B?NXpScHlXdjJYSzI0OUxBNzZPQVdUamQ0M2RGV0hta0hIeTgwcGpWd1pYTmNy?=
 =?utf-8?B?Tm1UMEE1bCtpQWpVbDhIYkMyUStvVm1VamplTytJU0dDVmdOakxnSDJOVklv?=
 =?utf-8?B?b3pTU01pOWZUbDhCSTgrL1d1ZWYvcEdBeEpyQW1sNkVSdEpIU0pqRkNWbHZi?=
 =?utf-8?B?K3JKN0d2SHVmb1NNdk1Fd3ZjVm9QRkk0TkpRUDFsdU5ObHpSTGxwTVFEN2hC?=
 =?utf-8?B?aWNEeVI4TzRUR1A3OUtqRll1RXdPVWdQaUxlWTRsNlZQQm5IdEpoMklESDE5?=
 =?utf-8?B?UW4rWnJaN3Z4U3ZIVzgrUC92S2oyVVJqZmVRMFV5blFBTTA1bVdkWTQzOUo4?=
 =?utf-8?B?SkZtNUtLUHR1MnQrUk5pbEFoclJzK1FrL0NFUFY3cGlPdk10cTUwK1F3Vk5k?=
 =?utf-8?B?V3VwOWQyK2JDZ0ZQTVBLRERyRGdJQitXTHp4L0xmclRmVklQZGNQeDd6c3BN?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HvuFE7nynKoslMXn7ByLS1QFlSW9f8K3qZXy7XIDk+dYp5HjMyljS9uA87UdVW9MPXdStfSG/nJhFA6zira6keuON/L06lU+Y7fWRwc2fkhIVIj3AYEg0jFIfCkiIVQYwyTi6+/HrPRSABjNjuIILLLm3fs0D5LiCsyZ5HhOl+EZEuhKJ/AcwwnwQvWUe0nL1QVxsCOA/wXPBeJMDad1TEyRXjr5/6NNJOijR0d4ZLKU6Ajf0NzuOOaux0eGz7cP6nyFG6LxS+BlnZCbUbC1oR/qSLHvqH/qLjfIpr5HtYh38tAwnIt2lskCiMw544iisjhlXQK5Nqz58kqCTPWgR4e/vDXVvfggWg2fb+5xXCqhps2bfZtrJllY+gm09d1g64bNVCXb7XNs4k2j5yMj2Z8a0b/rh+0L2t7a+rm/WCmPabRZVVGENADb9/+KxEjEQF+Gt7XqYmc7uuRbi96ILp5hGg/jyjuqsy5QvEtN3AUAvoy90m/EKMus1wI8dv2lt/iGQqf2sjSoyu36nNTdi9OrYY+X6S0NW46d5i4OCOmCzO1Xq3eYSapdEOyzxERj6CxaUlqc3WFlxFro5TQPLCTl8GqFM8VCnjwhtsZp5+HKjgJGcCja49MTAwHpHQVwRFeJDtIUCNSEelVb5uUoOMtf7hXaqTfR+rpPe8Rtc2/25fot8cFEnP6awM7okKLV2Sz300yaO1gUmiaQhK1vxHrFrrNw8jOwMW9XuPZ/g4oqh/4dJ9fR48GqniRuT4SQwxhKf7C8iDrHdOkj5uS8t5OnpW38/YXgvYijsYl/vYMpBDWWmBDzYmlLAZeefCvs1/6FvMpJAD0LX8vi+/9YfSJpv/EfwyE4OlzIZJDyTu0va97jQYq10zkXYCiVZII5
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3bd08d4-bea7-4c5e-08e8-08db6153abe1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 21:20:19.9356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFJDU+OKUT0WrpsEL4CXhuZhIoXNKgjxQPenn+IE5N/9yFM1uONoBfM8Upqa9V4CIYkdN8r1dOq1h0LJevaSnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_16,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300172
X-Proofpoint-ORIG-GUID: enDx4d6HSmFzsb3Kt8rrXBlExY6oq-R7
X-Proofpoint-GUID: enDx4d6HSmFzsb3Kt8rrXBlExY6oq-R7
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 16:14, Greg KH wrote:
> On Tue, May 30, 2023 at 03:40:09PM -0400, chris hyser wrote:
>> Writes to the debug files created by "debugfs_create_*" (u8/u16/u32/u64),
>> (x8/x16/x32/x64) should not silently succeed if the value exceeds the
>> storage space for the type and upper written bits are lost. Absent an
>> error, a read should return the last written value.  Current behaviour is
>> to down cast the storage type thus losing upper bits (thus u64/x64
>> files are unaffected).
>>
>> This patch ensures the written value fits into the specified storage space
>> returning EINVAL on error.
>>
>> Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
>> ---
>>   Documentation/filesystems/debugfs.rst | 7 ++++---
>>   fs/debugfs/file.c                     | 6 ++++++
>>   2 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/filesystems/debugfs.rst b/Documentation/filesystems/debugfs.rst
>> index dc35da8b8792..6f1ac8d7f108 100644
>> --- a/Documentation/filesystems/debugfs.rst
>> +++ b/Documentation/filesystems/debugfs.rst
>> @@ -85,9 +85,10 @@ created with any of::
>>   			    struct dentry *parent, u64 *value);
>>   
>>   These files support both reading and writing the given value; if a specific
>> -file should not be written to, simply set the mode bits accordingly.  The
>> -values in these files are in decimal; if hexadecimal is more appropriate,
>> -the following functions can be used instead::
>> +file should not be written to, simply set the mode bits accordingly.  Written
>> +values that exceed the storage for the type return EINVAL. The values in these
>> +files are in decimal; if hexadecimal is more appropriate, the following
>> +functions can be used instead::
>>   
>>       void debugfs_create_x8(const char *name, umode_t mode,
>>   			   struct dentry *parent, u8 *value);
>> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
>> index 1f971c880dde..743ddd04f8d8 100644
>> --- a/fs/debugfs/file.c
>> +++ b/fs/debugfs/file.c
>> @@ -429,6 +429,8 @@ static struct dentry *debugfs_create_mode_unsafe(const char *name, umode_t mode,
>>   
>>   static int debugfs_u8_set(void *data, u64 val)
>>   {
>> +	if (val > (1 << sizeof(u8) * 8) - 1)
>> +		return -EINVAL;
> 
> We do have U8_MAX and friends, please don't reinvent the whee >
> But really, why?  This is debugfs, if userspace messes something up like
> this, why not just cast and be done with it?

So PeterZ asked much the same question when I submitted something for 
the divide by zero bug mentioned. Just don't write 0. Ultimately, he 
recommended looking into the more generic min/max stuff.

Now, if it was only "really" debug I think even then catching an easy to 
catch error is useful. Unfortunately, many distros ship with this stuff 
turned on and tools access these things ... which is the answer to your 
next question, what might this break. I'm not sure something (likely 
accidentally) relying on silently dropping bits really works, but it 
would appear to break with this change.

> 
> In other words, what existing workflow is now going to break with this
> patchset?  :)

I would answer this with your point that this is debugfs. I remember 
when a bunch of the sched debug sysctls were originally moved to debugfs 
files. That broke tools etc, but the argument was that it is debugfs. 
You should not use it in production and the API is what it is. Not an 
exact analogy for sure, but that was my thinking.

Honestly, I wasn't really sure if this patch would fly, but simple 
checks and feedback even in debugging seemed useful to me.

Are you open to the min/max files patch? I can resend w/o basing on this 
patch.

-chrish

