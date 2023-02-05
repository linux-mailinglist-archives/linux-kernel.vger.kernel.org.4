Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B43A68B053
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 15:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjBEOmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 09:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBEOmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 09:42:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F401C31B;
        Sun,  5 Feb 2023 06:42:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C084B80B22;
        Sun,  5 Feb 2023 14:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA1DC433EF;
        Sun,  5 Feb 2023 14:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675608161;
        bh=2uiZi1cqU77kkLB21Yd0QlrFl7mrVelei0IjV/LyO34=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rn8lQ8XCYMmsL1/pCbCGnAgDq1rxq628txxHan4sSMHw8TwzuSQR6J0M/Coac10lT
         bIpCwMLCcDAfX773ce5nLtG26rmt54m5QGFHTTAQZ4x649/q9csK9AAjvYp73HpbPh
         EzaD0q5lOEGR6UWvI6JOSS7Z6Zy/4y0dMco6YP06Up/VgUEkgFYNi0MSGQ1V+/pIN5
         tZbGOmJ4wR1LLYoKDcrqALrQlnCl34XVL5D9M8CytqoaivL8v65WvPAf3a2SAFdZlA
         7ZmtWZKqOsmCtWlBVTEK4GxhW70ySBJAdb2VP0eLM5WJkqzxD7gwWy6te6OnKmwHNC
         Ym3MuPsgIKJig==
Date:   Sun, 5 Feb 2023 14:56:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-iio@vger.kernel.org, Tomasz Duszynski <tduszyns@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: sps030: Reformat comment in a more
 readable way
Message-ID: <20230205145642.3f2c3d1d@jic23-huawei>
In-Reply-To: <20230129132020.1352368-1-j.neuschaefer@gmx.net>
References: <20230129132020.1352368-1-j.neuschaefer@gmx.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jan 2023 14:20:20 +0100
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:

> It's easier to see the (lack of) difference between the lines when they
> are visually aligned.
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/sps30_i2c.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/chemical/sps30_i2c.c b/drivers/iio/chemical/sps3=
0_i2c.c
> index 2aed483a2fdec..0cb5d9b65d625 100644
> --- a/drivers/iio/chemical/sps30_i2c.c
> +++ b/drivers/iio/chemical/sps30_i2c.c
> @@ -68,10 +68,10 @@ static int sps30_i2c_command(struct sps30_state *stat=
e, u16 cmd, void *arg, size
>  	/*
>  	 * Internally sensor stores measurements in a following manner:
>  	 *
> -	 * PM1: upper two bytes, crc8, lower two bytes, crc8
> +	 * PM1:   upper two bytes, crc8, lower two bytes, crc8
>  	 * PM2P5: upper two bytes, crc8, lower two bytes, crc8
> -	 * PM4: upper two bytes, crc8, lower two bytes, crc8
> -	 * PM10: upper two bytes, crc8, lower two bytes, crc8
> +	 * PM4:   upper two bytes, crc8, lower two bytes, crc8
> +	 * PM10:  upper two bytes, crc8, lower two bytes, crc8
>  	 *
>  	 * What follows next are number concentration measurements and
>  	 * typical particle size measurement which we omit.
> --
> 2.39.0
>=20

