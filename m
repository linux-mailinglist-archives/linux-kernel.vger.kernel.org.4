Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B50A6BB550
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjCON4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjCON4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:56:21 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5791433450
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:56:12 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id o2so16999882vss.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678888571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9VkRl52vKFvSMTbHZvIzZYIkjIWZpYSDJH3lI7hgiM=;
        b=sicEmxUCcZ5hC71d6JIgdXIOMEFpC1gWIoxVJbyI2uK6YJbIMcb8WsFlAD235z29hc
         WXXWN92Z/x2jX0gNwbWQ/jnK9cBZ/xpMQEyXiYjlK/XCGFWJZyFaM75yJ3WRZuYIKbNy
         NQjB+xqJW5iC4Jpi8Xar3fNxjZpQeG69+i786UjiB5U50LaWTj4ZFb7l1k5tuVw8wq4Z
         buIUuSq6TZyny7bfsEwOHESnmKCe1rmhxc2sK6MQDy0hwG0godyf3fLoaMMS1BzWoDHT
         rJe8kiFfqpuEZ2SQm68gyweuqz+LKa+m3vb3/9Imf7azZ0CG33gQTALM8iixPqdFWnF6
         eDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678888571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9VkRl52vKFvSMTbHZvIzZYIkjIWZpYSDJH3lI7hgiM=;
        b=lt4c3IJVQOh6wLdazQ6VbI2dRsApqpcYM5TBd4sZFldLhfEMKwjJLn6CC3R+vWBtLF
         ce20ohyIui8VGXziLFZ5vXMUdVrH8gqRH+foZ6sLcaHg9aostUCGJ2NB5NtvqMkPjLUb
         00YHj7sXnLp9gizeIpqpZYTDJNmdNuNRVHkMrMRldQTvMyzeZjjLz2jCWbOKEJyVIGtz
         HfPyMBLvOCUmfrgvd6Ei/GCXOs6ncLYrNgHhUX1+NTSOQ6yHrkPRpYOYNTSk3ygGsEBK
         ZSIzKSvQSLp0iRNsVYEb0DHXK1i6M7pC8B9s0ObWA8mJMncxd+7Vu20/z8VgofYu1c8+
         cjIA==
X-Gm-Message-State: AO0yUKW74QZnGZIXq64CSRWz7CbHMjrwOspABfrQJ1p120v0+Uo/6nBn
        jx84lfoXbB2+7huWGjA6KIBkatiD2gygL/QO5ZdMQg==
X-Google-Smtp-Source: AK7set90eErg0/dQUjMT7KjsAsEiz3Bc14M73c5Zo+Ml+QbQ4hgEhLEHcd5FYpGO5f/hApGYOLOQIitv3heRMK7XOP0=
X-Received: by 2002:a67:cd06:0:b0:425:bfa9:eaf8 with SMTP id
 u6-20020a67cd06000000b00425bfa9eaf8mr1441491vsl.4.1678888571005; Wed, 15 Mar
 2023 06:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230309114319.v6.1.I8e7f9b01d9ac940507d78e15368e200a6a69bedb@changeid>
 <CAFA6WYP9Y0fG-2MeUC8rJcwYJodtLucaqeoDe4--fU0RyA8kFg@mail.gmail.com>
 <CA+ddPcNgkQZ5afwzNX=7nupBhLd0iK9smfCmGGeMtnCTXUcfqw@mail.gmail.com>
 <CAFA6WYPLzZcBKmFDfpnYydHxSZ0hL9fu6qfAxSYdFeLdjjMTjA@mail.gmail.com> <CA+ddPcNP_tL617q04zTHBiqW1qNoXz9QrpiGgx4mn8szTQaUTg@mail.gmail.com>
In-Reply-To: <CA+ddPcNP_tL617q04zTHBiqW1qNoXz9QrpiGgx4mn8szTQaUTg@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 15 Mar 2023 19:25:59 +0530
Message-ID: <CAFA6WYOoWgHUtikt4wt7WvEz3RWWaXCne8qUbvL52SJxhmo3CA@mail.gmail.com>
Subject: Re: [PATCH v6] tee: optee: Add SMC for loading OP-TEE image
To:     Jeffrey Kardatzke <jkardatzke@chromium.org>
Cc:     op-tee@lists.trustedfirmware.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 at 02:26, Jeffrey Kardatzke <jkardatzke@chromium.org> w=
rote:
>
> On Tue, Mar 14, 2023 at 5:41=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > On Mon, 13 Mar 2023 at 22:47, Jeffrey Kardatzke <jkardatzke@chromium.or=
g> wrote:
> > >
> > > On Mon, Mar 13, 2023 at 1:03=E2=80=AFAM Sumit Garg <sumit.garg@linaro=
.org> wrote:
> > > >
> > > > On Fri, 10 Mar 2023 at 01:13, Jeffrey Kardatzke <jkardatzke@chromiu=
m.org> wrote:
> > > > >
> > > > > Adds an SMC call that will pass an OP-TEE binary image to EL3 and
> > > > > instruct it to load it as the BL32 payload. This works in conjunc=
tion
> > > > > with a feature added to Trusted Firmware for ARMv8 and above
> > > > > architectures that supports this.
> > > > >
> > > > > The main purpose of this change is to facilitate updating the OP-=
TEE
> > > > > component on devices via a rootfs change rather than having to do=
 a
