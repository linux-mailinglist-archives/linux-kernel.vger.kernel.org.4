Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3573272CAEF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjFLQDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFLQDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:03:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C9CBB;
        Mon, 12 Jun 2023 09:03:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DE0561920;
        Mon, 12 Jun 2023 16:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50136C433EF;
        Mon, 12 Jun 2023 16:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686585792;
        bh=DVoozoXwr1+By1EY6gaWGvC8bmLqsVOluvH8fNoDeKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LDGk2nOmyZzVqZ9gQ04NkGPR0QJjU//3S4bP2TgZz6txbPuwaiRVKXXPw4upmGYFW
         0YdjjFx5WzjcDS1lypOsoqV91/fKUethof1Hp6zieJUxAQCt0jzqkus6lo0zMaWMA0
         O0B9XH7UConfXGEpvMS6yW5f4Kt62ryu308G9aU7VOj+435CCWaj/IMVnCWgw47zlI
         1VMT+S+fbYxlWkHHiXx/B1ht5oneBecK3hizmrCkz90a6GV55qLLKbIl/SUUdkvSy3
         r5bXq4peMwUOpHciaTFAizz6sPMABNPlJfBcscqVI5yXuBt14A3NTh8H+4Sz9HkYsR
         x3RtN9klrrZsA==
Date:   Mon, 12 Jun 2023 18:03:09 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, hsinyi@google.com,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        yangcong5@huaqin.corp-partner.google.com,
        linux-arm-msm@vger.kernel.org,
        Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH v2 00/10] drm/panel and i2c-hid: Allow panels and
 touchscreens to power sequence together
Message-ID: <z7wi4z4lxpkhvooqhihlkpubyvueb37gvrpmwk6v7xwj2lm6jn@b7rwyr5ic5x5>
References: <20230607215224.2067679-1-dianders@chromium.org>
 <jehxiy3z4aieop5qgzmlon4u76n7gvt3kc6knxhb5yqkiz3rsp@mx27m75sx43r>
 <CAD=FV=Wr7Xatw1LsofiZ5Xx7WBvAuMMdq4D5Po1yJUC1VdtZdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wihzk64u23zlxjhl"
Content-Disposition: inline
In-Reply-To: <CAD=FV=Wr7Xatw1LsofiZ5Xx7WBvAuMMdq4D5Po1yJUC1VdtZdg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wihzk64u23zlxjhl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Doug,

On Thu, Jun 08, 2023 at 07:38:58AM -0700, Doug Anderson wrote:
> On Thu, Jun 8, 2023 at 12:17=E2=80=AFAM Maxime Ripard <mripard@kernel.org=
> wrote:
> >
> > Hi Douglas,
> >
> > On Wed, Jun 07, 2023 at 02:49:22PM -0700, Douglas Anderson wrote:
> > >
> > > The big motivation for this patch series is mostly described in the p=
atch
> > > ("drm/panel: Add a way for other devices to follow panel state"), but=
 to
