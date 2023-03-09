Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521846B1B3F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCIGQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjCIGQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:16:16 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BA1DCA61;
        Wed,  8 Mar 2023 22:16:09 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id u9so2850264edd.2;
        Wed, 08 Mar 2023 22:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678342568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+YXj3xuJamy46fVwlA5D0PVaIrEDpyBLL/CETayzIQ=;
        b=hIFJJL3N3RVC22Wt8jlMc8D2dF9QUADUbLNswq5IaxtMbS3J86O1P9IPVsN9hOD6Ft
         nAm0U23KpWuYNMDQWjPKO9IEcaT13eYcHJBI7BKh+3j79nMG9kWMEHNtnY+0QHfE7odK
         tt77olNALEeYo7jL2N31ZiTD3kjzLIbm7zmjHBtKrhMqACZnBRVjN9mTsC+zznDjmvWn
         Ll3h5AR/YgBIhI1XxYezIhuy93gwYJHJLetLhmlPjIdNA9TB2XWoh7AtETyqL7jJB8f8
         aNoulwlvgi8U1g9ajjPBuVIzzpYsPcc6CN574h3TlD61iIkR8zylv4vOj1aZtwZk2HTj
         MdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678342568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+YXj3xuJamy46fVwlA5D0PVaIrEDpyBLL/CETayzIQ=;
        b=EIduy4GgjrBbQuMsFC6e53Nos7oM3EodpgZqNOIekIg4MUN29tHkQmPOJ6Rkyz1fAj
         T9DpxHwqh5RYJZSnO0sTF8d+Cg9Z9QQPxeY+e4QVPU17jY94G+JxAhgaxlWsWHr0kvqp
         EUDW8Jru+1OKuYIQjs3f/BhtterQ/dTBEJnwUYKVO1EZVpz9L6vWVfKyuyx8Ogr3ie4F
         UU+vudmL9O2FZxL7ZPmBt9H0dgOn/VyDmB1znsngioBfPQYJ0KzxHVvEqjdxXjkbqyz6
         mP56bed6mI0vHztjuSQ9H26YcAku6oFWjES5HOUCTA3wfwWsH79dqKFvdei8dSdGScMi
         LgQw==
X-Gm-Message-State: AO0yUKWiGuc3R+ZWpeowM0y11E80bHwsbeCv+LZ0oBtju9VtXcvoJBkU
        I1coM1EjVlREsWWIa06m/80Qp/Ma4D6uh8tjEVE=
X-Google-Smtp-Source: AK7set+pX4aXbrBAtPzUy0OOYdjRl9vI15JjJJrWhBl5M9MyxAE2uL+BYCgDCkNpTcYEk4FVcbdNDZ32jt3IYAjV1pI=
X-Received: by 2002:a50:c04b:0:b0:4bf:5fd5:da42 with SMTP id
 u11-20020a50c04b000000b004bf5fd5da42mr11522809edd.3.1678342567958; Wed, 08
 Mar 2023 22:16:07 -0800 (PST)
MIME-Version: 1.0
References: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
 <20230307-rust-drm-v1-1-917ff5bc80a8@asahilina.net> <c047e11f-33d0-6af4-21c3-adb384b68d8b@igalia.com>
 <93a57598-9deb-85f2-ebd9-8605404c1ef8@asahilina.net>
In-Reply-To: <93a57598-9deb-85f2-ebd9-8605404c1ef8@asahilina.net>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 9 Mar 2023 16:15:55 +1000
Message-ID: <CAPM=9tw6aUUgL63EFhX6W_mQa1ssEmcPjJJHhrssasRVPt76rg@mail.gmail.com>
Subject: Re: [PATCH RFC 01/18] rust: drm: ioctl: Add DRM ioctl abstraction
To:     Asahi Lina <lina@asahilina.net>
Cc:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linaro-mm-sig@lists.linaro.org, rust-for-linux@vger.kernel.org,
        Karol Herbst <kherbst@redhat.com>, asahi@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Mary <mary@mary.zone>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-sgx@vger.kernel.org, Ella Stanforth <ella@iglunix.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2023 at 15:32, Asahi Lina <lina@asahilina.net> wrote:
