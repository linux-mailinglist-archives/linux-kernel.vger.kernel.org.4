Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674966FDE5D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbjEJNUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbjEJNUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:20:03 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 May 2023 06:20:02 PDT
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A716A45
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1683724802;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=d6T+Tuh6mf1YUW2xjnx5OE3o+Oh5Pa7D0V2T78Yr87M=;
  b=h/H94xnSIArOLWM7n2c2tQNRkjQujEOZz052TLm6+RyICi8d5ODOK8IX
   nvDfSe+iH7zSc5yLsbqG0YU8yUKs/4C3anQrO/ZZar7fnooyxhg9H2Syo
   vmgMgQQAVtCM9jPW6R6ZnlkLrlo45JQfNvWahRMTgU75TJoRsgagAWnmp
   8=;
X-IronPort-RemoteIP: 104.47.66.42
X-IronPort-MID: 107856255
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:B0N98a5pw2ho95ygeQ3rsAxRtM7HchMFZxGqfqrLsTDasY5as4F+v
 mdNUGqFPauKMGamL9p2aNyy9R8PvcLTnYNkHQA++Ho3Hi5G8cbLO4+Ufxz6V8+wwm8vb2o8t
 plDNYOQRCwQZiWBzvt4GuG59RGQ7YnRGvynTraCYnsrLeNdYH9JoQp5nOIkiZJfj9G8Agec0
 fv/uMSaM1K+s9JOGjt8B5mr9VU+7ZwehBtC5gZlPa0S5AeH/5UoJMl3yZ+ZfiOQrrZ8RoZWd
 86bpJml82XQ+QsaC9/Nut4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5iXBYoUm9Fii3hojxE4
 I4lWapc6+seFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpdFLjoH4EweZOUlFuhL7W5m2
 u1IEQEtTzu/oLiV/Om1S+hJlMN9BZy+VG8fkikIITDxK98DGMqGZpqQoNhS0XE3m9xEGuvYa
 4wBcz1zYR/cYhpJfFAKFJY5m+TujX76G9FagAvN+exrvC6NkkotitABM/KMEjCObd9SkUuC4
 HrP4kzyAw0ANczZwj2Amp6prraXwnOmBthPSdVU8NZDhXGU9k80ISERC0G3heKlsnaVWIxmf
 hl8Fi0G6PJaGFaQZsH0QRC8iHKJuA5aV9c4O/Yn5ACVz+zR/gWZC3IGQzNpZ9kvtctwTjsvv
 neH2d3gBDpitLmUYX2Y/7aQ6zi1PEA9L2gEbDMERA0Fy9/9oY0yh1TESdMLOKq2gMGwBSvxy
 j+HhCw/nKkIy8oK0ayh+hbAmT3EjoDAUgU16x7/XW+/6A59b4/jYJangXDA7etJLK6aQ0OHs
 XxCnNKRhMgVF46ljyiETOgSFa2q5vCedjvRnTZHG5gn6iSF4XmudoMV/So4Ikp1Wu4YfiX3a
 UvfoitV5ZlOLD6karJxb4utCsMsi6/6GrzNUvHSc8oLYZVrcgKD1D9haFTW3G33lkUo16YlN
 v+zac+wBnYXEoxjzSGqXKEZ0Lk21mYyyH27bYvnxh6j3JKAa3OPD7QIKl2DaqY+9qzsiB7Y+
 tBQPpGixBBWUem4aS7SmaYcN10FLngTAZHwttxZcfOFLgN6GWYnTfjLztsJco99moxRl+HV7
 jSzXVJexFPjhHrBbwKQZRhLcqzmR414slo0ODxqMVvA5pQ4SYOm7aNacoRte7AirbZn1aQsE
 6NDfNicCPNSTDiB4y4acZT2sI1lclKsmB6KOC2mJjM4evaMWjD0xzMtRSO3nAFmM8Z9nZtuy
 1F8/ms3maY+ejk=
IronPort-HdrOrdr: A9a23:Xh1pDaqItgmgeVxyHrM/uxQaV5r2eYIsimQD101hICG9E/bo9P
 xG+c5x6faaslsssR0b9exoQZPwPU80lqQU3WByB9mftVLdyQmVxehZhOOJ/9SKIUzDH4Bmup
 uIeZIObeEZKjBB/KGKhnjAYq4d6ejC04ShheLT1B5WPHtXgtlbnnxE4tjyKDwTeOF/baBJaa
 Z0TfA32AadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AcftW0Wt+t25H4fTTM36aTeX+6IsKYy3k/VfxCHO?=
 =?us-ascii?q?fU0VVE7OUSHqC//1Nxp8=3D?=
