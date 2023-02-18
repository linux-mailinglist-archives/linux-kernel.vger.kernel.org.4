Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9119569BABD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 16:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjBRPeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 10:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBRPeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 10:34:09 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13A617153;
        Sat, 18 Feb 2023 07:34:08 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id eq13so3543877edb.11;
        Sat, 18 Feb 2023 07:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whvjdDNL0YyihGiScLJpuUiNsWaIXqPHSQ+hAFVaT/o=;
        b=hfCRopqQcvYe0p1NI/OnI0Asw7RK8dQG5GwB8iUEm7S86KQ3sogc8ptsBp/zppu7LU
         i1siVZxe14sq04QMCn/k8ZBI6WN4yQe5KI2o019L4PbCIhP0CMtuotM/mJ/g4XVuAuKW
         CJk3ESbIluAB34DjHZztYhby968kkDAqPqef7RBDePZ1sYc0b3DmHzrQRbw5CIzlDN5A
         ArZMX2prYjp7oy43pO6ROeEvJYybyoOk86sNh018m5lDqNE25awOPeEZogPjk9e13LWv
         DUQ8vBpgVqh5RhRK+LLvEAojVflWJbyML817mnm6dqGhApLMPxhjeX+zKUGKfzPcxJIe
         e9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whvjdDNL0YyihGiScLJpuUiNsWaIXqPHSQ+hAFVaT/o=;
        b=nOWOGwGMTD6vOU/iC3wDn1BwdqU3epC350wypTAkydS4yGizFBa/0iNlLiYuwJgf+W
         M4wb8FSkEP7FwIKvozKRmiH1cBOZ8eE9ADGBxUJR7WdzvCZM+yc+7EbAibL+Ija3Z/6p
         oGPSbecaAQ+36c9qtXZm1PP6tT0Isb93dPuIDvp9Q1GeFISGaSaZ26cUrHA0FBifVqMR
         bxaccOCSGOqP56VreDN+qI9xFDurb5Gn4xZzQYxBpiAFUz7fxzRmBiVohA+URKtwrqiv
         mCmjlvPxlO+4USw08IzmEUiEVaQnvu1RA2OqWvolExRItWPaqXGclNYTI/RxTxE8+jwM
         mLrA==
X-Gm-Message-State: AO0yUKVvp8arlHUMdOgctanYvdVUDSHWE5ouArQOe6O2UljNOR92PvXe
        8+DcTGCMXEN4UJktnoHkNf2iv8gMOy+0HEng5ohYZAGWSyA=
X-Google-Smtp-Source: AK7set9Tuyg7KuTgdoHJxdFQUaB/2dr0ffoue42nj2SuS5ryAeoWm2tBfUGhw5vYZutZ4hccrYOmriLPrj7eG6rP15w=
X-Received: by 2002:a50:8add:0:b0:4ad:274:cf12 with SMTP id
 k29-20020a508add000000b004ad0274cf12mr253734edk.4.1676734447404; Sat, 18 Feb
 2023 07:34:07 -0800 (PST)
MIME-Version: 1.0
References: <20230109223110.1165433-1-martin.blumenstingl@googlemail.com>
 <Y+DPQjukgC0BELkN@intel.com> <CAFBinCBpbRu9xfCEfZJfT7t3doV=+CX03+h7W+HsoW5T4X0W0w@mail.gmail.com>
 <Y+oa6O6+s5UXvOP6@intel.com> <CAFBinCC6RRiN0=XYNw464omzjHrRcNZn39i3_Ztfq6M2xMpgRw@mail.gmail.com>
 <Y+v+jFKiQ3Rj2aYL@intel.com>
In-Reply-To: <Y+v+jFKiQ3Rj2aYL@intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 18 Feb 2023 16:33:56 +0100
Message-ID: <CAFBinCARqY5K6r_9WcKvBnVfUJuFv78ZYk6D0UiA7FYaA4Kkog@mail.gmail.com>
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

On Tue, Feb 14, 2023 at 10:35 PM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
[...]
> > > We should perhaps just get rid of HDMI_VENDOR_INFOFRAME_SIZE
> > > entirely.
> > My thought was to make it the correct size for
> > drm_hdmi_vendor_infoframe_from_display_mode(). Then developers using
> > this "common" vendor infoframe don't have to worry much.
> > If there's another vendor infoframe implementation (which I'm not
> > aware of, but it may exist - since as you point out: it's vendor
> > specific) then the driver code shouldn't use
> > drm_hdmi_vendor_infoframe_from_display_mode() but rather implement
> > something custom. At that point the person implementing that will also
> > need to know their specific infoframe maximum size.
>
> Yes but that other infoframe will still have
> type=3D=3DHDMI_INFOFRAME_TYPE_VENDOR, and
> HDMI_INFOFRAME_SIZE(VENDOR) would again
> give the wrong answer.
So this means the way forward is to remove HDMI_VENDOR_INFOFRAME_SIZE?
That means it's up to the (HDMI) driver developers to use a big enough
buffer (by hard-coding the size). Last time I checked all drivers did.


Best regards,
Martin
