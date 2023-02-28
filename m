Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247296A5F12
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjB1SzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB1SzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:55:08 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB09D2685F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 10:55:05 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t15so10838639wrz.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 10:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mq4mIfViGmFVkoFWz7aKsIVug/BGd4cFtSMeLNFFR3k=;
        b=psMo7vA48rbjyaZHBFQzA4xOJUKC12vNxe6FS6eay2zUDm34+ANvE8Iojh7Q8O47OF
         FJHzEpy1p4ExWq8Z2TPz5yEd7TPrVsSxo03JwiMPuvHul/lBLBLn9o7WmXSxGkDP0x7M
         8R7ouVD/5RywjZxpQhkHoWQp5/KKXy3h02Oo5I7EqYDrrctLbCeq0G1mDWzkjcAxA34k
         CVOIhUgzNAr0Qnr7SxqVVDydFcw81xkBOo9pNc4U9mRZTKUYrBvuFXAFo76zPhqNZdMA
         /VsAWLgrLT/ygIh3t2z/PA5Wr6bC3tfOPDAIl7PZXxl1rdSEYbE2z6HB8dEO05T0Z4DJ
         8LQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mq4mIfViGmFVkoFWz7aKsIVug/BGd4cFtSMeLNFFR3k=;
        b=K6MKrQ8vcQF2I0hmskOi/9nD1BccMMQldknloTdpIFwxbz28tHQIO0flaWH/Izi4gZ
         Q3pZnZbE0PottFPpkfGRmIIPxDSEWhPuBW8DJmR4ZVE+hx0OrS0uMrv1c97PlMiZe4E2
         h5Ip7tjL7xKXEkqKCkE8mVIM3q61dCN322L8tBegq2PjbdjgVgFImXWH8xBzGo422UwF
         5aYqG3hlM++O+bgm/ldJNDJX1EJCukiIqWsgPsHu4rb8h/f3jcQsVP1/2xAu53fg2M9i
         yRunFs8Kn6dHwcsHxksArFla0E/qA4ggyP6eUhvNOqMvTz+VW+DXwkX4F6rf647yqYQT
         pkzA==
X-Gm-Message-State: AO0yUKX1oV7MteZoeRj5dl0Pw4JeoTfii0JHMfgD34CvQr+dn2MytXNF
        DAIrngZ9Q0AL/J0F9vFL0t6Dm7/DrFtYTMXoMngZrQ==
X-Google-Smtp-Source: AK7set+ct67HE2uM1heDWyAa5lF/uwZHvNpCusixjY9bfXNHVlnsrDU6Mu/EkTqSjdQLhHgK7T8jPx8k6Fj/Sfxfm/U=
X-Received: by 2002:a5d:63c6:0:b0:2c9:bd6e:83c0 with SMTP id
 c6-20020a5d63c6000000b002c9bd6e83c0mr700693wrw.3.1677610504195; Tue, 28 Feb
 2023 10:55:04 -0800 (PST)
MIME-Version: 1.0
References: <20230222092409.1.I8e7f9b01d9ac940507d78e15368e200a6a69bedb@changeid>
 <CAHUa44GUEtN4J_PKaeM4YEfL8dGBpCcSWw1C_pobwh9VFpWKTw@mail.gmail.com>
 <CA+ddPcNnCwBVnpyT2cWYeRtUfqZFk-KodtMHfNMnQs=T9o3nyA@mail.gmail.com>
 <CAHUa44FVrLDBNQqfFfwFAPHTjDNRpQJShCz2+H7X4nUbfe3QUQ@mail.gmail.com> <CA+ddPcMBfVxF2HK8g_o84Ata7Cg3MedacfpG=EZWUn4Zu8m0Pw@mail.gmail.com>
