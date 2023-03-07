Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348826AE468
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjCGPTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjCGPTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:19:13 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEAB4A1D6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 07:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678202226; x=1709738226;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=uEGZvDgxtFhcvXQOJEo6VBrBGFdTFjVZg2dmoSBUbGw=;
  b=nGqMf36jGynVfmf67qmUasBCdzUQGqd7pj6tprOzixm8z7xozZotJwuY
   XWl76aXveyyGfrXa+PxvPmADf5i6YfA5dE0KG8B/laLS+WBaKFATFgjfO
   DZU3d06WrqnD2tiIHI3JQSA0zZiD4YZi4fH7wWDZ0fg7kNaLvceqv1GFX
   9X+c347bgRq0DJemDq9g1jTMjvTiJEfUhgCd46I9LiXPFfJm43Pf//pE2
   8PZNlAV1yVGd27s4wHRg6SVIFqK97MntiIz3o7ZHhMdONVcL+ETMxmmkP
   qyI0dd52ReyMPcLnLzuo0ZoZrLsCEd2JLSaSo4cBr1zg6jR+oOGGrPJVQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="316275871"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="316275871"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 07:17:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="669921794"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="669921794"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 07 Mar 2023 07:17:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 07:17:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 07:17:05 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 07:17:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmtdksXVuzF3vn4YhR2vhtQol/RtieUECWMFWZpy9McZ19xtpo0TUIU5vPlNivN8uWIiJmmRl0iTIZTYt4towOcsxLJfw8IFRnGZ22zQAXHraY3mV4TDNybzJ2aJAtmH/I57IwYd78ueQzk153C+8HJh0bP5fvd4ZvQfPltdRiCX/k0V0XvqP2poxFsxaMyF+ewg8X46pCzIgQiHXVWmSowWXv5Bea6BVUv7RF2mJow0v52XlnciFl1KS9ggLYw1t4MZDa4OhGsb11vzua3VxVD1S+6VFu43dA1RakYPu6aXAvCHWC+raOZQ+8Scns/YF2q1x9rP5F80uI4Wib2yvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M31V9oMLgS8XGpbqQn11+Pv0iPz5I0CAp1QJXEYtRjc=;
 b=nquOnism5+lPQ3WNy2SyiN2j2hy27wSS3eHnqLIbpFQRNJl+mP5bE/ohQvvHBkzCMcSgTLNn80kQueCpUqedbxDLGNH1DfF8wdVgeHOCtq9+aEmtP/GOHT4LIiZ8n3OjuwTlhuwLgohRjHsj0K97AFf3S39eteUkhez0bDzmmoCQPNBpQcww2pEVMBhy8u4lUf7yMBrMMjIhLYafI9LIOe7d71h1weG1dDuS765jBjdg1zqLqZLex9MznVJ9EzeLsF+0S1Kf02waaIsOKv6ax2B9lgRIh6OCjo19977C5Dz1hUCaktpF/h8Gw/noTifMNNLTOQVWnnmrc7///kNT9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DM4PR11MB5328.namprd11.prod.outlook.com (2603:10b6:5:393::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 15:17:01 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::e28f:b27b:4b9d:2154]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::e28f:b27b:4b9d:2154%5]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 15:17:01 +0000
Date:   Tue, 7 Mar 2023 23:18:23 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <edumazet@google.com>
CC:     <linux-kernel@vger.kernel.org>, <ast@kernel.org>,
        <john.fastabend@gmail.com>, <heng.su@intel.com>, <lkp@intel.com>
Subject: Re: [Syzkaller & bisect] There is WARNING: refcount bug in
 sock_map_free in v6.3-rc1
