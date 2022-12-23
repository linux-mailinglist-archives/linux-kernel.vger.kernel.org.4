Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB7A654F37
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbiLWKep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbiLWKeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:34:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB692A513;
        Fri, 23 Dec 2022 02:34:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E23FCB81F51;
        Fri, 23 Dec 2022 10:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71693C433EF;
        Fri, 23 Dec 2022 10:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671791672;
        bh=pEi8Xz8eJjlzeyiiqC2lEqhANSejOYDD0mFpyX2uWuE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=eW2jtyLMcW3/uyA2m81/elhA84ITXUJule7OAiN127fzxnFeDPL0Fq46yzyM813kn
         ih9KB2sABJCG5hny9r8ntswKfpvPrlCTm348KMDCQRfGCxZH49ygd53GlKyTBGYn4C
         A6IoWRNEBJX/KtKL0aD6bju7wlTuoA1sF8JFcFU1ozhn3SxsgslkwqU6JfN5LkxIoJ
         RZubC+ZApPOsHTZF77HRVRf7rt5TDHVHo43Uda8zvlwHHmZ4Ik0KHXtZH788SvS7S/
         9B4e/1M2jwRk0Qd3pswBk5z/dQaik6BuVMC+EQLg2XH5Oihj08k/el83ECY8aVgczb
         MNeESw4sEqg1Q==
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
Subject: Re: [PATCH 2/2] dt-bindings: usb: rockchip,dwc3: Move RK3399 to its
 own schema
In-Reply-To: <CAL_JsqLo4qZRTOu7UR_AN_jHNgiFZp39dsXYwWnD_njyDQfmAA@mail.gmail.com>
References: <20221219191038.1973807-1-robh@kernel.org>
 <20221219191038.1973807-2-robh@kernel.org> <87bknya5lv.fsf@balbi.sh>
 <CAL_JsqLo4qZRTOu7UR_AN_jHNgiFZp39dsXYwWnD_njyDQfmAA@mail.gmail.com>
Date:   Fri, 23 Dec 2022 12:34:26 +0200
Message-ID: <875ye29znx.fsf@balbi.sh>
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

Rob Herring <robh@kernel.org> writes:

> On Tue, Dec 20, 2022 at 1:37 AM Felipe Balbi <balbi@kernel.org> wrote:
>>
>> Rob Herring <robh@kernel.org> writes:
>>
>> > The rockchip,dwc3.yaml schema defines a single DWC3 node, but the RK33=
99
>> > uses the discouraged parent wrapper node and child 'generic' DWC3 node.
>>
>> Why discouraged? Splitting those two separate devices (yes, they are
>> separate physical modules) has greatly simplified e.g. power management
>> and encapsulation of the core module.
>
> Sometimes they are separate and that's fine, but often it's just
> different clocks, resets, etc. and that's no different from every
> other block.

Right, then the argument is that all other blocks are not modelling the
HW as they should :)

> If there's wrapper registers or something clearly extra, then I agree
> a wrapper parent node makes sense.

There's always wrapper-specific registers. Some wrappers even add custom
functionality. IIRC Qcom added a HW-based URB "scheduler" or some sort.

> Otherwise, for cases like RK3399, I don't think it does, but we're
> stuck with it now.
>
> Also, we have this pattern pretty much nowhere else and DWC3 is not
> special.

No, it's not. But it could just be the first example of the driver
actually modelling the underlying HW.

In any case, I was just curious with your opinion that this model is
discouraged, as it's not stated anywhere in the kernel's documentation.

Happy holidays

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEEg3wK/NVnD14JZqsmho6y4DXKpEQFAmOlhDIRHGJhbGJpQGtl
cm5lbC5vcmcACgkQho6y4DXKpES1VA/+OxcarujRFwHa95+X7YWZNI3bmUDtKLPg
zOuwZkJQMoBBmV1QrVIkSmewZR2eZUmrYznXlswNWu3wt2UsCvGfFT3HenhSko17
ZdT8suhbRWZwDaQNm4uDeP9z+37gKn5NcwA6namgAVymsAb/voLQK/bkNth7LupJ
eY9Lh7D3xTfO1eZ23fBd9AQjQZGa6r7FKcH5tCwO4X+2OLWNY08hGTZVRfoJoIyZ
pJNt0rorl/a21j5JeGQwO0VST2/cQHmRDMzdTc4/3KFiy4Gx3Qq5/cp0Klv5qZ8y
vkKbCoZpxCgnUqc0DwxATeYVtQXnHnzoO0ahHgA7kM8Ap9DJWbbvZq+WupHXbmzK
P0eoRAS4V3OlG7GCjRFEU6TzrsVjl3Tgm+ILc8yiUXVlQcq40I1BXwZtzgY+qNVy
Lk4Z2ZLXDi8MKilK64bHW9dZaJq4k5ZjerXgFQYW2bvUJT1rk9EP+tisanKLelpS
Oggd3zZRk9PCg0cAvvN/4OOmBa/PtINXHX5Tb9zjVSGgbjqRDGJG+BfYpQ/ZTOF+
+qFx0ie5fLktEwcHGlqx/IZ0lFqOc6iSRDMzIJBnfVx0aanuuk/S+cAiTAg5TLYN
pMcfABi0dtDsanrSVlOGd2SOW1019+rPlN3jemigQ8dTawudC0/A93l65/4qyGiA
+R+1a/ubZhs=
=MZmx
-----END PGP SIGNATURE-----
--=-=-=--