>
> On 08/03/2023 00.32, Ma=C3=ADra Canal wrote:
> > On 3/7/23 11:25, Asahi Lina wrote:
> >> DRM drivers need to be able to declare which driver-specific ioctls th=
ey
> >> support. This abstraction adds the required types and a helper macro t=
o
> >> generate the ioctl definition inside the DRM driver.
> >>
> >> Note that this macro is not usable until further bits of the
> >> abstraction are in place (but it will not fail to compile on its own, =
if
> >> not called).
> >>
> >> Signed-off-by: Asahi Lina <lina@asahilina.net>
> >> ---
> >>   drivers/gpu/drm/Kconfig         |   7 ++
> >>   rust/bindings/bindings_helper.h |   2 +
> >>   rust/kernel/drm/ioctl.rs        | 147 ++++++++++++++++++++++++++++++=
++++++++++
> >>   rust/kernel/drm/mod.rs          |   5 ++
> >>   rust/kernel/lib.rs              |   2 +
> >>   5 files changed, 163 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> >> index dc0f94f02a82..dab8f0f9aa96 100644
> >> --- a/drivers/gpu/drm/Kconfig
> >> +++ b/drivers/gpu/drm/Kconfig
> >> @@ -27,6 +27,13 @@ menuconfig DRM
> >>        details.  You should also select and configure AGP
> >>        (/dev/agpgart) support if it is available for your platform.
> >>
> >
> > [...]
> >
> >> +
> >> +/// Declare the DRM ioctls for a driver.
> >> +///
> >> +/// Each entry in the list should have the form:
> >> +///
> >> +/// `(ioctl_number, argument_type, flags, user_callback),`
> >> +///
> >> +/// `argument_type` is the type name within the `bindings` crate.
> >> +/// `user_callback` should have the following prototype:
> >> +///
> >> +/// ```
> >> +/// fn foo(device: &kernel::drm::device::Device<Self>,
> >> +///        data: &mut bindings::argument_type,
> >> +///        file: &kernel::drm::file::File<Self::File>,
> >> +/// )
> >> +/// ```
> >> +/// where `Self` is the drm::drv::Driver implementation these ioctls =
are being declared within.
> >> +///
> >> +/// # Examples
> >> +///
> >> +/// ```
> >> +/// kernel::declare_drm_ioctls! {
> >> +///     (FOO_GET_PARAM, drm_foo_get_param, ioctl::RENDER_ALLOW, my_ge=
t_param_handler),
> >> +/// }
> >> +/// ```
> >> +///
> >> +#[macro_export]
> >> +macro_rules! declare_drm_ioctls {
> >> +    ( $(($cmd:ident, $struct:ident, $flags:expr, $func:expr)),* $(,)?=
 ) =3D> {
> >> +        const IOCTLS: &'static [$crate::drm::ioctl::DrmIoctlDescripto=
r] =3D {
> >> +            const _:() =3D {
> >> +                let i: u32 =3D $crate::bindings::DRM_COMMAND_BASE;
> >> +                // Assert that all the IOCTLs are in the right order =
and there are no gaps,
> >> +                // and that the sizeof of the specified type is corre=
ct.
> >
> > I believe that not necessarily the IOCTLs need to be in the right order=
 and
> > with no gaps. For example, armada_drm.h has a gap in between 0x00 and
> > 0x02 and exynos_drm.h also have gaps. Moreover, some drivers, like vgem=
 and
> > virtgpu, start their IOCTLs with 0x01.
>
> Yeah, we talked about this a bit... do you have any ideas about how to
> design this? I think it should be possible with a const function
> initializing an array entry by entry, we just need a two-pass macro
> (once to determine the max ioctl number, then again to actually output
> the implementation).
>
> I'm not sure why drivers would have gaps in the ioctl numbers though...
> my idea was that new drivers shouldn't need that as far as I can tell
> (you can't remove APIs after the fact due to UAPI stability guarantees,
> so as long as you don't have gaps to begin with...). But I guess if
> we're reimplementing existing drivers in Rust we'll need this... though
> maybe it makes sense to just say it's not supported and require
> reimplementations that have holes to just explicitly add dummy ioctls
> that return EINVAL? We could even provide such a dummy generic ioctl
> handler on the abstraction side, so drivers just have to add it to the
> list, or make the macro take a special token that is used for
> placeholder ioctls that don't exist (which then creates the NULL
> function pointer that the drm core interprets as invalid)...

I can think of two reason for gaps having appeared:

a) developers wanted to group new uapis at a nice base number.
This is never essential it's just makes things easier to read, and
allows slotting other ioctls into the gaps later.

b) parallel feature development ends up conflicting then one thread never l=
ands.
I've got two-three devs each adding a uAPI, we assign them 0x10, 0x11,
0x12 while they work, then 0x11 never lands because it was a bad idea.

However I think you should be fine enforcing a non-sparse space here
unless we want to handle replacing current drivers, as long as it's
hard to screw up so you know early.

Dave.
