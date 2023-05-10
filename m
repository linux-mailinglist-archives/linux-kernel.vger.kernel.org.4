Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A136FE516
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbjEJUaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236404AbjEJUa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:30:26 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1134EEC;
        Wed, 10 May 2023 13:30:24 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ac88d9edf3so72958541fa.0;
        Wed, 10 May 2023 13:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683750623; x=1686342623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkKYgbmgy8kkxywubZx4rt5qVzmNSK/xYEb72U2zNnc=;
        b=Gg3uv2MCPukFzmVxw4BCnADXDitRgDULWbqvkjmU4TjyCAQ5Conu7CuyCNMSLy3XW1
         cgLINThQPJw8XFQbBkZXXPJVIK5KGQ8dh4wZ1IozNRqEM4944/CDbpYeQ9jQBzBGL85+
         Wms/tndqNkKO8pwXIrGhUywmAvdx8VcdUAXLN2MmgD8jY4F1gy5EqEi0iBd9LAEmFmij
         JBXaQitd1hAv16b/VPV5dNA9A3H9/CtofG1l2BApiG1ANkB0KqtyUPUl4w+VK1ytRXbI
         56xttjnsTew1HmdeOZZTdKPte99HXizLrOd7VZZZHMScFFgZWwx7jihg6CvZQ+oPAopk
         Ecvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683750623; x=1686342623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkKYgbmgy8kkxywubZx4rt5qVzmNSK/xYEb72U2zNnc=;
        b=jdJyEHoheFOiN2bWMJv4HS90xHTYCrNyZ5dueT1Q40xnyXPCHfe9AsqNyh5bbhHRJF
         JDYA5hSS8cPOJ9/qlVFUyLqWXZ1/v0on797Ss95Y/O6EgZcx42pm99LaP/njLOriyafE
         1YTGGL14xf2A99mYbtdJzyOTXa8rDEMs4xTwrJAHRcsvJa59JhUP8D1ZzKiS1Z6KhiRM
         bWJoFuZSIIXvXDceMGDmHEpzZ38IHXjNOjDAJptclyl/f8vRnq9yvdp/EFuyT/5U1hhZ
         bXWMSpPQyMMtUOIxsMlyzicC2XN7FcrSBxEc5VSGcDw+BE5W06NUgg7bbDC6haRb1c5e
         +AyA==
X-Gm-Message-State: AC+VfDznjZtZKw77Lwuama4d05gZrLySEYDynYKUiTO5LYoG+h4jJ+8Y
        S/GDKODGRgQSYmwLp6xEx5axIyuvCN7UVZ1TTlo=
X-Google-Smtp-Source: ACHHUZ6SArMaZ72iOQk1vfjOokK7/5jYmuxyTbx6GRzsmW/BrKn0zQVyz7wGzjhUJz2cR1a4Vr1kWwBBZ099YTwzKk4=
X-Received: by 2002:a2e:8559:0:b0:2a8:ca1e:b63 with SMTP id
 u25-20020a2e8559000000b002a8ca1e0b63mr2304672ljj.36.1683750622500; Wed, 10
 May 2023 13:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-6-jorge.lopez2@hp.com>
 <266e7ffc-ee84-56d9-51c5-61f2600d4c4@linux.intel.com>
In-Reply-To: <266e7ffc-ee84-56d9-51c5-61f2600d4c4@linux.intel.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Wed, 10 May 2023 15:29:53 -0500
Message-ID: <CAOOmCE_=Fv3n9kGRhh3zHT2kJDNUik8uq4H7dV9eFH+2FW1YWg@mail.gmail.com>
Subject: Re: [PATCH v12 05/13] HP BIOSCFG driver - ordered-attributes
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
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

On Tue, May 9, 2023 at 8:15=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Fri, 5 May 2023, Jorge Lopez wrote:
>
> > HP BIOS Configuration driver purpose is to provide a driver supporting
> > the latest sysfs class firmware attributes framework allowing the user
> > to change BIOS settings and security solutions on HP Inc.=E2=80=99s com=
mercial
> > notebooks.
> >
> > Many features of HP Commercial notebooks can be managed using Windows
> > Management Instrumentation (WMI). WMI is an implementation of Web-Based
> > Enterprise Management (WBEM) that provides a standards-based interface
> > for changing and monitoring system settings. HP BIOSCFG driver provides
> > a native Linux solution and the exposed features facilitates the
> > migration to Linux environments.
> >
> > The Linux security features to be provided in hp-bioscfg driver enables
> > managing the BIOS settings and security solutions via sysfs, a virtual
> > filesystem that can be used by user-mode applications. The new
> > documentation cover HP-specific firmware sysfs attributes such Secure
> > Platform Management and Sure Start. Each section provides security
> > feature description and identifies sysfs directories and files exposed
> > by the driver.
> >
> > Many HP Commercial notebooks include a feature called Secure Platform
> > Management (SPM), which replaces older password-based BIOS settings
> > management with public key cryptography. PC secure product management
> > begins when a target system is provisioned with cryptographic keys
> > that are used to ensure the integrity of communications between system
> > management utilities and the BIOS.
> >
> > HP Commercial notebooks have several BIOS settings that control its
> > behaviour and capabilities, many of which are related to security.
> > To prevent unauthorized changes to these settings, the system can
> > be configured to use a cryptographic signature-based authorization
> > string that the BIOS will use to verify authorization to modify the
> > setting.
> >
> > Linux Security components are under development and not published yet.
> > The only linux component is the driver (hp bioscfg) at this time.
> > Other published security components are under Windows.
> >
> > Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> >
> > ---
> > Based on the latest platform-drivers-x86.git/for-next
> > ---
> >  .../x86/hp/hp-bioscfg/ordered-attributes.c    | 443 ++++++++++++++++++
> >  1 file changed, 443 insertions(+)
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/ordered-attribut=
es.c
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c b/=
drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
> > new file mode 100644

