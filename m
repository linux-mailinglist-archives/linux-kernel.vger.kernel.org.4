Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF875BD239
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiISQ3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiISQ3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:29:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCC03BC59;
        Mon, 19 Sep 2022 09:29:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFEB361E58;
        Mon, 19 Sep 2022 16:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC26C433D6;
        Mon, 19 Sep 2022 16:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663604957;
        bh=4VdiePOkmp/OFvDbVvlOVM3EL15ZdVX95NpybI0C5JE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HwLB0LN4m2a4S+AiA2dRVOxFZdadCBXdwtWgMDbuHjY7tkAO+h/f3oYFiJ6e2FwVw
         p/IpI/8NjadRkpeO4xiRCFf+zz7eyAACluTpEtLaLBOjAG8z1MZQ6ueU8JBT+lwYOC
         XYetMFE+o+VXrvsjsOe/+WXBv+FX80cqGgNMlLhBrUJNBrFPSaaGuBrsuFV7IkiOok
         8nIfDHpS7EOXy7pG/zAQ+LGj4onR2nhDELfbgjkLfI0KFO4aqPoHwDGHR16I5va+WX
         3NUz+6KagAPQjHTN/CQid/tK1rsFwQU1gEPGR3TBjP2eQ3oxRlyw0BgjmXnlDDGABm
         pcT1xtH0oRuTw==
Date:   Mon, 19 Sep 2022 12:29:14 -0400
From:   William Breathitt Gray <wbg@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux@rempel-privat.de, kernel@pengutronix.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: interrupt-cnt: Implement watch_validate callback
Message-ID: <YyiY2sKyuFiEHpjC@ishi>
References: <20220815225058.144203-1-william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q9YCHZKHyjXSqov2"
Content-Disposition: inline
In-Reply-To: <20220815225058.144203-1-william.gray@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q9YCHZKHyjXSqov2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 15, 2022 at 06:50:58PM -0400, William Breathitt Gray wrote:
> The interrupt-cnt counter driver only pushes one type of event on only
> one channel: COUNTER_EVENT_CHANGE_OF_STATE on channel 0. The
> interrupt_cnt_watch_validate() watch_valid callback is implemented to
> ensure watch configurations are valid for this driver.
>=20
> Cc: Oleksij Rempel <linux@rempel-privat.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

Applied to counter-next.

William Breathitt Gray

--q9YCHZKHyjXSqov2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYyiY2gAKCRC1SFbKvhIj
K8QsAPsGj8+ZNJy726G/oNYZ9tIY65a02Ncma4p3qmZ3KBgx5QEA3bg4LEBuI+mO
Js96KUcq2FKH2Js9jXzklZkDMaXzSgI=
=Ybm+
-----END PGP SIGNATURE-----

--q9YCHZKHyjXSqov2--
