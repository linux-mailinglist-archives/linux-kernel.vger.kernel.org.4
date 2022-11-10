Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F415C624719
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiKJQdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiKJQdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:33:11 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 08:33:09 PST
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBC632070;
        Thu, 10 Nov 2022 08:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1668097989;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=/ajotvBabRkAJRa8WyNoPM3w5dHVQCnNTELU9LsS+qQ=;
  b=PX8lK+UASA4bjdERL9gL/tka2s2CfFekS7cGIzOK6e8j5a1LJYymJNUB
   Al4JfYMHbfiNLRnRAP91Kgc5O2f0/qEos1VdBEfSt8ECjMzHrZonpPHh/
   cOfsHBI7jQfHzi/CoYmoyOFdAynUbY3LxJHWtTvuTy/VHp2ZkmsPq8w8t
   M=;
X-IronPort-RemoteIP: 104.47.55.172
X-IronPort-MID: 83651182
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:xxNJlq1BWPIEkHSv9/bD5c9xkn2cJEfYwER7XKvMYLTBsI5bpzwGz
 jQaWjyDOfeCM2Twed8lOoW/9kkGvcKBzdAyHVA+pC1hF35El5HIVI+TRqvS04F+DeWYFR46s
 J9OAjXkBJppJpMJjk71atANlVEliefTAOK5ULSfUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8tuTS9nuDgNyo4GlC5wVnPagQ1LPjvyJ94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD9IOaF8/ttm8t4sZJ
 OOhF3CHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqFvnrSFL/hGVSkL0YMkFulfCkpxx
 NckDjs3c0rbiaWRnaK6dPMyr5F2RCXrFNt3VnBI6xj8VKxja7aTBqLA6JlfwSs6gd1IEbDGf
 c0FZDFzbRPGJRpSJlMQD5F4l+Ct7pX9W2QA9BTJ+uxqvi6Kk1YZPLvFabI5fvSQQspYhACAr
 3/u9GXlGBAKcteYzFJp91r83bGSxHqrAur+EpW4zK53nFOUn1ciGQMkfwOckOKzlQmHDoc3x
 0s8v3BGQbIJ3EiqSMTtGh61uniJujYCVNdKVe438geAzuzT+QnxLngJSHtNZcIrsOcyRCc2z
 RmZktXxHzttvbaJD3WH+d+8rzyoPjMOBXQffiJCRgwAi/HvqZ8yglTCCNxkAIaxj9voCXfxx
 SyHqG41gLB7pc8R2qO69hbdijCqq5XSTiY64wzWWiSu6QYRTIKseY2kr1Wd5/FQBIefUlSF+
 nMDnqC27OwDApaAmCGlWugBHLi1of2CNVX0hFd1HJY78C+2032uZ4Zd5Hd5PkgBGs8CdSXoc
 QnIuQ5P759eOnitRat2ZZ+hTcUs0aXkU9/iU5j8dcBPZJlvfRTB5ChoaVSNwWnhmWAokKciK
 dGad9qhCTARDqEP5CKyTvsT1qUugywkxH3eX9Xrn0qPz7WTfjiWRK0DPV/Iafo2hJ5ouy3Q+
 tdbcsGMmxNWVbSkZjGNqNFJa1cXMXI8GJb67dRNcfKOKRZnH2dnDOLNxbQmeMpumKE9evr0w
 0xRk3RwkDLX7UAr4y3RApy/QNsDhapCkE8=
IronPort-HdrOrdr: A9a23:hBLtdq4lm0A39770MAPXwSeBI+orL9Y04lQ7vn2ZFiY5TiXIra
 qTdaogviMc6Ax/ZJjvo6HjBEDmewKlyXcV2/hpAV7GZmXbUQSTXeVfBOfZowEIeBeOi9K1q5
 0QFJSWYeeYZTYasS+T2njDLz9K+qjjzEnHv5a88587JjsaEJ2Ioj0JfjqzIwlTfk1rFJA5HJ
 2T6o5uoCehQ20eaoCeCmMeV+bOitXXnNa+CCR2cSIP2U2rt3eF+bT6Gx+X0lM3VC5O+64r9S
 zgnxbi7quunvmnwlv31nPV7b5RhNz9o+Ezc/Cku4wwEHHBmwyobINuV/mruy00mvim7BIQnN
 zFs34bTrdOwkKUWlvwjQrm2gHm3jprwWTl00WkjXzqptG8bC4mCuJa7LgpOCfx2g4FhpVRwa
 hL12WWu958FhXbhhnw4NDOSlVDile0m3w/iuQe5kYvGrf2UIUh4bD3wXklX6vpREnBmc4a+a
 hVfYnhDc9tAB6nhyuzhBgv/DSuNk5DbituDHJy+vB96AIm4kyR/3FouPD3oU1wi67VM6M0gd
 gsEp4Y5o2mHfVmGJ5VNaMmffadLFDrbFblDF+ySG6XZZ3vfUi94qLK3A==
