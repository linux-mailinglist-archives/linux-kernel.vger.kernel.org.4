Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CAC6AB113
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 15:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCEOkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 09:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjCEOjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 09:39:54 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA9AEC79;
        Sun,  5 Mar 2023 06:39:52 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 325AaFIe011786;
        Sun, 5 Mar 2023 14:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=iv3v/2XkT+pWqDqngR5jFERh0S30JHiM25UvNz0SQUE=;
 b=UfMk1RyUsWZVlF8oKAwB/wUCiR5K17BWnHZrCUedOyxrkQCpJxnKkyTWq13U5j7MiBG6
 xFZwgilGnzw03pQ3AXHcBZyHm0nd2Q9aw1YWhi1OdMfSG1PKexTgoWwfYzO4P0BBdPfk
 nPTzhaio1v/MQm1McSMauV7yfy5ljT8XxasbBAGK1E4/rgO9YPvEZv8MaMLp7N9+tjV4
 XtL1nhpOHsCUIKLUmH6+RA4H7zK1qribUdUp23NiFLKQlNKjmttZZhkzKiPikK1O6o9v
 g57abeqdeyrY3j5FXIW5FoBXNW6mvwwMk6NgJUiZEsAFsng/ig8IT5N16RhvpAeUZYHc +w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p415hshsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Mar 2023 14:38:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 325C82bG025835;
        Sun, 5 Mar 2023 14:38:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4ttghyyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Mar 2023 14:38:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwsIRXmORnDERQ2IQmcZ4p8TOCFPXFYPLIlwdDSwgDf/DxG2blmWaJcX/BIs8BSZsDLGN3Z3/tzb0irdBOw+cpWT2zHFin9BKP2az4BwJRxJkwGZnEluNvQbPNiDYGnQB7WASHOkaZpIxXBteLpUUBPejdr0UWQwZGtqAZQgQ9SWlbBdVuTuJttjE76OXrNd6pSxauiE4eicmnSwDmylN7JFubB8FqGHKcFxbtIWNyY3GBu1tNuCATDGqiRXMzdw1HLgs0dVqZB0JKdqhPn8sqGsWF3xpQHxvEwIUTjkQXzBMnxnCSV/ngzZA+Jf4UwfmP9ADQQ4phjwSEO84p8TgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iv3v/2XkT+pWqDqngR5jFERh0S30JHiM25UvNz0SQUE=;
 b=WmomWLWhrWHS+nEh90wftw+ibHalQ8R+pgEuS8wo84rnlMlokHpc7js2EgKOUfjuHdMd+45/adkh4lU55qhMVxyi2ueIclc1MmF/O/kMnt6mEdzjQMdD64mXJMnc0uqDvWzW0RN7ck3c8rJ7SWn6oNd63xQnaM5ANS7E4LbepPNBCaDEqr6yT8X4tolZUAtiD6LKI7G+8Z3aNnq0wYMGMH3IxmsOgA+gNL+9laNI9tNciqjsblSgLbSTbytqinc+Kced0QzhiP7LcS4gdzpEzojbZtmPCC0suik7ex75Mb8hk1JXer5ma2gNAsR64HFHXvexoOxgO139CM/hq6R+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iv3v/2XkT+pWqDqngR5jFERh0S30JHiM25UvNz0SQUE=;
 b=LrXvVxc/1gTr4Wp6sI/BNQ4EII84LCPOBNVookiAZQWjapqWuJHmPxL9n1mvqTA3/n0x5YT85htCORhNlDqt+57pWNN2bvRX+LuKP4jNKzXuqUFBD0uLPO2BjbsFwUfZMQXrmzV/U54/j6Xe3WAsVS1a1Dauf1DZNxXMFwhTTic=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by MW4PR10MB6581.namprd10.prod.outlook.com (2603:10b6:303:22a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.26; Sun, 5 Mar
 2023 14:38:30 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a0c1:677d:5394:bf43]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a0c1:677d:5394:bf43%6]) with mapi id 15.20.6156.027; Sun, 5 Mar 2023
 14:38:30 +0000
