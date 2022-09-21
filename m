Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879C35BF9F4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiIUI77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiIUI7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:59:53 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10769DF35
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663750790; x=1695286790;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ok07KPT4YRSO1DHvmn0I/RySEz4287U+p3ZqqAgmMfc=;
  b=IrrEQ+uGTjELcGWz4YcN6Cq6WVk5aBWCITRNreQ4G0og282eNr40NjeW
   uKnpOc5O7+EkUCqwW7mZRzLyifTNo2V0sDHXsp36pUueKyjsdyZZ2wcBx
   xUwKCfinrhiuBWU3YBac9OCf/HbUTSLdF/d3oh3s4zXyOv8nTlUT3gD7A
   rcF6I/fg9enlJzFZQ1mvZie1sF7u31mZqW726W8SVIJJYhcLsUBQkSWfx
   umjBLq1Va3fq8EX2+KjpQDCwk8ewCMmdkUwydFd6a/VmM04iSogyMyoS2
   /3tgaIMToRk+N0nMdGIm1lon+cjLIC61WDom9Lk6iiShAs/j9jKPh2aOC
   w==;
X-IronPort-AV: E=Sophos;i="5.93,332,1654531200"; 
   d="scan'208";a="210281212"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2022 16:59:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlMAcTBJ4/fYP4dLq+LoOOF9lam+qj5cy9vr4bp9BHH49yj/9rjSNh5GtHnkrNjqRooEEr8OgwYGaB0ManD6chSLIGPvjHJQ18dRMjfkHzdJL6L/YnQ28hQ25AX7iPcvi13rLfwi9fXinsJxuIrl2u5kR6VfrKBfneLmefBNPQrhGROLyjhnVumBiXqs0kLX+ZaG/ZX4G8ODEgQVvOrn4NbD3Pv/gKeLHEm7FVF1p6vH7ToYKjyzIYVq4ChN24k2Vyx/U6VQDeIyVuxqrm9pVNXF+otX0I5Cubfsl5wCu8c96UMwXd+uhNMT/ijUULaIYcGe3uG8JBpLy7vynZLdUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ok07KPT4YRSO1DHvmn0I/RySEz4287U+p3ZqqAgmMfc=;
 b=fItmm/j7xBz1FIxhFGId20W7Cwbm7xyU7ugSNyb8JETDeL5MU9Rov325FHM+c5b/qQvCmPe1w4uKCff34Y1RRjKCYy+ZLyQRBpsy1nPxGH9SpoSG4AZOE2AEyJYNp9xIQl3wCqo0QemcQoZiwuxCyik8dIYBtINTxXyn7B0Fqbnq4U7U14mQH5cQPPXcY4AvUmkG9ALR4fKf98p/zC3N0qHdZF7VTwDK4QstqaxF8wq4ZG1sD1I7FEXwD9GeqyLMupTJ6dsnHg+CTNn0y1geKBArPndo4mmjuFzoC25VZAN+84eFI+DCO4jkGXsuPqMki9OUKfqCQcHngzb43zhqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ok07KPT4YRSO1DHvmn0I/RySEz4287U+p3ZqqAgmMfc=;
 b=HEPHCgNU3PSPZINcZUDGNJcgxVSm3CQpHzx5jQiKrLWCkXjoOYrgY/4tVoGKOWILDdkQ0BMmOUwR/O/5aCff7kC3ds+dUwq/QtRQgS5rfVgPxAV0LyvBrLWUwpc/rxUK16mD9ArkmtOqFOMUsw76DXikP0s6WskGvxcgHgH56Nc=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SJ0PR04MB7726.namprd04.prod.outlook.com (2603:10b6:a03:31b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Wed, 21 Sep
 2022 08:59:46 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::c8bd:645f:364:f7aa]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::c8bd:645f:364:f7aa%5]) with mapi id 15.20.5632.021; Wed, 21 Sep 2022
 08:59:46 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] x86/mm: disable instrumentations of mm/pgprot.c
