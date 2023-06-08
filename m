Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B621D727AE6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbjFHJMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235753AbjFHJL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:11:57 -0400
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152EA18F;
        Thu,  8 Jun 2023 02:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1686215516;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ld0IbPUaYGimz9l/wNKkUCKWIHHFY8JFQHV/g/RnSM0=;
  b=BPCOz9DJO3oKJ/Y0p9o1O0n8SADikQv5oMeOetN4flBqDyR0rtko2bUA
   A4XFn2uWOki0FTDFi9jkcoSdET9KmkStsBRMrARkMTXsGymA9ZbPVoyRr
   Nk6ApcmpAq+esQfiKHZy12wihtcxqq33gvpzgFZcYRKMjemwmI5O6kAdi
   M=;
X-IronPort-RemoteIP: 104.47.58.104
X-IronPort-MID: 111362467
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:gRrISq8H+tlT1lIFHKpmDrUDwn6TJUtcMsCJ2f8bNWPcYEJGY0x3z
 WobXGGEOPaOYjOhf9lwbIrn80xSusSDzdQ1TAVv+So8E34SpcT7XtnIdU2Y0wF+jCHgZBk+s
 5hBMImowOQcFCK0SsKFa+C5xZVE/fjUAOG6UKicYXoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqojUNUTNNwRcawr40Ird7ks31BjOkGlA5AdmO6gb5Aa2e0Q9V/rzG4ngdxMUfaEMdgKKb
 76r5K20+Grf4yAsBruN+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+v9T2M4nQVVWk120c+VZk
 72hg3ASpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn9IBDJyCAWlvVbD09NqbDklL0
 9olEA4wMCyehue3mriXWMtqhPoseZyD0IM34hmMzBn/JNN/GdXvZvuP4tVVmjAtmspJAPDSI
 dIDbiZiZwjBZBsJPUoLDJU5n6GjgXyXnz9w8QrJ4/ZopTWDilUpjNABM/KMEjCObd9SkUuC4
 HrP4kzyAw0ANczZwj2Amp6prraWxHilAt5MS9VU8NZv2neNwVc2ByQXXHm1vvi/zUKsZvlQf
 hl8Fi0G6PJaGFaQZtXwWhyQoXiavwUdUd5dD+077g6WzqPepQ2eAwAsRy5Lb9EOt8IsQzEuk
 FOK9/vgCj9HqrCZSXuBsLyTqFuaIi4UMX0PfwcHQBED7t2lp5s85jrDS5NvHbC4ivXvFD3wy
 izMpy87750WhNQO3r+2/njGhSytvZnDSgMp5gTRUXmh5wk/b4mgD6Ss6F7G/bNKKIGSTXGfs
 3Ue3cuT9uYDCdeKjiPlaOEMGqy5ovWIKjvRhXZxEJQ7sTeg4XiuecZX+j4WDFdkNIMIdCHkZ
 GfXuBhN/9lDMX2yd6h1bomtTcMwwsDd+c/NU/nVap9CZ8Z3fQrepCV2PxfIgybqjVQmlrw5N
 dGDa8GwAH0GCKNhij2rW+Ma1rxtzSc7rY/Oea3GI92c+eL2TBaopX0tajNisshRAHu4nTjo
IronPort-HdrOrdr: A9a23:K6o0K6ENXiALmxKjpLqEGMeALOsnbusQ8zAXPiBKJCC9E/bo8/
 xG+c5w6faaslkssR0b9+xoW5PwJE80l6QFgrX5VI3KNGXbUQ2TTb2KhbGI/9SKIVydygcy78
 ddmtNFebrN5VgRt7eH3OG7eexQv+VuJsqT9JnjJ3QGd3AaV0l5hT0JbDpyiidNNXN77ZxSLu
 vk2uN34wCOVF4wdcqBCnwMT4H41qD2fMKPW29/O/Y/gjP+9g+V1A==