X-IronPort-AV: E=Sophos;i="5.96,154,1665460800"; 
   d="scan'208";a="83651182"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Nov 2022 11:32:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3oXtMg77lXL9aexkF0fEWovV60EY6CZfI++HBlXsWzr/Z/DSi+/Bs7dcr6vMW+LGj5DgKOPRl7ufyLPxJlR4lFo8/53E5SkoH3DW+c/t5RkqClUx+jHa12FeqnhgRRqmrhWeWayq3hZiBvi6Vssa6gxTZu/ee8iANttu9Cc8bsP3gPypzC1kiLOkV2klxacLjYsuwY7AnXgnCvAcjhh9xSpnnhoMBpa1fUHP3B7VR0fKagVZOzZbfuVcwv8oZvFYXsiJQ4UXUE+xvCKB1t9/ipdV5bLKp/eTko58lKf4dC/OC6XAqlZ2WeHaeH0Dc+aG9YpPQO9HzfVB9kUMQI7+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anhVgeEpURpP2uRlzZ2W5M+ywycrkzKb3c1lNsONauU=;
 b=ODH52CuwS8nvfMmbbLeYwQb2zkEJ0MWvEo5MjZyx+dWrg4PBRQZYzWrM/ifHPGjVyR0z49C+DJt460xwaBKIzT10Sy9brexzLWbbnGxPbErEnD0EXKOAFVREz/ZLA1EPMYvCVgR+k4ZcCmStGDmNx32x1l5i2oYegs/5VwpKS6/8Xn/m0l0XM3cTqX+b4dUeCF5TwCGKI8K7J/aSxWnbFoL5lP+j/eeubQ0n6xo55JzdTF0KjcG7Mlb5XnhnQJNZAWvOq95I99Yadnkq4G9vs9+WRDxx5QQfwN5TJel1Qswmx6P38yRJLBXnutsqpKIQL8BDT1tFIX0h4XlFXAf/qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anhVgeEpURpP2uRlzZ2W5M+ywycrkzKb3c1lNsONauU=;
 b=M+yd9u8UCzTeCFoJKiz50I7VGVcfXZyZhMje8EbZvnqB74dHbV+c0N6v+WSJ3o6KotR++e85V4LEuZ7txrBezbhf5OhWVRkAHe8TnP+WxqQPGNXBcamnDe9+tN2aNi9RTP+E+QpDdd/63DC3wqwtJgefKfYOASkqfPHv1WG0MdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by SA1PR03MB6545.namprd03.prod.outlook.com (2603:10b6:806:1c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 16:32:01 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::d197:992c:4dca:3c4c]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::d197:992c:4dca:3c4c%6]) with mapi id 15.20.5791.025; Thu, 10 Nov 2022
 16:32:01 +0000
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, jgross@suse.com,
        Roger Pau Monne <roger.pau@citrix.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v3] platform/x86: don't unconditionally attach Intel PMC when virtualized
