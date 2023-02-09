Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7276568FDB0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjBIDD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjBIDBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:01:47 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B7837F31;
        Wed,  8 Feb 2023 18:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675911468; x=1707447468;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=+yFh5Lsu86lDOoSrHKhq+vEPgVzbER9vzqdIAsYYVkU=;
  b=f5ZBMYq2L9Wq2v66lNuPOWlTH/NKjl0ThzNtupP4GUQA6GLMUfuLBJeG
   hempL8gCBzwqqoSkxDq66WA/tu+sbvaqS5tJhnfClN0AZgvCwC9qT1jPi
   e3xqM7cOlFRgtAsWmauWbpXfYuVF1MIEPw4aIYsrScrmOkrCL+PdxOLtf
   VFSt/FKlgTxzn1nDsWUQDIymgHWw9Od0lx+IUaFbqvGMrO+AS1MY+5CvM
   PRFh9P1JjwuzlSAlPunbJ9iM5Wn+mhzwakUY2Gm1Cct2a1jk4xUa8IeR6
   QIRMkwcDZwYa6p+gcvaLK03Slz6afWNj0DRuihWVac63B6z8IfdnasHIT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="392385046"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="392385046"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 18:57:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="776299162"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="776299162"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 08 Feb 2023 18:57:45 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 18:57:44 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 18:57:44 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 18:57:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgLSb8NqOscSdkHMNZAW23HcUADV9jPN8zIqnCsdqcDPUApNOQCOafw+5utdgRIyU0ods1wEZIf0QoTYRhvCTDjdAQyvmNNA/ixtp+KydQQ8inFvSQYyFtRoSIO7N+br7u+a0UHEcezbrEM+RUq6ELfCXFYlvDybckpjgFz2IU9g6v/ELbAiicCWSuF7RAl7nkS7MtfGh+8tafLMpC8AuzrhZnCMK6Zd0bOqiMUnCKuZAtwWll6/dgqnGRWsSh0/1sDbp5B6LuXcPdJo2hN1fzR+YkekGZ6rwpcArRK67DgH5g7me9x2nGwHWJoiKXP2RgEACKjCKJvIAMc04HodSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McszARdQV9rkze6SMBGzjYbft636L0hxb4Vf8ij95v4=;
 b=ao1p9PXefCzESm0+rPvmim+lN5SSQPyXbhT4+WJzq5QE8STJamY/CcCIODsCMsEgR1+TE+5UPTawOspKOl3obgIG0u3br4Yb7y9KcnmrNvBINJD9+v0kDNnCjkzGXy/XXDskTfnVVYAVMa4AVw373ZREVjBF3o/mwqO1voknLYZYdwhstU6ZMizsWC+W+xfXgjKjVd6dlWtalo5pncNtWRFbc+tA9vDdJGjbbiy8RvglYDls60TpXRFcTckj3DjwBiIJzWj0FjerRL5U257wtFSSunFEnfHA0tvwvJA4CI1cnC6rSF0YOOQ/7oZ9xVVPg3PXauahOIcim/m9Q81dsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH7PR11MB6796.namprd11.prod.outlook.com (2603:10b6:510:1ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Thu, 9 Feb
 2023 02:57:42 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be%3]) with mapi id 15.20.6064.031; Thu, 9 Feb 2023
 02:57:42 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>
CC:     RCU <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [BUG]  run rcutorture  BUG: unable to handle page fault for address:
 ffffffff84d05000
Thread-Topic: [BUG]  run rcutorture  BUG: unable to handle page fault for
 address: ffffffff84d05000