> > > > > firmware update. Further details are linked to in the Kconfig fil=
e.
> > > > >
> > > > > Signed-off-by: Jeffrey Kardatzke <jkardatzke@chromium.org>
> > > > > Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> > > > > ---
> > > > >
> > > > > Changes in v6:
> > > > > - Expanded Kconfig documentation
> > > > >
> > > > > Changes in v5:
> > > > > - Renamed config option
> > > > > - Added runtime warning when config is used
> > > > >
> > > > > Changes in v4:
> > > > > - Update commit message
> > > > > - Added more documentation
> > > > > - Renamed config option, added ARM64 dependency
> > > > >
> > > > > Changes in v3:
> > > > > - Removed state tracking for driver reload
> > > > > - Check UID of service to verify it needs image load
> > > > >
> > > > > Changes in v2:
> > > > > - Fixed compile issue when feature is disabled
> > > > > - Addressed minor comments
> > > > > - Added state tracking for driver reload
> > > > >
> > > > >  drivers/tee/optee/Kconfig     | 29 +++++++++++
> > > > >  drivers/tee/optee/optee_msg.h | 12 +++++
> > > > >  drivers/tee/optee/optee_smc.h | 24 +++++++++
> > > > >  drivers/tee/optee/smc_abi.c   | 97 +++++++++++++++++++++++++++++=
++++++
> > > > >  4 files changed, 162 insertions(+)
> > > > >
> > > > > diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfi=
g
> > > > > index f121c224e682..8d4836c58486 100644
> > > > > --- a/drivers/tee/optee/Kconfig
> > > > > +++ b/drivers/tee/optee/Kconfig
> > > > > @@ -7,3 +7,32 @@ config OPTEE
> > > > >         help
> > > > >           This implements the OP-TEE Trusted Execution Environmen=
t (TEE)
> > > > >           driver.
> > > > > +
> > > > > +config OPTEE_INSECURE_LOAD_IMAGE
> > > > > +       bool "Load OP-TEE image as firmware"
> > > > > +       default n
> > > > > +       depends on OPTEE && ARM64
> > > > > +       help
> > > > > +         This loads the BL32 image for OP-TEE as firmware when t=
he driver is
> > > > > +         probed. This returns -EPROBE_DEFER until the firmware i=
s loadable from
> > > > > +         the filesystem which is determined by checking the syst=
em_state until
> > > > > +         it is in SYSTEM_RUNNING. This also requires enabling th=
e corresponding
> > > > > +         option in Trusted Firmware for Arm. The documentation t=
here explains
> > > > > +         the security threat associated with enabling this as we=
ll as
> > > > > +         mitigations at the firmware and platform level.
> > > > > +         https://trustedfirmware-a.readthedocs.io/en/latest/thre=
at_model/threat_model.html
> > > > > +
> > > > > +         When utilizing this option, the following mitigations s=
hould be
> > > > > +         implemented to prevent attacks at the kernel level.
> > > > > +         1. There must be boot chain security that verifies the =
kernel and
> > > > > +            rootfs, otherwise an attacker can modify the loaded =
OP-TEE binary.
> > > > > +         2. It is recommended to build it as an included driver =
rather than
> > > > > +            a module to prevent exploits that may cause the modu=
le to not be
> > > > > +            loaded.
> > > > > +         3. If there are alternate methods of booting the device=
, such as a
> > > > > +            recovery mode, it should be ensured that the same mi=
tigations are
> > > > > +            applied in that mode.
> > > > > +         4. The OP-TEE driver must be loaded before any potentia=
l attack
> > > > > +            vectors are opened up. This should include mounting =
of any
> > > > > +            modifiable filesystems, opening of network ports or =
communicating
> > > > > +            with external devices (such a USB).
> > > >
> > > > This detailed threat model documentation belongs here [1] and it
> > > > should rather be in following format for every bullet point:
> > > >
> > > > Attack vector: <>
> > > > Mitigation: <>
> > > >
> > > > [1] https://docs.kernel.org/staging/tee.html?highlight=3Dtee#op-tee=
-driver
> > > >
> > >
> > > Done in v7 patch set.
> > >
> > > > > diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/op=
tee_msg.h
> > > > > index 70e9cc2ee96b..e8840a82b983 100644
> > > > > --- a/drivers/tee/optee/optee_msg.h
> > > > > +++ b/drivers/tee/optee/optee_msg.h
> > > > > @@ -241,11 +241,23 @@ struct optee_msg_arg {
> > > > >   * 384fb3e0-e7f8-11e3-af63-0002a5d5c51b.
> > > > >   * Represented in 4 32-bit words in OPTEE_MSG_UID_0, OPTEE_MSG_U=
ID_1,
> > > > >   * OPTEE_MSG_UID_2, OPTEE_MSG_UID_3.
> > > > > + *
> > > > > + * In the case where the OP-TEE image is loaded by the kernel, t=
his will
> > > > > + * initially return an alternate UID to reflect that we are comm=
unicating with
> > > > > + * the TF-A image loading service at that time instead of OP-TEE=
. That UID is:
> > > > > + * a3fbeab1-1246-315d-c7c4-06b9c03cbea4.
> > > > > + * Represented in 4 32-bit words in OPTEE_MSG_IMAGE_LOAD_UID_0,
> > > > > + * OPTEE_MSG_IMAGE_LOAD_UID_1, OPTEE_MSG_IMAGE_LOAD_UID_2,
> > > > > + * OPTEE_MSG_IMAGE_LOAD_UID_3.
> > > > >   */
> > > > >  #define OPTEE_MSG_UID_0                        0x384fb3e0
> > > > >  #define OPTEE_MSG_UID_1                        0xe7f811e3
> > > > >  #define OPTEE_MSG_UID_2                        0xaf630002
> > > > >  #define OPTEE_MSG_UID_3                        0xa5d5c51b
> > > > > +#define OPTEE_MSG_IMAGE_LOAD_UID_0     0xa3fbeab1
> > > > > +#define OPTEE_MSG_IMAGE_LOAD_UID_1     0x1246315d
> > > > > +#define OPTEE_MSG_IMAGE_LOAD_UID_2     0xc7c406b9
> > > > > +#define OPTEE_MSG_IMAGE_LOAD_UID_3     0xc03cbea4
> > > > >  #define OPTEE_MSG_FUNCID_CALLS_UID     0xFF01
> > > > >
> > > > >  /*
> > > > > diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/op=
tee_smc.h
> > > > > index 73b5e7760d10..7d9fa426505b 100644
> > > > > --- a/drivers/tee/optee/optee_smc.h
> > > > > +++ b/drivers/tee/optee/optee_smc.h
> > > > > @@ -104,6 +104,30 @@ struct optee_smc_call_get_os_revision_result=
 {
> > > > >         unsigned long reserved1;
> > > > >  };
> > > > >
> > > > > +/*
> > > > > + * Load Trusted OS from optee/tee.bin in the Linux firmware.
> > > > > + *
> > > > > + * WARNING: Use this cautiously as it could lead to insecure loa=
ding of the
> > > > > + * Trusted OS.
> > > > > + * This SMC instructs EL3 to load a binary and execute it as the=
 Trusted OS.
> > > > > + *
> > > > > + * Call register usage:
> > > > > + * a0 SMC Function ID, OPTEE_SMC_CALL_LOAD_IMAGE
> > > > > + * a1 Upper 32bit of a 64bit size for the payload
> > > > > + * a2 Lower 32bit of a 64bit size for the payload
> > > > > + * a3 Upper 32bit of the physical address for the payload
> > > > > + * a4 Lower 32bit of the physical address for the payload
> > > > > + *
> > > > > + * The payload is in the OP-TEE image format.
> > > > > + *
> > > > > + * Returns result in a0, 0 on success and an error code otherwis=
e.
> > > > > + */
> > > > > +#define OPTEE_SMC_FUNCID_LOAD_IMAGE 2
> > > > > +#define OPTEE_SMC_CALL_LOAD_IMAGE \
> > > > > +       ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32,=
 \
> > > > > +                          ARM_SMCCC_OWNER_TRUSTED_OS_END, \
> > > > > +                          OPTEE_SMC_FUNCID_LOAD_IMAGE)
> > > > > +
> > > > >  /*
> > > > >   * Call with struct optee_msg_arg as argument
> > > > >   *
> > > > > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_=
abi.c
> > > > > index a1c1fa1a9c28..00b6b69b6f79 100644
> > > > > --- a/drivers/tee/optee/smc_abi.c
> > > > > +++ b/drivers/tee/optee/smc_abi.c
> > > > > @@ -8,9 +8,11 @@
> > > > >
> > > > >  #include <linux/arm-smccc.h>
> > > > >  #include <linux/errno.h>
> > > > > +#include <linux/firmware.h>
> > > > >  #include <linux/interrupt.h>
> > > > >  #include <linux/io.h>
> > > > >  #include <linux/irqdomain.h>
> > > > > +#include <linux/kernel.h>
> > > > >  #include <linux/mm.h>
> > > > >  #include <linux/module.h>
> > > > >  #include <linux/of.h>
> > > > > @@ -1149,6 +1151,22 @@ static bool optee_msg_api_uid_is_optee_api=
(optee_invoke_fn *invoke_fn)
> > > > >         return false;
> > > > >  }
> > > > >
> > > > > +#ifdef CONFIG_OPTEE_INSECURE_LOAD_IMAGE
> > > > > +static bool optee_msg_api_uid_is_optee_image_load(optee_invoke_f=
n *invoke_fn)
> > > > > +{
> > > > > +       struct arm_smccc_res res;
> > > > > +
> > > > > +       invoke_fn(OPTEE_SMC_CALLS_UID, 0, 0, 0, 0, 0, 0, 0, &res)=
;
> > > > > +
> > > > > +       if (res.a0 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_0 &&
> > > > > +          res.a1 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_1 &&
> > > > > +          res.a2 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_2 &&
> > > > > +          res.a3 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_3)
> > > > > +               return true;
> > > > > +       return false;
> > > > > +}
> > > > > +#endif
> > > > > +
> > > > >  static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn=
)
> > > > >  {
> > > > >         union {
> > > > > @@ -1354,6 +1372,81 @@ static void optee_shutdown(struct platform=
_device *pdev)
> > > > >                 optee_disable_shm_cache(optee);
> > > > >  }
> > > > >
> > > > > +#ifdef CONFIG_OPTEE_INSECURE_LOAD_IMAGE
> > > > > +
> > > > > +#define OPTEE_FW_IMAGE "optee/tee.bin"
> > > > > +
> > > > > +static int optee_load_fw(struct platform_device *pdev,
> > > > > +                        optee_invoke_fn *invoke_fn)
> > > > > +{
> > > > > +       const struct firmware *fw =3D NULL;
> > > > > +       struct arm_smccc_res res;
> > > > > +       phys_addr_t data_pa;
> > > > > +       u8 *data_buf =3D NULL;
> > > > > +       u64 data_size;
> > > > > +       u32 data_pa_high, data_pa_low;
> > > > > +       u32 data_size_high, data_size_low;
> > > > > +       int rc;
> > > > > +
> > > > > +       if (!optee_msg_api_uid_is_optee_image_load(invoke_fn))
> > > > > +               return 0;
> > > > > +
> > > > > +       rc =3D request_firmware(&fw, OPTEE_FW_IMAGE, &pdev->dev);
> > > > > +       if (rc) {
> > > > > +               /*
> > > > > +                * The firmware in the rootfs will not be accessi=
ble until we
> > > > > +                * are in the SYSTEM_RUNNING state, so return EPR=
OBE_DEFER until
> > > > > +                * that point.
> > > > > +                */
> > > > > +               if (system_state < SYSTEM_RUNNING)
> > > > > +                       return -EPROBE_DEFER;
> > > > > +               goto fw_err;
> > > > > +       }
> > > > > +
> > > > > +       data_size =3D fw->size;
> > > > > +       /*
> > > > > +        * This uses the GFP_DMA flag to ensure we are allocated =
memory in the
> > > > > +        * 32-bit space since TF-A cannot map memory beyond the 3=
2-bit boundary.
> > > > > +        */
> > > > > +       data_buf =3D kmalloc(fw->size, GFP_KERNEL | GFP_DMA);
> > > > > +       if (!data_buf) {
> > > > > +               rc =3D -ENOMEM;
> > > > > +               goto fw_err;
> > > > > +       }
> > > > > +       memcpy(data_buf, fw->data, fw->size);
> > > > > +       data_pa =3D virt_to_phys(data_buf);
> > > > > +       reg_pair_from_64(&data_pa_high, &data_pa_low, data_pa);
> > > > > +       reg_pair_from_64(&data_size_high, &data_size_low, data_si=
ze);
> > > > > +       goto fw_load;
> > > > > +
> > > > > +fw_err:
> > > > > +       pr_warn("image loading failed\n");
> > > > > +       data_pa_high =3D data_pa_low =3D data_size_high =3D data_=
size_low =3D 0;
> > > > > +
> > > > > +fw_load:
> > > > > +       /*
> > > > > +        * Always invoke the SMC, even if loading the image fails=
, to indicate
> > > > > +        * to EL3 that we have passed the point where it should a=
llow invoking
> > > > > +        * this SMC.
> > > > > +        */
> > > > > +       pr_warn("OP-TEE image loaded from kernel, this can be ins=
ecure");
> > > > > +       invoke_fn(OPTEE_SMC_CALL_LOAD_IMAGE, data_size_high, data=
_size_low,
> > > > > +                 data_pa_high, data_pa_low, 0, 0, 0, &res);
> > > >
> > > > Apart from the security considerations discussed, I see an issue wi=
th
> > > > the implementation here. Here you only initialize OP-TEE on *CPUX*
> > > > that is performing OP-TEE probe. IIRC, it is required for that CPUX=
 to
> > > > be primary CPU0. How do we ensure that here?
> > >
> > > I'm not aware of any restrictions that require OP-TEE to be loaded on
> > > CPU0, do you have a point to something that indicates such a
> > > requirement? (it's always worked fine for me no matter what core it
> > > inits on)
> >
> > You can grep in OP-TEE OS code base for keywords like "primary" and
> > "secondary". This will give you an idea how initialization differs
> > among primary and secondary CPUs.
> Yes, I can see there are different things for "primary" vs.
> "secondary", but what I'm not seeing is anything that indicates that
> "primary" must be core 0 and not just the first CPU that boots into
> OP-TEE. Can you point me to anything that establishes that
> requirement?

On most platforms *cold boot* primary CPU is CPU0 and it's an implicit
assumption during boot it will do all the heavy lifting including
handling interrupts. However, at runtime you can always re-route
interrupts or threads and there won't be any difference among CPUs.

>
> >I would be interested to see the
> > OP-TEE init log (LOG_LEVEL =3D 4) when the primary CPU is *not* CPU0.
> > You can try to force that environment using taskset [1] while
> > installing the OP-TEE module as an out-of-tree build.
>
> OK, here's the log from booting up with that. I changed the log line
> for "Primary CPU initializing" to include the core #.
>
> D/TC:6   plat_get_aslr_seed:111 Warning: no ASLR seed
> D/TC:6   add_phys_mem:635 ROUNDDOWN(0x0C000000 + 0x400000,
> CORE_MMU_PGDIR_SIZE) type IO_SEC 0x0c400000 size 0x00200000
> D/TC:6   add_phys_mem:635 ROUNDDOWN(0x0C000000 + 0x0,
> CORE_MMU_PGDIR_SIZE) type IO_SEC 0x0c000000 size 0x00200000
> D/TC:6   add_phys_mem:635 ROUNDDOWN(0x11001100, CORE_MMU_PGDIR_SIZE)
> type IO_NSEC 0x11000000 size 0x00200000
> D/TC:6   add_phys_mem:635 TEE_SHMEM_START type NSEC_SHM 0x43c00000
> size 0x00200000
> D/TC:6   add_phys_mem:635 TA_RAM_START type TA_RAM 0x43400000 size 0x0080=
0000
> D/TC:6   add_phys_mem:635 VCORE_UNPG_RW_PA type TEE_RAM_RW 0x4325c000
> size 0x001a4000
> D/TC:6   add_phys_mem:635 VCORE_UNPG_RX_PA type TEE_RAM_RX 0x43200000
> size 0x0005c000
> D/TC:6   add_va_space:675 type RES_VASPACE size 0x00a00000
> D/TC:6   add_va_space:675 type SHM_VASPACE size 0x02000000
> D/TC:6   dump_mmap_table:800 type TEE_RAM_RX   va
> 0x43200000..0x4325bfff pa 0x43200000..0x4325bfff size 0x0005c000
> (smallpg)
> D/TC:6   dump_mmap_table:800 type TEE_RAM_RW   va
> 0x4325c000..0x433fffff pa 0x4325c000..0x433fffff size 0x001a4000
> (smallpg)
> D/TC:6   dump_mmap_table:800 type SHM_VASPACE  va
> 0x43400000..0x453fffff pa 0x00000000..0x01ffffff size 0x02000000
> (pgdir)
> D/TC:6   dump_mmap_table:800 type RES_VASPACE  va
> 0x45400000..0x45dfffff pa 0x00000000..0x009fffff size 0x00a00000
> (pgdir)
> D/TC:6   dump_mmap_table:800 type IO_SEC       va
> 0x45e00000..0x45ffffff pa 0x0c000000..0x0c1fffff size 0x00200000
> (pgdir)
> D/TC:6   dump_mmap_table:800 type IO_SEC       va
> 0x46000000..0x461fffff pa 0x0c400000..0x0c5fffff size 0x00200000
> (pgdir)
> D/TC:6   dump_mmap_table:800 type IO_NSEC      va
> 0x46200000..0x463fffff pa 0x11000000..0x111fffff size 0x00200000
> (pgdir)
> D/TC:6   dump_mmap_table:800 type TA_RAM       va
> 0x46400000..0x46bfffff pa 0x43400000..0x43bfffff size 0x00800000
> (pgdir)
> D/TC:6   dump_mmap_table:800 type NSEC_SHM     va
> 0x46c00000..0x46dfffff pa 0x43c00000..0x43dfffff size 0x00200000
> (pgdir)
> D/TC:6   core_mmu_xlat_table_alloc:526 xlat tables used 1 / 5
> D/TC:6   core_mmu_xlat_table_alloc:526 xlat tables used 2 / 5
> I/TC:
> D/TC:6 0 select_vector_wa_spectre_bhb:650 Spectre-BHB CVE-2022-23960
> workaround enabled with "K" =3D 32
> I/TC: OP-TEE version: Unknown_3.18 (gcc version 11.2.0 (coreboot
> toolchain v_)) #1 Tue Mar 14 18:08:58 UTC 2023 aarch64
> I/TC: WARNING: This OP-TEE configuration might be insecure!
> I/TC: WARNING: Please check
> https://optee.readthedocs.io/en/latest/architecture/porting_guidelines.ht=
ml
> I/TC: Primary CPU 6 initializing
> D/TC:6 0 boot_init_primary_late:1314 Executing at offset 0 with
> virtual load address 0x43200000
> D/TC:6 0 call_preinitcalls:21 level 2 mobj_mapped_shm_init()
> D/TC:6 0 mobj_mapped_shm_init:463 Shared memory address range:
> 43400000, 45400000
> D/TC:6 0 call_initcalls:40 level 1 register_time_source()
> D/TC:6 0 call_initcalls:40 level 1 teecore_init_pub_ram()
> D/TC:6 0 call_initcalls:40 level 3 check_ta_store()
> D/TC:6 0 check_ta_store:408 TA store: "Secure Storage TA"
> D/TC:6 0 check_ta_store:408 TA store: "REE"
> D/TC:6 0 call_initcalls:40 level 3 verify_pseudo_tas_conformance()
> D/TC:6 0 call_initcalls:40 level 3 tee_cryp_init()
> D/TC:6 0 call_initcalls:40 level 4 tee_fs_init_key_manager()
> D/TC:6 0 call_initcalls:40 level 6 mobj_init()
> D/TC:6 0 call_initcalls:40 level 6 default_mobj_init()
> I/TC: Primary CPU switching to normal world boot
> D/TC:6   tee_entry_exchange_capabilities:100 Asynchronous
> notifications are disabled
> D/TC:6   tee_entry_exchange_capabilities:109 Dynamic shared memory is ena=
bled
> D/TC:6 0 core_mmu_xlat_table_alloc:526 xlat tables used 3 / 5
> D/TC:? 0 tee_ta_init_pseudo_ta_session:296 Lookup pseudo TA
> 7011a688-ddde-4053-a5a9-7b3c4ddf13b8
> D/TC:? 0 tee_ta_init_pseudo_ta_session:309 Open device.pta
> D/TC:? 0 tee_ta_init_pseudo_ta_session:326 device.pta :
> 7011a688-ddde-4053-a5a9-7b3c4ddf13b8
> F/TC:? 0 plat_prng_add_jitter_entropy:72 0xAC2D
> D/TC:? 0 tee_ta_close_session:511 csess 0x43289a10 id 1
> D/TC:? 0 tee_ta_close_session:530 Destroy session
> I/TC: Secondary CPU 4 initializing
> D/TC:4   select_vector_wa_spectre_bhb:650 Spectre-BHB CVE-2022-23960
> workaround enabled with "K" =3D 32
> I/TC: Secondary CPU 4 switching to normal world boot
> D/TC:? 0 tee_ta_init_pseudo_ta_session:296 Lookup pseudo TA
> a92d116c-ce27-4917-b30c-4a416e2d9351
> D/TC:? 0 ldelf_load_ldelf:96 ldelf load address 0x80006000
> D/LD:  ldelf:134 Loading TS a92d116c-ce27-4917-b30c-4a416e2d9351
> F/TC:? 0 trace_syscall:151 syscall #3 (syscall_get_property)
> F/TC:? 0 trace_syscall:151 syscall #5 (syscall_open_ta_session)
> D/TC:? 0 ldelf_syscall_open_bin:142 Lookup user TA ELF
> a92d116c-ce27-4917-b30c-4a416e2d9351 (Secure Storage TA)
> D/TC:? 1 tee_ta_init_session_with_context:606 Re-open TA
> 7011a688-ddde-4053-a5a9-7b3c4ddf13b8
> F/TC:? 1 plat_prng_add_jitter_entropy:72 0xFC
> D/TC:? 1 tee_ta_close_session:511 csess 0x43288b40 id 2
> D/TC:? 1 tee_ta_close_session:530 Destroy session
> F/TC:? 0 plat_prng_add_jitter_entropy:72 0x16
> F/TC:? 0 plat_prng_add_jitter_entropy:72 0x36
> F/TC:? 0 plat_prng_add_jitter_entropy:72 0x23
> D/TC:? 0 ldelf_syscall_open_bin:146 res=3D0xffff0008
> D/TC:? 0 ldelf_syscall_open_bin:142 Lookup user TA ELF
> a92d116c-ce27-4917-b30c-4a416e2d9351 (REE)
> I/TC: Secondary CPU 1 initializing
> I/TC: Secondary CPU 1 switching to normal world boot
> I/TC: Secondary CPU 5 initializing
> D/TC:5   select_vector_wa_spectre_bhb:650 Spectre-BHB CVE-2022-23960
> workaround enabled with "K" =3D 32
> I/TC: Secondary CPU 5 switching to normal world boot
> I/TC: Secondary CPU 2 initializing
> I/TC: Secondary CPU 2 switching to normal world boot
> I/TC: Secondary CPU 0 initializing
> I/TC: Secondary CPU 0 switching to normal world boot
> D/TC:? 0 ldelf_syscall_open_bin:146 res=3D0
> F/TC:? 0 trace_syscall:151 syscall #7 (syscall_invoke_ta_command)
> F/TC:? 0 trace_syscall:151 syscall #11 (syscall_mask_cancellation)
> F/TC:? 0 trace_syscall:151 syscall #7 (syscall_invoke_ta_command)
> F/TC:? 0 trace_syscall:151 syscall #3 (syscall_get_property)
> F/TC:? 0 trace_syscall:151 syscall #8 (syscall_check_access_rights)
> F/TC:? 0 trace_syscall:151 syscall #8 (syscall_check_access_rights)
> F/TC:? 0 plat_prng_add_jitter_entropy:72 0x9B
> I/TC: Secondary CPU 7 initializing
> D/TC:7   select_vector_wa_spectre_bhb:650 Spectre-BHB CVE-2022-23960
> workaround enabled with "K" =3D 32
> I/TC: Secondary CPU 7 switching to normal world boot
> F/TC:? 0 plat_prng_add_jitter_entropy:72 0x31
> F/TC:? 0 plat_prng_add_jitter_entropy:72 0xB6
> I/TC: Secondary CPU 3 initializing
> I/TC: Secondary CPU 3 switching to normal world boot
> F/TC:? 0 plat_prng_add_jitter_entropy:72 0x23
> F/TC:? 0 trace_syscall:151 syscall #6 (syscall_close_ta_session)
> F/TC:? 0 trace_syscall:151 syscall #3 (syscall_get_property)
> D/LD:  ldelf:168 ELF (a92d116c-ce27-4917-b30c-4a416e2d9351) at 0x80049000
> F/TC:? 0 trace_syscall:151 syscall #8 (syscall_check_access_rights)
> F/TC:? 0 trace_syscall:151 syscall #8 (syscall_check_access_rights)
> F/TC:? 0 trace_syscall:151 syscall #4 (syscall_get_property_name_to_index=
)
> F/TC:? 0 plat_prng_add_jitter_entropy:72 0x38
>

