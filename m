Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C080722916
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbjFEOpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjFEOpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:45:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E699E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:45:15 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355BJYfM012439;
        Mon, 5 Jun 2023 14:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=iXaSLygp8IT1Bb/hlQGd5vCIrgVPB1ZOjTA9pkwVDxo=;
 b=VRb9oYooEQsYPmV4XUQtHXW89fsykK1zmopravS33s9YQA/xMclX9UIxHwGd5MrGp76g
 faC9L7wmr8VwoAIyNRZLgtt4dzpF7h0lKt9SS+3ed+CZfi/PZc3qhauoLZZ3NvU9DIZL
 NKtjyOKSRt8MCpTJQA+9WPrFfRRpO7gPoaBZW/AekWU7RhKGHLyMoNj0Z1s/FTGNO7hB
 5f43Gnhy0nUas24mMvpbFeaNJY6KH75CyuN5Q2UKEyO1MLiYyrcmr7KuX0ci3EefkpTE
 tB2f5D/8nu86dmtv3RZ+fYH0MoeZ9+1SRKxNNxP/NuGZj104fYtAlXNKdiCq2aDqi3WK 1w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyx2c36hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jun 2023 14:44:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 355DlBYd011477;
        Mon, 5 Jun 2023 14:44:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r0tjy2w4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jun 2023 14:44:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvhoVAIWb7M8RPdBWIoQ4zGoB04d1UgeDGdq9QuT4IwstB7EkyyWF9AogsSkzpNuXUYNLPPxLs05aupi4iqzm/kRFg8Nlrrfmt4+adhzu/AUArVNRx30UrYo6FqPdQG3/BmvcHlDjTBrYBQVl/nQ4YMUM8lTPNdXL2ff568Be2g6aRwlf8FzfmkkeYPL1OLnqRBXH2G/LAIi3FEqWE6AhaX2C+lJtVX0a+3t8GRubjXjCKFaHDi9DCEoC3fROUpZiCegtj/aCXfi3a2yACYKOOPQ6beow3xlK84tf7Z6DZBgc38SfnJpDieH+d/sfoGcBU7KNkZFO1gu4827Iw8Q1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXaSLygp8IT1Bb/hlQGd5vCIrgVPB1ZOjTA9pkwVDxo=;
 b=aztkUWfH5vWPf3oWuwSFEmF6j1bCC0zC2+2hx/PO2ymROGZ4ovbYGSN2lRMGd0KQzpWeJxUigb0riwXw1Z3UT1gb5NO3xUuNOUKnpyShlX4tAiJn1d68sMdTJjE7rx2LYp/qwd8fwBsJqjXzVxL+dsn/pP9FT1QPoWeBBL7KY/J8ZFGHRCr3q9GrAheHFqAidtuNeyY7+SxWFtFs9Dw09nKdRKk+pv4xBASXBrwLLGSPi8w1MXuMMuuF4JAGuNI0s02jZA5ShI3XLgKb1RV8ecMZVk9vHLwj1wZDxkNOCDs8lx404MppMYjvm9tP3h6ozhaH5tzCLzKMv/6uZ78bXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXaSLygp8IT1Bb/hlQGd5vCIrgVPB1ZOjTA9pkwVDxo=;
 b=G2nTDuwI0kCIyAp5WgnhxPksAIvfFD5mwuCk1pR2P8xrRUtffymtJEF3rCDP3Z0qyYP+b1Hgy4WpDEEezDq2L6Oh4k8Nx+SqFQrtrBV/sXJpx2j+oeKJVoCKRptjC4Sg91azVBk6BQNNL8xD/Jc9br2boOJa06qv98cuQHGwxPw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6956.namprd10.prod.outlook.com (2603:10b6:806:34a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 14:44:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 14:44:41 +0000
Date:   Mon, 5 Jun 2023 10:44:38 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Liu, Yujie" <yujie.liu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 00/14] Reduce preallocations for maple tree
Message-ID: <20230605144438.rloukl3mccgkfxam@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Liu, Yujie" <yujie.liu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
 <7a5dc9ce-b58f-e1b3-db1a-d00a8a556ae5@intel.com>
 <fad3c833-1ab3-2d34-aa85-dcc7c40c3587@bytedance.com>
 <a9d2ab1b-23a5-8c06-9f7a-6872c726db03@intel.com>
 <b5f2d527-8887-eb0b-d3f2-4e7cd8f3c022@intel.com>
 <4fb5f66d-c8c2-f857-7461-b974154dbc2b@bytedance.com>
 <20230605140344.66pwpdg5zgb6rfa7@revolver>
 <8f9ed046-529f-073f-5c1a-4c69328b2519@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8f9ed046-529f-073f-5c1a-4c69328b2519@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0056.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1cd5be-78f2-47cf-cfef-08db65d3652b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hGQPEIj0jVBLDRA0RxfK8CD4LzA+dYsnQnvG3co1d0yRNtkBuLYRveuEeLE4jWWDz4pABHwyQDg+xlpgFptZ5QNAtaYVx4jlhFZaMOFDliL3GCwg8ZR7L7Odk3rD1FexltKF/ENwrrAgAQXiSxewemfKuIv6AzqnO7T84clfzAHekkfClV0cFlKlq8wN5CGM7yPUcc6oStLSuGqRMleiKgVe8uOR78nyV4okcQ+N8UwGKNYTkk9f2Dk92ddQugt5srq+cGSuJFo17KjavABRIJhA+0HAEdO7XY11O2d155ccV3VavHd5kBwU0QerRIn0PQUcuZAdSpCqjHaN08sFBwHYwOcV8Kdvdq9Gr+4rYnRjqjPgP7SRGewo/cnsJdKAWZVWTfmaXQXKmGZHkifvMEcdNsA6k1vbhF84b1BHAju0IYtkyR54+joxbWjzwLqz75IyIVAOsmYKwfRwCocW8hsUBxY03zTuoTdcCZc5HbIA0yBzS1/thlaEj7esYDQqYu3sXYgEvzTcomyBrsD76wWnz6PSVfCY9J4qTk0bX8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(83380400001)(2906002)(86362001)(33716001)(38100700002)(966005)(6486002)(316002)(41300700001)(6666004)(5660300002)(8936002)(8676002)(54906003)(478600001)(66556008)(66946007)(66476007)(6916009)(4326008)(6506007)(9686003)(53546011)(6512007)(26005)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjJQcVRxQktrQ0I3eU8vMzFtNmVscWNFd2l6QTJTczlWMVpJNVVQWklnSlc2?=
 =?utf-8?B?RXFaZG8xMmZlcmZDOGttUHRNV0lhOWo0eWVNMy9MVHpnN3NHZ20wNEgvVUNR?=
 =?utf-8?B?WEgyaTByd3NLZVh4Q1gzeU9mdUlBbThOakc0cU1wbzVQVHdRQ0sxNzBYNncr?=
 =?utf-8?B?anNkejNCUjQvWFlQN2RyNTVMbVZLRGhjSHFkVmkxa2VLQWhmdlNkenJUOUVB?=
 =?utf-8?B?Y0xZRzYxQVBwWHZtVUNQc0VFc1d3SDVmS1VkSUdWbndVeHB0R09ubnNSN2NU?=
 =?utf-8?B?Y2lKV2l0L2VFUGhqWms3Zzd0d3ZqcnVhZk5lTGxTNmxVdXNiSWNCbEp2S1FK?=
 =?utf-8?B?VEVuVW5idDVMNndYZ3pnZ1hnQ0JJVDlubFgydThLWHJ0QkE2blc3WWh0RDVo?=
 =?utf-8?B?WHoyODdYUHhuYjFaTUJKbDNXWHNqZ2RhSytpS29CcnA4VDhFYnY2SzZRS1h0?=
 =?utf-8?B?MVNIQ05xSUFSQ3ZmR0lwMzZLVVNxeFhUekdzOVVBMmY4ckI1VXJ6QXN5dE9R?=
 =?utf-8?B?MEUvSDMwdDgrYll1NldIelBVTkoyTEZId3pLem14Uk5HNmU5UlQ4K2M2dDVQ?=
 =?utf-8?B?Qzk1MDFjWERtUlhETGhaU0g1Q3gzKzAyTjJtZ083OXl3cmRHbVBwLzhkQjY2?=
 =?utf-8?B?RkNPZjBsYUpFSVg0NG9EajNaUDRCMXFZTUY5ODJJeERrOWdmRGh1M0xkd2hG?=
 =?utf-8?B?aFE0T05zd1ZvZVRrMlNrV3RWOE1Cd3lUenVkQmdIb05hVnFsMk9UTVlESFg4?=
 =?utf-8?B?ZEdROTAvNG5jQXM5dTdJVlBnRStWV2NzL0F1VmcwZ0xzb25jVE5QUTRVL0or?=
 =?utf-8?B?TVNlaCtiREMyNHpuUjNsTHJCQmpMamozNWVNZUhqS2VrMnJ6TGFqZ2poRnYx?=
 =?utf-8?B?NTc4aFRmKzZzZ1gxMFBQNTNYZVk5Vlk5S0txVnJNK21Wa1Q3YW91RnJlNFlw?=
 =?utf-8?B?eTRGN3pPaURqb1YydG4rZGVLSXRDa3BtYlF3OUwwU2FEMVhVdUpEWlpnaUJ2?=
 =?utf-8?B?d0JWK0EzdmF4Y1ZVSnVkSEUxK1FScWs3MEgwZnozQS93YnVUZ3B0Vi9DNlp3?=
 =?utf-8?B?RWdmOHZJcGxsUW0rV0V6T00zdG1uMVRuaWlOTEVNV0szT3VjUXhtWTdzOUtr?=
 =?utf-8?B?WWRUZTViNHAvL0N6UTFUaUhoTjFWU1FRQ0pkNjBad0d0OE42RVRDTU1NZGZa?=
 =?utf-8?B?TDlHdmtNQmRvM2QvMUVGQ2t0UklZZGUxVmlhL0pTV0JBbDNOS0grWG5zVDcy?=
 =?utf-8?B?RHQ3QmQ1R3FCN2dWeXVkd2pQVXBJRnRLd0F5OVgvbEZZTkhGV1o2SHZ4Q2w1?=
 =?utf-8?B?cmt3NE5Ia1VscHh5R2ZjQ2E2cmg3ZW11KzIyUEhGSUNtVUNSSDBvTGtFdmZC?=
 =?utf-8?B?TTdRUk1VU25OMkZUNTMweHQ3TzBWN1pPeCtNK2dCb01UMEttS0ZuRm1MQlVI?=
 =?utf-8?B?T2pHSWJmaTdCRU9ZdzBIMDA1WUZMVmlnV25TN3d2MDRPT1dzeXQ0RUgybW5l?=
 =?utf-8?B?bnZRNW9CYTBTb2NMd1ZtUHBqV1VhRjFtVzBrQklQSUxNVlF6YlQ3Ty9yQXFZ?=
 =?utf-8?B?elEzV0YzaGVtc1M5Mis1U09TODRoczAvQjBxc2U0aFJrdHQ1UmNoSC9zZnRG?=
 =?utf-8?B?UW9Cd0JBQmdtekl6QTAwRXlGcFc4aytwNmxhdTIvYk5DekE3bEdYSktnTGs1?=
 =?utf-8?B?QnByUUp5d1BzQ2xvd0k0S2FjbWZMdG9vbVRqaStnNTBvSjBWYVdONWV3cHVp?=
 =?utf-8?B?cWZKSHFMUnpnZCtVQVQzOVVzY0R0NktHZVRlUzcyd3dZZnpqYUVPTnJTbEw0?=
 =?utf-8?B?MDU1bkViL1lqeUVkdmtSM0dnMExOMlgvaTZ0L2hoN3RTeE9KT1J5S3B1L0Nh?=
 =?utf-8?B?WHVWMUZVMzBnT3dGZFZsVUt3Tk5MdUNqeEpORGJwUTd1UVZ3ejk5VDg1RS80?=
 =?utf-8?B?MllvcnpnOCs5RlZqWE9vc1pwZ3BPc2JRaVlTcWJVNCtxdTVtQk0zRnJKNWNp?=
 =?utf-8?B?cXByaHRlaUVwbE9jeDBUZW9kNW9NMXJxMWtQK3hqdFpHb3JUVmU2bnhhTEZk?=
 =?utf-8?B?cnpyeTlDZXpJQldWN1R5MXVoY0NXZ3JVODhScEdGaEwrWTZZRlFDdXh2RFZk?=
 =?utf-8?B?M2JPa0hST0pXcnlqRzRxRmhhczlJVkZyUkwvVkl0ampLdzBTNVM4N2VlVlF0?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TkwrMU9pa2l3aXNwcHhBeXdVSFNFanczVDRQdFNIbndqOHBtYTBBeW5iNkJT?=
 =?utf-8?B?TjVYUWpSWHovUnZESndrSkVCUkkvSVZEZVFZQWhmNlI4czB3WmZFMi9nVzcw?=
 =?utf-8?B?Y0loRHNEM1dXL24zWjdRRjNaUVcrQmp5ekZqeWNLU0VBKzFKUkE3cVlqOEZl?=
 =?utf-8?B?ZDhIRU5wdVNEKzdSVGFUSFZaeFpUUkRpUjRtVmNPSjJJcE1KL1ovY3NHWXVM?=
 =?utf-8?B?Rk05TVhJZWF1V2Q4enN6cVQ4ZDgyaUlySS9CTkp4ZXRXVC9YUjZSNlpDNjhO?=
 =?utf-8?B?QVdnRVh5RnA1Q3g5TVJYZW5BVlVqNlRiUUEwWUE4NVEvekNjbUFqTTBvZXZD?=
 =?utf-8?B?M1FhbHBYZEd5a3J5UlBpazlxQ2FSdndOM2tINk9Nc2tsd1JYQW1HeHp3K1hM?=
 =?utf-8?B?THdoT2s5TFNTdDAxWTZSY3FJVU9LcXNybGNHSmFrUVZrQkN3bElXeTFXZHIv?=
 =?utf-8?B?RWFNbUZwNzF6YTYreFQxOUcvWGRzSitROGN4YXoxbUJlZ0FZenpYMVVXYSs5?=
 =?utf-8?B?YU1hU0Q2elZDZWZNd3RiYkRtTXdSb2tRRnAwYVJlV3hYcUZDVnRWNGZYMXAv?=
 =?utf-8?B?NTA3U01tUmpIZFFQSkpBWURFb210MkZUbHFGejdnUlJQRzJCRENya28yQ3d3?=
 =?utf-8?B?Q05hYlJNQ2t3M3AzTzFBYVhFRHQyU29TdlI1TkZzRUdRSDNyK0JobU4wQk9G?=
 =?utf-8?B?anl4OHB6N2dkRit2RDZBcERMWWVqejJsYmRtRmFyTEk5bTBvTkpIMjJrcGIv?=
 =?utf-8?B?NS9maGZvNkdaQzRMUlE3Tk1YakdFc1pkUFc5bENNVW5xTVEwMk9VMVREa2M3?=
 =?utf-8?B?UXNEc3lYaDJtQ0tmV01vcG5MNnMzaVUwVGtTNkxvcDRFLzRBY29aRnNWdFAr?=
 =?utf-8?B?bFVBYmM0TVMySzlSRG9OUENBVW5JUDZIc0lSQlA4NDVNYVVIcnFncnRMZmc2?=
 =?utf-8?B?Um1ZQm9aYUx5Vjdzb3R3dTFZVGlvWW82Rnd4TnpFbGpkTWgySGxydFdEelhS?=
 =?utf-8?B?UWtvSStuQlhRcDhvUEVSSWZwTStKcGkzdUdpOHB6a1drOUc2OXdMNkFPMVRO?=
 =?utf-8?B?RHFLcXZBdkxpRGR0SFEvdm95NHdsbE8wUU9pT0Uza1liLzVwME1aczU4TElH?=
 =?utf-8?B?WU5Kdms5Nyt5RjF3d1pNSGdqU0lpQU4xT083T3pLK1FXVVhSRXRhWlY1YnZC?=
 =?utf-8?B?N01XSjNRMWdHaVR6VGRta1NTZllSeGxIUnM3SnZRTHo0QmpnKzhRNURRZzJn?=
 =?utf-8?B?S2FoOFRLQmh3akQwK25pcG1veCtNNjFsY0IxN3FzejBpelRkUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1cd5be-78f2-47cf-cfef-08db65d3652b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 14:44:41.4528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKYfek0KEY0R9J8QLDdVib56MeRkI6d5QABz/Zu9doOdlQn040Yc2vit6XBEz32WMVO9I7JT2OXxI7PWM9AXIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6956
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_30,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306050127
X-Proofpoint-ORIG-GUID: vrsHfq-wNOULqHjD8BTNwVxrWqJ0nO4M
X-Proofpoint-GUID: vrsHfq-wNOULqHjD8BTNwVxrWqJ0nO4M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230605 10:27]:
>=20
>=20
> =E5=9C=A8 2023/6/5 22:03, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230605 03:59]:
> > >=20
> > >=20
> > > =E5=9C=A8 2023/6/5 14:18, Yin, Fengwei =E5=86=99=E9=81=93:
> > > >=20
> > > >=20
> > > > On 6/5/2023 12:41 PM, Yin Fengwei wrote:
> > > > > Hi Peng,
> > > > >=20
> > > > > On 6/5/23 11:28, Peng Zhang wrote:
> > > > > >=20
> > > > > >=20
> > > > > > =E5=9C=A8 2023/6/2 16:10, Yin, Fengwei =E5=86=99=E9=81=93:
> > > > > > > Hi Liam,
> > > > > > >=20
> > > > > > > On 6/1/2023 10:15 AM, Liam R. Howlett wrote:
> > > > > > > > Initial work on preallocations showed no regression in perf=
ormance
> > > > > > > > during testing, but recently some users (both on [1] and of=
f [android]
> > > > > > > > list) have reported that preallocating the worst-case numbe=
r of nodes
> > > > > > > > has caused some slow down.=C2=A0 This patch set addresses t=
he number of
> > > > > > > > allocations in a few ways.
> > > > > > > >=20
> > > > > > > > During munmap() most munmap() operations will remove a sing=
le VMA, so
> > > > > > > > leverage the fact that the maple tree can place a single po=
inter at
> > > > > > > > range 0 - 0 without allocating.=C2=A0 This is done by chang=
ing the index in
> > > > > > > > the 'sidetree'.
> > > > > > > >=20
> > > > > > > > Re-introduce the entry argument to mas_preallocate() so tha=
t a more
> > > > > > > > intelligent guess of the node count can be made.
> > > > > > > >=20
> > > > > > > > Patches are in the following order:
> > > > > > > > 0001-0002: Testing framework for benchmarking some operatio=
ns
> > > > > > > > 0003-0004: Reduction of maple node allocation in sidetree
> > > > > > > > 0005:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Small cleanup of do_vmi=
_align_munmap()
> > > > > > > > 0006-0013: mas_preallocate() calculation change
> > > > > > > > 0014:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Change the vma iterator=
 order
