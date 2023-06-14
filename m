Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FE972F685
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243291AbjFNHid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbjFNHi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:38:26 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA13E62;
        Wed, 14 Jun 2023 00:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=WID80vYS4EtWRNtZsTHqjGXaq8KNYNCjE5M7eGOJcaY=;
        t=1686728305; x=1687937905; b=XOTxWAyaYtdz0GZwilfC+Vey4F321f5F84G/nxkRMRYL9td
        YmQV6w/Y02TNGLpfKJT9g8zbJjzTYl2TyjgE1SMSlqX4hgGc9klUS2MZTKVws853zyWPET+ikhFH1
        Z+3EBcgnYQAvS8Eu5NFP2XGOjOSEE5nmexm0Xq/f+TxkpWegI2HTjsJfFL+clK/ge0h7ZYkbUxFEp
        TE7HHUVn+puMndIJl+E2pUbGND9UjGQhQF8bJw8Ur6vQH2ijeg9GhU5XAlwGPXTDTyTnm2qVa0YPS
        HKrK+kbcMf/PHzofiY7D0GFHg4ribj2B3dTxQg6hHW10qpgjTboZh3bMs2vsTj3Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q9L56-005yyv-2C;
        Wed, 14 Jun 2023 09:38:16 +0200
Message-ID: <02650a6d4c82bce62a9625714540ea75f7b3f571.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: ath9k: remove unneeded variable from
 ath9k_dump_legacy_btcoex()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     baomingtong001@208suo.com, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 14 Jun 2023 09:38:15 +0200
In-Reply-To: <695b68601eecd648b7531f2e40561edb@208suo.com>
References: <20230614061007.62077-1-luojianhong@cdjrlc.com>
         <695b68601eecd648b7531f2e40561edb@208suo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-06-14 at 14:13 +0800, baomingtong001@208suo.com wrote:
> Fix the following coccicheck warning:
>=20
> drivers/net/wireless/ath/ath9k/gpio.c:501:5-8: Unneeded variable: "len".
>=20
> Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>

Same here. I'm even wondering if there are different people behind this?

Also, I'm wondering what you're up to - are you all training or
something? I see the same kind of patches that are the same kind of
broken from a handful of different people?

> ---
>   drivers/net/wireless/ath/ath9k/gpio.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/ath/ath9k/gpio.c=20
> b/drivers/net/wireless/ath/ath9k/gpio.c
> index b457e52dd365..f3d1bc02e633 100644
> --- a/drivers/net/wireless/ath/ath9k/gpio.c
> +++ b/drivers/net/wireless/ath/ath9k/gpio.c
> @@ -498,14 +498,13 @@ static int ath9k_dump_legacy_btcoex(struct=20
> ath_softc *sc, u8 *buf, u32 size)
>   {
>=20
>       struct ath_btcoex *btcoex =3D &sc->btcoex;
> -    u32 len =3D 0;
>=20
>       ATH_DUMP_BTCOEX("Stomp Type", btcoex->bt_stomp_type);
>       ATH_DUMP_BTCOEX("BTCoex Period (msec)", btcoex->btcoex_period);
>       ATH_DUMP_BTCOEX("Duty Cycle", btcoex->duty_cycle);
>       ATH_DUMP_BTCOEX("BT Wait time", btcoex->bt_wait_time);
>=20
> -    return len;
> +    return 0;
>=20

This won't even build.

Please try to understand the code you're modifying before you do. And
no, build-testing it (and fixing it) will not result anything better.

johannes
