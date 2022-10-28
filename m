Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0E3610DEF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJ1J4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiJ1J4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:56:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AF189AE8;
        Fri, 28 Oct 2022 02:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1666950924; bh=4c2U5abA0ObwFBqTupA+Ypcyzv/fJnoG1A+yS2C369s=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=XP6xYbaEVNP7zR3NEUrkkmklBKQyu/j5bLRYKHJzCLajIhFpvDXbPNlfHV4f14hvl
         1ZTOcuyhKTKZCBa0sf9QytGv4J3rdxuF7/uwrEQDkQXnqxIJKi3qLnOwDcUIBo0ec0
         cq97gapP5b7HhNb4jG0CGcCOex/sXcQkiv5QJ0dzviFC8WDjDdul1mF8Ia18Rudhz/
         Q+em8BUrD+gzD/xGg/lfvxN2fbHzCMY/lgyOZ3ew4RfpWYS1XPPTRAAzuYX+Fno7ey
         PofOfIDHSHQ3AYpdo+9M9K1W7Z216eH3q1A5+lo62M3gYtgeeZPyTeEAXU4VlQsmQd
         XEJWlYHhQ/4Qg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkHQX-1pTiJp2nGL-00kcTi; Fri, 28
 Oct 2022 11:55:24 +0200
Date:   Fri, 28 Oct 2022 11:55:23 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     "Gole, Dhruva" <d-gole@ti.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-mem: Fix typo (of -> or)
Message-ID: <Y1unCzyjQ1ZzgU/S@probook>
References: <20221008151459.1421406-1-j.neuschaefer@gmx.net>
 <0f5235b8-9f35-6f7c-37b4-8094e476fbd4@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1NtTPhkobE9FrTi9"
Content-Disposition: inline
In-Reply-To: <0f5235b8-9f35-6f7c-37b4-8094e476fbd4@ti.com>
X-Provags-ID: V03:K1:+u0k713dk+xt7z9LwjDSM3AWpg/Gk69GC3CTAAZ+Uh8sB+rEmJa
 0iIv3wtN05Jl7lk0Z1Kt4PiT/jLbM/9b7HTAGkz902eVrcedAIaPP0QsrPg/1fRqMQk0LBN
 BdmzImuWnKg4vTM78RvXF713G4QTi9b8q6Datt+15NF0Qhx3Kh2XWLhCN3xrGD11ahA3fqQ
 Y/PpIivRMzH9ZR8rnb1Lg==
UI-OutboundReport: notjunk:1;M01:P0:N1lsjRnlqaQ=;fNkAC7kWKBjkcVw5mRwQPYFHwjb
 CdCuv11tVODhHBj6yyFZVt8R+OAd2aWQpWXFsp2OzbAe/DJeWAcXx1KIEiJlGyN50OrgFZLS9
 AZzSlpzYjBBIq7IcqIWAz63cOvl0VXtsVuLGyPiZs52Ny9+1Q/2KxGX5ialqEkOAMRWSp0oIk
 umu1TULRksbk63j8YTfZabJ88ijZSGh82AN86yeYNDqptmZGPfFrB2tHTerF1t9gcbXgYGsdn
 wwsLqyeYk5ELVFboqNJrMt1DYUV91+9adUmD+hatPsb4H2P817G3ygyiXx+XiBjmSCJqmgkw0
 3CntwNxc+XmSB9WfnAJCfLLZf6BvMRehbK8y5XpI9UALd9r/NDCULIr3x01N6zaBF7U/RjD8z
 tcZtVc4nEwUKD4zCyIzAHtWFMpbBdyScvSQxpZPfNM+2sCbuJtso4DO76rIK9L8edACVWGHuW
 j3F4jVD4Mv/DbHv79Svi+q6nxY+9EzXGnNUoU0frGgP+O17d/yfEoEKO+yOGeg3SHfUd73FwX
 CfTzClYgiVciFLWIdeH7f23VxjaoIgkcylMOUuMZKEG35tL8rYi5JhCRmO9gPZGJ3ltWnyfV5
 smTAJXzEG1bBhp009TGy23bBbglPlWweLcaxKDAAUKkcAFaP3AHAjzHPd1NzLy8futlDePRW+
 Erak7/62WVTn46LEkWctGoLVQt+JUJee272BLn6RUXg8r9Y02iklvUTTb7cUAPs9UxjCT+fhe
 7oqpBbIOCA2QH4un8KcnLtONSe106JK9DrgPv3cWarTVfqovNDn8B52iMYmo2tPAr5qg26hej
 5GlIBuIL7ZMRHUoBOkbI71xsyqE46JS5mHJsrAU6/DVYJCENUdE8NcuJk8qkaRkh5hiAmfeAB
 kuCf2QlRnAU43GgVDL8eo2WlJQJr7+u4uHL4mf+5FE0NglID7RkVvq0mtvJ8OKKItDwOb3l9N
 Pk23LCt1HkZswC9Qj6INvW7cs+k=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1NtTPhkobE9FrTi9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2022 at 12:00:23PM +0530, Gole, Dhruva wrote:
