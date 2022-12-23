Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3585654F2F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbiLWKbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiLWKbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:31:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C7027DF1;
        Fri, 23 Dec 2022 02:31:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABB9F61DB3;
        Fri, 23 Dec 2022 10:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015C4C433EF;
        Fri, 23 Dec 2022 10:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671791490;
        bh=6wmYFAAcZgXeEqTN//fhHTM54kWAbw0UyCStoqODi6s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BEyR8WP6WX3GtZpTZwyvh6OGrEFdaVlUcmfPF3c/2LEX4kyhwln3qYDDOeVFlTGuw
         7DrYKRNNPzm2aA4AWpm9QiLKqrk75STh/zZjnVhHDcboCUL8fv1NWdcLfTUP/KyhI6
         QGJPalphACsy+K7uM6ZKjrNy3ZdPIEK29DPBm7VxwNl3RrElL3xW0W200UGni6gReT
         bvKOUaIvd04RL0CbsKQJzs78ub+efKUqAs6kAZL/OE+K/Zc/fKOJD60EM+0buIpBs0
         xk2dGqETA6m4gdoxm37WekG/7yw82X2mM6t9eb7hHOgOpkcbqRRpo1m/wxXR7dSOrG
         SISfWKOcCFjKA==
From:   Felipe Balbi <balbi@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-rockchip@lists.infradead.org,
        Johan Jonker <jbx6244@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: usb: snps,dwc3: Allow power-domains
 property
In-Reply-To: <CAL_JsqKgGWN93QJ=V34=X3hC2bgdcd3vwO0Mne-8z8HOfVDz-g@mail.gmail.com>
References: <20221219191038.1973807-1-robh@kernel.org>
 <87edsua5q4.fsf@balbi.sh>
 <CAL_JsqKgGWN93QJ=V34=X3hC2bgdcd3vwO0Mne-8z8HOfVDz-g@mail.gmail.com>
Date:   Fri, 23 Dec 2022 12:31:01 +0200
Message-ID: <878riy9ztm.fsf@balbi.sh>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Rob Herring <robh@kernel.org> writes:
>> > The Rockchip RK3399 DWC3 node has 'power-domain' property which isn't
>> > allowed by the schema:
>> >
>> > usb@fe900000: Unevaluated properties are not allowed ('power-domains' =
was unexpected)
>> >
>> > Allow DWC3 nodes to have a single power-domains entry. We could instead
>> > move the power-domains property to the parent wrapper node, but the
>> > could be an ABI break (Linux shouldn't care). Also, we don't want to
>> > encourage the pattern of wrapper nodes just to define resources such as
>> > clocks, resets, power-domains, etc. when not necessary.
>> >
>> > Signed-off-by: Rob Herring <robh@kernel.org>
>> > ---
>> >  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >
>> > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Do=
cumentation/devicetree/bindings/usb/snps,dwc3.yaml
>> > index 6d78048c4613..bcefd1c2410a 100644
>> > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> > @@ -91,6 +91,9 @@ properties:
>> >          - usb2-phy
>> >          - usb3-phy
>> >
>> > +  power-domains:
>> > +    maxItems: 1
>>
>> AFAICT this can be incorrect. Also, you could have Cc the dwc3
>> maintainer to get comments.
>
> When we have a user with more and know what each one is, then we can
> extend it. All the other users (upstream), put 'power-domains' in the

Won't that be an ABI break at that point? You'll change the maximum
number of power-domains.

> wrapper node. But this is what we need now for RK3399.
>
> I used get_maintainers.pl. If that's the wrong output, fix it please.

@Thinh, perhaps you should add dwc3 binding file to the list of
maintained files for you?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEEg3wK/NVnD14JZqsmho6y4DXKpEQFAmOlg2URHGJhbGJpQGtl
cm5lbC5vcmcACgkQho6y4DXKpERo4hAApZSXiZmGtrVhLB64SCqHD9+VJbt4amWz
ePO7l7j7gpou9fF4lDUnWBaoAE1xnpv/6Hr64fq5D540UXFW0pfwV+WFMSm86fjU
jlqErZlbMAb/0oj0E0YVBN0zA4Mi7VjWuO5Q99bEdcaBr6aBQAD2/mcODQhfWHbv
ZPmK5psZh/yoeaQBVExyJHPi3Bi/hCpZPhVkWnfUgBEUfGMeNigXloqg0jp8+tzD
ClgH1LBw8dW5Oa2/z63C9XLYGL0KB/gsVMMGyWUY2u2v/xqJ+sLyAPzYX1JIqJq3
MiyKJVSGplfOBa5GSGaKehTfPwAG8Du7CP3K3+9ydU/TWw3lg/fQ5UbYRBr/Q4SC
5S3micolyaEIWkW4XyrWgPSr/eq4A5vVZWRAqEEKvyBGKGxsZZqRkFoxzhYHd8FO
pIkBRI/kLtIhFDkXZ5e1HvmvsGgJJcRAZfawaw8RoY6sJgkQquxgKW3ob7Aeb6jK
seY4rLlxzDmdzlqrPyXFxVNrUNn/JW1KoY5sYfAQumBdM7PSR/xNN1NYAGJAI4on
UpKSIuTwKgMzM6i69wioIRK0QV1y3yvTdYB/umO+YT1sCKLaRX998O2Z33i6TCTv
LDwdv8JqXQFyIn8IecdLA9qsKsqApS67M4n+38SLyBkvttJtNGka1afH5PFJNt95
jLwjgQSUmDI=
=6qAf
-----END PGP SIGNATURE-----
--=-=-=--
