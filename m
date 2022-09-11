Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2445B4FD2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 17:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiIKP4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 11:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiIKP4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 11:56:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDC427CC3;
        Sun, 11 Sep 2022 08:56:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47909B802BD;
        Sun, 11 Sep 2022 15:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FD7C433D6;
        Sun, 11 Sep 2022 15:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662911806;
        bh=2nq41yNdbUw5fMOHMV5IErZ0s6o+uE0fA0RnEPg13yo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E2kGkBNXF4iK+Cg+rBMBDa0o54CQGGS2ZvXtJX4LrDrKpyQo6Y65vz4MTHhwewQp3
         +ge9lgSlFY5IHlD3bkrub3sIR8BdqodGu/u7yKH4u/lbbY96XF+GO5SWoHHbtXT+BK
         QN6iB7MX0xd4jf2aA5NXCVOkxVInoY6n6Ooz1DjgOBD3KXvZ3LVr7pRS38zfTt873R
         5P9QopTxzGcWCOh/WizFDoFnmFva3K92oGnMjXSOF5Ur/0k9lPITPN4yQfIEt6f9a0
         18bUOsJP7L3XOnyHGeEuHKo6XlL2OHnb5/o9bBYgb9rBBOaqlWQykmzhImtQUb8e//
         8d7ISPz1X09pg==
Date:   Sun, 11 Sep 2022 11:56:43 -0400
From:   William Breathitt Gray <wbg@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Yanteng Si <siyanteng@loongson.cn>
Subject: Re: [PATCH] counter: Realign counter_comp comment block to 80
 characters
Message-ID: <Yx4FOxWw9fUfXAJw@ishi>
References: <20220902120839.4260-1-william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6CbbHGKRoNCATRN5"
Content-Disposition: inline
In-Reply-To: <20220902120839.4260-1-william.gray@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6CbbHGKRoNCATRN5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 02, 2022 at 08:08:39AM -0400, William Breathitt Gray wrote:
> The member documentation comment lines for struct counter_comp extend
> past the 80-characters column boundary due to extra identation at the
> start of each section. This patch realigns the comment block within the
> 80-characters boundary by removing these superfluous indents.
>=20
> Cc: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

Applied to counter-current.

William Breathitt Gray

--6CbbHGKRoNCATRN5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYx4FOwAKCRC1SFbKvhIj
K5cdAQD2/N7Bev98Y2mj3CfXDHnIJDZqYJoBeTr0ozF72h0jzAD/XlB1OLvbxQom
CtiIOdXIJnXknBUV/d+1tx2yvPRq+QE=
=GStq
-----END PGP SIGNATURE-----

--6CbbHGKRoNCATRN5--
