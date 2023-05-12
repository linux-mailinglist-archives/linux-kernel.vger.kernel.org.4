Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A51700C5E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241558AbjELPzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241992AbjELPzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:55:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449D33C2F
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:55:06 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4ktS023033;
        Fri, 12 May 2023 15:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=ox6HyPOFsGCQWrDH2VnrM/YYxETcNZj4j1kXmyr3FHA=;
 b=eqoDwQdfxnPC3j3SypHcHm0JJ1Q351WGn2u+UQ7TJFnOANrc9zbbo/ld96tTpZqspOJN
 DaxSU6tE6AGwHqFaFlk8NGR1MPdVc5J0VyMgXj5ayPrQkK3/f5/Vq5wQUtr/H70KrDsW
 8b6imO1EQr1JGWIVdBfIvxf8PnuQpU+mlBB4ruUJIXpnYmZaWUQIkV0LAmHIGF2UbIww
 T0Hg2QWKFYgwaG7UCGzdnBAixetwf2aZ/MZPUJ+Hgedzn2wktfQE3PtLg3Tl20zqXGpK
 YJZbZ91qLBbAEnsWu5RkHtDX7Aex2cgnYd9eNd4PkAfmc3UyWxXmjZElWAbxTDzDQyoM ag== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77gb2d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 15:54:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CEYoQD011834;
        Fri, 12 May 2023 15:54:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf8151juy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 15:54:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1K7SM2N4mIFY+n6XSRSD8WzvxLQmVq4cDIMnGgvu7TkVNcT6F2fiFKiACKvvpvfZ8gJD5oaq4v0empsWvMdjhQRu+9MvWuOFSuHbZGd7GWHCP573gl/oxIj26p97FEVKB8+FnvODgO6S6MHLtxVR4YAlhjzEFfdDtFqVTlnFQKlYHVJBxMbwZgKqaYDqeZut7F/kLYHbrZV8jPKLiaiUMeBi9ZdAVe89nIZJFZ6SFCSCbIKBPYjOdkGgclB8u6Tu+ldRNrcctLZ3Lh44S9uPnYHsLz4GEHRmynONrKnePBBPKMWiXph1PyQJ6jeiGOYfjvJH73wqoKr/tqus+vH/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ox6HyPOFsGCQWrDH2VnrM/YYxETcNZj4j1kXmyr3FHA=;
 b=bRo/S0u1iofBiSuoob4BhpFZfm+OvAvLMIEbHCWUvXOBDSr+aMMevlN+lykWeUVTobVX1OMkheaTSfbrzVPLK6VEKuCX7jOUrZHvA9otF7UGW9UbbeL7uLZ8cWk9tJc656F2e0DXrdtKi1omdHHD9qUWn8MW4h8Dk8LaAuhxAhAuMn3eQYB6cf9Bn6YcvWKJPAu5EpeWLuQx7gsTM/BvzgUD9lcaLsngy52CqMFVFVYU50p8w3YoAot2JnlW61k/1oHsQCRtjjLmUs2LNV5h6/PtESF4S0EEW11yYbHi3mRDoXT00OaYG3XS8YcJvdu+GpsyVOCLOsI1Bjy0vDSutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ox6HyPOFsGCQWrDH2VnrM/YYxETcNZj4j1kXmyr3FHA=;
 b=wUntJEwD8Wh1PLjLfVgDcZqCzhAEyHRqqBWw5Ld70neLa9ubyruI+e80kblMmuQ2e/d7ZM/5Juhspqbnb0ykh8Giq6uAtKmjboydCytr3nH7NNnYksn8QXmS383Lsh+qCeyJJ+vhJPf+M1xkq5NSKxqyx2nX5DmwPFFY55Lv3i8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4637.namprd10.prod.outlook.com (2603:10b6:a03:2d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Fri, 12 May
 2023 15:54:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 15:54:36 +0000
Date:   Fri, 12 May 2023 11:54:27 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 32/36] maple_tree: Clear up index and last setting in
 single entry tree