Message-ID: <62ea5094-0412-c1a6-8730-670a4fd1ad51@oracle.com>
Date:   Sun, 5 Mar 2023 15:38:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] Documentation/security-bugs: overhaul
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Solar Designer <solar@openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Willy Tarreau <w@1wt.eu>
References: <20220606194850.26122-1-vegard.nossum@oracle.com>
 <20220607090726.GB32282@willie-the-truck>
 <a0728939-0852-57e8-6d4b-8c11c73569bb@oracle.com>
 <20220609145127.GD3064@willie-the-truck>
From:   Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <20220609145127.GD3064@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0051.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cb::12) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|MW4PR10MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: f2e4aa4f-7d66-4854-a22d-08db1d874a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Osz6HigGcv65SjCh8+KfXMH4zZtWUuBl7DArPeTA2zTbpJz3UKtigVq4L0DpzwkDEaUl+EH5PQcX3cwMg4ugNtJC084K0WHERARisEhctvPpshaBcObibQGcDj3uA2uTKQKBRwsl8oXGwUHuEo7UQpstziAwEWY9zdONIDyTf2GR+vRB22NGH1R9Jo2Yjvp6CZ+O0iPwxFt8tkfWViEHFcN/HN5DIph2FEN9btbNHCkNUKb4y9Gtj92BbsyGWh4a/1DxNEd0oXkiTqrFeUQHdUbAQT5L8WRZauxRSiJfHxUUfSk6HCz+kYxG4ODfxYLpfbDRiR8VCNEpdy124+oJSHtepl+lHQVdNWtETCCRPhjR6qK9lUTv/r1Ep4VLWXMdnTVTme+MVusYJB4XWBXiNo8OatJRpsmihIRG/BaMFpxWSvvZZ/iKIdiywLKNs2Rw9tHQ4b+gCCN0+KsTBpOgTT04IRIOinLlfQ/Bn/wllJxrEwxs6vqod/BSEewWlpS3dNsv6y8s359rG6vmpvuRDfsB3RCxD3uQWTJ2HtjrgHAbmpyo+a0Bjtd6LZnzu3kqVfhxr974Pnx0cdWUBwlqE3NZp9AGzwl6SssfL/v+W8cnzkTqcg1IxEw/CI1n6qzCE9aYhZF9Kq9GLaLNK9Yh89EcBoTBknpnklfmQvUKpBCuHDg0vGAfvQpJEoAXNTmeY9Q1lEmv1jAblLz5NDxRFcyKhC2BA2KtoLcrdhqbwjo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199018)(478600001)(6506007)(31686004)(53546011)(6666004)(6486002)(83380400001)(38100700002)(2616005)(316002)(66946007)(66556008)(54906003)(26005)(6512007)(66899018)(186003)(66476007)(8676002)(41300700001)(6916009)(4326008)(44832011)(8936002)(7416002)(5660300002)(15650500001)(2906002)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1F4b2JsdldkK0JTcGs0QTlXQmovaHY0RGJscEtJd1hoaEs2OGFUZHJSQ0JO?=
 =?utf-8?B?QUcwUVJ4dlBRb3V3RE43eWtzSVBsWU5nWUczQjMwR1owRUoxTGRTL0l6K2ZK?=
 =?utf-8?B?WEdhL1dTMkZNT1hyLzhIaWhQUll6TCszbjZnMU9VWXYwQ08vSGZSMUhNVEU2?=
 =?utf-8?B?Nm13cXRLVDhTc1Y3L0E4dkRSWStiQUgvMXF0WFBaNDhYTGc3ZnFtem9zbzZT?=
 =?utf-8?B?SU5KZzNCSFpUN3RrMzgrSWZxTlgrekM5QUIrbUJUaExjQXV5YnpPNERZcFhH?=
 =?utf-8?B?NU9BcXhleitnNEZHbjBWRzlmY1NzTkVRMVA2NENmOE10cUYvaVF3MVREdUx4?=
 =?utf-8?B?ZlEwTlFRdVpHT1hZcVJqSFE3T0pxS2NXM3FGcHptQWJUdk92QXVVL1JVSDBY?=
 =?utf-8?B?OXljMWtkcFJVby9TN3pET240TW9RcmJwUTZHY29JeTRGcFR0bnNFMU1wcW5i?=
 =?utf-8?B?QUpKc2Qzc1FWRkJwWmREU2NtZUZiaXRaUDJWYUZsYndwNHNXYmJwMFNxNXNM?=
 =?utf-8?B?MVZkeVpMUlRGb1cxOVN4TU1rdGNVU2UwcDZCVnRVeXd5L3NOdEduZVFraEQ0?=
 =?utf-8?B?aGk2VndLRkF1Y3kwRlY0RXp3MVNVNTJ6U2MwODliNWVqOEwrOHVqVGRsejZG?=
 =?utf-8?B?SjNlWUU0cGZNMUFudmJtZ1JMZ0pLaVJzQjFPbU1ySHAvb3dxcE5rMFY3WVQx?=
 =?utf-8?B?WStSY09WQVk0WHg5QUVoZTBYWTVOT2tDY3pMVU1zTkJsK0lCVUlXUVJ6Rit4?=
 =?utf-8?B?SjU3ZEl2aC9TVG1teEJuU0ZwdXR1dXlsb1hRWUZZeW1LeUlzdmtJQkYzT2JF?=
 =?utf-8?B?dm9ncVdpL2VxNTBtRXhxTTN4TWc2R295K0JlK2lIWWVCcG1UYUsrSzhBZlFU?=
 =?utf-8?B?d1VKZzBML2t6a2wzdEtLY2FoN2VaTlZRaHNRbTB2Nk10SFlPYzh3ZTd1NjhO?=
 =?utf-8?B?aHpQblVSU2JpdVd3amdlTlM1bkJwUW5VQ3ljVlczN0JOZUhMNjdrblhYV3Br?=
 =?utf-8?B?YXN4TzVGL09WeEswT3NuRHBBTnp1K0h0bWVxQ0ZSK1VuallmY2kyV1B0YUpQ?=
 =?utf-8?B?RVludHlGSUpnaG1XYm5nMEIzTmk1aEE1Y3g4a0J6MWgxNlp0VTFnUTR4ZlVJ?=
 =?utf-8?B?bDhmbDIveWhzbzlsT3hPeDRMbXZ5dW41RmNLRmVLeUY1dEJaeXBqZ0M2RFA2?=
 =?utf-8?B?NVFKSW9iTWQ3bm5xaEtsa1paQkswOGJGdXd6dlZ2MEJMMlc2RGFqZUdjRzRk?=
 =?utf-8?B?dEJIT05va3gyN0llejVRYnFlVXFDUlJTTjNUVVRiTHg2aTNYRXF4NGg5SXJ0?=
 =?utf-8?B?MjFudU1MTWwrcVB6YjlEU3hMdExwYXAzRkUvU0lJNlBPa3E1S3VTMFF1TFFG?=
 =?utf-8?B?bk9NdXc3M3dnNWphT0Z5Z29LUlRoWXdHek9NL1I3bk1WZGtUSUtXaVp5Qm5t?=
 =?utf-8?B?MXhmUGV3LzB2bnVXdEVuU2VYcW5tRmZqM1MwR1VESmZ5WEtQK3duejdqOW81?=
 =?utf-8?B?aGdvWjJaR21VbnY4M3B5VTltZm56Zi9ycDNmVXFCY0RDZm9ReXEwd1hmVWxN?=
 =?utf-8?B?bDF0Rm1YUElXVjk3am92QzlhZTh5UUlnUTMycGVRSnQyNi9IeUhQeCtyeUxC?=
 =?utf-8?B?bzBKTU1oRVZIMHhCQ054ZHNmcFVQbG5SNDEvVkR0ZXFHK05qQWsvQzlsdDho?=
 =?utf-8?B?d2hRbnlJTE5yc0M2anF4YzdkUG93V0Z6TXN2UzBPRG9mWlpEQkJKais0Nllu?=
 =?utf-8?B?R1F3TVAzb085TnVFNmNMZGs5REVVa05MZkROSWRTWitsSzloVjd6TE9yb2Vy?=
 =?utf-8?B?U3duWVF6NHViZnNJMG42N1VyUm9iQms0ZVdrNUNEaDZubnNQVEUxUzBmRWoz?=
 =?utf-8?B?cjhTS3pWbnBrdTFydkp4cG4wVmRPZTF5WTJKdER2TUFSUzRkYUJGRVV2cDNk?=
 =?utf-8?B?em5nd2JXVFpaUkhTY29sK0orcTZEcDRiVEgrMm12d1JKc1MvdnBvK1A0TEVl?=
 =?utf-8?B?SlNQbWhrYkQydklxUDVid1gyNzJKQmRxYlJlYWJqOEc4NG5NTnNQTG5XNi9T?=
 =?utf-8?B?TXB3OHAzcmFPblhTdFQ3WTJQSVRlcENaMDZGZ1h2L2JkeTlDWnJ3cE96c1l6?=
 =?utf-8?B?U2hBeHVrZ0xWNmlMTWR2T1dJYXREWHpxbUsyckNIRFZSQWJZZDVGTUljdWVX?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VWhBZFZab3ByVDMyQko4UUcxUm1lZFB0d29qOU4xZ2l5MDd1aTk3NThMMmVu?=
 =?utf-8?B?RlNvTEsvb0NUcWh0bXcrMlhWeVlEYmRUTDR6bEpqVmdaUGIyOVA4SWIvMEdR?=
 =?utf-8?B?RUJiM0Y1WVVseFZmOHV4RVdBNmw0b2FxUU5sMTF5bHlrWG1ldTlCaWpzL2F5?=
 =?utf-8?B?Z1FLTmV3L1lEa3ByaFBPS0Rya2JhT3lWMHFxYkVGUWsrK3BvNnBWaFZ6RHJ0?=
 =?utf-8?B?eTBKMUg1ZXR0ZTFYU3ZEbjcwMjVXYjNHSFZua2RtVVBGSVZGakdZQkRBQU95?=
 =?utf-8?B?Wlo5L0lYN0t2WWlkVjRZTjd1SG5QaU5RZDVIeFc4L0dQbGZoTkpKWUM2S0RY?=
 =?utf-8?B?VWwxTXJvemQzVmhURmlJNmZKVlM2U05SWVJRQVRDOFJjRHVNNzBHb3A2U3BM?=
 =?utf-8?B?OTdZaWl6LzVmd2FyWkVpTFc1VnVZK2JCVURodktESTArUFJRQWVFbTF2ZE00?=
 =?utf-8?B?bkVzMXJEMGhQcytDQTBxeDRDRXE0TU9LOGF2M2hpSXF4WS9EVndCSkJJT2RC?=
 =?utf-8?B?VFYwRStBRjlnSk1RQ2NUcStabmtBY1FnZlFwWTRZa3BNRk5QM3dsT1JFWUIy?=
 =?utf-8?B?MnZZQ0d5M0x6U2ZHRThST0lKV1FNWVl0RldlaE9tYVVlK1MvVUM5Y2hnWHNw?=
 =?utf-8?B?LzNmYUQxc3lBaytKOUIzSExjVFZPcnczeGtkbEJiUFhZemVQRU1TQSsvN2lK?=
 =?utf-8?B?M2liZzVoVm5mN3ZpOUFBUlF5QkZtc1AyNFQvWnFqOHc0ZHlBZStZV0ozUXpj?=
 =?utf-8?B?eXQwc2h1SlpzQ1RidjZUNFA3T3MvSTVlcWhKVVpVNmo0VFpscU93NFNyaUsz?=
 =?utf-8?B?aFZoUlN1ZytTdm9DbnZ0YXZVd1FDMDl3anV5NUlqY0dnK0J6bENTYlVMTG9S?=
 =?utf-8?B?b2IyZHM1NmExMWZyek1ZcnNjQXZMVDVGbUJlMmdiWUFFUmFHZklJNTJ1NDho?=
 =?utf-8?B?RmV0aE5FclIxbHZhU3p6VVUrZGh0cDhaOUJScms5Q1hBSVd3Rnh1K2I0NUdT?=
 =?utf-8?B?N3B0VFM2c0RRWEdORFFXV1JkR0c5eWFqM3BVbk9Hc3lMeVlnK0FVbFNXOFdK?=
 =?utf-8?B?QVVhZVlGZUNsTUVsYi9ycjZwZDdYdURQK3hSV0hZSEhVeXZLdjFTWjdKQ1JY?=
 =?utf-8?B?bFdMdFZqK0dSdlNvTklrYlNIWWxEaXdKWGlwcCtYTENyYjljSlZ5bWdrSXVD?=
 =?utf-8?B?cUtTNnhqbjhWbkVTbnBNTi9Hd2NQeU5ZSFh0Qkp2cDg4ZDdCQ1h4aUFlbEZj?=
 =?utf-8?B?NTJkQkVVaHV2V1dIbmJ1dlROS25GY2Fjc2RDeC93UjA0Q0ZNNG4ySXpOSHRq?=
 =?utf-8?B?aXBmMUFQaGkwWlNVbklRUlFuRVNhd3Z2Z0JEcSsxb1hoakt1aGh1UE5ySWJl?=
 =?utf-8?B?OS9PNjQzZGNRSTB5SlVleGk5NTlSWklUdTY1bkowYmE5QUlFV3dVcElZaUw2?=
 =?utf-8?B?SW16ajJLdDlpTWxTTHVnSlJCWXVPZTVTR1AwUXVHd0JUNzB6WXhVZTRmWCtl?=
 =?utf-8?B?MEczOG45a1FDZjZhdmdiZE5iKzhvVmU3Sy9qcno1VFREZTh6MmdUYzJnRG5T?=
 =?utf-8?B?d2E4SmF1UlhONmxKOW5lSTBySzFBaWVRRFlublpzdkxISHpHd0djU0pITC91?=
 =?utf-8?B?amI4aG4xYy9aSmllZnZBeDI3d3A0ajdFZ1I5aVg1RFZqMEJ0WHJXaEdsNita?=
 =?utf-8?B?Q3JvSVJLWG9YMmhTd2wvbS9rUEpCYWUxNE5TdEUvd0RkTnFsc1l5bUcvVXFJ?=
 =?utf-8?Q?gBTnssEvjQmDjT4dP2FxulEFEyuK4GiJfL4E1Qn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e4aa4f-7d66-4854-a22d-08db1d874a19
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2023 14:38:30.7959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXJNnPOwdwOIgVdUaCb3kmTD6KTqHD/TivyLUx0TCS0GL/nvdAMAh5SuZFQbDeY9HVMvpEK5hCnkl1L6rQLp1/e4tZ2kapH6nlsGR+y3qMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6581
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-05_04,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303050128
X-Proofpoint-GUID: 1YqqbCA8Vvt9FTk8iQLimHvWn9yca5-I
X-Proofpoint-ORIG-GUID: 1YqqbCA8Vvt9FTk8iQLimHvWn9yca5-I
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/9/22 16:51, Will Deacon wrote:
> On Tue, Jun 07, 2022 at 03:06:37PM +0200, Vegard Nossum wrote:
>> On 6/7/22 11:07, Will Deacon wrote:
>>> I think there's a semantic change here, and I tend to feel that these sort
>>> of changes would be much easier to review if the semantic changes were done
>>> separately from the reformatting or the addition of entirely new sections.
>>> As it stands, the whole doc is effectively being replaced, but what we
>>> currently have has been tweaked over the years (often as a result of
>>> spirited debate) and I'm keen not to open up some of the issues we had
>>> previously if at all possible.
>>
>> My goal with the rewrite was to clarify the policy for reporters,
>> include the updates to linux-distros policy, and turn the document into
>> more of a step-by-step guide for reporters that corresponds to both what
>> happens in reality and what the "ideal" flow for a security bug report
>> is. It's not my intention here to modify the policy itself.
> 
> Oh, for-sure, I'm not trying to suggest there's any malice involved here.
> Rather, my heart sinks at the prospect of reopening old (and, frankly,
> tedious) discussions around the finer details of what is in that doc.
> 
>> My impression of the current document is that it's a little bit chaotic
>> and difficult to follow -- perhaps exactly because of tweaking over the
>> years rather than writing for the reader/reporter.
> 
> That's a fair criticism, but a straight-up rewrite won't solve that imo; the
> thing will still get tweaked until the next rewrite comes along etc etc

[...]

> What exactly is unreadable with the current doc?

Lots of people have been confused about the 7/14 days of the kernel list
vs. the 7/14 days of the distros list, the fact that these are two
separate groups, etc. Many reporters contact distros first, or submit
their report to both lists at the same time (which has the unfortunate
effect of starting off the disclosure countdown for the distros list
before s@k.o has had a chance to look at the report). I've since shared
the updated doc with a couple of people who submitted reports and they
said they found it a lot clearer.

I've split my changes into a series of 7 patches and reverted some of
the wording back to the original document in the cases where you thought
the original was clearer or the semantics had changed -- will send it
out shortly.

Thanks for your comments so far.


Vegard