X-Talos-CUID: =?us-ascii?q?9a23=3AFVc5Jmqv4dewM4xNLqIKcvbmUcUDVEDl8kqOH1K?=
 =?us-ascii?q?5DGczQpGHa1mSxqwxxg=3D=3D?=
X-Talos-MUID: 9a23:xeXqqQSoKghuLHbMRXTp3ht8M/xN7J2vAWIDjpQA/MWWCAd/bmI=
X-IronPort-AV: E=Sophos;i="6.00,226,1681185600"; 
   d="scan'208";a="111362467"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jun 2023 05:11:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbwSJlEEPCdRF+NE1GYbn8TVRNDWNN9IKLZMLgfTqC1gpojyjkiYDmIzQMx6ecPgoPxa273VdlMm28HjTtC9qysVuU7YJJItpJ+Q6UolE4FVDRInH3/Fy85bZ8URkEdQV2vYWZkQabWHooPXZqDutx8xAV/R3C06GN21gYxzrX4mhi+vmJrPdIL4o4gZWrupM9Q0FLwby/IYw3XEi3D7ZA1iPkynwi9fpKDagUKto5DT8R64WaPh0nDKpFjPRoh69kaa5Ty0gSF8iC+y/vvFItC82Ucm6bkseoR+PNmOeDFy+4HuAbXuc8aaphBoLH72Vf/X4qv6Fx1wxyQyB+CkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyYSjQ9TsbDN4DAzwXQdpwJ89qF1zxgw1zHOP2E+Lqs=;
 b=HpRpN+eHGwT5aDcg1c8ZnXfMcRrCKufmBVqDy/n/tKNaPECP+6aAA23iATxsPIlm5z2pxC+NUsEyDVyM0sRzdgcFfQjoZb/UT9CtkdV68+tldbszpO06ckwL2gkd8inKoM0J8owdVKK4wlytr6hp2Lj2w6A2lUkMXE7VW54k2q6OAz7gOX+k0G0DvsA4y9ZwRjItCRJrj/Zqxr47Y61W1pAc0y81IXgZHMVRtf1Lws6GR5mWqDMnM+5xTvoQarSZkAk8q7BxtkmAhDDiGZqQ+u4B5B28Ltbbm1aJtH6T1BkfYeKBLUT5rBmbsI1FeYFM5HF9j5+uc8KNotd9vfjueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyYSjQ9TsbDN4DAzwXQdpwJ89qF1zxgw1zHOP2E+Lqs=;
 b=c8GrdWJD+xtpouUNKdBRtR9iurP7kEO8PUennvcMCxzxnXZVDhwRVpK67BFi/cmgkBfggfSe1AymZcCTRGPZFGhvT2YfD0G/Z1av3WvK2vM6NRhq2ld91UgG4w7wn9ogfLW+5kBkZRFmfkBu2tM5nWdeXkg5LJp3GeupbduW7Kg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com (2603:10b6:a03:38d::21)
 by CO1PR03MB5873.namprd03.prod.outlook.com (2603:10b6:303:9b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Thu, 8 Jun
 2023 09:11:51 +0000
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::192:6bdf:b105:64dd]) by SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::192:6bdf:b105:64dd%3]) with mapi id 15.20.6455.028; Thu, 8 Jun 2023
 09:11:51 +0000
Date:   Thu, 8 Jun 2023 11:11:44 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 16/16] xen-blkback: Inform userspace that device has
 been opened
Message-ID: <ZIGbUDpqjwbR5zmz@Air-de-Roger>
References: <20230530203116.2008-1-demi@invisiblethingslab.com>
 <20230530203116.2008-17-demi@invisiblethingslab.com>
 <ZH75OTMA6N3zYrH2@Air-de-Roger>
 <ZH9tcGh0N2fEcwjH@itl-email>
 <ZIBDgKKDhDj+//Q0@Air-de-Roger>
 <ZICwaWidZxhaGp8v@itl-email>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZICwaWidZxhaGp8v@itl-email>