> > > > > > > I did run The AIM:page_test on an IceLake 48C/96T + 192G RAM =
platform with
> > > > > > > this patchset.
> > > > > > >=20
> > > > > > > The result has a little bit improvement:
> > > > > > > Base (next-20230602):
> > > > > > >   =C2=A0=C2=A0 503880
> > > > > > > Base with this patchset:
> > > > > > >   =C2=A0=C2=A0 519501
> > > > > > >=20
> > > > > > > But they are far from the none-regression result (commit 7be1=
c1a3c7b1):
> > > > > > >   =C2=A0=C2=A0 718080
> > > > > > >=20
> > > > > > >=20
> > > > > > > Some other information I collected:
> > > > > > > With Base, the mas_alloc_nodes are always hit with request: 7=
.
> > > > > > > With this patchset, the request are 1 or 5.
> > > > > > >=20
> > > > > > > I suppose this is the reason for improvement from 503880 to 5=
19501.
> > > > > > >=20
> > > > > > > With commit 7be1c1a3c7b1, mas_store_gfp() in do_brk_flags nev=
er triggered
> > > > > > > mas_alloc_nodes() call. Thanks.
> > > > > > Hi Fengwei,
> > > > > >=20
> > > > > > I think it may be related to the inaccurate number of nodes all=
ocated
> > > > > > in the pre-allocation. I slightly modified the pre-allocation i=
n this
> > > > > > patchset, but I don't know if it works. It would be great if yo=
u could
> > > > > > help test it, and help pinpoint the cause. Below is the diff, w=
hich can
> > > > > > be applied based on this pachset.
> > > > > I tried the patch, it could eliminate the call of mas_alloc_nodes=
() during
> > > > > the test. But the result of benchmark got a little bit improvemen=
t:
> > > > >     529040
> > > > >=20
> > > > > But it's still much less than none-regression result. I will also=
 double
