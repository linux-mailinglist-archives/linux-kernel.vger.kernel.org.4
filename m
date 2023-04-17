Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBE96E5189
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjDQURa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjDQUR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:17:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C600F10CE;
        Mon, 17 Apr 2023 13:17:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6164962434;
        Mon, 17 Apr 2023 20:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E41C4339B;
        Mon, 17 Apr 2023 20:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681762645;
        bh=2Z+SIDd9C6cEZu/Q2BOuzuLxvlVlpCYFLsgPpDLRIXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zu3KpGaddyzaA9/FQUizcAfTLZOuhyxaTrl0ye5+npMzq+AuNYsRCA8tnyaH1YMzm
         4E5MKBnoH6AHDogtfgdeDc6f2510KiVL4CH6pG8FAJTiQCaMjTPDTPETRXsRTAgmyF
         ZmGlWepufPohN99o9x/BE1uSrkkKB7kKnPD9eOf+qiv04Li3ric7VXuz9HuloScxXh
         LKKJrqm/1y23IikxGTzXOLj/Flj0nfH2wY8YMSvilZZoV1MQsXqDllkH/wJ31cg9XT
         QEajky01ohKSorWjtgEAHenIlFYf0hnY0nQXdFrPOwiuK6L9S+ssAuoD+WKvZm+JSw
         kBB7gwW5yGJ+A==
Date:   Mon, 17 Apr 2023 16:17:23 -0400
From:   William Breathitt Gray <wbg@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: 104-quad-8: Remove reference in Kconfig to
 25-bit counter value
Message-ID: <ZD2pU9hocDAVNkS0@ishi>
References: <20230410134516.102886-1-william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yJ+WcPd4laP4aanl"
Content-Disposition: inline
In-Reply-To: <20230410134516.102886-1-william.gray@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yJ+WcPd4laP4aanl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2023 at 09:45:16AM -0400, William Breathitt Gray wrote:
> Support for 25-bit counter values was removed in commit 4aa3b75c7460
> ("counter: 104-quad-8: Fix race condition between FLAG and CNTR reads").
> Adjust the Kconfig description of CONFIG_104_QUAD_8 to remove reference
> of 25-bit counter values.
>=20
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

Applied to counter-next of the Counter tree.

William Breathitt Gray

--yJ+WcPd4laP4aanl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZD2pUwAKCRC1SFbKvhIj
K96IAP9LUMD8lCBCVxA4KlLVfNblbaW5FlZE6RgpY33TPHf+hAEA2fHBH3FG0M2p
A17UqggKB6pxZVht2dicEajlneLB2AQ=
=Xj4C
-----END PGP SIGNATURE-----

--yJ+WcPd4laP4aanl--
