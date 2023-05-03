Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6DC6F5B4D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 17:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjECPfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 11:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjECPfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 11:35:45 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E49A449B;
        Wed,  3 May 2023 08:35:43 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4ec8eca56cfso6316820e87.0;
        Wed, 03 May 2023 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683128142; x=1685720142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFjqMoLMLjbtDQ/FU1cJVmttw0+g9NofP/Ycqwg6QIY=;
        b=K76Ghx//hX9tW7hHI/FUWux51ViM4vpqlDsSH5zxXGrxB50x7VcP0uDGhcb5yU4l2A
         K+wTlTnsGLZnklY0cgk2lbCf09y+rJUCeXq/gV8EU7TjdDivQfqjEblksuWxJzmrHhod
         PUHrl5Czf2YFmHTGf3Vdy4tOQpU7SEugoCUfmNPuEnU5XYBk/+coG7UxBtliSCubq/Zl
         IthyxQHkwaBuzchxWcF6odTdqEMruNYfUzWGwCMNCY+YrJBsugnwxhfPAfJEOLE4yGZw
         KXKpYUR1VBNxQU3vmbshlprI5fxJYjy/bLHYS1V3FI0KNLK1eHfU3qgxsaX2MJ12zAJz
         yA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683128142; x=1685720142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFjqMoLMLjbtDQ/FU1cJVmttw0+g9NofP/Ycqwg6QIY=;
        b=WvyZb62GR6LfHay2Vbc30KYQDSV9x7+7sGppaTibU9txJ/qYlcUA/h0ONf0W5jGwvA
         ZlkjvPCLcuM/FXB+InVZt0lfwomLAM970Oaq7lQiaGDCPhC2NAKorAEiiYgq1azjU2ob
         kZsr+8rKN7/XXFp37i/ZOM483BBIlYOgrlRdr9GIs7Wiq77ieEL2l6UnMdzHHCzUOgfR
         tv/n64iJdVJwSLdxl/uTJ7+UHYPqu67B0/ufGMA4wM/KEudkpce57T04KG7jyXlxRQS1
         WggNBJYYqjSqA6eS/dFwIQ7fLO7FcwS7WqHOyfsyLVoe4TT2ppU5AjWzNgfKM9VfAQZ7
         Oizg==
X-Gm-Message-State: AC+VfDw+d7z+z2hSrz3ALySRIoQvp9E3kHK+TsAEajiWGlOBSWossAys
        padLn1J2C54lT4S4W88VPh85ofBeEt6cgMEplAP/yg6PQIQ=
X-Google-Smtp-Source: ACHHUZ6GOeKAUtMS19C1Uh8omVflvYszWMm59+XnpoCPt3wEDwEiIBXYP+LsJ7aHxwdvLUmm9moEKnyNO02wdW1Rpl8=
X-Received: by 2002:ac2:4d10:0:b0:4f0:1a32:ca23 with SMTP id
 r16-20020ac24d10000000b004f01a32ca23mr927848lfi.40.1683128141551; Wed, 03 May
 2023 08:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-5-jorge.lopez2@hp.com>
 <26f0a80e-d3f8-4d6c-83ff-d756abed7b6b@t-8ch.de> <CAOOmCE8+Kgkm4uscYEei1+9xHiN=wd2oNtEiLeneDS+zppuYcg@mail.gmail.com>
 <efafedc0-e9d3-4060-a174-dc4f33f77246@t-8ch.de>
