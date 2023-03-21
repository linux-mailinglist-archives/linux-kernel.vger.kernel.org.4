Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CC66C2988
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCUFBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjCUFBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:01:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5661E22DC5;
        Mon, 20 Mar 2023 22:00:53 -0700 (PDT)
Received: from mercury (dyndsl-091-248-215-171.ewe-ip-backbone.de [91.248.215.171])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CCEC9660304E;
        Tue, 21 Mar 2023 05:00:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679374850;
        bh=BnvyoteHKI9wY48ZjZ0iqWIQKPL57OZHpv/A2dQoasg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QyPhBokC0aPOnFnEZN3nuB9BOQziiQ4D6TZ016KmwguKWy5u+/AZKmnYQYoK91pKy
         Lvb9VZwmxQVGO+WHI6xT7P89g7uhGuF5YIR0xwacZ7XaIztXwVinByXdsa4Hrod8Pr
         6vciMxJln75EQt1feWGmN7o0C/yLRCbDZQkY/IKMyqEryMcYi9IjzeIQhVbayYC4h9
         mdN/RlP8RiWI+fEXeG1xgHD8Pv4dBA9goRrqCIoQsX1LMlCdAhXwhuTzSPCyzTnGLb
         KzWIL512wG9aYCrBK/QMdys6DQlBE/3UlL0sdZgD/0zIsILHr3G4VOJgn8oOQgRL4U
         LQVXHior7eheg==
Received: by mercury (Postfix, from userid 1000)
        id 3E2EC1060FAB; Tue, 21 Mar 2023 06:00:48 +0100 (CET)
Date:   Tue, 21 Mar 2023 06:00:48 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Frank Wang <frank.wang@rock-chips.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, heiko@sntech.de,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com
Subject: Re: [PATCH v2 3/3] usb: typec: tcpm: add get max power support
Message-ID: <20230321050048.3p7xtyikf2lkqwrg@mercury.elektranox.org>
References: <20230320100711.3708-1-frank.wang@rock-chips.com>
 <20230320100711.3708-4-frank.wang@rock-chips.com>
 <20230320203139.quld3gmoo6esu56i@mercury.elektranox.org>
 <19b39d82-8510-2717-cf3b-71cb955373d0@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w2wopulsblcnnvo7"
Content-Disposition: inline
In-Reply-To: <19b39d82-8510-2717-cf3b-71cb955373d0@rock-chips.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w2wopulsblcnnvo7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 21, 2023 at 09:32:53AM +0800, Frank Wang wrote:
> On 2023/3/21 4:31, Sebastian Reichel wrote:
> > On Mon, Mar 20, 2023 at 06:07:11PM +0800, Frank Wang wrote:
> > > Traverse fixed pdos to calculate the maximum power that the charger
> > > can provide, and it can be get by POWER_SUPPLY_PROP_INPUT_POWER_LIMIT
> > > property.
> > >=20
> > > Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> > > ---
> > >   drivers/usb/typec/tcpm/tcpm.c | 24 ++++++++++++++++++++++++
> > >   1 file changed, 24 insertions(+)
> > >=20
> > > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/t=
cpm.c
> > > index 13830b5e2d09f..d6ad3cdf9e4af 100644
> > > --- a/drivers/usb/typec/tcpm/tcpm.c
> > > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > > @@ -6320,6 +6320,27 @@ static int tcpm_psy_get_current_now(struct tcp=
m_port *port,
> > >   	return 0;
> > >   }
> > > +static int tcpm_psy_get_input_power_limit(struct tcpm_port *port,
> > > +					  union power_supply_propval *val)
> > > +{
> > > +	unsigned int src_mv, src_ma, max_src_mw =3D 0;
> > > +	unsigned int i, tmp;
> > > +
> > > +	for (i =3D 0; i < port->nr_source_caps; i++) {
> > > +		u32 pdo =3D port->source_caps[i];
> > > +
> > > +		if (pdo_type(pdo) =3D=3D PDO_TYPE_FIXED) {
> > > +			src_mv =3D pdo_fixed_voltage(pdo);
> > > +			src_ma =3D pdo_max_current(pdo);
> > > +			tmp =3D src_mv * src_ma / 1000;
> > > +			max_src_mw =3D tmp > max_src_mw ? tmp : max_src_mw;
> > > +		}
> > > +	}
> > > +
> > > +	val->intval =3D max_src_mw;
> > The power-supply subsystem expects Microwatts and not Milliwatts.
>=20
> Yes, but I see the 'power_supply_propval' member 'intval' is an integer
> type, I worry about it may be overflowed that uses Microwatts.

Data being encoded in Microwatts is part of the ABI. The data
you are supplying will be interpreted in =B5W. If you submit your
data in mW it is basically always wrong even without an overflow.

Now regarding the overflow: A signed int can store 2^31 bit, so
2,147,483,648 =B5W =3D 2147 W. Looking at your code you effectively
calculate Microwatts in an unsigned int and then divide by 1000.
Since the intermediate value (before dividing by 1000) needs to be
stored you gain only one bit. That raises the question: Why do you
expect data to be between 2147 W and 4294 W when the latest released
USB PD spec allows 5A@48V =3D 240W?

-- Sebastian

--w2wopulsblcnnvo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQZOfsACgkQ2O7X88g7
+pojhBAAhgzwQSDfENO6eGtWR2yQMwgG0jOd4CTCv9Cp3UuxB60XUdp9lDcRosz3
T5InXJ/FMWUhEiHoo/pq/95CsrKW7ybUylCTbhWaiWmipBsKURaJGiJWUopdYN01
M2zhd78L0nGghRkF/vJcBxl4TPoQtp2YUr+oEmKGcar4+cNaVAYOuzChOKx61H+/
J7U06yL3GcrGu00upnbY49prr5lJIWHV7zinHFpx79y9joYYh9Nh6766y2EQCo7g
iMj5LxYyxLtPMJLTl0eS1U0hQb3l9AvJLUoDaAU92x9+CEbpTczk2XBrpBJfHJQc
/x0PtQ+xlaxdABsN62RdwPiUCQOs1FqPMbLNr2oqwbmiY4caj8uogJl0nnhMYz34
HMUtHgZL/O+Hlrd/bVliGabySpgUQjZKfvk03E7nNRyNygscUSpNGSPMCqhFLfkW
FY8quL01XZIEyCfgHoxKAv6geKAtmZ5TfJdGw68V/8z3FJJHZ3/Gun6sqewc+RCe
J0lM3M2htBeV8lsMua+PhRDnHDr/6FMxAM4eMmRqVXgIsfFkwjnwQJyjQUEpD8na
wJCEufjleDMfkBLwet9C4SclnGgGOTWw+dsF6CYfnY9kZM7r/zed1znyWrsXm58i
fTqzppOzwPzLtoUXO9Si4fCxZeoZrdav0JqoKyI026D9y+v6e0k=
=do4N
-----END PGP SIGNATURE-----

--w2wopulsblcnnvo7--
