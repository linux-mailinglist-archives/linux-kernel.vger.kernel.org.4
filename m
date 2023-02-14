Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99AA696F96
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjBNV13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjBNV1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:27:23 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFEC30190;
        Tue, 14 Feb 2023 13:26:47 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cq19so16624901edb.5;
        Tue, 14 Feb 2023 13:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBwPN5w46KPtYzNBB1PUOcI+pxWeogqZV27TrNkwSng=;
        b=e6L9U1/sP8yKtDbZJ2G5JLuglrqL1t+mtS4EgAFm5APvzqAaG3bci9IVie8AD5G97m
         ozsYpcoJoD7o+jwnvGtiDiL2FUCbovV+6FI4fCnb5IDTcU1/aL4NXTsrE1Xxh2UcLYLe
         JKUW6th3x0j1zxmSyUlkpqVOQW8hOkSvBDRnmSZLS6d1AC8Rgo0b0FQUixO77nRXfXHp
         xOb7QUZ2f13OZmVZ4siw84XSU/Ufo5DX9O6pROIoyo7mGlF5uu/cGn2aulgZw5PYpe1F
         Vfh6olDVo8P0qZFxOL+MMktSNQ17nwOf7/UvHlyCMP763gNOM13n2bAGZ03OvFE/yx2b
         eYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBwPN5w46KPtYzNBB1PUOcI+pxWeogqZV27TrNkwSng=;
        b=bB/R/AjfT0FmqU+Ckzptf6k++ThSAapo8MLmXMlWdb3Rt1BBYRFx46nMQLXyrJ78C4
         T/t2C1byd76/6MWjxfXHth1JSCle59z831K8O6wbELlh2cp+l8exKgb5RmJr8HrqZxMS
         YO4opxZQDeIswlg8XyIvRhW+8jEhl+x+OGL7fAVP6lXcw7lM9wD0gkvVTng3L8p0wIN/
         2KUnNNcRbvO28VQTYQWlalImh0u/ZFfxyPQgC2BXCwMvvHP6gVTxUuEP0JDwRsIUCQjq
         YmE+k5sMCWnWyrFRB5ZBnECkGu3J2MutnFhMjREBmMdDxTv3ODlZB6PSIODIfHz4pqni
         PB2w==
X-Gm-Message-State: AO0yUKVtDEVQZT/kwCwKJgy4mATMvqnTY0SRnCSiZtvThWzzCgsq6yZw
        rMYljs7vbqW/n8JC4gDd8HlfrSnXd9nE18t3MSY=
X-Google-Smtp-Source: AK7set/vnb1CkEj0ea06+CeQQeObauM91aLnWsPix4DfC/uLhJV482BdKGeQN7nHcfRTn+5QH44loUb0Fn0o9nOPHUU=
X-Received: by 2002:a50:c04a:0:b0:4ab:4b85:a6a8 with SMTP id
 u10-20020a50c04a000000b004ab4b85a6a8mr1965287edd.4.1676409996412; Tue, 14 Feb
 2023 13:26:36 -0800 (PST)
MIME-Version: 1.0
References: <20230109223110.1165433-1-martin.blumenstingl@googlemail.com>
 <Y+DPQjukgC0BELkN@intel.com> <CAFBinCBpbRu9xfCEfZJfT7t3doV=+CX03+h7W+HsoW5T4X0W0w@mail.gmail.com>
 <Y+oa6O6+s5UXvOP6@intel.com>
In-Reply-To: <Y+oa6O6+s5UXvOP6@intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 14 Feb 2023 22:26:24 +0100
Message-ID: <CAFBinCC6RRiN0=XYNw464omzjHrRcNZn39i3_Ztfq6M2xMpgRw@mail.gmail.com>
Subject: Re: [PATCH v1 RFC] video/hdmi: Fix HDMI_VENDOR_INFOFRAME_SIZE
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bernard Zhao <bernard@vivo.com>
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

On Mon, Feb 13, 2023 at 12:11 PM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
[...]
> > One could use HDMI_VENDOR_INFOFRAME_SIZE with this as well:
> >   u8 buffer[HDMI_INFOFRAME_SIZE(VENDOR)];
> > But it would only result in an 8 byte wide buffer.
> > Nobody uses it like this yet.
>
> Not sure that would make any sense since a vendor
> specific infoframe has no defined size until you
> figure out which vendor defined it (via the OUI).
My understanding is that all of the existing HDMI vendor infoframe
code is built for HDMI_IEEE_OUI.

> I suppose the current value of 4 is also a bit nonsense
> as well then, becasue that is a legal value for the
> HDMI 1.4 vendor specific infoframe, but might not be
> valid for any other infoframe.
>
> We should perhaps just get rid of HDMI_VENDOR_INFOFRAME_SIZE
> entirely.
My thought was to make it the correct size for
drm_hdmi_vendor_infoframe_from_display_mode(). Then developers using
this "common" vendor infoframe don't have to worry much.
If there's another vendor infoframe implementation (which I'm not
aware of, but it may exist - since as you point out: it's vendor
specific) then the driver code shouldn't use
drm_hdmi_vendor_infoframe_from_display_mode() but rather implement
something custom. At that point the person implementing that will also
need to know their specific infoframe maximum size.


Best regards,
Martin
