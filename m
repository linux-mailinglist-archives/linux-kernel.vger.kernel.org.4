Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FD46A99D0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjCCOtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjCCOtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:49:24 -0500
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53625D8A9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:49:16 -0800 (PST)
Date:   Fri, 03 Mar 2023 14:49:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanle.dev;
        s=protonmail; t=1677854954; x=1678114154;
        bh=GE82kdhVniwQCHmSI+W3zZPQ84XQA0TdOMeq+pnRWDE=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=IqwEbFJRh8Kx0oQWHp9cVQcj8La/lHRA3HdeeTq3cg3FsIeeitkFmaE1sduTdvxj1
         7AGsyZ3iXdXs+d2ZovIUjhUXJAO9zKCSBPRFiojK91Hxe7C2nyY+XIm5QJqj0/Ns6r
         8bE8kwL/sy1GOpTnqcnUScOMceOb6EBfOEH4ij95MPGm5t6Xte/EdQN1pmYY9/14s/
         0TBtuRLcfAGRdWWOvlpVrsoIv2lF4CXSmVdoM5z80XgR4cuY40kKyppNKvPYDip0Jx
         PqtJD2YW251KfLXiWqoZXBt29+F8Mq1gkP8S4kwJP06cdkUM25zQ2V2sOIVv7nnDBY
         uhYCnWcZBRrNQ==
To:     Bagas Sanjaya <bagasdotme@gmail.com>
From:   Dylan Le <self@dylanle.dev>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] Documentation: gpu: add acceleration node section
Message-ID: <mnLCBvF9cqw1NSMEMHVM86FfcFsr63NEB1V1q0uUFUv70_ZBHgOLgtY-qIDiolOKclKFLfcBOpWfF1Q6PpWXNqRx0mI0yoWfBD7zLPM6HXc=@dylanle.dev>
In-Reply-To: <Y/bqtlbnWkKMIJI4@debian.me>
References: <7799513f0fb5aee27b64752c037980471be669c5.1677120686.git.self@dylanle.dev> <Y/bqtlbnWkKMIJI4@debian.me>
Feedback-ID: 68106091:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, February 22nd, 2023 at 11:25 PM, Bagas Sanjaya <bagasdotme@gm=
ail.com> wrote:
>=20
>=20
> On Thu, Feb 23, 2023 at 02:52:52AM +0000, Dylan Le wrote:
>=20
> > This patch was initially written for the Linux Kernel Bug Fixing Mentor=
ship
> > program. The patch adds a temporarily stubbed section on Acceleration N=
odes
> > to resolve a documentation warning.
> >=20
> > This resolves the warning:
> > ./Documentation/gpu/drm-internals:179: ./include/drm/drm_file.h:411: WA=
RNING: undefined label: drm_accel_node
>=20
>=20
> Please write the patch description in imperative mood ("Do foo" instead
> of "This patch does foo").
>=20
> > I would appreciate any feedback on what should be documented here.
>=20
>=20
> I think above is better placed between the three dashes and diffstat ...
>=20
> > ---
>=20
>=20
> like here.
>=20
> > Documentation/gpu/drm-uapi.rst | 9 +++++++++
> > 1 file changed, 9 insertions(+)
>=20
> > +.. _drm_accel_node:
> > +
> > +Acceleration nodes
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +.. note::
> > + There is not any documentation yet need to figure out what this is.
>=20
>=20
> I'd like to write this stub as generic .. admonition:: block [1] instead,
> with the content which is "This section is empty, add appropriate
> documentation here." or similar.
>=20
> [1]: https://docutils.sourceforge.io/docs/ref/rst/directives.html#generic=
-admonition
>=20
> Thanks.
>=20
> --
> An old man doll... just what I always wanted! - Clara

Thank you Bagas for the feedback,

I prematurely sent a v2 of this patch taking into account your feedback, bu=
t I will hold off on other changes. Since there seems to be another discuss=
ion about a broken reference in drm_file.h.

If there is something I can look at in the meantime let me know.

Thanks,
Dylan Le