In-Reply-To: <efafedc0-e9d3-4060-a174-dc4f33f77246@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Wed, 3 May 2023 10:35:14 -0500
Message-ID: <CAOOmCE9U3y_aCD9LGdWLXFAF5OQzWFfNRbywQM5iGdM=DCzkLg@mail.gmail.com>
Subject: Re: [PATCH v11 04/14] HP BIOSCFG driver - int-attributes
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 2, 2023 at 4:30=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t-8ch.=
de> wrote:
>
> Hi Jorge,
>
> thanks for incorporating my feedback, I'm curious for the next revision!
>
> The review comments are very terse but that is only to bring across
> their points better. Your effort is appreciated.
>
> On 2023-05-02 15:56:22-0500, Jorge Lopez wrote:
>
> <snip>
>
> > > On 2023-04-20 11:54:44-0500, Jorge Lopez wrote:
> > > > ---
> > > > Based on the latest platform-drivers-x86.git/for-next
> > > > ---
> > > >  .../x86/hp/hp-bioscfg/int-attributes.c        | 474 ++++++++++++++=
++++
> > > >  1 file changed, 474 insertions(+)
> > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/int-attribut=
es.c
> > > >
> > > > diff --git a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c b/=
drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> > > > new file mode 100644
> > > > index 000000000000..d8ee39dac3f9
> > > > --- /dev/null
> > > > +++ b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
>
> <snip>
>
> > > > +int populate_integer_elements_from_package(union acpi_object *inte=
ger_obj,
> > > > +                                        int integer_obj_count,
> > > > +                                        int instance_id)
> > > > +{
> > > > +     char *str_value =3D NULL;
> > > > +     int value_len;
> > > > +     int ret =3D 0;
> > > > +     u32 size =3D 0;
> > > > +     u32 int_value;
> > > > +     int elem =3D 0;
> > > > +     int reqs;
> > > > +     int eloc;
> > > > +
> > > > +     if (!integer_obj)
> > > > +             return -EINVAL;
> > > > +
> > > > +     strscpy(bioscfg_drv.integer_data[instance_id].common.display_=
name_language_code,
> > > > +             LANG_CODE_STR,
> > > > +             sizeof(bioscfg_drv.integer_data[instance_id].common.d=
isplay_name_language_code));
> > > > +
> > > > +     for (elem =3D 1, eloc =3D 1; elem < integer_obj_count; elem++=
, eloc++) {
> > > > +
> > > > +             /* ONLY look at the first INTEGER_ELEM_CNT elements *=
/
> > >
> > > Why?
> > The information provided in element 0 from the package is ignored as
> > directed by the BIOS team.
> > Similar action is taken when reading the information from ACPI Buffer
> > (populate_integer_elements_from_buffer())
>
> This should be mentioned somewhere.
>
> But my question was more why to we only look at INTEGER_ELEM_CNT?
> It is clear to me now, but this is very convulted. See below.

I am adding the following information to each attribute file for clarificat=
ion.

"The total number of elements (INT_ELEM_CNT) read include only data
relevant to this driver and its functionality. BIOS defines the order
in which each element is read.  Element 0 data is not relevant to this
driver hence it is ignored.  For clarity, The switch statement list
all element names (DISPLAY_IN_UI) which defines the order in which is
read and the name matches the variable where the data is stored".

>
> <snip>
>
> > >
> > > > +
> > > > +int populate_integer_elements_from_buffer(u8 *buffer_ptr, u32 *buf=
fer_size,
> > > > +                                       int instance_id)
> > > > +{
> > > > +     char *dst =3D NULL;
> > > > +     int elem;
> > > > +     int reqs;
> > > > +     int integer;
> > > > +     int size =3D 0;
> > > > +     int ret;
> > > > +     int dst_size =3D *buffer_size / sizeof(u16);
> > > > +
> > > > +     dst =3D kcalloc(dst_size, sizeof(char), GFP_KERNEL);
> > > > +     if (!dst)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     elem =3D 0;
> > > > +     strscpy(bioscfg_drv.integer_data[instance_id].common.display_=
name_language_code,
> > > > +             LANG_CODE_STR,
> > > > +             sizeof(bioscfg_drv.integer_data[instance_id].common.d=
isplay_name_language_code));
> > > > +
> > > > +     for (elem =3D 1; elem < 3; elem++) {
> > > > +
> > > > +             ret =3D get_string_from_buffer(&buffer_ptr, buffer_si=
ze, dst, dst_size);
> > > > +             if (ret < 0)
> > > > +                     continue;
> > > > +
> > > > +             switch (elem) {
> > > > +             case VALUE:
> > > > +                     ret =3D kstrtoint(dst, 10, &integer);
> > > > +                     if (ret)
> > > > +                             continue;
> > > > +
> > > > +                     bioscfg_drv.integer_data[instance_id].current=
_value =3D integer;
> > > > +                     break;
> > > > +             case PATH:
> > > > +                     strscpy(bioscfg_drv.integer_data[instance_id]=
.common.path, dst,
> > > > +                             sizeof(bioscfg_drv.integer_data[insta=
nce_id].common.path));
> > > > +                     break;
> > > > +             default:
> > > > +                     pr_warn("Invalid element: %d found in Integer=
 attribute or data may be malformed\n", elem);
> > > > +                     break;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     for (elem =3D 3; elem < INTEGER_ELEM_CNT; elem++) {
> > >
> > > This loop pattern seems weird to me.
> > > It is not obvious that the values are read in the order of the switch=
()
> > > branches from the buffer.
> > >
> >
> > The order in which the data is read from the buffer is set by BIOS.
>
> This I understand.
>
> > The switch statement was used to enforce the reading order of the
> > elements and provide additional clarity
>
> This is not clear from the code alone. One also needs to know the
> concrete values of the enums.
>
> > > Something more obvious would be:
> > >
> > > instance.common.is_readonly =3D read_int_from_buf(&buffer_ptr);
> > > instance.common.display_in_ui =3D read_int_from_buf(&buffer_ptr);
> > > instance.common.requires_physical_presence =3D read_int_from_buf(&buf=
fer_ptr);
>
> The proposed pattern above, just regular function calls, are also
> executed in the correct order, the order in which they are written.
>
The code will be easier to follow and will not require checking of the
results  because failing conditions are ignored.
This will be a good option for functions such
populate_integer_elements_from_buffer().  Buffer elements.
Refactoring  package function,
populate_integer_elements_from_package(), will introduce additional
complexity and obfuscation.


> For a reader it is clear that the order is important and part of the
> ABI of the BIOS.
>
> > > This would make it clear that these are fields read in order from the
> > > buffer. Without having to also look at the numeric values of the
> > > defines.
> > >
> > > Furthermore it would make the code shorter and errorhandling would be
> > > clearer and the API similar to the netlink APIs.
> > >
> > > Or maybe with error reporting:
> > >
> > > ret =3D read_int_from_buf(&buffer_ptr, &instance.common.is_readonly);
> > > if (ret)
> > >     ...
> >
> > Instance.common.is_readonly is only evaluated when the user attempt to
> > update an attribute current value
>
> is_readonly was only an example on how to more nicely read the data from
> the buffer. It applies to all values of all attribute types.
>
> > > ret =3D read_int_from_buf(&buffer_ptr, &instance.common.display_in_ui=
);
> > > if (ret)
> > >     ...
> >
> > Instance.common.display_in_ui has no specific use at this time.
> >
> > The code was made shorter and easier to understand by replacing the
> > long statements with
> >
> > struct integer_data *integer_data =3D &bioscfg_drv.integer_data[instanc=
e_id];
> > ...
> > integer_data->common.is_readonly =3D integer;
> >
> > Same approach was taken for all attribute files.
>
> Thanks!
>
> Please do try to use the "plain functioncall" pattern as outlined above.
> I think it can make the code much shorter and idiomatic.

Understood!
