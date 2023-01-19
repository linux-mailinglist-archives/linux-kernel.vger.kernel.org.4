Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0464F6737F7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjASMJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjASMJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:09:49 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEF82BEC3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:09:46 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h16so1620160wrz.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iJM/h+lldPXDlTcAuDUdunbYkmcG7VHMb5074kf6tA0=;
        b=P1XDghb5jL3e1MRSpcUCp94PDNobl2vr2DOi5acBorxHYFvq6rY8KEpa/V6WNDlFSN
         ai8t3W95n5hWIn/P6vOafgpSvOgDRbsNcGX1RbE/vHw5iGSYs/3aQyYdPe/tG/jS0n1v
         HqLo582UeEhdXlcVT3jRHVfQkgDO5Yc9pZJPfPRpV26F10Xo6t5WYWQONLSixF9YOt5w
         0a/9INrTDeYQHUa+Z7p7NQoAS5Y1lmB5MVJa16LK+DJHmp7wjNgVWhCGgwK4AqXmFx24
         YV8ZptHfnkPtIqS50zj/mBP5ZSiq1Uec1u6XNKrpwiSt5fw467Jb5q3WuT3a+qN78hKX
         2HqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJM/h+lldPXDlTcAuDUdunbYkmcG7VHMb5074kf6tA0=;
        b=dQIgVpdOrJNUV/U/25ZKHFxGruVL2TXYUDnS//S6JapG9tUMcrFFJCi+amoVd4ClD3
         OEHeCSXqBq0rX/DZDRxuU4Opm6pg/VrCp2REZfwT1IAFv5VeEzleFPuVMm7lT1G/yKd6
         5YNnjug2w3MLxQLAN9s0SVdsNCtFLbFU1bEJRpSmPJ8xnBXgjPGbs2lwllNTzPxF/7Oc
         6onMRycBIkqPpLdfj08FQZdqI2Ni+oXjsnf/hgGYYcGGqe+fTYzNUcXO9yDJQWeiaaSr
         o66I9MlXNzkJV7B4ygNqnIPY8ILWEQ8D4BfEpnYXMqL1V9C8L6CpLhDalkQDKSHYLi5u
         ToZA==
X-Gm-Message-State: AFqh2kpYD/Jmk4LeytIcYOmp4k53fLL1xtKHO5AJepyIKkNy68n44WW2
        S6lKQx4wdCtpTKy+K0KuuxTttQ==
X-Google-Smtp-Source: AMrXdXs7QQi4g4VYJPo232c8Q5V9/773sn0KHvyX6ENIS2uuYmJA9wUi1iKQcFkDf4ozmhlPdvZszw==
X-Received: by 2002:a5d:6b09:0:b0:2be:110d:5d59 with SMTP id v9-20020a5d6b09000000b002be110d5d59mr8620305wrw.51.1674130185366;
        Thu, 19 Jan 2023 04:09:45 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id f2-20020adfdb42000000b0024274a5db0asm33607850wrj.2.2023.01.19.04.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 04:09:44 -0800 (PST)
Date:   Thu, 19 Jan 2023 14:09:43 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/2] arm64: dts: qcom: sm8550: Add PCIe HC and PHY
 support
Message-ID: <Y8kzBz0ApSWgOkVJ@linaro.org>
References: <20230118230526.1499328-1-abel.vesa@linaro.org>
 <167408614065.2989059.2950818972854332656.b4-ty@kernel.org>
 <Y8jyQAR7fF1NRmwu@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8jyQAR7fF1NRmwu@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-19 08:33:20, Johan Hovold wrote:
> On Wed, Jan 18, 2023 at 05:55:31PM -0600, Bjorn Andersson wrote:
> > On Thu, 19 Jan 2023 01:05:24 +0200, Abel Vesa wrote:
> > > This patchset adds PCIe controllers and PHYs support to SM8550 platform
> > > and enables them on the MTP board.
> > > 
> > > The v1 was here:
> > > https://lore.kernel.org/all/20221116130430.2812173-1-abel.vesa@linaro.org/
> > > 
> > > Changes since v1:
> > >  * ordered pcie related nodes alphabetically in MTP dts
> > >  * dropped the pipe_mux, phy_pipe and ref clocks from the pcie nodes
> > >  * dropped the child node from the phy nodes, like Johan suggested,
> > >    and updated to use the sc8280xp binding scheme
> > >  * changed "pcie_1_nocsr_com_phy_reset" 2nd reset name of pcie1_phy
> > >    to "nocsr"
> > >  * reordered all pcie nodes properties to look similar to the ones
> > >    from sc8280xp
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/2] arm64: dts: qcom: sm8550: Add PCIe PHYs and controllers nodes
> >       commit: 7d1158c984d37e79ab8bb55ab152a0b35566cb89
> > [2/2] arm64: dts: qcom: sm8550-mtp: Add PCIe PHYs and controllers nodes
> >       commit: 1eeef306b5d80494cdb149f058013c3ab43984b4
> 
> I believe there were still some changes needed to the controller
> and PHY bindings so this should not have been merged.
> 
> 	https://lore.kernel.org/all/Y8fuUI4xaNkADkWl@hovoldconsulting.com/
> 	https://lore.kernel.org/lkml/Y8giHJMtPu4wTlmA@hovoldconsulting.com/
> 
> Perhaps in the future you can send the dts changes along with the (PHY)
> driver changes so that they can be kept in lock-step and avoid this.

Well, that is a bit hard to do, because phy patches are based on
linux-phy/next, while dtsi patches are based on Bjorn's tree which,
so ...

> 
> Johan