Thanks for this log, I can see how it works.

> >
> > The one thing that essentially pops out to me is that, with the
> > default SPI interrupt routing model (routed to CPU0), OP-TEE won't be
> > able to handle the secure interrupts until it has been initialized on
> > CPU0.
> >
> OK, so the actual concern is that we should initialize on all online
> CPUs at startup or we may miss S-EL1 interrupts, correct?
>

Yeah, having all the CPUs initialized at once would solve the interrupts is=
sue.

> > [1] https://man7.org/linux/man-pages/man1/taskset.1.html
> >
> > > >
> > > > Also, I observe from the TF-A patch that you are doing lazy OP-TEE
> > > > initialization for other secondary CPUs. IOW, if there is an OP-TEE
> > > > SMC call invoked for a particular CPU then only you invoke
> > > > opteed_cpu_on_finish_handler(0) once. This can be a bit unsafe as
> > > > OP-TEE hasn't setup its context for those CPU which may involve som=
e
> > > > CPU specific security bits too such as:
> > > > - GIC CPU interface initialization, secure vs non-secure interrupts=
.
> > > > - Any platform and CPU specific TrustZone configuration.
> > >
> > > When opteed_cpu_on_finish_handler(0) is invoked...that invokes
> > > opteed_init_optee_ep_state(...) which then sets up the CPU context fo=
r
> > > that CPU. It then invokes opteed_synchronous_sp_entry for the
> > > cpu_on_entry handler which should then do any other type of platform
> > > specific initialization in the OP-TEE code itself. What setup in
> > > OP-TEE are you referring to that isn't going to be invoked when doing
> > > it the lazy way?
> >
> > No, I am not worried about any missing setup but rather deferred
> > OP-TEE initialization for secondary CPUs after you open up the Linux
> > attack surface.
>
> What is the concern about initializing on secondary CPUs after the
> attack surface is opened up?

