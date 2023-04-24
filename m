Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E756ED62C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 22:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjDXUeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 16:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjDXUd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 16:33:59 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E125FCD;
        Mon, 24 Apr 2023 13:33:52 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4edcc885d8fso5397617e87.1;
        Mon, 24 Apr 2023 13:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682368430; x=1684960430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFPCEZd9kmAwp5VnaOiF8JVfnq6OYfJZmMphlHfmxIQ=;
        b=aaqYMk41OnWnGUUSRZAcnOZqDMNlrRzPUzknKgEmzQfr6s9l8CcOqfpQxkr3B6Cvha
         y7E+LxMU34AtS1D5Zkfv3tCXSzTO3vc0OmL+/WTdXkVgGlDWzcHy8GzcVN0/ySTpDvSt
         wEBCg/WRpGbgdfJsdQ9P+LPQqXDDPNNl22z8Ze4AhBS0rIyfKNNPlHn7bdIqjzsWfk/X
         qGQjYiNud3zDxbHC4SiUN56xYVpJcS+gGuTVzGRbebw5gCYWP/XweKYJzBvHrkMS9m09
         ezzemqIj9VfBPJxdjyE/Whng2FK1+/cwxQEyFQuiTNzKB6LTG4RtDIJ3EOeO6nrRi94X
         1DBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682368430; x=1684960430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFPCEZd9kmAwp5VnaOiF8JVfnq6OYfJZmMphlHfmxIQ=;
        b=koNI3oK0lmAq34aXSeGNzItsnm1RA+wQOfYIdlxr5HHN1LCDS3pd0rvNfgH9pXZmRf
         fNbS0bAOalbbojDyiHSiUYkWgDJr/dKZ9IbGV8svbqlfn3qW/DfDHyscLQcQRp7pG7dW
         dXHQSya3Xh/feQH2Gl7esjbx5gz8iveeLAqnKvfbWVZMCE3DpSuEHQaD2J3nVr42XffQ
         Ai0xQhY/NuafsWLL4vr8EFmtaU42gyoFikEQudt9MUCTMJf55FatTE44HWqOokjX2tbx
         NpA8n5qbsJJ0TGsVy+x01O8aw9WUyG1QBiCGnrJCelzAdrV22de6Iq3Imutkc5d9oA0G
         VZlQ==
X-Gm-Message-State: AAQBX9fQoNYWpCIyNRAkWBCuvXAMcPzxBDSszNQabdJDvSfOz0PpTkpQ
        NEHJRE4qgwvGBlzq1HCJuJJxUz7mYmI2aPH85DVW7A9BO9o=
X-Google-Smtp-Source: AKy350YPHX7wNKPUaa7JKCx5BXvXqiXPqftAmHhFcq/nDiGaw3peuIRzpFN5m/KGvrxnvb6S2t1FtaxTT8BQtts+/mA=
X-Received: by 2002:ac2:4204:0:b0:4ea:e296:fe9e with SMTP id
 y4-20020ac24204000000b004eae296fe9emr3523599lfh.9.1682368430271; Mon, 24 Apr
 2023 13:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-3-jorge.lopez2@hp.com>
 <b7c49593-13f9-44f8-b3b8-66551b01e966@t-8ch.de>
In-Reply-To: <b7c49593-13f9-44f8-b3b8-66551b01e966@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Mon, 24 Apr 2023 15:33:26 -0500
Message-ID: <CAOOmCE_MdHnPb250DDYC6Hoqutod2m=2voBqFz4g0dLcmJ5PRQ@mail.gmail.com>
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

Please see my comments below.

On Sat, Apr 22, 2023 at 4:30=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t-8ch=
.de> wrote:
>
> Hi Jorge,
>
> checkpatch.pl finds some issues on your patches.
> Please make sure checkpath.pl --strict is happy.
>
I wasn't aware of the '--strict' parameter.  It is not part of the
help information for checkpath.pl tool.
Nonetheless, I will use it forward.
Thanks