> > > quickly summarize here: for touchscreens that are connected to a pane=
l we
> > > need the ability to power sequence the two device together. This is n=
ot a
> > > new need, but so far we've managed to get by through a combination of
> > > inefficiency, added costs, or perhaps just a little bit of brokenness.
> > > It's time to do better. This patch series allows us to do better.
> > >
> > > Assuming that people think this patch series looks OK, we'll have to
> > > figure out the right way to land it. The panel patches and i2c-hid
> > > patches will go through very different trees and so either we'll need
> > > an Ack from one side or the other or someone to create a tag for the
> > > other tree to pull in. This will _probably_ require the true drm-misc
> > > maintainers to get involved, not a lowly committer. ;-)
> > >
> > > Version 2 of this patch series doesn't change too much. At a high lev=
el:
> > > * I added all the forgotten "static" to functions.
> > > * I've hopefully made the bindings better.
> > > * I've integrated into fw_devlink.
> > > * I cleaned up a few descriptions / comments.
> > >
> > > This still needs someone to say that the idea looks OK or to suggest
> > > an alternative that solves the problems. ;-)
> >
> > Thanks for working on this.
> >
> > I haven't seen in any of your commit messages how the panels were
> > actually "packaged" together?
> >
> > Do a panel model typically come together with the i2c-hid support, or is
> > it added at manufacture time?
> >
> > If it's the latter, it's indeed a fairly loose connection and we need
> > your work.
> >
> > If it's the former though and we don't expect a given panel reference to
> > always (or never) come with a touchscreen attached,
>=20
> Thanks for your reply. Let me see what I can do to bring clarity.
>=20
> In at least some of the cases, I believe that the panel and the
> touchscreen _are_ logically distinct components, even if they've been
> glued together at some stage in manufacturing. Even on one of the
> "poster child" boards that I talk about in patch #3, the early
> versions of "homestar", I believe this to be the case. However, even
> if the panel and touchscreen are separate components then they still
> could be connected to the main board in a way that they share power
> and/or reset signals. In my experience, in every case where they do
> the EEs expect that the panel is power sequenced first and then the
> touchscreen is power sequenced second. The EEs look at the power
> sequencing requirements of the panel and touchscreen, see that there
> is a valid power sequence protocol where they can share rails, and
> design the board that way. Even if the touchscreen and panel are
> logically separate, the moment the board designers hook them up to the
> same power rails and/or reset signals they become tied. This is well
> supported by my patch series.
>=20
> The case that really motivated my patch series, though, is the case
> that Cong Yang recently has been working on. I think most of the
> discussion is in his original patch series [1]. Cong Yang's patch
> series is largely focused on supporting the "ILI9882T" chip and some
> panels that it's used with. I found a datasheet for that, and the
> title from the first page is illustrative: "In-cell IC Integrates TFT
> LCD Driver and Capacitive Touch Controller into a Two Chip Cascade".
> This is an integrated solution that's designed to handle both the LCD
> and the touchscreen.
>
> [1] https://lore.kernel.org/lkml/20230519032316.3464732-1-yangcong5@huaqi=
n.corp-partner.google.com/

Ok, I think we're on the same page at the hardware level then :)

> > I guess we can have
> > something much simpler with a bunch of helpers that would register a
> > i2c-hid device and would be called by the panel driver itself.
> >
> > And then, since everything is self-contained managing the power state
> > becomes easier as well.
>=20
> Can you give me more details about how you think this would work?
>=20
> When you say that the panel would register an i2c-hid device itself,
> do you mean that we'd do something like give a phandle to the i2c bus
> to the panel and then the panel would manually instantiate the i2c-hid
> device on it? ...and I guess it would need to be a "subclass" of
> i2c-hid that knew about the connection to the panel code? This
> subclass and the panel code would communicate with each other about
> power sequencing needs through some private API (like MFD devices
> usually do?). Assuming I'm understanding correctly, I think that could
> work.

I guess what I had in mind is to do something similar to what we're
doing with hdmi-codec already for example.

We have several logical components already, in separate drivers, that
still need some cooperation.

If the panel and touchscreen are on the same i2c bus, I think we could
even just get a reference to the panel i2c adapter, get a reference, and
pass that to i2c-hid (with a nice layer of helpers).

What I'm trying to say is: could we just make it work by passing a bunch
of platform_data, 2-3 callbacks and a device registration from the panel
driver directly?

> Is it cleaner than my current approach, though?

"cleaner" is subjective, really, but it's a more "mainstream" approach
that one can follow more easily through function calls.

> I guess, alternatively, we could put the "panel" directly under the
> i2c bus in this case. That would probably work for Cong Yang's current
> needs, but we'd end up in trouble if we ever had a similar situation
> with an eDP panel since eDP panels need to be under the DP-AUX bus.

I don't know DP-AUX very well, what is the issue that you're mentioning?

> I guess overall, though, while I think this approach could solve Cong
> Yang's needs, I still feel like it's worth solving the case where
> board designers have made panel and touchscreens "coupled" by having
> them rely on the same power rails and/or reset signals.

Sure, I definitely want that too :)

Maxime

--wihzk64u23zlxjhl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZIdBvQAKCRDj7w1vZxhR
xUWbAQDoKHxkNsFJzRnUavFQyfjOPvUIBZBQCZ+q/L9YUH2x+AD/c+cVLzsnSBQR
XCR4Te6QoM5Xqv6kSOVA66MXQ4py0wc=
=vl21
-----END PGP SIGNATURE-----

--wihzk64u23zlxjhl--