Date:   Thu, 10 Nov 2022 17:31:44 +0100
Message-Id: <20221110163145.80374-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0340.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::16) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|SA1PR03MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: fb50074d-7b0f-416a-6aba-08dac339181c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3eBEcCx3nG7+hZ0i7ZYqER5qRygPZtLH0anPwtWdKqLGpQEok8n4K6xR/UeVnjx48OSx8IPx9tQa6tdqgKcX27xq4rRV1JP4A4cP21q7bOyAQJInINL47oHgZJHN8x9MHEPvRE7wlyXx1gba/8FERhqzTNstbvfF7leyGZH+xuysy6sKu2eqB1m2M+YkY9EUFRAzeQ6ZOcX5IvtzU4SG/TKuGZPzgkXgSophPb1XGCu/lWOc+FYueO1ySN+Vp3YvsZV5aeYOpqSqwW5zTxihdpRSNCGSDAAoTjnrEyOz4BDZjA7jm3suKjVyhlJH4BGI0XMKjCNE5Ii03SLVhHyxOY5mMDOhK8Y/yRoUdnlHtfXVTNiivvJT2xp20fvn6n0CgotlZiOtF15u8n9fbwThXtKW0LsYexYvBgsJnbR5MXC4K51jR2Bu5l47xvWEH7W+PdeQ7N41HWXeLPN3TMKv3v2RUy8VwsUaDgSO7QYIoMkTG1ZNxIUEu6Wf6DptgMY5IosnC28t50pYA7t4ti+uau+vkCfvHZQSCb2n0vIlumdW9VECbELC827ktdueyaUKm1yWFXqmPp5JSA0yx65Y9036EDGOynBopDyjaKJO/lawTTajLw+aKJhJnp54T2hWD103EMBSRVZ/kI+tgZCjSb4DV0JM8FVIr0JSPzkm1fnyY0QAIgr+3fAYnT1wGwWMHCqtagao1QeMVaBgNrWlCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199015)(82960400001)(38100700002)(66946007)(6666004)(66556008)(8676002)(4326008)(66476007)(41300700001)(2616005)(5660300002)(7416002)(316002)(86362001)(6486002)(478600001)(54906003)(6916009)(1076003)(186003)(83380400001)(8936002)(2906002)(6506007)(6512007)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGhpNnVaeG12aGdUcjRyNUZ2L0FpaVRHUHZwMWdVWG81eDRDWHJDMmUwTnY0?=
 =?utf-8?B?dXFpOThUK0tmK1JSenp0TDF6NXR6Tk03YlVSNW82dnhRWGF4RVVaVDNOWFVv?=
 =?utf-8?B?WU42TkRIcDNLZEM2YmN3OFZxMDIvQVhIaU03cmxHZW50clV6QmxUcWFacXN4?=
 =?utf-8?B?WGhTaGRlODFGYmxuNUdyZ3Zkais5NjhPZGNLUXBSaEZGS0hVcmZPcGZWMm9v?=
 =?utf-8?B?UDltT2JzZXRLNlJsOHhPUUM1Nit4VDJQcVFIakRDRXgrV1NFSEFuMmZza21P?=
 =?utf-8?B?TUc0ZTBHNysrdEdMaXhuZUd1U3F6SFBJN0pvQTF4SVB2M2RVdXRSMkhqV1lZ?=
 =?utf-8?B?Tm1yOEdUZWxWT0tIQkUyUVVCbEh0dmFsVytXMjh6bldrMGRRdXQ3WkFHRmIx?=
 =?utf-8?B?ZU8xdnozZkxubXZjci9nL3ZLVWZMY2lYN2cza2tleVNyTWtQZ3RzemVZZ2RP?=
 =?utf-8?B?blJ2VHoxRXJDYkZpUkpXNVhUSktEYjVORDRsQ3RyRHRUWExNOFh2VGMyWTJs?=
 =?utf-8?B?eXduSTVBR1BYajZTTDlxMzhHak9RdG53ZUs2R0NOaURLSVl6cmtXcENpaVRC?=
 =?utf-8?B?ZEFUa0ZRQmxPK3pYRERRcm50SHN5RGIwMmo4UjJWRlA3R083R045TUU0Z09j?=
 =?utf-8?B?UjhqYlNaeUthL3A3WmdEMkY4K1MvYVl3cVNDZitIY2E5Z0FNazRTN1Jwckx0?=
 =?utf-8?B?Ung5ajFxSmsxWnlxVWczd3c4cGxyRldVZ2IreGtCYnVUWlpvUWJlanRyUGYy?=
 =?utf-8?B?aURQb09WL2VFOWl5SHRjY0J1Y0RnNmEvbGxjZi9US3hGNXRSYjlJSkQ1ME9n?=
 =?utf-8?B?WlJaY3ZWaW1IRXFqZGtmaXlacTZFbGdpUm1jb0xCR3ord1hLU0dWcU5EL0Jm?=
 =?utf-8?B?S0x3a1E3Y0JLbkpsaVFGUG5VL0tpQTZ5VFNyQUlFRHNSUlFaU3NDRGsvcmNJ?=
 =?utf-8?B?dk50cG0yRERta2hJL1lZcTgxWGxRaWNjL2NJeVlBSXc5VzJnSWRya1FiNFc1?=
 =?utf-8?B?eEN3ZkZGcVBkMGtsUjhydTRnUmZWOHg5Z28wdGxZaEF4T25TVGI2K0JUbDRp?=
 =?utf-8?B?OGxPNWdONnNSSG1oTktxWGxoOU55L3BWd3NCVXk4Z01kb1J1Y3B1Y1B1UE5K?=
 =?utf-8?B?ZHlsbC9tQ2ovMnVXcnUzcitYM2tRQTE0Tm94RkxkMU9Mc1BGL0xENS81RlRT?=
 =?utf-8?B?blZyYk52ZUNDc0JnRzZFRWJ4TFFWUlFCQnhDcFZnL1RoU1A3U0hjWU1RUGN2?=
 =?utf-8?B?WldGWlhHMFF4am9YdmlFKzBiWFhtSXJGZVhLS3ZlTU1ITDZPdFpoQWk3N2RK?=
 =?utf-8?B?RTRvVnUzQTh4aXE4RzgvcUx1Y3pZZmRKYktuSUhoT2RKU204YXNhQTh6aEN2?=
 =?utf-8?B?cXRKUHlqOE8vUno3Nmt0ZW9ueVNaN0NIQmlzNCs5dDV4L1hhWXpRVExQMk50?=
 =?utf-8?B?QU51cVEzNDNSVFJpUVdKVmpWYkJZMUZGc1VkdURIWlB2bGo4MHlxYk1HTGFY?=
 =?utf-8?B?OGMraFl6cWttcUs4dFFyTnNKU2p6a25LaHVZZXlieTcwRXlNbnY3RzBxWENl?=
 =?utf-8?B?b1lRUGJTcU1GNkhIMDNsK1UzZ01NSllkd2QyZjhYSmZmUzJDWGxEbEhITTdK?=
 =?utf-8?B?QXliOUtYM3lXZUZZMUtvemZQYWpQVysyMXFmQnRzN1Z6Z1FoOHJ2Z3VlZ1Fm?=
 =?utf-8?B?NEhHSXkycnZ2RUNOaG53d2FTVDBlRTg3ZVlBcGZETnpLSkNtRWFHRzM4V3l0?=
 =?utf-8?B?WDJ0eDJPL1g5TjVlNncyb0ZaUWFCc1hCci9DWFkxSmZyd2dUZlBTWUV6akx6?=
 =?utf-8?B?eDZRK1F1TG5oUVJJb2VpaTZYMGdNNzJEQ2N0TnZGZmZOajRhek1lOW9PQVdp?=
 =?utf-8?B?MGNuTUdiSVpSU0luZmJRUEl3eWZWL2xwRUdxOStkREZvWWxXNFVxQnZUaW5L?=
 =?utf-8?B?bCtib3dpYmUzalZSdUgvNnFET2hlRGkyNnhIaU9vUmVWMVpkWkJOQUdLM29P?=
 =?utf-8?B?SjlYaU9BYzA1cXlBM3JrSGtzWDlWWHRiODBCRFVXM2tXVDM0aU90OGl3T2w2?=
 =?utf-8?B?UlM3ZVh1T0tEb1JCU0s5STVacXJtQVlGcEpxOEtrV1F5dU5qQjY0RmRFTXp4?=
 =?utf-8?Q?3PRxgG5LElyEcln+tGovTnwk1?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb50074d-7b0f-416a-6aba-08dac339181c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 16:32:01.3913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uz8xCiazrWtnLry56VlovYblzxRaMoZzgPw6qcCxWQdDJui1lTe3yuJxWY+byHmQ3TXarxL+mPbclyFsoau+/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6545
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current logic in the Intel PMC driver will forcefully attach it
when detecting any CPU on the intel_pmc_core_platform_ids array,
even if the matching ACPI device is not present.