I have already mentions some concerns as follows:

- GIC CPU interface initialization, secure vs non-secure interrupts.
- Any platform and CPU specific TrustZone configuration.

Basically we should have OP-TEE context initialized for every online
core in a safe context to close down any possibilities for a
particular CPU go rogue wrt OP-TEE.

>
> >
> > >
> > > >
> > > > I would have rather expected you to utilize cpuhp_setup_state() and
> > > > friends to initialize OP-TEE for secondary CPUs during boot instead
> > > > which is safe as per your platform threat model.
> > > >
> > > That could be another way to do it (I'm not familiar with that kernel
> > > code currently)..
> >
> > AFAIK, there are many Linux kernel experts within Google who can guide
> > you through.
> >
> I was simply stating that I wasn't familiar with that API...I have no
> problems reading the API and understanding it myself. :)
>

That's good to hear.

> > > but I'd rather stick with what I have unless there is
> > > something technically wrong with it since it's already been approved
> > > in TF-A.
> >
> > We can very well amend the TF-A implementation with a followup patch.
> > Given above comments, the approach to initialize OP-TEE on all CPUs at
> > once during boot should be the correct approach.
> OK, so I've done this now in the v9 patchset. After it loads the
> OP-TEE image, then it invokes cpuhp_setup_state(), which receives a
> callback on each active core, which then simply gets the UID for
> OP-TEE, and that invocation will then cause TF-A to init the context
> for each core. Then it deregisters with cpuhp since that work is done.
> This will then ensure that all cores that have come online will have
> their CPU context initialized for OP-TEE. And any cores that may not
> be online at this time will get initialized when they come back
> online.  This *should* address the concerns you have outlined above.