> On 2023-04-20 11:54:42-0500, Jorge Lopez wrote:
> > ---
> > Based on the latest platform-drivers-x86.git/for-next
> > ---
> >  .../x86/hp/hp-bioscfg/biosattr-interface.c    | 307 ++++++++++++++++++
> >  1 file changed, 307 insertions(+)
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/biosattr-interfa=
ce.c
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c b/=
drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
> > new file mode 100644
> > index 000000000000..f09dd41867f7
> > --- /dev/null
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
> > @@ -0,0 +1,307 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Functions corresponding to methods under BIOS interface GUID
> > + * for use with hp-bioscfg driver.
> > + *
> > + *  Copyright (c) 2022 Hewlett-Packard Inc.
> > + */
> > +
> > +#include <linux/wmi.h>
> > +#include "bioscfg.h"
> > +
> > +#define SET_DEFAULT_VALUES_METHOD_ID 0x02
> > +#define SET_BIOS_DEFAULTS_METHOD_ID  0x03
> > +#define SET_ATTRIBUTE_METHOD_ID              0x04
>
> This could be an enum.

Define lines are not in use.  They will be removed.
>
> > +
> > +/*
> > + * set_attribute() - Update an attribute value
> > + * @a_name: The attribute name
> > + * @a_value: The attribute value
> > + *
> > + * Sets an attribute to new value
> > + */
> > +int hp_set_attribute(const char *a_name, const char *a_value)
> > +{
> > +     size_t security_area_size;
> > +     size_t a_name_size, a_value_size;
> > +     u16 *buffer =3D NULL;
> > +     u16 *start =3D NULL;
> > +     int  buffer_size;
> > +     int ret =3D 0;
> > +     int instance;
> > +     char *auth_empty_value =3D "";
> > +     char *auth_token_choice =3D NULL;
>
> No need to initialize auth_token_choice and start.
> Consider coalescing variable declaration to avoid wasting vertical
> space.
>
Done!

> > +
> > +
> > +     mutex_lock(&bioscfg_drv.mutex);
> > +     if (!bioscfg_drv.bios_attr_wdev) {
> > +             ret =3D -ENODEV;
> > +             goto out_set_attribute;
> > +     }
> > +
> > +     instance =3D get_password_instance_for_type(SETUP_PASSWD);
> > +     if (instance < 0) {
> > +             ret =3D -EINVAL;
> > +             goto out_set_attribute;
> > +     }
> > +
> > +     if (strlen(bioscfg_drv.password_data[instance].current_password) =
=3D=3D 0)
> > +             strscpy(bioscfg_drv.password_data[instance].current_passw=
ord,
> > +                     auth_empty_value,
> > +                     sizeof(bioscfg_drv.password_data[instance].curren=
t_password));
>
> This essentially does
>
> if (current_password[0] =3D=3D '\0')
>         current_password[0] =3D '\0';
>
> ... nothing.
>
The statement was intended as part of early testing and failed to
remove it during cleanup.
It will be removed.

>
> In the driver there is a lot of dereferencing substructures of
> bioscfg_drv going on. This makes the code harder to read.
>
> > +
> > +     /* Select which auth token to use; password or [auth token] */
> > +
> > +     if (bioscfg_drv.spm_data.auth_token !=3D NULL)
> > +             auth_token_choice =3D bioscfg_drv.spm_data.auth_token;
> > +     else
> > +             auth_token_choice =3D bioscfg_drv.password_data[instance]=
.current_password;
> > +
> > +     a_name_size =3D bioscfg_calculate_string_buffer(a_name);
> > +     a_value_size =3D bioscfg_calculate_string_buffer(a_value);
> > +     security_area_size =3D calculate_security_buffer(auth_token_choic=
e);
> > +     buffer_size =3D a_name_size + a_value_size + security_area_size;
> > +
> > +     buffer =3D kmalloc(buffer_size + 1, GFP_KERNEL);
> > +     if (!buffer) {
> > +             ret =3D -ENOMEM;
> > +             goto out_set_attribute;
> > +     }
> > +
> > +     /* build variables to set */
> > +     start =3D buffer;
> > +     start =3D ascii_to_utf16_unicode(start, a_name);
> > +     if (!start)
> > +             goto out_set_attribute;
>
> ret is 0 here. Is this success?
>
> > +
> > +     start =3D ascii_to_utf16_unicode(start, a_value);
> > +     if (!start)
> > +             goto out_set_attribute;
>
> Same as above.

These conditions are not successful. ret value will be reset to
indicate the appropriate failure.
>
> > +
> > +     populate_security_buffer(start, auth_token_choice);
> > +
> > +     ret =3D hp_wmi_set_bios_setting(buffer, buffer_size);
> > +
> > +
> > +out_set_attribute:
> > +     kfree(buffer);
> > +     mutex_unlock(&bioscfg_drv.mutex);
> > +     return ret;
> > +}
> > +
> > +/*
> > + * hp_wmi_perform_query
> > + *
> > + * query:    The commandtype (enum hp_wmi_commandtype)
> > + * write:    The command (enum hp_wmi_command)
> > + * buffer:   Buffer used as input and/or output
> > + * insize:   Size of input buffer
> > + * outsize:  Size of output buffer
> > + *
> > + * returns zero on success
> > + *         an HP WMI query specific error code (which is positive)
> > + *         -EINVAL if the query was not successful at all
> > + *         -EINVAL if the output buffer size exceeds buffersize
>
> How is the caller supposed to distinguish those?
This is a piece of legacy code from early development.  'ret' value is
set to -EIO and the line 98 will read

" -EIO if the output buffer size exceeds buffersize "

>
> > + *
> > + * Note: The buffersize must at least be the maximum of the input and =
output
> > + *       size. E.g. Battery info query is defined to have 1 byte input
> > + *       and 128 byte output. The caller would do:
> > + *       buffer =3D kzalloc(128, GFP_KERNEL);
> > + *       ret =3D hp_wmi_perform_query(HPWMI_BATTERY_QUERY, HPWMI_READ,
> > + *                               buffer, 1, 128)
> > + */
> > +int hp_wmi_perform_query(int query, enum hp_wmi_command command, void =
*buffer,
> > +                      int insize, int outsize)
>
> Can insize and outsize ever be negative?
> Maybe use u32 or size_t.

