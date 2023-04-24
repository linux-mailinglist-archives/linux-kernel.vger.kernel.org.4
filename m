Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99AF6ED6FF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 23:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjDXVuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 17:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjDXVt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:49:57 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3C69012;
        Mon, 24 Apr 2023 14:49:51 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4efec123b28so2547137e87.1;
        Mon, 24 Apr 2023 14:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682372990; x=1684964990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UaqrPzK4eXqFK4tbZryREyP9NkLVlumedAFj/tL9Ss=;
        b=knb7XFdICiuaEwjt64pugG0hxN0VKqdoWMObG+APb5g80uUURWsUK3VsyTvQxCKpFD
         bf/OlJiJHtDoHY97wt/6rbAmJU0SVAoP7JJm223GLKinLjMB+x9ue2R0dsIMC3WRf6e1
         G8m7Sskqbc6EoMPWfhVV2kufqbjOhrsZlpek/wXWKU2OJfMTwopNCTKrKKXEuZ93fOe1
         n4BGUZOO09n2USHY2ouYknL/fyJLr1+yV31LSKLKJsFIeJ4Cy4H64D+gmH+x2uQag8LK
         OOcDgbiy26EqIYB/KTV/tjNLvfQf51Td4Xn/iU3ooZ6nu87uQjughw1Mi0/NlN2k3LGo
         gikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682372990; x=1684964990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UaqrPzK4eXqFK4tbZryREyP9NkLVlumedAFj/tL9Ss=;
        b=VsvMdI0UPf5UV40LRpHMN/0OrbwvaA5xhthQBog3Q2Jjf6DtHfKSV1tms4LnrVXw2y
         iIFWlfWsCJ7rCIKHLThU5lXXuOZYvzCUsrEF7qJ8PRwCAdynHO9qDiRDLCXo1gyN37vg
         b2NtmFH2XMzr5e55pr36Rtag3YOeG6Ahb0PnE5xRaY9Dv8Xl/F/TtLPgWLDZpduu1JoN
         KbCwfCaJMJ7jatpTOsKUsyYzXhqJ9+Iqu9yQZvGh3MGj6or1+F7EmtCgFC34W0yLIH5m
         gqeP6EOZnuxi5ubw828JgnhRf77BB24MGeAkDUStRlCNZQZpqfVVeoZYheQ+hBKrYiE4
         1SBw==
X-Gm-Message-State: AAQBX9csnTm49buib+TPur7YH2/qtE4E6at2zy0DOOQNcomyBJ0G3DcS
        G8eQfQsJL1AEgPwQOQSDf7o7nQtcs8jkbttxzZ4=
X-Google-Smtp-Source: AKy350b5tdpbEJCrZ81EZqUJEz+IWXWtCLOs15yrXwf4I0rjMgh/wNK94iLciWHDKBta6/zTKosOyA16Ak9PeUlm65c=
X-Received: by 2002:ac2:54b3:0:b0:4e9:8994:49bd with SMTP id
 w19-20020ac254b3000000b004e9899449bdmr4456740lfk.3.1682372989638; Mon, 24 Apr
 2023 14:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-3-jorge.lopez2@hp.com>
 <b7c49593-13f9-44f8-b3b8-66551b01e966@t-8ch.de> <CAOOmCE_MdHnPb250DDYC6Hoqutod2m=2voBqFz4g0dLcmJ5PRQ@mail.gmail.com>
 <67108caf-2a03-4ef0-9f8d-819b0d6f0a2e@t-8ch.de>
In-Reply-To: <67108caf-2a03-4ef0-9f8d-819b0d6f0a2e@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Mon, 24 Apr 2023 16:49:25 -0500
Message-ID: <CAOOmCE8dru7YOmZeTiEoDMiy7d6nTEih6D2H-AMrOykt=z1bhQ@mail.gmail.com>
Subject: Re: [PATCH v11 02/14] HP BIOSCFG driver - biosattr-interface
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

Hi Thomas,

On Mon, Apr 24, 2023 at 4:04=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t-8ch=
.de> wrote:
>
> On 2023-04-24 15:33:26-0500, Jorge Lopez wrote:
> > Hi Thomas,
> >
> > Please see my comments below.
> >
> > On Sat, Apr 22, 2023 at 4:30=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t=
-8ch.de> wrote:
> > >
> > > Hi Jorge,
> > >
> > > checkpatch.pl finds some issues on your patches.
> > > Please make sure checkpath.pl --strict is happy.
> > >
> > I wasn't aware of the '--strict' parameter.  It is not part of the
> > help information for checkpath.pl tool.
> > Nonetheless, I will use it forward.
> > Thanks
>
> It's an alias to --subjective. But indeed, it's hard to see in the help
> output.
Thanks
>
> > > On 2023-04-20 11:54:42-0500, Jorge Lopez wrote:
> > > > ---
> > > > Based on the latest platform-drivers-x86.git/for-next
> > > No need to initialize auth_token_choice and start.
> > > Consider coalescing variable declaration to avoid wasting vertical
> > > space.
> > >
> > Done!
>
> Please note that this affects many parts of the driver,
> try to fix it everywhere.

It will be done across all files

