Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2508729DB5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241676AbjFIPCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238987AbjFIPCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:02:50 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88061FEB;
        Fri,  9 Jun 2023 08:02:48 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30e5289105cso1441865f8f.1;
        Fri, 09 Jun 2023 08:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686322967; x=1688914967;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kyh0drEh7i0RL6QHKLUUjH8KeXIoQQqVsBzHXVqUBVY=;
        b=AQQKvXj3Ij2Khufgucqv8n4/9NwTgCBuPOJBVHmAPHaC/zlnvcGySQaawyRvnxxOy/
         yWzdFI6B9oPKRX48fB/qwWzlJj8keWB2x+6N7hoNhToz7RqkgTUun+Y2U8YYj2LyZruD
         smKf+uSEvA6wjQMnT/Dg8PHZ1jv/rem/Npdk7Ek2CTjlKqueX/jAw/RP6IkqPDJTHGVN
         Y46u2fQmL8jOD2gnXy/UCgopuBFE/2o5xu2POmuxaLlO3qHHpC49927psVf2kGiPvWtD
         4foYVKlAE55EuVYA9U0c3SUX5zT3eTCTZgbZhMdKJnRAkvoxRDq9IQfQJfxDKsFffPw3
         RDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686322967; x=1688914967;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyh0drEh7i0RL6QHKLUUjH8KeXIoQQqVsBzHXVqUBVY=;
        b=i/YUf2Wz3c1xlEbhcAx+zQn6wuZt/9YjhoPK4CvvVZYM0p/5bIX3rMTYMOWSLIcUuy
         CkNvCvZzKUORk3aOsFroQTRlDgSfHikorLpkSmKQ8ZhPzvXvtkmaSoXZ+HV8PAL1WAys
         m7cZuqVIn6oUakw76grAhmAjd+34+WsPdWb/rRIXM0SexC93WAIiJ6aP9YhWnEH7u0zq
         34e/8X6fc1BklQn4zt7fPAH7hAdv0TK3tjOtEcX76HXsYociJGjxM2956ByiU4TVrvlE
         sN9ZXM6uDGFOSIT4v0Oktw7mcPuZZ025C+5YU+PECFatKoADs6f81pWJ23iGnXK0QJgo
         qbow==
X-Gm-Message-State: AC+VfDyLkLe8f5baSrorZksQ1WIcFWi/2F2SLti5a8kcSfIyQGxx0m2A
        AcgjQFBI3CIoCmm3npDe5a8=
X-Google-Smtp-Source: ACHHUZ5Xtm/6kx6UxB6YH2IychcCTwaDzV2MukX1cSBPGYJD4FvcY5t12A29LBE8dtSW27E7yOa8Qg==
X-Received: by 2002:a5d:42cc:0:b0:30a:aeb3:f3b0 with SMTP id t12-20020a5d42cc000000b0030aaeb3f3b0mr4837660wrr.17.1686322966994;
        Fri, 09 Jun 2023 08:02:46 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c230600b003f41bb52834sm2949655wmo.38.2023.06.09.08.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:02:46 -0700 (PDT)
Message-ID: <64833f16.050a0220.5c39c.20ce@mx.google.com>
X-Google-Original-Message-ID: <ZIM/FHhE1v0+s2dT@Ansuel-xps.>
Date:   Fri, 9 Jun 2023 17:02:44 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Robert Marko <robimarko@gmail.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, ilia.lin@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [RESEND PATCH v2 2/2] cpufreq: qcom-nvmem: add support for
 IPQ8064
References: <20230530165807.642084-1-robimarko@gmail.com>
 <20230530165807.642084-2-robimarko@gmail.com>
 <3f1bfaf9-35ff-59ae-6756-84fc8900ed92@linaro.org>
 <647708e2.050a0220.514c7.feab@mx.google.com>
 <517f8b82-1230-985a-811a-2100f0dd339e@linaro.org>
 <6483353e.7b0a0220.65698.0e15@mx.google.com>
 <CAA8EJpqCiWFxVSbMLViJaVvAqVVu9Tx6SAUovDH9GraeTYH4HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpqCiWFxVSbMLViJaVvAqVVu9Tx6SAUovDH9GraeTYH4HA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 05:53:40PM +0300, Dmitry Baryshkov wrote:
> On Fri, 9 Jun 2023 at 17:21, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > On Thu, Jun 01, 2023 at 06:07:17PM +0300, Dmitry Baryshkov wrote:
> > > On 31/05/2023 04:36, Christian Marangi wrote:
> > > > On Wed, May 31, 2023 at 05:03:01AM +0300, Dmitry Baryshkov wrote:
> > > > > On 30/05/2023 19:58, Robert Marko wrote:
> > > > > > From: Christian Marangi <ansuelsmth@gmail.com>
> > > > > >
> > > > > > IPQ8064 comes in 3 families:
> > > > > > * IPQ8062 up to 1.0GHz
> > > > > > * IPQ8064/IPQ8066/IPQ8068 up to 1.4GHz
> > > > > > * IPQ8065/IPQ8069 up to 1.7Ghz
> > > > > >
> > > > > > So, in order to be able to share one OPP table, add support for
> > > > > > IPQ8064 family based of SMEM SoC ID-s as speedbin fuse is always 0 on
> > > > > > IPQ8064.
> > > > > >
> > > > > > Bit are set with the following logic:
> > > > > > * IPQ8062 BIT 0
> > > > > > * IPQ8064/IPQ8066/IPQ8068 BIT 1
> > > > > > * IPQ8065/IPQ8069 BIT 2
> > > > > >
> > > > > > speed is never fused, only psv values are fused.
> > > > > > Set speed to the versions to permit a unified opp table following
> > > > > > this named opp:
> > > > > >
> > > > > > opp-microvolt-speed<SPEED_VALUE>-pvs<PSV_VALUE>-v0
> > > > > >
> > > > > > Example:
> > > > > > - for ipq8062 psv2
> > > > > >     opp-microvolt-speed0-pvs2-v0 = < 925000 878750 971250>
> > > > > > - for ipq8064 psv2
> > > > > >     opp-microvolt-speed2-pvs2-v0 = <925000 878750 971250>;
> > > > > > - for ipq8065 psv2
> > > > > >     opp-microvolt-speed4-pvs2-v0 = <950000 902500 997500>;
> > > > > >
> > > > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > > > > ---
> > > > > >    drivers/cpufreq/qcom-cpufreq-nvmem.c | 73 +++++++++++++++++++++++++++-
> > > > > >    1 file changed, 72 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > > > > > index ce444b5962f2..c644138680ba 100644
> > > > > > --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > > > > > +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > > > > > @@ -34,6 +34,10 @@
> > > > > >    #define IPQ8074_HAWKEYE_VERSION              BIT(0)
> > > > > >    #define IPQ8074_ACORN_VERSION                BIT(1)
> > > > > > +#define IPQ8062_VERSION                BIT(0)
> > > > > > +#define IPQ8064_VERSION                BIT(1)
> > > > > > +#define IPQ8065_VERSION                BIT(2)
> > > > >
> > > > > I think it would be more logical to change these defines to consecutive enum
> > > > > instead of BIT(n) values. Another (and better in my opinion) option is to
> > > > > drop versions completely (and remove speedN from the opp names) and to have
> > > > > per-SoC tables in per-SoC dtsi files. There are already separate
> > > > > ipq8064.dtsi, ipq8062.dtsi and ipq8065.dtsi files. It makes little sense to
> > > > > overcomplicate the OPP tables.
> > > > >
> > > >
> > > > That is what was used downstream but it was also wrong and against the
> > > > normal implementation of this driver itself.
> > > >
> > > > OPP have opp-supported-hw just for the task with the principle of
> > > > declaring a single table in dtsi and automatically select the right one.
> > > >
> > > > Using the implementation downstream (opp table in each dtsi) is actually
> > > > worse as ipq8065 have 1.4ghz and not 1.2ghz and that can correctly be
> > > > handled with opp-supported-hw (and this change) or using delete-property
> > > > in dtsi (that I don't really like and it's ugly)
> > > >
> > > > Also this implementation would match what is currently secribed for the
> > > > use of OPP in the documentation.
> > > >
> > > > Hope you can understand the reason of this change, the intention is to
> > > > clear and trying to use standard OPP stuff instead of hacks in the DTS.
> > >
> > > I'm fine with the opp-supported-hw part (I forgot that it is used by default
> > > with the help of drv->versions). I do not like the idea of encoding the same
> > > value into the -speedN part. If it is not needed, it's better be dropped
> > > than using a semi-dummy value there.
> > >
> > > So, I'd suggest to define an enum, use BIT(enum_value) for drv->versions and
> > > drop the speed%d part.
> > >
> > > Also, while we are at it, could you please define a schema for your opp
> > > extensions? An example would make it easier to understand the bindings (and
> > > will also provide a reference for possible other implementers).
> > >
> >
> > Sorry for the delay in answering this.
> >
> > The speed part is still needed... since the voltage for each voltage
> > change on the different SoC.
> >
> > Let me give you an example for one freq.
> >
> >                 opp-384000000 {
> >                         opp-hz = /bits/ 64 <384000000>;
> >                         opp-microvolt-speed0-pvs0-v0 = <1000000 950000 1050000>;
> >                         opp-microvolt-speed0-pvs1-v0 = <925000 878750 971250>;
> >                         opp-microvolt-speed0-pvs2-v0 = <875000 831250 918750>;
> >                         opp-microvolt-speed0-pvs3-v0 = <800000 760000 840000>;
> >                         opp-microvolt-speed2-pvs0-v0 = <1000000 950000 1050000>;
> >                         opp-microvolt-speed2-pvs1-v0 = <925000 878750 971250>;
> >                         opp-microvolt-speed2-pvs2-v0 = <875000 831250 918750>;
> >                         opp-microvolt-speed2-pvs3-v0 = <800000 760000 840000>;
> >                         opp-microvolt-speed4-pvs0-v0 = <975000 926250 1023750>;
> >                         opp-microvolt-speed4-pvs1-v0 = <950000 902500 997500>;
> >                         opp-microvolt-speed4-pvs2-v0 = <925000 878750 971250>;
> >                         opp-microvolt-speed4-pvs3-v0 = <900000 855000 945000>;
> >                         opp-microvolt-speed4-pvs4-v0 = <875000 831250 918750>;
> >                         opp-microvolt-speed4-pvs5-v0 = <825000 783750 866250>;
> >                         opp-microvolt-speed4-pvs6-v0 = <775000 736250 813750>;
> >                         opp-supported-hw = <0x7>;
> >                         clock-latency-ns = <100000>;
> >                 };
> 
> What about (it will require changes to opp-v2-base.yaml):
> 
> opp-384000000-0 {
>     opp-hz = /bits/ 64 <384000000>;
>     opp-microvolt-pvs0-v0 = <1000000 950000 1050000>;
>     opp-microvolt-pvs1-v0 = <925000 878750 971250>;
>     opp-microvolt-pvs2-v0 = <875000 831250 918750>;
>     opp-microvolt-pvs3-v0 = <800000 760000 840000>;
>     opp-supported-hw = <0x1>;
>     clock-latency-ns = <100000>;
> };
> 
> opp-384000000-1 {
>     opp-hz = /bits/ 64 <384000000>;
>     opp-microvolt-pvs0-v0 = <1000000 950000 1050000>;
>     opp-microvolt-pvs1-v0 = <925000 878750 971250>;
>     opp-microvolt-pvs2-v0 = <875000 831250 918750>;
>     opp-microvolt-pvs3-v0 = <800000 760000 840000>;
>    opp-supported-hw = <0x2>;
>     clock-latency-ns = <100000>;
> };
> 
> opp-384000000-2 {
>     opp-hz = /bits/ 64 <384000000>;
>     opp-microvolt-pvs0-v0 = <975000 926250 1023750>;
>     opp-microvolt-pvs1-v0 = <950000 902500 997500>;
>     opp-microvolt-pvs2-v0 = <925000 878750 971250>;
>     opp-microvolt-pvs3-v0 = <900000 855000 945000>;
>     opp-microvolt-pvs4-v0 = <875000 831250 918750>;
>     opp-microvolt-pvs5-v0 = <825000 783750 866250>;
>     opp-microvolt-pvs6-v0 = <775000 736250 813750>;
>     opp-supported-hw = <0x4>;
>     clock-latency-ns = <100000>;
> };
> 
>