X-Talos-MUID: 9a23:MoHdgghs+nCp6G9uxkZwcsMpHcJE5JSNL2kxlssct+2fKRRIEDTDtWHi
X-IronPort-AV: E=Sophos;i="5.99,264,1677560400"; 
   d="scan'208";a="107856255"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 May 2023 09:18:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvufFj74cSLjxbYMwyKQzfZJLoE1L6PzeoHXT6Z2g5ar2GJjUWLEh3Nz7GbLyNrZh4VNRWJlRtyIYi8Rsrb4plRIehJYMms0/cRaktWsm9PhzLjqUMKIsdAhqXovo1rucKm2ESiCAZkM01LZ3Sfp9gF2CGN8vylXDFO3l8c13jjoWgbhwgAg5lLWNB9uQqyT2Td2RvkIMMwsV+izEV3KadHPy2W0TM/csY9Ivbuf1ihWLdJoC1iRMFxIdo9wtXdXBp5aAqW+QDG3zxD5DpsgTvDDBzLRFIuHEhApWMWTjEbTAYHHfvPFu+L7HDe7co5vFtfAiMp5FdXv2KG9GXdLZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZnS5NaggzoCNK5demEo22gikIQ7cEJq4HpTn2tUjfo=;
 b=dKzmmU/YDPQsUufDv07F91q9TAcZhbOfOM+gT8x9VEVyJwDRp269QTcV6mhXgLyBrPggkiyNCsA+17LIsg6lcGKnX5SRXfcMc5urQg+InNG4xoeAU7eKDuO7GHfjAn9PHAXcudvtU9uIkb3NYAuwcj1m6KL9bC7cR+OK6VntRaCxZZmsH5lRLsbFCa2kvwDVnSqsdvWwVoBlaBWmmbMHOuEv16g8CO9g3/ZtnHnqnYLmuxJReB68AgbOC6qUkssZWMk21XYhUH6/VWG4+Mkgv67bDDwnTriC9ymfO9QS7wZI3RhxNxUD7ZxeL8gC0W+kf1PnwyLvmLjjFe09N4cRWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZnS5NaggzoCNK5demEo22gikIQ7cEJq4HpTn2tUjfo=;
 b=mgLixnknTMmDJ2nCYV1zY0sGBG2/moRF9qggxIINLRf/Pc5LOh1/F2pOUfXLb2d+ZMe0YibM/eizvMnRrcXE5GkAfKrN0ELp2pTjqHiqCBVDoLrGAEsHe5KEoz+Jt39v8gWLuG8RixUnAN3gZgAnq2RR+9EPygtSddYVXWTWU0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com (2603:10b6:a03:38d::21)
 by PH8PR03MB7247.namprd03.prod.outlook.com (2603:10b6:510:23a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 13:18:22 +0000
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::b0b8:8f54:2603:54ec]) by SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::b0b8:8f54:2603:54ec%4]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 13:18:21 +0000
Date:   Wed, 10 May 2023 15:18:14 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, seanga2@gmail.com,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/610] 6.1.28-rc2 review
Message-ID: <ZFuZllSJguONF2p0@Air-de-Roger>
References: <20230509030653.039732630@linuxfoundation.org>
 <ZFuEoWJL1TRmEuMM@duo.ucw.cz>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZFuEoWJL1TRmEuMM@duo.ucw.cz>
