Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167536EBFD1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 15:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjDWNpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 09:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWNpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 09:45:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD74510EA;
        Sun, 23 Apr 2023 06:45:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CB2260F55;
        Sun, 23 Apr 2023 13:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289B1C433EF;
        Sun, 23 Apr 2023 13:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682257511;
        bh=gDJ5bumOU4KUPeLMyT7aBH/db/dxG+6sONKvH+a/LFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=chsdJR4nhxZbWWm5qSudwyib20L/x5E/0qXh7iuMpiMwB/RMINWYH2FdRNNE4N0xx
         BTLhXdtYMewaMIbLXEWdB90KWt69tGqi5u/w5Pw5FXrvjmoz9e3pMyiEI9rOpTcra4
         rmsJjNJC5g2W0Paqv7CBxHDCfur8wdCN3jcGlqiBQrElpP8vdRKhld3OftTBkwQrCE
         Q3rxaCg6qF4uFnTVHumYgIStFIMJAyaF9HkWY4NJaX/W4K4tl7OrthQGReKyPuAOU8
         mChONz4ZPTgjUJIT1VVu3N9CEctYpnau6FStK7ULBeF38pAyqE27GFDIoGChvNvw+I
         i9FajKVOQSl8A==
Date:   Sun, 23 Apr 2023 09:45:08 -0400
From:   William Breathitt Gray <wbg@kernel.org>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     william.gray@linaro.org, Rong Tao <rongtao@cestc.cn>,
        "open list:COUNTER SUBSYSTEM" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/counter: Makefile: Remove lingering 'include'
 when make clean
Message-ID: <ZEU2ZBexi1UxPULj@ishi>
References: <tencent_F85E314661100B0CE2845EB27E2E2F558C09@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3aSY/5R33N/gCQvK"
Content-Disposition: inline
In-Reply-To: <tencent_F85E314661100B0CE2845EB27E2E2F558C09@qq.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3aSY/5R33N/gCQvK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 22, 2023 at 10:27:38PM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
>=20
> 'make' create 'include' directory, we should remove it when 'make clean'.
>=20
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

Queued (with minor commit description cleanup) for the counter-next
branch of the Counter tree.

Thank you,

William Breathitt Gray

--3aSY/5R33N/gCQvK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZEU2ZAAKCRC1SFbKvhIj
K/pUAQCpnV/1BMOuhBHf7up1UP6xVMF7Z7W5HvCPB2bL+Vaf4gD/Uh84jkA+ImFw
BwNvX3aPejP3XjV8noeZx7uAVqXlMA8=
=aHCT
-----END PGP SIGNATURE-----

--3aSY/5R33N/gCQvK--