In-Reply-To: <CA+ddPcMBfVxF2HK8g_o84Ata7Cg3MedacfpG=EZWUn4Zu8m0Pw@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 28 Feb 2023 19:54:53 +0100
Message-ID: <CAHUa44GhTnpyN6BrK69vOsjnDrQmYFsfm2mTX=sK97D2SWtrGQ@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Add SMC for loading OP-TEE image
To:     Jeffrey Kardatzke <jkardatzke@chromium.org>
Cc:     op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 24, 2023 at 9:17 PM Jeffrey Kardatzke
<jkardatzke@chromium.org> wrote:
>
> On Fri, Feb 24, 2023 at 12:25 AM Jens Wiklander
> <jens.wiklander@linaro.org> wrote:
> >
> > On Thu, Feb 23, 2023 at 8:09 PM Jeffrey Kardatzke
> > <jkardatzke@chromium.org> wrote:
> > >
> > > On Thu, Feb 23, 2023 at 1:28 AM Jens Wiklander
> > > <jens.wiklander@linaro.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Wed, Feb 22, 2023 at 6:24 PM Jeffrey Kardatzke
> > > > <jkardatzke@chromium.org> wrote:
> > > > >
> > > > > Adds an SMC call that will pass an OP-TEE binary image to EL3 and
> > > > > instruct it to load it as the BL32 payload. This works in conjunction
> > > > > with a feature added to Trusted Firmware for ARM that supports this.
> > > > >
> > > > > Signed-off-by: Jeffrey Kardatzke <jkardatzke@chromium.org>
> > > > > Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> > > > > ---
> > > > >
> > > > >  drivers/tee/optee/Kconfig     | 10 +++++
> > > > >  drivers/tee/optee/optee_msg.h | 14 +++++++
> > > > >  drivers/tee/optee/optee_smc.h | 22 ++++++++++
> > > > >  drivers/tee/optee/smc_abi.c   | 77 +++++++++++++++++++++++++++++++++++
> > > > >  4 files changed, 123 insertions(+)
> > > > >
> > > > > diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> > > > > index f121c224e682..5ffbeb3eaac0 100644
> > > > > --- a/drivers/tee/optee/Kconfig
> > > > > +++ b/drivers/tee/optee/Kconfig
> > > > > @@ -7,3 +7,13 @@ config OPTEE
> > > > >         help
> > > > >           This implements the OP-TEE Trusted Execution Environment (TEE)
> > > > >           driver.
> > > > > +
> > > > > +config OPTEE_LOAD_IMAGE
> > > > > +       bool "Load Op-Tee image as firmware"
> > > >
> > > > OP-TEE
> > > Done, fixed in next patch set.
> > > >
> > > > > +       default n
> > > > > +       depends on OPTEE
> > > > > +       help
> > > > > +         This loads the BL32 image for OP-TEE as firmware when the driver is probed.
> > > > > +         This returns -EPROBE_DEFER until the firmware is loadable from the
> > > > > +         filesystem which is determined by checking the system_state until it is in
> > > > > +         SYSTEM_RUNNING.
> > > > > diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> > > > > index 70e9cc2ee96b..84c1b15032a9 100644
> > > > > --- a/drivers/tee/optee/optee_msg.h
> > > > > +++ b/drivers/tee/optee/optee_msg.h
> > > > > @@ -284,6 +284,20 @@ struct optee_msg_arg {
> > > > >   */
> > > > >  #define OPTEE_MSG_FUNCID_GET_OS_REVISION       0x0001
> > > > >
> > > > > +/*
> > > > > + * Load Trusted OS from optee/tee.bin in the Linux firmware.
> > > > > + *
> > > > > + * WARNING: Use this cautiously as it could lead to insecure loading of the
> > > > > + * Trusted OS.
> > > > > + * This SMC instructs EL3 to load a binary and excute it as the Trusted OS.
> > > > > + * The first two params are the high and low 32 bits of the size of the payload
> > > > > + * and the third and fourth params are the high and low 32 bits of the physical
> > > > > + * address of the payload. The payload is in the OP-TEE image format.
> > > > > + *
> > > > > + * Returns 0 on success and an error code otherwise.
> > > > > + */
> > > > > +#define OPTEE_MSG_FUNCID_LOAD_IMAGE   0x0002
> > > >
> > > > There's no need to add anything to this file, you can define
> > > > OPTEE_SMC_FUNCID_LOAD_IMAGE to 2 directly in optee_smc.h below.
> > > >
> > > Done, fixed in next patch set.
> > > > > +
> > > > >  /*
> > > > >   * Do a secure call with struct optee_msg_arg as argument
> > > > >   * The OPTEE_MSG_CMD_* below defines what goes in struct optee_msg_arg::cmd
> > > > > diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> > > > > index 73b5e7760d10..908b1005e9db 100644
> > > > > --- a/drivers/tee/optee/optee_smc.h
> > > > > +++ b/drivers/tee/optee/optee_smc.h
> > > > > @@ -104,6 +104,28 @@ struct optee_smc_call_get_os_revision_result {
> > > > >         unsigned long reserved1;
> > > > >  };
> > > > >
> > > > > +/*
> > > > > + * Load Trusted OS from optee/tee.bin in the Linux firmware.
> > > > > + *
> > > > > + * WARNING: Use this cautiously as it could lead to insecure loading of the
> > > > > + * Trusted OS.
> > > > > + * This SMC instructs EL3 to load a binary and excute it as the Trusted OS.
> > > >
> > > > execute
> > > >
> > > Done, fixed in next patch set.
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
> > > > > + * Returns result in a0, 0 on success and an error code otherwise.
> > > > > + */
> > > > > +#define OPTEE_SMC_FUNCID_LOAD_IMAGE OPTEE_MSG_FUNCID_LOAD_IMAGE
> > > > > +#define OPTEE_SMC_CALL_LOAD_IMAGE \
> > > > > +       OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_LOAD_IMAGE)
> > > > > +
> > > > >  /*
> > > > >   * Call with struct optee_msg_arg as argument
> > > > >   *
> > > > > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > > > > index a1c1fa1a9c28..c1abbee86b39 100644
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
> > > > > @@ -1354,6 +1356,77 @@ static void optee_shutdown(struct platform_device *pdev)
> > > > >                 optee_disable_shm_cache(optee);
> > > > >  }
> > > > >
> > > > > +#ifdef CONFIG_OPTEE_LOAD_IMAGE
> > > > > +
> > > > > +#define OPTEE_FW_IMAGE "optee/tee.bin"
> > > > > +
> > > > > +static int optee_load_fw(struct platform_device *pdev,
> > > > > +                        optee_invoke_fn *invoke_fn)
> > > > > +{
> > > > > +       const struct firmware *fw = NULL;
> > > > > +       struct arm_smccc_res res;
> > > > > +       phys_addr_t data_pa;
> > > > > +       u8 *data_buf = NULL;
> > > > > +       u64 data_size;
> > > > > +       u32 data_pa_high, data_pa_low;
> > > > > +       u32 data_size_high, data_size_low;
> > > > > +       int rc;
> > > > > +
> > > > > +       rc = request_firmware(&fw, OPTEE_FW_IMAGE, &pdev->dev);
> > > > > +       if (rc) {
> > > > > +               /*
> > > > > +                * The firmware in the rootfs will not be accessible until we
> > > > > +                * are in the SYSTEM_RUNNING state, so return EPROBE_DEFER until
> > > > > +                * that point.
> > > > > +                */
> > > > > +               if (system_state < SYSTEM_RUNNING)
> > > > > +                       return -EPROBE_DEFER;
> > > > > +               goto fw_err;
> > > > > +       }
> > > > > +
> > > > > +       data_size = fw->size;
> > > > > +       /*
> > > > > +        * This uses the GFP_DMA flag to ensure we are allocated memory in the
> > > > > +        * 32-bit space since TF-A cannot map memory beyond the 32-bit boundary.
> > > > > +        */
> > > > > +       data_buf = kmalloc(fw->size, GFP_KERNEL | GFP_DMA);
> > > > > +       if (!data_buf) {
> > > > > +               rc = -ENOMEM;
> > > > > +               goto fw_err;
> > > > > +       }
> > > > > +       memcpy(data_buf, fw->data, fw->size);
> > > > > +       data_pa = virt_to_phys(data_buf);
> > > > > +       reg_pair_from_64(&data_pa_high, &data_pa_low, data_pa);
> > > > > +       reg_pair_from_64(&data_size_high, &data_size_low, data_size);
> > > > > +       goto fw_load;
> > > > > +
> > > > > +fw_err:
> > > > > +       pr_warn("image loading failed\n");
> > > > > +       data_pa_high = data_pa_low = data_size_high = data_size_low = 0;
> > > > > +
> > > > > +fw_load:
> > > > > +       /*
> > > > > +        * Always invoke the SMC, even if loading the image fails, to indicate
> > > > > +        * to EL3 that we have passed the point where it should allow invoking
> > > > > +        * this SMC.
> > > > > +        */
> > > > > +       invoke_fn(OPTEE_SMC_CALL_LOAD_IMAGE, data_size_high, data_size_low,
> > > > > +                 data_pa_high, data_pa_low, 0, 0, 0, &res);
> > > >
> > > > Prior to this, you've done nothing to check that the firmware might do
> > > > what you're expecting. optee_msg_api_uid_is_optee_api() does this
> > > > under normal circumstances as that SMC function is defined in the SMC
> > > > Calling Convention. I'm not sure what is the best approach here
> > > > though.
> > > >
> > > The way I think about it is that we have to issue this SMC call once
> > > we are in the SYSTEM_RUNNING state no matter what. We need to close
> > > the security hole this would leave open otherwise. Any other checks we
> > > would do that would prevent us from making that call could be other
> > > attack vectors.
> >
> > This is clearly a weakness in the design. If the kernel config doesn't
> > match exactly, we either have an open security hole in the secure
> > world or fail to initialize the driver.
> Yes, that's correct where if TF-A was built to enable the SMC call,
> but then the kernel wasn't built to include the OP-TEE driver, or with
> the image loading SMC config or the driver doesn't get loaded; that's
> leaving an open security hole. It's understood as part of this design
> that there's a big open security hole if the system isn't configured
> properly.
> > The former can only happen in
> > systems designed like yours where the kernel up to this point has the
> > same level of security as the secure world. There's no need for me to
> > repeat my concerns over that, but this is now going to have an impact
> > on platforms that don't use your security model too. So far we've
> > managed to avoid configuration options in the OP-TEE driver that
> > breaks everything for a class of devices.
> I could change TF-A and the kernel driver so that if it somebody does
> enable the kernel option but not the TF-A option, that TF-A returns a
> specific error code (rather than passing the non-secure originating
> call to OP-TEE) and the kernel driver can recognize that and then
> continue as if OP-TEE was loaded. Then enabling this option won't
> break anything if the TF-A config doesn't match.

