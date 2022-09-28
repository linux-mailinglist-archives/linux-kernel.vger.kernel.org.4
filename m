Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF3D5EE5A0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 21:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiI1TZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 15:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbiI1TYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 15:24:47 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078DDE027
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:24:46 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id n192so9783183iod.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=MO1VbxnfAHIl77onNuYWJWsBzJp4QOHXVNC5oK8Yuqk=;
        b=VGhasSHLM0UkJ9hO2GsiyUwH4ah5kerBGf+crFciQjqxDNeERk5jKuYEJ5Yba9Go0q
         IgtJJf3agMY6KjseD9Gyn/BnWrwXU0+KleAvQiAzyMtGEiCWn49FGbq2bFProuD3p50Q
         aotr66sKe46RnRQvVkj4ufBvdi5IhntQhj5nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=MO1VbxnfAHIl77onNuYWJWsBzJp4QOHXVNC5oK8Yuqk=;
        b=dqVAWFN97P68GZvXXYmZjocz7FA7mQ6Fn65oEngUBDiigyRLol9e3hsCPVOFjxyqEv
         bndMdTuej0ALUi15Yb5IJob3M3WqLTo78TIf8vGzglxfkWFox/MHumleqf7uA2Ga60FH
         LJYl0oRwRqhwkCnkM6c/923PUnZ0lTU6OGA4cggTgF6OUgc38AJ1dCYh5Ke2uS0JVOyS
         bM3a4+bTuDsWgCiq6UzUHEwgChIFZ/zm1KNLSSo78EgxeV5lFihaiVggxDTVDdroHBKE
         Nw5Lx+qSY9RJ+jSXh+W9wR0phNWdDtMbJb93NJ96teJJ+tCAUkINUQ4lzOVhGBGmmk7U
         qE5Q==
X-Gm-Message-State: ACrzQf0yz98g6LuQ3glpckzzZS2HDoQEl0cRLiidfFgwLCZBMd5QwXQH
        qSkmVpH/vjerUlBzW4gdB9lXFQ==
X-Google-Smtp-Source: AMsMyM4Fl42E9H+wUQXKwFcdMnU08P+BAXhYmjSJDqL8xOBr7TJo2zF9ZAwd9zNUMHuvxLdD4XgIRg==
X-Received: by 2002:a05:6602:2d83:b0:6a4:ea1e:3fe8 with SMTP id k3-20020a0566022d8300b006a4ea1e3fe8mr5216114iow.163.1664393085395;
        Wed, 28 Sep 2022 12:24:45 -0700 (PDT)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id r2-20020a056e02108200b002f6460e4d90sm1904897ilj.85.2022.09.28.12.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 12:24:44 -0700 (PDT)
Date:   Wed, 28 Sep 2022 19:24:43 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7180: Configure USB as wakeup
 source
Message-ID: <YzSfe2dY2fyXDJLl@google.com>
References: <20220901102946.v2.1.I347ea409ee3134bd32a29e33fecd1a6ef32085a0@changeid>
 <CAD=FV=WBzVTaz1dtMswNMWhBzBBUQZTxqXff_DgiuP6WJgG8Qg@mail.gmail.com>
 <YxeZrvKvRB/ct3Ss@google.com>
 <CAD=FV=VsRi2kt9K9E+VOEGqdJFT43-aj415Gk2Q=OP64L-JAUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=VsRi2kt9K9E+VOEGqdJFT43-aj415Gk2Q=OP64L-JAUA@mail.gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

This patch should be ready for landing, could you pick it?

Thanks

Matthias

On Tue, Sep 06, 2022 at 12:22:42PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Sep 6, 2022 at 12:04 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Hi Doug,
> >
> > On Tue, Sep 06, 2022 at 11:33:56AM -0700, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Thu, Sep 1, 2022 at 10:29 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> > > >
> > > > The dwc3 USB controller of the sc7180 supports USB remote
> > > > wakeup, configure it as a wakeup source.
> > > >
> > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > ---
> > > >
> > > > Changes in v2:
> > > > - use qcom/arm64-for-6.1 as base, v1 was unintendedly based on a
> > > >   downstream branch that was used for testing
> > > >
> > > >  arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > > index e8debb0da411..af5bab27eaf3 100644
> > > > --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > > +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > > @@ -2782,6 +2782,8 @@ usb_1: usb@a6f8800 {
> > > >                                         <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3 0>;
> > > >                         interconnect-names = "usb-ddr", "apps-usb";
> > > >
> > > > +                       wakeup-source;
> > > > +
> > >
> > > The patch documenting this property has landed in commit 416b61893860
> > > ("dt-bindings: usb: qcom,dwc3: add wakeup-source property"). I guess
> > > the only question is whether this should be in the general sc7180
> > > device tree file or just for trogdor.
> >
> > I had a similar comment on the patch for sc7280 [1], there the rationale
> > for putting the property into the .dtsi of the SoC was that the wakeup
> > capability is provided by the SoC.
> >
> > For sc8280xp.dtsi the property is also in the .dtsi of the SoC:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/tree/arch/arm64/boot/dts/qcom/sc8280xp.dtsi?h=arm64-for-6.1#n1315
> >
> > > Any chance it could cause problems for devices that aren't designed like
> > > trogdor?
> >
> > Probably not in a functional sense, however power consumption during system
> > suspend is slightly higher (2-3 mW) when USB wakeup is enabled. Boards can
> > disable wakeup by deleting the property in their .dtsi file, though it
> > is not necessarily evident that this is an option to reduce power
> > consumption.
> >
> > [1] https://patchwork.kernel.org/project/linux-arm-msm/patch/1649321104-31322-7-git-send-email-quic_c_sanm@quicinc.com/
> 
> OK then.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
