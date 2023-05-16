Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0347C704C72
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjEPLg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjEPLgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:36:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83610BA
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684236980; x=1715772980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CTuARb/YrAFoLf//M9oeOcM9jK+YYhZvEJI0/BqCYLc=;
  b=kX8SrAf0YcFctpqj8UJQe9Iu6AiHaeOgE3O5HLMR9pyRnDe6EHwyOsnO
   EZKAiVZB69hSCvDPogIelc0ggkf5A3Fugev0wLoicMYqEvw4JHSFn0HmB
   ckuLATAL1NjtC8eiEfeW6w8D94mQr/R0T7vj30jtZJsiLW2j3f9gqn4h7
   8Hrjy7yk606KVpL31ahxQOuxemTqAIsz+hVQHg1Yjx+GSnNMsi8B0GRWo
   eW6/y1o1d6iJio1fgF+xXx0peYzaEpONQJJ/cIHE3MZafxuSu4J02Y9Ta
   MWo9qVl4fqAJnFwz6sTJfzsH6VNEi/8bk0qJGWtsYssO4pdmKlGDyqacd
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,278,1677567600"; 
   d="asc'?scan'208";a="213509855"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 May 2023 04:36:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 16 May 2023 04:36:18 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 16 May 2023 04:36:16 -0700
Date:   Tue, 16 May 2023 12:35:55 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Song Shuai <suagrfillet@gmail.com>
CC:     <alexghiti@rivosinc.com>, <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>, <anup@brainfault.org>,
        <palmer@rivosinc.com>, <jeeheng.sia@starfivetech.com>,
        <leyfoon.tan@starfivetech.com>, <mason.huo@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Guo Ren <guoren@kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <regressions@lists.linux.dev>
Subject: Re: Bug report: kernel paniced when system hibernates
Message-ID: <20230516-figure-vanity-d8b671ca1aa0@wendy>
References: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Thw0RZ3mGVPR1apd"
Content-Disposition: inline
In-Reply-To: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Thw0RZ3mGVPR1apd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2023 at 09:24:07AM +0000, Song Shuai wrote:
> Description of problem:
>=20
> The latest hibernation support[1] of RISC-V Linux produced a kernel panic.
> The entire log has been posted at this link: https://termbin.com/sphl .

Since the reporting is a bit scattered between here and the sw-dev list:

#regzbot introduced: v6.4-rc1.. ^
#regzbot title: kernel accessing opensbi reserved memory

--Thw0RZ3mGVPR1apd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGNqiwAKCRB4tDGHoIJi
0kCaAQCKg2EPoULgExcqaStj6FVDGF8glj2Zx8FXdFbroDJd1AD/YDqMn5PkGi/W
MVkHIVMQ0QwpL9sXst2NadGypRkw7Ao=
=QQ5L
-----END PGP SIGNATURE-----

--Thw0RZ3mGVPR1apd--
