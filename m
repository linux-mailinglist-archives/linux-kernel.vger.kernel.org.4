Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EBF5BBB03
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 01:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiIQX7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 19:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIQX7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 19:59:17 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3C62A712;
        Sat, 17 Sep 2022 16:59:16 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t14so41653148wrx.8;
        Sat, 17 Sep 2022 16:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date;
        bh=xcj3QHZVq7X3o4/R+MjpHzJBysypAsFYDAvh1iyPhso=;
        b=NvAcuQOv67JAuTun7VqDsmHeJSDveVovdoFB9UA7GoxPq4sRg49IMc5ijZJfcv80Ki
         L13NhoujjeKE1UEmasCLSY8QQgX3ATckb2sIp20puVrY4DqlGqT1gjKMwN84UPBe2f7+
         yZkxwMUrK04PQw13RedER79pEfUCfYGXV9Qik/tR/MERf4sk1JP9FYNQWqYA2J9yL01y
         ozseHjVaDCF1NedbqvgClCN2JmtF2Hb59JuokXBklArFQi+j68mUoGz3BIBcYcYtW7uG
         h+7m9SRW7MNN93xOVl3GuXiUQBiEiPbt6ELMlidVFmnZ8beKN7C/+nTVXtIWoTVDJHcN
         665Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=xcj3QHZVq7X3o4/R+MjpHzJBysypAsFYDAvh1iyPhso=;
        b=4ssTQlb+AeiOEpVTCC5B5MDnbqqCR8jAfaBSLMIxG6ZQJKTPyL65LoNC5V9gt4LWEb
         UuNK77I7CeMAkhkYxNjm+xAMpHIY3zuRIWjfurl0Wk7WFVcT0c05ZtfUxsVnI+DvwV6n
         ZSvTD4c2VClBy38gmujrWcE28Txrx39CGCcCEjjIhJZe7wmFOP0vQVD41PQkrgIUC7cd
         BnXMWfJue3g+3OtHn6cvLMQ3xV37pPUNhuU39XpK4i/brVak98W6gruWOfjfBP0RCAMn
         lacutGAPK4z4996njvnSmkhqR/bhkK+xEqyuOYlH3S2OKKBQ1dkO1cXvO4w5eAZvCpP0
         fZ1w==
X-Gm-Message-State: ACrzQf3yAPLvAnmqlfYTyw9DJuaSBDFFq8vEKvYUKy+eptrCtmLd+gHk
        HTMQ7V9moNnu3IzRrBpkEZ89SIwfTJU=
X-Google-Smtp-Source: AMsMyM48rllysIhiO0I2d5kH2MMIQDSzGD2ebCEgXFCtuEI7dZ9sZKpzGxAiCxDqwO4UjPEAymzvIQ==
X-Received: by 2002:a5d:65c2:0:b0:228:68b7:e7b2 with SMTP id e2-20020a5d65c2000000b0022868b7e7b2mr6615005wrw.440.1663459154655;
        Sat, 17 Sep 2022 16:59:14 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b003b49bd61b19sm2455055wmn.15.2022.09.17.16.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 16:59:14 -0700 (PDT)
Message-ID: <63265f52.050a0220.93255.3a4c@mx.google.com>
X-Google-Original-Message-ID: <YyY04tNY4I1FJhOY@Ansuel-xps.>
Date:   Sat, 17 Sep 2022 22:58:10 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Christian Brauner <brauner@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Marc Herbert <marc.herbert@intel.com>,
        James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 2/5] dt-bindings: arm: msm: Convert kpss-acc driver
 Documentation to yaml
References: <CAA8EJprEQOsm4TxGWJYZo04D1PagT3QmhDdYQkEid-KSP-tpTw@mail.gmail.com>
 <6324d8e1.170a0220.aba35.ba4f@mx.google.com>
 <CAA8EJpowLvkuiYupqS0WEhnMR8q=R1YUUFgdFVCAx1PXyoo1xw@mail.gmail.com>
 <6324dc1b.df0a0220.97787.083c@mx.google.com>
 <CAA8EJpo08WoQ_LYOtg5C2BB=Q6GR_cftLjaWHWjYD6BjfDZcsg@mail.gmail.com>
 <6324f087.1c0a0220.7123d.8665@mx.google.com>
 <CAA8EJprhLUybqmPhFmit6LGaNOxz=-9+8xADXowJuzU5BtjjtA@mail.gmail.com>
 <632618ac.050a0220.bda86.d7a8@mx.google.com>
 <63262383.df0a0220.27cbb.1c41@mx.google.com>
 <7F54CF10-F2EF-46C6-B291-9339FE5D10E4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F54CF10-F2EF-46C6-B291-9339FE5D10E4@linaro.org>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 11:46:23PM +0300, Dmitry Baryshkov wrote:
> 
> 
> On 17 September 2022 22:44:00 GMT+03:00, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >On Sat, Sep 17, 2022 at 08:57:44PM +0200, Christian Marangi wrote:
> >> On Sat, Sep 17, 2022 at 04:45:21PM +0300, Dmitry Baryshkov wrote:
> >> > On Sat, 17 Sept 2022 at 00:54, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >> > >
> >> > > On Fri, Sep 16, 2022 at 11:31:49PM +0300, Dmitry Baryshkov wrote:
> >> > > > On Fri, 16 Sept 2022 at 23:27, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >> > > > >
> >> > > > > On Fri, Sep 16, 2022 at 11:22:17PM +0300, Dmitry Baryshkov wrote:
> >> > > > > > On Fri, 16 Sept 2022 at 23:13, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >> > > > > > >
> >> > > > > > > On Fri, Sep 16, 2022 at 11:06:35PM +0300, Dmitry Baryshkov wrote:
> >> > > > > > > > On Fri, 16 Sept 2022 at 22:43, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >> > > > > > > > >
> >> > > > > > > > > On Fri, Sep 16, 2022 at 02:17:15PM -0500, Rob Herring wrote:
> >> > > > > > > > > > On Wed, Sep 14, 2022 at 04:22:53PM +0200, Christian Marangi wrote:
> >> > > > > > > > > > > Convert kpss-acc driver Documentation to yaml.
> >> > > > > > > > > > > The original Documentation was wrong all along. Fix it while we are
> >> > > > > > > > > > > converting it.
> >> > > > > > > > > > > The example was wrong as kpss-acc-v2 should only expose the regs but we
> >> > > > > > > > > > > don't have any driver that expose additional clocks. The kpss-acc driver
> >> > > > > > > > > > > is only specific to v1. For this exact reason, limit all the additional
> >> > > > > > > > > > > bindings (clocks, clock-names, clock-output-names and #clock-cells) to
> >> > > > > > > > > > > v1 and also flag that these bindings should NOT be used for v2.
> >> > > > > > > > > >
> >> > > > > > > > > > Odd that a clock controller has no clocks, but okay.
> >> > > > > > > > > >
> >> > > > > > > > >
> >> > > > > > > > > As said in the commit v2 is only used for regs. v2 it's only used in
> >> > > > > > > > > arch/arm/mach-qcom/platsmp.c to setup stuff cpu hotplug and bringup.
> >> > > > > > > > >
> >> > > > > > > > > Should we split the 2 driver? To me the acc naming seems to be just
> >> > > > > > > > > recycled for v2 and it's not really a clk controller.
> >> > > > > > > > >
> >> > > > > > > > > So keeping v2 in arm/msm/qcom,kpss-acc-v2.yaml and v1 moved to clock?
> >> > > > > > > >
> >> > > > > > > > I suspect that qcom,kpss-acc-v2 is misnamed as the "clock-controller".
> >> > > > > > > > According to msm-3.10, these regions are used by the Krait core
> >> > > > > > > > regulators.
> >> > > > > > > >
> >> > > > > > >
> >> > > > > > > Well we need to understand how to handle this... change the compatible
> >> > > > > > > it's a nono for sure. In platsmp.c they are used for cpu power control
> >> > > > > > > so could be that they are actually used to regulators. I would honestly
> >> > > > > > > move v1 to clock and leave v2 to arm/msm but I'm not cetain on what name
> >> > > > > > > to assign to the 2 yaml.
> >> > > > > > >
> >> > > > > > > What do you think?
> >> > > > > >
> >> > > > > > This is fine for me. If somebody gets better understanding of
> >> > > > > > underlying hardware and works on actually using these blocks, he will
> >> > > > > > update the bindings.
> >> > > > > >
> >> > > > > > My only suggestion would be to rename kpss-acc-v2 nodes to
> >> > > > > > 'power-controller@address' and document them so.
> >> > > > > >
> >> > > > >
> >> > > > > Ok so something like this?
> >> > > > >
> >> > > > >     power-controller@f9088000 {
> >> > > > >       compatible = "qcom,kpss-acc-v2";
> >> > > > >       reg = <0xf9088000 0x1000>,
> >> > > > >             <0xf9008000 0x1000>;
> >> > > > >     };
> >> > > > >
> >> > > > > (and I will have to fix dtbs warning as they will be unmatched I think.)
> >> > > > > Yaml naming:
> >> > > > > qcom,kpss-acc-v1.yaml
> >> > > > > qcom,kpss-acc-v2.yaml
> >> > > > > Right?
> >> > > >
> >> > > > Sounds good to me.
> >> > > >
> >> > > > I'd even say clock/qcom,kpss-acc-v1.yaml and
> >> > > > arm/msm/qcom,kpss-acc-v2.yaml or maybe power/qcom,kpss-acc-v2.yaml
> >> > > >
> >> > >
> >> > > Wonder if the gcc driver should have the same tretement? It's also a
> >> > > clock-controller driver that doesn't use clock at all... Do you have
> >> > > some info about it?
> >> > 
> >> > As far as I understand, the kpss-gcc is a normal clock controller,
> >> > isn't it? It provides clocks to other devices.
> >> > 
> >> 
> >> Hi again... Having acc-v2 as power-controller would require to set
> >> #power-domain-cells = <0>;
> 
> Why? I don't think so. Rob/Krzysztof, please correct me if I'm wrong.
> 

make dtbs_check and dt_binding_check complains about that.

> >> 
> >> Would that be acceptable? Considering it wouldn't expose any PM domain?
> >> 
> >> About kpss-gcc we have some device that for some reason doesn't have the
> >> required clocks defined in the dts. I checked the related gcc and no PXO
> >> defined and no pll8_vote clock defined. (the affected dts are all listed
> >> in the related Documentation)
> >> 
> >> No idea how they currently work with the kpss-gcc driver as these
> >> parents are missing. Guess the driver just fails to probe?
> >> So this was the question if you had more info about it... since to me it
> >> seems just another gcc v2 that doesn't expose clocks but it's just a
> >> power-controller just like acc-v2. 
> >> 
> >> -- 
> >> 	Ansuel
> >
> >(Also sorry for the double email)
> >I'm checking the regs for apq8084 for example (from the dtsi)
> >Are we really sure they are power-controller?
> 
> It looks like it's a regularor on steroids. See krait-regulator.c and corresponding bindings in msm-3.10/3.14. So I'd use either the regulator or the power-controller (with significant bias towards controller)
> 

Ok so on that platform they are both power-controller(saw and acc)...
Think we only need to understand about the binding power-domain-cells
binding...

Will check the driver and binding on msm-3.10

> >Checking the regs it seems they just changed the location and they
> >placed clock-controller and right after the power-controller.
> >So one can get confused and say that 0xf9... can be all related to power
> >controller. I posted the regs for reference.
> >
> >acc0 0xf9088000 0x1000
> >saw0 0xf9089000 0x1000
> >
> >acc1 0xf9098000 0x1000
> >saw1 0xf9099000 0x1000
> >
> >acc2 0xf90a8000 0x1000
> >saw2 0xf90b9000 0x1000
> >
> >Anyway while at it there seems to be a bit of confusion about the naming
> >here... We have on ipq8064 and ipq4019 the saw node set as regulator and
> >with the regulator binding but on msm8974 and apq8084 the saw node set
> >as power-controller (with the l2 node with the regulator binding).
> >
> >Think we should chose a name and fix every dts.
> >So the main question here is...
> >Should we keep acc as clock-controller or change it to power-controller
> >(for v2)?
> >
> >Should we change saw node to regulator or power-controller?
> >
> >From what I know acc are used to enable the cpu so it seems sane to keep
> >them as clock-controller (even if v2 doesn't export clock)
> >Saw node handle power (and in theory even low power state) so it seems
> >sane to change them to power-controller.
> >
> >Currently we have no warning for saw node as they are not converted to
> >yaml but as soon as someone convert the txt to yaml then we will have
> >all sort of inconsistency so better take a decision now instead of
> >convert saw to yaml and then change acc node again to fix them for good.
> 
> 
> The saw is definitely a bigger thing than just a regularor (or a set of them). It is used to control pmics, it handles low-power states, so `power-controller'.
> 
> -- 
> With best wishes
> Dmitry

-- 
	Ansuel
