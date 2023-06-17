Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9832E73446C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 01:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjFQXAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 19:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjFQXAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 19:00:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8B810FE
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 16:00:11 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35HJekDb015822;
        Sat, 17 Jun 2023 22:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=jAjY5zCDlpeJstRNYa3yE2j2jdsFL/XtTtN8VEbGJ0U=;
 b=CyeE4ctQUx+Yc538CRVDLMyjAvWIc2GE1E4lbhF0dbrJodAypmW8V+oKgyEZelbrnMv9
 ZsNU7l7ZDHPI6+aE36HEf4tNEhy8LTCL/fEx4J6mtlVPzIqpnSQ1Vy7TOyqa+Gt8rkgK
 qutBgq48rGZHTSE/mF+U/UBcEvilqXIKG2u6GnyiiHKbsjNc8rJqW5yQi3pWKtCr4bOd
 UNH3y6de6rvwW1hcYw41X1pxlp699xSrKXdIV5RxlTXgjc/Tsin9pqI57gr/WH3zms88
 JqFyx6fs9ZXpcLNxVUuYcpeHwvStqdNzfsOzISOdj/lLvRXpxGFOGt81BCtrdWRmeW4o Hg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94etgqw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Jun 2023 22:59:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35HI0F30012378;
        Sat, 17 Jun 2023 22:59:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9391n3as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Jun 2023 22:59:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEsTFsl5yRe923nECNuNzDBhMxWsvhuAgQb7kwUgc/zqi+8l7hkwJc7ZGct5TbAFpRGLlrfFb+yjLkkkbNk2mCbw/Z4tIykD2L67EXWYJ34ImkJNAiu8Q7O0BzkJpmDLTQFQZ51LiVCyhqOsvR15YM7LpB+0H1Y3INb9zGCBXVESs+K1sbLCLhTKy9CkA87TTkLHa23UfE+gDneZrRbuQe7cYG1gFZLL6YMVYT20ZZ17p/ZgS6pklMvEA9Q9fX3w1i/BqPMICG7hETmZFOmpLqXON0XO8SOFE3LCzSqzeknFa3/O5x0CCDB9CJm+pB4iFXGKyuvGwta97rrQjdspmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAjY5zCDlpeJstRNYa3yE2j2jdsFL/XtTtN8VEbGJ0U=;
 b=XhA/HPZ0NsQjwRdh0ijZkVZsFJlYrsoAZvzT1SGEuf8V6s5QWbvMx9Tk95XAiYEg+FGzs2BJCMcU2naU0Tyrjzl8j7hLlXnQx0qG+1r7bRzZEchilCLTOUG9pqC2s+8ELBb0TeVw6ITuPhiT7n/TfMpCYIZib9Pj6b4NJVMMv3LN59X5lO48Kth0WLrdQJyKihcgY9knwoXVme51I5bTVejO7Sf8H/9Mq3yld48S2TL1qG+krOTYWWOXrS5U2yp6N69UGuwQ4wInB6KeXFE86bySRdzsbR19IPI/FeHdpnhVzG5z4E9ded/Ci0fIeoqybT+jrgiW7Z3zhteUkS1kmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAjY5zCDlpeJstRNYa3yE2j2jdsFL/XtTtN8VEbGJ0U=;
 b=TeUYwAdqnJ90qrXZlT8ESvt1SgVpgziG+6x5yoH/EEHBPaSrR/T9NVrrLqb2UfzpxcuyidU3YfxJ3THefYLfbFVqcagzv0Cp8lq20EI9sGEbhWuVBX8Xvdc0Y2U/YVfveMRk1Tddd7a/UhyRJU0rfrneo7oN9ZGUxIkBfDcmg8Q=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA1PR10MB6518.namprd10.prod.outlook.com (2603:10b6:806:2b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Sat, 17 Jun
 2023 22:59:30 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6500.031; Sat, 17 Jun 2023
 22:59:30 +0000
Date:   Sat, 17 Jun 2023 15:59:27 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "duenwen@google.com" <duenwen@google.com>,
        "axelrasmussen@google.com" <axelrasmussen@google.com>,
        "jthoughton@google.com" <jthoughton@google.com>
Subject: Re: [PATCH v1 1/3] mm/hwpoison: find subpage in hugetlb HWPOISON list
Message-ID: <20230617225927.GA3540@monkey>
References: <20230519224214.GB3581@monkey>
 <20230522044557.GA845371@hori.linux.bs1.fc.nec.co.jp>
 <CACw3F50rkrWkdMKo7yq35vDbGrcF4b0zohN3dORxL_h0KxZ7Bg@mail.gmail.com>
 <20230523024305.GA920098@hori.linux.bs1.fc.nec.co.jp>
 <CACw3F53C0f_Ph0etD+BgkAz4P8pX3YArjFgSPaLh_d6rUqMUCw@mail.gmail.com>
 <CACw3F52k=fhYpLpvDoVPcmKnOALLkPsGk08PdS_H0+miSYvhEQ@mail.gmail.com>
 <20230612041901.GA3083591@ik1-406-35019.vs.sakura.ne.jp>
 <CACw3F51o1ZFSYZa+XLnk4Wwjy2w_q=Kn+aOQs0=qpfG-ZYDFKg@mail.gmail.com>
 <20230616233447.GB7371@monkey>
 <CACw3F52iG5bqQbvZ9QkkRkVfy+NbSOu9hnkVOt5khukNNG73OQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F52iG5bqQbvZ9QkkRkVfy+NbSOu9hnkVOt5khukNNG73OQ@mail.gmail.com>
X-ClientProxiedBy: MW3PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:303:2b::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA1PR10MB6518:EE_
X-MS-Office365-Filtering-Correlation-Id: f27f15a5-051f-420a-f9e9-08db6f8681fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dcPt9iNpD6aI2mE+2IOXKaJOzUpARwQAt9RNdsM8g//eCl4tKzxp+gQkl7WyPIBL31CcOcQRHR/4vO6GAACk1+6Lse03n3KfMoJjWbHLaV5wG4GpYLwLDR74ofylbsUmbUvZQY6J5KBvTxzHbC6bGAF4dS4310jhG2K391E8HVliSqd4w1Iw+8cHLCaPWPpdnpef5Wtnj9lC3L7zq3vv966PVZmSL9rXUsLkEnjbxZTlkcmXYlrlEuAToR3hUKGo9Bpdd2/wBCPnfNLXxQWQr+M6ohwas16xg7Db2RBdjx02jj4HISDq5Nloh1LBiau/rURqHwMOwR9b+XXGEPisfvJp60hDhvDV8Wif0m/795HcR9E3ZbP+SR4vTV5JWg5OKVeHSIAlcYoSv9nxzk6vmWSLf4suXD+8JsQlgOVowFehB84gLGWOcHquIW57UeIWiKxiYZas2Ul3WAOaCzDdcQ7zryJ9E6qSzqRaEAgw6+dX14O/ruGMbcz9NsIL13GB4HqPSnIgANTg+Fac87FbbaUqFVzWwpI0hMytf6bKw110r6gmRz9+AZ5wZttlsm+/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199021)(83380400001)(26005)(5660300002)(6506007)(53546011)(1076003)(2906002)(186003)(44832011)(7416002)(9686003)(478600001)(6512007)(38100700002)(66556008)(33656002)(316002)(66946007)(66476007)(8936002)(33716001)(6486002)(6666004)(86362001)(6916009)(41300700001)(8676002)(4326008)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU5aM2IrNmZMenhmemJrZVgwcVNIMVNiYTFkSjVzNlNOYkl6OXg5a05OMW96?=
 =?utf-8?B?TkdsTEZ2bm9MYmlOczIwRUJPTjRwNEEvS3N1bGtqd2xnUFBhc1J1WUdzOE5U?=
 =?utf-8?B?MkNtUERWdnlDYlFMd0NhZyswYk1HSDBlNm9TaXRsMzNxUHltSmJKTjhweDBz?=
 =?utf-8?B?S2hYRkVpb1RoSnBtNS9Oa0NKVmhqZ2wwVnNoYmVDN2RtMXJuQTlYWGF3cjZM?=
 =?utf-8?B?LzRwK3BRTTFsVlltRm9ma0lib0dQVktPdUI4Q3ArazNud3BIR0paTFJ6WVhz?=
 =?utf-8?B?RUZtMCt1Q3NTbXI2NjE5d0dueCtiaFVhQ2x6MXVDZ01reU1TU0ZLZ2ZGZTh2?=
 =?utf-8?B?NUJiY3dxNEpOOElQUzk4QWlic0dsTnZVKzEwWHFWaFo2ay9mNDNuMEhPYVpl?=
 =?utf-8?B?ZVc1RVZVTkNVTHFRUERhQUxjYWtrYlExbnVuVmVublR6cVAwWnpxN1hWNzBN?=
 =?utf-8?B?aVlpOGFSM2V1VWhuNDlxZm8yejNFYVR1Q3ZtNHdzd1FFWVpxS0d1Sy9zeGVB?=
 =?utf-8?B?bk5PNjg2cE9DZVFjcjVWMGQrNFlIMU1nR1hSN0V1QWkwTGFLQytNWnpkSFY4?=
 =?utf-8?B?VW52bmNNRTVqNEE2ZUpkdXZkY3NkOUFLZTAwcFRuekxEUUhrY21PS3BkeWRj?=
 =?utf-8?B?dTI0dWp3cmFVWlBHSnRSc05YdFRKUGVoakFyeHBPb2lJWnNEK3R6Wmx0aXdz?=
 =?utf-8?B?SDk3cEUyRXRMTzlZenlFQ1lCTU41TEFjWllyQ3d0N0dOYm9IbVRFRENnakh4?=
 =?utf-8?B?cFBUSllXMGdCTERhUzhsR0l5aTFib3pRTnV5UmVTeXpQZmpmYzhsV09UTWJV?=
 =?utf-8?B?dktQWGhvcXZCa3M5VVhlTkZlNHdUZHBzVncrQnBHSWRyVkZuNkVsdk9jUUEy?=
 =?utf-8?B?amRtajU1anlIZi93ZkhGbXBtbm5UMkwrakh4QVVjV1F0RG5uSHVWcWNtdHpO?=
 =?utf-8?B?T2V1bmJlVHFoWXY4b2tJV2MwdUVXUGRuL1c0RENKQTFLL2VNM0F4bXFCd29j?=
 =?utf-8?B?NGp3RzV2MG1UenhMRW15VmUyK05rSzQ3MG9WZzQ4RVJJTVgrbDkxa0o4QmUz?=
 =?utf-8?B?bXFUdWJDVHZSVzRUc0lGR2RwaERmWVNYZzZ6NGlnVWZhdlphTjN2a2U4cE1H?=
 =?utf-8?B?RXY1dWY0MHJhSVltVjl4RUhScHBWU3ZFcWRkMkx4SkdBVG1lTEI1QUZXL2k2?=
 =?utf-8?B?MC94RlA1cE1lV0EyVjArUDFMVnpqdUFKQmMxQnZDMktPcjJRL05SUFBvUTc3?=
 =?utf-8?B?TTNMOUhHOGlCc2ZqWkRZcVEwUnMxd1VneDQyQVpnRk5GSjVpcDlLMlpUejFJ?=
 =?utf-8?B?Q3FQdVNMWW1GRFpiRWRZS0xaSzVCbGhVdlo0bnE0SWc1bXpRbmhyd2ZxSGFN?=
 =?utf-8?B?Mmd2SWZyZjdrekRHeEFtbTlxNHVvT3hVa0JsN1NEV3A3M1VBd05YV1dTeFRZ?=
 =?utf-8?B?NGFKbGI4K0ZVVEZZWW1PdkdwTDd4VndySldodFpCRytHZTBhOWtpYWdEeVJi?=
 =?utf-8?B?clc0N2RYMDdOUnNjUzR1NE54bHk2NEZEMm4xQVJBblZycytCVkNHc3hNdGE0?=
 =?utf-8?B?TEdnMCtqbzRBUUErUW1VRlJXb0hqNnBCaHZQck5lanVkMVgrWDZsOEFvc1Jj?=
 =?utf-8?B?SUQ2aXNUNmZJZE5jeVNMQVZZWmgxMEw2bDlVL0VvZ0J0MkRZL05YWUszSmRq?=
 =?utf-8?B?V3QwYStIZlhLSnIzUFVDVW50TmRmYjRmcEFnYUc3Z01RdWZDQ3dLWUw3UUN0?=
 =?utf-8?B?aXJJbFZDclhaalNKc1Z3NkxublljTFFpdnREZmQ3YTR1WnZFOERaaTNDdWp0?=
 =?utf-8?B?UEgvVTVUaHdiSjdPTDVtWndMd2NXbENKTFNXM0FDZjVUZVRKcXRZKzFlNGtF?=
 =?utf-8?B?Y1gyLzZsMFkxN2ppdzE5aFNBTFp5aXhiUWNrcGZNS3ZQQlN2KzVDcXBzcVZ2?=
 =?utf-8?B?Y1M3SS9HREx2YU1SYVF4elVweG1idDFTVkNxMWxnc0ZYOUJ4NEV5eElUa2F4?=
 =?utf-8?B?RDl1aGQ3RjZFcjl0V0VtQ1dQNmQ5TzhqbktGWEg1NkZhTWpuQ1hLUkZWR21i?=
 =?utf-8?B?ZWFCMTJGUElxajJyaUd2T3RlTE1FQXlkZ0xZSUkrQjZqMEorS0RqTGszTDhO?=
 =?utf-8?Q?c8kTeRaYOtkdkrDH9kazZaKT2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ckdma1ZXb25SUUFQcFdKYzRKd2tiYUFOL2ZqWFZKemFiRFl0K1g0OFZVdG1J?=
 =?utf-8?B?TjVnSzdaaUFkOE9JV29sRFlkUmVRQUhNKzJZbmxjcExxSEsvR1gwMXZDWGdV?=
 =?utf-8?B?MEZFWGZiUlNUdVRrUGR6VzUxQnlMV2o0bjlnQWpENFZ5L1VBbFpYd3IwdE1C?=
 =?utf-8?B?bndEcmZ3OEE3bEc4ZmduNmZsNkhpNWRGVTBkN3FvbXZDYUxmQTJGajk5dHh4?=
 =?utf-8?B?TU1Tc2U4OVM5ZU5LR2t3OGwrVzNBZWxYbzF0WDlaVTJxbWE5YlNHQkkvcDAz?=
 =?utf-8?B?dWw0RXlyYUgyYnExbVFTbUExdDVvZkpxYlUvc2E4VCtpMU8vQmN4Q3djRUVN?=
 =?utf-8?B?WCtkRnBNWWRoSUpzOHI2UWFXQTJaWGlpbWlmTXNUKzIrdXZhYzdGUmgvVE03?=
 =?utf-8?B?TkYrQnBWaldTMHZQZHhWVFE4cW80a1AzdTc0dmpIdlZiRC9zWTRZcGh1djkw?=
 =?utf-8?B?Q2gzcldZQ1ZUbCthRGlXMGZRMXVybFU4RGxyVERkTHBwOGpnV2F1a2l5cEN2?=
 =?utf-8?B?b0hZWDVHbzZ5dHl2VnJNQlQ3UnI4TW14ekk4UDE0ZmZRcFJpdnlVZU9mR2FV?=
 =?utf-8?B?UW4zUlBFaDVtVVdXbDBGWnRGTlk3ZTEyS29haUp3UVVsR0pwemhISTRJQmVx?=
 =?utf-8?B?WlVEeXlHdUMvMkZ2NWhwb1JBQUxCcW9BcXFDdFA0aVMxaVFpaXpBUDM5Vktx?=
 =?utf-8?B?U0pMVzZNc3ZzN2VScEtYc3o3bzJSd09kM3JRVGI4dUJBMzV6RTV0ZnFXcWF4?=
 =?utf-8?B?alh4Z2NKZCt3N0FUYlAzRVNXSmRJWHNyNklDU0NNUENaa2ZHeGNkbnFLQjFN?=
 =?utf-8?B?cldiY2ZuS01wWkFCd3ZDRGtLa1VvMkxsdzhWTm81SjFtY1RnTWVQTEJSbnFM?=
 =?utf-8?B?elE3MEZHVXUrSk5ic1EyZXBURTNUc0k2Y2pHN3dDMzRId2M5ZzlGWkpGSkRi?=
 =?utf-8?B?TzdZK2N6MmltS2ZreGQrQ3dlQStyc0NsNXlCUzFJY043aVFHZVYrQTRxd0hz?=
 =?utf-8?B?b01kVTdqenAwMjB5Ukt1RVZpWkZMbURySi9acTdqVEZ4UnpqUSt0TW8ybmVp?=
 =?utf-8?B?T0NrdjVOQm9ibDZPTEx0SWtIUCtIT1NLQU5ORnoySi9JQXhyZEIvSHYyY0RE?=
 =?utf-8?B?VG52ZGpReEthalMrRVJLdXJ3R2tUcGU5WDJpb2tOZWpqL2FSaWlPS1pxN1ZO?=
 =?utf-8?B?VEdlK3hnYVltVnZ6bUY0cEFLcGhBb2IvTHhpYnMxY0lubVVSQzF0c3JXc3lq?=
 =?utf-8?B?VzVIdjhNaTIrWkg5MndEOEN3d0lFTlBkSU1IR0p2ckZKZkdETzJRYkM5K3BI?=
 =?utf-8?B?RTNKRlJoKzdRSUg3SEhYblprSGFwZGVsY3lDWlc1d0FSam1vU0ZHUGdCcHJp?=
 =?utf-8?B?c3Bpa2tkMXBMTmc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27f15a5-051f-420a-f9e9-08db6f8681fd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2023 22:59:30.3029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgEHfQTOZh7h6M4k3CgsGXejhiRZ0UnNajhXJoLXeBir/Yi8szQ1mVpI7jtZasJLVWMPAf6JAogsM9ZJdwyjwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6518
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-17_17,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=840
 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306170215
X-Proofpoint-GUID: NXkgd6zz0sAa4IxmsoWOkWiW09W28KWI
X-Proofpoint-ORIG-GUID: NXkgd6zz0sAa4IxmsoWOkWiW09W28KWI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/16/23 19:18, Jiaqi Yan wrote:
> On Fri, Jun 16, 2023 at 4:35 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > On 06/16/23 14:19, Jiaqi Yan wrote:
> > >
> > > Now looking again this, I think concurrent adding and deleting are
> > > fine with each other and with themselves, because raw_hwp_list is
> > > lock-less llist.
> >
> > Correct.
> >
> > > As for synchronizing traversal with adding and deleting, I wonder is
> > > it a good idea to make __update_and_free_hugetlb_folio hold
> > > hugetlb_lock before it folio_clear_hugetlb_hwpoison(which traverse +
> > > delete raw_hwp_list)? In hugetlb, get_huge_page_for_hwpoison already
> > > takes hugetlb_lock; it seems to me __update_and_free_hugetlb_folio is
> > > missing the lock.
> >
> > I do not think the lock is needed.  However, while looking more closely
> > at this I think I discovered another issue.
> > This is VERY subtle.
> > Perhaps Naoya can help verify if my reasoning below is correct.
> >
> > In __update_and_free_hugetlb_folio we are not operating on a hugetlb page.
> > Why is this?
> > Before calling update_and_free_hugetlb_folio we call remove_hugetlb_folio.
> > The purpose of remove_hugetlb_folio is to remove the huge page from the
> > list AND compound page destructor indicating this is a hugetlb page is changed.
> > This is all done while holding the hugetlb lock.  So, the test for
> > folio_test_hugetlb(folio) is false.
> >
> > We have technically a compound non-hugetlb page with a non-null raw_hwp_list.
> >
> > Important note: at this time we have not reallocated vmemmap pages if
> > hugetlb page was vmemmap optimized.  That is done later in
> > __update_and_free_hugetlb_folio.
> 
> 
> >
> > The 'good news' is that after this point get_huge_page_for_hwpoison will
> > not recognize this as a hugetlb page, so nothing will be added to the
> > list.  There is no need to worry about entries being added to the list
> > during traversal.
> >
> > The 'bad news' is that if we get a memory error at this time we will
> > treat it as a memory error on a regular compound page.  So,
> > TestSetPageHWPoison(p) in memory_failure() may try to write a read only
> > struct page. :(
> 
> At least I think this is an issue.
> 
> Would it help if dissolve_free_huge_page doesn't unlock hugetlb_lock
> until update_and_free_hugetlb_folio is done, or basically until
> dissolve_free_huge_page is done?

Unfortunately, update_and_free_hugetlb_folio is designed to be called
without locks held.  This is because we can not hold any locks while
allocating vmemmap pages.

I'll try to think of some way to restructure the code.  IIUC, this is a
potential general issue, not just isolated to memory error handling.
-- 
Mike Kravetz

> 
> TestSetPageHWPoison in memory_failure is called after
> try_memory_failure_hugetlb, and folio_test_hugetlb is tested within
> __get_huge_page_for_hwpoison, which is wrapped by the hugetlb_lock. So
> by the time dissolve_free_huge_page returns, subpages already go
> through hugetlb_vmemmap_restore and __destroy_compound_gigantic_folio
> and become non-compound raw pages (folios). Now
> folio_test_hugetlb(p)=false will be correct for memory_failure, and it
> can recover p as a dissolved non-hugetlb page.
