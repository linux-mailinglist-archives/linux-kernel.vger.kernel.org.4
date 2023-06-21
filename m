Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD2773817A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjFUKJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjFUKJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:09:29 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E7D2693;
        Wed, 21 Jun 2023 03:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1687342098;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=EAc0q8FOvJgGqZN0p1c8AEES6bphAGij6ylWipMW9CU=;
  b=aZdxJhsnHfJ5PpdpC4DXw8BdDmTey6NmI2Q/hOFAQU0Kg0HdAM1BRWzN
   DND17l+4A7sb2X9k5OaaeRx/VQmHZUWzHZ3wnMuWmJKyf9GpXX3sGi3pd
   Hqi5X5khBHsERBdvT/X8s0UdeusOpjbIAiFE4fZe9vpRv+D8EyHTwuzyA
   w=;
X-IronPort-RemoteIP: 104.47.55.105
X-IronPort-MID: 116155715
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:njymha5VbyXT3IgsTX8J2AxRtHrHchMFZxGqfqrLsTDasY5as4F+v
 mMdC2HVb/+MYGqkLopxaNizoUtUvMfVn9dhHQRo+SA8Hi5G8cbLO4+Ufxz6V8+wwm8vb2o8t
 plDNYOQRCwQZiWBzvt4GuG59RGQ7YnRGvynTraCYnsrLeNdYH9JoQp5nOIkiZJfj9G8Agec0
 fv/uMSaM1K+s9JOGjt8B5mr9lU35JwehBtC5gZlPa4R5QeE/5UoJMl3yZ+ZfiOQrrZ8RoZWd
 86bpJml82XQ+QsaC9/Nut4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5iXBYoUm9Fii3hojxE4
 I4lWapc6+seFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpdFLjoH4EweZOUlFuhL7W5mp
 eIicxtQZDq/t++15ZfgeslKl8cNFZy+VG8fkikIITDxK98DGMiGZpqQoNhS0XE3m9xEGuvYa
 4wBcz1zYR/cYhpJfFAKFJY5m+TujX76G9FagAvN+exrvC6OkUooiOWF3Nn9I7RmQe1PmUmVv
 CTe9nnRCRAGLt2PjzGC9xpAg8eWxH2iBd9NTeDQGvhCq0HU/E88WSQqChinuaaczRS7XI9bN
 BlBksYphe1onKCxdfHxUhi5iH+CoB8HWtBUHvE66QeC0a7d6UCSAW1sZjdRYtsrnMw7Xzon0
 hmFnLvBDDNsmKeYRXKU6vGfqjbaETMTLHMQaDUsTgYf5dTn5oYpgXrnQtMmHKOrg9ndAzz8w
 zmW6iM5gt07iMcR0qyh8FPvgjSyp4PIRAo4+gXWWG2+6gpzIoWiYuSA7Vnd8OYFJoKeRVqpo
 ncJgY6d4foIAJXLkzaCKM0JHbe097OGPSfajFpHAZYs7XKu9mSlcIQW5ytxTG95P8BBdTL3b
 Uv7vQJK+IQVLHasdbVwYY+6F4It16eIKDj+fvXdb94LZ4crcgaCpXlqfRTJhz2rl1Uwm6YiP
 5vdadyrEXsRFaVgynyxWvsZ1rgogCs5wAs/WKzG8vhu6pLGDFb9dFvPGALmgjwRhE9cnDjoz
 g==
IronPort-HdrOrdr: A9a23:RcWz/avXxl96dOci9RaCUapw7skDstV00zEX/kB9WHVpm6yj+v
 xG/c5rsCMc7Qx6ZJhOo7+90cW7L080lqQFg7X5X43DYOCOggLBQL2KhbGI/9SKIVycygcy78
 Zdm6gVMqyLMbB55/yKnTVRxbwbsaW6GKPDv5ag8590JzsaD52Jd21Ce36m+ksdfnggObMJUK
 Cyy+BgvDSadXEefq2AdwI4t7iqnaysqHr+CyR2fiIa1A==