Message-ID: <ZAdVvximUvRXcGZZ@xpf.sh.intel.com>
References: <ZAdMB+eGT3TQEo7y@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZAdMB+eGT3TQEo7y@xpf.sh.intel.com>
X-ClientProxiedBy: SG2PR02CA0075.apcprd02.prod.outlook.com
 (2603:1096:4:90::15) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DM4PR11MB5328:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e70080-47ba-490f-54ae-08db1f1f007e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R98O/jt1qySdsMuzXI1pT7Smrr9MkEuNDisRRQRu4LkWq/sbfZxO7dCNlrh+ReyJjunocfneL+dtNUi7AFFRkvLjI8T5lH2cUJZzFrHmbqSx0+c8xb6fSL+0N7uhITx7oAY4H8LltWUR4E5p5ZELAaxKl9uYcolT/hMpWm5vsu5QBm9lop09EGgcf3RSjzltafT6k4iSOgZw9Qd+FzOOJAIzQvF1aZyhhQDqXR5up/at2kn76f4FeQ+KZsxFbSKJVaX7UukNMiwhhMh6C5kx0HNiZdg0TgdIVZ+UZ5wmsD6yYJb3tK73mjRXvU9sAZ6WnRIhCurekdQCXbfJCHd16WVmS5uie53Jh/r/QnTl1mRg0L9jO1hxjMZ3FZurVYiBHofASGo4UxB8foW5wIbl9SBI/8PPV+oK3rT3fS5BnY/jEtqkY7SmSYeKw1ZvfnvEcOiW9BsqsCBB95QZ8ESlY6sY7lznHm2a1IpOFterxNvex8qYDCvhba0/QjrBmTwjCmUUBpOBCC5YnUo2qV7x/VYSOCAtctNwCgxS2JzqaAtfieHNW2/82GuQL9cN/i6UOIcyYZYnBVxWIJvJQHyKbcl6ZrizdV00xHVOi+bPwF62/6HuqRX+k6C3BRKuBFWWe7MA+t3S5Vwi89LZ+CoyqyGw/KFb31eBDjUHSlLCLpC/DKKfrRuPTD/DtGQzcjCN3eA34aCfY13cK4AL/R482XnlfykO5fhe238oZ7qEsxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199018)(44832011)(83380400001)(316002)(8676002)(66476007)(4326008)(66946007)(6916009)(66556008)(86362001)(38100700002)(186003)(82960400001)(26005)(478600001)(6486002)(107886003)(6666004)(966005)(6506007)(6512007)(45080400002)(53546011)(30864003)(5660300002)(8936002)(2906002)(41300700001)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MS93V8/BhIsWYVRGzo6dyQHkgsJkqZgbIYvoAw99TGMA2nLId8sYgrClxKca?=
 =?us-ascii?Q?WT0jB6E6kWWfKAJvKcvr1NrnoQuRiMPJKZuO3cXBHMIl6f+bB9S77b8xCdUx?=
 =?us-ascii?Q?b2nAJxVLw09PfJh5tSURBe1EZGaiUWjce7MOagiySIBIqrDBceQhnOQUK/ZU?=
 =?us-ascii?Q?QKASMGvXs1hxQYwT9IOVROXOpbcQEDPxCavLacHenu4zxDonfYMmVBZg4RqF?=
 =?us-ascii?Q?VIEhn1NSCetvhFVc1F7LVXsmsYQZdfMyFnbpCKQUznPp0jtZeNKpoMqPTHHD?=
 =?us-ascii?Q?Eys7PTvMagm++R+HKnBcW4POuyjQa8R8jOcrEKXHlPfiGkYPekrVcvFmF8pr?=
 =?us-ascii?Q?3miDyE/TimTVcUGspHocNE6+FNOmKJ1H/ccklZnohzx9pO0jvHTE8zyRbXXZ?=
 =?us-ascii?Q?ogtrr7ltRNx67+qtO+OJcIRTneBUJrx4flYwg/JKlr4Di8cpx6/AUPwrj4YF?=
 =?us-ascii?Q?09xOii8sRZ1f06APSdUbgfBelvyljfyIMVdov6Ge53en+Kq9grUhTaZxDrb/?=
 =?us-ascii?Q?pPt/CThAm17sjjdXvjSmYN8RNmaC98mYL5nM8DHFZLhOi6SMLqvKv26w8yo+?=
 =?us-ascii?Q?nJXIsjC1obR+vqnc8hkvia/rJvww7nml8vMQFyvgm/PuLPSNd1r91Nnu/HMS?=
 =?us-ascii?Q?QuQ93R7qlDfNqMjXDwcLuefcN91LtPrEQpU3nW3eoLd59p45QjtJS5Y3hEPi?=
 =?us-ascii?Q?P3TctnW3qVY9sJcQfq8iN7PW91nzy6mtbr9GEopA1Xih0n+ZJgBiWbmWEM/O?=
 =?us-ascii?Q?4cchpytPZ3t9vqVTSWB6RN9Q7ywKj+arZYJoT4p4QPQsFa/bcb6S9V+uy3k/?=
 =?us-ascii?Q?BgMc2Hw95Z32w2TQ6ZqTU+16TE33uVtp28jv4RJ2/f3v7ofXtjcRd/Zg7+7e?=
 =?us-ascii?Q?dQsKFICJ8FG07hNwufO2bkEmbvvmge+JvZ6ENf4wORdL6wkNaCgyaHRV0BEQ?=
 =?us-ascii?Q?S4qhq/pD+0LLRjLsEHBrwZX+SdCCbYuG0sziJrZvlJDmTM3930Z0gQqonU/V?=
 =?us-ascii?Q?Kdg/56bfD0fto+b2H4ooZ6a5aBnQpGwwloM7HAuj9raU1PGL6mFo/++0Bqgc?=
 =?us-ascii?Q?QzeSzxPoJLI1vJcuHDpujn3cNJmOQYy+6k9MdC2ESQM/IyECu5Bgn4kKttf6?=
 =?us-ascii?Q?/z3V611GQ20DhxurMcEZQodkVbXkV4O9rL0r7/1M1FYqpEBjdpN78Lbdw7tU?=
 =?us-ascii?Q?marYG5A9aI7i4ESdYWrVFT4ahHD+3F6tked8r2RdQj0cetZpz+0+nvE/aCdG?=
 =?us-ascii?Q?y3oNqFGRuxbxQiz5pUR05bkUp9cCALdb8Mi62CLgXEWhsKD2RHkEmkkTpE+P?=
 =?us-ascii?Q?W33CzqMdt2Fh40ZrOr9+YGuDWkxJHVKq+LaZ8u1ut7ONWe145AJMfOhLT/ap?=
 =?us-ascii?Q?6SXmG+5yqBUeznEP0OkFeChRm/845OglpztDi1UWughhRqtYYx2HE/bo5PSJ?=
 =?us-ascii?Q?ekUlagv7Mx2sJrCvbPJHeVjc9Ete6dGQ5KCR0hYfirSkY6XvBNWGBruNQhZo?=
 =?us-ascii?Q?iCbQjkRYAPdW/LZxwnWFQp4Ko3pLGGhSd6qRRfmb+aPn3MTt0subgz+OaHcK?=
 =?us-ascii?Q?v+3h57KLR6V8aTy9Yl0tkZR3mcpbFUcHwBqo7KVzBYveVnkr0y4+ZNLx5oxY?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e70080-47ba-490f-54ae-08db1f1f007e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 15:17:01.7189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAhz0Kaz+XSakqbQwV1Oo8c7g6rpLtYXxbh05iWlr64f89+SFpX7S5Li1/25CmtptL4uf3p5d9W6IwCOGFISGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5328
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to update the missed reproduced code from syzkaller:
https://github.com/xupengfe/syzkaller_logs/blob/main/230306_123510_sock_map=
_free/repro.c

