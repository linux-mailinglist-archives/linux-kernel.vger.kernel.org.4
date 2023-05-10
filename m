Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A7A6FE67F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 23:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbjEJV4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 17:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjEJV4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 17:56:49 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDADDB;
        Wed, 10 May 2023 14:56:46 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f22908a082so5734757e87.1;
        Wed, 10 May 2023 14:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683755805; x=1686347805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWJ+ftMhyGsytGMKQ7lp/rN3me1y8hdBPTMZiVFJYAs=;
        b=dtAtvqEk+h3nDj4lvjRJInsjJaa53WKqjJSNP05SoUycLverqk1h30xs+u6ZUzXk5h
         IavxXynb0UtNNIDo7Lv2UTN9XrXAk3qNq4bfq7iOf9u5dgByEoIUznKf+OwvWaUVBqX0
         xsiiyYe5FqmYACWqFmKb4HyZCfzAQxJt16WS638wrXNVog2m2icQ93aM0n7cWBiDbE8T
         dBOxLMIb2upy3K2cTLRpWAbgV1nKAHaaSEXLy6/8/rWRZj9K5v2/bzPFWjvaL1mDRWoR
         E4Th7efCrIdCOPZWgAZXl96hJiDyYKz13z117f+vsRLzzF+UelBrM4PTez7xBP0wIt0n
         +glA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683755805; x=1686347805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWJ+ftMhyGsytGMKQ7lp/rN3me1y8hdBPTMZiVFJYAs=;
        b=KWBDWuDMgy79mkXmnQxi7at67McvyPmxXmeHYwsuP2LT6VpJKvlA7XRcPFzelRWAh3
         7kyOY4w/VeAipZWaNxRvKXzuMYklrimmUwYwfk1rdgtDlQhI3pRs3ioQe9U4Nl4iPUI6
         41GAJLwVDl9vO+QHJNaeGMJn3UHv0vm9kkMUuhaGZ+FLISXwmENZ95nd44HVQFyG4JcB
         tkOvGcAFKJQwRoi6u4LPRlnWbhT4l4niTHAEoIkLaGWAbXV5W5nrfgQgXmP9XFLWREbK
         q8KTXoYHbloQEr7cQQ/lI/GUktZRl7yWKBqtF8GRO7zoQ11wIMzwNiT//u9OJxxcRDr8
         z4cg==
X-Gm-Message-State: AC+VfDxarf2tZkAEd2Fp0iwFh1k2l1gr2V/k0vN+cNLtM/QKe+3hridH
        oiVxjNUF/Rfsh4ZCEFgbskUPfB8lXE1dEVJ9pCYyZMmj
X-Google-Smtp-Source: ACHHUZ4FXJ+5/po1Kwtnjc+SWJVQvHnkyUi1+oxI3Vu5JsKBjAUyj3yjt3HkynAWen+yNYq4KkUUXP9L1hB1RlvjfIw=
X-Received: by 2002:a2e:9496:0:b0:2a7:9884:ad53 with SMTP id
 c22-20020a2e9496000000b002a79884ad53mr2315798ljh.48.1683755804403; Wed, 10
 May 2023 14:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-11-jorge.lopez2@hp.com>
 <4537f210-4a7a-3c11-ecbb-ed4762a1f598@linux.intel.com>
In-Reply-To: <4537f210-4a7a-3c11-ecbb-ed4762a1f598@linux.intel.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Wed, 10 May 2023 16:56:15 -0500
Message-ID: <CAOOmCE9m5++_4nBu3C64uWVOeyUQs3afn_Q9AJz9oudGvMHHiQ@mail.gmail.com>
Subject: Re: [PATCH v12 10/13] HP BIOSCFG driver - spmobj-attributes
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

