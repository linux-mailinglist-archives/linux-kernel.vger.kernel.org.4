Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E75690EBA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjBIQ73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBIQ71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:59:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29FB64650;
        Thu,  9 Feb 2023 08:59:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33B43B8224B;
        Thu,  9 Feb 2023 16:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC069C4339C;
        Thu,  9 Feb 2023 16:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675961963;
        bh=pq6Qa/PmXkcIXc+XOMo6Okx7Ag7QK4FyBsSO3pSN7z8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rFnSmvtHfFUmRcIlaaIZG7xBYOCSAlh6gYMTlhYRirHmOe05nUrvhSF8wq5+5ixnE
         whM616+ySl+yfmXSYcLpdXHqhuDQDMLOBEdYTqfrCi9dF/sDYRFFJZsoPflhWuVmDQ
         nh5bLImLI1OgJ9uslC8TLJZo+/OIaO9AhgGRD4zGCNlHzXlXgnazo2CodUmy6UnPiF
         NUGoRQaNxitRWB24AXN+YfORZcayq2UJ/mSR4gqgrlxp7TcKN6RCGtv8/Gc3LgEUWS
         fMrV8qJ7nSwVo5nIGGQ8CqI8NVnQ+4jVV/G1Rv+m0P3N8dm+PJBX2nGlOFTAzjAhqn
         TYdKSkTd9OVlg==
Received: by mail-lj1-f169.google.com with SMTP id b13so2775996ljf.8;
        Thu, 09 Feb 2023 08:59:23 -0800 (PST)
X-Gm-Message-State: AO0yUKXmmQ0MvkbpWLrDAyed01cgYcZz51mxBMPCm4VRR1FoI8Mx65X4
        G6gGEJSlFBu0v8QzrQWaOFuQVr/JZQU06QeEXqo=
X-Google-Smtp-Source: AK7set84ViuAZxzFwbHMC7zs7Bzk0V4q6ADg55zwQZL00COLiBD5JOdVbNXmjbnVXOMVrPsQZDTr8Cc4zlRSzA7cxpg=
X-Received: by 2002:a2e:8206:0:b0:290:5b9d:e97 with SMTP id
 w6-20020a2e8206000000b002905b9d0e97mr1910505ljg.187.1675961961847; Thu, 09
 Feb 2023 08:59:21 -0800 (PST)
MIME-Version: 1.0
References: <20230126142057.25715-1-johan+linaro@kernel.org>
 <20230126142057.25715-19-johan+linaro@kernel.org> <20230130184944.GA3096050-robh@kernel.org>
 <Y9qO0yQ7oLux2L9n@hovoldconsulting.com>
In-Reply-To: <Y9qO0yQ7oLux2L9n@hovoldconsulting.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Feb 2023 17:59:10 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGwVO_WtfMSkbYj_Uf2t7-=G2b1vt-pggOGwMqFJKEQNQ@mail.gmail.com>
Message-ID: <CAMj1kXGwVO_WtfMSkbYj_Uf2t7-=G2b1vt-pggOGwMqFJKEQNQ@mail.gmail.com>
Subject: Re: [RFC 18/24] dt-bindings: rtc: qcom-pm8xxx: add uefi-variable offset
To:     Johan Hovold <johan@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Feb 2023 at 17:09, Johan Hovold <johan@kernel.org> wrote:
>
> [ +CC: Ard ]
>
> On Mon, Jan 30, 2023 at 12:49:44PM -0600, Rob Herring wrote:
> > On Thu, Jan 26, 2023 at 03:20:51PM +0100, Johan Hovold wrote:
> > > On many Qualcomm platforms the PMIC RTC control and time registers are
> > > read-only so that the RTC time can not be updated. Instead an offset
> > > needs be stored in some machine-specific non-volatile memory, which a
> > > driver can take into account.
> > >
> > > Add a 'qcom,uefi-rtc-info' boolean flag which indicates that the RTC
> > > offset is stored in a Qualcomm specific UEFI variable so that the RTC
> > > time can be updated on such platforms.
> > >
> > > The UEFI variable is
> > >
> > >     882f8c2b-9646-435f-8de5-f208ff80c1bd-RTCInfo
> > >
> > > and holds a 12-byte structure where the first four bytes is a GPS time
> > > offset in little-endian byte order.
> >
> > Can't you just try to read the UEFI variable and use it if that
> > succeeds?
>
> Generally, yes. The problem here is that this UEFI variable is not used
> on all devices using these PMICs and I need a way to determine whether
> to wait for the UEFI variables to become available or not (e.g. when
> efivars support is built as module, yes, that's a thing now...).
>

Could we read this variable at boot and pass it to the kernel in a
different way? That way, we only have to defer the ability to set the
RTC, right?

> > I don't like this in DT because what if lots of devices start storing
> > lots of things in vendor specific UEFI variables. It doesn't scale.
>
> I hope we won't see that even if we already have some devices for x86
> platforms storing MAC addresses and such in UEFI variables. They
> currently access the UEFI firmware directly (i.e. not using the efivars
> abstraction) and simply assume UEFI is always there.
>
> With the Google SMI efivars implementation or the new Qualcomm SMC-based
> one, we need a way to determine whether to wait for efivars to become
> registered. For drivers where efivars is always needed we can just probe
> defer, but in this case we should not wait unless the DT indicates that
> the RTC offset is stored in UEFI on this particular machine.
>
> Just as the nvmem-cell property indicates that the offset is stored in
> some abstract nvmem, it seems reasonable to describe the offset being
> stored in UEFI when that is the case (even if it is indeed generally
> possible to probe for the latter).
>
> An alternative might be to describe the efivars fw dependency in DT too
> (e.g. for device links), but I believe you have already expressed some
> concerns over that:
>
>         https://lore.kernel.org/lkml/20230130210530.GA3339716-robh@kernel.org/
>
> Johan