> Hi Jonathan,
>=20
> On 10/8/2022 8:44 PM, Jonathan Neusch=C3=A4fer wrote:
> > In this instance, "or" makes more sense than "of", so I guess that "or"
> > was intended and "of" was a typo.
>=20
> Using "I guess" is generally discouraged in commit messages. Please read =
up
> the documentation

It is truthful though: I did not write the original comment, and my
change is based on my interpretation of the comment.

> on submitting patches:
>=20
> > Describe your changes in imperative mood, e.g. =E2=80=9Cmake xyzzy do f=
rotz=E2=80=9D
> instead of =E2=80=9C[This patch] makes xyzzy do frotz=E2=80=9D or =E2=80=
=9C[I] changed xyzzy to do
> frotz=E2=80=9D, as if you are giving orders to the codebase to change its=
 behaviour.

The imperative-mood description is already in the commit title
(or subject line). I am not making a functional change to the code, so
"fix a typo" is really all that is to be said in imperative mood, the
rest is an explanation of why I think this makes sense.

>=20
> link: https://www.kernel.org/doc/html/latest/process/submitting-patches.h=
tml#describe-your-changes


Best regards,
Jonathan

--1NtTPhkobE9FrTi9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmNbpuAACgkQCDBEmo7z
X9sr4g//VvsB4DL6cxOkmmeWBDqoGQantquJSx2os82Mrwqh1d3WAuc/fXeODrTU
4pMFCbrbv/eC1sKy0LiYMcBFCy5n6dUcxHMVFl+QNlc0HZxOLVYVsD3aUWGkEdVq
5RnfTmXvK/CIiK+OahaFpg7x2g7guNWT/7Tc4mwDPuEh78QO8QAB9Jc1HD9u1HbT
71mqGBRSAux7/0WD/D0qIE7VDxKGRt7nempUAcC/ys+6iSkR/csJfBhSilpJFBI+
GBumW2Lt4UHYk48E0mZeQCycGYarQ3E71/Slm2bdWfLaaUEgcQ6OX1mtpWxqamzI
SIGju+H+sxLagjkDM7nr7WMNoAUc1GqXKqryfTLOUZSj1BkVCrjLUBFxRwDolZ7A
kD+0VCuTtqACFhn7CpwB1lK7RWG1Eu4zX+eEb4uSMIq6ZKruIf+yRbjwP3B2E3As
SPXAxQb1wuV81Itg4jAfxrUw2KLayeIJdYG/aH5vO8muXAJX0ap+ti6obKqYkeZu
cASE8C1stw5spziwKwYeHnJO4HhmVTfUsGBYpRAdC7zu3OtZNeIGuZOSzYHb74Iy
4dmwgwQCZGyBNbX2HBkbKg3nUxxw9yAAgB+zvYvjs+P4B1xg7HI9Qu87p8PeCgLF
N0TicmHo6KdHj8l/L5+HzTa0BIJRMNTXX9U+R31fjOdhsSiYqAo=
=q8+s
-----END PGP SIGNATURE-----

--1NtTPhkobE9FrTi9--
