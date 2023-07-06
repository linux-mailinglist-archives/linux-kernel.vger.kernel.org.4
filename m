Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918CD7498C5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjGFJxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGFJxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:53:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0A21727;
        Thu,  6 Jul 2023 02:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688637222; x=1720173222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZCTwEarZVfz6L7OhWE+2PAwDTd9f66HzYjjis2h0zro=;
  b=PDPcd0/3q66VUwgiJpg8IwwrmnFQLHhT66LQ8mmxoGQIz2F57G1MfRjZ
   T6l0B6hc/xDxLPLikoeYNH2KXhCCzeixxPqVxqYTwNmvcPCpyZpAAQ7Wq
   T+qNDcMTnhzhgICUswGDbA/4Cd2MBT5MZZfTRJw3/jKOMUt1R+dq/CWqL
   wvdCs5a99+EaQoWeS6LQcm9k9FIO+HC9EBmonP7zYb32qg8ZEjXdYBabw
   PklGGB9Ou75+9CaJJayp2lLJeOhJjsiTh3Rg0jbfvwNJ2NmYkavvDopi7
   PSVJUW32ziD7HSYM9AZmSkkCdCitY9P0xY7CyYMoKlHyaTnmJLmI62aVW
   A==;
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="asc'?scan'208";a="221603502"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jul 2023 02:53:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Jul 2023 02:53:37 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 6 Jul 2023 02:53:35 -0700
Date:   Thu, 6 Jul 2023 10:53:05 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Song Shuai <suagrfillet@gmail.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>, <mark.rutland@arm.com>, <guoren@kernel.org>,
        <bjorn@rivosinc.com>, <jszhang@kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <songshuaishuai@tinylab.org>
Subject: Re: [PATCH V11 0/5] riscv: Optimize function trace
Message-ID: <20230706-crumpet-chemist-84b1dce8b155@wendy>
References: <20230627111612.761164-1-suagrfillet@gmail.com>
 <c7090e76-b054-1f0d-8c05-18f041904b22@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TsUbL/pzvtHwGmhl"
Content-Disposition: inline
In-Reply-To: <c7090e76-b054-1f0d-8c05-18f041904b22@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--TsUbL/pzvtHwGmhl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2023 at 05:35:49PM +0800, Song Shuai wrote:
> Ping...

A context-less ping is not very helpful - what are you looking for here?
More reviews? For example, someone to look at 5/5?

> =E5=9C=A8 2023/6/27 19:16, Song Shuai =E5=86=99=E9=81=93:

If it's application you want, you sent the patch only last week - which
was during the merge window, making it unlikely to be applied.

Either way, please try to explain what it is that you are looking for
when you do a ping!

Cheers,
Conor.


--TsUbL/pzvtHwGmhl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKaPAQAKCRB4tDGHoIJi
0u7zAP4m9nHeOnzNDjd07uvtTYVoMTRG9PlPI7TMsYAWdsPwBgD+Ijw30cnV0FLL
OmYhxUULMKySX5DeeB8VLFHiJXnLcg8=
=9Z22
-----END PGP SIGNATURE-----

--TsUbL/pzvtHwGmhl--
