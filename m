Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7235BBA2B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 21:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiIQToK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 15:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIQToH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 15:44:07 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5852BB24;
        Sat, 17 Sep 2022 12:44:05 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id az24-20020a05600c601800b003a842e4983cso1833268wmb.0;
        Sat, 17 Sep 2022 12:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date;
        bh=9MOtt1g/rm8xaea/35yg7P6pO/gnunYbV8isjRoBVdg=;
        b=e8xu9MRfatjxNk6m/3A+pZqn221lwHNckzcTpWFacpW/cj9zvojW+ULn/yJYpIJmYD
         sdqEUdqDUaIf7gOXWUfvuzyyoyaor5eYTUxivJZ4taNd4L2DL7vrbkPIm0RdaO/eDXnT
         rNDfMaFC9uoe7mYu801u/WrRONvaih/K3xE1u7UdIRNB2f/XezkCkDuL4BdDVrADgTcT
         eqFTw2MwNf411fiuva/KErGnIKRvTuYrnc73JZjPCtvlGfQFGVAVEyiX6IjLFSegXIMp
         mJRFCJa9ANG3ID63U1cIQjO9RQQsLBZLRXlHRRHRIonAE0qgIUiXHxm584tPCfY1NUbm
         YlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=9MOtt1g/rm8xaea/35yg7P6pO/gnunYbV8isjRoBVdg=;
        b=gd8U2mHsQyx4FmACixfVJaxnoNNWZRPYdUQZpZiCQj51do37i5ugePjW72O2e1QEwH
         wlB8bLyo6omSuzWs3+kQErLK77jOsPdASzeHH6gMEMIKh5aP3aX10wmpTUoUL2nPk2rA
         6bfNbPKpFCQxfsL4r1LjUoxCpKizRuf3JGpLC44shKW8+GzeWBvh7wdfKZ8hEOeHkxhd
         1xvhXhdf5+fvzbXXfCcmOEdPTdxenZnj6fgw+1OqSJsfH9nvNobeC80BvodXo51bicdV
         fw/EeZYhLYlqrIVtsu5wybNgp3+QlPOrnu9e1c1z1Z2/1g9nRtmriTPf9gbagXOqYzsR
         KYtA==
X-Gm-Message-State: ACrzQf2osQR7ZBbV0LgWyI17lVye3MR/u6T9KoB8yxB1F0lZpCzGIHAX
        9ga8qPR4cuD3Dy2MFGhheDk=
X-Google-Smtp-Source: AMsMyM6yF5xqGZYQUON3LyUEhYWCuF4gl3rbiaAjHSdxKZsmF+LTWXIcg40eqORnx77JZRP0tf8njA==
X-Received: by 2002:a7b:c2a2:0:b0:3a8:4959:a327 with SMTP id c2-20020a7bc2a2000000b003a84959a327mr7329658wmk.50.1663443844289;
        Sat, 17 Sep 2022 12:44:04 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.gmail.com with ESMTPSA id d8-20020adfef88000000b002250c35826dsm8604667wro.104.2022.09.17.12.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 12:44:03 -0700 (PDT)
Message-ID: <63262383.df0a0220.27cbb.1c41@mx.google.com>
X-Google-Original-Message-ID: <YyYjgPeHn6nvaFcV@Ansuel-xps.>
Date:   Sat, 17 Sep 2022 21:44:00 +0200
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
References: <20220916191715.GA1079300-robh@kernel.org>
 <6324d1be.050a0220.9d842.7b47@mx.google.com>
 <CAA8EJprEQOsm4TxGWJYZo04D1PagT3QmhDdYQkEid-KSP-tpTw@mail.gmail.com>
 <6324d8e1.170a0220.aba35.ba4f@mx.google.com>
 <CAA8EJpowLvkuiYupqS0WEhnMR8q=R1YUUFgdFVCAx1PXyoo1xw@mail.gmail.com>
 <6324dc1b.df0a0220.97787.083c@mx.google.com>
 <CAA8EJpo08WoQ_LYOtg5C2BB=Q6GR_cftLjaWHWjYD6BjfDZcsg@mail.gmail.com>
 <6324f087.1c0a0220.7123d.8665@mx.google.com>
 <CAA8EJprhLUybqmPhFmit6LGaNOxz=-9+8xADXowJuzU5BtjjtA@mail.gmail.com>
 <632618ac.050a0220.bda86.d7a8@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <632618ac.050a0220.bda86.d7a8@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 08:57:44PM +0200, Christian Marangi wrote:
> On Sat, Sep 17, 2022 at 04:45:21PM +0300, Dmitry Baryshkov wrote:
> > On Sat, 17 Sept 2022 at 00:54, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > >
> > > On Fri, Sep 16, 2022 at 11:31:49PM +0300, Dmitry Baryshkov wrote:
> > > > On Fri, 16 Sept 2022 at 23:27, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > > >
> > > > > On Fri, Sep 16, 2022 at 11:22:17PM +0300, Dmitry Baryshkov wrote:
> > > > > > On Fri, 16 Sept 2022 at 23:13, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > > > > >
> > > > > > > On Fri, Sep 16, 2022 at 11:06:35PM +0300, Dmitry Baryshkov wrote:
> > > > > > > > On Fri, 16 Sept 2022 at 22:43, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Sep 16, 2022 at 02:17:15PM -0500, Rob Herring wrote:
> > > > > > > > > > On Wed, Sep 14, 2022 at 04:22:53PM +0200, Christian Marangi wrote:
> > > > > > > > > > > Convert kpss-acc driver Documentation to yaml.
> > > > > > > > > > > The original Documentation was wrong all along. Fix it while we are
> > > > > > > > > > > converting it.
> > > > > > > > > > > The example was wrong as kpss-acc-v2 should only expose the regs but we
> > > > > > > > > > > don't have any driver that expose additional clocks. The kpss-acc driver
> > > > > > > > > > > is only specific to v1. For this exact reason, limit all the additional
> > > > > > > > > > > bindings (clocks, clock-names, clock-output-names and #clock-cells) to
> > > > > > > > > > > v1 and also flag that these bindings should NOT be used for v2.
> > > > > > > > > >
> > > > > > > > > > Odd that a clock controller has no clocks, but okay.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > As said in the commit v2 is only used for regs. v2 it's only used in
> > > > > > > > > arch/arm/mach-qcom/platsmp.c to setup stuff cpu hotplug and bringup.
> > > > > > > > >
> > > > > > > > > Should we split the 2 driver? To me the acc naming seems to be just
> > > > > > > > > recycled for v2 and it's not really a clk controller.
> > > > > > > > >
> > > > > > > > > So keeping v2 in arm/msm/qcom,kpss-acc-v2.yaml and v1 moved to clock?
> > > > > > > >
> > > > > > > > I suspect that qcom,kpss-acc-v2 is misnamed as the "clock-controller".
> > > > > > > > According to msm-3.10, these regions are used by the Krait core
> > > > > > > > regulators.
> > > > > > > >
> > > > > > >
> > > > > > > Well we need to understand how to handle this... change the compatible
> > > > > > > it's a nono for sure. In platsmp.c they are used for cpu power control
> > > > > > > so could be that they are actually used to regulators. I would honestly
> > > > > > > move v1 to clock and leave v2 to arm/msm but I'm not cetain on what name
> > > > > > > to assign to the 2 yaml.
> > > > > > >
> > > > > > > What do you think?
> > > > > >
> > > > > > This is fine for me. If somebody gets better understanding of
> > > > > > underlying hardware and works on actually using these blocks, he will
> > > > > > update the bindings.
> > > > > >
> > > > > > My only suggestion would be to rename kpss-acc-v2 nodes to
> > > > > > 'power-controller@address' and document them so.
> > > > > >
> > > > >
> > > > > Ok so something like this?
> > > > >
> > > > >     power-controller@f9088000 {
> > > > >       compatible = "qcom,kpss-acc-v2";
> > > > >       reg = <0xf9088000 0x1000>,
> > > > >             <0xf9008000 0x1000>;
> > > > >     };
> > > > >
> > > > > (and I will have to fix dtbs warning as they will be unmatched I think.)
> > > > > Yaml naming:
> > > > > qcom,kpss-acc-v1.yaml
> > > > > qcom,kpss-acc-v2.yaml
> > > > > Right?
> > > >
> > > > Sounds good to me.
> > > >
> > > > I'd even say clock/qcom,kpss-acc-v1.yaml and
> > > > arm/msm/qcom,kpss-acc-v2.yaml or maybe power/qcom,kpss-acc-v2.yaml
> > > >
> > >
> > > Wonder if the gcc driver should have the same tretement? It's also a
> > > clock-controller driver that doesn't use clock at all... Do you have
> > > some info about it?
> > 
> > As far as I understand, the kpss-gcc is a normal clock controller,
> > isn't it? It provides clocks to other devices.
> > 
> 
> Hi again... Having acc-v2 as power-controller would require to set
> #power-domain-cells = <0>;
> 
> Would that be acceptable? Considering it wouldn't expose any PM domain?
> 
> About kpss-gcc we have some device that for some reason doesn't have the
> required clocks defined in the dts. I checked the related gcc and no PXO
> defined and no pll8_vote clock defined. (the affected dts are all listed
> in the related Documentation)
> 
> No idea how they currently work with the kpss-gcc driver as these
> parents are missing. Guess the driver just fails to probe?
> So this was the question if you had more info about it... since to me it
> seems just another gcc v2 that doesn't expose clocks but it's just a
> power-controller just like acc-v2. 
> 
> -- 
> 	Ansuel

(Also sorry for the double email)
I'm checking the regs for apq8084 for example (from the dtsi)
Are we really sure they are power-controller?
Checking the regs it seems they just changed the location and they
placed clock-controller and right after the power-controller.
So one can get confused and say that 0xf9... can be all related to power
controller. I posted the regs for reference.

acc0 0xf9088000 0x1000
saw0 0xf9089000 0x1000

acc1 0xf9098000 0x1000
saw1 0xf9099000 0x1000

acc2 0xf90a8000 0x1000
saw2 0xf90b9000 0x1000

Anyway while at it there seems to be a bit of confusion about the naming
here... We have on ipq8064 and ipq4019 the saw node set as regulator and
with the regulator binding but on msm8974 and apq8084 the saw node set
as power-controller (with the l2 node with the regulator binding).

Think we should chose a name and fix every dts.
So the main question here is...
Should we keep acc as clock-controller or change it to power-controller
(for v2)?

Should we change saw node to regulator or power-controller?

From what I know acc are used to enable the cpu so it seems sane to keep
them as clock-controller (even if v2 doesn't export clock)
Saw node handle power (and in theory even low power state) so it seems
sane to change them to power-controller.

Currently we have no warning for saw node as they are not converted to
yaml but as soon as someone convert the txt to yaml then we will have
all sort of inconsistency so better take a decision now instead of
convert saw to yaml and then change acc node again to fix them for good.

-- 
	Ansuel