X-Talos-CUID: 9a23:PayOz24xSRS5i5rzkNsspFAuQet4eFfh/HrTBmrjOUZPWb67cArF
X-Talos-MUID: 9a23:c1HS8gRPFNuQepTwRXTHmHZYF+g52pjxS1wVzrBB4cyDaChvbmI=
X-IronPort-AV: E=Sophos;i="6.00,260,1681185600"; 
   d="scan'208";a="116155715"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jun 2023 06:07:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SM59qhdzng0cl4rm1c8o3VqPQrJnDRblnoQbo+Ahe1gwTXq+syP1nI97RqNSxAIuhn/qPkeARU46CYC8lj0MtHMcAkvj4Z0Xk2sZVI2sP7h5ZXk+mu/PdDV09J6e/wW6xcmRCupxdUo1q9dT+a1UAioXftYjOzzd9tNAejrVIiVxJhLpZXxlbfwKXU1wSz6J0ua3aH+UvmRwJgNgE1zKed5T7cnbo2MdszjTxw19gztlvgo80RMayg/1WwseDP7Gv9Zzb8oqtQuNhI1JW2nahXMkGznTQFFjOix3veBA1vOjuMY5ippAQ1vgvwsqmcJA856doeV8GPyFj3swYe01uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgorcOhVAWPKSD25OVlXAg1i+IhLQ79OGbg8fRxYPLM=;
 b=O81kNAK9f1JgUur1IqZXZ83OGGd4lUILjcYYIygnLgi9WslCDxD/xdTkjGlH7DUAZMgshOqcPEW0aNOzLxrzLVmK0oKk13iDvXnN6HpXYadrzU4evkb1850x1KAI+295cJFioCPjUAc5X530PlgsUsU/jqbA8SpqTksF2zHGcjRIxqJZ0+VOZOBiFOgF4UcMaxsqWAMmCrkffyTTSec5vlhCuCMDuu8Z8c8wHCzINpQTIgnJhmxBhf+5GxIsgWHXnjanmb+mwhIj/aflROPsFItL71uK3/KrgE7UuM8AH/D+dp81CbzotNt+mFaF/T+l/n4kbiYYOGYzutBUP/XfJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgorcOhVAWPKSD25OVlXAg1i+IhLQ79OGbg8fRxYPLM=;
 b=MyOsw+HYH2L9Tm0Wr/+8kvIt6dvBOJ4hXNi37LvqBGzXC3W1+CJnkzQgKvXu/ZRyw23wk/Ba8lhyUFLqEbqb9ibo7g/A8lP+HBcGYcuELntnuuTOUaZT50BU3Xmj1ytjZgdTSS2BgntPxdFhvdELhgRvneE8Mmmtb5br7sAa2GQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com (2603:10b6:a03:38d::21)
 by SJ0PR03MB5662.namprd03.prod.outlook.com (2603:10b6:a03:285::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 10:07:13 +0000
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::1c83:1877:a68b:8902]) by SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::1c83:1877:a68b:8902%6]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 10:07:12 +0000
Date:   Wed, 21 Jun 2023 12:07:05 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 13/16] xen-blkback: Implement diskseq checks
Message-ID: <ZJLLyVasQ/MAXFDI@MacBook-Air-de-Roger.local>
References: <ZH7tizoYl8YVFN9B@Air-de-Roger>
 <ZH9mZGbM32CDmKGF@itl-email>
 <ZIA9uBJxx2gqA4Cq@Air-de-Roger>
 <ZICs+WYCPYdu2yoI@itl-email>
 <ZIGRXrSGmgLF/07O@Air-de-Roger>
 <ZIH0yQCICZRpliSc@itl-email>
 <ZINBqToBZVdfmr0e@Air-de-Roger>
 <ZINZj8ubQj7yFxdR@itl-email>
 <ZIbSw44a8Te27BP3@Air-de-Roger>
 <ZJJO8zUBhd8QrQYL@itl-email>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJJO8zUBhd8QrQYL@itl-email>
