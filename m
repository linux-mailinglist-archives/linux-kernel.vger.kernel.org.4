Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B72162DA82
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239744AbiKQMPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240068AbiKQMPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:15:40 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA006F375;
        Thu, 17 Nov 2022 04:15:39 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id s24so2416665ljs.11;
        Thu, 17 Nov 2022 04:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kKtlUJsoWwuJjn2VHo1qi4XSHSvJGEMBe3QKZ5NB7JU=;
        b=KunCPphvVvLwYsVVkKod7lezBxR7mK0L81iehXwwrQMtgiPRmMer82ixlmGKbAUR1Q
         Tu/Hqj7s9ji6czoAV3ceB9SK1wJGu3lA6+r3KW2P4s4FzdJYp+H/LNHmHTKHTdtqjtwU
         vgDIcgZfn/Ma4UlgaliNvLzhbBpXFD/VQs+A/RK6P/ihpi1UR8u25xMCykbmZj35b2Qf
         HqkeHfM1CsmG0Qf5yp1CodQCklhYOhtUuVoGk8idOab8tbuHDpdmKe/qBPvX2hv+0kE+
         zwUY0NZvLcN/h/TWMLRqlm2c2T6OYCpnpvIEaPgP6InwCdxJvcch/FXKnLCJRXl90uNf
         KzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKtlUJsoWwuJjn2VHo1qi4XSHSvJGEMBe3QKZ5NB7JU=;
        b=El0xkzKK5DLcsHGRIJhxIAS69VjCHE30ZbKxItJdaMLiBEQi/YtHZv2nDdFxduQJhd
         hzv0E3OopEZKoAPqb0SPyBrZYfkKX6klUlaZJZUr824+rTRnhXFmYt873VQ2N3dcGxu/
         f4NUKjDkoGhAxZNUNx+DqwJPxcW3PkdOcXRLL3ePUra2pu6pVw8+uyDnMq5w42sJQThi
         XbzknR7lfKK6ighH+6SMhGjReWxDiXx26u2FiWQkY5EL78abrjuO4J2XTASevAz7cc17
         IxVpOq89nC1MUE27HDfkoHaGHyYLpc+HlI6UqDYm6kbYMWRYB/nIEgYgCkBd5uH/bPtA
         lSFw==
X-Gm-Message-State: ANoB5pnamFN61hO+Ee99bV9UA/yPsEUSN4ar84DGPMkkLUxag0YFJ7wX
        GSSzqqyNU1ggZEAMOwwmzKKtXiY4fqI=
X-Google-Smtp-Source: AA0mqf4UCDUQaigclcgvYY1BIeuKdUrjoaago4v5D3TcDO0TTVIP7PmqyWK/SWWBu7nujQOsL1jXDg==
X-Received: by 2002:a05:651c:198d:b0:278:eef5:8d16 with SMTP id bx13-20020a05651c198d00b00278eef58d16mr866908ljb.220.1668687337634;
        Thu, 17 Nov 2022 04:15:37 -0800 (PST)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id j6-20020a2e8006000000b0026dd24dc4ecsm168361ljg.82.2022.11.17.04.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 04:15:36 -0800 (PST)
Date:   Thu, 17 Nov 2022 13:17:00 +0100
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2] HID: hid-cmedia: use device managed resources
Message-ID: <Y3YmPA/TqAFQ4xwn@gmail.com>
References: <20221117121304.5516-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sGgkfKs0LXXLLOUj"
Content-Disposition: inline
In-Reply-To: <20221117121304.5516-1-marcus.folkesson@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sGgkfKs0LXXLLOUj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 17, 2022 at 01:13:04PM +0100, Marcus Folkesson wrote:
> When we do not need to free() any memory in .remove, we can remove
> cmhid_remove as well.
> hid_device_remove() will call hid_hw_stop() as default .remove function
> if no function is specified.
>=20
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---

    v2:
    - return ret instead of 0 in probe.

>  drivers/hid/hid-cmedia.c | 27 +++++----------------------
>  1 file changed, 5 insertions(+), 22 deletions(-)
>=20

--sGgkfKs0LXXLLOUj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmN2JjgACgkQiIBOb1ld
UjKh0RAA3RH3WxbO24nxmCHtkOfwZciwymwpbzySUKGBRyVHrET+JfouDirx3oSd
lHI+1XYVT4JnwhdFm+SAQ9pjpOn4rNMVmqwoTJSLSQO1WLGsc3VTW8dsSieyyAkE
2JQU2RxUsqJziTjensq1Xpt4spy4c8QDuyOQEfQr2ES57ggPxcsxqwSPAQWv7DVu
lhHEJ+xSQ8kw+RAJW860rdvr8JUDtb6uWHL2H3ziQ0QFH+wfl+Mq1GCGp8zkq8F1
E8HjDBl753faG/Kmv2LNtKgVPV3Dg4boYsWDgJnx81w//ltiKqJhHXACGhq8Lwwy
XEQGPjh7jBbgsL1GEke0AyHaSu8kOYccYAfCCrD37fYBremNeVd7uiBiYkZmIV7q
LoaVX62FYekBynviLY7ujzQfKOgfTv2RfCg3HI+gfBZFYciJiwrGw+VtEArjIVE6
wJoEPQF3bVQik34EBjE3h0zVcmHXWhTNRy5Oo7VkH0F8N1SOlz1V25tGioitOZEZ
z6mAxEAMO8JxywMVpiz4G3BACZvoH7gU6vL3uuVGo/y4Qe+JFo3hnCuedul4mCbD
Leqkk3QbsY/5cRLbACJmJcbZ2/6lR/RLwZmiTCEEbGwnzrHviV3WF97paRN0l+wQ
YCNGB5yMt/Q/tt+u100jeOH+iiq05kMy/swErcuILaUJxpFuAfc=
=ues2
-----END PGP SIGNATURE-----

--sGgkfKs0LXXLLOUj--
