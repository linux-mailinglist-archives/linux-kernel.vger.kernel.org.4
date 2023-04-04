Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AEB6D5EE0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 13:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbjDDLXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 07:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234730AbjDDLXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:23:47 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5341980
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 04:23:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso770583wmo.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 04:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680607423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMNH2NHnNeTRpeMge5JCNE6oTR/cR6flhaiwBjgFpZo=;
        b=Wp+7/Y8ghEseJFjYMrBM1IH23vUtCp9+e/UiLvSsr4rZFkwIwBBDX/jVq6HQOa+gv7
         OifvvuvxSndtV/mmCmNBMhyA2ZrkGHLiHgyCGe8gsNqL3r2PtpyXQZGn3yO30GJV6uv+
         +n9iNdBWhx4fwmCBa2Tdg87BY8rAJZDhqShhsT1yFPZ2vOctYCXVATvFSmmhFaKWQJNx
         mAg4qqvqcgTjF8RIBQsczQufXVD2aYv8+eqmsuArNeLNj325zfmn41s+RpiOiPyRaApA
         YXGrEWxlD/O/PeKfXHCTBs7d7SJaPBKgAq5qlJ3kAVsR4Rqcui5FtmcpwDEL/PqNXDpx
         r0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680607423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMNH2NHnNeTRpeMge5JCNE6oTR/cR6flhaiwBjgFpZo=;
        b=UOE/ymy5Xq4sdtTCXMEAi+Sjyt1xvdG6e1/BIvoxqEQK8sOqAZ3fhEcz8pH+/jaHng
         WvFyC7qkfayOOt4PEhQfNM0sCykT6SYuFzqoJ9Y+QutNNPs5vwEDQRecD7xNgUVb7Fkk
         mB71kTy57tRzXSPT5DrnVOh3r85c0GAMW9k/IO0tKoTyn/o+G8cbFf+A0r5MJHB/Hs1s
         Bf/22iPACZJMMjX4Mu+809q4m8GRxULf4ACHlLdwb5DkV4tO+hIwRfHPL2y+mL/tIErq
         6xXNe99tCKJqeoPOuDpBsp1AJfw+d1dIhCi/BHDtnDRMKHlwFV9h5rFl4fR2QTa7A0Gk
         Ku4w==
X-Gm-Message-State: AAQBX9eGUhSyiRDzxnG+lQ8NSIZFk9TumwOHjBMLJ6HByrEc7eiAu9UH
        +Viy0HTgIzPM4nP5lXX20PYlHhuJOpugm88zViXL9w==
X-Google-Smtp-Source: AKy350Z2Uqvl57zM4G2qqZa1EgQgrrmqh733JiyUY4s9YM7qi0fPZkiY1EVmXT2Z73tlf9AhZrCYeq9Nyzew/xX0mCo=
X-Received: by 2002:a05:600c:c6:b0:3ee:2552:7520 with SMTP id
 u6-20020a05600c00c600b003ee25527520mr663869wmm.4.1680607422987; Tue, 04 Apr
 2023 04:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230331113539.v13.1.I8e7f9b01d9ac940507d78e15368e200a6a69bedb@changeid>
 <CA+ddPcNQp6BO9NHmoBTOU5QxhK0oqekRwQxhXBAyL_20DTVhCg@mail.gmail.com>
In-Reply-To: <CA+ddPcNQp6BO9NHmoBTOU5QxhK0oqekRwQxhXBAyL_20DTVhCg@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 4 Apr 2023 13:23:32 +0200
Message-ID: <CAHUa44E1BD8wHL=XEUxduwgVGeu1nhpAEW0j==4+rm=z52qTXw@mail.gmail.com>
Subject: Re: [PATCH v13] tee: optee: Add SMC for loading OP-TEE image
To:     Jeffrey Kardatzke <jkardatzke@google.com>
Cc:     op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023 at 6:57=E2=80=AFPM Jeffrey Kardatzke <jkardatzke@google=
.com> wrote:
>
> The  corresponding TF-A change is merged now, so the kernel patch
> should be all ready to go.
>
> On Fri, Mar 31, 2023 at 11:35=E2=80=AFAM Jeffrey Kardatzke
> <jkardatzke@chromium.org> wrote:
> >
> > Adds an SMC call that will pass an OP-TEE binary image to EL3 and
> > instruct it to load it as the BL32 payload. This works in conjunction
> > with a feature added to Trusted Firmware for ARMv8 and above
> > architectures that supports this.
> >
> > The main purpose of this change is to facilitate updating the OP-TEE
> > component on devices via a rootfs change rather than having to do a
> > firmware update. Further details are linked to in the Kconfig file.
> >
> > Signed-off-by: Jeffrey Kardatzke <jkardatzke@chromium.org>
> > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>

