Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E9E5BB429
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 23:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiIPVyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 17:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiIPVyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 17:54:19 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DA6BB6B4;
        Fri, 16 Sep 2022 14:54:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so609631wmq.1;
        Fri, 16 Sep 2022 14:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date;
        bh=TmnG3jeBJUMOvDJva0+5mSJwWgdih9OGLFDQiz7A5yo=;
        b=n7CeGD8q4B4phfEHJ3h1DHWYx9l8ZHegUidbkRP9n6dq2Q3UQefpw53XlIPgs9xwEi
         v9nAl1JvSxu3k4uoznXY6dqoI8PnC0OnURyyaqzl74o9wTTG831uPklRoZIWWGP600jD
         tw4aA8EPGdMpa1Vbz6TIMzGYXa7DoqM0mGxUSiDK/H+hAomssSZEbjCvpHVm8fvqdZO7
         bwO2KvAXGyFpyY92OMIRxwXPapAc0BhhyaDgfoZ8ssc4fbXrNJP/wP6i6NZxLMEK1npW
         jdenp0BTztiuv3a2jk6vmlYZF4Yk13kAl6l0eZj4OwVFOyPxjqbPmJHshUTAq5EvRxZV
         RsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=TmnG3jeBJUMOvDJva0+5mSJwWgdih9OGLFDQiz7A5yo=;
        b=gyl8VwAxWF5tQ256qM2MpryRVSYDE1+BM95NIiGBX1/aL7ZtnDE/eK1eJnFVCMuGhd
         5O0XVHSbwpJACtigpIMEsc+4ra84qTNBj0V0IsVXbNGOevJOY5HNreoS3EmBZ5uSBeB3
         CRySEyVGlPYnVkN6MAf7dpS4quazOXh8NY7xUhEvbXd1Sq+2p6gLdXseKqFXzDUjD+eV
         slLRyeTOZM4yB4uIuz3NY1bYcOgZlioFPMIZVClLOS74pSV9k897iJPb2F+PLQTrTxYl
         20L04rYMso3K7wVocIJcd1pI+pEs9BzaeB40RGoRq6r1rmkb0cjt8MqCN4LbopbovE3M
         sl7w==
X-Gm-Message-State: ACgBeo1D9/nvO8gCtO0CUiG6xXa68cyD3OAeqyRlnARRNyGbCVpvyluM
        RMwBBIBvIUlcPGw/BsiMQSiuGEKgah0=
X-Google-Smtp-Source: AA6agR45GifptiKz10GptRcdaPoz7U/Jq9hNCeh3uxBFcAhbjyhNWDJrw+hlkMRhS7R9KnoX5ZN1rg==
X-Received: by 2002:a05:600c:2646:b0:3b4:7640:3c1a with SMTP id 6-20020a05600c264600b003b476403c1amr11931475wmy.2.1663365256133;
        Fri, 16 Sep 2022 14:54:16 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.gmail.com with ESMTPSA id i17-20020a1c5411000000b003a63a3b55c3sm3420031wmb.14.2022.09.16.14.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 14:54:15 -0700 (PDT)
Message-ID: <6324f087.1c0a0220.7123d.8665@mx.google.com>
X-Google-Original-Message-ID: <YyTwhPVWdo5Z0wZB@Ansuel-xps.>
Date:   Fri, 16 Sep 2022 23:54:12 +0200
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
 <6324dc1b.df0a0220.97787.083c@mx.google.com>
 <CAA8EJpo08WoQ_LYOtg5C2BB=Q6GR_cftLjaWHWjYD6BjfDZcsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpo08WoQ_LYOtg5C2BB=Q6GR_cftLjaWHWjYD6BjfDZcsg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 11:31:49PM +0300, Dmitry Baryshkov wrote:
> On Fri, 16 Sept 2022 at 23:27, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > On Fri, Sep 16, 2022 at 11:22:17PM +0300, Dmitry Baryshkov wrote:
> > > On Fri, 16 Sept 2022 at 23:13, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > >
> > > > On Fri, Sep 16, 2022 at 11:06:35PM +0300, Dmitry Baryshkov wrote:
> > > > > On Fri, 16 Sept 2022 at 22:43, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Sep 16, 2022 at 02:17:15PM -0500, Rob Herring wrote:
> > > > > > > On Wed, Sep 14, 2022 at 04:22:53PM +0200, Christian Marangi wrote:
> > > > > > > > Convert kpss-acc driver Documentation to yaml.
> > > > > > > > The original Documentation was wrong all along. Fix it while we are
> > > > > > > > converting it.
> > > > > > > > The example was wrong as kpss-acc-v2 should only expose the regs but we
> > > > > > > > don't have any driver that expose additional clocks. The kpss-acc driver
> > > > > > > > is only specific to v1. For this exact reason, limit all the additional
> > > > > > > > bindings (clocks, clock-names, clock-output-names and #clock-cells) to
> > > > > > > > v1 and also flag that these bindings should NOT be used for v2.
> > > > > > >
> > > > > > > Odd that a clock controller has no clocks, but okay.
> > > > > > >
> > > > > >
> > > > > > As said in the commit v2 is only used for regs. v2 it's only used in
> > > > > > arch/arm/mach-qcom/platsmp.c to setup stuff cpu hotplug and bringup.
> > > > > >
> > > > > > Should we split the 2 driver? To me the acc naming seems to be just
> > > > > > recycled for v2 and it's not really a clk controller.
> > > > > >
> > > > > > So keeping v2 in arm/msm/qcom,kpss-acc-v2.yaml and v1 moved to clock?
> > > > >
> > > > > I suspect that qcom,kpss-acc-v2 is misnamed as the "clock-controller".
> > > > > According to msm-3.10, these regions are used by the Krait core
> > > > > regulators.
> > > > >
> > > >
> > > > Well we need to understand how to handle this... change the compatible
> > > > it's a nono for sure. In platsmp.c they are used for cpu power control
> > > > so could be that they are actually used to regulators. I would honestly
> > > > move v1 to clock and leave v2 to arm/msm but I'm not cetain on what name
> > > > to assign to the 2 yaml.
> > > >
> > > > What do you think?
> > >
> > > This is fine for me. If somebody gets better understanding of
> > > underlying hardware and works on actually using these blocks, he will
> > > update the bindings.
> > >
> > > My only suggestion would be to rename kpss-acc-v2 nodes to
> > > 'power-controller@address' and document them so.
> > >
> >
> > Ok so something like this?
> >
> >     power-controller@f9088000 {
> >       compatible = "qcom,kpss-acc-v2";
> >       reg = <0xf9088000 0x1000>,
> >             <0xf9008000 0x1000>;
> >     };
> >
> > (and I will have to fix dtbs warning as they will be unmatched I think.)
> > Yaml naming:
> > qcom,kpss-acc-v1.yaml
> > qcom,kpss-acc-v2.yaml
> > Right?
> 
> Sounds good to me.
> 
> I'd even say clock/qcom,kpss-acc-v1.yaml and
> arm/msm/qcom,kpss-acc-v2.yaml or maybe power/qcom,kpss-acc-v2.yaml
> 

Wonder if the gcc driver should have the same tretement? It's also a
clock-controller driver that doesn't use clock at all... Do you have
some info about it?

-- 
	Ansuel
