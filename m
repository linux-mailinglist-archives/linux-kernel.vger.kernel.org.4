Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDC75B412D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiIIVAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiIIVAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:00:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6036D9E0;
        Fri,  9 Sep 2022 14:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662757221;
        bh=JLntwPoctWAoCyoxRVHbtaxMdOR9afywA5kpPqKGx+Q=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ShV9lm/So/ywYigMcuszxGuy/M0zsc2P5Hvbxj13Zj9yBjxFyLCzM45Z70K3EEzMf
         SGg2PdySVxO+YnZztCItoz7c8KrgNQqNUEmGL2Q3IDJLhZ8fUDMnmZA47SObYOxpih
         TiXrGduobC0deVBp2KjK5Wk59moXvUeOngR6YaMQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from probook ([87.78.200.132]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6m4-1pDTqL1i4C-00lR5z; Fri, 09
 Sep 2022 23:00:21 +0200
Date:   Fri, 9 Sep 2022 23:00:19 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] pinctrl: wpcm450: Correct the fwnode_irq_get()
 return value check
Message-ID: <YxupY5MGWddiY2mq@probook>
References: <20220905191408.73794-1-andriy.shevchenko@linux.intel.com>
 <YxkHaBKtiO9zVuKM@probook>
 <Yxm9fB/5IJS3MXGu@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T4S0blP9/51qK21U"
Content-Disposition: inline
In-Reply-To: <Yxm9fB/5IJS3MXGu@smile.fi.intel.com>
X-Provags-ID: V03:K1:r0wpIjMElmEi0hqV8F0RnUamSKCv8L6GjZxaIVBmve/tIxeyEb6
 f3uFy7LBihUBoL1b59/bEm5igYVc+pPV3r746gI4FXNZQPBfYiGC/1JVM2t0DGqiyHPlcvF
 tlqWEDCuEqV+AuOWwBUClSr4xvChsWpcjWWcCGBjS2F8XNaN/Uh68Es1eQBw2fNsJ4ouUpx
 2iOfzmpJXFdcsop/93O8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2C/pU3Vhr7g=:GXVm17NUUeX89H2jAKMOz1
 MPz7d6NoHtQq9O3tZOpcuU1iu11+Cze9kMjItmcgR+l6rBKds/7BcoO9GHPQs6Mw27dpevTwk
 GeeSLVndPsjc8Y4BxwkCG9R3a6zJKMoxs4DEa6lcdZ/CD7apYMFU6J0FfFc0dMPcjyX2tF7Ym
 XNNuGOxvg+6VTjiHlVm0bUGsKIVUUg/s6hwyBbpHvi2RwSzYkPOI/rX8hDRFBDELz3VAQXTeU
 M2E9Ukp+mpagDUDSuklMxy0fP1N8zTj43BfymGZfOrXZEr/FDmbvT9kCc5Oaisg4pUKx1x1h1
 exQ89+1EWNdBtRh1g/r9O8W1cQaazy+GIG1RUsC3IBppxBLMGQH07fxlFCpsKXvyA73eRtmKk
 1Yo1MCCSiLB1FqQmOKFH532rlwZnLGAmhhgrfx5xuF3IwekBur8fWy9ewwLM2Qzfz9nZeHIPa
 KsSiP8L/5/UFjjkFUNDFsUKUcMqZr858JJ975vSdYwe3DO49l4mOdu0ZS/5Cu8KJ1+deFGP9v
 ItqHJ+Q7Y0OT8VYP2S/km0IO7CVGb2qdjEEy7mT4AUhF2BB+s0Zq6JcmZq8xjv7piy8KDx7c8
 T6A7y6W8yAkZU143YXBrmCCwwKe9n/OB18a/9l+DtC+SWo6HUXNeiECI9XkS+8kfNdWMXGUbQ
 Q+RjOYkkItn/P6vGIJOODGKVb0EGIz/99ukGwvn9Y0vLWBTjPnhrMy5Ddorrjy17ufpBmOVR6
 5gmd+I9y2bpYSz09gAgdJRZIaBe45HBbgRNA65TvdscWGqMJWVYBm1uKvmQ+cyMVIXVohI3WI
 vJOj/Bi9KQFDuDpxVw11sGTXFMRWZKO6Gl9UzKbokcTR9LfFtihNt3nIQqOCRvWDI9/yP0Ogy
 0pMNcnUK2PDSvLpkflZJeFjFQjebRoQreNgxIyN29Cms/jMIODpC4XfUeIqgBC5Cck7EYguc2
 p7xBVjMFEPkYZ0kypK7EvpM9bTS899CRlamVWoBSdegOZOgcGKXzXrFyAjDO8GgzwyR/Z7Cp0
 kDrOHN0S+zlT+s76njoxjl5YC8+piw2UX/KfPzd/w6oZlkR8wTG+Y8/lnuFaL4jwqcG3tk/0n
 RieGUX0h9Ktc8lKl/5xjlB+seWq7JVbOJMhSXanSpzt4r39s0axY6ZDxznu1yXBqBuYAOuY4Z
 clMf9v7fon79Wnc8C9N7OUXD4z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T4S0blP9/51qK21U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,