Thread-Topic: [PATCH] x86/mm: disable instrumentations of mm/pgprot.c
Thread-Index: AQHYzZh/CXtSwfb9LkuupZiXt0U5TA==
Date:   Wed, 21 Sep 2022 08:59:46 +0000
Message-ID: <YyrSgXltQr5XrnSN@x1-carbon>
References: <20220824084726.2174758-1-naohiro.aota@wdc.com>
In-Reply-To: <20220824084726.2174758-1-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SJ0PR04MB7726:EE_
x-ms-office365-filtering-correlation-id: 9bf14f1c-d1c7-4616-9839-08da9bafa1fe
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +H2pdmAdFaK784kzM+2DlMf4plTiMpV4ESt6vul6ZdDFZgmHQ6LADHEX++N8vsNjBbRiOEMPw0DdW6KPZX1t7PFhvbt45Z14MDWsGmltO/gCCGDunsmyE7tgdHvCVWno9Q0Ys++t1CgjX/8+VwAjypagSi4Pasjk5df6RAKDNWFdkoj49RTQBamMv8S6m6CUscqpGS0yR6euHkTbYE2MzV8GYvyatPTde44vZW0i2aO1P0jjW0A547wm15dGutjGlNKicD2XjIfnHBHmsxoQgUyK7ui3jhoZClTON2OwWw9QsxNmeRUN7Lh+TAUcmVLlWBEkfQORVEnhutTyjg1HHYmxcbD3EPq9kFEHkXcxPg2QWHYZu3grtr4cLa8/D/dw2yRP3RfSwfH5coyEPgpPgYBzH262VvQhdHDM2Albq2zDeTiaZLtVeuViIF5suP4xeIZ2a09WKX6mnGLxHYFKibka1nAXcEtEANtdNF4uRXi3x1pNs65hJtWEFEWPyQlHMM3PDeMplukECOrqW7l3xiu1WDwEGvPoSdiI0UaNeef7nZdB6rOR5+etwPiFKQr97lF8/Bvn33lnkn1JNWGsdp/VHLUUI1Y09KOr3oArHOf9PGPTEVvuUOs933R+e/caz4NCzg8N46p3rVSoVIX1zESUrEGJutEt7BzJ0/cgaw7p2Hsr3rOBB1zAQE0oJw0vQvHPa0D7kG+e+NjyB1o9CuLt1lu9JeYv5581mg5V2j8Vtd5vOflfFth+P88hFAnMz2BMdG5KoH41xcEGd3mnHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199015)(83380400001)(122000001)(38100700002)(82960400001)(38070700005)(5660300002)(66476007)(7416002)(2906002)(41300700001)(186003)(8936002)(33716001)(478600001)(71200400001)(6486002)(66556008)(6506007)(26005)(6512007)(9686003)(8676002)(4326008)(64756008)(4744005)(66946007)(76116006)(66446008)(316002)(54906003)(6916009)(86362001)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ih7ZA5QN5gufNjci3pCwQK2Nhyp7LTIZoK0JhYwVBM1wL0UxobUqOorYEDTx?=
 =?us-ascii?Q?ClI9iP6vlPNQmu/wDVg6Ie9UqZf4+BOCNkNM98vx1d9QA6CNGcBlRAjat3FZ?=
 =?us-ascii?Q?psPXJLuuwUX3LPqsBwz3Yi8PQLyNzLFag/wD/xm7S64yDbmMZK5cClI+KRit?=
 =?us-ascii?Q?y7i4y4b/FfMi2byqsmFj7TBwm5cq0Gnyqqco4tpBwRmV9DGDTgO7ygI5tsIr?=
 =?us-ascii?Q?6+j14XRtJYhhsNiWiTInu2K7v7udA0QgFTAQ9/2POyUpF1Nci58fbm7TIj9J?=
 =?us-ascii?Q?KYl7x2xBQF4/6hCIX//hjC7EMO2z7UDBc3YTY1T/BmnKrGUfs+QOb0SjTe6Z?=
 =?us-ascii?Q?UTR5HOuWqYlJh2DFEKvffzbNtW4gE0crFrtZ/18rNUg1ozPQt2JSRxOqbOb0?=
 =?us-ascii?Q?6AltditZCT5KfLgzG24ve1uHmuihotUxVD5Lb23Uq7hZWkTpX8cJfAGDhKoo?=
 =?us-ascii?Q?+waYXjaX8CdJSh1wklJKIgjbAnwVx9MDH33Z7m59YD4iYN284NcoJTsNSLwF?=
 =?us-ascii?Q?y0r9CexHymnE6l3T8lP394rl5PBoy5MQze3gBow5TAyyug/UZbNV0jLhLuUp?=
 =?us-ascii?Q?7s0rudUvnKg5GHQV93i2tdvFYGXqBtDHa6wx+e+osTags2xsrJIRUiPFI0+C?=
 =?us-ascii?Q?coHgHBxihqucGrjcdgzEuebBndoafiFnx9uZgwuMp62pjg28c0L0NQgYv8ER?=
 =?us-ascii?Q?3KrPk7iUBV07Ygm0lmctPn8ew7mfBIItVIRU4Nf8sz91xVX6WgBZqMNgfvIp?=
 =?us-ascii?Q?avl84PwA9/zmGw5Q0q77fSgSIysozTvWRT8iQDlYO+ZDG6uCVRfDducBiHLv?=
 =?us-ascii?Q?5JwZq6RIh29/UkL9u3XTT8jX92Hryf1UWRQ31qd9wW9qdYwZm+TWx64V4Fie?=
 =?us-ascii?Q?4qxTAPQvyaX2QX8ULLv1/cr81ffZGQCH3Yrlvcz+04kOk7QbPd6Ra7JRXpOS?=
 =?us-ascii?Q?NV3+VPAb6xSOmKGMAis+FsZPJkukRFq1xn+n6W/GA18aUATywQugRUXkns4/?=
 =?us-ascii?Q?/mZojpi6BpyhBQiqZKpZM2pQrPxu++s5x01Xn5PDpyATzRRrYuy/qkM8/ZEP?=
 =?us-ascii?Q?AS/vj13XeBV+/Ntr1RqIml06DKEYtUm6gcpSQl4Z2btwOcNAHpdy5shIA9/f?=
 =?us-ascii?Q?XSYwA89sIAPwywRmhkwjnorUuxQfpVRA0BEUjTZUI7bxQFoFS7orRua5IIsj?=
 =?us-ascii?Q?MG8SaA67g+72NG4UpPzWPxca4lgKtoStuezpBUc4U8viEIAMHD/seO81BAVs?=
 =?us-ascii?Q?Scsqf1QTaJ4FcIide8edHZ6zO2kxYeBb1h7e1d/Omu06fc1humxzQbX5p23K?=
 =?us-ascii?Q?e1r13/z/kZxPKKEXi+TKLzvtd3Qew7eQJorgTlok5X5YtyGgO+hxEX+Y6X8u?=
 =?us-ascii?Q?iFrFKNCiBOeHUQoEg4YpJ6Q7yWyQ69CEc6MzSxyesNrVyWu7Rd4Cz2tMw5Tr?=
 =?us-ascii?Q?nnWnN34VdSYX9Kua+kUlC4hLxC9Wr92CU4qb12qQoNtU4Ybz21sLUIKRCu0z?=
 =?us-ascii?Q?jK3FUTMWvS4FbEuH/6dlVrbFDrOq1GLdPlg3xypxmxXwvaRVXEeHhAlTWQRk?=
 =?us-ascii?Q?pqBygSLhMvHPqojPi+JJWysQXMI71wv97IBdPf7Rfp+6lLuMIm9+6P+LmlxB?=
 =?us-ascii?Q?KA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CAC8B6DE02485047899CCFE4DC934A0F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf14f1c-d1c7-4616-9839-08da9bafa1fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 08:59:46.5120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: glgoDzofirJCTjNUVYELKtvvnC6Vg1/tgZkh1Hm5yZRbiov3cH5+HHhkB2wD0x6xpvbqBQ+lbHGFRhRj7z4myQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7726
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 05:47:26PM +0900, Naohiro Aota wrote:
> The commit 4867fbbdd6b3 ("x86/mm: move protection_map[] inside the
> platform") moved accesses to protection_map[] from mem_encrypt_amd.c to
> pgprot.c. As a result, the accesses are now targets of KASAN (and other
> instrumentations), leading to the crash during the boot process.
>=20
> Disable the instrumentations for pgprot.c like commit 67bb8e999e0a
> ("x86/mm: Disable various instrumentations of mm/mem_encrypt.c and
> mm/tlb.c").
>=20
> Before this patch, my AMD machine cannot boot since v6.0-rc1 with KASAN
> enabled, without anything printed. After the change, it successfully boot=
s
> up.
>=20
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---

Hello Andrew,

I see that this patch is in linux-next, but not in Linus's tree.

Since this fixes something introduced in v6.0-rc1, I think this
ought to go into v6.0 before it is released.


Kind regards,
Niklas=