I'm picking up this.

Thanks,
Jens

> > ---
> >
> > Changes in v13:
> > - Documentation formatting changes
> >
> > Changes in v12:
> > - Fixed checkpatch strict issues
> >
> > Changes in v11:
> > - Fixed typo in tee.rst documentation
> >
> > Changes in v10:
> > - Fixed tee.rst documentation formatting
> >
> > Changes in v9:
> > - Add CPU hotplug callback to init on all cores at startup
> >
> > Changes in v8:
> > - Renamed params and fixed alignment issue
> >
> > Changes in v7:
> > - Added documentation to Documentation/staging/tee.rst
> >
> > Changes in v6:
> > - Expanded Kconfig documentation
> >
> > Changes in v5:
> > - Renamed config option
> > - Added runtime warning when config is used
> >
> > Changes in v4:
> > - Update commit message
> > - Added more documentation
> > - Renamed config option, added ARM64 dependency
> >
> > Changes in v3:
> > - Removed state tracking for driver reload
> > - Check UID of service to verify it needs image load
> >
> > Changes in v2:
> > - Fixed compile issue when feature is disabled
> > - Addressed minor comments
> > - Added state tracking for driver reload
> >
> >  Documentation/staging/tee.rst |  53 +++++++++++++
> >  drivers/tee/optee/Kconfig     |  17 +++++
> >  drivers/tee/optee/optee_msg.h |  12 +++
> >  drivers/tee/optee/optee_smc.h |  24 ++++++
> >  drivers/tee/optee/smc_abi.c   | 137 ++++++++++++++++++++++++++++++++++
> >  5 files changed, 243 insertions(+)
> >
> > diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.=
rst
> > index 498343c7ab08..22baa077a3b9 100644
> > --- a/Documentation/staging/tee.rst
> > +++ b/Documentation/staging/tee.rst
> > @@ -214,6 +214,57 @@ call is done from the thread assisting the interru=
pt handler. This is a
> >  building block for OP-TEE OS in secure world to implement the top half=
 and
> >  bottom half style of device drivers.
> >
> > +OPTEE_INSECURE_LOAD_IMAGE Kconfig option
> > +----------------------------------------
> > +
> > +The OPTEE_INSECURE_LOAD_IMAGE Kconfig option enables the ability to lo=
ad the
> > +BL32 OP-TEE image from the kernel after the kernel boots, rather than =
loading
> > +it from the firmware before the kernel boots. This also requires enabl=
ing the
> > +corresponding option in Trusted Firmware for Arm. The Trusted Firmware=
 for Arm
> > +documentation [8] explains the security threat associated with enablin=
g this as
> > +well as mitigations at the firmware and platform level.
> > +
> > +There are additional attack vectors/mitigations for the kernel that sh=
ould be
> > +addressed when using this option.
> > +
> > +1. Boot chain security.
> > +
> > +   * Attack vector: Replace the OP-TEE OS image in the rootfs to gain =
control of
> > +     the system.
> > +
> > +   * Mitigation: There must be boot chain security that verifies the k=
ernel and
> > +     rootfs, otherwise an attacker can modify the loaded OP-TEE binary=
 by
> > +     modifying it in the rootfs.
> > +
> > +2. Alternate boot modes.
> > +
> > +   * Attack vector: Using an alternate boot mode (i.e. recovery mode),=
 the
> > +     OP-TEE driver isn't loaded, leaving the SMC hole open.
> > +
> > +   * Mitigation: If there are alternate methods of booting the device,=
 such as a
> > +     recovery mode, it should be ensured that the same mitigations are=
 applied
> > +     in that mode.
> > +
> > +3. Attacks prior to SMC invocation.
> > +
> > +   * Attack vector: Code that is executed prior to issuing the SMC cal=
l to load
> > +     OP-TEE can be exploited to then load an alternate OS image.
> > +
> > +   * Mitigation: The OP-TEE driver must be loaded before any potential=
 attack