Thread-Index: Adk8MhYPZ5mQA/WsTS2t5TzUx/BkvA==
Date:   Thu, 9 Feb 2023 02:57:42 +0000
Message-ID: <PH0PR11MB5880C80360BE924B60905CC0DAD99@PH0PR11MB5880.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|PH7PR11MB6796:EE_
x-ms-office365-filtering-correlation-id: 4f7ee25d-047a-432e-1805-08db0a4969a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uElT8XeH6AV44AdEzo8pRrvUKANB8g4b4Ac9nqo/PXL1aYe/8fnHLbBsgVBdtF2KNcrhFQDRS3usP/0ASUsd0aCQ61TsKUSJa5mVr1ieBGL7YGFRE+1daTWq/ylbN0P7Pa+OXWmYq2nbZgMe03njtWYQoykLsgVq/Ca4z2tTrTRWt+w/jKhUW+aVWZtN974/Xs3ec9h+C49fcSKnN6UAitWf9Y0GH3opJHyZRYOHrBeWUXaMUTeUg4CW+QOhnZ4UjQ13kjXllSd3dd0zj8jptdS8VW1GeaZNP8JYOonxMQEaTZlPBq6DUOJkDcSKXfNaMD8OH9qMdrzIB9Ag/ThB9Q0fY/U5erlBdbNa6Qx4ilLxaovW3MxQnw6cB5XyMxqArI4BjXuL1idNheZewwfJoMJ1Q8hMFapEtZagym+nindRBVdaghkQ4mxk9z96I5G7jfa+0J7PJZciko/Hr9bGUKo1f+NiJBbUKC1PLaR5hzEAmYG45Hzi/yS2pBZZqz/FwtZFKo0qklTTDBs4KjxT68kRGw2y0UkWr5Mjj0znHg+JFH2gYAYbAMD87eXiXw+nsryYL8bM4t/TCcJ4j+z02tMqevUjmaJ71R4vPkcpQnr1xbKqW8Y0sZakifocZFNNqzuL3RroxDQ+IsgfXJLhzDSEFCt2wVwexLtKc2JLY+3swwBIodl2rUu/YHTF3HoZ6veqWCFy3bAxWxkScPREL1R2wispWpHn1klsLXsKFOk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199018)(2906002)(38070700005)(6506007)(9686003)(26005)(186003)(82960400001)(122000001)(38100700002)(478600001)(33656002)(54906003)(83380400001)(4326008)(86362001)(316002)(41300700001)(966005)(8936002)(45080400002)(110136005)(66476007)(64756008)(55016003)(7696005)(8676002)(66446008)(66946007)(71200400001)(66556008)(76116006)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ljJT7/23t3KZ9AepiYfm5ZbF+RaVJi6ajmL4x0daVdwrbMaRJ5/yc0/EhPBe?=
 =?us-ascii?Q?BqLgvheiLm9aRB/Py4rja+vjf8y+uWw1OOO2YsKNySYt0EGGxEzjeRoWVraw?=
 =?us-ascii?Q?WuxHJm7mGe1XJKL5TeHe6fu78rIFG5hJ5/rn7NFqwDfvzr1/tCnSqVWZRoju?=
 =?us-ascii?Q?Au1A3FIyKL7yedThPJAlSCW4NcH1aW0ozuYcoUIyeXB9Mp6fTEctDxtqOf4y?=
 =?us-ascii?Q?mg75QkLceM/qHpi/wHhTKNRGzUcv9n2OdaXM1a9C7dQTIOQeueuwyH1Ug9Zn?=
 =?us-ascii?Q?xumUWG0+gWVI/SRs1ZjGr3S1VKPYGnOhoH2LRiOoHAkG7rnmJMKvMdiHOTmn?=
 =?us-ascii?Q?S14pZKPjqhuuVuvcCAKsIiTshCMCHtZBsoPFZ7reRdAMMX6IGK6OiWpZ9K8k?=
 =?us-ascii?Q?xkxuDU6cJBl/dcbqW/F63nkKx2mO/6/IkpF4FJ7sMS3rVkg5dW9ucId5qBM5?=
 =?us-ascii?Q?TYtOLBGBWGu9MigaReIRpXZ06uczXiVlO0Tm74yS3FEMC8fPlJhKG7RriBYv?=
 =?us-ascii?Q?sHQumzoIq0mWRdOdwshjPp+PzIvHviuQ2FXCWBH6Oxb2tBG7SikGbbHGgQAr?=
 =?us-ascii?Q?nuB0+hyTUIqQsDftTAyXFpQbHTRq6ejXUtJes9RiMOg8rD65Nmw+ZVJ4YAhI?=
 =?us-ascii?Q?0sxxJMkRdsTJa8rewfEb4ulAUk9Ns950ieXoNy50HMqzvu4aVNN8orH6ikAh?=
 =?us-ascii?Q?CWvdc9HEgBFaqWJ+7kq64U8ro/8tsasSl9MKe7gxchUEGOwBVPflZxxGjz47?=
 =?us-ascii?Q?vti0I94emIgdacvVUPBW6HBzJjUHoGFoXY2Ujk4hzOX2qeIPYIpC9CP00wTR?=
 =?us-ascii?Q?Wmkef+Hfb2U6yghmOEmhaCDfAgspphKpCmn/RW86tl6i1eRku6jPBH++n9VE?=
 =?us-ascii?Q?Ld5yynBdOwGY+I0rDqPwloif853fRPrDhrq8Dm/V0Bjk4fUaBYpjmVIKNm2n?=
 =?us-ascii?Q?iKWwCkiaFVmeADK2iKMMcQUEU2IeX2a/Z5+VVBSAa61xQTVPRKB5uchkra5s?=
 =?us-ascii?Q?7ilgUPtcBOGOecWOLPzePP+3FHjz7iRW2J3pmEEQ9ZHfhoBJEJVBpse8GS11?=
 =?us-ascii?Q?Badc4Tq4zx0dBrQCXqh2dm3MKuJO/OhV2rM3XGQFZfn/29XvaHPAg2tFv6Df?=
 =?us-ascii?Q?FmGXKYnwuROUP3IsyjYEEx5K1D2Jz2L64ikWY6LJjau2NTuC6BX4Ja0xxPQh?=
 =?us-ascii?Q?ZhzGe/FlEVFaoezsAv6j7LxJAuLdwCS6YRgbZKcEdbjuXvDS6yiFvt80ehwz?=
 =?us-ascii?Q?dHRKYkq4KGwljZSiU8R83FElGJ7IciKNtvVO8D5oQts5aUllII/oNgcMohQX?=
 =?us-ascii?Q?8/cqvhlXBnHcyVIcrVD+sBejSCAQjz72Se0n9eWRbZIjJIpYoYz65il0mQ9c?=
 =?us-ascii?Q?GLaVMd7Ya50Xa65WALtN44Hqr1+6/H7urSYfhFZLhRBbIymrR2NDZ9Nb/xBI?=
 =?us-ascii?Q?ueauO3IGggu8sTXhqPBEG+TQ7G7+AgQ+q7a2ZSxik2p1wgiV7MIIdc/S787g?=
 =?us-ascii?Q?50zBzvZnwJORxQi6IHRcz9nL5MW/sZzKAZYkNJQm3916+zBxPI1WNI1z3yU/?=
 =?us-ascii?Q?EsYdhheZfAgM6SUCmQ5vJm2TXNT3VSZ4xjJ91Tdd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7ee25d-047a-432e-1805-08db0a4969a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 02:57:42.4349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNZ0TBmGeWPrthDgp2F7zn6wfpCP9tevINBYXonageviHA2U4GC/LQKA2jKEdb/OxWKW/T4rg6ZeOpfvWa2DQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6796
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Test based on the following branches:

https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  bran=
ch dev, arch X86_64=20


runqemu kvm slirp nographic qemuparams=3D"-m 1024 -smp 4" bootparams=3D"nok=
aslr console=3DttyS0 rcutorture.torture_type=3Drcu rcutorture.shuffle_inter=
val=3D0 isolcpus=3D0,1 rcu_nocbs=3D0,1 nohz_full=3D0,1 rcutree.dump_tree=3D=
1 rcutorture.onoff_holdoff=3D30 rcutorture.onoff_interval=3D10" -d

[   39.392925] BUG: unable to handle page fault for address: ffffffff84d050=
00
[   39.393244] #PF: supervisor read access in kernel mode
[   39.393480] #PF: error_code(0x0000) - not-present page
[   39.393715] PGD 3e19067 P4D 3e19067 PUD 3e1a063 PMD 800ffffffb3ff062
[   39.394014] Oops: 0000 [#1] PREEMPT SMP KASAN PTI
[   39.394231] CPU: 0 PID: 16 Comm: rcu_preempt Not tainted 6.2.0-rc1-yocto=
-standard+ #635
[   39.394590] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.0-0-gd239552ce722-prebuilt.qemu.o4
[   39.395085] RIP: 0010:do_raw_spin_trylock+0x70/0x120
[   39.395320] Code: 81 c7 00 f1 f1 f1 f1 c7 40 04 04 f3 f3 f3 65 48 8b 04 =
25 28 00 00 00 48 89 45 e0 31 c0 e8 c8 0
[   39.396143] RSP: 0018:ffff8880072d7b30 EFLAGS: 00010046
[   39.396381] RAX: 0000000000000000 RBX: ffffffff84d05000 RCX: dffffc00000=
00000
[   39.396703] RDX: 0000000000000003 RSI: 0000000000000004 RDI: ffffffff84d=
05000
[   39.397027] RBP: ffff8880072d7ba8 R08: ffffffff811d74a0 R09: fffffbfff09=
a0a01
[   39.397346] R10: ffffffff84d05003 R11: fffffbfff09a0a00 R12: 1ffff11000e=
5af66
[   39.397669] R13: ffffffff84d05018 R14: ffffffff84d05000 R15: ffff8880072=
d7cd8
[   39.397990] FS:  0000000000000000(0000) GS:ffff888035400000(0000) knlGS:=
0000000000000000
[   39.398353] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.398615] CR2: ffffffff84d05000 CR3: 000000000a22c000 CR4: 00000000001=
506f0
[   39.398936] Call Trace:
[   39.399053]  <TASK>
[   39.399156]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[   39.399379]  ? trace_preempt_off+0x2a/0x110
[   39.399576]  _raw_spin_lock+0x41/0x80
[   39.399751]  ? schedule_timeout+0x242/0x580
[   39.399945]  schedule_timeout+0x242/0x580
[   39.400133]  ? __pfx_schedule_timeout+0x10/0x10
[   39.400346]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[   39.400567]  ? __pfx_process_timeout+0x10/0x10
[   39.400776]  ? _raw_spin_unlock_irqrestore+0x46/0x80
[   39.401006]  ? prepare_to_swait_event+0xb8/0x210
[   39.401221]  rcu_gp_fqs_loop+0x60b/0xd50
[   39.401405]  ? rcu_gp_init+0x89c/0x1250
[   39.401587]  ? __pfx_rcu_gp_fqs_loop+0x10/0x10
[   39.401793]  ? _raw_spin_unlock_irqrestore+0x46/0x80
[   39.402022]  rcu_gp_kthread+0x2b7/0x620
[   39.402201]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[   39.402421]  ? __pfx_rcu_gp_kthread+0x10/0x10
[   39.402625]  ? __kasan_check_read+0x11/0x20
[   39.402818]  ? __kthread_parkme+0xe8/0x110
[   39.403010]  ? __pfx_rcu_gp_kthread+0x10/0x10
[   39.403213]  kthread+0x192/0x1d0
[   39.403366]  ? __pfx_kthread+0x10/0x10
[   39.403541]  ret_from_fork+0x2c/0x50
[   39.403712]  </TASK>
[   39.403818] Modules linked in:
[   39.403972] CR2: ffffffff84d05000
[   39.404128] ---[ end trace 0000000000000000 ]---
[   39.404340] RIP: 0010:do_raw_spin_trylock+0x70/0x120
[   39.404569] Code: 81 c7 00 f1 f1 f1 f1 c7 40 04 04 f3 f3 f3 65 48 8b 04 =
25 28 00 00 00 48 89 45 e0 31 c0 e8 c8 0
[   39.405400] RSP: 0018:ffff8880072d7b30 EFLAGS: 00010046
[   39.405639] RAX: 0000000000000000 RBX: ffffffff84d05000 RCX: dffffc00000=
00000
[   39.405959] RDX: 0000000000000003 RSI: 0000000000000004 RDI: ffffffff84d=
05000
[   39.406281] RBP: ffff8880072d7ba8 R08: ffffffff811d74a0 R09: fffffbfff09=
a0a01
[   39.406602] R10: ffffffff84d05003 R11: fffffbfff09a0a00 R12: 1ffff11000e=
5af66
[   39.406922] R13: ffffffff84d05018 R14: ffffffff84d05000 R15: ffff8880072=
d7cd8
[   39.407245] FS:  0000000000000000(0000) GS:ffff888035400000(0000) knlGS:=
0000000000000000
[   39.407607] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.407871] CR2: ffffffff84d05000 CR3: 000000000a22c000 CR4: 00000000001=
506f0
[   39.408195] Kernel panic - not syncing: Fatal exception
[   39.408450] Kernel Offset: disabled
[   39.408615] ---[ end Kernel panic - not syncing: Fatal exception ]---

After remove isolcpus=3D0,1 and nohz_full=3D0,1, there is no Oops.

Thanks
Zqiang