Thanks!
BR.

On 2023-03-07 at 22:36:55 +0800, Pengfei Xu wrote:
> Hi Eric Dumazet,
>=20
> Greeting!
>=20
> Platform: x86 platform
> All detailed log link: https://github.com/xupengfe/syzkaller_logs/tree/ma=
in/230306_123510_sock_map_free
> v6.3-rc1 problem dmesg: https://github.com/xupengfe/syzkaller_logs/blob/m=
ain/230306_123510_sock_map_free/v6.3-rc1_problem_dmesg.log
> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230306_=
123510_sock_map_free/bisect_info.log
> Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230306_1235=
10_sock_map_free/bisect_info.log
>=20
> There is WARNING: refcount bug in sock_map_free in v6.3-rc1 kernel.
>=20
>=20
> [   58.955232] ------------[ cut here ]------------
> [   58.955976] refcount_t: addition on 0; use-after-free.
> [   58.956752] WARNING: CPU: 0 PID: 9 at lib/refcount.c:25 refcount_warn_=
saturate+0xe6/0x1c0
> [   58.957846] Modules linked in:
> [   58.958278] CPU: 0 PID: 9 Comm: kworker/u4:0 Not tainted 6.3.0-rc1-fe1=
5c26ee26e+ #1
> [   58.959340] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   58.960854] Workqueue: events_unbound bpf_map_free_deferred
> [   58.961630] RIP: 0010:refcount_warn_saturate+0xe6/0x1c0
> [   58.962344] Code: 1d b8 c2 43 02 31 ff 89 de e8 c6 ab 52 ff 84 db 75 9=
7 e8 5d aa 52 ff 48 c7 c7 d8 b6 be 83 c6 05 98 c2 43 02 01 e8 1a 55 36 ff <=
0f> 0b e9 78 9
> [   58.964836] RSP: 0018:ffffc90000053da0 EFLAGS: 00010286
> [   58.965582] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8=
111b6fb
> [   58.966570] RDX: 0000000000000000 RSI: ffff888007372340 RDI: 000000000=
0000002
> [   58.967569] RBP: ffffc90000053db0 R08: 0000000000000000 R09: 000000000=
0000001
> [   58.968547] R10: 0000000000000000 R11: 0000000000000001 R12: ffff88800=
ec16200
> [   58.969532] R13: 0000000000000000 R14: ffff888015808000 R15: ffff88800=
ed6fc00
> [   58.970500] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlG=
S:0000000000000000
> [   58.971647] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   58.972447] CR2: 0000000020000000 CR3: 0000000003e3a006 CR4: 000000000=
0770ef0
> [   58.973461] PKRU: 55555554
> [   58.973851] Call Trace:
> [   58.974206]  <TASK>
> [   58.974520]  sock_map_free+0x387/0x390
> [   58.975077]  bpf_map_free_deferred+0x124/0x2d0
> [   58.975753]  process_one_work+0x3b1/0x9e0
> [   58.976350]  worker_thread+0x52/0x660
> [   58.976895]  ? __pfx_worker_thread+0x10/0x10
> [   58.977514]  kthread+0x161/0x1a0
> [   58.977994]  ? __pfx_kthread+0x10/0x10
> [   58.978529]  ret_from_fork+0x29/0x50
> [   58.979073]  </TASK>
> [   58.979448] irq event stamp: 25237
> [   58.979940] hardirqs last  enabled at (25245): [<ffffffff811eac21>] __=
up_console_sem+0x91/0xb0
> [   58.981151] hardirqs last disabled at (25252): [<ffffffff811eac06>] __=
up_console_sem+0x76/0xb0
> [   58.982466] softirqs last  enabled at (25234): [<ffffffff83023a3c>] __=
do_softirq+0x31c/0x49c
> [   58.983769] softirqs last disabled at (25229): [<ffffffff8112b5a4>] ir=
q_exit_rcu+0xc4/0x100
> [   58.985055] ---[ end trace 0000000000000000 ]---
> [   58.985813] ------------[ cut here ]------------
> [   58.986530] refcount_t: underflow; use-after-free.
> [   58.987460] WARNING: CPU: 0 PID: 9 at lib/refcount.c:28 refcount_warn_=
saturate+0x15e/0x1c0
> [   58.988714] Modules linked in:
> [   58.989207] CPU: 0 PID: 9 Comm: kworker/u4:0 Tainted: G        W      =
    6.3.0-rc1-fe15c26ee26e+ #1