> > +     vectors are opened up. This should include mounting of any modifi=
able
> > +     filesystems, opening of network ports or communicating with exter=
nal
> > +     devices (e.g. USB).
> > +
> > +4. Blocking SMC call to load OP-TEE.
> > +
> > +   * Attack vector: Prevent the driver from being probed, so the SMC c=
all to
> > +     load OP-TEE isn't executed when desired, leaving it open to being=
 executed
> > +     later and loading a modified OS.
> > +
> > +   * Mitigation: It is recommended to build the OP-TEE driver as built=
in driver
> > +     rather than as a module to prevent exploits that may cause the mo=
dule to
> > +     not be loaded.
> > +
> >  AMD-TEE driver
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > @@ -309,3 +360,5 @@ References
> >  [6] include/linux/psp-tee.h
> >
> >  [7] drivers/tee/amdtee/amdtee_if.h
> > +
> > +[8] https://trustedfirmware-a.readthedocs.io/en/latest/threat_model/th=
reat_model.html
> > diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> > index f121c224e682..70898bbd5809 100644
> > --- a/drivers/tee/optee/Kconfig
> > +++ b/drivers/tee/optee/Kconfig
> > @@ -7,3 +7,20 @@ config OPTEE
> >         help
> >           This implements the OP-TEE Trusted Execution Environment (TEE=
)
> >           driver.
> > +
> > +config OPTEE_INSECURE_LOAD_IMAGE
> > +       bool "Load OP-TEE image as firmware"
> > +       default n
> > +       depends on OPTEE && ARM64
> > +       help
> > +         This loads the BL32 image for OP-TEE as firmware when the dri=
ver is
> > +         probed. This returns -EPROBE_DEFER until the firmware is load=
able from
> > +         the filesystem which is determined by checking the system_sta=
te until
> > +         it is in SYSTEM_RUNNING. This also requires enabling the corr=
esponding
> > +         option in Trusted Firmware for Arm. The documentation there e=
xplains
> > +         the security threat associated with enabling this as well as
> > +         mitigations at the firmware and platform level.
> > +         https://trustedfirmware-a.readthedocs.io/en/latest/threat_mod=
el/threat_model.html
> > +
> > +         Additional documentation on kernel security risks are at
> > +         Documentation/staging/tee.rst.
> > diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_ms=
g.h
> > index 70e9cc2ee96b..e8840a82b983 100644
> > --- a/drivers/tee/optee/optee_msg.h
> > +++ b/drivers/tee/optee/optee_msg.h
> > @@ -241,11 +241,23 @@ struct optee_msg_arg {
> >   * 384fb3e0-e7f8-11e3-af63-0002a5d5c51b.
> >   * Represented in 4 32-bit words in OPTEE_MSG_UID_0, OPTEE_MSG_UID_1,
> >   * OPTEE_MSG_UID_2, OPTEE_MSG_UID_3.
> > + *
> > + * In the case where the OP-TEE image is loaded by the kernel, this wi=
ll
> > + * initially return an alternate UID to reflect that we are communicat=
ing with
> > + * the TF-A image loading service at that time instead of OP-TEE. That=
 UID is:
> > + * a3fbeab1-1246-315d-c7c4-06b9c03cbea4.
> > + * Represented in 4 32-bit words in OPTEE_MSG_IMAGE_LOAD_UID_0,
> > + * OPTEE_MSG_IMAGE_LOAD_UID_1, OPTEE_MSG_IMAGE_LOAD_UID_2,
> > + * OPTEE_MSG_IMAGE_LOAD_UID_3.
> >   */
> >  #define OPTEE_MSG_UID_0                        0x384fb3e0
> >  #define OPTEE_MSG_UID_1                        0xe7f811e3
> >  #define OPTEE_MSG_UID_2                        0xaf630002
> >  #define OPTEE_MSG_UID_3                        0xa5d5c51b
> > +#define OPTEE_MSG_IMAGE_LOAD_UID_0     0xa3fbeab1
> > +#define OPTEE_MSG_IMAGE_LOAD_UID_1     0x1246315d
> > +#define OPTEE_MSG_IMAGE_LOAD_UID_2     0xc7c406b9
> > +#define OPTEE_MSG_IMAGE_LOAD_UID_3     0xc03cbea4
> >  #define OPTEE_MSG_FUNCID_CALLS_UID     0xFF01
> >
> >  /*
> > diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_sm=
c.h
> > index 73b5e7760d10..7d9fa426505b 100644
> > --- a/drivers/tee/optee/optee_smc.h
> > +++ b/drivers/tee/optee/optee_smc.h
> > @@ -104,6 +104,30 @@ struct optee_smc_call_get_os_revision_result {
> >         unsigned long reserved1;
> >  };
> >
> > +/*
> > + * Load Trusted OS from optee/tee.bin in the Linux firmware.
> > + *
> > + * WARNING: Use this cautiously as it could lead to insecure loading o=
f the
> > + * Trusted OS.
> > + * This SMC instructs EL3 to load a binary and execute it as the Trust=
ed OS.
> > + *
> > + * Call register usage:
> > + * a0 SMC Function ID, OPTEE_SMC_CALL_LOAD_IMAGE
> > + * a1 Upper 32bit of a 64bit size for the payload
> > + * a2 Lower 32bit of a 64bit size for the payload
> > + * a3 Upper 32bit of the physical address for the payload
> > + * a4 Lower 32bit of the physical address for the payload
> > + *
> > + * The payload is in the OP-TEE image format.
> > + *
> > + * Returns result in a0, 0 on success and an error code otherwise.
> > + */
> > +#define OPTEE_SMC_FUNCID_LOAD_IMAGE 2
> > +#define OPTEE_SMC_CALL_LOAD_IMAGE \
> > +       ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, \
> > +                          ARM_SMCCC_OWNER_TRUSTED_OS_END, \
> > +                          OPTEE_SMC_FUNCID_LOAD_IMAGE)
> > +
> >  /*
> >   * Call with struct optee_msg_arg as argument
> >   *
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index a1c1fa1a9c28..6e1f023d50c6 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -7,10 +7,13 @@
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >
> >  #include <linux/arm-smccc.h>
> > +#include <linux/cpuhotplug.h>
> >  #include <linux/errno.h>
> > +#include <linux/firmware.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/irqdomain.h>
> > +#include <linux/kernel.h>
> >  #include <linux/mm.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > @@ -1149,6 +1152,22 @@ static bool optee_msg_api_uid_is_optee_api(optee=
_invoke_fn *invoke_fn)
> >         return false;
> >  }
> >
> > +#ifdef CONFIG_OPTEE_INSECURE_LOAD_IMAGE
> > +static bool optee_msg_api_uid_is_optee_image_load(optee_invoke_fn *inv=
oke_fn)
> > +{
> > +       struct arm_smccc_res res;
> > +
> > +       invoke_fn(OPTEE_SMC_CALLS_UID, 0, 0, 0, 0, 0, 0, 0, &res);
> > +
> > +       if (res.a0 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_0 &&
> > +           res.a1 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_1 &&
> > +           res.a2 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_2 &&
> > +           res.a3 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_3)
> > +               return true;
> > +       return false;
> > +}
> > +#endif
> > +
> >  static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
> >  {
> >         union {
> > @@ -1354,6 +1373,120 @@ static void optee_shutdown(struct platform_devi=
ce *pdev)
> >                 optee_disable_shm_cache(optee);
> >  }
> >
> > +#ifdef CONFIG_OPTEE_INSECURE_LOAD_IMAGE
> > +
> > +#define OPTEE_FW_IMAGE "optee/tee.bin"
> > +
> > +static optee_invoke_fn *cpuhp_invoke_fn;
> > +
> > +static int optee_cpuhp_probe(unsigned int cpu)
> > +{
> > +       /*
> > +        * Invoking a call on a CPU will cause OP-TEE to perform the re=
quired
> > +        * setup for that CPU. Just invoke the call to get the UID sinc=
e that
> > +        * has no side effects.
> > +        */
> > +       if (optee_msg_api_uid_is_optee_api(cpuhp_invoke_fn))
> > +               return 0;
> > +       else
> > +               return -EINVAL;
> > +}
> > +
> > +static int optee_load_fw(struct platform_device *pdev,
> > +                        optee_invoke_fn *invoke_fn)
> > +{
> > +       const struct firmware *fw =3D NULL;
> > +       struct arm_smccc_res res;
> > +       phys_addr_t data_pa;
> > +       u8 *data_buf =3D NULL;
> > +       u64 data_size;
> > +       u32 data_pa_high, data_pa_low;
> > +       u32 data_size_high, data_size_low;
> > +       int rc;
> > +       int hp_state;
> > +
> > +       if (!optee_msg_api_uid_is_optee_image_load(invoke_fn))
> > +               return 0;
> > +
> > +       rc =3D request_firmware(&fw, OPTEE_FW_IMAGE, &pdev->dev);
> > +       if (rc) {
> > +               /*
> > +                * The firmware in the rootfs will not be accessible un=
til we
> > +                * are in the SYSTEM_RUNNING state, so return EPROBE_DE=
FER until
> > +                * that point.
> > +                */
> > +               if (system_state < SYSTEM_RUNNING)
> > +                       return -EPROBE_DEFER;
> > +               goto fw_err;
> > +       }
> > +
> > +       data_size =3D fw->size;
> > +       /*
> > +        * This uses the GFP_DMA flag to ensure we are allocated memory=
 in the
> > +        * 32-bit space since TF-A cannot map memory beyond the 32-bit =
boundary.
> > +        */
> > +       data_buf =3D kmalloc(fw->size, GFP_KERNEL | GFP_DMA);
> > +       if (!data_buf) {
> > +               rc =3D -ENOMEM;
> > +               goto fw_err;
> > +       }
> > +       memcpy(data_buf, fw->data, fw->size);
> > +       data_pa =3D virt_to_phys(data_buf);
> > +       reg_pair_from_64(&data_pa_high, &data_pa_low, data_pa);
> > +       reg_pair_from_64(&data_size_high, &data_size_low, data_size);
> > +       goto fw_load;
> > +
> > +fw_err:
> > +       pr_warn("image loading failed\n");
> > +       data_pa_high =3D 0;
> > +       data_pa_low =3D 0;
> > +       data_size_high =3D 0;
> > +       data_size_low =3D 0;
> > +
> > +fw_load:
> > +       /*
> > +        * Always invoke the SMC, even if loading the image fails, to i=
ndicate
> > +        * to EL3 that we have passed the point where it should allow i=
nvoking
> > +        * this SMC.
> > +        */
> > +       pr_warn("OP-TEE image loaded from kernel, this can be insecure"=
);
> > +       invoke_fn(OPTEE_SMC_CALL_LOAD_IMAGE, data_size_high, data_size_=
low,
> > +                 data_pa_high, data_pa_low, 0, 0, 0, &res);
> > +       if (!rc)
> > +               rc =3D res.a0;
> > +       if (fw)
> > +               release_firmware(fw);
> > +       kfree(data_buf);
> > +
> > +       if (!rc) {
> > +               /*
> > +                * We need to initialize OP-TEE on all other running co=
res as
> > +                * well. Any cores that aren't running yet will get ini=
tialized
> > +                * when they are brought up by the power management fun=
ctions in
> > +                * TF-A which are registered by the OP-TEE SPD. Due to =
that we
> > +                * can un-register the callback right after registering=
 it.
> > +                */
> > +               cpuhp_invoke_fn =3D invoke_fn;
> > +               hp_state =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "op=
tee:probe",
> > +                                            optee_cpuhp_probe, NULL);
> > +               if (hp_state < 0) {
> > +                       pr_warn("Failed with CPU hotplug setup for OP-T=
EE");
> > +                       return -EINVAL;
> > +               }
> > +               cpuhp_remove_state(hp_state);
> > +               cpuhp_invoke_fn =3D NULL;
> > +       }
> > +
> > +       return rc;
> > +}
> > +#else
> > +static inline int optee_load_fw(struct platform_device *pdev,
> > +                               optee_invoke_fn *invoke_fn)
> > +{
> > +       return 0;
> > +}
> > +#endif
> > +
> >  static int optee_probe(struct platform_device *pdev)
> >  {
> >         optee_invoke_fn *invoke_fn;
> > @@ -1372,6 +1505,10 @@ static int optee_probe(struct platform_device *p=
dev)
> >         if (IS_ERR(invoke_fn))
> >                 return PTR_ERR(invoke_fn);
> >
> > +       rc =3D optee_load_fw(pdev, invoke_fn);
> > +       if (rc)
> > +               return rc;
> > +
> >         if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
> >                 pr_warn("api uid mismatch\n");
> >                 return -EINVAL;
> > --
> > 2.40.0.348.gf938b09366-goog
> >