There's no checking in pmc_core_probe() to assert that the PMC device
is present, and hence on virtualized environments the PMC device
probes successfully, even if the underlying registers are not present.
Previous to 21ae43570940 the driver would check for the presence of a
specific PCI device, and that prevented the driver from attaching when
running virtualized.

Fix by only forcefully attaching the PMC device when not running
virtualized.  Note that virtualized platforms can still get the device
to load if the appropriate ACPI device is present on the tables
provided to the VM.

Make an exception for the Xen initial domain, which does have full
hardware access, and hence can attach to the PMC if present.

Fixes: 21ae43570940 ('platform/x86: intel_pmc_core: Substitute PCI with CPUID enumeration')
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Acked-by: David E. Box <david.e.box@linux.intel.com>
---
Changes since v2:
 - Don't split condition line.

Changes since v1:
 - Use cpu_feature_enabled() instead of boot_cpu_has().
---
 drivers/platform/x86/intel/pmc/pltdrv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/pltdrv.c b/drivers/platform/x86/intel/pmc/pltdrv.c
index 15ca8afdd973..ddfba38c2104 100644
--- a/drivers/platform/x86/intel/pmc/pltdrv.c
+++ b/drivers/platform/x86/intel/pmc/pltdrv.c
@@ -18,6 +18,8 @@
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 
+#include <xen/xen.h>
+
 static void intel_pmc_core_release(struct device *dev)
 {
 	kfree(dev);
@@ -53,6 +55,13 @@ static int __init pmc_core_platform_init(void)
 	if (acpi_dev_present("INT33A1", NULL, -1))
 		return -ENODEV;
 
+	/*
+	 * Skip forcefully attaching the device for VMs. Make an exception for
+	 * Xen dom0, which does have full hardware access.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR) && !xen_initial_domain())
+		return -ENODEV;
+
 	if (!x86_match_cpu(intel_pmc_core_platform_ids))
 		return -ENODEV;
 
-- 
2.37.3