> [   58.990565] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   58.992351] Workqueue: events_unbound bpf_map_free_deferred
> [   58.993213] RIP: 0010:refcount_warn_saturate+0x15e/0x1c0
> [   58.994119] Code: 02 31 ff 89 de e8 52 ab 52 ff 84 db 0f 85 1f ff ff f=
f e8 e5 a9 52 ff 48 c7 c7 08 b7 be 83 c6 05 1f c2 43 02 01 e8 a2 54 36 ff <=
0f> 0b e9 00 9
> [   58.997238] RSP: 0018:ffffc90000053da0 EFLAGS: 00010286
> [   58.998124] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8=
111b6fb
> [   58.999358] RDX: 0000000000000000 RSI: ffff888007372340 RDI: 000000000=
0000002
> [   59.000558] RBP: ffffc90000053db0 R08: 0000000000000000 R09: 000000000=
0000001
> [   59.001737] R10: 0000000000000000 R11: 0000000000000001 R12: ffff88800=
ec16200
> [   59.002928] R13: 0000000000000000 R14: ffff888015808000 R15: ffff88800=
ed6fc00
> [   59.004172] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlG=
S:0000000000000000
> [   59.005541] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   59.006521] CR2: 0000000020000000 CR3: 0000000003e3a006 CR4: 000000000=
0770ef0
> [   59.007770] PKRU: 55555554
> [   59.008260] Call Trace:
> [   59.008709]  <TASK>
> [   59.009094]  sock_map_free+0x36c/0x390
> [   59.009745]  bpf_map_free_deferred+0x124/0x2d0
> [   59.010543]  process_one_work+0x3b1/0x9e0
> [   59.011288]  worker_thread+0x52/0x660
> [   59.011947]  ? __pfx_worker_thread+0x10/0x10
> [   59.012694]  kthread+0x161/0x1a0
> [   59.013270]  ? __pfx_kthread+0x10/0x10
> [   59.013925]  ret_from_fork+0x29/0x50
> [   59.014570]  </TASK>
> [   59.014959] irq event stamp: 25629
> [   59.015589] hardirqs last  enabled at (25639): [<ffffffff811eac21>] __=
up_console_sem+0x91/0xb0
> [   59.017047] hardirqs last disabled at (25646): [<ffffffff811eac06>] __=
up_console_sem+0x76/0xb0
> [   59.018450] softirqs last  enabled at (25412): [<ffffffff83023a3c>] __=
do_softirq+0x31c/0x49c
> [   59.019851] softirqs last disabled at (25367): [<ffffffff8112b5a4>] ir=
q_exit_rcu+0xc4/0x100
> [   59.021282] ---[ end trace 0000000000000000 ]---
>=20
> Found this issue existed in v6.2 kernel also.
> And bisected from v6.2 to v5.11 and found the bad commit:
> "
> 0a182f8d6074
> bpf. sockmap: fix race in sock_map_free()
> "
> Reverted the bad commit on top of v6.2, above issue was gone.
>=20
>=20
> There was "use after free" in dmesg info.
> And I found that GPIO kselftest triggered the similar Call Trace also.
> "
> cd linux/tools/testing/selftests
>=20
>  1.  ./kselftest_install.sh
>=20
>=20
>  2.  cd  linux/tools/testing/selftests/kselftest_install/gpio
>=20
>  # ./gpio-mockup.sh
>  1.  Module load tests
>  1.1.  dynamic allocation of gpio
>  2.  Module load error tests
>  2.1 gpio overflow
>  test failed: unexpected chip - gpiochip1
>  GPIO gpio-mockup test FAIL
> "
> Related dmesg:
> "
> [ 9729.144086] ------------[ cut here ]------------
> [ 9729.149680] refcount_t: underflow; use-after-free.
> [ 9729.155478] WARNING: CPU: 75 PID: 809778 at lib/refcount.c:28 refcount=
_warn_saturate+0xd3/0x120
> [ 9729.165489] Modules linked in: gpio_mockup(-) xt_state rds quota_v2 qu=
ota_tree brd overlay ntfs btrfs blake2b_generic xor raid6_pq ip6t_REJECT nf=
_reject_ipv6 ip6t_rpfilter xt_tcpudp ipt_REJECT nf_reject_ipv4 xt_conntrack=
 nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bridge stp=
 llc vsock_loopback vhost_vsock vmw_vsock_virtio_transport_common vhost vho=
