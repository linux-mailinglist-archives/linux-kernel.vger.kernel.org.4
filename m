Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18876F1E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346491AbjD1SiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjD1SiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:38:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340781BEB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:37:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7E7D6428C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 18:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C67C433EF;
        Fri, 28 Apr 2023 18:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682707078;
        bh=KT5vios8l4FhVhmreslYblBZoac+mOoSTRH/woainQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HWOqKyvAqWrnh3ktvUVEAeIO+FIJzfFswpl5fAAew6OAZ25MvP9GuMYxpTMLeKK/P
         N492Kz6vBm58IGKH/VMQKb6A2xzWC+QSDo0DcSCbWjff8Epth/zB9RRr6AuOU5u2rq
         bsE0wvqGITFZro506gz22oWUjWdevSlV4M8T+7BeADK/I31NN6H9EJw3Pmg5CgttXj
         jD8TPzjlRc3A1wTJPXcoYwG+sh69+QRyZ987sCYxbCsqIZkWH/YlwrXyjZa9o36UFa
         PXjWOgFLR/c8AcBQPnaSmTSVrTqow3wHSBjhB6QSGcn4HpqEbZGzatAbWSTf1lHOC5
         0AEPZ/APDNzYA==
Date:   Fri, 28 Apr 2023 19:37:53 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yangyu Chen <cyy@cyyself.name>
Cc:     ajones@ventanamicro.com, aou@eecs.berkeley.edu, i@zenithal.me,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org, soha@lohu.info,
        twd2.me@gmail.com
Subject: Re: [PATCH v2 0/2] riscv: allow case-insensitive ISA string parsing
Message-ID: <20230428-flagship-algorithm-9f10e99a184f@spud>
References: <tencent_BC90DDC6093E3E41246D3EC73F5CAB189007@qq.com>
 <tencent_D5671CCB7149630242B61A1BF8B80581B409@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VdNPN6rkklY5NcK8"
Content-Disposition: inline
In-Reply-To: <tencent_D5671CCB7149630242B61A1BF8B80581B409@qq.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VdNPN6rkklY5NcK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 29, 2023 at 12:26:00AM +0800, Yangyu Chen wrote:
> Sorry for the cover letter being detached with patches. My mailing
> service provider will override the Message-IDs which caused this=20
> trouble. I will send the cover letter first to get the correct Message-ID
> before sending the rest of the patches the next time.

At least it doesn't overwrite the in-reply-to headers also, so the
patches are at least threaded.

> The cover letter is at https://lore.kernel.org/linux-riscv/tencent_8492B6=
8063042E768C758871A3171FBD2006@qq.com/
> The patches is at https://lore.kernel.org/linux-riscv/tencent_85F69423082=
E524C478844E31D5F8920A506@qq.com/
>=20

--VdNPN6rkklY5NcK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEwSgQAKCRB4tDGHoIJi
0nxmAP40dDtM5k+b7eEMGlkWF09qJmHYGklxsdAOB6KMP/xl1QEAjndyYJNKsHoI
mum0oxlHxq990mKY8gdGloNMwOuJyA4=
=NSep
-----END PGP SIGNATURE-----

--VdNPN6rkklY5NcK8--
