Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4986EBA25
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 18:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjDVQD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 12:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDVQD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 12:03:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E691736;
        Sat, 22 Apr 2023 09:03:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A11A760B78;
        Sat, 22 Apr 2023 16:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B9BC433D2;
        Sat, 22 Apr 2023 16:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682179435;
        bh=it93gmXDoW9uP9aF9DuUPAIAfLHjHw/yXOyTOuMN9g0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ILh6lBwIOlgoyv0rAUqkX14NsDn7UND8cRSCJ9BZTJetgoH5EmpmVBL98GeD0ipUk
         US3a39JYic2TPl/w6pDmewq2G2cGYwxg86mAL370x1WJmj8pMFDrropp34PK/p630Z
         hai4uteU2DzoIZdtrrsvKtgMpQsXAzag57v12CK8wvrl/4CCqWtmJ2P/abBDJBbIXg
         HW1oEKP6lb3e3pjj8leVHRIixegN3jOeOAbYuQBp9UNaH8M+XhViR7uCGJpBISj9uC
         BQGPI9jAEakMmI1KHnNPA/8OsuLicKhDCt9fjU4NFfkNlbuiasCV2K9MV7QBDurXuz
         69gnwEJHi7tjQ==
Date:   Sat, 22 Apr 2023 12:03:52 -0400
From:   William Breathitt Gray <wbg@kernel.org>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     william.gray@linaro.org, Rong Tao <rongtao@cestc.cn>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:COUNTER SUBSYSTEM" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] tools/counter: Add .gitignore
Message-ID: <ZEQFaDHYHb7tzjQd@ishi>
References: <tencent_3E0341A1C9AC8FCB7915E7D791D117445707@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2PJ4kaa6F6kJH0hA"
Content-Disposition: inline
In-Reply-To: <tencent_3E0341A1C9AC8FCB7915E7D791D117445707@qq.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2PJ4kaa6F6kJH0hA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 22, 2023 at 10:35:53PM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
>=20
> Ignore counter_example and include/linux/counter.h.
>=20
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

Queued for the counter-next branch of the counter tree.

Thanks,

William Breathitt Gray

> ---
> v2: Ignore /include/linux/counter.h, instead of /include directory
> v1: https://lore.kernel.org/lkml/tencent_1625E21562D40C91CEE047E82E2BFC52=
4305@qq.com/
> ---
>  tools/counter/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 tools/counter/.gitignore
>=20
> diff --git a/tools/counter/.gitignore b/tools/counter/.gitignore
> new file mode 100644
> index 000000000000..9fd290d4bf43
> --- /dev/null
> +++ b/tools/counter/.gitignore
> @@ -0,0 +1,2 @@
> +/counter_example
> +/include/linux/counter.h
> --=20
> 2.40.0
>=20

--2PJ4kaa6F6kJH0hA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZEQFaAAKCRC1SFbKvhIj
K0lQAPsHMtC3DGML6lyLCPGOaZyshLXrlZLyBApHHjZuSiQSBwD+ODo+/D3QUSNX
ejRyfYkbSPhaeMSPqZRN8i2WUj6EHwk=
=EqRg
-----END PGP SIGNATURE-----

--2PJ4kaa6F6kJH0hA--