On Tue, May 9, 2023 at 8:48=E2=80=AFAM Ilpo J=C3=A4rvinen
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
> >  .../x86/hp/hp-bioscfg/spmobj-attributes.c     | 381 ++++++++++++++++++
> >  1 file changed, 381 insertions(+)
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/spmobj-attribute=
s.c
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c b/d=
rivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> > new file mode 100644
> > index 000000000000..f08f7aae9423
> > --- /dev/null
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> > @@ -0,0 +1,381 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Functions corresponding to secure platform management object type
> > + * attributes under BIOS PASSWORD for use with hp-bioscfg driver
> > + *
> > + *  Copyright (c) 2022 HP Development Company, L.P.
> > + */
> > +
> > +#include "bioscfg.h"
> > +
> > +static const char * const spm_state_types[] =3D {
> > +     "not provisioned",
> > +     "provisioned",
> > +     "provisioning in progress",
> > +};
> > +
> > +static const char * const spm_mechanism_types[] =3D {
> > +     "not provisioned",
> > +     "signing-key",
> > +     "endorsement-key",
> > +};
> > +
> > +struct secureplatform_provisioning_data {
> > +     u8 state;
> > +     u8 version[2];
> > +     u8 reserved1;
> > +     u32 features;
> > +     u32 nonce;
> > +     u8 reserved2[28];
> > +     u8 sk_mod[MAX_KEY_MOD];
> > +     u8 kek_mod[MAX_KEY_MOD];
> > +};
> > +
> > +int check_spm_is_enabled(void)
> > +{
> > +     /* do we need to check the admin password is also configured */
> > +     return bioscfg_drv.spm_data.is_enabled;
> > +}
> > +
> > +/**
> > + * calculate_security_buffer() - determines size of security buffer
> > + * for authentication scheme
> > + *
> > + * @authentication: the authentication content
> > + *
> > + * Currently only supported type is Admin password
> > + */
> > +size_t calculate_security_buffer(const char *authentication)
> > +{
> > +     int size;
>
> Why not size_t?

Done!
>
> > +
> > +     if (authentication && strlen(authentication) > 0) {
> > +             size =3D sizeof(u16) + (strlen(authentication) * sizeof(u=
16));
>
> Extra parenthesis.
Done!
>
> > +             if (!strstarts(authentication, BEAM_PREFIX))
> > +                     size +=3D strlen(UTF_PREFIX) * sizeof(u16);
> > +
> > +             return size;
> > +     }
> > +
> > +     size  =3D sizeof(u16) * 2;
>
> Extra space
>
> > +     return size;
>
> I'd do it this way though:
>
>         size_t size, authlen;
>
>         if (!authentication)
>                 return sizeof(u16) * 2;
>
>         authlen =3D strlen(authentication);
>         if (!authlen)
>                 return sizeof(u16) * 2;
>
>         size =3D sizeof(u16) + authlen * sizeof(u16);
>         ...
>
>

Done!
> > +}
> > +
> > +/**
> > + * populate_security_buffer() - builds a security buffer for
> > + * authentication scheme
> > + *
> > + * @buffer: the buffer to populate
> > + * @authentication: the authentication content
> > + *
> > + * Currently only supported type is PLAIN TEXT
> > + */
> > +int populate_security_buffer(u16 *buffer, const char *authentication)
> > +{
> > +     u16 *auth =3D buffer;
> > +     u16 *retbuffer;
> > +     char *strprefix =3D NULL;
> > +     int ret =3D 0;
> > +
> > +     if (strstarts(authentication, BEAM_PREFIX)) {
> > +             /*
> > +              * BEAM_PREFIX is append to buffer when a signature
> > +              * is provided and Sure Admin is enabled in BIOS
> > +              */
> > +             // BEAM_PREFIX found, convert part to unicode
> > +             retbuffer =3D hp_ascii_to_utf16_unicode(auth, authenticat=
ion);
> > +             if (!retbuffer) {
> > +                     ret =3D -EINVAL;
> > +                     goto out_buffer;
>
> return -EINVAL directly.

Done!
>
> > +             }
> > +             auth =3D retbuffer;
> > +
> > +     } else {
> > +             /*
> > +              * UTF-16 prefix is append to the * buffer when a BIOS
>
> What is "the * buffer" ?

It is the data stored in 'buffer' variable which is composed of three
strings concatenated together to be submitted to BIOS via WMI call.
'Buffer' will looks something as    [size attribute][attribute][size
value][value][auth size][auth payload]
size is the length in bytes,  attribute/value/auth are string represented i=
n u16
>
> > +              * admin password is configured in BIOS
> > +              */
> > +
> > +             // append UTF_PREFIX to part and then convert it to unico=
de
>
> Use /* */ comments consistently.

Done!
>
> > +             strprefix =3D kasprintf(GFP_KERNEL, "%s%s", UTF_PREFIX,
> > +                                   authentication);
> > +             if (!strprefix)
> > +                     goto out_buffer;
>
> Shouldn't you return an error code here? Also, strprefix is NULL so you
> can do return -ENOMEM directly.
>
> > +
> > +             retbuffer =3D hp_ascii_to_utf16_unicode(auth, strprefix);
>
> If you move kfree(strprefix) here, the flow is more obvious.

Done!
>
> > +             if (!retbuffer) {
> > +                     ret =3D -EINVAL;
> > +                     goto out_buffer;
> > +             }
> > +             auth =3D retbuffer;
> > +     }
> > +
> > +out_buffer:
> > +     kfree(strprefix);
> > +     return ret;
> > +}
> > +
> > +static ssize_t update_spm_state(void)
> > +{
> > +     int ret;
> > +     struct secureplatform_provisioning_data data;
> > +
> > +     ret =3D hp_wmi_perform_query(HPWMI_SECUREPLATFORM_GET_STATE,
> > +                                HPWMI_SECUREPLATFORM, &data, 0,
> > +                                sizeof(data));
> > +     if (ret < 0)
> > +             goto state_exit;
>
> return ret; directly.
Done!
>
> > +
> > +     bioscfg_drv.spm_data.mechanism =3D data.state;
> > +     if (bioscfg_drv.spm_data.mechanism)
> > +             bioscfg_drv.spm_data.is_enabled =3D 1;
> > +
> > +state_exit:
> > +     return ret;
>
> return 0;
Done!
>
> > +}
> > +
> > +static ssize_t statusbin(struct kobject *kobj,
> > +                      struct kobj_attribute *attr,
> > +                      struct secureplatform_provisioning_data *buf)
> > +{
> > +     int ret =3D hp_wmi_perform_query(HPWMI_SECUREPLATFORM_GET_STATE,
> > +                                    HPWMI_SECUREPLATFORM, buf, 0,
> > +                                    sizeof(struct secureplatform_provi=
sioning_data));
> > +
> > +     return ret < 0 ? ret : sizeof(struct secureplatform_provisioning_=
data);
>
> Split to:
>
>         int ret;
>
>         ret =3D hp_...();
>         if (ret < 0)
>                 return ret;
>
>         return sizeof(...);
>

Done!

> > +}
> > +
> > +/*
> > + * status_show - Reads SPM status
> > + */
> > +static ssize_t status_show(struct kobject *kobj, struct kobj_attribute
> > +                 *attr, char *buf)
> > +{
> > +     int ret, i;
> > +     struct secureplatform_provisioning_data data;
> > +
> > +     ret =3D statusbin(kobj, attr, &data);
> > +     if (ret < 0)
> > +             goto status_exit;
>
> Can you calculate strnlen() from buf at this point, or is the result
> garbage? Should you return ret instead here?

It should return the error instead.
>
> > +
> > +     sysfs_emit(buf, "%s{\n", buf);
> > +     sysfs_emit(buf, "%s\t\"State\": \"%s\",\n", buf,
> > +                spm_state_types[data.state]);
> > +     sysfs_emit(buf, "%s\t\"Version\": \"%d.%d\",\n", buf, data.versio=
n[0],
> > +                data.version[1]);
> > +
> > +     /*
> > +      * state =3D=3D 0 means secure platform management
> > +      * feature is not configured in BIOS.
> > +      */
> > +     if (data.state =3D=3D 0)
> > +             goto status_exit;
> > +
> > +     sysfs_emit(buf, "%s\t\"Nonce\": %d,\n", buf, data.nonce);
> > +     sysfs_emit(buf, "%s\t\"FeaturesInUse\": %d,\n", buf, data.feature=
s);
> > +     sysfs_emit(buf, "%s\t\"EndorsementKeyMod\": \"", buf);
> > +
> > +     for (i =3D 255; i >=3D 0; i--)
> > +             sysfs_emit(buf, "%s %u", buf, data.kek_mod[i]);
> > +
> > +     sysfs_emit(buf, "%s \",\n", buf);
> > +     sysfs_emit(buf, "%s\t\"SigningKeyMod\": \"", buf);
> > +
> > +     for (i =3D 255; i >=3D 0; i--)
> > +             sysfs_emit(buf, "%s %u", buf, data.sk_mod[i]);
> > +
> > +     /* Return buf contents */
> > +
> > +     sysfs_emit(buf, "%s \"\n", buf);
> > +     sysfs_emit(buf, "%s}\n", buf);
> > +
> > +status_exit:
> > +     return strnlen(buf, PAGE_SIZE);
> > +}
>
> Emit buf into buf? There's sysfs_emit_at(), however,
>
> while I'm far from sysfs formatting expert, this feels something that
> tries to expose more than one thing over same sysfs file. Shouldn't they
> be each in their own files?

