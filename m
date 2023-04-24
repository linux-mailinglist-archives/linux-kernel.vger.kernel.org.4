Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323486ED846
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 01:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjDXXDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 19:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjDXXDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 19:03:45 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DDB93F6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 16:03:44 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-54fae5e9ec7so57186897b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 16:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682377423; x=1684969423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xRrth/2rPlHJRD57ZDquRzBPnCdvHhyHdVMWOLBhruc=;
        b=pwTi6X4Nah2HOzAB1Ma+a9krICtX2pHckFVINb88v52GBWheZ7jNNAHDVo8Dnp5zsZ
         wuJDfJTRWf9GdX6CanriP+Pu1yBthY4U12nueDOM1sq+a9AYrud+7bkuee8qPbzhqQNS
         eSF8AfTN5oMY3xh7hUEhIiu5DCIlMS8bs+rduoF78daKpkxi+ykuz0ImcKQt4grSnFyx
         O3tIl8t1S3YoAf+71PDzbzsIStpGrhiNCSpgRfO8l1LD20TmV+aOAm4DdrhMmbHJXXtM
         9nWRUsfqJeEv+wO+5qHzsDsCN5nmk6Mg96rCymIFnFZk+Az51S7i5tUAwERWVkxY3c1p
         dK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682377423; x=1684969423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRrth/2rPlHJRD57ZDquRzBPnCdvHhyHdVMWOLBhruc=;
        b=GPAzRyye5G03LreKhzOI/3o/QOxFKXcY4W5w1YACIJWioitWzPv1fVhF29Fz6+KWon
         /dovTJqOiKoeDMXHqNG/o/GkkM5U1DzHPZtcyx/hwslGg/Bl8B+ye96jpLeYocbjU1+P
         Z87/NGbgdZTguccLYB+A0AKSVzBYY7VyH96pKg11A/T5SvHUWoD/YK+0vDifgGmsm50u
         iPtrWxzs9mEuMr3LrxCmQ+9Iciy+gNH4Pea6uKveg4feX+nDRPcstERu5D5U72oiDiV/
         7MfNLkhf6nBmnXS3LGSacK8erCed/3+Z76hQ0X4X2DeaCMu9CJfOcnnesAX/GJdvRQEO
         7rNQ==
X-Gm-Message-State: AAQBX9c0VNxGpLNPv55+ZVysiw5X0CAV60Ve7GTG7TJiGjR7bdGqaaI9
        fzX6XBVl5gYEw07VeFshZ5ZOhrDBxLObptZjdXrlqg==
X-Google-Smtp-Source: AKy350bUIDhOyA/75JWrk6ft3Se2t9sPXfgR909GdW/OWl6txSewv5q6VCQpcF8tzR9yOS7WWg8fvn4NqZyvM03Udk8=
X-Received: by 2002:a0d:e68b:0:b0:54f:9e41:df5a with SMTP id
 p133-20020a0de68b000000b0054f9e41df5amr9223949ywe.15.1682377423165; Mon, 24
 Apr 2023 16:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230421133922.8520-1-quic_shazhuss@quicinc.com> <ZEcEGJiikEC2wIVE@fedora>
In-Reply-To: <ZEcEGJiikEC2wIVE@fedora>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 25 Apr 2023 02:03:32 +0300
Message-ID: <CAA8EJpr27=2jAXbamN6J7yF+7G=L5Af8+XReB5UnFuihcEwMQA@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] arm64: qcom: sa8775p: add support for USB
To:     Adrien Thierry <athierry@redhat.com>
Cc:     Shazad Hussain <quic_shazhuss@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023 at 01:36, Adrien Thierry <athierry@redhat.com> wrote:
>
> Hi Shazad,
>
> On Fri, Apr 21, 2023 at 07:09:15PM +0530, Shazad Hussain wrote:
> > Update relavent DT bindings for USB, add new config to the phy driver,
> > add USB and PHY nodes to the .dtsi and enable them in the board .dts
> > for the sa8775p-ride platform.
> >
> > Shazad Hussain (6):
> >   dt-bindings: usb: qcom,dwc3: Add bindings for SA8775P
> >   dt-bindings: phy: qcom,usb-snps-femto-v2: Add bindings for SA8775P
> >   dt-bindings: phy: qcom,sc8280xp-qmp-usb3-uni: Add SA8775P USB PHY
> >     binding
> >   phy: qcom-qmp: Add SA8775P USB3 UNI phy
> >   arm64: dts: qcom: sa8775p: add USB nodes
> >   arm64: dts: qcom: sa8775p-ride: enable USB nodes
> >
> >  .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   |   1 +
> >  .../bindings/phy/qcom,usb-snps-femto-v2.yaml  |   1 +
> >  .../devicetree/bindings/usb/qcom,dwc3.yaml    |   5 +
> >  arch/arm64/boot/dts/qcom/sa8775p-ride.dts     |  92 +++++++
> >  arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 239 +++++++++++++++++-
> >  drivers/phy/qualcomm/phy-qcom-qmp-usb.c       |  45 ++++
> >  6 files changed, 381 insertions(+), 2 deletions(-)
> >
> > --
> > 2.17.1
> >
>
> Thanks for posting this. I tested the series on the sa8775p, and it seems
> initialization for the controller at a400000 sometimes fails with a
> timeout (-110) error:
>
>     dwc3 a400000.usb: Adding to iommu group 2
>     xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
>     xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 1
>     xhci-hcd xhci-hcd.0.auto: can't setup: -110
>     xhci-hcd xhci-hcd.0.auto: USB bus 1 deregistered
>     xhci-hcd: probe of xhci-hcd.0.auto failed with error -110