Yeah it does address my concerns. I will review it.

-Sumit

> >
> > -Sumit
> >
> > >
> > > > -Sumit
> > > >
> > > > > +       if (!rc)
> > > > > +               rc =3D res.a0;
> > > > > +       if (fw)
> > > > > +               release_firmware(fw);
> > > > > +       kfree(data_buf);
> > > > > +
> > > > > +       return rc;
> > > > > +}
> > > > > +#else
> > > > > +static inline int optee_load_fw(struct platform_device *__unused=
1,
> > > > > +               optee_invoke_fn *__unused2) {
> > > > > +       return 0;
> > > > > +}
> > > > > +#endif
> > > > > +
> > > > >  static int optee_probe(struct platform_device *pdev)
> > > > >  {
> > > > >         optee_invoke_fn *invoke_fn;
> > > > > @@ -1372,6 +1465,10 @@ static int optee_probe(struct platform_dev=
ice *pdev)
> > > > >         if (IS_ERR(invoke_fn))
> > > > >                 return PTR_ERR(invoke_fn);
> > > > >
> > > > > +       rc =3D optee_load_fw(pdev, invoke_fn);
> > > > > +       if (rc)
> > > > > +               return rc;
> > > > > +
> > > > >         if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
> > > > >                 pr_warn("api uid mismatch\n");
> > > > >                 return -EINVAL;
> > > > > --
> > > > > 2.40.0.rc1.284.g88254d51c5-goog
> > > > >