st_iotlb ip6_tables vsock ip_tables nft_compat x_tables ip_set nf_tables nf=
netlink intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncor=
e_frequency_common i10nm_edac nfit x86_pkg_temp_thermal snd_hda_codec_realt=
ek intel_powerclamp snd_hda_codec_generic ledtrig_audio coretemp snd_hda_in=
tel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hda_core snd_hwde=
p snd_seq kmem ofpart snd_seq_device kvm_intel snd_pcm pmt_telemetry pmt_cr=
ashlog cmdlinepart snd_timer kvm ipmi_ssif spi_nor device_dax intel_sdsi pm=
t_class irqbypass mei_me mtd rapl snd i2c_i801 isst_if_mmio pcspkr dax_hmem=
 isst_if_mbox_pci intel_cstate
> [ 9729.165539]  spi_intel_pci soundcore isst_if_common mei intel_vsec idx=
d i2c_ismt spi_intel i2c_smbus ipmi_si acpi_power_meter acpi_pad mac_hid sc=
h_fq_codel crct10dif_pclmul crc32_pclmul ghash_clmulni_intel sha512_ssse3 a=
esni_intel crypto_simd cryptd ast igc pinctrl_emmitsburg pinctrl_intel pwm_=
lpss [last unloaded: init_module(O)]
> [ 9729.297472] CPU: 75 PID: 809778 Comm: modprobe Tainted: G S        IO =
      6.2.0-lkml #18