X-ClientProxiedBy: LO4P265CA0090.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::11) To SJ0PR03MB6423.namprd03.prod.outlook.com
 (2603:10b6:a03:38d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6423:EE_|PH8PR03MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd1ccff-c426-4bbd-8931-08db515906c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sgyTSMH42f3rz2jmzpBLYdpanB9nTw0DTWI5RkJW0NzfmPxqkpv90CLiR9EHM42jXQVdf9ZWgH7bphmpDZX+aKi90fp2VgK3Od66du3H4enqjfVNyZ3qe4NGGWN6k3nggRPK3VeBSFDSCFax0oBO/48Y4z4Z8/YU2GAIIN4oLd2MLshwLChONkfPo2JSnQU/rQNu4Bc/ApgKLw6qkFP35S5ZhsSswuCSwksqlLcvLNMB66eC+K2LfJ7dA3oXCmMX6oekqy0wVCBVFc0Zwws1OC9fez66GDRyBJVnvGf1AH49m47V7mR9c2Th48dGk9oS1yUz9ulilyAzIHlNEHBpqJWkeQVVewg10ua7rCRPV2YsYHoHXVW4VOSTnLvlktBQrGB4BefBnKVYCe12sCTWHoq/QYMZlG+KKEzZHEGYA3iH5l3EFuY8NevDJ7aEPv7DIKLFJnT0mH5WY1pv92Qk2jztJqXxH1LK0vgPqG2QoYrbvX2YsWyYB08ANgPeHPJnPyqyhZwapyidzigGS9WXWObmKUXxhSxUkf3GX7oE/ZmpB/SBj8UaKqR2EWPKGKpc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6423.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199021)(186003)(2906002)(38100700002)(85182001)(86362001)(33716001)(82960400001)(5660300002)(8936002)(8676002)(7416002)(66946007)(66556008)(66476007)(4326008)(6916009)(6666004)(41300700001)(6486002)(478600001)(316002)(6506007)(6512007)(9686003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlFpWC9LdHNIa0VCRHNNRGNmckw1cEQ4TFVkMGthR0lXYUdEZGpiZk5DZFUx?=
 =?utf-8?B?R0JWL09Ca2RzMUYxYjhwN3ZBSkdEVHA5cXJPejdjcW85UnpUZXZWbThnczBE?=
 =?utf-8?B?ZTN1aDM5KzY5WG94SzRUOWJTNEpyZmVFUXdYRFhGYVFydFRxN3N6VHdIM2h3?=
 =?utf-8?B?bnpSRWZkOEdvRTlqNFZwQWkxN09uemFtanZlM2VPNUwybDhJeTFkMzdHcmVH?=
 =?utf-8?B?Mis3cmRKRHNMVjFvMEY3SUJqY0F6MUlSbWtERDBJd3hOSEhYVXRzQmkxUDdp?=
 =?utf-8?B?VE8vVXlwV2JxTWQyS3hia0pSa1NkUTlaaU5PYmp3bTNZbGlrdFFnbzBCQmQr?=
 =?utf-8?B?UC9MMDJNenA1K1pLeGdjMGx1R3VYdmNjbmE2R0pOVDJ6YVdzMWc2U0lYRVho?=
 =?utf-8?B?Tmg5S2FQVWgvY2RBVTVvNm1HQml6Wld0SWg2R09qeDg0MHc4VlRWNTloQXpr?=
 =?utf-8?B?NTRCN1g0S1hOdElNQ2UvY3ZXZG5uSGozTkVBRm9aclRtWHVYUkdWYUlMRVNI?=
 =?utf-8?B?WHJVYW5IQ2tzMVBocEZDdDh0NHo3TCs3dkVmSXhzN1ppMnlJU2ZXeGp1M1dT?=
 =?utf-8?B?S3h4Uk5XaVQyMGpsK3Z2d0tsaWVWVEdROEsxTHJmN3B0L0twNG1WNUszZHVm?=
 =?utf-8?B?ekZnZ2dmWjhPZ0RCTkhGTFJWemxTd2ZpekhDbXV5bjdkZnJFNjR5bGxFVXQ5?=
 =?utf-8?B?MWRnNldIL0lpWnpEemlITGFYMmpxYWJzNlRaeE1SSHdMSGhOTTYxTWFtTHFx?=
 =?utf-8?B?YVZoRDQxUTM0dzVSWlFTbHR2Y0FkNlZCUXRsV3dja2hnSy9xbU9JZDB4dzFQ?=
 =?utf-8?B?aWdlZGZhTnhaVW9QQU14Y09Rc1RHREZrOXhFRUpJcG5qVzFST0M1WFBLUU4v?=
 =?utf-8?B?aE1oUXRkRE1XYit3ZEEwZUMyZ3JXMUdsY29nRS9ldURadzJXaHdkQnViSWZp?=
 =?utf-8?B?UkNNaEtOWU1KM3B6cmY4Tnh4NmtaVHZsU3FINkx4cVRKSlZHZHY2bVFoakxj?=
 =?utf-8?B?WExEUFBmZ3ozNndpbC8vQVhRWENBMGxnRFBjUEgvZmVGNUJSRDA5THNlMHky?=
 =?utf-8?B?ek9mZk1hTFMvVTdCWWZxajJ4SGNJRDhuVGRsMXJyemI2Y3Vvd0RhNjJKTG5z?=
 =?utf-8?B?VXVneXIrKzJaekVEZ2NqbHR0VExHTVdpbE5ERzdEUStBaFcxRmtPMXdlaDRp?=
 =?utf-8?B?VTUzL01haUprOTVoUTcyUmo2NDNwVzh6TXNTUGJjaFpUYkZZNmpsd1hLdVVE?=
 =?utf-8?B?Y2hRRUt6c2xvWW9jMGFPOTBhN0NZVlZKWld5ZVEyQVFieUhtVVJzZDlLK3pm?=
 =?utf-8?B?ZHdDTm0yU0ZOZDM1VFhYNHVrc0xyd3NmN1p2MXdQTWpEU1NqRGVqTnhnTGJW?=
 =?utf-8?B?ejhDaUtVZ3B6Q09qMGE1TjZIZ2Z1SDErRXN4ejhwUWVqNjJTVDRDRU5GS2hR?=
 =?utf-8?B?eS9lTlV1NE5Odi9nc1RkOGRCb0FxYWhMN3EycXFHZ1Zyb2hNRGNWdXdHNWQ0?=
 =?utf-8?B?bGNJY2ZLbjAxUlUyclZQNDVKSWtoZzJ0WUFGZ0dKWkszS1ZxM1NIWlU0KzRX?=
 =?utf-8?B?ZVZSS09SVTRtbXVmTWRDenM0aFZFU3VLTVk5MDNEUEZWZE9PcnhXNEZPNG1h?=
 =?utf-8?B?YUptNi9hMWZFWDl0Q1BWbGl4TXF5a29xdDdSYjJLSDBtK0dVdWJlMnVLWjJ2?=
 =?utf-8?B?NXU5ZXIxUnlUdjJRcitkZk9PbEUwK2RTQndlcFh0b2s2dVRrMTZrTHRhSFE2?=
 =?utf-8?B?OVJ0NXZXWHh6aXZNSHRFSmhkZXpOeUJjdHJiWDFQd1kzTmhnTHl3L3ZMTTVR?=
 =?utf-8?B?b2pJOURjUEhCZ2RkS2dtaS80WkRmM0lVSHZpeFMvMi9UdWFJK2RzSExVU2NU?=
 =?utf-8?B?cGFhSU80bW10b2hya0FRVXZxdnZyTThPQ2xqWU1jdkZWdFJVbnRkTlpua1RY?=
 =?utf-8?B?RXh3QzlabUlaeHBaQXhtc2o5WEhwWHZIU3Vaak5hVG1JZGNBQ05OWklDckx5?=
 =?utf-8?B?SE05N1h4U2d3VXRSRURZVlVKNHRISEZWSCtsQjMzYTV1aVVid1JxR2JCbjlj?=
 =?utf-8?B?UW5NbHJpeEszUGFkbHVLZUJEQWNWS0todGpkMEkwaytHOStkWlY4L3hyQW1k?=
 =?utf-8?Q?P3kJb0+P0OWc+qGTrEByQUKHS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VEZVNm5hSzV2Tk9tcjBRSzg2VEZjTWFtRzRPOGJtdFVud0xnVUFMR3NCTEwx?=
 =?utf-8?B?NXBmMFpWNmsyZGdYZ1J2Tnd5ZWNlVHo4SVU4SDlQa1BPTG5hWHVGMlhlWHlT?=
 =?utf-8?B?U1lOUllUQXUxK2djTkhCMjZIZnJBbmJyQk5IaG84aGsxRGFuNGFWZUY2ZzJ1?=
 =?utf-8?B?M1k2RGtCN3g2ZThrVkd2VldWSUZhcE5kdmY4NVdybHc0NTF1WUVTSlRtOXpX?=
 =?utf-8?B?VnUyRmtPTjhYUXh6NmVNU2NoM3FmZXVyK0VKWWlCOUtySmlpdGgzeFQ2WVNa?=
 =?utf-8?B?NkNiS2pPTk13OG96MDI5eWd4UVFMM0M3U0daRTFxZEtmaTdqczNWdUVWQWoz?=
 =?utf-8?B?WFlqYzBOaWVUcEU5S0c2emNzS2RQcTQ1VEhITTkrUzNTQ1Irbkt3QjZxMEg2?=
 =?utf-8?B?TDIxbzk3R2QrUE1UMlNZcjVyTXJFSmFnM2JxV3poTFFKdk0zMVkrYldXcWha?=
 =?utf-8?B?MHdzc1FqejVRbDFtaUl3MlVUTEtaS2tVSWFWNEZ4cERJRU1teGVqb3hTNUF2?=
 =?utf-8?B?TFVSZy9aSzdlVFRDeHhWYm9ObW1nSFd6cnVOWlhPdG1qYmRyWXRrbHJ0cWxl?=
 =?utf-8?B?cTRLTi9PbDBMQ1M5dUoxWmhtVUVXWmZFLzhEWENWak9hWGkxU1BJWXVTaTZo?=
 =?utf-8?B?SkFIN3dpa2J4VjBKNlMyS0t6cDl2ODB1R0RqUlZraWhpSUkvRVhtUTcyYkxS?=
 =?utf-8?B?emQ4M0o0T0ZROFlPTTUrTUgxS05CSHgwYkFWcTN3MktIMENPYkR0dVlMbkQ1?=
 =?utf-8?B?TU5FK1BmN2dVamJlSUdveTdVbW1wZ3VNTldldjluRGlhbERGVzd4VUpsRzBk?=
 =?utf-8?B?UUhrN0h1THR2RS9KdUZSc2ZaVC9hT3NFS3p0OHlPV0NmRkRhaisvdmxwaXhi?=
 =?utf-8?B?UU1uVSsrRi9hVTdrZk1iYllWRTd5UVRDLzQyWkRzamlUc1VNSzlPNnMvWlNs?=
 =?utf-8?B?Q0xNZ2x5Tk5jd0lLcUozVWZUdTVoTFhoeFR4ZnhoUjNuVDhXKytUOUdnSlRz?=
 =?utf-8?B?dklocjNRVGRVZTZQM0VyM28zbDdYdDRMbjQ2ZUU2ZFQyaXQ4NGVNc0RXdUF0?=
 =?utf-8?B?QUg2QmMyOUxKVDB4N3pKZkgwb2pZb3pDOEtSUW5DWTZLY3RrSWMvOWQ3T0hH?=
 =?utf-8?B?SEl3NXR6Rmx2NjlIRnBydklhUElQdTJrV3lZUWw3dk9URUFRWHdZUGI5S0ln?=
 =?utf-8?B?T2psdmlEVUhoazNIMHFRUEc4ZkdlaWMvNWVFSU41NmVqSXhJckQ2QmhSRnNU?=
 =?utf-8?B?bG9RWnIrc1lGOHEybDJ3RDB3VHE1Um1hTk1jakVMdmkwTFpEQW0rUG51WUhO?=
 =?utf-8?B?Q0IrcFFoRU9MZk9XL3c4ODM4MGdDSnlzOUJkSm5SSmljTlp2ZU45TE9rU0pw?=
 =?utf-8?B?d0I5cTZvYkFMalhWMHZJVVFXdEhPMzdGTDV6Z05aVUdkUGFTQ3BJV3pPVUlK?=
 =?utf-8?B?bmU5NUhXL0tYYzgxM1hDeTA5b3VESTdIa09TUGIvYzA1Snh2cnBGWUxWU0Fj?=
 =?utf-8?B?UWhuc25WSnNONVVKb2luVmJoWmNvcjBFZGNjSjJ4OEdYODVoTW04WDdEb1U3?=
 =?utf-8?Q?boQ4Huv0bUwzPyZ8WtnyOLEU8eeP4coBDRBO4xs6qhNYt9?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd1ccff-c426-4bbd-8931-08db515906c3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6423.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 13:18:21.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSJfxiCjeDhGsqhqrleQ3kvFsct1iu9WsG6jxSVtBzagF7bUHTvuUfhXxSy2JZ0PMppFgYUVshs/tGxQG5SHIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB7247
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 01:48:49PM +0200, Pavel Machek wrote:
> Hi!
> 
> > This is the start of the stable review cycle for the 6.1.28 release.
> > There are 610 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> 
> > Sean Anderson <seanga2@gmail.com>
> >     net: sunhme: Fix uninitialized return code
> 
> This one is wrong for stable. err is still initialzied to 0, which is
> wrong thing to do. Mainline is ok, but fix does not work for 6.1.
> 
> > Roger Pau Monne <roger.pau@citrix.com>
> >     ACPI: processor: Fix evaluating _PDC method when running as Xen dom0
> 
> If the condition can be handled (and code has "return false"), it
> should use WARN, not BUG.

Feel free to send a followup fix.

Such dummy handler getting caller is a sign of an error elsewhere:
someone playing with Kconfig logic or trying to add _PDC / Xen support
to a different architecture, so I think it's fine to BUG in that
case.

Thanks, Roger.