X-ClientProxiedBy: LO4P123CA0165.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::8) To SJ0PR03MB6423.namprd03.prod.outlook.com
 (2603:10b6:a03:38d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6423:EE_|CO1PR03MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a92e457-0e57-41c2-64fc-08db68006509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dCG8b2hegsg5rquNK13BWen0/GsRzM6xXZiOhxfEyAMdMAnJYozEKuCWGAZfzRUkyzOqj7zbF2Epjy6oWFIEJoPPE/aoghB95mmztY2XNBuAGa3/0t9erJCwMNJFlzDbXasfs4nIBuyts2Nc8ixx7EXIyBMGJufdFpAsZ0KRe63M9c923ra+wgN5Razrs/rMX4uVXam+UoLaAeQWg9gEaVHrcc+n4d9hBjHSBOfs4s8rNWyhcW1Xk6hQ6eWKyKeAKSCdgV0hdRMZfw9qOyUnK/PL0prBAwIGNApixfsLgMqmuRxosY8zvSOFls1rI8sD9DWl0y0kUFmwcRF6i0Mt67qJfXCt9wIzKEO2lGYlsEPJeCeonMpYUZ3qndZ4mVhEMnbVlt/uzYfjU1cUXtHLKKai+gowtY3tXoXo0IhYkrTYJdgva1lfNC0DDetNq+Zcv7wyc2yqY4zMZ0R/zUxrtDD1iQhuKdu6fgXEmOI1L9XAB5areu79jYIiRghH6m73m0BiWB7P7bzhj+4akwMRBwLOKV9zUkhKL1J77p0m2Hcyd/jjUcFyJS0q8L7ljzEb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6423.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199021)(54906003)(82960400001)(478600001)(5660300002)(8936002)(8676002)(4326008)(6916009)(66556008)(66476007)(316002)(66946007)(41300700001)(38100700002)(186003)(83380400001)(6486002)(6666004)(9686003)(6506007)(26005)(6512007)(86362001)(33716001)(2906002)(85182001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm5NMDZ5anEvcVRzVzVZc0pFK203dGhsRW9uTXFjdGZpNDNYZ0lxOEl3a3px?=
 =?utf-8?B?ZTM2YjFjSE1UcDYzQzFVcUkyc1NnV0pKbVh6MWdDMUY5N0Q4RnNPQlV6WDdR?=
 =?utf-8?B?UndTT3BOaDlBZ1hqeG1nbFdLOCtIZjB1ZlcxU2tHcEV1ck55R2w0eG1FOGtF?=
 =?utf-8?B?THA4Qi9kRWJYZnY5TXZiWVBDTjJhWi93cWhYY2JuQUJlMTJ1UUNOeFlKODZN?=
 =?utf-8?B?NVQxbVQ4UEdrb3NhVlB5dDczMkF6bHJ0WHN1ZFZuRTVKZGltM0hrRnBudU1M?=
 =?utf-8?B?OEtrZ1hGSFB3Z2hmcTExN0xyeThsQm8rQ0lzUnk1RDVMOEdCYVdKUXkwMXZ4?=
 =?utf-8?B?Vy9rTVlGUjFudFphOTNFdWEyMHZSVklRbTRldXVzZmtReEwwN3I4OXJKUUlF?=
 =?utf-8?B?Z0N4cCtwZEtFcGpMTFczZVZhOU1YU2hka0ZPYTMzakFzak1hR2lmMForT0pp?=
 =?utf-8?B?cFNLa2NTZERpMENDRFc2S0NUVW1xcXFXd1ExaUJQb2pEZXc5MDhPQWg3UUtL?=
 =?utf-8?B?QVZnVFhuMU1EYVc3WmFzcVJiTjVZQW50MXFwN05jS2pHVlgxZnB3cFBVVk92?=
 =?utf-8?B?ZXBIdm4zcDkwL08vbFNqdzZvOC80QnlPSUhoRjg2Vnp0WVQ3ckxPVmU1ZnJw?=
 =?utf-8?B?d2hLU0lvMnVjRVhyaXkrT2k4d1MzVWFLaTYzNUhXYUx5ZlVyY1FQYXpucloy?=
 =?utf-8?B?c1BCVmxMYjAxZ1R1VG1Td3JwY3pySUpQNWF3dWljVzZLS0dMRmZqc0xKVDBJ?=
 =?utf-8?B?QjZpaTZ4eXFhL2dHcmtXdjhUYWVid3I2a2EvRmowZ1BMZjFNOEJJMnBpS1F0?=
 =?utf-8?B?N0grODNhN3VGc082NlMrRm1MdkJKbzVyOWdScEhtak5pNlVMZXl6OUVxWksx?=
 =?utf-8?B?TVFML3YyaGpkOGk1RlBTSXNxbVFtcklSVHl4T1NZbitjRWFuM21ySUNCMENG?=
 =?utf-8?B?clRoakZFUkJvVWlGQ0JpbEhCaEU3WkNOZXJYQmRKNVIrQ0h1blkxZ3NycWVo?=
 =?utf-8?B?YXZXVlVmTnZhenJVYUxLRzB6b3VyVW5jbHp3K1NXaGNkdTVRdnJxMk1KQjNJ?=
 =?utf-8?B?Qk1WalR6cDdBM1IrNHdkeitZcHN5UGhzTklOT1lYZUZvcXdCMXdrOEx2aFRO?=
 =?utf-8?B?UWx4b1VwTTVFN1l2U1g4L1BJYW5vSzRkaUkzc0NsUUE5Rm42R0tFbGh4Y1VR?=
 =?utf-8?B?azZWWEd0WUpycFZZUGdrVnVsWHRzU2dxd2ROQVFldkhMQ2xjcjR1Z0VMSkhz?=
 =?utf-8?B?SE9ZajVJNDZYOUMvYWVqMkpZdFFTVHJxQUFsZFNXUzhFV1JMV3NUZXFmekZB?=
 =?utf-8?B?cDZOakRndi9SWXMwcmRHNXhmU0JNYnYxeERLNWpqYTlZTURxTmxCSzN3UWRE?=
 =?utf-8?B?cUNLbjBlYlhsSFN1WDVuWkc3Zm4wdXNPZVlpZ2xrUzUvMSt6L241OHdSWCtt?=
 =?utf-8?B?UVZyY1NqQ2hZaHloSkNGWVdwbmJGeU9GclNUaXdvN1VuQ21Yam1tYWVVc1Vz?=
 =?utf-8?B?SEFsZmhYNVByRVlqNFlqZ01mQ204ZHFGZTlrdU81QVAydVA2dExWaHEzdGdy?=
 =?utf-8?B?cHZqTVE4M21RZU1xUThxMGpZd2tRQUxSVXhSVEdCYU8xRzIzMFVHL2w0YUV2?=
 =?utf-8?B?U1lhK1BrYW5VRGNwY044QVdjL0V2OTM5VzdaRDhNZlNDZ1g1U29SRzFsc2pw?=
 =?utf-8?B?M2tKdlR6eHlHeXVFcStIN3ZiOGt2ZWRSWmh0ZENzeGdSekFLa05yVTlzbUNp?=
 =?utf-8?B?cDNKNlduMTJGWjhhYW9wTGwvOTk1RDFPS1JoSG5aWlpQYWtJMFg0QXFwUmJT?=
 =?utf-8?B?K214VnE0TzJ5YlkwSWVvcFZTQmIxMFROYzR0MlNVUlNBVXd4L1M2N1VwRzk2?=
 =?utf-8?B?Um9GdXYvVjVSLzZNZGdETGtLN3pLaVVoeFFZNnA5ZTg1eU9TeEFBc1czZXZa?=
 =?utf-8?B?QnBSSHdIZWhoMTFlUG5oWU9IOVhlU3YwU1hvcGxNckZzZ2xHY1FNV2FNZGR1?=
 =?utf-8?B?Tkl0aE5kbjd2Yi9KL2RiNnpnZFVWWEpIVGFiYXM5ZFlONFlOR3AzcGwwYTNw?=
 =?utf-8?B?RnJRWlFlZDV4WUxlMkNiQmlXTnNjYm9renlxdEJhMTJGQTNDdGx4eVV1aFBM?=
 =?utf-8?B?Yk93U0NvdE5nNFlNUWdOZ1B1d0RoZ0NMZlZaaS9RM0xIU1pMaGRieEVueW9K?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YysvMmlUblhpWlEveVhHbTVKeVpmOEd3UnlMUUFiRGNSSElEdEhPQXlpQ2h4?=
 =?utf-8?B?eGppREZTWkUyanlNUGRJL0tzcFRHaFU2S0xUOWluYk16akJvTlQzT2UrSEth?=
 =?utf-8?B?bGN5L2huTklOVW1UYW9mZ2xGYjBGODBoZXRhSkF5UUtaTjVndnhRL1NDVlFz?=
 =?utf-8?B?bTd5cVJxM1VEbHhVVnAxelhHNHNkeXYyRkltSkFCQWFaZFVPWmpqR3hIakla?=
 =?utf-8?B?NHk0OWhMOVorL0tJZy82eTQxa3FhSUI2a1hrSDM5Ym1oR1hBT044ak5nZzdF?=
 =?utf-8?B?cnJCcVYxYnJ6aHRhYjJmbTFtWlFuVXRTZCtkeU1CNFRxdGFBWEIwczhwOEtO?=
 =?utf-8?B?WmZNYXMxTW03K0x0S2JhallaZzV5YmpyYkxjNEsyL2J0L2V2QTUrTCtVVVhv?=
 =?utf-8?B?Q2prYkpORU1NaXIvWWFoZE1pdlFoZGxnS3k5NjEvdnJScWZwYjEzOHIra3hD?=
 =?utf-8?B?VFZQd0tPeWU1MUowYThqK1BmNllrcG12OStqREJsV2lna0hNdHkxRUhQa2g5?=
 =?utf-8?B?cWhqdkhnZWhrS05ZQk5wL2ZyaGFiNVZLc0J1Sm8rODRNMDIzT25vUm05dlo0?=
 =?utf-8?B?enZXRTYzQ2pzMGdwdnljTm02QjBtenhaM2M1UU1BYWkxNXU1K084TzZ2RUsz?=
 =?utf-8?B?VHdBTjRhdTRTSXlMM1ZxUmFDM2J5bll6OEhSNXFuNHE2QUQ1REdESzFGcDRh?=
 =?utf-8?B?TnRVWEhoTk9Cc0IxU0JKWllhRmtLeG5EN2ZKSTQyekhMMG44UUlQZ1ZIeHYw?=
 =?utf-8?B?akltNHYrdVowZkRDaitEU3BIRTRqNEtvR3RTNEpydHZpYzVJb1lPL3JJY0dP?=
 =?utf-8?B?MHliamtia0FBc0ZPNThRUU5OMGkzZFdiRXdOYURUUDJMUEVDZVdWTWdWMTR3?=
 =?utf-8?B?SzR1WmFLcTBYZC8zdFdvdXBEUzQrait4a1NGU2JicEpLN0RlYkhKV1B2MlUr?=
 =?utf-8?B?dEI3TDlZTWs2VEdyNnR3bWJoVTFSVUZYL3U5aXZqaWkyNjN2UHNGYXdQTzN4?=
 =?utf-8?B?VDI5Wmlya0hxaC9lNEhsNmQ0dytFVmlhZzZFem1PT0tmaW8vaEJXeFFPc1Bs?=
 =?utf-8?B?UUo2a0NjYnRNQllwVG0wWUZNWWJVYm1HR1NJRm5qYnVaeWFVOHFZTHF5QVdz?=
 =?utf-8?B?cUx3ak9TMjNTR2VRRzd5bjFiZk5BYWxxYlRGK3FEbHFOckZxOVNVdGRpc0pU?=
 =?utf-8?B?cE4wclpnOUFCUEV6NmFCRnhGSFFBUjRDem9LUXFCeEpzcXZabUtjckVKVHN0?=
 =?utf-8?B?dEpUZnVHaU82N0N2Tk5MOTVVcjR3Y3VHRkVuK2x2cDVrcmtDZz09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a92e457-0e57-41c2-64fc-08db68006509
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6423.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 09:11:51.1063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDbJaNQ6GmtpULeYEdhhy+D1txRQFQPG3J1OPXhgq6JekeCDtbzJMyzyH8nusFK95yTFN5CpbvcW6hefzymvgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5873
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 12:29:26PM -0400, Demi Marie Obenour wrote:
> On Wed, Jun 07, 2023 at 10:44:48AM +0200, Roger Pau Monné wrote:
> > On Tue, Jun 06, 2023 at 01:31:25PM -0400, Demi Marie Obenour wrote:
> > > On Tue, Jun 06, 2023 at 11:15:37AM +0200, Roger Pau Monné wrote:
> > > > On Tue, May 30, 2023 at 04:31:16PM -0400, Demi Marie Obenour wrote:
> > > > > Set "opened" to "0" before the hotplug script is called.  Once the
> > > > > device node has been opened, set "opened" to "1".
> > > > > 
> > > > > "opened" is used exclusively by userspace.  It serves two purposes:
> > > > > 
> > > > > 1. It tells userspace that the diskseq Xenstore entry is supported.
> > > > > 
> > > > > 2. It tells userspace that it can wait for "opened" to be set to 1.
> > > > >    Once "opened" is 1, blkback has a reference to the device, so
> > > > >    userspace doesn't need to keep one.
> > > > > 
> > > > > Together, these changes allow userspace to use block devices with
> > > > > delete-on-close behavior, such as loop devices with the autoclear flag
> > > > > set or device-mapper devices with the deferred-remove flag set.
> > > > 
> > > > There was some work in the past to allow reloading blkback as a
> > > > module, it's clear that using delete-on-close won't work if attempting
> > > > to reload blkback.
> > > 
> > > Should blkback stop itself from being unloaded if delete-on-close is in
> > > use?
> > 
> > Hm, maybe.  I guess that's the best we can do right now.
> 
> I’ll implement this.

Let's make this a separate patch.

> > > > Isn't there some existing way to check whether a device is opened?
> > > > (stat syscall maybe?).
> > > 
> > > Knowing that the device has been opened isn’t enough.  The block script
> > > needs to be able to wait for blkback (and not something else) to open
> > > the device.  Otherwise it will be confused if the device is opened by
> > > e.g. udev.
> > 
> > Urg, no, the block script cannot wait indefinitely for blkback to open
> > the device, as it has an execution timeout.  blkback is free to only
> > open the device upon guest frontend connection, and that (when using
> > libxl) requires the hotplug scripts execution to be finished so the
> > guest can be started.
> 
> I’m a bit confused here.  My understanding is that blkdev_get_by_dev()
> already opens the device, and that happens in the xenstore watch
> handler.  I have tested this with delete-on-close device-mapper devices,
> and it does work.

Right, but on a very contended system there's no guarantee of when
blkback will pick up the update to "physical-device" and open the
device, so far the block script only writes the physical-device node
and exits.  With the proposed change the block script will also wait
for blkback to react to the physcal-device write, hence making VM
creation slower.

> > > > I would like to avoid adding more xenstore blkback state if such
> > > > information can be fetched from other methods.
> > > 
> > > I don’t think it can be, unless the information is passed via a
> > > completely different method.  Maybe netlink(7) or ioctl(2)?  Arguably
> > > this information should not be stored in Xenstore at all, as it exposes
> > > backend implementation details to the frontend.
> > 
> > Could you maybe use sysfs for this information?
> 
> Probably?  This would involve adding a new file in sysfs.
> 
> > We have all sorts of crap in xenstore, but it would be best if we can
> > see of placing stuff like this in another interface.
> 
> Fair.

Let's see if that's a suitable approach, and we can avoid having to
add an extra node to xenstore.

Thanks, Roger.