Yes, that should help a bit. We may want to check some UUID of the
service too, just to avoid sending SMCs into the dark and not knowing
what it may hit. I believe we can sort out those details when
reviewing the TF-A patch.

> >
> > Given how important this call is for your platform and at the same
> > time harmful for all others perhaps this call should be done in a
> > separate driver.
> I'm not a kernel driver expert...but if I moved this into its own
> driver, then I think I'd need to have the OP-TEE driver defer loading
> until the image loading driver succeeds if it's enabled. So somebody
> enabling that other driver would hit the same issues as somebody
> enabling this config option for OP-TEE. (I have no problem moving this
> into a new driver if that's what you really want, but I want to be
> sure the same concerns don't come up if I do that).

I was considering a way of trying to minimize the window where this
hole is open while taking care of that other problem. Let's say that
if something goes wrong and the OP-TEE driver isn't probed, then
you're in trouble if it doesn't crash badly. If you don't like it I
don't mind if you skip it.

>
> If your main concern is somebody enabling this option and breaking
> their use of OP-TEE...then what I mentioned above should resolve that.
> If not, let me know more specifically what issue you're trying to
> avoid here.

Yes, that's my main concern.

Cheers,
Jens

>
> Thanks,
> Jeff
> >
> > Thanks,
> > Jens
> >
> > > > > +       if (!rc)
> > > > > +               rc = res.a0;
> > > > > +       if (fw)
> > > > > +               release_firmware(fw);
> > > > > +       kfree(data_buf);
> > > > > +
> > > > > +       return rc;
> > > > > +}
> > > > > +#else
> > > > > +static inline int optee_load_fw(struct platform_device *__unused,
> > > > > +               optee_invoke_fn *__unused) {
> > > > > +       return 0;
> > > > > +}
> > > > > +#endif
> > > > > +
> > > > >  static int optee_probe(struct platform_device *pdev)
> > > > >  {
> > > > >         optee_invoke_fn *invoke_fn;
> > > > > @@ -1372,6 +1445,10 @@ static int optee_probe(struct platform_device *pdev)
> > > > >         if (IS_ERR(invoke_fn))
> > > > >                 return PTR_ERR(invoke_fn);
> > > > >
> > > > > +       rc = optee_load_fw(pdev, invoke_fn);
> > > > > +       if (rc)
> > > > > +               return rc;
> > > >
> > > > What if OP-TEE already was loaded?
> > > > This also causes trouble if unloading and loading the driver again.
> > > > I think we need a way of telling if OP-TEE must be loaded first or not.
> > > >
> > > OK, I added some state tracking in the driver code to return the prior
> > > loading result if it was already loaded.
> > > > Thanks,
> > > > Jens
> > > >
> > > > > +
> > > > >         if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
> > > > >                 pr_warn("api uid mismatch\n");
> > > > >                 return -EINVAL;
> > > > > --
> > > > > 2.39.2.637.g21b0678d19-goog
> > > > >