<snip>

> > +     strscpy(ordered_list_data->common.display_name_language_code,
> > +             LANG_CODE_STR,
> > +             sizeof(ordered_list_data->common.display_name_language_co=
de));
> > +
> > +     for (elem =3D 1, eloc =3D 1; elem < order_obj_count; elem++, eloc=
++) {
> > +             /* ONLY look at the first ORDERED_ELEM_CNT elements */
> > +             if (eloc =3D=3D ORD_ELEM_CNT)
> > +                     goto exit_list_package;
> > +
> > +             switch (order_obj[elem].type) {
> > +             case ACPI_TYPE_STRING:
> > +
>
> Extra newline.

Done!
>
> > +                     if (elem !=3D PREREQUISITES && elem !=3D ORD_LIST=
_ELEMENTS) {
> > +                             ret =3D convert_hexstr_to_str(order_obj[e=
lem].string.pointer,
> > +                                                         order_obj[ele=
m].string.length,
> > +                                                         &str_value, &=
value_len);
> > +                             if (ret)
> > +                                     continue;
> > +                     }
> > +                     break;
> > +             case ACPI_TYPE_INTEGER:
> > +                     int_value =3D (u32)order_obj[elem].integer.value;
> > +                     break;
> > +             default:
> > +                     pr_warn("Unsupported object type [%d]\n", order_o=
bj[elem].type);
> > +                     continue;
> > +             }
> > +
> > +             /* Check that both expected and read object type match */
> > +             if (expected_order_types[eloc] !=3D order_obj[elem].type)=
 {
> > +                     pr_err("Error expected type %d for elem  %d, but =
got type %d instead\n",
>
> Extra space before %d.
Done!
>
> > +                            expected_order_types[eloc], elem, order_ob=
j[elem].type);
> > +                     return -EIO;
> > +             }
> > +
<snip>
> > +                     kfree(tmpstr);
> > +                     break;
> > +             default:
> > +                     pr_warn("Invalid element: %d found in Ordered_Lis=
t attribute or data may be malformed\n", elem);
> > +                     break;
> > +             }
> > +             kfree(tmpstr);
> > +             kfree(str_value);
> > +     }
> > +
> > +exit_list_package:
> > +     kfree(tmpstr);
> > +     kfree(str_value);
> > +     return 0;
> > +}
>
> Looks double and triple frees in this function.

Done!
>
> After reading the about same things once again, I started to wonder if
> some of that switch content could be moved into a common helper (which
> takes e.g. the xx->common pointer as parameter and perhaps some other
> carefully selected pointers). There's a lots of duplication.
>

I will look into how the common data can be implemented with a helper.

