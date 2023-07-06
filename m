Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D40374A61F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 23:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjGFVsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 17:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjGFVsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:48:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F7C1FC1;
        Thu,  6 Jul 2023 14:47:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F2C66136F;
        Thu,  6 Jul 2023 21:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54FBC433C7;
        Thu,  6 Jul 2023 21:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688680077;
        bh=xPrfRcwCRWC8Llb+km158meSUnx/aUoWRQHVf7QPSD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OAhL7nRvZdJjZc1TRFxME0hOxF3jF0zIKdmHya+NPBeqY+EvFCcFv846VS7ljNuke
         MuQIumpBm39nMXf1dFSdz7HrCSm1LTT3fILV2yUTozmKohP/RDdgry9aZaK/az4Duv
         AilGMvlXl4aSW4uveXErqrylfjBuyzty4JdUU3nInpNNEIk4wa6MSXbsgyhF8MSKiT
         lUzdEk0k+IjcZSmG3UrJZrMWx8tbHw7mJQ4Sy/7RlZsy8uuGuL4YOb8lK/rkAcQl6s
         9nytGtIswe7e+VSMETihiu1Vyxm+ohgN5wQ2o6q3WrrTpGptIu9KYpM4UuS2h9p2MH
         YTDk3Db3Ot3Qw==
Date:   Thu, 6 Jul 2023 22:47:50 +0100
From:   Conor Dooley <conor@kernel.org>
To:     ron minnich <rminnich@gmail.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Ard Biesheuvel <ardb@kernel.org>, cuiyunhui@bytedance.com,
        jrtc27@jrtc27.com, kernel@esmil.dk, sunilvl@ventanamicro.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
Subject: Re: [External] Re: [PATCH v3 0/4] Obtain SMBIOS and ACPI entry from
 FFI
Message-ID: <20230706-barcode-front-5bed954740a7@spud>
References: <CAMj1kXFZren0Q19DimwQaETCLz64D4bZQC5B2N=i3SAWHygkTQ@mail.gmail.com>
 <mhng-b66b085a-eb15-4c9b-b2aa-93ddf16ec7aa@palmer-ri-x1c9a>
 <CAP6exYKwZG=_47r0jAUFYNL5-P-SS==k6vWdKiMJ9nB0upH5Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WZJy3m/uHxS6AiTK"
Content-Disposition: inline
In-Reply-To: <CAP6exYKwZG=_47r0jAUFYNL5-P-SS==k6vWdKiMJ9nB0upH5Zw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WZJy3m/uHxS6AiTK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Ron,

On Thu, Jul 06, 2023 at 02:39:13PM -0700, ron minnich wrote:

Please do not top-post or send HTML mails to LKML, they are rejected by
the list services.

Thanks,
Conor.

--WZJy3m/uHxS6AiTK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKc2hgAKCRB4tDGHoIJi
0ijoAQDzRpg7JkYw/5I203sH/zXQQ9kYceHTa7UL1EoZ+xkISgD+MQg+3shNDOQf
8p3zeQ4LDq9AuZwGqv1MRO8l5/YPHQM=
=dE3s
-----END PGP SIGNATURE-----

--WZJy3m/uHxS6AiTK--