On Thu, Sep 08, 2022 at 01:01:32PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 07, 2022 at 11:04:40PM +0200, Jonathan Neusch=C3=A4fer wrote:
> > On Mon, Sep 05, 2022 at 10:14:08PM +0300, Andy Shevchenko wrote:
> > > fwnode_irq_get() may return all possible signed values, such as Linux
> > > error code. Fix the code to handle this properly.
> >=20
> > It would be good to note explicitly here what a return value of zero
> > means, i.e., as the documentation of of_irq_get says, "IRQ mapping
> > failure", and why it should result in skipping this IRQ.
>=20
> Not that I'm fun of duplicating documentation in the commit message,
> but it won't take much in this case.

My problem with the description is that handling "all possible signed
values" is fairly meaningless: The code arguably did that already, it
did *something* for every possible value. The significant change of
your patch is that the value zero is handled differently.

IOW, what I miss is something along the lines of: "fwnode_irq_get can
return zero to indicate some errors. Handle this case like other errors."

> ...
>=20
> > >  		for (i =3D 0; i < WPCM450_NUM_GPIO_IRQS; i++) {
> > > -			int irq =3D fwnode_irq_get(child, i);
> > > +			int irq;
> > > =20
> > > +			irq =3D fwnode_irq_get(child, i);
>=20
> > (Unneccesary churn, but I'll allow it)
>=20
> The point here is to see that we actually check something that we just got
> from somewhere else. It's slightly better for reading and maintaining the
> code as I explained in [1].
>=20
> And there is a difference to the cases like
>=20
> static int foo(struct platform_device *pdev, ...)
> {
> 	struct device *dev =3D &pdev->dev;
> 	...
> }
>=20
> when we know ahead that if pdev is NULL, something is _so_ wrong that
> it's not even our issue.
>=20
> [1]: https://lore.kernel.org/lkml/CAHp75Vda5KX5pVrNeueQEODoEy405eTb9SYJtt=
s-Lm9jMNocHQ@mail.gmail.com/

Ok, fair enough.


>=20
> > >  			if (irq < 0)
> > >  				break;
> > > +			if (!irq)
> > > +				continue;
> >=20
> > Since irq =3D=3D 0 seems to be an error condition, the following seems =
fine
> > to me, and simpler:
> >=20
> > -			if (irq < 0)
> > +			if (irq <=3D 0)
> >  				break;
>=20
> Not sure it's the same by two reasons:
>  1) break !=3D continue;

Right, hence why I asked for reasoning why zero should be handled
the way you propose to handle it.

>  2) we might need to convert 0 to error if we ever go to report this

Good point.

>=20
> So, to me mapping error shouldn't be fatal to continue, but I would
> like to hear your interpretation since you know this case much better
> than me.

However: In wpcm450_gpio_register, there is currently no reporting for
mapping errors in this loop.

I'm fine with either break or continue.


Thanks,
Jonathan

--T4S0blP9/51qK21U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmMbqUMACgkQCDBEmo7z
X9vPTg//W68gSOfDJBQZ2/UeuyNZ5V9lnHuvyi6tBr+qM77qU9qZoqss1lcSbVq9
vhtvGEPdFIvPKb61wU0qYM70Kr3TXHpsFHK9lUo25WZybUq32OJMFZYY0go0IQ2X
FZ8VpUlb7lMOy0jwPu6ARQhyuVN1I5Cr6EnzWs8bhxAIJANqAMeqD85hsXmel3O8
4IM+oa+26i5otyGZLeLQPAJO1ABWAExemevWsmfsghTcbSt1fTc34dbnyCCXrAE7
d09YYaIu9SVHt584aIDMMdGwpXDxF1a4ObaRXvv6atMC07Ezs4zU12hATe+GVGx7
0MCD+bh4RxjSCrAAKRDItN1nJqMFhZTTB0ugmneDAKzORoiV3iDCxCsABxsH1ds4
u+yI+JAulbWdHsUOXfuns/qQqaTDPbLYdXE3asunOIRNlvTw+DwzuyJ5sIJfBclJ
6FuIyv+DjjcEt9YRlKtZzkgMxGw0Z13ZvlVlZb9RS9A176xFO04J1m22Vy2Kj+TF
5UouBkVh0OU9zkLHa+KRmcT88uvVgzK6YqvATSFBvcYGSV2r1Y3v2HlRWCrNxygy
vqsgWN/d9dqeVLyj5vVUz3ksveKlFEJ8mhPAwHGxSiQUyOLQ/s6YS88GiMioBlFG
hRoetTp8LXl9SbQyqmuuVzJsaFocIQ271MtXjOIWJou5+k8YN+o=
=HFeK
-----END PGP SIGNATURE-----

--T4S0blP9/51qK21U--
