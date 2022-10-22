Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C895608BD0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 12:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiJVKnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 06:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJVKmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 06:42:33 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D674D49B62;
        Sat, 22 Oct 2022 02:59:46 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 983D31C09E5; Sat, 22 Oct 2022 11:58:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1666432711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KpPCRvQJgXDGyb4glxKUpw4uaIOMm328LUpioHS06b4=;
        b=P6Ku5VcPksDLiXOABOexev1hqvQKRo2VO92jzkU7/2sEBonRVRo7LsVzokTpj/c0vrc5Ze
        appbndtcn4NuAhPYsibq2/r/tUcLTSBnB8kU+BoL0yRgiR2d2+6NfTAc4gWJKt8BCto8Yr
        Ru7UYLfzPlKgsHBuz2sywz2q8vBiPBk=
Date:   Sat, 22 Oct 2022 11:58:31 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: leds: Add 'cpuX' to 'linux,default-trigger'
Message-ID: <20221022095831.GC10427@duo.ucw.cz>
References: <20221021205428.304422-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline
In-Reply-To: <20221021205428.304422-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2022-10-21 15:54:28, Rob Herring wrote:
> Add 'cpu' and 'cpuN' to possible values for 'linux,default-trigger'.
> There's 45 cases of them in upstream dts files.

Thanks, applied.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY1O+xwAKCRAw5/Bqldv6
8mvlAJ0eDhIdUncPO7XaO2IwkqDMs6fcCQCfVKnaVUblsT9moEDEbKkPF1uCxXs=
=NDwL
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--
