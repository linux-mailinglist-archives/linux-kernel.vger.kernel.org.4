Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF155B5F77
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiILRhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiILRhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:37:51 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4A52B192
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:37:49 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y127so9318821pfy.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=rDSb8wBkava5eJX1NDUA2GSRdCj2vETP+h2CNX/Jsas=;
        b=zid13Oa92HtzMnA32QRfh2V53dl3pMFmtq47ObgaNEWfIMYFalfim0e9lrFkJFYuu+
         /G6U2No3QUsfUeJhSLinRAudXTDfo52ev29lh2uiP4FyZuKt0Xmg4WiPG9zAc+aLHyIF
         uriKINcJ3tdoVNZeqKwpIHC8qiyreEcyJ+tAw2HkCsHu4qsetsVBKtmoa/2MX8ZHs5oe
         Ciww/EJDUHkLBeHM41n9wKRCSrjQ5rRqSGIJvSt585itKEdLIiSmP3okgiWDsbQ0Dlkw
         CKqMqMEsS4D5tzHDW4uxMAxnO8ZCi56RqnuTgXWCtvlrQM8qUNPeL45q/Hol8JmdYyk+
         95Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rDSb8wBkava5eJX1NDUA2GSRdCj2vETP+h2CNX/Jsas=;
        b=B0CwAU/J1bPu9078YGOn33ehtma5qjkCarJGhQTvQ1x9Mt9ZieT+V3rtBLCeaNBUqk
         xKzAFwvmjO130ajMunSNP2+8ODSLxNpZ6RnJh3204W/bjNcgLAPGjfq9HFpqizZ+S2Ki
         7cRkan+pWJuUnfnUfg2J9Y24EZrMtBIggLN8dl4Eyq9FAV3wXuoqzCSCCx2ORBDM5YhK
         aO1VnPwoe7X7VdbfgR77Bcc07Jaa5Ix79s9rROOfPugpLPnoX0d0+AgNqvcvJpT9JxAd
         dlzOCY3uvLYCg68AHk6N78GMXvn4+b2Am7QxxwL4tsztpJnpt+nRJoSnal1T6XeZZxw8
         qkuA==
X-Gm-Message-State: ACgBeo0UMB+xqJOHfIiWbPNpM2ZukxN2Q8u16W9Emvxwjfvph39BNmIG
        ygUhdAyy9ZiaaIhMoelD2MXm
X-Google-Smtp-Source: AA6agR4l3pM0O1E/J+Y4AXeoLROuvig+uKorFygfak4fjEPRdVYtXmMT6bcOpodc5WOyYIQWlBdH4Q==
X-Received: by 2002:a65:6e0c:0:b0:438:a981:aea7 with SMTP id bd12-20020a656e0c000000b00438a981aea7mr12291165pgb.144.1663004268806;
        Mon, 12 Sep 2022 10:37:48 -0700 (PDT)
Received: from workstation ([117.202.184.122])
        by smtp.gmail.com with ESMTPSA id y65-20020a62ce44000000b00536816c0d4asm6003024pfg.147.2022.09.12.10.37.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Sep 2022 10:37:47 -0700 (PDT)
Date:   Mon, 12 Sep 2022 23:07:42 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v6 0/5] PCI: qcom: Add system suspend & resume support
Message-ID: <20220912173742.GC25849@workstation>
References: <1662713084-8106-1-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662713084-8106-1-git-send-email-quic_krichai@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 02:14:39PM +0530, Krishna chaitanya chundru wrote:
> Add suspend and resume syscore ops.
> 
> When system suspends, and if the link is in L1ss, disable the clocks
> and power down the phy so that system enters into low power state by
> parking link in L1ss to save the maximum power. And when the system
> resumes, enable the clocks back and power on phy if they are disabled
> in the suspend path.
> 

You need to mention that you are only turning off the PCIe controller
clocks and PHY is still powered by a separate domain (MX) so the link
statys intact.

> we are doing this only when link is in l1ss but not in L2/L3 as
> nowhere we are forcing link to L2/L3 by sending PME turn off.
> 
> is_suspended flag indicates if the clocks are disabled in the suspend
> path or not.
> 
> There is access to Ep PCIe space to mask MSI/MSIX after pm suspend ops
> (getting hit by affinity changes while making CPUs offline during suspend,
> this will happen after devices are suspended (all phases of suspend ops)).
> When registered with pm ops there is a crash due to un-clocked access,
> as in the pm suspend op clocks are disabled. So, registering with syscore
> ops which will called after making CPUs offline.
> 
> Make GDSC always on to ensure controller and its dependent clocks
> won't go down during system suspend.
> 

Where is the changelog? You seem to have added PHY and CLK patches to
this series. You need to comment on that.

Thanks,
Mani

> Krishna chaitanya chundru (5):
>   PCI: qcom: Add system suspend and resume support
>   PCI: qcom: Add retry logic for link to be stable in L1ss
>   phy: core: Add support for phy power down & power up
>   phy: qcom: Add power down/up callbacks to pcie phy
>   clk: qcom: Alwaya on pcie gdsc
> 
>  drivers/clk/qcom/gcc-sc7280.c            |   2 +-
>  drivers/pci/controller/dwc/pcie-qcom.c   | 156 ++++++++++++++++++++++++++++++-
>  drivers/phy/phy-core.c                   |  30 ++++++
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c |  50 ++++++++++
>  include/linux/phy/phy.h                  |  20 ++++
>  5 files changed, 256 insertions(+), 2 deletions(-)
> 
> -- 
> 2.7.4
> 