Semi-random suggestion, but could you please try using
clk_regmap_phy_mux/clk_regmap_phy_mux_ops for USB pipe clk src?


>     dwc3 a600000.usb: Adding to iommu group 3
>     dwc3 a800000.usb: Adding to iommu group 4
>     xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
>     xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 1
>     xhci-hcd xhci-hcd.1.auto: hcc params 0x0110ffc5 hci version 0x110 quirks 0x0000000000010010
>     xhci-hcd xhci-hcd.1.auto: irq 162, io mem 0x0a800000
>     xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
>     xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 2
>     xhci-hcd xhci-hcd.1.auto: Host supports USB 3.1 Enhanced SuperSpeed
>     hub 1-0:1.0: USB hub found
>     hub 1-0:1.0: 1 port detected
>     usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
>     hub 2-0:1.0: USB hub found
>     hub 2-0:1.0: 1 port detected
>
> In this case, only usb devices for a800000 are showing:
>
>     dracut:/# ls -alh /sys/bus/usb/devices
>     total 0
>     drwxr-xr-x 2 root root 0 Feb 27 00:00 .
>     drwxr-xr-x 4 root root 0 Feb 27 00:00 ..
>     lrwxrwxrwx 1 root root 0 Feb 27 00:00 1-0:1.0 -> ../../../devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.1.auto/usb1/1-0:1.0
>     lrwxrwxrwx 1 root root 0 Feb 27 00:00 2-0:1.0 -> ../../../devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.1.auto/usb2/2-0:1.0
>     lrwxrwxrwx 1 root root 0 Feb 27 00:00 usb1 -> ../../../devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.1.auto/usb1
>     lrwxrwxrwx 1 root root 0 Feb 27 00:00 usb2 -> ../../../devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.1.auto/usb2
>
> This happens approximately 1 out of 2 reboots. Here's the kernel output
> when initialization succeeds:
>
>     dwc3 a600000.usb: Adding to iommu group 2
>     dwc3 a800000.usb: Adding to iommu group 3
>     xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
>     xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 1
>     xhci-hcd xhci-hcd.0.auto: hcc params 0x0110ffc5 hci version 0x110 quirks 0x0000000000010010
>     xhci-hcd xhci-hcd.0.auto: irq 161, io mem 0x0a800000
>     xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
>     xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 2
>     xhci-hcd xhci-hcd.0.auto: Host supports USB 3.1 Enhanced SuperSpeed
>     hub 1-0:1.0: USB hub found
>     hub 1-0:1.0: 1 port detected
>     usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
>     hub 2-0:1.0: USB hub found
>     hub 2-0:1.0: 1 port detected
>     dwc3 a400000.usb: Adding to iommu group 4
>     xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
>     xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 3
>     xhci-hcd xhci-hcd.1.auto: USB3 root hub has no ports
>     xhci-hcd xhci-hcd.1.auto: hcc params 0x0220fe65 hci version 0x110 quirks 0x0000000000010010
>     xhci-hcd xhci-hcd.1.auto: irq 162, io mem 0x0a400000
>     hub 3-0:1.0: USB hub found
>     hub 3-0:1.0: 1 port detected
>
> And the list of usb devices:
>
>     dracut:/# ls -alh /sys/bus/usb/devices
>     total 0
>     drwxr-xr-x 2 root root 0 Feb 27 00:00 .
>     drwxr-xr-x 4 root root 0 Feb 27 00:00 ..
>     lrwxrwxrwx 1 root root 0 Feb 27 00:00 1-0:1.0 -> ../../../devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.0.auto/usb1/1-0:1.0
>     lrwxrwxrwx 1 root root 0 Feb 27 00:00 2-0:1.0 -> ../../../devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.0.auto/usb2/2-0:1.0
>     lrwxrwxrwx 1 root root 0 Feb 27 00:00 3-0:1.0 -> ../../../devices/platform/soc@0/a4f8800.usb/a400000.usb/xhci-hcd.1.auto/usb3/3-0:1.0
>     lrwxrwxrwx 1 root root 0 Feb 27 00:00 usb1 -> ../../../devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.0.auto/usb1
>     lrwxrwxrwx 1 root root 0 Feb 27 00:00 usb2 -> ../../../devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.0.auto/usb2
>     lrwxrwxrwx 1 root root 0 Feb 27 00:00 usb3 -> ../../../devices/platform/soc@0/a4f8800.usb/a400000.usb/xhci-hcd.1.auto/usb3
>
> Have you also encountered this?
>
> Best,
>
> Adrien
>


-- 
With best wishes
Dmitry