> > > > > confirm the none-regression result.
> > > > Just noticed that the commit f5715584af95 make validate_mm() two im=
plementation
> > > > based on CONFIG_DEBUG_VM instead of CONFIG_DEBUG_VM_MAPPLE_TREE). I=
 have
> > > > CONFIG_DEBUG_VM but not CONFIG_DEBUG_VM_MAPPLE_TREE defined. So it'=
s not an
> > > > apple to apple.
> >=20
> > You mean "mm: update validate_mm() to use vma iterator" here I guess.  =
I
> > have it as a different commit id in my branch.
> >=20
> > I 'restored' some of the checking because I was able to work around not
> > having the mt_dump() definition with the vma iterator.  I'm now
> > wondering how wide spread CONFIG_DEBUG_VM is used and if I should not
> > have added these extra checks.
> >=20
> > > >=20
> > > >=20
> > > > I disable CONFIG_DEBUG_VM and re-run the test and got:
> > > > Before preallocation change (7be1c1a3c7b1):
> > > >       770100
> > > > After preallocation change (28c5609fb236):
> > > >       680000
> > > > With liam's fix:
> > > >       702100
> > > > plus Peng's fix:
> > > >       725900
> > > Thank you for your test, now it seems that the performance
> > > regression is not so much.
> >=20
> > We are also too strict on the reset during mas_store_prealloc() checkin=
g
> > for a spanning write.  I have a fix for this for v2 of the patch set,
> > although I suspect it will not make a huge difference.
> >=20
> > > >=20
> > > >=20
> > > > Regards
> > > > Yin, Fengwei
> > > >=20
> > > > >=20
> > > > >=20
> > > > > Regards
> > > > > Yin, Fengwei
> > > > >=20
> > > > > >=20
> > > > > > Thanks,
> > > > > > Peng
> > > > > >=20
> > > > > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > > > > index 5ea211c3f186..e67bf2744384 100644
> > > > > > --- a/lib/maple_tree.c
> > > > > > +++ b/lib/maple_tree.c
> > > > > > @@ -5575,9 +5575,11 @@ int mas_preallocate(struct ma_state *mas=
, void *entry, gfp_t gfp)
> > > > > >   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto ask_now=
;
> > > > > >   =C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > >=20
> > > > > > -=C2=A0=C2=A0=C2=A0 /* New root needs a singe node */
> > > > > > -=C2=A0=C2=A0=C2=A0 if (unlikely(mte_is_root(mas->node)))
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto ask_now;
> >=20
> > Why did you drop this?  If we are creating a new root we will only need
> > one node.
> The code below handles the root case perfectly,
> we don't need additional checks.
> 	if (node_size  - 1 <=3D mt_min_slots[wr_mas.type])
> 		request =3D mas_mt_height(mas) * 2 - 1;