This concern was brought up in earlier reviews but it was decided to
allow returning the information as a single json file.
Because the information is part of the same structure and received in
a single WMI call, separating the components into multiple files can
cause the data read in one field to be stale by the time is read.
>
> > +static struct kobj_attribute password_spm_status =3D __ATTR_RO(status)=
;
> > +
> > +ATTRIBUTE_SPM_N_PROPERTY_SHOW(is_enabled, spm);
> > +static struct kobj_attribute password_spm_is_key_enabled =3D __ATTR_RO=
(is_enabled);
> > +
> > +static ssize_t key_mechanism_show(struct kobject *kobj, struct kobj_at=
tribute *attr,
> > +                               char *buf)
> > +{
> > +     return sysfs_emit(buf, "%s\n",
> > +                       spm_mechanism_types[bioscfg_drv.spm_data.mechan=
ism]);
> > +}
> > +
> > +static struct kobj_attribute password_spm_key_mechanism =3D __ATTR_RO(=
key_mechanism);
> > +
> > +static ssize_t sk_store(struct kobject *kobj,
> > +                     struct kobj_attribute *attr,
> > +                     const char *buf, size_t count)
> > +{
> > +     int ret;
> > +     int length;
> > +
> > +     length =3D count;
> > +     if (buf[length - 1] =3D=3D '\n')
> > +             length--;
> > +
> > +     /* allocate space and copy current signing key */
> > +     bioscfg_drv.spm_data.signing_key =3D kmalloc(length, GFP_KERNEL);
> > +     if (!bioscfg_drv.spm_data.signing_key) {
> > +             ret =3D -ENOMEM;
> > +             goto exit_sk;
> > +     }
> > +
> > +     strscpy(bioscfg_drv.spm_data.signing_key, buf, length);
> > +     bioscfg_drv.spm_data.signing_key[length] =3D '\0';
> > +
> > +     /* submit signing key payload */
> > +     ret =3D hp_wmi_perform_query(HPWMI_SECUREPLATFORM_SET_SK,
> > +                                HPWMI_SECUREPLATFORM,
> > +                                (void *)bioscfg_drv.spm_data.signing_k=
ey,
> > +                                length, 0);
> > +
> > +     if (!ret) {
> > +             bioscfg_drv.spm_data.mechanism =3D SIGNING_KEY;
> > +             set_reboot_and_signal_event();
> > +     }
> > +
> > +exit_sk:
> > +     kfree(bioscfg_drv.spm_data.signing_key);
> > +     bioscfg_drv.spm_data.signing_key =3D NULL;
> > +
> > +     return ret ? ret : count;
> > +}
> > +
> > +static struct kobj_attribute password_spm_signing_key =3D __ATTR_WO(sk=
);
> > +
> > +static ssize_t kek_store(struct kobject *kobj,
> > +                      struct kobj_attribute *attr,
> > +                      const char *buf, size_t count)
> > +{
> > +     int ret;
> > +     int length;
> > +
> > +     length =3D count;
> > +     if (buf[length - 1] =3D=3D '\n')
> > +             length--;
> > +
> > +     /* allocate space and copy current signing key */
> > +     bioscfg_drv.spm_data.endorsement_key =3D kmalloc(length, GFP_KERN=
EL);
> > +     if (!bioscfg_drv.spm_data.endorsement_key) {
> > +             ret =3D -ENOMEM;
> > +             goto exit_kek;
>
> Return directly.
>
> > +     }
> > +
> > +     memcpy(bioscfg_drv.spm_data.endorsement_key, buf, length);
> > +     bioscfg_drv.spm_data.endorsement_key[length] =3D '\0';
> > +
> > +     ret =3D hp_wmi_perform_query(HPWMI_SECUREPLATFORM_SET_KEK,
> > +                                HPWMI_SECUREPLATFORM,
> > +                                (void *)bioscfg_drv.spm_data.endorseme=
nt_key,
>
> In general, casting to void * (and back) is not required.
Done!
>
> > +                                count, 0);
> > +
> > +     if (!ret) {
> > +             bioscfg_drv.spm_data.mechanism =3D ENDORSEMENT_KEY;
> > +             set_reboot_and_signal_event();
> > +     }
> > +
> > +exit_kek:
> > +     kfree(bioscfg_drv.spm_data.endorsement_key);
> > +     bioscfg_drv.spm_data.endorsement_key =3D NULL;
> > +
> > +     return ret ? ret : count;
> > +}
> > +
> > +static struct kobj_attribute password_spm_endorsement_key =3D __ATTR_W=
O(kek);
> > +
> > +static ssize_t role_show(struct kobject *kobj, struct kobj_attribute *=
attr,
> > +                      char *buf)
> > +{
> > +     return sysfs_emit(buf, "%s\n", BIOS_SPM);
> > +}
> > +
> > +static struct kobj_attribute password_spm_role =3D __ATTR_RO(role);
> > +
> > +static ssize_t auth_token_store(struct kobject *kobj,
> > +                             struct kobj_attribute *attr,
> > +                             const char *buf, size_t count)
> > +{
> > +     int ret =3D 0;
> > +     int length;
> > +
> > +     length =3D count;
> > +     if (buf[length - 1] =3D=3D '\n')
> > +             length--;
> > +
> > +     /* allocate space and copy current auth token */
> > +     bioscfg_drv.spm_data.auth_token =3D kmalloc(count, GFP_KERNEL);
> > +     if (!bioscfg_drv.spm_data.auth_token) {
> > +             ret =3D -ENOMEM;
> > +             goto exit_token;
>
> Return directly.

Done!
>
> > +     }
> > +

<snip>
