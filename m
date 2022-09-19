Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927E85BD5CF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 22:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiISUpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 16:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiISUp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 16:45:29 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BC64A13E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:45:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id kr11so1441734ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=WnevHGZQneBwmhff1l52cnQESSdtlV5X3NztfaFuYL8=;
        b=IBwAVUCZ8W5/Q9Cldx3f9lZcMPhLY4WCnLwvsLELOZWoLMrev/aoaNIi3Di3zG7QOD
         hV4E0Efwg/959P0D21WxEDzflRL/5D4Qy6RMGCNxF94L7ALCCfwDC33YqjeI1Mpr+ypk
         JFzdZWxdcNO6OftL0X/5scBtMXpVv9XLQjsQutf9xYZOByWDKrJQNrh82CrN5nYcjS+v
         OH/ys6Za3pi4vE8IXSo4SIK9zDeZ4Tv257+obIUmAdkAoAZMCbbcmcGivNqX1BNqkDsq
         RwEuMc/ic24j5MKKXAF33N7YMCysX3MQQ5W3JjUvkcAookMTjwSjwT/ALSEoIn+LSuHF
         Iiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WnevHGZQneBwmhff1l52cnQESSdtlV5X3NztfaFuYL8=;
        b=jWUc3JPeP2nph7HNspZ2cY+UNKrfBCqCCUBJf9DLx38zZT4S3ej8rDJey94tIh3Hwy
         Oo8HS9YrK7mmXZnqEOzKKHTLmuXFVzrGeoNFdtrMieiS8UL67bVojXrXUVDXPeaos6lm
         WV8Z9+I3XxNSLM8tboUOWTtSv5ZgcX6HDtM2OxnB04Hge+tN/6PTNmozcYyEb9aV8Rnh
         1bzc4Vb+C5wzoar6qMue6Pb/EKxxsg/mL4TbNz+6ClP3QvkBr5ra5OSuTGuCCrEiYrqs
         2JgmN9yPY/yjhZfVN+2Eam3WZmfbajo8mjs8ifUxRtfId8m/65iqDp+X6tuWRLnI74Q+
         +pYg==
X-Gm-Message-State: ACrzQf0HqhTKF3H9hleDd8lT9bxziWpGeKQtj1Qzy4OFi620Ws+lPAv0
        CTF9ytqYQKgswb25oMOsvfz3CVMaZr3mx0Dnk6Tmfg==
X-Google-Smtp-Source: AMsMyM76rqA/7vzl3M35a8URKb//s3n2RMh81mvBx3haA7dXQk2fp2ZE056GeNDAPVit+6F0MP1cYYGgh99Gf1+ME7M=
X-Received: by 2002:a17:907:728d:b0:77e:143b:a86 with SMTP id
 dt13-20020a170907728d00b0077e143b0a86mr13695069ejc.770.1663620325214; Mon, 19
 Sep 2022 13:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220607045650.4999-1-p-mohan@ti.com> <20220607045650.4999-3-p-mohan@ti.com>
 <20220712175949.GB2945984@p14s> <20220714172015.GA3106020@p14s>
 <20c544ef-40b3-dcbc-1f29-aac140725b57@ti.com> <7e7ed572-93fe-a9c8-f11e-d555e5113fd1@ti.com>
 <20220906192827.GA65147@p14s> <694da03a-e34d-1939-8b01-a75bc25495e0@ti.com>
 <992019ad-5c58-d420-8a18-a82228f8e086@smile.fr> <a0b99322-5886-6a56-74e4-e78dcb32ffa0@ti.com>
