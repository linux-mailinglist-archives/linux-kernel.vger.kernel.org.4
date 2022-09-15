Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB90C5B947C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 08:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiIOGba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 02:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiIOGb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 02:31:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907C195ADD;
        Wed, 14 Sep 2022 23:31:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CE7AB8170D;
        Thu, 15 Sep 2022 06:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B18C433C1;
        Thu, 15 Sep 2022 06:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663223482;
        bh=/j3wYkQ53wBqOy1dy0RP/FqvWpaMmnV8jV9KSEsMfb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q+g2wvii0/E/Z8cVEDNw6sgIeuruMdFIm883E1cP1WCsrDyMYItGA8qNKop/AUPuu
         wMyNNgu/YV0JUNQHMGqvgYhgPNkxHD3WvsIcgqfcUL2QA1UNBC7kdwpEe+PEk7e6w0
         DiP0vYCA249b6Wrrbjymk/ybH1P3mub/01z5lnKVOdeRAmq7s/HNMpim2gi7n9J0F5
         nW8gWK3MkdZ2waQEVRUM0j000m4/9R9xnSWK+W0GbxbjKCh5b3NU2QvMLEKVjIYm63
         vE9uJn4I7RBa3jdBgMG893n8+sNNdOkNEdgQwr5fdR8c1j98r7qGuKs/7+w3AZYcUv
         B+pOvd/TsILAg==
Date:   Thu, 15 Sep 2022 07:31:15 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     Lin Yujun <linyujun809@huawei.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        akpm@linux-foundation.org, wim@iguana.be,
        linux-rtc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] rtc: stmp3xxx: Add failure handling for
 stmp3xxx_wdt_register()
Message-ID: <YyLGsybCM5a5N1Mt@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Lin Yujun <linyujun809@huawei.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, akpm@linux-foundation.org,
        wim@iguana.be, linux-rtc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220915013304.213917-1-linyujun809@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="INGsqzS9vIYhwxhE"
Content-Disposition: inline
In-Reply-To: <20220915013304.213917-1-linyujun809@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--INGsqzS9vIYhwxhE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 15, 2022 at 09:33:04AM +0800, Lin Yujun wrote:
> Use platform_device_put() to free platform device before print
> error message when platform_device_add() fails to run. Add dev_err()
> to report error in case of alloc memory to wdt_pdev fail.

The second part of the commit message is now obsolete.


--INGsqzS9vIYhwxhE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmMixq4ACgkQFA3kzBSg
Kba06hAAoctutLkOr2jK9CYiGkFPE9BZufQe7ynk9RqKHGrJl8koHbPFix/eJqaj
7H7R8mleeK4NYpDq1G0YSRqyrYm9rsUrMhMI76cFCZzi8eoQhkEiDPdJY46Oqpc0
9yKUv4GVQP0wQl1GDPdag8sniYm4zzzfWN+eNYeclBoJ0PvAPaxq3RAppbgxGEkm
9C1w7xzs3z6cAZGxWS2d56uDYDiFsP+0Prs7O4uM9q1xPi3/83BA8HXKECLv9maJ
+7EI8jqEIVYrBZedcoj2+ZyG2x0DrBGMoHJ3VnjAAZqr3uUOsKWZvV8bl9S2xBv7
OYvoR6rWjfteKC+8H1mFFP5xoxpOnYXE7wcE3CmDRZgody6G4rZ9yzTc+KtuN0Hi
fskF8s4bvjT4H/k5ON8KLVVNoj3nWzwmDn25uZ84cl6dMlgTgaSX21ufIvYd5DvG
ZHQpHrgJo+PtZTOXg7hVQaF+VurZrigxyo/pxI32C8rmLD0TX79nSZNWfJm8y47f
LadpP/k77dFMoSFl4sSYpamfnJuBWAsiJBhpARsta6VRdlWubSj+DVUiy3BG1YvK
/aYMDRjkgc1yGKayHsdZgwkMzAhh2F25nSSj8AN3cpJVXcjG4rNnZ0MtNYHOTAJp
u227FUBpN67I/Oidhg3QwWZ3YqI3QXSG7b/bEqqsNKUU7gLqPfE=
=Z8sd
-----END PGP SIGNATURE-----

--INGsqzS9vIYhwxhE--