> > +/**
> > + * populate_ordered_list_buffer_data() - Populate all properties of an
> > + * instance under ordered list attribute
> > + *
> > + * @buffer_ptr: Buffer pointer
> > + * @buffer_size: Buffer size
> > + * @instance_id: The instance to enumerate
> > + * @attr_name_kobj: The parent kernel object
> > + */
> > +int populate_ordered_list_buffer_data(u8 *buffer_ptr, u32 *buffer_size=
, int instance_id,
> > +                                   struct kobject *attr_name_kobj)
> > +{
> > +     struct ordered_list_data *ordered_list_data =3D &bioscfg_drv.orde=
red_list_data[instance_id];
> > +
> > +     ordered_list_data->attr_name_kobj =3D attr_name_kobj;
> > +
> > +     /* Populate ordered list elements */
> > +     populate_ordered_list_elements_from_buffer(buffer_ptr, buffer_siz=
e,
> > +                                                instance_id);
> > +     update_attribute_permissions(ordered_list_data->common.is_readonl=
y,
> > +                                  &ordered_list_current_val);
> > +     friendly_user_name_update(ordered_list_data->common.path,
> > +                               attr_name_kobj->name,
> > +                               ordered_list_data->common.display_name,
> > +                               sizeof(ordered_list_data->common.displa=
y_name));
> > +
> > +     return sysfs_create_group(attr_name_kobj, &ordered_list_attr_grou=
p);
> > +}
> > +
> > +int populate_ordered_list_elements_from_buffer(u8 *buffer_ptr, u32 *bu=
ffer_size,
> > +                                            int instance_id)
> > +{
> > +     int reqs;
> > +     int values;
> > +     struct ordered_list_data *ordered_list_data =3D &bioscfg_drv.orde=
red_list_data[instance_id];
> > +
> > +     strscpy(ordered_list_data->common.display_name_language_code,
> > +             LANG_CODE_STR,
> > +             sizeof(ordered_list_data->common.display_name_language_co=
de));
> > +
> > +     // VALUE:
> > +     get_string_from_buffer(&buffer_ptr, buffer_size, ordered_list_dat=
a->current_value,
> > +                            sizeof(ordered_list_data->current_value));
> > +
> > +     // PATH:
> > +     get_string_from_buffer(&buffer_ptr, buffer_size, ordered_list_dat=
a->common.path,
> > +                            sizeof(ordered_list_data->common.path));
> > +
> > +     // IS_READONLY:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &ordered_list_data->common.is_readonly);
> > +
> > +     //DISPLAY_IN_UI:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &ordered_list_data->common.display_in_ui)=
;
> > +
> > +     // REQUIRES_PHYSICAL_PRESENCE:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &ordered_list_data->common.requires_physi=
cal_presence);
> > +
> > +     // SEQUENCE:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &ordered_list_data->common.sequence);
> > +
> > +     // PREREQUISITES_SIZE:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &ordered_list_data->common.prerequisites_=
size);
> > +
> > +     if (ordered_list_data->common.prerequisites_size > MAX_PREREQUISI=
TES_SIZE) {
> > +             /* Report a message and limit prerequisite size to maximu=
m value */
> > +             pr_warn("String Prerequisites size value exceeded the max=
imum number of elements supported or data may be malformed\n");
> > +             ordered_list_data->common.prerequisites_size =3D MAX_PRER=
EQUISITES_SIZE;
> > +     }
> > +
> > +     // PREREQUISITES:
> > +     for (reqs =3D 0;
> > +          reqs < ordered_list_data->common.prerequisites_size && reqs =
< MAX_PREREQUISITES_SIZE;
> > +          reqs++)
> > +             get_string_from_buffer(&buffer_ptr, buffer_size,
> > +                                    ordered_list_data->common.prerequi=
sites[reqs],
> > +                                    sizeof(ordered_list_data->common.p=
rerequisites[reqs]));
> > +
> > +     // SECURITY_LEVEL:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &ordered_list_data->common.security_level=
);
> > +
> > +     // ORD_LIST_SIZE:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &ordered_list_data->elements_size);
> > +
> > +     if (ordered_list_data->elements_size > MAX_ELEMENTS_SIZE) {
> > +             /* Report a message and limit elements size to maximum va=
lue */
> > +             pr_warn("Ordered List size value exceeded the maximum num=
ber of elements supported or data may be malformed\n");
> > +             ordered_list_data->elements_size =3D MAX_ELEMENTS_SIZE;
> > +     }
> > +
> > +     // ORD_LIST_ELEMENTS:
> > +     for (values =3D 0; values < ordered_list_data->elements_size && v=
alues < MAX_ELEMENTS_SIZE;
> > +          values++)
> > +             get_string_from_buffer(&buffer_ptr, buffer_size,
> > +                                    ordered_list_data->elements[values=
],
> > +                                    sizeof(ordered_list_data->elements=
[values]));
> > +
> > +     return 0;
> > +}
>
> Same here. Pass buffer, buffer_size and common into a helper? Maybe some
> other parameters too to cover many/all of the cases?

I will investigate how I can use more helpers to minimize the duplication

>
> > +
> > +/**
> > + * exit_ordered_list_attributes() - Clear all attribute data
> > + *
> > + * Clears all data allocated for this group of attributes
> > + */
> > +void exit_ordered_list_attributes(void)
> > +{
> > +     int instance_id;
> > +
> > +     for (instance_id =3D 0; instance_id < bioscfg_drv.ordered_list_in=
stances_count;
> > +          instance_id++) {
> > +             struct kobject *attr_name_kobj =3D
> > +                     bioscfg_drv.ordered_list_data[instance_id].attr_n=
ame_kobj;
> > +
> > +             if (attr_name_kobj)
> > +                     sysfs_remove_group(attr_name_kobj,
> > +                                        &ordered_list_attr_group);
> > +     }
> > +     bioscfg_drv.ordered_list_instances_count =3D 0;
> > +
> > +     kfree(bioscfg_drv.ordered_list_data);
> > +     bioscfg_drv.ordered_list_data =3D NULL;
> > +}
> >
>
> --
>  i.