Unless we have the minimum for a node, in which case we will fall
through and ask for one node.  This works and is rare enough so I'll
drop it.  Thanks.

> >=20
> > > > > > +=C2=A0=C2=A0=C2=A0 if ((node_size =3D=3D wr_mas.node_end + 1 &=
&
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mas->offset =
=3D=3D wr_mas.node_end) ||
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (node_size =3D=3D w=
r_mas.node_end &&
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wr_mas.offset=
_end - mas->offset =3D=3D 1))
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> >=20
> > I will add this to v2 as well, or something similar.
> >=20
> > > > > >=20
> > > > > >   =C2=A0=C2=A0=C2=A0=C2=A0 /* Potential spanning rebalance coll=
apsing a node, use worst-case */
> > > > > >   =C2=A0=C2=A0=C2=A0=C2=A0 if (node_size=C2=A0 - 1 <=3D mt_min_=
slots[wr_mas.type])
> > > > > > @@ -5590,7 +5592,6 @@ int mas_preallocate(struct ma_state *mas,=
 void *entry, gfp_t gfp)
> > > > > >   =C2=A0=C2=A0=C2=A0=C2=A0 if (likely(!mas_is_err(mas)))
> > > > > >   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > > >=20
> > > > > > -=C2=A0=C2=A0=C2=A0 mas_set_alloc_req(mas, 0);
> >=20
> > Why did you drop this?  It seems like a worth while cleanup on failure.
> Because we will clear it in mas_node_count_gfp()->mas_alloc_nodes().

