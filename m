Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9490D677797
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjAWJnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjAWJnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:43:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E201A1F935;
        Mon, 23 Jan 2023 01:43:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37813B80CA6;
        Mon, 23 Jan 2023 09:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD88C433D2;
        Mon, 23 Jan 2023 09:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674466987;
        bh=zqDlD4UopnwoyaNHYVa7uoZaLDHyVvELIS4k830a3tE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cQck51QSo8S3o8L0jiTiWU/KpeSoiVyZcK+f7dn56i9J8+qhqem70UnLO8vXJSPPS
         MOdxE5M0Wd/Ptvrkhv7VfpzcMxs9Lm6UJ7bGVyI1jII0C9XM2eTgZ9Qs6IoJ0khLcn
         c2/+3OctjRN9iQWnGfLZyQuUgoNMXcfLZOr5m5ts86o8deD5axtsAD8mqCgrqWXdD7
         xQCVXHedeCqIqYv089jZIu6gFkfITQ7YI0v/h6OczP74sRn2v+YaU1UnBhlHncT7M0
         N6BKpWRzW/5y3pcD4QfnmVSuR/jFHHmtZEKF2zZvIbHBxppNrd+R8HLPByyzH/8BMY
         3qrAU6OFlJF+Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pJtM0-0000GF-SP; Mon, 23 Jan 2023 10:43:04 +0100
Date:   Mon, 23 Jan 2023 10:43:04 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] phy: qcom-qmp-combo: Add config for SM6350
Message-ID: <Y85WqDrGXAXp7gS/@hovoldconsulting.com>
References: <20221130081430.67831-1-luca.weiss@fairphone.com>
 <20221130081430.67831-2-luca.weiss@fairphone.com>
 <Y6xP4YRAp68TfxFi@hovoldconsulting.com>
 <Y8BIX+js1ircJyb9@matsya>
 <cf968a25-02f7-d402-530b-eb379b707e54@linaro.org>
 <CPR2LS3SJQ3I.Z7UY505COG3@otso>
 <CAA8EJpoOMMALHz7ysft6KvQaYhGWPD+xZiUjOTrC8CA_y81n-w@mail.gmail.com>
 <CPX2VVT5EUDV.2LH6VI2586F02@otso>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CPX2VVT5EUDV.2LH6VI2586F02@otso>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 03:13:46PM +0100, Luca Weiss wrote:
> On Fri Jan 13, 2023 at 2:01 PM CET, Dmitry Baryshkov wrote:
> > On Fri, 13 Jan 2023 at 14:44, Luca Weiss <luca.weiss@fairphone.com> wrote:
> > >
> > > Hi Dmitry,
> > >
> > > On Thu Jan 12, 2023 at 8:33 PM CET, Dmitry Baryshkov wrote:
> > > > On 12/01/2023 19:50, Vinod Koul wrote:
> > > > > On 28-12-22, 15:17, Johan Hovold wrote:
> > > > >> Luca, Vinod,
> > > > >>
> > > > >> On Wed, Nov 30, 2022 at 09:14:28AM +0100, Luca Weiss wrote:
> > > > >>> Add the tables and config for the combo phy found on SM6350.
> > > > >>>
> > > > >>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > > >>> ---
> > > > >>> Changes since v2:
> > > > >>> * Drop dp_txa/dp_txb changes, not required
> > > > >>> * Fix dp_dp_phy offset
> > > > >>>
> > > > >>>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 126 ++++++++++++++++++++++
> > > > >>>   1 file changed, 126 insertions(+)
> > > > >>>
> > > > >>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > > > >>> index 77052c66cf70..6ac0c68269dc 100644
> > > > >>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > > > >>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > > > >>
> > > > >>> @@ -975,6 +1039,19 @@ static const char * const sc7180_usb3phy_reset_l[] = {
> > > > >>>           "phy",
> > > > >>>   };
> > > > >>>
> > > > >>> +static const struct qmp_combo_offsets qmp_combo_offsets_v3 = {
> > > > >>> + .com            = 0x0000,
> > > > >>> + .txa            = 0x1200,
> > > > >>> + .rxa            = 0x1400,
> > > > >>> + .txb            = 0x1600,
> > > > >>> + .rxb            = 0x1800,
> > > > >>> + .usb3_serdes    = 0x1000,
> > > > >>> + .usb3_pcs_misc  = 0x1a00,
> > > > >>> + .usb3_pcs       = 0x1c00,
> > > > >>> + .dp_serdes      = 0x1000,
> > > > >>
> > > > >> I would have expected this to be 0x2000 as that's what the older
> > > > >> platforms have been using for the dp serdes table so far. Without access
> > > > >> to any documentation it's hard to tell whether everyone's just been
> > > > >> cargo-culting all along or if there's actually something there at offset
> > > > >> 0x2000.
> > > >
> > > > usb3_serdes is 0x1000, so dp_serdes equal to 0x1000 is definitely an typo.
> > > >
> > > > Judging from the downstream dtsi, the DP PHY starts at offset 0x2000. So
> > > > dp_serdes is equal to 0x2000, dp_phy = 0x2a00, ln_tx1 = 0x2200, ln_tx2 =
> > > > 0x2600.
> > >
> > > Can you share how you got to the 0x2000 offset? You can see my
> > > (potentially wrong) reasoning for 0x1000 a few messages ago[0].
> > >
> > > The only 0x2000-something I could find now while looking at it again is
> > > "#define USB3_DP_PHY_DP_DP_PHY_PD_CTL 0x2a18" which becomes
> > > USB3_DP_DP_PHY_PD_CTL in the driver but this is seemingly not used at
> > > all in my msm-4.19 tree.
> >
> > Quite simple: see [1]. DP_PLL is at +0x2000
> >
> > [1] https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/heads/android-msm-bramble-4.19-android11-qpr1/qcom/lagoon-sde-pll.dtsi#27
> 
> I still disagree from what I see.
> 
> E.g. this part of the dp_serdes init table in mainline:
> 
> static const struct qmp_phy_init_tbl qmp_v3_dp_serdes_tbl_rbr[] = {
> 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_HSCLK_SEL, 0x0c),
> 
> With this one:
> #define QSERDES_V3_COM_HSCLK_SEL                     0x13c
> 
> To write this config qmp->dp_serdes gets used which is set at:
> 	qmp->dp_serdes = base + offs->dp_serdes;
> 
> So if offs->dp_serdes is 0x2000, this write will go to 0x213c.
> 
> If we go back to msm-4.19 downstream the equivalent define is
> #define USB3_DP_QSERDES_COM_HSCLK_SEL				0x113c
> 
> So there we are at offset 0x1000. And this define is used in
> qcom,qmp-phy-init-seq which I already went to in detail in a previous
> email in this thread.

From what I've heard, the PHY driver in the vendor kernel only deals
with the USB part of the PHY, while some display driver accesses the DP
part directly. So the fact that the Qualcomm USB PHY driver init
sequences don't seem to use the DP regions (apart from that
USB3_DP_PHY_DP_DP_PHY_PD_CTL register) is to be expected.

IIRC the v3 layout was also used by the SoC for which DP support was
first implemented. Presumably, the separate USB and DP regions do exist
and you should include them also for SM6350 even if you can't test it
currently.

We'll convert the older platforms over to use the new binding scheme
soon and then we'd need this anyway. And if it turns out later that this
was all bogus, at least we only need to fix the driver (and not worry
about dts backward compatibility as we had to with the old style
bindings).

Johan
