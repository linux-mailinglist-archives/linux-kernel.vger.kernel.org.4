Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2D0674CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjATF5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjATF5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:57:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6AA11EAE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:57:05 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JNDpHi007782;
        Fri, 20 Jan 2023 05:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=YktTjB2zKT/72+7B1jivFn2/qWf3tgdgl7sMfn1Ce+k=;
 b=OLOGoADs00rlfBnPz3GEDPM+ZHU0TQYr4cUpfNPaZ8UOs2kmjjAKP1yr7R/39SHjjdli
 boNUopIrdtunlZLeV724JPtelxp+ngMr0JaYjbJgJfI7jqtZvOsKf8OUgoqKQFQGr774
 W7kKsGYZ0vWfiW4GNC+cYEF0HJ2r1tprffsx8pETpM1mpuuh2CAGix86AalbXauWTGEQ
 kV965r9cb7l7xqLK5PVUS4C0HQOAxD6L9eEowjzMVHDQEyQsmWbJvfeXTHo7XG/AHXS/
 mPo0BLCfPpOoD4wH53xLZnTDlIAlxpcQ88FEYZCBbsCflmBtNAXOdEDIzLQjg/CeAqvm Ng== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n78959h1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 05:56:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30K2sskT018699;
        Fri, 20 Jan 2023 05:56:58 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6quhmuxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 05:56:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HudMQmw4Np4pjHDCErmJ8c3Nj0SO2YFo7vl48OSQmLhlxOF+cEEnjcefkKmBcGKaPkhnkp4vKqmX64MnJxfy4BeeKoyCSnmHZUxKG8SNhQ2ZxLeSRGcSCNNZwgYWo+nR17OZLDSJ5LuNgYVO4TpkAf7BT8ndBkI5DVbWbSSlV2LEeCoB1bpfxd5HHhTyToYCbbZRdY6XmrWkENa3kaSNgmSncoS0zCIS7o9742JP8NYcKmV9VL+9fUo+WnnJttFj5QAmPM2ndI+p+l5bidJjHtICdl/R6rpSWPYvsaOLyRwbyoiSSM/Q4J8V58mBMoq1Xo2BUzj/fXMNJoW+7cZJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YktTjB2zKT/72+7B1jivFn2/qWf3tgdgl7sMfn1Ce+k=;
 b=Ep1f4DO+Q7zFWUURQJ8EN5iWLSaCv6HZ867NlZjO5+a6li3HdZq//xief2jaD+tqgw8aEfV2T1GCUKCe5xMRgTR9RLjfDkiD2CBr24IBaqpYWLVVu2bO9OQ9S8/pP8Bvob8SHeVY4ASwuJUtrQPWCo1VGwAHEeK8aomOejntPQKy0VVsAXzsPmHRKGrB7SA+8HGx7yZ2F5U9J262Dn4xpxUbgjIpz4SL5suVHFeUAHNn9LcJdIjH64GP2KyVJ9qrXi+nQFz/xLifX/wugRsI1AJ78WU+85lKn4UUJsboRlKWx6Gq1hq0/OIhmSJXNIKgde4b+nh58YaftmRbwJxrVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YktTjB2zKT/72+7B1jivFn2/qWf3tgdgl7sMfn1Ce+k=;
 b=LB49Ltu6icdL7lk904Gi6QrnKI+RPRPylb4T4J4utZw0olTfHXaJk1PPblf0TyON+fNG5hG7CIm6RhQ96l2sjjHE0AmFwfOGHpCU6gvXGlt9gNHRfkMpDYmSbcKMUZz1TWO3EEWEhCCiyigCEi8gEnRDtZdQ9DUNg45W30CDZJM=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by SJ0PR10MB4447.namprd10.prod.outlook.com (2603:10b6:a03:2dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 05:56:55 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Fri, 20 Jan 2023
 05:56:55 +0000
Message-ID: <a700c648-f1de-83af-ae6a-181bf8f04e21@oracle.com>
Date:   Thu, 19 Jan 2023 21:56:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_linux-next=5d_mm/hugetlb=3a_replace_get=5f?=
 =?UTF-8?Q?hwpoison=5fhuge=5fpage=28=29_with_get=5fhwpoison=5fhugetlb=5ffoli?=
 =?UTF-8?B?bygpIHdoZW7CoCFDT05GSUdfSFVHRVRMQkZT?=
Content-Language: en-US
To:     yang.yang29@zte.com.cn, mike.kravetz@oracle.com,
        muchun.song@linux.dev
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
References: <202301201036092738081@zte.com.cn>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <202301201036092738081@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0056.prod.exchangelabs.com (2603:10b6:a03:94::33)
 To DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|SJ0PR10MB4447:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cbbbea6-2b95-499a-f8e4-08dafaab22a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zI3uRiWksu8m817JQMBTOBtCMTbe/gblRzgwYnHtTrWXxnljJqIveVVHFOFfyFrAhT0KUPsdO3mv6dKGDZMU6wEPL/zEhbuWiX7YMQTNkRTdy7mdCH7nCc0MLQ5mlhIbAynA0nACoZQzSK7Il2i34MlVGz+UvvwScgBkXwGYIxbHNcfkQNlQhroE5H3/GuW+0Y7Za2d3yQsFN1IU9QB8OKsJmlWh/4WD0UWWq9gsmrJ+pdQjYNmwIT+JpZUgmtcqwlg7EP8AuPRJbqsbZC9zD5Kl9BPJ2UaCVrMe0Jt3CcAM5CLv8LcEonSI+w0oIX7ZbjaKpIUgjs9lfmlalAzKfaK43WoNBJgN8ULMA3Y+ngkOOGL/2xvfOAoscTjo8OeNnT4rdLJj47hTD1jkmfziYgRZhszksCm1MGOYCnXmYmy4jY2dVay5hhLhiunVcbzyj98eEpB2hr/oUHEHuHcf5/IFyH+09PPQhNOk+32J72kgOYQSR3kd8tVKk8Kj5nyLKQMbarmKeWy/k6E4HvXPaRAI44CgRkaeGIJ4Qa/JIZQSil74ElUqFHeXHkPYYsmAjeABP40Ff0WToY9k6yRYD/JD+wbmJP/EWyn3pc59La6Wajwxn14G+f8/sPMyx08YC+e3Wj+kgv9LUG0CuXzdYGA5EFuXvo/cx1Gv2Jd413U6FjhX06wwP5vXIp9bdEhPFiHreefsB15naSf8G+zSCtpR/aLSpyepVEWDixW7yF/4wWocducGo7ElvCrpmVfWmijwj947Woh1aER8vfPftlozphqG9P0ydk0SgiUF/YE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199015)(478600001)(6512007)(8936002)(2616005)(5660300002)(966005)(6486002)(38100700002)(4326008)(66946007)(66476007)(6506007)(186003)(66556008)(316002)(53546011)(36756003)(26005)(41300700001)(31696002)(2906002)(31686004)(83380400001)(86362001)(44832011)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTNYeTJZMlpiTnFGSFRRWi9xc0VibTZRSFR1UHowbDBGekhIZnJ1NVc2ME1r?=
 =?utf-8?B?WFE5eUV0Njk1aFhOR1dYWllIdklrR09pbWJzdWkxRi9vbEJZdlVPeHRFS0F0?=
 =?utf-8?B?WVNiK3VLSXN5dURiQ083aXJTWWtGNlJQc0pZS21paWJaYmV5NXhHYTUzMjcw?=
 =?utf-8?B?Qmg3bWU1KzVNcWhJZ0Y4cGd3QXl3VDR0SkVsVlplZ1I5RFF1WUNCaG1ZdzVJ?=
 =?utf-8?B?bHJxMks2UEhmcnNHMVZGQ1RGSCtOaHR3bjlleUUyZUFRK2NHR1k5YjRoZEZm?=
 =?utf-8?B?Yk5jWVF4NXVtai96RE9ITnAxeG83M2xDVU44VncvTjZVenF4M3JZVmV1bWQ2?=
 =?utf-8?B?NG9IbXBmR0NNclB1dGNwUktrRURESkdaZmMzZ2YwNStEZU9uNjF2RzlQMEx2?=
 =?utf-8?B?VlN5cm5EdFQvY2kzaFdjeXVWRjNrRGU2bW52TDdOLzhQWmNrdmk5aExhQkl2?=
 =?utf-8?B?SnpYb3JpbU5aRXdBbks5QmdranhycW12Y3ltdW0rM3MzYm1lNXFHenh0dGdM?=
 =?utf-8?B?S0lZUUkvYXk4K2xFTkNEWXRWcmNVdEZ5QmUzemEzaW1mTzN1M3d2WEdjS29U?=
 =?utf-8?B?WUtsSzdUVVoxRnUyZjBMQlNhT0RXdCtHajAveGxVNFJLb2trcXZnanBpL2JS?=
 =?utf-8?B?L1JYRjBHVEk2bHZYcFdXRUhONFAzT1BGbE43L0tBQnNOYzVBdGZUZm5aVkZF?=
 =?utf-8?B?OXhOMmc1WFhWQXNlcFhYQzhYVE1vNmxGWUFNdmtYRGpsVnFhd3BudGhoVExN?=
 =?utf-8?B?cy95Y080dDdYMlpIMGlsT2RSZFpGWVZlZHY5Y1hMUXYzL05vM2M5WHBXN1FQ?=
 =?utf-8?B?K1RJVXMyWnF2Q0hBb0dzb2JsbExoaHY2L1MweXdNbFhRSEsyZkUxTi94NW93?=
 =?utf-8?B?SVUrUGdVY2QrUUFiMEhNTDh1UkFuSUhSeHFIS1dvczI0QjFVMUlKYnFQZVRB?=
 =?utf-8?B?eTFyNUlXL0FsSUlBZktXQ1NlNUdGU0lZdjFQSklJOThxTWFRZUZnUm5GaGFn?=
 =?utf-8?B?ekk5T2NmMU10OTRkTlc1NHlReWFBbUVMbzVRa1lCVnFHempVbEFqM0xCSTl5?=
 =?utf-8?B?TGd1R3JTS3k2dmhzSnQra1AyTStiaHpWMysrcHdKUEx3MzZ2bVorSlE1Wnkx?=
 =?utf-8?B?SURXbGIxcXNDZzZTcGdpMGhrRmsrRERGTkMrSSsyTzVVQTJIRDRpYTJVTk9Q?=
 =?utf-8?B?eWVhcktjQnVRNmpOZ3ViRDFsQ0VJeGhaNU1ZOGZuMWNOSEZWbUJLdktnY0Qx?=
 =?utf-8?B?R1V5TlU5dWptK1JYa1JZSkFvZERwbDR0cGEzWUJHSFJlVFFPMkpnSzhPYlNS?=
 =?utf-8?B?Z2ZleHhXRWdwSEViSTNqa0VMRURlVWY1bEpPNU10YnlYakl6blEzUFRLSm5k?=
 =?utf-8?B?VWFCanoxSDNBV3d6YkswblVKQnphdCt4aEFQRVRydEZLVm5qVi9xVG04S29l?=
 =?utf-8?B?WStIOFRxaG1ZUlRyNkNmZkxzdEx1RkZZbVBVOHZCbVlxN0Z5SlVtWUxYempk?=
 =?utf-8?B?TmgyejNLUnZDdW1sSDl0MFk1dTRnb3BqTVNuUENpVDRGajkzeUlPZGJNRDVy?=
 =?utf-8?B?VXYzTUlzai9zeWo0U1dtdEVhVXo1NVVWRU5yMnFyb0c4a2VPY1ZrZG9iWXRV?=
 =?utf-8?B?YklvZmt6UitnMkNUZzhUYTVlalRjMEFidXlwR0NIelFkamoyR1RnT0lIZHVk?=
 =?utf-8?B?NTArVkVzcDB2NlpvV3JNd2g3NjNEMmxTSU5Rd29sNkNIZWs3L2FUdWRmM1px?=
 =?utf-8?B?ejdiSFRtc3VVMlMwRDFiSFZtcnY4SXJYdlUxbTBpMUxrUms2b3VKdnVITUpu?=
 =?utf-8?B?OWZ4RlRtM0JOUkovbStGejF1amp4eUprLzI4bm1zWnRiazIrOXBHWExKdTNS?=
 =?utf-8?B?WlVNMDdZOTJwSldOYXh2cCtxNkNibnJqQ0habVNCVklLV2VGN1M0QThHbUQ4?=
 =?utf-8?B?R09HTWxvRTQyZmJRZzFpMGF0R1ByL2NLbnRHQWR1T3VCYVlrQnIrMFZuRUJ5?=
 =?utf-8?B?dktaMHlHS2E2N2hnL2pwajN6WnhNcVNZOFpLNnQzNzFtdUo3ZlplNzhxNFhi?=
 =?utf-8?B?NEVDbERaR3dwck01cUhIclV6alZkS2RWRC9Hc1l2d1dobklmUVRsR1J2MTM0?=
 =?utf-8?B?MkZQMUtIdFhWMHVDOSsrTUpadFBzN1gzNVFwR1l4Z1dtbWVYcVZoa0c5VHlC?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SC/PCx2l6hlymnvTs4c4axHPV++TBZA+3VE4eKM5jaHDN22rL++X3pAVY8QWR6oWrnMzuwlRe3mMw9+pMbe6LL0bruL4vXjOayX6KVetmrS/qqQ3oyjo8YRcxQtY3sldhxav81fEZqpdc72lKUrMyTcYFXjK2caiAMSzBHXqTnvU8g48ZYv8Mqiy6QyCwPsKnFZnpfkBKlc1DE7eHi4MjLzMyKtT0qnpUZCes/Gfzo9lRFQcUn63+G6mvkPAVKSta8XbLM0cF4bxiZ/oc1MmfhXJlXoQgAnEYORv29rSR+sWlx3VCnfD1z00KoKR9CjhTCMoP+choIrRLrqWr32XLevPhcYd5sZP9w98Xsw8+qzkY8obAUoJ/cvR1dc1cfP7unqDi5Nz+s7NqOe9sclGgedse+WUAhU7S5gisBwNTRSHzAXZ+rUrKp+Dj+B8mizVorjJltTgxV9MOLEf7Ym4QbMpaU+8A8PXbIQZmNI6kNypuPe9NUx3+cldndtgrVtSbYhXKzTK8HTyyx0Oka5Z+2iYZlewEDDxMLi3IoC+ZgSgsAaJo1wfP/I7w8XVG9z/jZrJcOEJyxgFW9Y60pnSG7JuWFkgJxQuNu94lbI1Nat19kXT6/j+pqXiQoonXeDSocKm13cUdGq1AHIVuGB+wEu/9PpEfGZweAYYiez2wSHASBnf4h8DN4hq3RdoRwZPTGdfs2fT8ECoel2vOVOu3kSNQiXM5kTcKyegS0QK0GxqWsmMiKREo/Jx2VKK+fE1u3jT79rAESuYo9YLR0b9Ww/XfnXd+XmbVQMYuE7u6Q9ViBjnFEZOQkT7JBIndpCdIsm8CKJ1d7F2Bk7Ivh+6CD3XLyyJX3tz4swHRO/mwd4HxEIpRl2attSIv5FtPyrK24P9arOy8fDaa7qKcOrgYQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbbbea6-2b95-499a-f8e4-08dafaab22a2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 05:56:55.8022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixDY8dCG0vdFiLaw2r2Xrtw8NUyo7CqoUdi/5OzvlzQL2KM8hHPrrYNoKM7Mgv0vyjqrnM+tyuMKnnrSobllPIwsoSCMfYSs2ZUJH+iJnsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4447
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_02,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200053
X-Proofpoint-ORIG-GUID: fh80ErlxJARvu1nuxeRmHDG_vXRFu4ch
X-Proofpoint-GUID: fh80ErlxJARvu1nuxeRmHDG_vXRFu4ch
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/23 6:36 PM, yang.yang29@zte.com.cn wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> When CONFIG_HUGETLBFS is not set, there are two problems. One
> is implicit declaration of function get_hwpoison_hugetlb_folio(),
> the other is get_hwpoison_huge_page() is defined but not used.
> Fix them all by defining get_hwpoison_hugetlb_folio() instead of
> get_hwpoison_huge_page() when !CONFIG_HUGETLB_PAGE.
> 
> Fixes: 92e109a2c5a7 ("mm/hugetlb: convert get_hwpoison_huge_page() to folios")
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>   include/linux/hugetlb.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index f14a6bd2a6ed..9189cc359c64 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -417,7 +417,8 @@ static inline int isolate_hugetlb(struct folio *folio, struct list_head *list)
>   	return -EBUSY;
>   }
> 
> -static inline int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison)
> +static inline int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb,
> +			bool unpoison)
>   {
>   	return 0;
>   }

I believe this issue has been fixed by this patch:

https://lore.kernel.org/linux-mm/20230119111920.635260-1-arnd@kernel.org/T/

which has been added to mm-unstable now.

Thanks,
Sidhartha Kumar
