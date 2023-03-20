Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DDD6C11FD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjCTMgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCTMgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:36:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B024EC7E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679315794; x=1710851794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c4fTS22EntYkPyJ7LZfkV/isNWtd+bG5rciJpOFRr08=;
  b=K8S/meiHCef0KXxFjipXW3PVKvD7bOC7PkFKfRIXtFe34+M5HeOKaFen
   Dvyae5xwb2E/mRyzH/m4dquSaUw+IaLQkxLdkZUuMiDkaI02A1B36Y5gW
   K2TqcFqp0JgIcFcLqhNW0qGn8rk4SCS1MH/Vv35KpiyMyTz6XK9b8wf0V
   qM89T8vo70b/8FScuUJSK2HpJoohbWIItVALHV6RGTLX5f8V7aBBNAJOy
   W3TLzC91XOn2wjHu8utaV53IGRqp4Zgm2wv6Bql/J6E30/qstoXtquUF6
   lr843GA+1zcNUrr9leNNa1tqaPZGUCwYQNqGC4IVgvLeyW9Qlhovsxyoq
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,274,1673938800"; 
   d="asc'?scan'208";a="217085399"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Mar 2023 05:36:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 05:36:33 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 20 Mar 2023 05:36:31 -0700
Date:   Mon, 20 Mar 2023 12:36:02 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <leyfoon.tan@starfivetech.com>,
        <mason.huo@starfivetech.com>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v6 2/4] RISC-V: Factor out common code of
 __cpu_resume_enter()
Message-ID: <e4cbdcec-585b-4e82-8f74-3799592b1308@spud>
References: <20230314050316.31701-1-jeeheng.sia@starfivetech.com>
 <20230314050316.31701-3-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="87p31Ihj7t7GhMZ6"
Content-Disposition: inline
In-Reply-To: <20230314050316.31701-3-jeeheng.sia@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--87p31Ihj7t7GhMZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--87p31Ihj7t7GhMZ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBhTMgAKCRB4tDGHoIJi
0tVZAQCD0PqDy7i1j0jcRVMZZCw3usZtoykmyLeexRgU5oeodgD/bJEqeA2/L9nK
fgWqwx5DPJAzeU6xjtUxnyEon3UxJgc=
=sH0e
-----END PGP SIGNATURE-----

--87p31Ihj7t7GhMZ6--