>
> > > > +{
> > > > +     struct acpi_buffer input, output =3D { ACPI_ALLOCATE_BUFFER, =
NULL };
> > > > +     struct bios_return *bios_return;
> > > > +     union acpi_object *obj =3D NULL;
> > > > +     struct bios_args *args =3D NULL;
> > > > +     int mid, actual_outsize;
> > > > +     size_t bios_args_size;
> > > > +     int ret;
> > > > +
> > > > +     mid =3D encode_outsize_for_pvsz(outsize);
> > > > +     if (WARN_ON(mid < 0))
> > > > +             return mid;
> > > > +
> > > > +     bios_args_size =3D struct_size(args, data, insize);
> > > > +     args =3D kmalloc(bios_args_size, GFP_KERNEL);
> > > > +     if (!args)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     input.length =3D bios_args_size;
> > > > +     input.pointer =3D args;
> > > > +
> > > > +     args->signature =3D 0x55434553;
> > >
> > > What does this number mean?
> > This is a HEX representation of the word  'SECU' expected by BIOS as a =
signa.
>
> Sounds like a good thing to comment or put into a #define.

I will add a comment since it is only used here.
>
> > >
> > > > +     args->command =3D command;
> > > > +     args->commandtype =3D query;
> > > > +     args->datasize =3D insize;
> > > > +     memcpy(args->data, buffer, flex_array_size(args, data, insize=
));
> > > > +
> > > > +     ret =3D wmi_evaluate_method(HP_WMI_BIOS_GUID, 0, mid, &input,=
 &output);
> > >
> > > The driver is mixing calls to the UUID based APIs and the wmi_device
> > > ones.
> > > wmi_devices is newer and preferred.
> >
> > The driver  calls wmi_evaluate_method when initiating an WMI call.
> > Where is the driver mixing calls to the UUID based APIs and the
> > wmi_device one?
> > WMI calls are made by calling hp_wmi_perform_query() which invokes
> > wmi_evaluate_method().
> > Did I miss something?
>
> wmi_evaluate_method() is UUID-based.
> struct wmi_driver is wmi_device based.
>
> The wmi_driver/wmi_device code essentially does nothing and is only used
> to validate that a device is present.
> The same can be done more easily wmi_has_guid().
>

Thank you for the clarification.
> > >
> > > > +     bioscfg_wmi_error_and_message(ret);
> > > > +
> > > > +     if (ret)
> > > > +             goto out_free;
> > > > +
> > > > +     obj =3D output.pointer;
> > > > +     if (!obj) {
> > > > +             ret =3D -EINVAL;
> > > > +             goto out_free;
> > > > +     }
> > > > +     if (query !=3D HPWMI_SECUREPLATFORM_GET_STATE &&
> > > > +         command !=3D HPWMI_SECUREPLATFORM)
> > > > +             if (obj->type !=3D ACPI_TYPE_BUFFER ||
> > > > +                 obj->buffer.length < sizeof(*bios_return)) {
> > > > +                     pr_warn("query 0x%x returned wrong type or to=
o small buffer\n", query);
> > > > +                     ret =3D -EINVAL;
> > > > +                     goto out_free;
> > > > +             }
> > > > +
> > > > +
> > > > +     bios_return =3D (struct bios_return *)obj->buffer.pointer;
> > >
> > > For query =3D=3D HPWMI_SECUREPLATFORM_GET_STATE && command =3D=3D HPW=
MI_SECUREPLATFORM
> > > this is not guaranteed to be a buffer.
> >
> > BIOS ensures the output is of buffer type and  buffer of 1024 bytes in
> > size.  This check also help us validate that BIOS only returns a
> > buffer type for this query/command type.
>
> The kernel does not trust the BIOS :-)
> It trusts nothing and nobody.
>
> All cases should be validated.

Additional validation will be added to cover all cases.

>
> > >
> > > > + */
> > > > +void *ascii_to_utf16_unicode(u16 *p, const u8 *str)
> > > > +{
> > > > +     int len =3D strlen(str);
> > > > +     int ret;
> > > > +
> > > > +     /*
> > > > +      * Add null character when reading an empty string
> > > > +      * "02 00 00 00"
> > > > +      */
> > > > +     if (len =3D=3D 0)
> > > > +             return utf16_empty_string(p);
> > > > +
> > > > +     /* Move pointer len * 2 number of bytes */
> > > > +     *p++ =3D len * 2;
> > > > +     ret =3D utf8s_to_utf16s(str, strlen(str), UTF16_HOST_ENDIAN, =
p, len);
> > > > +     if (ret < 0) {
> > > > +             dev_err(bioscfg_drv.class_dev, "UTF16 conversion fail=
ed\n");
> > > > +             goto ascii_to_utf16_unicode_out;
> > > > +     }
> > >
> > > What if ret !=3D len ?
> >
> > only in conditions where utf8s_to_utf16s an error, we can state  ret !=
=3D len.
> > ret =3D=3D len when utf8s_to_utf16s() is successful.
> > >
> > > > +
> > > > +     if ((ret * sizeof(u16)) > U16_MAX) {
> > > > +             dev_err(bioscfg_drv.class_dev, "Error string too long=
\n");
> > > > +             goto ascii_to_utf16_unicode_out;
> > > > +     }
> > > > +
> > > > +ascii_to_utf16_unicode_out:
> > > > +     p +=3D len;
> > >
> > > In cases of errors this will still point to the end of the data that
> > > should have been written but was not actually written.
> > > The caller has no way to recognize the error case.
> > >
> > That is correct.  If an error occurs, we only provide an error message
> > for those conditions.
>
> But the caller has no idea that this error occurred and will try to use
> the garbage buffer.
> The error should be communicated to the caller, and the caller has to
> validate the result.
> Maybe return NULL?

returning NULL will be a good option so I will review what the impact
will be across the driver
>
> >
> > > > +     return p;
> > > > +}
> > > > +
> > > > +/*
> > >
> > > kernel-doc comments start with "/**". Note the two asterisks.
> > Done
>
> This also needs to be done all over the driver.

It will be done across all files.
