Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A2B74275B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjF2N1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjF2N0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:26:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CEAE4C;
        Thu, 29 Jun 2023 06:26:53 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TAp4rq008123;
        Thu, 29 Jun 2023 13:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=lN+jTOaOCjZdlNtPLPO9yqfYjzHMM4adlbwrNpS2F6Y=;
 b=E2+DOiWe8tQR3IG5qHKzZIe8i17BiRYy8paZqSqV503NWSN9SEKCIReb83OCWnP6wLaZ
 pBKdXxNFeFoWJgO3qWY9uAPk33DEOwH06hVi+St6nTX//JcLMvi4Zdjc9VE2geZMqmhv
 IeyCacp+YiZp67/xfsTLEG5nk1rdTsT1oXSmyPpRstw52jWoz8sRjlYwy2DN7wqGbT78
 ZBoFarElW7VcKP5is4+ktmx7ssKY6Z794wp82LDRDhRvoroxJdYBt9ku5+eLrGbcSyWt
 mAqZ2YiedWP2KGezFccsROr91GuPPONy74NoSeoc6akZtxtkJ7SR5jn4LNKPSRx6g1qT KA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdqdtv795-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 13:25:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35TCrQCT004035;
        Thu, 29 Jun 2023 13:25:20 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxddk8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 13:25:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FB6kQz7lejv9FYRxRRNxomY4YCs+JiSulVmRXlZMZZmoWzCk+vnBYRd0mtlV4d59smSigasIz016iB/n70mFQ2SDQEjle3Rm49WW501AmsNWtni/JSc+aCuUdH9vtenpo4dd8F9meauKp0IRnY0hoY5GS9LNv18702mxSNQ1qEjzaXyoLJm1mislTKi1a0404oxv/ebZ5UZ5B7CmLbczjTNYPFOU21HFPB4sZrkHHEt+nSWC7hkd0ia4bw+CftRaftzGym3emhSU91S2wxbrpQNKgMQmgNJAumftokGupEhBJ5tSyng8k+z0epNzWEy7dqU+9f8U0DA6Wt9+OIkflw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lN+jTOaOCjZdlNtPLPO9yqfYjzHMM4adlbwrNpS2F6Y=;
 b=Zbx3E5EPkwmk4FEQp+Er0806AeCzOt3sxD4ZfEYzi6oZBrC9xPSyqeOqoz7bWR8REscggNd7IK/MxFXmjAqF8PBNr8WaywUmhWWZ7BG9J78OyTfRCIWOdtR39yv5ao/fNfNGgYNSySz7wfI/h8KzjXmglUCr1BEH3uWN7wywGFzjhimaIP6I06hg/pMszClANxCX4nBy4zCoddcHzVxp3bglhtuNzhskPPh/tqWEYBoKdMPj98IPqy0kC8U4ypizH62cJJan+A4WaCcEKU7nicFTdenkTTrg9Ffgq07RkFv7RKpame8CtDB5BkqEBJyJ0+NVOxTliWiXlSjlUj2Tzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lN+jTOaOCjZdlNtPLPO9yqfYjzHMM4adlbwrNpS2F6Y=;
 b=L5N6u8Hebg8ep9bnDq6lgycOHOGH61+t26kBhKPRqVdRkSIjrVMe7dfJPTM4QTtclSm1ASy1KeA29XqDRCPf7mLXxwXU0vWIUQqcuf2QL0b9gpK5CQEpyJ32X/z+bWclIObefgbXFNsqjDinA6bTNqEwy/YNThIwBA3hyU0KlZU=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BLAPR10MB5169.namprd10.prod.outlook.com (2603:10b6:208:331::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Thu, 29 Jun
 2023 13:25:17 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 13:25:17 +0000
Message-ID: <e4288a46-5cb2-8797-bf30-c14765af8ce3@oracle.com>
Date:   Thu, 29 Jun 2023 08:25:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v24 01/10] drivers/base: refactor cpu.c to use
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
 <20230628185215.40707-2-eric.devolder@oracle.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20230628185215.40707-2-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::6) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BLAPR10MB5169:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c1b777-b400-42c1-327f-08db78a4475e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJYYcd+WPG14VWr4W1ONBGqcG+rRC5ufY7The95Wv20YoTs+aBCiFZLutK5R2x5DZnqgkJUtHabwgqftdlC2S5hquDYGNtVA9pjArwg/8ylPrGaxmR0Bq+6j2lTVnmaE+VKT682pDe/taXLlsOdWvlPL8VuFc115mRX9W1tX+k8uuB8YwKf27qdEVUw83NB3ygkSyvFsBoSogQsHtZT/LE0od7bpOUYnKvK1VhlKqvK1PYGdoSpGHj+4su0UvOiy/gzT4rRrdjD4LCtGhPUSV+3yQEiPPvaIs23mcREYVu/28l0YR/mEWF1h76thu56zpK/mAsljVHjuh6leJlPLKArmkC9dxjS4tUlluvQ1KcUh6u1PEJ8xWA4UhKWdpk2p8g4vT0HfK2L0OQDO4pSLLvsAuPzhgLDVDOPVpRV53gVKdus3FZtCTDzHZWxDIMMlp+ZClejHE9exquP4S3H1mWV9ACxJUkgwWmk5fS8K+9UCji716SyiRx6KqFTtR47y/c4votGDDeQBQTJJ58f/7ZqyiTs3VMmFk/feBPETbG8hWd96YlDvTHpBgbqUfGCBPiffkdDGErO9RRzpM5/JZx6TbbGDEjYxR5JkyI7OZ6i+3tTE98oNSBCCf42EzBGMNOfhW7INz1eoly6Ob5OQIUtKPosvts6Zb1IPVYhbj/Rt13uqvOY+qk+F1iidLXpm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(2616005)(83380400001)(31696002)(86362001)(2906002)(38100700002)(36756003)(8936002)(41300700001)(921005)(6486002)(8676002)(107886003)(5660300002)(478600001)(316002)(6666004)(66476007)(66946007)(31686004)(66556008)(186003)(4326008)(53546011)(7406005)(6512007)(26005)(7416002)(6506007)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHJyNTlQRHFuNU1yNWhKSUJDM1hpOUxxQTBaWTViaFh0NTJoNUdvKzYvUzlm?=
 =?utf-8?B?UTlqWkZKUnY5Y2dFVkdPV09Hc2NodWU0MXFPUEZoME8xSHQzenFMSUFNVXRq?=
 =?utf-8?B?bExHc1JqME5OT2lvTzR1MzgrNXVNd09KWGF4aEtrSVA2WGVWRzZEdGtVUTRi?=
 =?utf-8?B?K3lGL1NVQk9jMnFzLzhaMWhkdzBCbVVZV29LT0VKaXNCU1ZhNHc4Mk9wTW13?=
 =?utf-8?B?QmtEQ1lLa21ZOXU2RENhS1hTWHI1NWgwa0hOb3hZNUo4RWJ2Yk5EUHpXRWZP?=
 =?utf-8?B?QkR3Y3MzbWR2YXRrOUM3RS8xWW5oMnVmRFRqdlFBNjAxaVZuR1lGZndDQXJF?=
 =?utf-8?B?amZFYVVISW5DUnlrWmNDN2FjVllRMWhxYXpvMG93cGtVYXR3NThmOHdzY1ds?=
 =?utf-8?B?Q1lCeWhaK210eU9LMnR4aG5QK0VWOWxEOHFJdVE0MlIyMG1DYmMxRXFtZy9J?=
 =?utf-8?B?Vjhhbkowc29NK2ZOVlg0VWV3ZkNEcFhobHByTjFvSjRyUk5TNlUyZnFxUXZw?=
 =?utf-8?B?YTlGTjh1czdpalpYTEt3dkgxcVgxVVVDRUs1c2dWeVBEOTcySUQxb2lEZWhQ?=
 =?utf-8?B?c0M4TUROb3k0VDlIOUJYdURDcVVhUFZZQU1IbGZiaEYyN2ZqdFZMUEFIZE5R?=
 =?utf-8?B?SjFWOHZReHI3Ukk4UllsQnRtMUZJMXNHZnJEZVM1NHlYWE1tanIxSUxpQWts?=
 =?utf-8?B?QnJZV1NXRDJNNVhNbkd2ZFJSTU9VTVpEdTUyYVZQZE1NK0JLdXdUajJHZnFu?=
 =?utf-8?B?a2lxQzhHZTlScEgyN2FMVWVma212THY1ME9mSnBKME5qV2NydTBmNi9zZ2Q4?=
 =?utf-8?B?dkNWZENaSjZpQmhoWXJmL0ZLWXhIa1h1czRsVnM2QmpKYjEwQm9pWFY2QXlS?=
 =?utf-8?B?V215U0ZuSVhLdXlEN01OMXdkZnBIeGwrRERUekJka2lCWUYyZCtXYXVuVVZN?=
 =?utf-8?B?emNXNkhJNVlieU55TkR6UXFzQ2FpR29yWFhteW9xTXl2ZjVEYTRDQ2ZxYTRr?=
 =?utf-8?B?U09lam4xLzBxRzZQTWZKZnF3blhQd2szM3h2c09ob3dvVDhJVWxZenZUNXJN?=
 =?utf-8?B?VUJMOVFVcHFabldmY1laeEkzdXhkQk9vVkp3N0dDRnJXalh2MENPdHk2YktM?=
 =?utf-8?B?cEVKZllaVWxsMkZoMm54K25yb3NIaUI3NUs0VXRYbk9uS2JlQllaYUxrR1Y5?=
 =?utf-8?B?QzQ3ZGxwNXJCRUR5dWtxY2Z4ZGduMDYzUzNUdWo0WFhaTWlhSE9UejQvanBr?=
 =?utf-8?B?U2w0UW5xUU9xT1J6a3NYQW5LaEo2aEFJMW0wdjJHSnlHK1VacC9YemsxVSt5?=
 =?utf-8?B?ZUZxTlhJMnE0cUc3MFN0WmgxWkkwb09uTXhXT05GRlpjeDIvQ0FVNTBrVVMx?=
 =?utf-8?B?MkFuc2s4OEd5RmcwTS9LK3h3Mjl4eWR1djFSTXlBUmt4Uk42djFrT0JnaUN3?=
 =?utf-8?B?QkpQaVRna2lUa1FSWjhkZzNsOWlHeExoOUlZOUlycHB3K0FjSVAzMy9Jb0RU?=
 =?utf-8?B?VGVpKzhGaVRraWF6KzZkbkk2TFYyUTU1MTNyQmxMdWxveHZ0SWdseWlEb0h2?=
 =?utf-8?B?S3pjMzdSaEIyN284WXAxYTJwcVh3a09zaFZTQ0pxZ1lUSVNadW9TcnMrV0dW?=
 =?utf-8?B?a08vOGlSUE1Rb01BK2xxZXhxcnhkRnVsaUw5bmtXUmZJRXlhSDhnbUp3TDFa?=
 =?utf-8?B?ZlE3RnV2dkE4OGtQUzFmaUY2clRZck04ckdiajkxbTZTcWVzY1A3RXlLdDIx?=
 =?utf-8?B?aUhHL2xBdzFlOEpScnhxejhKZENzbUZtTGI1Z1dDbzhRZmlQMksxbGhnSDBt?=
 =?utf-8?B?Vm5CYk1pR1RUVzVBUHp4Y1NYMGsxM1haM1RRQ1hjdzZDNFo0UFRlcDB0ZTFC?=
 =?utf-8?B?UkVMalJpZlUyUWJGVkVRRVJBY0ZqQVpOQTNpeXRIcExFb0VxdzZwdWVBRWFY?=
 =?utf-8?B?NHhMZk9MM1VlVkdHTThNbjliN0dzTGxkV0d0TnB3aTdGT1dDMXRGV005S1dM?=
 =?utf-8?B?RTBMU25lM1VCM0ZEVXhrbXdiZnhtQjNsbEl6bDhVc1lLL01idkprQkYzamgw?=
 =?utf-8?B?cWJCVmdZcm5lek1EcjZEQjlqZ09aNEE3ekEreHFDblExdEh6QXdTVVVHR0Rk?=
 =?utf-8?B?eHRjT2NUOVZQbTRGQ29kNWtXaWl0Q0dzaEpuemdjdU5mc0puRHFoQTZkdGtq?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cEVzaUhrUCtxWVp2enQ1K1gyN0xLeEsxaCtKTm10cGlxMmZKVzJISUFPSVIw?=
 =?utf-8?B?Q1VBNC9oT0IydlptYUZ4Z3F2bVM0TXB0aWNNZzI0NmNuVUF4SnU0MHdDS2p6?=
 =?utf-8?B?RzAxWHlYOEFScnhzay9nZTY2NW9jdE1oUGVoL1UyWWxaWFVSeVdnS1ByV0Js?=
 =?utf-8?B?NG9TQmxzT0xwaE9TSEZ3N2xXL1M3b0ZuUnVYNG1hK2RqdWJKWWdvalgvREZ1?=
 =?utf-8?B?ZEVuWms2aENYLzV3RlYrVjlQeW11VUZCS0wrelppd2ZEdGFIK3hEWHU3aWhn?=
 =?utf-8?B?TldiWXlTRTIvalFyZnI0YWlzc3hzV0NGK3hPVkh5K01OVWdyTEpYR1NuY1dZ?=
 =?utf-8?B?cU1ScU14WDgrYkd1Y2dSK2xMVjJhS1NsUU1OSTFXNGxhN3NrZ3B2RHd4WUl5?=
 =?utf-8?B?YkRQOWx0QXRSMkl0bFVMbngrN2QxVEVFWVdjcE1vZUFKWVJRY2pvYng5M2lN?=
 =?utf-8?B?NnZpNEEzY3F6N0tOTWMvQzk5Y0dha21wSkJmR2wwU0djaEFNQ08zUlZtTmE4?=
 =?utf-8?B?MHBlM1BNazdPZzExUHNDbmZyamRnMXllWmxDSm9taitoK2g3VE1iTnNEM1dO?=
 =?utf-8?B?Y1E2cGtnbWgyRlIyRTBPd09vbWJVYjNHL3ZFWWdWa2hwWlFnK0oxZG44RXFj?=
 =?utf-8?B?Z29Ba0xhZWYvS0RkS2JLK09LRlRlVndyeDVzWkg2NXBtd0NvUE9XRGpJUTZ1?=
 =?utf-8?B?WFl0Wk5qQXorYVdhbUoxSUpKR0Z6c25kSElhTzA4NnhDeWsxNFdnSXcwdUlz?=
 =?utf-8?B?ZUdmUlIvdTcxWXJ6Nm1MTW9hanY1ekptWTJ3dGhteTBwdFZXeTRtbW5VeHdU?=
 =?utf-8?B?TTZyc0I3Y3hINWpKQlpuc3UwZ3RINkpGd1hYbk42QVNaa25wTi9qdnVIWTI4?=
 =?utf-8?B?bnN5U0RZeE5mMFFXaVcwTVc3VGFGYTNnSnVvYkMwdHpLZXBSS0U5MklZQ1lh?=
 =?utf-8?B?TGc5K2xBbXA1WFc3VFFOQkxMdndteHFXMlBjandnYytURENxZmY3WGkzMDhw?=
 =?utf-8?B?VXA3akphNnJ6dWoxR2xzL2lQNkNuYU5hMmRXb09VZ0dNaUlDOTFVRG5IRGxk?=
 =?utf-8?B?YUJYejd1cUFTaHVEV0o0UlRUK1pxaDZIQTJtb1h0bDZHbUNLWE1rbTY0REVY?=
 =?utf-8?B?bTJxU1dISzNvckgrWW8wc2ltV1Mrb2hlRXdXZVphanNZaXdtaHJ3L25CaWhi?=
 =?utf-8?B?NGpjY1FlU3ZqQnFnVkFhRWxSQ0FDNlh5bEFEN1U4c3NLaVlsN0NoYmhlbitZ?=
 =?utf-8?B?ZVJybU1RRTJhQTNyNUxNV255WjdvVmpvUW90SUdVMHZnZ2xUVEd0d1BKcmYv?=
 =?utf-8?B?TjF2TDFheEJtTkZSMnZBVE93TDRrTDVsdEJXTjN0NDNJQngrUTE4WmN0SFQz?=
 =?utf-8?B?cjhqaDZoZmZUNGJtSW9tM3U4MU9tOWNyTE5VdnNyNWxQcm0wcENyQWJEMWRk?=
 =?utf-8?B?VEYyaHJ6a1JtR1ZxaXV2ODVRdHlCOVRYZVBQVytuVzNGUnN6VHRpcGd1TUxE?=
 =?utf-8?B?WHY5T3JrUlFRNmlaZDV0ZXJkcm01d25ZSXBoSGtRSFNjYzlnVEs1TTZ1SVlu?=
 =?utf-8?B?MDBYUzhPbUNyeGNTVUJmQVo4MFJuUUcxQTA1U0dsenh4dS9QbUlmZnBFY2ln?=
 =?utf-8?B?WlJrdEc4aHNvWmoxSktscUpaYWtub0dpK0ZJRS9OTHNBSXN0a2JFNFVSZ20z?=
 =?utf-8?B?OWVpckZGR1lxK2srVTdmajV3WnMzbEVwb0xqcmxVeUVpTU1QaGZnbkk2RHdK?=
 =?utf-8?B?MzUwdGRYejd1TUxtRWhsVGd3ZXREMXJrWGo5d0piMktIUEM0WElJYjRKZGgr?=
 =?utf-8?B?ZmExaTlRdjVoK2lGd2NkRHY2SlJPWThrSnZoZnExWXEzUERqd1JFVXBKM2xw?=
 =?utf-8?B?bDRwTktCSXRoU1oxTGZXYldmQ0cxNVduRTZ5RFlsazd0RDBkUjEvSENrdVIv?=
 =?utf-8?Q?UMj/LogOQLI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c1b777-b400-42c1-327f-08db78a4475e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 13:25:17.2703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yL1mmbKvccTZPpKyl0Pa7Sm5EwqjOVxZn+xEtd54oQaqDQ0oaJHsPcQd+dU55D2oBH93GRGRWrky7tqUqFGMkKz9hVwqTdcAIBkRtysZDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306290120