On failure we set the alloc request to the remainder of what was not
allocated.

> >=20
> > > > > >   =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D xa_err(mas->node);
> > > > > >   =C2=A0=C2=A0=C2=A0=C2=A0 mas_reset(mas);
> > > > > >   =C2=A0=C2=A0=C2=A0=C2=A0 mas_destroy(mas);
> > > > > >=20
> > > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > > > > > Regards
> > > > > > > Yin, Fengwei
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > [1] https://lore.kernel.org/linux-mm/202305061457.ac15990c-=
yujie.liu@intel.com/
> > > > > > > >=20
> > > > > > > > Liam R. Howlett (14):
> > > > > > > >   =C2=A0=C2=A0 maple_tree: Add benchmarking for mas_for_eac=
h
> > > > > > > >   =C2=A0=C2=A0 maple_tree: Add benchmarking for mas_prev()
> > > > > > > >   =C2=A0=C2=A0 mm: Move unmap_vmas() declaration to interna=
l header
> > > > > > > >   =C2=A0=C2=A0 mm: Change do_vmi_align_munmap() side tree i=
ndex
> > > > > > > >   =C2=A0=C2=A0 mm: Remove prev check from do_vmi_align_munm=
ap()
> > > > > > > >   =C2=A0=C2=A0 maple_tree: Introduce __mas_set_range()
> > > > > > > >   =C2=A0=C2=A0 mm: Remove re-walk from mmap_region()
> > > > > > > >   =C2=A0=C2=A0 maple_tree: Re-introduce entry to mas_preall=
ocate() arguments
> > > > > > > >   =C2=A0=C2=A0 mm: Use vma_iter_clear_gfp() in nommu
> > > > > > > >   =C2=A0=C2=A0 mm: Set up vma iterator for vma_iter_preallo=
c() calls
> > > > > > > >   =C2=A0=C2=A0 maple_tree: Move mas_wr_end_piv() below mas_=
wr_extend_null()
> > > > > > > >   =C2=A0=C2=A0 maple_tree: Update mas_preallocate() testing
> > > > > > > >   =C2=A0=C2=A0 maple_tree: Refine mas_preallocate() node ca=
lculations
> > > > > > > >   =C2=A0=C2=A0 mm/mmap: Change vma iteration order in do_vm=
i_align_munmap()
> > > > > > > >=20
> > > > > > > >   =C2=A0 fs/exec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > > > > > >   =C2=A0 include/linux/maple_tree.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 23 ++++-
> > > > > > > >   =C2=A0 include/linux/mm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 -
> > > > > > > >   =C2=A0 lib/maple_tree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 78 =
++++++++++----
> > > > > > > >   =C2=A0 lib/test_maple_tree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 74 +++++++++++++
> > > > > > > >   =C2=A0 mm/internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 40 ++++++--
> > > > > > > >   =C2=A0 mm/memory.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 16 ++-
> > > > > > > >   =C2=A0 mm/mmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 171 ++++++++++++++++---------------
> > > > > > > >   =C2=A0 mm/nommu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 45 ++++----
> > > > > > > >   =C2=A0 tools/testing/radix-tree/maple.c |=C2=A0 59 ++++++=
-----
> > > > > > > >   =C2=A0 10 files changed, 331 insertions(+), 180 deletions=
(-)
> > > > > > > >=20
