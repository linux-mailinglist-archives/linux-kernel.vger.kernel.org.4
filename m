Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F271721340
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 23:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjFCV52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 17:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjFCV5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 17:57:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE5BFD;
        Sat,  3 Jun 2023 14:57:23 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 65E4A6602B7B;
        Sat,  3 Jun 2023 22:57:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685829441;
        bh=hJv1+07zztxnXaWB2lGLhpwvzjwzOPI66T01+jArZXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i+6zwYvDfkcEW67V2s8wtEUsRo+LG6xkCsd1FhS3pQ7RyKPIZH8NGTpoWuJBnoFSj
         sWudrVLaPg3txEwfu/KRQNgJnDzqLlSSdUYB/7KKYl5xWXXrLKggqchaUhMDRNWaaM
         pKxfY9cJSLO+MHLf06v2q5S3T4grbhX7NUPGEdvkeZWoadv79OJKEWrez5VOIelpMe
         7BFzw7kOMgfvmU2YU/ZWjcNJRRSLa31JngHg2en7AyfyPGMTWmlUztaWRjStSEvh3v
         Y+U3iazDDbitswzonWPDBuC1OMqgfjvclRzPR7ZeCuGh5vJvLw00gkNP7zMHYKcL1O
         e7IEV8YEzXGTQ==
Received: by mercury (Postfix, from userid 1000)
        id 03463106090A; Sat,  3 Jun 2023 23:57:18 +0200 (CEST)
Date:   Sat, 3 Jun 2023 23:57:18 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <20230603215718.ca5hdzdsj4btnlc2@mercury.elektranox.org>
References: <20230525113034.46880-1-tony@atomide.com>
 <20230602083335.GA181647@google.com>
 <87a5xii33r.fsf@jogness.linutronix.de>
 <20230603054139.GR14287@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tneo32rghtw2mwkv"
Content-Disposition: inline
In-Reply-To: <20230603054139.GR14287@atomide.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tneo32rghtw2mwkv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sat, Jun 03, 2023 at 08:41:39AM +0300, Tony Lindgren wrote:
> Looking at the kernelci.org test boot results for Linux next [0], seems
> this issue is somehow 8250_mtk specific. I don't think the rk3399 boot
> issue is serial port related.

The rk3399-gru-kevin board is broken because of a change from me
renaming CONFIG_MFD_RK808 to CONFIG_MFD_RK8XX and forgetting to
update the defconfig :( This means the board is missing its PMIC
driver. It should be fixed once the defconfig update is queued:

https://lore.kernel.org/all/20230518040541.299189-1-sebastian.reichel@collabora.com/

Unfortuantely nobody seems to feel responsible for the generic arm
defconfig files :(

-- Sebastian

--tneo32rghtw2mwkv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmR7tzsACgkQ2O7X88g7
+pqWzQ//Uie7CBnwn5JUIsHsI4pPtgldOe3Z8n7rWBzZvYXWIfkk/BJg1Dw8i+Xx
QFeJoehfNn02Lkznixt6ZsIL6iVQketP/BfKSFl/QFV/LkKqqRn8lqdwOtDi3ek5
LVEN0nbMCI6KMNFZgnIU0Vg6L7RLKA/PgAZ9n0FT/rnKQBj3yJCE9/UaqdxFmZ2Q
GMSOWPh21szOK9nd+9irXGLtJBirdSK+uzkwIt8zs/Ff2NiUPbHw+cArDb1qZwJ5
t7fLF9HkbrDViQtJr5eHdmVhXT4WIPZbeob2tKUy37weZemNXd9LTOjJlAxu7voa
swsc/jVZJCjQrySnn1MFmL8nV/Ae+MDq/EceDR5JpiiS/NN4AtdzV+ieRcqhf10a
Amni6QCMoe4nqMEFAPsdOTe1obH5qiTYhRohkIBjrQQ4CgCUDk6fvlq7LFjpW+ZD
BNsVHk9jlO+VKMclFLAmgWb4gV3HF68SE2cpOCtYINFmaAqxRfiboeIEsGDGOuA7
869iSzU5Z1m9Cz0huFRH6QaDIMCI4+WWikekGuTT3vuFdh4OgH/1ZNdSz2RizkGi
oQV08HqL8tkufUhFeiLUfDZhz6LmNzanlMcQZbEzlOyN9FOqXSZ4/BhPCLJtzMrT
tjDdjj0wFg7NgAJI+v6n71GpVDzWMNufTt+ppYm7GNRsveW+Dt8=
=oc53
-----END PGP SIGNATURE-----

--tneo32rghtw2mwkv--
