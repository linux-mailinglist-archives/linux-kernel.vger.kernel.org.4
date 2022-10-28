Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4F1611777
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiJ1QXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiJ1QXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:23:19 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406CD1DEC19;
        Fri, 28 Oct 2022 09:23:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id fy4so14115316ejc.5;
        Fri, 28 Oct 2022 09:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43IXkrBvhJMjTYYaSy9C6G880H4PyNNIIiDB/uxTIJA=;
        b=iVnAWSYn34kjfTHNy3nIZtYnYq5Tsj0LT1wqqTorR6HuhvRcB4NNohue3zuRC8UzyC
         Fjg6bZ4T0JMde4iCl7jsd1vHper8Q0sCGSfuE9TNa4Tk8b7J1pHIp0mmAz3R8zOWS2UP
         UBMvJgNR7Bqkm5CtpZCZ3tHafj0cJPKI2ujYNAYYiDg+MgJdIzT9gUqKKeclaEkxjDQj
         h03hT6TzDgsK8U6fkUp8wW8bJTKq+S40YmtXEfVtbn7j0RK6yDtiahHL4/cjLbxmxC6j
         C/EOOMK2p86GWwQtWPutLQJARG+uJpPtJiPBUtSPJ2C/0OUSDMPFF6NiaTwjDD9Ck6G7
         mRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43IXkrBvhJMjTYYaSy9C6G880H4PyNNIIiDB/uxTIJA=;
        b=O97Vllgwo2ejvnhyumqbLjlma1QN1bWyTkvHJrj2P3azQXvcxzrOayfSp2VOgLMnR4
         wYyV8tgtn3tMjuhNkNCc/F3o/pU3PpWZdGx5eHpfRDwvOzeCqj6TbZnaYCLvjWu8mmub
         g9QeOJQyUmws+CP0TwO6t3FrzjJXH202pxseDrmybff4dz3gR53pyE4TFepvhQ2p1Wnk
         bWTzw7TmY6IzMLcNDndHHTGGaH61FtDfUfJDanRRyP/EKIiKANJvRb9yUXLj83W0hAeR
         8rx4P0vPpckhj6Z0YMxoNpFkXpN3XOVSgDivpf9pGZRoqRbHJMvkdUD1MEdZDqIml504
         wijA==
X-Gm-Message-State: ACrzQf0f5a15arwCOriQ8uu3OOiMS4BN9JQLaTMYOC1eoy/UAylMgmVK
        X7WDpfltCvElVx5/0RTxows=
X-Google-Smtp-Source: AMsMyM42XCNA5AF7L70F/2Fb1twGetD6QuXX9asJ4OFTfi/0GJPHTVVIp8/eZyCBKMm6Vp4fKgFY5g==
X-Received: by 2002:a17:907:1dda:b0:7a6:8ffc:7dc with SMTP id og26-20020a1709071dda00b007a68ffc07dcmr121847ejc.163.1666974196606;
        Fri, 28 Oct 2022 09:23:16 -0700 (PDT)
Received: from eray-Lenovo-Z50-70.. ([188.132.247.187])
        by smtp.googlemail.com with ESMTPSA id c15-20020aa7c74f000000b0043bbb3535d6sm2878090eds.66.2022.10.28.09.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 09:23:16 -0700 (PDT)
From:   =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
To:     pobrn@protonmail.com
Cc:     benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        erayorcunus@gmail.com, hdegoede@redhat.com, ike.pan@canonical.com,
        jikos@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgross@linux.intel.com,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 5/6] platform/x86: ideapad-laptop: Expose camera_power only if supported
Date:   Fri, 28 Oct 2022 19:23:14 +0300
Message-Id: <20221028162314.15490-1-erayorcunus@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <NVuCQsVF6HONw3-eRplxrMgWlvEu6AwKlrXqouYOw1FSFucZ9oprZoUeXzBCsrdzFStLjWP4DSl9wOXTe1pS19MZovS9fDmmtVuRD_prCvQ=@protonmail.com>
References: <20221026190106.28441-1-erayorcunus@gmail.com> <20221026190106.28441-6-erayorcunus@gmail.com> <NVuCQsVF6HONw3-eRplxrMgWlvEu6AwKlrXqouYOw1FSFucZ9oprZoUeXzBCsrdzFStLjWP4DSl9wOXTe1pS19MZovS9fDmmtVuRD_prCvQ=@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2022 19:43:29 +0000 Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com> wrote:

