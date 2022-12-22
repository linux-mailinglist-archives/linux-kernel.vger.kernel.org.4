Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F49653D48
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 10:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbiLVJEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 04:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbiLVJD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 04:03:57 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F00205D5;
        Thu, 22 Dec 2022 01:03:50 -0800 (PST)
Received: from booty (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 098A8240006;
        Thu, 22 Dec 2022 09:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1671699829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gktEAWN3JB8j4tgK6e174eAxgB6KpzGMlNNM9C0jpTQ=;
        b=hkeMahLxr95J8jRRBnHvUsJYopZH+NMQb36c/kMWeoRhxAs9R0Nsx8Kqm4U4LWysvOU4rF
        NOIWJ4Zdl2Q5dDwUN/9g+0FVXa2wXZXOsk7HTAxAy0vDhJzSm3+xBN79nR+exWUshQho0n
        TtXXf4UQwrpswjA0RHE4dVmNNSZqJrhzz3Npot2ARR9J9w3hzGj1YuIKyMSJsiJPG42RrC
        hed3gv6cFfcUIZtqDTYk0dIwQUY5zfKceYc9cFExuKYtMcklW7NUXc94FiHaP5kEglHpvS
        jA0pmJ5r/t1D76kP/f+IqMwWqd69m16O/ZRCLR4rCWJLZ5XFm1xIAyAQsSY4LQ==
Date:   Thu, 22 Dec 2022 10:03:41 +0100
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH v2 21/21] staging: media: tegra-video: add tegra20
 variant
Message-ID: <20221222100341.5882c19c@booty>
In-Reply-To: <30e6b040-aa82-f6a3-1ff6-baa2c0dcb0e2@gmail.com>
References: <20221128152336.133953-1-luca.ceresoli@bootlin.com>
 <20221128152336.133953-22-luca.ceresoli@bootlin.com>
 <30e6b040-aa82-f6a3-1ff6-baa2c0dcb0e2@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry,

On Wed, 21 Dec 2022 00:40:20 +0300
Dmitry Osipenko <digetx@gmail.com> wrote:

> 28.11.2022 18:23, Luca Ceresoli =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > +static int tegra20_channel_capture_frame(struct tegra_vi_channel *chan,
> > +					 struct tegra_channel_buffer *buf)
> > +{
> > +	u32 value;
> > +	int err;
> > +
> > +	chan->next_out_sp_idx++;
> > +
> > +	tegra20_channel_vi_buffer_setup(chan, buf);
> > +
> > +	tegra20_vi_write(chan, TEGRA_VI_CAMERA_CONTROL, VI_CAMERA_CONTROL_VIP=
_ENABLE);
> > +
> > +	/* Wait for syncpt counter to reach frame start event threshold */
> > +	err =3D host1x_syncpt_wait(chan->out_sp, chan->next_out_sp_idx,
> > +				 TEGRA_VI_SYNCPT_WAIT_TIMEOUT, &value); =20
>=20
> You're not using the "value" variable, it should be NULL.

Ah, sure, good catch.

> The "chan->out_sp" looks redundant, it duplicates the chan->mw_ack_sp.

I agree it is redundant and can be improved.

> AFAICS from the doc, T20 has two VI channels, and thus, two mw_ack_sp,
> like T210.

I'm confused by this. In the current driver, each VI channel has an
array of 2 mw_ack_sp, the second of which is only used the ganged
CSI ports. I have no docs mentioning ganged ports so I don't know
exactly how they work and whether T20 might need more than 1 syncpt per
channel or not for CSI. Definitely when using VIP only one such syncpt
per each VI (or per each VIP, as per your reply to patch 1) is needed.

Bottom line: I think I can simply remove the out_sp and in the VIP code
always use chan->mw_ack_sp[0], and document that it's what is called OUT
in VIP terms.

Does this plan seem good?

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