X-Proofpoint-GUID: CKWZj9XbeIf2dNiyj6kom2dgSlYKnF1i
X-Proofpoint-ORIG-GUID: CKWZj9XbeIf2dNiyj6kom2dgSlYKnF1i
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
> method instead of #ifdefs for the attributes in cpu.c.
> 
>   static struct attribute *cpu_root_attrs[] = {
>   #ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
>      &dev_attr_probe.attr,
>      &dev_attr_release.attr,
>   #endif
>      &cpu_attrs[0].attr.attr,
>      &cpu_attrs[1].attr.attr,
>      &cpu_attrs[2].attr.attr,
>      &dev_attr_kernel_max.attr,
>      &dev_attr_offline.attr,
>      &dev_attr_isolated.attr,
>   #ifdef CONFIG_NO_HZ_FULL
>      &dev_attr_nohz_full.attr,
>   #endif
>   #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
>      &dev_attr_modalias.attr,
>   #endif
>      NULL
>   };
> 
> To that end:
>   - the .is_visible() method is implemented, and IS_ENABLED(), rather
>     than #ifdef, is used to determine the visibility of the attribute.
>   - the DEVICE_ATTR() attributes are moved outside of #ifdefs, so that
>     those structs are always present for the cpu_root_attrs[].
>   - the #ifdefs guarding the attributes in the cpu_root_attrs[] are moved
>     to the corresponding callback function; as the callback function must
>     exist now that the attribute is always compiled-in (though not
>     necessarily visible).
> 
> No functionality change intended.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>   drivers/base/cpu.c | 67 ++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 53 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index c1815b9dae68..75fa46a567a1 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -82,13 +82,14 @@ void unregister_cpu(struct cpu *cpu)
>   	per_cpu(cpu_sys_devices, logical_cpu) = NULL;
>   	return;
>   }
> +#endif /* CONFIG_HOTPLUG_CPU */
>   
> -#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
>   static ssize_t cpu_probe_store(struct device *dev,
>   			       struct device_attribute *attr,
>   			       const char *buf,
>   			       size_t count)
>   {
> +#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
>   	ssize_t cnt;
>   	int ret;
>   
> @@ -100,6 +101,9 @@ static ssize_t cpu_probe_store(struct device *dev,
>   
>   	unlock_device_hotplug();
>   	return cnt;
> +#else
> +	return 0;
> +#endif
>   }
>   
>   static ssize_t cpu_release_store(struct device *dev,
> @@ -107,6 +111,7 @@ static ssize_t cpu_release_store(struct device *dev,
>   				 const char *buf,
>   				 size_t count)
>   {
> +#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
>   	ssize_t cnt;
>   	int ret;
>   
> @@ -118,12 +123,13 @@ static ssize_t cpu_release_store(struct device *dev,
>   
>   	unlock_device_hotplug();
>   	return cnt;
> +#else
> +	return 0;
> +#endif
>   }
>   
>   static DEVICE_ATTR(probe, S_IWUSR, NULL, cpu_probe_store);
>   static DEVICE_ATTR(release, S_IWUSR, NULL, cpu_release_store);
> -#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
> -#endif /* CONFIG_HOTPLUG_CPU */
>   
>   #ifdef CONFIG_KEXEC
>   #include <linux/kexec.h>
> @@ -273,14 +279,16 @@ static ssize_t print_cpus_isolated(struct device *dev,
>   }
>   static DEVICE_ATTR(isolated, 0444, print_cpus_isolated, NULL);
>   
> -#ifdef CONFIG_NO_HZ_FULL
>   static ssize_t print_cpus_nohz_full(struct device *dev,
>   				    struct device_attribute *attr, char *buf)
>   {
> +#ifdef CONFIG_NO_HZ_FULL
>   	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
> +#else
> +	return 0;
> +#endif
>   }
>   static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
> -#endif
>   
>   static void cpu_device_release(struct device *dev)
>   {
> @@ -301,12 +309,12 @@ static void cpu_device_release(struct device *dev)
>   	 */
>   }
>   
> -#ifdef CONFIG_GENERIC_CPU_AUTOPROBE
>   static ssize_t print_cpu_modalias(struct device *dev,
>   				  struct device_attribute *attr,
>   				  char *buf)
>   {
>   	int len = 0;
> +#ifdef CONFIG_GENERIC_CPU_AUTOPROBE
>   	u32 i;
>   
>   	len += sysfs_emit_at(buf, len,
> @@ -322,9 +330,11 @@ static ssize_t print_cpu_modalias(struct device *dev,
>   			len += sysfs_emit_at(buf, len, ",%04X", i);
>   		}
>   	len += sysfs_emit_at(buf, len, "\n");
> +#endif
>   	return len;
>   }
>   
> +#ifdef CONFIG_GENERIC_CPU_AUTOPROBE
>   static int cpu_uevent(const struct device *dev, struct kobj_uevent_env *env)
>   {
>   	char *buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
> @@ -451,32 +461,61 @@ struct device *cpu_device_create(struct device *parent, void *drvdata,
>   }
>   EXPORT_SYMBOL_GPL(cpu_device_create);
>   
> -#ifdef CONFIG_GENERIC_CPU_AUTOPROBE
>   static DEVICE_ATTR(modalias, 0444, print_cpu_modalias, NULL);
> -#endif
>   
>   static struct attribute *cpu_root_attrs[] = {
> -#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
>   	&dev_attr_probe.attr,
>   	&dev_attr_release.attr,
> -#endif
>   	&cpu_attrs[0].attr.attr,
>   	&cpu_attrs[1].attr.attr,
>   	&cpu_attrs[2].attr.attr,
>   	&dev_attr_kernel_max.attr,
>   	&dev_attr_offline.attr,
>   	&dev_attr_isolated.attr,
> -#ifdef CONFIG_NO_HZ_FULL
>   	&dev_attr_nohz_full.attr,
> -#endif
> -#ifdef CONFIG_GENERIC_CPU_AUTOPROBE
>   	&dev_attr_modalias.attr,
> -#endif
>   	NULL
>   };
>   
> +static umode_t
> +cpu_root_attr_is_visible(struct kobject *kobj,
> +			       struct attribute *attr, int unused)
> +{
> +	umode_t mode = attr->mode;
> +
> +	if (IS_ENABLED(CONFIG_ARCH_CPU_PROBE_RELEASE)) {
> +		if (attr == &dev_attr_probe.attr)
> +			return mode;
> +		if (attr == &dev_attr_release.attr)
> +			return mode;
> +	}
> +	if (attr == &cpu_attrs[0].attr.attr)
> +		return mode;
> +	if (attr == &cpu_attrs[1].attr.attr)
> +		return mode;
> +	if (attr == &cpu_attrs[2].attr.attr)
> +		return mode;
> +	if (attr == &dev_attr_kernel_max.attr)
> +		return mode;
> +	if (attr == &dev_attr_offline.attr)
> +		return mode;
> +	if (attr == &dev_attr_isolated.attr)
> +		return mode;
> +	if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
> +		if (attr == &dev_attr_nohz_full.attr)
> +			return mode;
> +	}
> +	if (IS_ENABLED(CONFIG_GENERIC_CPU_AUTOPROBE)) {
> +		if (attr == &dev_attr_modalias.attr)
> +			return mode;
> +	}
> +
> +	return 0;
> +}
> +
>   static const struct attribute_group cpu_root_attr_group = {
>   	.attrs = cpu_root_attrs,
> +	.is_visible = cpu_root_attr_is_visible,
>   };
>   
>   static const struct attribute_group *cpu_root_attr_groups[] = {