Message-ID: <20230512155427.dyoymejdgnitfkcu@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
 <20230505174204.2665599-33-Liam.Howlett@oracle.com>
 <5ca5da7f-1b17-b22b-58c4-eae41443e334@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5ca5da7f-1b17-b22b-58c4-eae41443e334@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0124.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::33) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4637:EE_
X-MS-Office365-Filtering-Correlation-Id: af3f4ce7-a987-47fd-0175-08db53012fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OqbqSQJ7NLM9vtpQ0yzssNq44r2pm1izs1u4vL6ogI3TEwFzI2rxfwWcMPsK2SoU1YqC2S+9KlxkKWvILmBOCWf1ONPKO0PFY5OQbwjljR5hujIz7N67uMhZEY4trd7FlweZ9FVwyQRkzi8eRgEZ5QR4wMmEVZgqudC7xRxDA8f4ntXEIBeczYyAZ4yUPqfvf+cny9HNxNw9hSnGLSKGY9AcPYQoOwMBeSMMkt65JCaMQuqL6nbOo4WnxtLh24E6wfr/Kxfl+t3cnfEM1Sp5DblipqDXH9xx43rUmlcY23Hu9uUpr3O0w2sxhltTIUm6Z4wo7EzXMVn6EBCFwpNgtMYPRYGlY9a6vC5tAGnAa1YNkvXVrQfruqzHE15Bri2GMMVRGop+LQ7zWFdQdjXlGhZu08exvKWVMvB3I1bdg0AnmrGgOea02QlP9zvFvASDPgmLCeIFfrkpxXP1P7CkJqeHaU8J7wG/VPIMVIv5qYWXrAsihrK4DgrVrWd1vouDmq2qLpMw/2HpEPkKTo2pDxf7etqTziaynpAjPYz0V7JfKoXdnZNYe9NeehKhdZm6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(66556008)(6916009)(66946007)(4326008)(66476007)(478600001)(316002)(86362001)(6486002)(83380400001)(26005)(186003)(1076003)(6506007)(9686003)(6512007)(8936002)(5660300002)(8676002)(41300700001)(3716004)(2906002)(6666004)(33716001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTJUdktPYVVTWHgwRmdLY3h6OC8zRmZWUW42cm9SamNYSWF5Y053NUVORzZJ?=
 =?utf-8?B?ZUVrWFQ4NEdCRXQ4S29vbk1RYld3QzRZZFlOc0RWbmJWaldkVGM2MmdyNDNh?=
 =?utf-8?B?WlN1NjBIRU5wZ3k5STVOQUZHZFpYYzEyRysrNHgyY2tuUWpqL28veVI0TGto?=
 =?utf-8?B?NXVDckJtYXR3Z3JhMUZtNWJISmk3cFltYXgyWWZsaUJPV3BsY0hnL0VCYU5S?=
 =?utf-8?B?eHc5TmNIVHU5SFVMTlRlbFlzNzN1NWpUSTRWRGJCQTMrYlVtNUZEcXEwVjVC?=
 =?utf-8?B?ZXJnZkdlWWk4R2JPODJ4N2JRVThhTjZkbWU4SzNtVDFwTWlsbVV1YWZiM21K?=
 =?utf-8?B?cnhCcGNrU1FmVTFjQmZNNWZYZis0bWpuMm1obXdWd3liZGpad2x3eThNOEpQ?=
 =?utf-8?B?K2wvRFV6ZDhNdm5UY3ZJdDhnMWJLM2tvN1NicVVlMXBKYUVYRThESmFqQlFk?=
 =?utf-8?B?bG9YTHFQSW82SitHTE5ScjIrTmZMd0hrc1pOcDJTYkNveG4yKy9xRFppKzJW?=
 =?utf-8?B?R09RTTlYaTl2T2M4QXdHSXVxTjNndE5TUW9YL29YU2FteEk3b3dWRlB3YlFX?=
 =?utf-8?B?Q08ybHhYanIzclF0V3MyaXUrVU5WUzdFRHROY25wUVlyaU5xa2JFOFd5d3ZF?=
 =?utf-8?B?YzcvLzlXUVltbWMrOGZIbGp6OGpiN29OYmxWVnR6SllWSi9xSWpWTHV3eGVs?=
 =?utf-8?B?NkxuOENZYTZqczRsSzNuUE9FVFZKRGRhbXpsVkdkbjVieGVFOU1WbEZpdU5Y?=
 =?utf-8?B?T2xKV29EQ1dSeURWOS95SEhwRnIvL1pGajEzcTI0Rk0yV0I0TVByV2lLYlBE?=
 =?utf-8?B?ZEFOSXlzWkhrY3N2Q04rNUpudys5OGhWeUZyRHVDMytBWGVERTF6ZHJ5ZlpV?=
 =?utf-8?B?U243OFZtTitoSTBJQU55QWEzaU1RZVlhYnpyaE1pN1A3ajNGWno3aEtaYTZv?=
 =?utf-8?B?bUZGTEs1SWU0S09oLzBkenFxSmF0UWhNYTdJVmtHVU4xR1ZmVXcxWEF3N0VM?=
 =?utf-8?B?VG0vZDBXRDErcVl2V0cyN0pZTUhWOVc3alhxbCttUkZMZUxWbklPNEg4enpF?=
 =?utf-8?B?K1VKWExDU0FuTUwxWE13UHgzeFV5a2pQUFZ0eGxhQysrWGFhOWxXbzV3MEpO?=
 =?utf-8?B?VUU2MUp1bHByRytLT3JPcWVKMzNwUE1ldTdDcGVwUHFkbHc5TU96d2ttWFgx?=
 =?utf-8?B?cHp0NzhMWjhqWTVEUzhUV3ZucC9NVmoveTl2U1hOUlRkWnh1dVBxMXFCUUVt?=
 =?utf-8?B?QkVHM2hscEZER3dHU2dETE90M0s1aVRzMWlxc0hqbWs1T3NwWkhaZTZrb1dL?=
 =?utf-8?B?WkFJd3JGRnpmWlpFV2JqUllCQ1Vvb0ZBYmlvZE5QbE5KSkVKOG9QNGlvVjNQ?=
 =?utf-8?B?VWFkYll1TFl4ZzVreGd3eEFRUTNJSUhlQWhzemV1VU16RE1hVEhHL2hjN1B4?=
 =?utf-8?B?WGlHYWU3MmJ2YWQ4dFdHc1ZLMGZtdjNQTlBTUFVWRStaNHRFWE5iTWIwSkRr?=
 =?utf-8?B?dE5JQ20zKzBDZlE4bVFDOTdzdU04b3JpOC9EM1JvcnVpdFAzblprNmxZa3cx?=
 =?utf-8?B?a0JXMisrQWVsZU1JZXNHYVRTVFBpaXd0cDZOTktSMXBCMkNaaDZKN0ttcHB2?=
 =?utf-8?B?cVVlQktqWG5LVW1Remo5RDhwWERwU2NvOWdTTnlEdC9qZllLQTVKR2RCbXVx?=
 =?utf-8?B?Tm5SOStLdGNjYlFPdUZmM0pxbGQ0RWtNVmViTGJMbTg2RUFHK0Q1Mk52aXBi?=
 =?utf-8?B?dnFpaldZWUVzMXpvK096cHVXTXowUDNjdXIwdnJEQkFybUp5OHkwNStYRHFq?=
 =?utf-8?B?cC9lQnUvSE45Y3pvdC9uYTlEZnRqbW1UajQyN1BjNmdSMWNIVXY0djl3TG1D?=
 =?utf-8?B?RGt2OU0vdzkwM1U1NlBmbFM3MGZLdEZOWmcrdExYV0JqQWRmdGowc0RnR0Zm?=
 =?utf-8?B?emEyWEhhbEEwd0NlVU85VnczM2hxOVRHSjdKclc5ckRFR0drRytOTXZ2YTJT?=
 =?utf-8?B?Q2V5QlJJMWlUUjNKa2x1ZkFXd3ZZeVU4akM3MGpwSzY4TXlKMWhhbjRPOTVh?=
 =?utf-8?B?cVRUZk9CTEswZnBuRDg3enV3V3E3V0Rhbm9qdHFmSFBZYjZhd08rTEtmYnJl?=
 =?utf-8?B?TXNPc1dDYXdXRGJDeXRzUjlQN1pBQXVCVWYxS2YxTnJKS0loWXIzVnFQKzBy?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?K3VjS1FpdHJVNGZOblIzSE85YllmeHpNSEFMbjR1VVFsb0M1QStWanRObDVz?=
 =?utf-8?B?NS80bVZtOWZjSXlTUWwxT2IwcnA1OWJvYTZDZkE4ZzR3K2Q3Qm1LRmx4MTNK?=
 =?utf-8?B?Njc0OWE2ZHJ0UitiaGZNdTYzQnA2YjBiSEdJVTJUVHlQRUd5dkY5UVA2WjdG?=
 =?utf-8?B?Yjl6RkUxUkxDc3RXbmlKTi83QkJWdWRodmxUQUYxL2l1OENWNGFtTGRqTHZ1?=
 =?utf-8?B?ZkR0eEgyRldyajZEM1YxajRJeUNwQnhuTzFSbzE2eUpvUFlNRXo2QWpiYnBX?=
 =?utf-8?B?SXhJWURCVE1jT1hSbGg4VldSMmhoZHpLaldmQnNVYkx5K0NCVWFCR1lLMXhl?=
 =?utf-8?B?TmVXWi9wRzBnUXNRZFNZMmFFZ29FK3pCQ3ZHay9jMExSWXdJdGVTNDdnV0Qv?=
 =?utf-8?B?SEczN084K3dsOTFYbE55Sk94RWJScW1Ec0xZVG9xdmd3U0tBWFFyZVBGR1Ur?=
 =?utf-8?B?WHBDQ3J4dyttdXB5L0VxVzRlQWJLL2VERDVRY2dZaDEvYUlneW12Zm1oTVB2?=
 =?utf-8?B?ejN4NlRSbHZuUlZyWVNNaTlUNGtNQzJMUms0QjVIcWhkOFI4YURaYmUwT2l3?=
 =?utf-8?B?eEQwVTVNTUQ3UUNCVEpTWTNJNjJHQmswUlUvNklsYmdwazlycFphZE1kS2Y2?=
 =?utf-8?B?OUpBbmZQd1JNNU9BTkZZR2dTbkg5VlZBaHlHQjBqYUtzdmoxdmk5R0xZRy9R?=
 =?utf-8?B?TmM2MW5kWUlEN1cwVjRuRnZyeVNqVGdxZjhic0VhdXdRV0NEU2ZVK2MxNnFT?=
 =?utf-8?B?b0hPcHdFNFRFcDB3Z2VzTy92REM3QUZJK2w5NDV4dHdtcHF2aUprd21RNWZF?=
 =?utf-8?B?NHhJMmtER2JQbFprYXNlYy9JZmtQRHViOGV6S1lCZWdBK0h1UzF2Vk1WWmVN?=
 =?utf-8?B?WkFQQldHdVY4aGVJK3NlZjIyVnE5Wm01WDZnYnlYd3JGN1lPZ2dZMkNZTDNw?=
 =?utf-8?B?RUV3UC91Y1Z0M05vd3l3TittYkhSYzloTHdZTnVMZzQxWGpKSWdKMDdoTWVL?=
 =?utf-8?B?Q1pxOXExZEl5amh0VTBQMjZYdXF3MGNSZ05SZEl4a1JPVkdET0VVWXl2R2VD?=
 =?utf-8?B?cDF5aU4rMko1VmhwZDlFZ0g1ZHpuTmFtcklaTUFnOHhISkdRRFNCb3EyVXFV?=
 =?utf-8?B?VFhIbFlBK21xTUNnRklGUlVnZTZ5dmFjemg1Ly9RcXVENjZBa2dDR25nM1da?=
 =?utf-8?B?YmJwQjhzWVJXNzErdzJ5cWNzaWRBdWdGTFBwWnBaaU9WeFl5UHFlSXlweURn?=
 =?utf-8?Q?vPeD23a40gswgb3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af3f4ce7-a987-47fd-0175-08db53012fd0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 15:54:36.7329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCqKgTac0CCB9TC6RQrJEa+dvB1qqwjb607agmbCL7hC6ES6ZQfJZska9yHq2iRZSmDusy/T45eyaiuyPb5QQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4637
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120132
X-Proofpoint-GUID: T0QYnOPyLFGQ9LnQWgL2gs8KkUVKQya6
X-Proofpoint-ORIG-GUID: T0QYnOPyLFGQ9LnQWgL2gs8KkUVKQya6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230509 08:39]:
>=20
>=20
> =E5=9C=A8 2023/5/6 01:42, Liam R. Howlett =E5=86=99=E9=81=93:
> > When there is a single entry tree (range of 0-0 pointing to an entry),
> > then ensure the limit is either 0-0 or 1-oo, depending on where the use=
r
> > walks.  Ensure the correct node setting as well; either MAS_ROOT or
> > MAS_NONE.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >   lib/maple_tree.c | 21 +++++++++++----------
> >   1 file changed, 11 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index f060c71965c0d..914399519cf54 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -5022,24 +5022,25 @@ void *mas_walk(struct ma_state *mas)
> >   {
> >   	void *entry;
> > +	if (mas_is_none(mas) || mas_is_paused(mas))
> if (mas_is_none(mas) || mas_is_paused(mas) || mas_is_ptr(mas))
> > +		mas->node =3D MAS_START;
>=20
> Hi, Liam
> There is an issue that it cannot pass the user space test program
> with this patchset.
> I tested it based on 47cba14ce6fc4(linux-next/master).
>=20
> The reason is that mas_walk() does not handle the state that mas is
> root. The root cause is that mas_start() only handles the start state,
> and returns NULL for the root state. When encountering the root state,
> we can reset to start so that it is handled in mas_start().

Thanks.  I'll have a look and adjust v3.

>=20
> log:
> BUG at check_state_handling:3076 (1)
> maple_tree(0x55d6a9838ca0) flags 1, height 0 root 0x1234500
> 0: 0x1234500
> Pass: 453406336 Run:453406337
> maple: ../../../lib/test_maple_tree.c:3076: check_state_handling: Asserti=
on
> `0' failed.
> Aborted (core dumped)
> >   retry:
> >   	entry =3D mas_state_walk(mas);
> > -	if (mas_is_start(mas))
> > +	if (mas_is_start(mas)) {
> >   		goto retry;
> > -
> > -	if (mas_is_ptr(mas)) {
> > +	} else if (mas_is_none(mas)) {
> > +		mas->index =3D 0;
> > +		mas->last =3D ULONG_MAX;
> > +	} else if (mas_is_ptr(mas)) {
> >   		if (!mas->index) {
> >   			mas->last =3D 0;
> > -		} else {
> > -			mas->index =3D 1;
> > -			mas->last =3D ULONG_MAX;
> > +			return entry;
> >   		}
> > -		return entry;
> > -	}
> > -	if (mas_is_none(mas)) {
> > -		mas->index =3D 0;
> > +		mas->index =3D 1;
> >   		mas->last =3D ULONG_MAX;
> > +		mas->node =3D MAS_NONE;
> > +		return NULL;
> >   	}
> >   	return entry;