The values are positive but there is no check in the event a negative
value is passed.
I will use u32 instead as precaution.

>
> > +{
> > +     struct acpi_buffer input, output =3D { ACPI_ALLOCATE_BUFFER, NULL=
 };
> > +     struct bios_return *bios_return;
> > +     union acpi_object *obj =3D NULL;
> > +     struct bios_args *args =3D NULL;
> > +     int mid, actual_outsize;
> > +     size_t bios_args_size;
> > +     int ret;
> > +
> > +     mid =3D encode_outsize_for_pvsz(outsize);
> > +     if (WARN_ON(mid < 0))
> > +             return mid;
> > +
> > +     bios_args_size =3D struct_size(args, data, insize);
> > +     args =3D kmalloc(bios_args_size, GFP_KERNEL);
> > +     if (!args)
> > +             return -ENOMEM;
> > +
> > +     input.length =3D bios_args_size;
> > +     input.pointer =3D args;
> > +
> > +     args->signature =3D 0x55434553;
>
> What does this number mean?
This is a HEX representation of the word  'SECU' expected by BIOS as a sign=
a.

>
> > +     args->command =3D command;
> > +     args->commandtype =3D query;
> > +     args->datasize =3D insize;
> > +     memcpy(args->data, buffer, flex_array_size(args, data, insize));
> > +
> > +     ret =3D wmi_evaluate_method(HP_WMI_BIOS_GUID, 0, mid, &input, &ou=
tput);
>
> The driver is mixing calls to the UUID based APIs and the wmi_device
> ones.
> wmi_devices is newer and preferred.

The driver  calls wmi_evaluate_method when initiating an WMI call.
Where is the driver mixing calls to the UUID based APIs and the
wmi_device one?
WMI calls are made by calling hp_wmi_perform_query() which invokes
wmi_evaluate_method().
Did I miss something?

>
> > +     bioscfg_wmi_error_and_message(ret);
> > +
> > +     if (ret)
> > +             goto out_free;
> > +
> > +     obj =3D output.pointer;
> > +     if (!obj) {
> > +             ret =3D -EINVAL;
> > +             goto out_free;
> > +     }
> > +     if (query !=3D HPWMI_SECUREPLATFORM_GET_STATE &&
> > +         command !=3D HPWMI_SECUREPLATFORM)
> > +             if (obj->type !=3D ACPI_TYPE_BUFFER ||
> > +                 obj->buffer.length < sizeof(*bios_return)) {
> > +                     pr_warn("query 0x%x returned wrong type or too sm=
all buffer\n", query);
> > +                     ret =3D -EINVAL;
> > +                     goto out_free;
> > +             }
> > +
> > +
> > +     bios_return =3D (struct bios_return *)obj->buffer.pointer;
>
> For query =3D=3D HPWMI_SECUREPLATFORM_GET_STATE && command =3D=3D HPWMI_S=
ECUREPLATFORM
> this is not guaranteed to be a buffer.

BIOS ensures the output is of buffer type and  buffer of 1024 bytes in
size.  This check also help us validate that BIOS only returns a
buffer type for this query/command type.
>
> > +     ret =3D bios_return->return_code;
> > +     bioscfg_wmi_error_and_message(ret);
> > +
> > +     if (ret) {
> > +             if (ret !=3D HPWMI_RET_UNKNOWN_COMMAND &&
> > +                 ret !=3D HPWMI_RET_UNKNOWN_CMDTYPE)
> > +                     pr_warn("query 0x%x returned error 0x%x\n", query=
, ret);
> > +             goto out_free;
> > +     }
> > +
> > +     /* Ignore output data of zero size */
> > +     if (!outsize)
> > +             goto out_free;
> > +
> > +     actual_outsize =3D min(outsize, (int)(obj->buffer.length - sizeof=
(*bios_return)));
>
> actual_outsize could be negative, which will underflow in the call to
> memcpy().

I will evaluate the two size values prior calling memcpy and report an
error if needed.
>
> > +     memcpy(buffer, obj->buffer.pointer + sizeof(*bios_return), actual=
_outsize);
> > +     memset(buffer + actual_outsize, 0, outsize - actual_outsize);
>
> memcpy_and_pad()
>
I will replace the two calls with the single proposed memcpy_and_pad call.

> > +
> > +out_free:
> > +     kfree(obj);
> > +     kfree(args);
> > +     return ret;
> > +}
> > +
> > +static void *utf16_empty_string(u16 *p)
> > +{
> > +     *p++ =3D 2;
> > +     *p++ =3D (u8)0x00;
> > +     return p;
> > +}
> > +
> > +/*
> > + * ascii_to_utf16_unicode -  Convert ascii string to UTF-16 unicode
> > + *
> > + * BIOS supports UTF-16 characters that are 2 bytes long.  No variable
> > + * multi-byte language supported.
> > + *
> > + * @p:   Unicode buffer address
> > + * @str: string to convert to unicode
> > + *
> > + * Returns a void pointer to the buffer containing unicode string
>
> This returns a pointer to the end of the written string.

Done
>
> > + */
> > +void *ascii_to_utf16_unicode(u16 *p, const u8 *str)
> > +{
> > +     int len =3D strlen(str);
> > +     int ret;
> > +
> > +     /*
> > +      * Add null character when reading an empty string
> > +      * "02 00 00 00"
> > +      */
> > +     if (len =3D=3D 0)
> > +             return utf16_empty_string(p);
> > +
> > +     /* Move pointer len * 2 number of bytes */
> > +     *p++ =3D len * 2;
> > +     ret =3D utf8s_to_utf16s(str, strlen(str), UTF16_HOST_ENDIAN, p, l=
en);
> > +     if (ret < 0) {
> > +             dev_err(bioscfg_drv.class_dev, "UTF16 conversion failed\n=
");
> > +             goto ascii_to_utf16_unicode_out;
> > +     }
>
> What if ret !=3D len ?

only in conditions where utf8s_to_utf16s an error, we can state  ret !=3D l=
en.
ret =3D=3D len when utf8s_to_utf16s() is successful.
>
> > +
> > +     if ((ret * sizeof(u16)) > U16_MAX) {
> > +             dev_err(bioscfg_drv.class_dev, "Error string too long\n")=
;
> > +             goto ascii_to_utf16_unicode_out;
> > +     }
> > +
> > +ascii_to_utf16_unicode_out:
> > +     p +=3D len;
>
> In cases of errors this will still point to the end of the data that
> should have been written but was not actually written.
> The caller has no way to recognize the error case.
>
That is correct.  If an error occurs, we only provide an error message
for those conditions.

> > +     return p;
> > +}
> > +
> > +/*
>
> kernel-doc comments start with "/**". Note the two asterisks.
Done
>
> > + * hp_wmi_set_bios_setting - Set setting's value in BIOS
> > + *
> > + * @input_buffer: Input buffer address
> > + * @input_size:   Input buffer size
> > + *
> > + * Returns: Count of unicode characters written to BIOS if successful,=
 otherwise
> > + *           -ENOMEM unable to allocate memory
> > + *           -EINVAL buffer not allocated or too small
> > + */
> > +int hp_wmi_set_bios_setting(u16 *input_buffer, u32 input_size)
> > +{
> > +     union acpi_object *obj;
> > +     struct acpi_buffer input =3D {input_size, input_buffer};
> > +     struct acpi_buffer output =3D {ACPI_ALLOCATE_BUFFER, NULL};
> > +     int ret =3D 0;
>
> No need to initialize "ret".
Done!
>
> > +
> > +     ret =3D wmi_evaluate_method(HP_WMI_SET_BIOS_SETTING_GUID, 0, 1, &=
input, &output);
> > +
> > +     obj =3D output.pointer;
> > +     if (!obj)
> > +             return -EINVAL;
>
> This skips the bioscfg_wmi_error_and_message call.
done!
>
> > +
> > +     if (obj->type !=3D ACPI_TYPE_INTEGER)
> > +             ret =3D -EINVAL;
> > +
> > +     ret =3D obj->integer.value;
>
> This overwrites the "ret =3D -EINVAL" from above.
> Add an "else" branch.

done!
>
> > +     bioscfg_wmi_error_and_message(ret);
> > +
> > +     kfree(obj);
> > +     return ret;
> > +}
> > +
> > +static int bios_attr_set_interface_probe(struct wmi_device *wdev, cons=
t void *context)
> > +{
> > +     mutex_lock(&bioscfg_drv.mutex);
> > +     bioscfg_drv.bios_attr_wdev =3D wdev;
> > +     mutex_unlock(&bioscfg_drv.mutex);
> > +     return 0;
> > +}
>
> Technically a WMI UUID can be present multiple times.
> This would lead to the driver being loaded multiple times, each driver
> clobbering the bios_attr_wdev of the other drivers.
>
> Maybe check the pointer and return -EEXIST.
>
> This applies to all subdrivers.

Done!
>
> > +
> > +static void bios_attr_set_interface_remove(struct wmi_device *wdev)
> > +{
> > +     mutex_lock(&bioscfg_drv.mutex);
> > +     bioscfg_drv.bios_attr_wdev =3D NULL;
> > +     mutex_unlock(&bioscfg_drv.mutex);
> > +}
> > +
> > +static const struct wmi_device_id bios_attr_set_interface_id_table[] =
=3D {
> > +     { .guid_string =3D HP_WMI_BIOS_GUID},
> > +     { }
> > +};
> > +static struct wmi_driver bios_attr_set_interface_driver =3D {
> > +     .driver =3D {
> > +             .name =3D DRIVER_NAME
> > +     },
> > +     .probe =3D bios_attr_set_interface_probe,
> > +     .remove =3D bios_attr_set_interface_remove,
> > +     .id_table =3D bios_attr_set_interface_id_table
>
> Put a comma here and above after DRIVER_NAME to reduce future diffs.

Done!
>
> > +};
> > +
> > +int init_bios_attr_set_interface(void)
> > +{
> > +     return wmi_driver_register(&bios_attr_set_interface_driver);
> > +}
> > +
> > +void exit_bios_attr_set_interface(void)
> > +{
> > +     wmi_driver_unregister(&bios_attr_set_interface_driver);
> > +}
> > +
> > +MODULE_DEVICE_TABLE(wmi, bios_attr_set_interface_id_table);