X-ClientProxiedBy: LO3P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::7) To SJ0PR03MB6423.namprd03.prod.outlook.com
 (2603:10b6:a03:38d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6423:EE_|SJ0PR03MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ca49a4-bbcc-4bdf-9a93-08db723f484a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rQKkm+MI7DrL/X5YXJhCIKlPRS7ba+BirSnguTln6HEQjOhRIocqZqZ4n0rGFa6GXV6hQ16JGM4jE4S+5yEv7DjvYYid1QQhHmqmDGOkl82ld5hfe/9qWXlWkQMZ+BtP9u5ZPMEOmqT6qRqIXWSZh5v8B/1/EYvHgQxTFMdworPpipah23tNMNgSZGFndFyiKNkzR9IJVzikNYbqy73HgUMHO+20SKdSyrziZunbPV1C0gl8RPtcrzsH9Bt62eXYtqrpDf9lHMmub5015EzDaPsRO/4/CxoIw5b+jRjvmvMIODIKQ+FPQ6cUlB6YDJoFtDQKmP3x3o9I7zHfQxRSW4IL1e1TKLTAM4NXzmgGWz7/bX7QUwbo6Dukb+jnXSTSguXKxyz19dffHbTq5SLRcJTcS6rcSGYJpxAIP0Y4DEzNu1vg+TkYTVpj68R4vl6zvYj+PgqGgJOOZLJmhGCNn9f4sFJM/CzHLvpjVXCWyH6gjc/7wUiDzSIqWOt5MR6YQzTlPKgEDwOSf+8dWPlD1pZwBc4mI4+yBVmOiC5MqifamkzAQQubAUvUQg6yRQxh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6423.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(2906002)(8936002)(8676002)(86362001)(316002)(4326008)(6916009)(85182001)(66946007)(66556008)(66476007)(478600001)(82960400001)(41300700001)(54906003)(5660300002)(83380400001)(6666004)(38100700002)(6486002)(186003)(26005)(9686003)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnVRMmNET2lFQS9oN1B3L3J4TEgyWWtEOXFXUVQwLyt1YzdIcnF3YThjaDNy?=
 =?utf-8?B?NCtqTXhjQUZrVnp2RUxCRC9neHA2SG1yb3RUbzF1alplVFQwM2l5QTB5aExZ?=
 =?utf-8?B?Q1NNa3hxRlhHck5rdmRxL1J2RVlBUEh2T1l0QjN3Rmszd01uOXc2UHJiUzVQ?=
 =?utf-8?B?amhaUDBydnhZWlpPQUozYXBSVktYMDlHYm00YnZqNHM2OUVOTy9vZ2Z4dWZZ?=
 =?utf-8?B?b0FVRnNOMDNUdld3T2VUc0wyNlhhVGlBdit0cExFbndpTE1PMnc4TDExRU1x?=
 =?utf-8?B?NldlNkhiOGNCbHUza01DTXJiZkNsSkZEQlVhcGFXSlVob1EyNk1mRTYzeXBa?=
 =?utf-8?B?S1hJemIyV2Z0QjFvZzJpb0czTWREWGI2WjRENURySGs5Z2czYUVZQ1RPdHRI?=
 =?utf-8?B?YnZ3YnplS0RBYWw0ZTYwQlBFWW56YW9Uakg2Y2V6MGdvN1RlUW1UMFU3VXVw?=
 =?utf-8?B?VFZzakNJNlNRQ1cxNG9uQjFlNytJRUYrM3lvZkZoZFh0dHhQaUw1NzJoS1Y5?=
 =?utf-8?B?SHVJMFFjVXkzNEkyeWs2eTY3QXlTdU5nSXZjU1pDWnlhQXRzK3AxVzdiQldF?=
 =?utf-8?B?WEFOaE43V0R0WVg4YjZEK0JIbFlvOW1HaTdvUWN2WkZ4UFg0djdGUTVXaTIr?=
 =?utf-8?B?YklGL2NEcVB4a210QTFMdm5wNTFmblY1SkF4RElVVlh4SDJzTGNmbFBBYlVJ?=
 =?utf-8?B?R1J4Y3h1WDNVbEpZL1h6VDJsa1RJSm1XcVVYYURXTjJ3Ukh0T21abDNLQmJo?=
 =?utf-8?B?NGJ3N0lVa01XN0p5TmtzTkY0ZEUvK0tRVlh0Q3YwTmNyN1A5Yjd3ZjNxWWM4?=
 =?utf-8?B?OTZINXVxaU5INjk3QjhHa1JqRHd4a2ZtZkR5L1hhcUVNZTR3VWVmd25tZVpL?=
 =?utf-8?B?N0d0VE41VXFGcW1PMkE2K3VUdGpmWXppbWQzRVUvdmlFY0tZSWgvVmZhVngz?=
 =?utf-8?B?OHROeUUwdkwzWGlWSk41R2ZVVGY1QnlMTm5IMUYyaGppcUloOWxuazMwbVEy?=
 =?utf-8?B?K1AyS0k2MWtNUDV5OFk5STNCelIwamF4K2RQK0szRkIySzNFZEZHd1dhb0xk?=
 =?utf-8?B?ejU5ZTE3eGVhZU0rTWpzVloxVWRhZEprcDdJem1Zc2l2NktDd2tHUnlwTFNm?=
 =?utf-8?B?Mm9DNW14Rlo3UFU3K2JOTmxhbmFHUWEyQUJNMGNaa1BKR0hibjBobkltZ2ZS?=
 =?utf-8?B?OHcyWEZIbXFRUkMreUhXSGYwRlhlcFlMc3hOVkl4UUdybVpiTENNbXZPcDMx?=
 =?utf-8?B?WjlnamgvRGY5MjJkM2tuTVovYXRIZlp0QWx6VG1mK2RldGxBaCtTaklpTFBG?=
 =?utf-8?B?eWtPc2JYbDh5d29BVE9jYU1KT08wNXFLZkZCcTA2N21rblFjVm5wSU5ZK0Uw?=
 =?utf-8?B?Ymx5eWx2cXNmWmh5eDl3R04zZE1HeTZWaWR6Um1TVkIwZjVwVkFxYkNkenVX?=
 =?utf-8?B?OGFUSHlPT2J1VEtMTTZIYkxNTkdqN0JhRE9CK2w5RVlsMW5wYjhtYzZGa0Rp?=
 =?utf-8?B?SHVUdUwwc0ZTTUlZelJ5bitRaXFjaElUQ09yQVdQODl4ZVErUTdQSjV5VXY0?=
 =?utf-8?B?Y240YWNWbVUzZERqMmEyeWllR2VRUTJoL1BOcEdlbmxYVzYyclQ0eERLWGN5?=
 =?utf-8?B?RUIzdTNEU1FZVXhXeGdIYTJDVUJaU3FMYVJZbm9ockpXVU5JR1orVFNZeHEv?=
 =?utf-8?B?WjZnaGtWSWw2VWt1TEs3NjFEems1UTVKN1NNUGltTFIxRmkxSjRKVXR5ZUFZ?=
 =?utf-8?B?SnM5aWlieU9obGN2aVJhejNyK2l4enF1dkRFYUhUUjEzd2JHUUh2VmFIZkRs?=
 =?utf-8?B?NWMzWWEzSit2SDFtNWovNHJranZnU3hiU2lXWXFWNGRWdG9BRGdSOUNPWFRq?=
 =?utf-8?B?ai9vVGwreExtR0FQNFhXZzh6N29yZ2tZb0U2MjJRRzE1ZllPa2tmZGlucldU?=
 =?utf-8?B?a0lPYXZ0SkllbWNacGt5M1pSRTZpY25RZWMzcVJvcjV4eDI4U3BJMlFSR0J5?=
 =?utf-8?B?aHpHK1RpYlhyUmR1bjdhc3ZZSEQ3TkNHYzVMRTM2ZmQzeXFEQS9BZlNXSWFs?=
 =?utf-8?B?eXlpWWhrZmNhRVR4MlVKM0FKWExJRy9QN1A5RTR2bzR4dlBDMUxuNzQvTm5k?=
 =?utf-8?Q?1WXVvA0WKPGUMynIXI1x7xkOl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZDhjUUZHMnRjcmxFY1oxYkJGMmZ1WWNydEpta0RYbmRCVzFOYzd2ODdYR3NP?=
 =?utf-8?B?KzFGdXd1L21LUkxWUjJ3ajJNRFltWFVMOXk0eHdsSmI1bTQ3ZnZnaUgxTVIr?=
 =?utf-8?B?K3RrRWZqNEc0bTRXKzNnTkE5azRpaWd0UEFSZDA2NEZyREJSSVNqc1JBNGE3?=
 =?utf-8?B?eFJST08rSEVHTmc3aVJGSHZBMGFCVEZ2aWRoeXFMVlNHSERTdWtPZ1FucHdF?=
 =?utf-8?B?Wlp4dFFNQytrck0raFRqaS9PYWtQVE1ZSktTaWoyR001cVR3MzQ4QXdwam9L?=
 =?utf-8?B?SUFEMEh6bkREVWxSSGJkeC9sNDN0N1BjZUcxaUx4VXd5NkpQSCtFM3FWamF4?=
 =?utf-8?B?UW1mY0xVbkhEOHJzOVYvQjYzVU5OSm9VMHdES0VsWGN5Qy9BZGt0WnoyTVF0?=
 =?utf-8?B?Q25iZnFVL1l6WDhsRTFuTGZVcjJVenpsNXlVYVNmUFYyd3dMVmdLbk1mMXJH?=
 =?utf-8?B?eVFRZUhueFVWcmJhdlEwUmdDTnJYbkxieFFDRlRQTHJ0dTFvZ3hGTU5FbUdq?=
 =?utf-8?B?M0JSUmZKcEdDWUhDZVE0OFgwVVFYQjNua3A2VGN0VEZuNWRNSXhIME9mbWZ6?=
 =?utf-8?B?cjB4V0tiZW40OERnOGkzdzVtVUZ4OXBlVjdJS08ySHJqcHVSQzcyVHpLM3Bo?=
 =?utf-8?B?bEFUY2hiRDVic2x5R2FzOXZsVEhhYUN6WmNqckllZVR0NzV2MTlRaUYvUEdi?=
 =?utf-8?B?Z1dzSVRSR2t6Z0JZblNhN3lLU1UrdDBodGdLS041a1ZBMXQ1Z0YzOGV0bFhI?=
 =?utf-8?B?S2RNU0FBZzR0NDNodWUrS2c5b2xVWnF0SVdQaGNHQUszTW14WHcvWXJPZG5K?=
 =?utf-8?B?US9lWTFPS2FqUldYNDdKRjgvd0hIYnk5c0ZUSk53OEV4a0RMRjdxLzNrZnpE?=
 =?utf-8?B?SUNnbDh2Y2p5YmZpSmQwSnkyeWxaSnY1UUp2ZEd2TG1td0NHbi9ZMHdlQit5?=
 =?utf-8?B?ZDhzQTBycDRYSi9LdEtOdWFrVWx6cFpCUm1yc2ZibmdkbEtiVUVNczhhTnU2?=
 =?utf-8?B?YTA5WW5kQ0UyTGhuV1lxeHg0NnQvc3NxbDU3c3RYcEdTWm9LQk1sU0RNZ20y?=
 =?utf-8?B?MTlKa2NoME9aR25VSjRBS05lM2JrNVorQnNseC9nNUVvUmNzUzhENG96S29u?=
 =?utf-8?B?aUEzZjB2Qm9SRTJZL2d4Unc3UnNwSHo4OEFCM0dQdm5NK1owa3BlSVR3dmJx?=
 =?utf-8?B?ZzFaV05oNE1CcmlsVVdyNVhGWTFjallZb0hlKzFvR2NOUDB0SElON0Vwb1po?=
 =?utf-8?B?clhmSlZZOFU1RnBacnRrRVpQMkY2ZXJTWGc2MzRuSCtldjFSUT09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ca49a4-bbcc-4bdf-9a93-08db723f484a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6423.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 10:07:12.7439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofCEiguSbBas1Pdunm3JZhuGqnRmG8ilmdrf8zT6CrSPPNYZkWTqarwNMD/EjqlDi6rXpVqufAKraYtYMIS9Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5662
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 09:14:25PM -0400, Demi Marie Obenour wrote:
> On Mon, Jun 12, 2023 at 10:09:39AM +0200, Roger Pau Monné wrote:
> > On Fri, Jun 09, 2023 at 12:55:39PM -0400, Demi Marie Obenour wrote:
> > > On Fri, Jun 09, 2023 at 05:13:45PM +0200, Roger Pau Monné wrote:
> > > > On Thu, Jun 08, 2023 at 11:33:26AM -0400, Demi Marie Obenour wrote:
> > > > > On Thu, Jun 08, 2023 at 10:29:18AM +0200, Roger Pau Monné wrote:
> > > > > > On Wed, Jun 07, 2023 at 12:14:46PM -0400, Demi Marie Obenour wrote:
> > > > > > > On Wed, Jun 07, 2023 at 10:20:08AM +0200, Roger Pau Monné wrote:
> > > > > > Then the block script will open the device by diskseq and pass the
> > > > > > major:minor numbers to blkback.
> > > > > 
> > > > > Alternatively, the toolstack could write both the diskseq and
> > > > > major:minor numbers and be confident that it is referring to the
> > > > > correct device, no matter how long ago it got that information.
> > > > > This could be quite useful for e.g. one VM exporting a device to
> > > > > another VM by calling losetup(8) and expecting a human to make a
> > > > > decision based on various properties about the device.  In this
> > > > > case there is no upper bound on the race window.
> > > > 
> > > > Instead of playing with xenstore nodes, it might be better to simply
> > > > have blkback export on sysfs the diskseq of the opened device, and let
> > > > the block script check whether that's correct or not.  That implies
> > > > less code in the kernel side, and doesn't pollute xenstore.
> > > 
> > > This would require that blkback delay exposing the device to the
> > > frontend until the block script has checked that the diskseq is correct.
> > 
> > This depends on your toolstack implementation.  libxl won't start the
> > domain until block scripts have finished execution, and hence the
> > block script waiting for the sysfs node to appear and check it against
> > the expected value would be enough.
> 
> True, but we cannot assume that everyone is using libxl.

Right, for the udev case this won't be good, since the domain could be
already running, and hence could potentially attach to the backend
before the hotplug script realized the opened device is wrong.
Likewise for hot add disks.

> > > Much simpler for the block script to provide the diskseq in xenstore.
> > > If you want to avoid an extra xenstore node, I can make the diskseq part
> > > of the physical-device node.
> > 
> > I'm thinking that we might want to introduce a "physical-device-uuid"
> > node and use that to provide the diskseq to the backened.  Toolstacks
> > (or block scripts) would need to be sure the "physical-device-uuid"
> > node is populated before setting "physical-device", as writes to
> > that node would still trigger blkback watch.  I think using two
> > distinct watches would just make the logic in blkback too
> > complicated.
> > 
> > My preference would be for the kernel to have a function for opening a
> > device identified by a diskseq (as fetched from
> > "physical-device-uuid"), so that we don't have to open using
> > major:minor and then check the diskseq.
> 
> In theory I agree, but in practice it would be a significantly more
> complex patch and given that it does not impact the uAPI I would prefer
> the less-invasive option.

From a blkback point of view I don't see that option as more invasive,
it's actually the other way around IMO.  On blkback we would use
blkdev_get_by_diskseq() (or equivalent) instead of
blkdev_get_by_dev(), so it would result in an overall simpler
change (because the check against diskseq won't be needed anymore).

> Is there anything more that needs to be done
> here, other than replacing the "diskseq" name?

I think we also spoke about using sscanf to parse the option.

The patch to Xen blkif.h needs to be accepted before the Linux side
can progress.


> I prefer
> "physical-device-luid" because the ID is only valid in one particular
> VM.

"physical-device-uid" then maybe?

Thanks, Roger.
