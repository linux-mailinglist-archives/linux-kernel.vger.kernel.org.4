Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347B65BB37E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 22:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiIPU1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 16:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiIPU1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 16:27:11 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FEBA9C06;
        Fri, 16 Sep 2022 13:27:10 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l8so11441924wmi.2;
        Fri, 16 Sep 2022 13:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date;
        bh=Y+4u3HprOM4AbiGAF2kHfVJR+XvSaOp0FKOxbaiwzGA=;
        b=U0XFnk/2Gl57SBl4jdJiQ+H/QcL6nIe/yzY/bnbPwcTBvUvAHbsu4fqW6gUmyLj+Tl
         9bpuhJuxYIM07CXXHbP5tedUjIVFWgi/CPzgiwggfxOxZDunecCbXKpYeePgH5RHiyIz
         AX4nkgrVxxa8xnUFFFeOZiJs/r8/0OgUZc7JaRm6aQoAQxKKC9cSs2W29obSfXuOv3Gy
         guRERo+y1/EYi4GHhLgIiwdXPpUB0hvMO1+inU1/StlDfjZHGZuMaiVfadBhoQmKrrsH
         qEORa48rGkgWhok24NVsYGacXkrCpD14IuyunFnXyadqckf/upU/s99FeYICqVB0UF75
         kYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Y+4u3HprOM4AbiGAF2kHfVJR+XvSaOp0FKOxbaiwzGA=;
        b=5y+asDV+fExspJIv3IkVUcGg2JD7dRqs2k5GjwlvLSghN7YBeA637sNkVZKioRd1KK
         y9HQXSZBn1sKCUb2ojxCKJyNoHi9p2331u7jexwNTunYZMu4aIU0I7TijCSqp6PRuQ+M
         taTWHhJHwmpVsD0vjm3IRjTny1V3mK4SLXVswI6w5thF2Ol3Km778lwjkHcmiKFhFIfd
         OXoXOlTwm6IULMF5fEiTdL1tuku1pbNhjjtnMazzvkEIl7iR4QgN4pGqM3HPB7a3GuE3
         e8Ze9mGAq/dYMSLNPXZw/EhrtMEEAbXAiPUU8MVMsbAal4V2OUQBfk7CtFCeYpdRhDDR
         KkyA==
X-Gm-Message-State: ACgBeo37Nx8FPHr5bC4IlKywrGEYoSYMEuyP/T2rIuI2Sye9nXYqOFOP
        OPPWDLouX+m5lsH27iwk+H4=
X-Google-Smtp-Source: AA6agR5z7FqX+lUO3WsAP6HHlvQYNX1ISJBgK3AFOWKfdMPsbt44297opFfG46D/zPaq9qiYwOstHQ==
X-Received: by 2002:a05:600c:1f15:b0:3b4:8600:fd7e with SMTP id bd21-20020a05600c1f1500b003b48600fd7emr11742690wmb.40.1663360028408;
        Fri, 16 Sep 2022 13:27:08 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.gmail.com with ESMTPSA id s2-20020adfdb02000000b002253fd19a6asm6984959wri.18.2022.09.16.13.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 13:27:07 -0700 (PDT)
Message-ID: <6324dc1b.df0a0220.97787.083c@mx.google.com>
X-Google-Original-Message-ID: <YyTcGKNOIA2pggHa@Ansuel-xps.>
Date:   Fri, 16 Sep 2022 22:27:04 +0200
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
References: <20220914142256.28775-1-ansuelsmth@gmail.com>
 <20220914142256.28775-3-ansuelsmth@gmail.com>
 <20220916191715.GA1079300-robh@kernel.org>
 <6324d1be.050a0220.9d842.7b47@mx.google.com>
 <CAA8EJprEQOsm4TxGWJYZo04D1PagT3QmhDdYQkEid-KSP-tpTw@mail.gmail.com>
 <6324d8e1.170a0220.aba35.ba4f@mx.google.com>
 <CAA8EJpowLvkuiYupqS0WEhnMR8q=R1YUUFgdFVCAx1PXyoo1xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpowLvkuiYupqS0WEhnMR8q=R1YUUFgdFVCAx1PXyoo1xw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 11:22:17PM +0300, Dmitry Baryshkov wrote:
> On Fri, 16 Sept 2022 at 23:13, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > On Fri, Sep 16, 2022 at 11:06:35PM +0300, Dmitry Baryshkov wrote:
> > > On Fri, 16 Sept 2022 at 22:43, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > >
> > > > On Fri, Sep 16, 2022 at 02:17:15PM -0500, Rob Herring wrote:
> > > > > On Wed, Sep 14, 2022 at 04:22:53PM +0200, Christian Marangi wrote:
> > > > > > Convert kpss-acc driver Documentation to yaml.
> > > > > > The original Documentation was wrong all along. Fix it while we are
> > > > > > converting it.
> > > > > > The example was wrong as kpss-acc-v2 should only expose the regs but we
> > > > > > don't have any driver that expose additional clocks. The kpss-acc driver
> > > > > > is only specific to v1. For this exact reason, limit all the additional
> > > > > > bindings (clocks, clock-names, clock-output-names and #clock-cells) to
> > > > > > v1 and also flag that these bindings should NOT be used for v2.
> > > > >
> > > > > Odd that a clock controller has no clocks, but okay.
> > > > >
> > > >
> > > > As said in the commit v2 is only used for regs. v2 it's only used in
> > > > arch/arm/mach-qcom/platsmp.c to setup stuff cpu hotplug and bringup.
> > > >
> > > > Should we split the 2 driver? To me the acc naming seems to be just
> > > > recycled for v2 and it's not really a clk controller.
> > > >
> > > > So keeping v2 in arm/msm/qcom,kpss-acc-v2.yaml and v1 moved to clock?
> > >
> > > I suspect that qcom,kpss-acc-v2 is misnamed as the "clock-controller".
> > > According to msm-3.10, these regions are used by the Krait core
> > > regulators.
> > >
> >
> > Well we need to understand how to handle this... change the compatible
> > it's a nono for sure. In platsmp.c they are used for cpu power control
> > so could be that they are actually used to regulators. I would honestly
> > move v1 to clock and leave v2 to arm/msm but I'm not cetain on what name
> > to assign to the 2 yaml.
> >
> > What do you think?
> 
> This is fine for me. If somebody gets better understanding of
> underlying hardware and works on actually using these blocks, he will
> update the bindings.
> 
> My only suggestion would be to rename kpss-acc-v2 nodes to
> 'power-controller@address' and document them so.
>

Ok so something like this?

    power-controller@f9088000 {
      compatible = "qcom,kpss-acc-v2";
      reg = <0xf9088000 0x1000>,
            <0xf9008000 0x1000>;
    };

(and I will have to fix dtbs warning as they will be unmatched I think.)
Yaml naming:
qcom,kpss-acc-v1.yaml
qcom,kpss-acc-v2.yaml
Right?


-- 
	Ansuel