> [ 9729.306942] Hardware name: Intel Corporation ArcherCity/ArcherCity, BI=
OS EGSDCRB1.SYS.0090.D03.2210040200 10/04/2022
> [ 9729.318926] RIP: 0010:refcount_warn_saturate+0xd3/0x120
> [ 9729.325020] Code: 9f 00 0f 0b 5d c3 cc cc cc cc 80 3d c5 72 b7 01 00 0=
f 85 74 ff ff ff 48 c7 c7 10 b9 2b bc c6 05 b1 72 b7 01 01 e8 7d 39 9f 00 <=
0f> 0b 5d c3 cc cc cc cc 80 3d 9b 72 b7 01 00 0f 85 4c ff ff ff 48
> [ 9729.346438] RSP: 0018:ff38111b0f3b3e48 EFLAGS: 00010286
> [ 9729.352524] RAX: 0000000000000000 RBX: ff1e4ed2436ee100 RCX: 000000000=
0000001
> [ 9729.360745] RDX: 0000000000000001 RSI: ffffffffbc1ea3d1 RDI: 00000000f=
fffffff
> [ 9729.368960] RBP: ff38111b0f3b3e48 R08: 0000000000000000 R09: c0000000f=
f7fffff
> [ 9729.377188] R10: 0000000000000001 R11: ff38111b0f3b3cb8 R12: ff1e4ed24=
b90fc00
> [ 9729.385415] R13: ff1e4ed2436ee140 R14: 0000000000000000 R15: 000000000=
0000000
> [ 9729.393639] FS:  00007f76415d5740(0000) GS:ff1e4ef0972c0000(0000) knlG=
S:0000000000000000
> [ 9729.402941] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 9729.409618] CR2: 00007f764154fd96 CR3: 000000108c20c006 CR4: 000000000=
0f71ee0
> [ 9729.417860] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [ 9729.426087] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 000000000=
0000400
> [ 9729.434328] PKRU: 55555554
> [ 9729.437633] Call Trace:
> [ 9729.440650]  <TASK>
> [ 9729.443266]  kobject_put+0x10f/0x1b0
> [ 9729.447520]  fwnode_remove_software_node+0x35/0x50
> [ 9729.453158]  gpio_mockup_unregister_pdevs+0x3a/0x4e [gpio_mockup]
> [ 9729.460233]  gpio_mockup_exit+0xd/0x3b3 [gpio_mockup]
> [ 9729.466169]  __x64_sys_delete_module+0x140/0x240
> [ 9729.471619]  do_syscall_64+0x3b/0x90
> [ 9729.475909]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [ 9729.481830] RIP: 0033:0x7f7641954f7b
> [ 9729.486100] Code: 73 01 c3 48 8b 0d 15 8f 0c 00 f7 d8 64 89 01 48 83 c=
8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e5 8e 0c 00 f7 d8 64 89 01 48
> [ 9729.507517] RSP: 002b:00007ffef02671e8 EFLAGS: 00000206 ORIG_RAX: 0000=
0000000000b0
> [ 9729.516270] RAX: ffffffffffffffda RBX: 0000562e93269ee0 RCX: 00007f764=
1954f7b
> [ 9729.524519] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 0000562e9=
3269f48
> [ 9729.532752] RBP: 0000562e93269f48 R08: 00007ffef0266191 R09: 000000000=
0000000
> [ 9729.541004] R10: 00007f76419d3ae0 R11: 0000000000000206 R12: 000000000=
0000000
> [ 9729.549266] R13: 0000000000000000 R14: 0000562e93269f48 R15: 000000000=
0000000
> [ 9729.557518]  </TASK>
> [ 9729.560246] ---[ end trace 0000000000000000 ]---
> "
>=20
> I hope it's helpful.
>=20
>=20
> ---
>=20
> If you don't need the following environment to reproduce the problem or i=
f you
> already have one, please ignore the following information.
>=20
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v=
7.1.0
>    // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f6=
5 v6.2-rc5 kernel
>    // You could change the bzImage_xxx as you want
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
>=20
> After login vm(virtual machine) successfully, you could transfer reproduc=
ed
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
>=20
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc =
has
>=20
> Fill the bzImage file into above start3.sh to load the target kernel vm.
>=20
>=20
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> ../configure --target-list=3Dx86_64-softmmu --enable-kvm --enable-vnc --e=
nable-gtk --enable-sdl
> make
> make install
> ---
>=20
> Thanks!
> BR.
