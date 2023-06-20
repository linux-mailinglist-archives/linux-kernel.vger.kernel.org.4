Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769E2736F20
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjFTOuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjFTOuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:50:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1D51712;
        Tue, 20 Jun 2023 07:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4399C6109A;
        Tue, 20 Jun 2023 14:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B38C433C8;
        Tue, 20 Jun 2023 14:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687272613;
        bh=1N8sfTqkXTL7Ptxsvt7hf8Yzq98vL8R1L0H1fSMsblE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z8boLADKI3wxcbjHTAIGbQIPGAj4vkK7UGqLHxsJLfyWuJIJxT4QbHRVhemsoHjUH
         3KH+nNZ1uHKmyBJ5LbnWddDJSThisBhekHH+mehkdIdcltT5Xdp196NBa6YXosKNyD
         loLXbgv++K4QAQWK/YUOwC8BrHzn6g81qkpq9ZEfLHmZDJ2Lk8MBxs136XvpeVlK5n
         /VCWx9mdZlwDI159ulOBNN3/wu905FRYRRmvi+wZv4Nc4e312CRQj0TFNlmWQj0REl
         e1mZB64KB97DdqoF3LpAyAzRyYtVaSIoXt2Cq9/66Fbw/BUyw2aJnlF1e7UTwYMzYI
         3gI6Q51LBvtnQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qBcgQ-0000uw-1k; Tue, 20 Jun 2023 16:50:14 +0200
Date:   Tue, 20 Jun 2023 16:50:14 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] WIP: gnss: merge MTK driver into UBX driver
Message-ID: <ZJG8ppuI6dS_jhe3@hovoldconsulting.com>
References: <20230523064310.3005-1-wsa+renesas@sang-engineering.com>
 <20230523064310.3005-2-wsa+renesas@sang-engineering.com>
 <ZIcC/sg59Ti+lL1N@ninjato>
 <ZJFRnIFUokVvV-pY@hovoldconsulting.com>
 <ZJF9tJokpbFtaeLG@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uwEegjmzjS3dGEBy"
Content-Disposition: inline
In-Reply-To: <ZJF9tJokpbFtaeLG@ninjato>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uwEegjmzjS3dGEBy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 20, 2023 at 12:21:40PM +0200, Wolfram Sang wrote:

> Speaking of proprietary protocols: did you ever get in contact with the
> gpsd folks? I stumbled over this mail from February this year [1] where
> nobody knew where this /dev/gnss0 device came from. I'd think we should
> be in contact with them if we want to support e.g. line speed changes?

No, I haven't and I have very little motivation for spending time on
this. With the features we have today gpsd works as-is (last time I
checked).

Line-speed configuration would likely also be handled transparently by
the driver without user space interaction, but there is also room for
extending the interface should need arise.

Johan

--uwEegjmzjS3dGEBy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZJG8oQAKCRALxc3C7H1l
CIUAAQDEKfIj4d9rjz8UxCnpaed1PVRGc9jW11M8TxrGS74IIwD/TSGPvoBOdzGi
2Jej/v9UPJtlVI8EynIsV4azE1Mdtw4=
=RL5r
-----END PGP SIGNATURE-----

--uwEegjmzjS3dGEBy--