> Hi
> 
> 
> 2022. okt=C3=B3ber 26., szerda 21:01 keltez=C3=A9ssel, Eray Or=C3=A7unus =
> =C3=ADrta:
> 
> > IdeaPads dropped support for VPCCMD_W_CAMERA somewhere between 2014-2016,
> > none of the IdeaPads produced after that I tested supports it. Fortunatel=
> y
> > I found a way to check it; if the DSDT has camera device(s) defined, it
> > shouldn't have working VPCCMD_W_CAMERA, thus camera_power shouldn't be
> > exposed to sysfs. To accomplish this, walk the ACPI namespace in
> > ideapad_check_features and check the devices starting with "CAM".
> > Tested on 520-15IKB and Legion Y520, which successfully didn't expose
> > the camera_power attribute.
> >=20
> > Link: https://www.spinics.net/lists/platform-driver-x86/msg26147.html
> > Signed-off-by: Eray Or=C3=A7unus <erayorcunus@gmail.com>
> > ---
> >  drivers/platform/x86/ideapad-laptop.c | 53 ++++++++++++++++++++++++++-
> >  1 file changed, 52 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86=
> /ideapad-laptop.c
> > index f3d4f2beda07..65eea2e65bbe 100644
> > --- a/drivers/platform/x86/ideapad-laptop.c
> > +++ b/drivers/platform/x86/ideapad-laptop.c
> > @@ -149,6 +149,7 @@ struct ideapad_private {
> >  =09=09bool fn_lock              : 1;
> >  =09=09bool hw_rfkill_switch     : 1;
> >  =09=09bool kbd_bl               : 1;
> > +=09=09bool cam_ctrl_via_ec      : 1;
> >  =09=09bool touchpad_ctrl_via_ec : 1;
> >  =09=09bool usb_charging         : 1;
> >  =09} features;
> > @@ -163,6 +164,26 @@ static bool no_bt_rfkill;
> >  module_param(no_bt_rfkill, bool, 0444);
> >  MODULE_PARM_DESC(no_bt_rfkill, "No rfkill for bluetooth.");
> >=20
> > +static char *cam_device_prefix =3D "CAM";
> > +
> > +static acpi_status acpi_find_device_callback(acpi_handle handle, u32 lev=
> el,
> > +=09=09=09=09=09     void *context, void **return_value)
> > +{
> > +=09char buffer[8];
> > +=09struct acpi_buffer ret_buf;
> > +
> > +=09ret_buf.length =3D sizeof(buffer);
> > +=09ret_buf.pointer =3D buffer;
> > +
> > +=09if (ACPI_SUCCESS(acpi_get_name(handle, ACPI_SINGLE_NAME, &ret_buf)))
> > +=09=09if (strncmp(ret_buf.pointer, context, strlen(context)) =3D=3D 0) {
> 
> Please use `strstarts()` here. Is there any reason why you decided not to
> simply "inline" the "CAM" string here (or even in the function call)?

I may use this function to find other devices in future
(thus the name `acpi_find_device_callback`) and I've found a code in the kernel
which use static global initialization like that, so I decided to go for it in here.
But now I will create the "CAM" string inline, and I will also use `strstarts()`
(I didn't know such a function existed), thank you.

> 
> 
> > +=09=09=09*return_value =3D handle;
> > +=09=09=09return AE_CTRL_TERMINATE;
> > +=09=09}
> > +
> > +=09return AE_OK;
> > +}
> > +
> >  /*
> >   * ACPI Helpers
> >   */
> > @@ -675,7 +696,7 @@ static umode_t ideapad_is_visible(struct kobject *kob=
> j,
> >  =09bool supported =3D true;
> >=20
> >  =09if (attr =3D=3D &dev_attr_camera_power.attr)
> > -=09=09supported =3D test_bit(CFG_CAP_CAM_BIT, &priv->cfg);
> > +=09=09supported =3D priv->features.cam_ctrl_via_ec;
> >  =09else if (attr =3D=3D &dev_attr_conservation_mode.attr)
> >  =09=09supported =3D priv->features.conservation_mode;
> >  =09else if (attr =3D=3D &dev_attr_fan_mode.attr)
> > @@ -1523,10 +1544,40 @@ static const struct dmi_system_id hw_rfkill_list[=
> ] =3D {
> >  static void ideapad_check_features(struct ideapad_private *priv)
> >  {
> >  =09acpi_handle handle =3D priv->adev->handle;
> > +=09acpi_handle pci_handle;
> > +=09acpi_handle temp_handle =3D NULL;
> >  =09unsigned long val;
> > +=09acpi_status status;
> 
> It is a small thing, but I believe it is best to define these variables
> in the block of that `if` since they are not used outside of it.

Ok, will do in next revision, thank you.

-eray
