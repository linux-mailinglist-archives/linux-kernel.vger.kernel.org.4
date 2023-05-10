Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E206FE52E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbjEJUgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbjEJUgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:36:18 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015D14C16;
        Wed, 10 May 2023 13:36:16 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ecb137af7eso8744925e87.2;
        Wed, 10 May 2023 13:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683750975; x=1686342975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTuiC0ua1kIyWi3iheh/3XF1H10GgI50sRM4ZeY/JDg=;
        b=EtKP6OM3eAtq9L7LIAH4ZD/qwUKVCv5RUrIRvLK65LqgYDQJ6DIMmcbScvI2ybkfR9
         18LS2Nw6eltSEzL0eos7uwew0qWPitrbQXlkjWZl904zhOl/df/DIPQIttpiz9i3ZTnt
         m7f5lUnwmvpGSmFUq0zZExX6Vd4fVH/u78WB1mN8bT4RjYxPfUkGatD5Wvg+4XKPvmdk
         GRLqI86DTahAPl4Vzs3OUAV2gimPQHpT8ICd/K0gXkTJBRtyzrthi0FMgfO6s/oTK7zz
         LkgGpvSv2YNiXM2Wm2HWrgDzBpZ9eL3iqTC5xwsELAU+lLW2ilBzua/Y/jSMNxWXpAAc
         VqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683750975; x=1686342975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTuiC0ua1kIyWi3iheh/3XF1H10GgI50sRM4ZeY/JDg=;
        b=Qt07KTOBAGuy5nb0+tjY3ExYGE1CgdFG2TGaW84Sik0hIpO5q4Qmkzz8WzMehlUqhA
         VBsLhOmv9NJpA+MOa5uwg7clPna2vfjubl/7X6742tAKG1dWiC8YmxzAVzBRuNw2MVJI
         P+ub5ChNlJ79QJRzNLOm4F8sd5EXSQjsNeDQLHlIFH4dc67134Fk5jTBPBDXyMc1QBm8
         Qm6bcwvPHliRXRlWvT3lg05PGP3DKMG2ALTYl/BGV/C0P62poRJsqzYc2ahNIcBwjBB/
         5Zbjh5l6mWtaJMU5dStr5v3hGjNQ+OyDPRgtl5FrCCjDZMULKTC2WSd5l02X4o7ztjbQ
         4Yjg==
X-Gm-Message-State: AC+VfDxFjgtgFgCdM+ktwRaMcaTPSv7u3hfZCzcpw6f4//SnOjgVcMDC
        4FabcQFhRVx5WBi2357jTDPnw7PhdLhViNfhq4A=
X-Google-Smtp-Source: ACHHUZ6XwOgg2hOQrhsiKgXYmI4nlnr6sziZ4fx8HXWKtAVY1Ab24dU/Ti/UlzfzD1I/LMXTVTjEbTw8wNk4pP3FDwE=
X-Received: by 2002:a2e:9c18:0:b0:2ad:bedc:995b with SMTP id
 s24-20020a2e9c18000000b002adbedc995bmr218134lji.16.1683750975077; Wed, 10 May
 2023 13:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-8-jorge.lopez2@hp.com>
 <882cc771-7fdb-5ba6-b4ae-36e7d3ad920@linux.intel.com>
In-Reply-To: <882cc771-7fdb-5ba6-b4ae-36e7d3ad920@linux.intel.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Wed, 10 May 2023 15:35:46 -0500
Message-ID: <CAOOmCE8ZS8uzt8UCeSCkxCeL+x4Wkqsyx0v6yOK8dkSbFpTDLQ@mail.gmail.com>
Subject: Re: [PATCH v12 07/13] HP BIOSCFG driver - string-attributes
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

On Tue, May 9, 2023 at 8:18=E2=80=AFAM Ilpo J=C3=A4rvinen
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
> >  .../x86/hp/hp-bioscfg/string-attributes.c     | 415 ++++++++++++++++++
> >  1 file changed, 415 insertions(+)
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/string-attribute=
s.c
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c b/d=
rivers/platform/x86/hp/hp-bioscfg/string-attributes.c
> > new file mode 100644
> > index 000000000000..d74ecc973703
> > --- /dev/null

<snip>

> > +static void update_string_value(int instance_id, char *attr_value)
> > +{
> > +     struct string_data *string_data =3D &bioscfg_drv.string_data[inst=
ance_id];
> > +
> > +     /* Write settings to BIOS */
> > +     strscpy(string_data->current_value,
> > +             attr_value,
> > +             sizeof(string_data->current_value));
>
> Use less lines.

Done!
>
> > +}
> > +
> > +ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name_language_code, string);
> > +static struct kobj_attribute string_display_langcode =3D
> > +     __ATTR_RO(display_name_language_code);
> > +
> > +ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name, string);
> > +static struct kobj_attribute string_display_name =3D
> > +     __ATTR_RO(display_name);
> > +
> > +ATTRIBUTE_PROPERTY_STORE(current_value, string);
> > +static struct kobj_attribute string_current_val =3D
> > +     __ATTR_RW_MODE(current_value, 0644);
> > +
> > +ATTRIBUTE_N_PROPERTY_SHOW(min_length, string);
> > +static struct kobj_attribute string_min_length =3D
> > +     __ATTR_RO(min_length);
> > +
> > +ATTRIBUTE_N_PROPERTY_SHOW(max_length, string);
> > +static struct kobj_attribute string_max_length =3D
> > +     __ATTR_RO(max_length);
> > +
> > +static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *=
attr,
> > +                      char *buf)
> > +{
> > +     return sysfs_emit(buf, "string\n");
> > +}
> > +
> > +static struct kobj_attribute string_type =3D
> > +     __ATTR_RO(type);
> > +
> > +static struct attribute *string_attrs[] =3D {
> > +     &string_display_langcode.attr,
> > +     &string_display_name.attr,
> > +     &string_current_val.attr,
> > +     &string_min_length.attr,
> > +     &string_max_length.attr,
> > +     &string_type.attr,
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group string_attr_group =3D {
> > +     .attrs =3D string_attrs,
> > +};
> > +
> > +int alloc_string_data(void)
> > +{
> > +     bioscfg_drv.string_instances_count =3D get_instance_count(HP_WMI_=
BIOS_STRING_GUID);
> > +     bioscfg_drv.string_data =3D kcalloc(bioscfg_drv.string_instances_=
count,
> > +                                       sizeof(struct string_data), GFP=
_KERNEL);
>
> sizeof(*bioscfg_drv.string_data) ?

Done!

>
> > +     if (!bioscfg_drv.string_data) {
> > +             bioscfg_drv.string_instances_count =3D 0;
> > +             return -ENOMEM;
> > +     }
> > +     return 0;
> > +}

<snip>

> > +
