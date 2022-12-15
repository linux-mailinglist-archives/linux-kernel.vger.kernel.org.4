Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A62464D93F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiLOKIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiLOKH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:07:57 -0500
X-Greylist: delayed 348 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Dec 2022 02:07:55 PST
Received: from mo6-p02-ob.smtp.rzone.de (mo6-p02-ob.smtp.rzone.de [IPv6:2a01:238:400:300::7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4790B1E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1671098498;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=gSkawMZII/szNuMPzj1SG1TIC63W2ydy3RFSlgeYViA=;
    b=qTEo8CBtxfbB8IWD0USfZACF1KXxdSaHAzwQzAVoRunHu7zDeK1oJ74veDucQpYQoO
    U6Jg8IwUXMADze4RM74Z/gGGY434ymEVJEHVxWK8mBhLwzlJnMYt0ixEczhHnhCHVI8l
    XbEKYI7e4NGx+ZC//pfXBM+GOGEBKf1m3amhdS5IU3JXNxsTjzvSlt+d1CkW2rc9bpiu
    w3IyXA/Aq2dDLQK17ux8gwR6tAIb9gtsV38gwNyE92EZ1BxPKD9nKAKH1hcH2xRPJPb2
    g3rxbXYcoG2Rx4mQqBDQTQh3yjm25DqbB+wm/oq4Ftjbc6sN55KiAKa2qjL7NRpHCEny
    Mbbg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJAhdlWwfLI"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.2.1 DYNA|AUTH)
    with ESMTPSA id Yce349yBFA1bs09
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 15 Dec 2022 11:01:37 +0100 (CET)
Date:   Thu, 15 Dec 2022 11:01:36 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Michael Srba <Michael.Srba@seznam.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "phy: qualcomm: usb28nm: Add MDM9607 init
 sequence"
Message-ID: <Y5rwgMOCSC2z/Xv9@gerhold.net>
References: <20221214223733.648167-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214223733.648167-1-marijn.suijten@somainline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 11:37:32PM +0100, Marijn Suijten wrote:
> This reverts commit 557a28811c7e0286d3816842032db5eb7bb5f156.
> 
> This commit introduced an init sequence from downstream DT [1] in the
> driver.  As mentioned by the comment above the HSPHY_INIT_CFG macro for
> this sequence:
> 
>     /*
>      * The macro is used to define an initialization sequence.  Each tuple
>      * is meant to program 'value' into phy register at 'offset' with 'delay'
>      * in us followed.
>      */
> 
> Instead of corresponding to offsets into the phy register, the sequence
> read by the downstream driver [2] is passed into ulpi_write [3] which
> crafts the address-value pair into a new value and writes it into the
> same register at USB_ULPI_VIEWPORT [4].  In other words, this init
> sequence is programmed into the hardware in a totally different way than
> downstream and is unlikely to achieve the desired result, if the hsphy
> is working at all.
> 

Thanks for sending this, I've also been meaning to do this for quite
some time :)

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> An alternative method needs to be found to write these init values at
> the desired location.  Fortunately mdm9607 did not land upstream yet [5]
> and should have its compatible revised to use the generic one, instead
> of a compatible that writes wrong data to the wrong registers.
> 

There is a simple solution to write the init values correctly: You can
just use the ULPI PHY driver for MSM8916 (phy-qcom-usb-hs.c), which
writes those init values correctly.

If you look closely at downstream you can see that all targets with the
"SNPS Femto PHY" (at least MSM8909, MDM9607, MSM8976) actually use a
mixture of the code currently implemented in the mainline ULPI PHY
driver (phy-qcom-usb-hs.c) and the actual Femto PHY driver
(phy-qcom-usb-hs-28nm.c):

 - The device trees contains "qcom,dp-manual-pullup", which enables the
   ULPI_MISC_A_VBUSVLDEXT magic that is currently implemented partly in
   phy-qcom-usb-hs.c and partly in ci_hdrc_msm.c: 
     - Downstream: https://git.codelinaro.org/clo/la/kernel/msm-4.9/-/blob/29f81c613f4c853f4125ef189ede1f6d610653c0/drivers/usb/gadget/ci13xxx_msm.c#L113
     - Mainline: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/phy/qualcomm/phy-qcom-usb-hs.c?h=v6.1#n92
       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/chipidea/ci_hdrc_msm.c?h=v6.1#n117

  - The ULPI init sequence is also implemented by phy-qcom-usb-hs.c in
    mainline: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/phy/qualcomm/phy-qcom-usb-hs.c?h=v6.1#n144

  - The PHY CSR registers implemented by phy-qcom-usb-hs-28nm.c are only
    used to enter retention mode downstream (I guess some low-power mode
    where an USB device/host could still wake up the other host/device).

We don't have support for proper support for retention on mainline
(phy-qcom-usb-hs-28nm.c never enables the retention mode without
 fully powering off the PHY immediately after using the regulators).

So I suggest that we simply use the ULPI PHY driver for MSM8916 at least
for MSM8909 and MDM9607 (haven't checked MSM8976 in detail). I have
tried it and it works without any problems on both MSM8909 and MDM9607.
No driver changes needed!

Thanks,
Stephan