Mhhhhhh is it really worth it? Would also require to modify the pattern
currently used in the qcom-cpufreq-nvmem that is speedXX-pvsXX-vXX.

ipq806x is really krait cpu not correctly fused. I expect downstream the
same pattern to be used widely with other krait based systems so the
idea was to not reinvent the wheel. (introducing a different pattern
also means additional condition in the schema)

If we really don't want to have big opp table in one dtsi I can consider
redefining the same opp table in the different dtsi. (the
opp-supported-hw was really needed for the 1.2ghz problem, if asked I
can still split the table in the related dtsi but I don't really like
it)

Anyway I'm open to both solution.
If it's ok to change the pattern I would change it directly to something
like opp-microvolt-pvs since even pvs version is always 0.

I'm honestly against the idea of defining multiple opp-table for the
same freq (and also change the base schema) since we can do the same
thing by just overwriting the table in the other dtsi.

> > As you can see we use the speed value to match the different SoC and
> > apply the correct voltage.
> >
> > Yes I will add the missing info in the schema.
> >
> > > >
> > > > > > +
> > > > > >    struct qcom_cpufreq_drv;
> > > > > >    struct qcom_cpufreq_match_data {
> > > > > > @@ -207,6 +211,69 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
> > > > > >         return ret;
> > > > > >    }
> > > > > > +static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
> > > > > > +                                            struct nvmem_cell *speedbin_nvmem,
> > > > > > +                                            char **pvs_name,
> > > > > > +                                            struct qcom_cpufreq_drv *drv)
> > > > > > +{
> > > > > > +       int speed = 0, pvs = 0, pvs_ver = 0;
> > > > > > +       int msm_id, ret = 0;
> > > > > > +       u8 *speedbin;
> > > > > > +       size_t len;
> > > > > > +
> > > > > > +       speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> > > > > > +
> > > > > > +       if (IS_ERR(speedbin))
> > > > > > +               return PTR_ERR(speedbin);
> > > > > > +
> > > > > > +       switch (len) {
> > > > > > +       case 4:
> > > > > > +               get_krait_bin_format_a(cpu_dev, &speed, &pvs, &pvs_ver,
> > > > > > +                                      speedbin);
> > > > > > +               break;
> > > > > > +       default:
> > > > > > +               dev_err(cpu_dev, "Unable to read nvmem data. Defaulting to 0!\n");
> > > > > > +               ret = -ENODEV;
> > > > > > +               goto len_error;
> > > > > > +       }
> > > > > > +
> > > > > > +       ret = qcom_smem_get_soc_id(&msm_id);
> > > > > > +       if (ret)
> > > > > > +               return ret;
> > > > > > +
> > > > > > +       switch (msm_id) {
> > > > > > +       case QCOM_ID_IPQ8062:
> > > > > > +               drv->versions = IPQ8062_VERSION;
> > > > > > +               break;
> > > > > > +       case QCOM_ID_IPQ8064:
> > > > > > +       case QCOM_ID_IPQ8066:
> > > > > > +       case QCOM_ID_IPQ8068:
> > > > > > +               drv->versions = IPQ8064_VERSION;
> > > > > > +               break;
> > > > > > +       case QCOM_ID_IPQ8065:
> > > > > > +       case QCOM_ID_IPQ8069:
> > > > > > +               drv->versions = IPQ8065_VERSION;
> > > > > > +               break;
> > > > > > +       default:
> > > > > > +               dev_err(cpu_dev,
> > > > > > +                       "SoC ID %u is not part of IPQ8064 family, limiting to 1.0GHz!\n",
> > > > > > +                       msm_id);
> > > > > > +               drv->versions = IPQ8062_VERSION;
> > > > > > +               break;
> > > > > > +       }
> > > > > > +
> > > > > > +       /*
> > > > > > +        * IPQ8064 speed is never fused. Only psv values are fused.
> > > > > > +        * Set speed to the versions to permit a unified opp table.
> > > > > > +        */
> > > > > > +       snprintf(*pvs_name, sizeof("speedXX-pvsXX-vXX"), "speed%d-pvs%d-v%d",
> > > > > > +                drv->versions, pvs, pvs_ver);
> > > > > > +
> > > > > > +len_error:
> > > > > > +       kfree(speedbin);
> > > > > > +       return ret;
> > > > > > +}
> > > > > > +
> > > > > >    static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
> > > > > >                                              struct nvmem_cell *speedbin_nvmem,
> > > > > >                                              char **pvs_name,
> 
> 
> -- 
> With best wishes
> Dmitry

-- 
	Ansuel