In-Reply-To: <a0b99322-5886-6a56-74e4-e78dcb32ffa0@ti.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 19 Sep 2022 14:45:13 -0600
Message-ID: <CANLsYkykPRn2Jj_5oSm4sLBx3rQnJozJ9cL=R1WUR7oXUF6jPA@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] remoteproc: pru: Add APIs to get and put the PRU cores
To:     Md Danish Anwar <a0501179@ti.com>
Cc:     Romain Naour <romain.naour@smile.fr>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Md Danish Anwar <danishanwar@ti.com>,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        nm@ti.com, ssantosh@kernel.org, s-anna@ti.com,
        linux-arm-kernel@lists.infradead.org, rogerq@kernel.org,
        grygorii.strashko@ti.com, vigneshr@ti.com, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sept 2022 at 05:40, Md Danish Anwar <a0501179@ti.com> wrote:
>
> Hi Mathieu,
>
> On 12/09/22 18:54, Romain Naour wrote:
> > Hi Danish, All,
> >
> > Le 07/09/2022 =C3=A0 11:24, Md Danish Anwar a =C3=A9crit :
> >> Hi Mathieu,
> >>
> >> On 07/09/22 00:58, Mathieu Poirier wrote:
> >>> On Fri, Sep 02, 2022 at 03:09:04PM +0530, Md Danish Anwar wrote:
> >>>> Hi Mathieu,
> >>>>
> >>>>
> >>>> On 15/07/22 11:52, Kishon Vijay Abraham I wrote:
> >>>>> +Danish
> >>>>>
> >>>>> Hi Mathieu,
> >>>>>
> >>>>> On 14/07/22 22:50, Mathieu Poirier wrote:
> >>>>>> On Tue, Jul 12, 2022 at 11:59:49AM -0600, Mathieu Poirier wrote:
> >>>>>>> Hi Puranjay,
> >>>>>
> >>>>> Removed Puranjay (as he is no longer with TI) and adding Danish.
> >>>>>
> >>>>> Regards,
> >>>>> Kishon
> >>>>>>>
> >>>>>>> On Tue, Jun 07, 2022 at 10:26:46AM +0530, Puranjay Mohan wrote:
> >>>>>>>> From: Tero Kristo <t-kristo@ti.com>
> >>>>>>>>
> >>>>>>>> Add two new APIs, pru_rproc_get() and pru_rproc_put(), to the PR=
U
> >>>>>>>> driver to allow client drivers to acquire and release the remote=
proc
> >>>>>>>> device associated with a PRU core. The PRU cores are treated as
> >>>>>>>> resources with only one client owning it at a time.
> >>>>>>>>
> >>>>>>>> The pru_rproc_get() function returns the rproc handle correspond=
ing
> >>>>>>>> to a PRU core identified by the device tree "ti,prus" property u=
nder
> >>>>>>>> the client node. The pru_rproc_put() is the complementary functi=
on
> >>>>>>>> to pru_rproc_get().
> >>>>>>>>
> >>>>>>>> Co-developed-by: Suman Anna <s-anna@ti.com>
> >>>>>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
> >>>>>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >>>>>>>> Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org=
>
> >>>>>>>> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> >>>>>>>> Co-developed-by: Puranjay Mohan <p-mohan@ti.com>
> >>>>>>>> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
> >>>>>>>> ---
> >>>>>>>>   drivers/remoteproc/pru_rproc.c | 138 +++++++++++++++++++++++++=
++++++--
> >>>>>>>>   include/linux/pruss.h          |  56 +++++++++++++
> >>>>>>>>   2 files changed, 189 insertions(+), 5 deletions(-)
> >>>>>>>>   create mode 100644 include/linux/pruss.h
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc=
/pru_rproc.c
> >>>>>>>> index 1777a01fa84e..7a35b400287a 100644
> >>>>>>>> --- a/drivers/remoteproc/pru_rproc.c
> >>>>>>>> +++ b/drivers/remoteproc/pru_rproc.c
> >>>>>>>> @@ -2,12 +2,13 @@
> >>>>>>>>   /*
> >>>>>>>>    * PRU-ICSS remoteproc driver for various TI SoCs
> >>>>>>>>    *
> >>>>>>>> - * Copyright (C) 2014-2020 Texas Instruments Incorporated - htt=
ps://www.ti.com/
> >>>>>>>> + * Copyright (C) 2014-2022 Texas Instruments Incorporated - htt=
ps://www.ti.com/
> >>>>>>>>    *
> >>>>>>>>    * Author(s):
> >>>>>>>>    *   Suman Anna <s-anna@ti.com>
> >>>>>>>>    *   Andrew F. Davis <afd@ti.com>
> >>>>>>>>    *   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org> for Texa=
s Instruments
> >>>>>>>> + *    Puranjay Mohan <p-mohan@ti.com>
> >>>>>>>>    */
> >>>>>>>>   #include <linux/bitops.h>
> >>>>>>>> @@ -16,6 +17,7 @@
> >>>>>>>>   #include <linux/module.h>
> >>>>>>>>   #include <linux/of_device.h>
> >>>>>>>>   #include <linux/of_irq.h>
> >>>>>>>> +#include <linux/pruss.h>
> >>>>>>>>   #include <linux/pruss_driver.h>
> >>>>>>>>   #include <linux/remoteproc.h>
> >>>>>>>> @@ -111,6 +113,8 @@ struct pru_private_data {
> >>>>>>>>    * @rproc: remoteproc pointer for this PRU core
> >>>>>>>>    * @data: PRU core specific data
> >>>>>>>>    * @mem_regions: data for each of the PRU memory regions
> >>>>>>>> + * @client_np: client device node
> >>>>>>>> + * @lock: mutex to protect client usage
> >>>>>>>>    * @fw_name: name of firmware image used during loading
> >>>>>>>>    * @mapped_irq: virtual interrupt numbers of created fw specif=
ic mapping
> >>>>>>>>    * @pru_interrupt_map: pointer to interrupt mapping descriptio=
n (firmware)
> >>>>>>>> @@ -126,6 +130,8 @@ struct pru_rproc {
> >>>>>>>>        struct rproc *rproc;
> >>>>>>>>        const struct pru_private_data *data;
> >>>>>>>>        struct pruss_mem_region mem_regions[PRU_IOMEM_MAX];
> >>>>>>>> +      struct device_node *client_np;
> >>>>>>>> +      struct mutex lock; /* client access lock */
> >>>>>>>>        const char *fw_name;
> >>>>>>>>        unsigned int *mapped_irq;
> >>>>>>>>        struct pru_irq_rsc *pru_interrupt_map;
> >>>>>>>> @@ -146,6 +152,125 @@ void pru_control_write_reg(struct pru_rpro=
c *pru, unsigned int reg, u32 val)
> >>>>>>>>        writel_relaxed(val, pru->mem_regions[PRU_IOMEM_CTRL].va +=
 reg);
> >>>>>>>>   }
> >>>>>>>> +static struct rproc *__pru_rproc_get(struct device_node *np, in=
t index)
> >>>>>>>> +{
> >>>>>>>> +      struct device_node *rproc_np =3D NULL;
> >>>>>>>> +      struct platform_device *pdev;
> >>>>>>>> +      struct rproc *rproc;
> >>>>>>>> +
> >>>>>>>> +      rproc_np =3D of_parse_phandle(np, "ti,prus", index);
> >>>>>>>> +      if (!rproc_np || !of_device_is_available(rproc_np))
> >>>>>>>> +              return ERR_PTR(-ENODEV);
> >>>>>>>> +
> >>>>>>>> +      pdev =3D of_find_device_by_node(rproc_np);
> >>>>>>>> +      of_node_put(rproc_np);
> >>>>>>>> +
> >>>>>>>> +      if (!pdev || !(&pdev->dev) || !((&pdev->dev)->driver))
> >>>>>>>> +              /* probably PRU not yet probed */
> >>>>>>>> +              return ERR_PTR(-EPROBE_DEFER);
> >>>>>>>> +
> >>>>>>>> +      /* make sure it is PRU rproc */
> >>>>>>>> +      if (!is_pru_rproc(&pdev->dev)) {
> >>>>>>>> +              put_device(&pdev->dev);
> >>>>>>>> +              return ERR_PTR(-ENODEV);
> >>>>>>>> +      }
> >>>>>>>> +
> >>>>>>>> +      rproc =3D platform_get_drvdata(pdev);
> >>>>>>>> +      put_device(&pdev->dev);
> >>>>>>>> +      if (!rproc)
> >>>>>>>> +              return ERR_PTR(-EPROBE_DEFER);
> >>>>>>>> +
> >>>>>>>> +      get_device(&rproc->dev);
> >>>>>>>> +
> >>>>>>>> +      return rproc;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +/**
> >>>>>>>> + * pru_rproc_get() - get the PRU rproc instance from a device n=
ode
> >>>>>>>> + * @np: the user/client device node
> >>>>>>>> + * @index: index to use for the ti,prus property
> >>>>>>>> + * @pru_id: optional pointer to return the PRU remoteproc proce=
ssor id
> >>>>>>>> + *
> >>>>>>>> + * This function looks through a client device node's "ti,prus"=
 property at
> >>>>>>>> + * index @index and returns the rproc handle for a valid PRU re=
mote processor if
> >>>>>>>> + * found. The function allows only one user to own the PRU rpro=
c resource at a
> >>>>>>>> + * time. Caller must call pru_rproc_put() when done with using =
the rproc, not
> >>>>>>>> + * required if the function returns a failure.
> >>>>>>>> + *
> >>>>>>>> + * When optional @pru_id pointer is passed the PRU remoteproc p=
rocessor id is
> >>>>>>>> + * returned.
> >>>>>>>> + *
> >>>>>>>> + * Return: rproc handle on success, and an ERR_PTR on failure u=
sing one
> >>>>>>>> + * of the following error values
> >>>>>>>> + *    -ENODEV if device is not found
> >>>>>>>> + *    -EBUSY if PRU is already acquired by anyone
> >>>>>>>> + *    -EPROBE_DEFER is PRU device is not probed yet
> >>>>>>>> + */
> >>>>>>>> +struct rproc *pru_rproc_get(struct device_node *np, int index,
> >>>>>>>> +                          enum pruss_pru_id *pru_id)
> >>>>>>>> +{
> >>>>>>>> +      struct rproc *rproc;
> >>>>>>>> +      struct pru_rproc *pru;
> >>>>>>>> +      struct device *dev;
> >>>>>>>> +
> >>>>>>>> +      try_module_get(THIS_MODULE);
> >>>>>>>
> >>>>>>> There should be a module_put() in pru_rproc_put()...
> >>>>>>
> >>>>>> ... and in the error path of this function.
> >>>>>>
> >>>>>>>
> >>>>>>> More comments to come tomorrow.  I'm especially worried about thi=
s API racing
> >>>>>>> with a remote processor being removed or detached.
> >>>>>>>
> >>>>>>
> >>>>>> Looking at what is done in wkup_m3_ipc_probe(), it should be possi=
ble to call
> >>>>>> rproc_get_by_handle() here and that would make sure the remote pro=
cessor doesn't
> >>>>>> go away before the end of the function.
> >>>>>>
> >>>>>> More comments to come...
> >>>>
> >>>> It is possible to call rproc_get_by_handle() here instead of
> >>>> __pru_get_proc(), but that would not provide multiple functionality.
> >>>>
> >>>> The API rproc_get_by_handle() returns rproc handle on success, and N=
ULL on
> >>>> failure where as __pru_get_proc() returns ERR_PTR on failure which p=
rovides
> >>>> multiple functionality and opportunity for us to distinguish between
> >>>> multiple errors.
> >>>>
> >>>> So we have these three options.
> >>>>
> >>>> 1. If we're using the API rproc_get_by_handle() and we want the mult=
iple
> >>>> ERR_PTR on failure then we will need to change the API rproc_get_by_=
handle()
> >>>> and also all the functions that uses rproc_get_by_handle().
> >>>>
> >>>
> >>> Not optimal.
> >>>
> >>>> 2. Keep the API rproc_get_by_handle() as it is. That will restrict u=
s from
> >>>> using multiple ERR_PTR on different kinds of error.
> >>>>
> >>>
> >>> Not optimal.
> >>>
> >>>> 3. Instead of using rproc_get_by_handle(), keep using __pru_get_proc=
(). This
> >>>> will make sure we have the proper ERR_PTR to retrun for different ki=
nds of
> >>>> errors.
> >>>>
> >>>
> >>> Unacceptable for the reason I already stated.
> >>>
> >>>> Please let me know which option to continue with.
> >>>
> >>> I suggest building a wrapper that does everything you want around rpr=
oc_get_by_phandle().
>
> We can introduce a new API __rproc_get_by_phandle() similar to the API
> rproc_get_by_phandle(). The new API __rproc_get_by_phandle() will do all =
the
> functionality of getting the rproc. On success it will return rproc and o=
n
> failure it will return the different ERR_PTR.
> If rproc is not probed yet, it will return ERR_PTR(-EPROBE_DEFER).
>
> This will make sure that we're getting different error codes for differen=
t
> errors from pru_rproc_get().
>
> The old API rproc_get_by_handle() will invoke the new API. On success the=
 new
> API will return rproc and the old API will also return rproc. On failure =
the
> new API will return different error codes while the old API will preserve=
 it's
> nature and return NULL.

I meant to create a wrapper around rproc_get_by_handle() that is local
to pru_rproc.c.  That way you can enact the behavior you want without
having to constrain others in this specific design.

Thanks,
Mathieu

>
> The API __rproc_get_by_handle will look like this.
>
> struct rproc *__rproc_get_by_handle(phandle phandle)
> {
>         struct rproc *rproc =3D NULL, *r;
>         struct device_node *np;
>
>         np =3D of_find_node_by_phandle(phandle);
>         if (!np)
>                 return NULL;
>
>         rcu_read_lock();
>         list_for_each_entry_rcu(r, &rproc_list, node) {
>                 if (r->dev.parent && r->dev.parent->of_node =3D=3D np) {
>                         /*prevent underlying implementation from being re=
moved */
>                         if (!try_module_get(r->dev.parent->driver->owner)=
) {
>                                 dev_err(&r->dev, "can't get owner\n");
>                                 break;
>                         }
>
>                         rproc =3D r;
>                         get_device(&rproc->dev);
>                         break;
>                 }
>         }
>         rcu_read_unlock();
>
>         of_node_put(np);
>
>         if(!rproc)
>                 return ERR_PTR(-EPROBE_DEFER);
>
>         return rproc;
> }
>
> The API rproc_get_by_handle() will look like this.
>
> struct rproc *rproc_get_by_phandle(phandle phandle)
> {
>         struct rproc *rproc =3D NULL;
>
>         rproc =3D __rproc_get_by_handle(phandle);
>
>         if(!rproc || IS_ERR(rproc))
>                 return NULL;
>
>         return rproc;
> }
>
> This way in pru_rproc_get(), we'll get the rproc by phandle and we'll sti=
ll
> return different error codes depending upon failure cases. We'll also be =
able
> to preserve the actual functionality of rproc_get_by_phandle() so that th=
e
> other APIs using rproc_get_by_phandle() won't get affected.
>
> Please let me know if this looks good.
>
> >>>
> >>
> >> Sure, I'll do that. I'll share this change in v6 of this patch series.
> >
> > I'm able to test the TI prueth driver from the ti-linux-5.10.y tree [1]=
 on a
> > AM5749 cpu (custom board). But I need a more recent kernel (at least 5.=
15) to
> > support other devices recently added to the Linux kernel (wifi6 module =
and an
> > ethernet switch). Also it would be nice if this driver is finally merge=
d in the
> > Linux kernel.
> >
> > Maybe I can help to test this series but I noticed it only provide the =
driver
> > for TI AM654x cpus [2]. Can you also provide patches for basic EMAC sup=
port with
> > the TI AM574x too? (I don't need advanced features like frame timestamp=
ing, HSR
> > etc).
> >
> > Also, what about patches present in the ti-linux-kernel tree and not in=
cluded
> > this this series? Especially patches that modify the kernel network sta=
ck [3]
> > (net/rpmsg: add support for new rpmsg sockets). Is this new socket prot=
ocol
> > really needed?
> >
> > Notice the patch adding the rpmsg sockets [3] already conflict with the=
 upstream
> > kernel since the AF_MCTP definition now use the value temporarly used b=
y
> > AF_RPMSG [4].
> >
> > Can you send an updated version of the complete series?
> >
> > Thanks!
> >
> > [1] https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/log/?h=3Dti=
-linux-5.10.y
> >
> > [2] https://lore.kernel.org/linux-remoteproc/20220406094358.7895-1-p-mo=
han@ti.com/
> >
> > [3]
> > https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?h=3Dti-=
linux-5.10.y&id=3Df4b978a978c38149f712ddd137f12ed5fb914161
> >
> > [4]
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/?id=3Dbc49d8169aa72295104f1558830c568efb946315
> >
> > Best regards,
> > Romain
> >
> >
> >>
> >>>>
> >>>> Thanks,
> >>>> Danish
> >>>>
> >>>>
> >>>>>>
> >>>>>>
> >>>>>>> Thanks,
> >>>>>>> Mathieu
> >>>>>>>
> >>>>>>>> +
> >>>>>>>> +      rproc =3D __pru_rproc_get(np, index);
> >>>>>>>> +      if (IS_ERR(rproc))
> >>>>>>>> +              return rproc;
> >>>>>>>> +
> >>>>>>>> +      pru =3D rproc->priv;
> >>>>>>>> +      dev =3D &rproc->dev;
> >>>>>>>> +
> >>>>>>>> +      mutex_lock(&pru->lock);
> >>>>>>>> +
> >>>>>>>> +      if (pru->client_np) {
> >>>>>>>> +              mutex_unlock(&pru->lock);
> >>>>>>>> +              put_device(dev);
> >>>>>>>> +              return ERR_PTR(-EBUSY);
> >>>>>>>> +      }
> >>>>>>>> +
> >>>>>>>> +      pru->client_np =3D np;
> >>>>>>>> +
> >>>>>>>> +      mutex_unlock(&pru->lock);
> >>>>>>>> +
> >>>>>>>> +      if (pru_id)
> >>>>>>>> +              *pru_id =3D pru->id;
> >>>>>>>> +
> >>>>>>>> +      return rproc;
> >>>>>>>> +}
> >>>>>>>> +EXPORT_SYMBOL_GPL(pru_rproc_get);
> >>>>>>>> +
> >>>>>>>> +/**
> >>>>>>>> + * pru_rproc_put() - release the PRU rproc resource
> >>>>>>>> + * @rproc: the rproc resource to release
> >>>>>>>> + *
> >>>>>>>> + * Releases the PRU rproc resource and makes it available to ot=
her
> >>>>>>>> + * users.
> >>>>>>>> + */
> >>>>>>>> +void pru_rproc_put(struct rproc *rproc)
> >>>>>>>> +{
> >>>>>>>> +      struct pru_rproc *pru;
> >>>>>>>> +
> >>>>>>>> +      if (IS_ERR_OR_NULL(rproc) || !is_pru_rproc(rproc->dev.par=
ent))
> >>>>>>>> +              return;
> >>>>>>>> +
> >>>>>>>> +      pru =3D rproc->priv;
> >>>>>>>> +
> >>>>>>>> +      mutex_lock(&pru->lock);
> >>>>>>>> +
> >>>>>>>> +      if (!pru->client_np) {
> >>>>>>>> +              mutex_unlock(&pru->lock);
> >>>>>>>> +              return;
> >>>>>>>> +      }
> >>>>>>>> +
> >>>>>>>> +      pru->client_np =3D NULL;
> >>>>>>>> +      mutex_unlock(&pru->lock);
> >>>>>>>> +
> >>>>>>>> +      put_device(&rproc->dev);
> >>>>>>>> +}
> >>>>>>>> +EXPORT_SYMBOL_GPL(pru_rproc_put);
> >>>>>>>> +
> >>>>>>>>   static inline u32 pru_debug_read_reg(struct pru_rproc *pru, un=
signed int reg)
> >>>>>>>>   {
> >>>>>>>>        return readl_relaxed(pru->mem_regions[PRU_IOMEM_DEBUG].va=
 + reg);
> >>>>>>>> @@ -438,7 +563,7 @@ static void *pru_d_da_to_va(struct pru_rproc=
 *pru, u32 da, size_t len)
> >>>>>>>>        dram0 =3D pruss->mem_regions[PRUSS_MEM_DRAM0];
> >>>>>>>>        dram1 =3D pruss->mem_regions[PRUSS_MEM_DRAM1];
> >>>>>>>>        /* PRU1 has its local RAM addresses reversed */
> >>>>>>>> -      if (pru->id =3D=3D 1)
> >>>>>>>> +      if (pru->id =3D=3D PRUSS_PRU1)
> >>>>>>>>                swap(dram0, dram1);
> >>>>>>>>        shrd_ram =3D pruss->mem_regions[PRUSS_MEM_SHRD_RAM2];
> >>>>>>>> @@ -747,14 +872,14 @@ static int pru_rproc_set_id(struct pru_rpr=
oc *pru)
> >>>>>>>>        case RTU0_IRAM_ADDR_MASK:
> >>>>>>>>                fallthrough;
> >>>>>>>>        case PRU0_IRAM_ADDR_MASK:
> >>>>>>>> -              pru->id =3D 0;
> >>>>>>>> +              pru->id =3D PRUSS_PRU0;
> >>>>>>>>                break;
> >>>>>>>>        case TX_PRU1_IRAM_ADDR_MASK:
> >>>>>>>>                fallthrough;
> >>>>>>>>        case RTU1_IRAM_ADDR_MASK:
> >>>>>>>>                fallthrough;
> >>>>>>>>        case PRU1_IRAM_ADDR_MASK:
> >>>>>>>> -              pru->id =3D 1;
> >>>>>>>> +              pru->id =3D PRUSS_PRU1;
> >>>>>>>>                break;
> >>>>>>>>        default:
> >>>>>>>>                ret =3D -EINVAL;
> >>>>>>>> @@ -816,6 +941,8 @@ static int pru_rproc_probe(struct platform_d=
evice *pdev)
> >>>>>>>>        pru->pruss =3D platform_get_drvdata(ppdev);
> >>>>>>>>        pru->rproc =3D rproc;
> >>>>>>>>        pru->fw_name =3D fw_name;
> >>>>>>>> +      pru->client_np =3D NULL;
> >>>>>>>> +      mutex_init(&pru->lock);
> >>>>>>>>        for (i =3D 0; i < ARRAY_SIZE(mem_names); i++) {
> >>>>>>>>                res =3D platform_get_resource_byname(pdev, IORESO=
URCE_MEM,
> >>>>>>>> @@ -903,7 +1030,7 @@ MODULE_DEVICE_TABLE(of, pru_rproc_match);
> >>>>>>>>   static struct platform_driver pru_rproc_driver =3D {
> >>>>>>>>        .driver =3D {
> >>>>>>>> -              .name   =3D "pru-rproc",
> >>>>>>>> +              .name   =3D PRU_RPROC_DRVNAME,
> >>>>>>>>                .of_match_table =3D pru_rproc_match,
> >>>>>>>>                .suppress_bind_attrs =3D true,
> >>>>>>>>        },
> >>>>>>>> @@ -915,5 +1042,6 @@ module_platform_driver(pru_rproc_driver);
> >>>>>>>>   MODULE_AUTHOR("Suman Anna <s-anna@ti.com>");
> >>>>>>>>   MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
> >>>>>>>>   MODULE_AUTHOR("Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org=
>");
> >>>>>>>> +MODULE_AUTHOR("Puranjay Mohan <p-mohan@ti.com>");
> >>>>>>>>   MODULE_DESCRIPTION("PRU-ICSS Remote Processor Driver");
> >>>>>>>>   MODULE_LICENSE("GPL v2");
> >>>>>>>> diff --git a/include/linux/pruss.h b/include/linux/pruss.h
> >>>>>>>> new file mode 100644
> >>>>>>>> index 000000000000..fdc719b43db0
> >>>>>>>> --- /dev/null
> >>>>>>>> +++ b/include/linux/pruss.h
> >>>>>>>> @@ -0,0 +1,56 @@
> >>>>>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
> >>>>>>>> +/**
> >>>>>>>> + * PRU-ICSS Subsystem user interfaces
> >>>>>>>> + *
> >>>>>>>> + * Copyright (C) 2015-2022 Texas Instruments Incorporated - htt=
p://www.ti.com
> >>>>>>>> + *    Suman Anna <s-anna@ti.com>
> >>>>>>>> + */
> >>>>>>>> +
> >>>>>>>> +#ifndef __LINUX_PRUSS_H
> >>>>>>>> +#define __LINUX_PRUSS_H
> >>>>>>>> +
> >>>>>>>> +#include <linux/device.h>
> >>>>>>>> +#include <linux/types.h>
> >>>>>>>> +
> >>>>>>>> +#define PRU_RPROC_DRVNAME "pru-rproc"
> >>>>>>>> +
> >>>>>>>> +/*
> >>>>>>>> + * enum pruss_pru_id - PRU core identifiers
> >>>>>>>> + */
> >>>>>>>> +enum pruss_pru_id {
> >>>>>>>> +      PRUSS_PRU0 =3D 0,
> >>>>>>>> +      PRUSS_PRU1,
> >>>>>>>> +      PRUSS_NUM_PRUS,
> >>>>>>>> +};
> >>>>>>>> +
> >>>>>>>> +struct device_node;
> >>>>>>>> +
> >>>>>>>> +#if IS_ENABLED(CONFIG_PRU_REMOTEPROC)
> >>>>>>>> +
> >>>>>>>> +struct rproc *pru_rproc_get(struct device_node *np, int index,
> >>>>>>>> +                          enum pruss_pru_id *pru_id);
> >>>>>>>> +void pru_rproc_put(struct rproc *rproc);
> >>>>>>>> +
> >>>>>>>> +#else
> >>>>>>>> +
> >>>>>>>> +static inline struct rproc *
> >>>>>>>> +pru_rproc_get(struct device_node *np, int index, enum pruss_pru=
_id *pru_id)
> >>>>>>>> +{
> >>>>>>>> +      return ERR_PTR(-EOPNOTSUPP);
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static inline void pru_rproc_put(struct rproc *rproc) { }
> >>>>>>>> +
> >>>>>>>> +#endif /* CONFIG_PRU_REMOTEPROC */
> >>>>>>>> +
> >>>>>>>> +static inline bool is_pru_rproc(struct device *dev)
> >>>>>>>> +{
> >>>>>>>> +      const char *drv_name =3D dev_driver_string(dev);
> >>>>>>>> +
> >>>>>>>> +      if (strncmp(drv_name, PRU_RPROC_DRVNAME, sizeof(PRU_RPROC=
_DRVNAME)))
> >>>>>>>> +              return false;
> >>>>>>>> +
> >>>>>>>> +      return true;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +#endif /* __LINUX_PRUSS_H */
> >>>>>>>> --
> >>>>>>>> 2.17.1
> >>>>>>>>
> >>
> >
