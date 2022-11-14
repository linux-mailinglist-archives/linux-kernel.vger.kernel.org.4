Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80526278EE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbiKNJXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236121AbiKNJW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:22:57 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999971571B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:22:55 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-37063f855e5so100370967b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YTSPKqKmSzN7Y9ddQTOuim0BwGIV+0OUYKAM+OJAgxU=;
        b=FJ8f0IlKEyuFd9c7FRLCSKtPbw3QibehiiaGqUeq13/pnK5SBl1WAZuZCgYVpNe3k4
         nIFNx26dIzPHHJJMcAJJzbYkpBv9TRwhr8h3Nn85SVR1C4jOzcg9x4IyqLcQQCgUZRaf
         NEdfibo8iCzpRAWzKALEdeq3EuKnP5EKCDNi0FnghnveIVjSVLTcXsD8P19jRerKOAR0
         ifvE9S/xti3oOvKMN5soUdNK9kFamqamD42vr5Zvh0qwFkcRNsLKBvjMFYTdrdI+h4Qf
         0aA2LzoB96c8hAus+8eZ9UtahFBWs+oMBlK+zns8VlU6TeLfhiMzoR6lKDH7k4SaAl2W
         fA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTSPKqKmSzN7Y9ddQTOuim0BwGIV+0OUYKAM+OJAgxU=;
        b=APFGOGof4sbhs60EAq5pKLiKjuR1JqgJxxyaYe/fvzBzIlhkTrCrMAGM8Xk2poSF92
         yxFwRjP2CLfrlAFRtUbKswWUSGcMBAecTSRlUIrZJjdH+JjZ1Q9VQiI/PTXDvzodieuz
         5TYu0OCiIKuf9vcdHfzAtMp37+FU6G5tk7LaUt3m62fdIgcuXvPZPmuz0a6WstB/7ADj
         XdfwpBM5GycQdia/WqD1jVGlW5Zs6BF2l/Qyxya4FRCvrC7uLRCMzvfg+7rTQcpPk9+P
         SPQmy7vdbWtVtSLSLWf+Z0qgutQRI4DlfUirwgh23+blinoKoDT1dFbXi8X4aOy75W2A
         xItQ==
X-Gm-Message-State: ANoB5pnH2YLRU/4fVjdSSJCgKmFtSprsz5l6ryfDBaakp9nvroQH6xjQ
        9p20IL//d9lCFXkLlygacRobNn9VPdKdH/vnsKFFfw==
X-Google-Smtp-Source: AA0mqf6Eb3N3yWA9GPPGTDup7DI7EWbsnHCkjc6p+IN70Fp46vORCtD3Crhhj/Vg7Sc8Pa8MQ7wdH5SW7I+84etan38=
X-Received: by 2002:a81:9297:0:b0:370:547a:9d03 with SMTP id
 j145-20020a819297000000b00370547a9d03mr12582358ywg.132.1668417774745; Mon, 14
 Nov 2022 01:22:54 -0800 (PST)
MIME-Version: 1.0
References: <20221111085643.9478-1-johan+linaro@kernel.org>
 <20221111085643.9478-19-johan+linaro@kernel.org> <54d3d1b4-29de-4d18-a39e-bf74a5c61509@linaro.org>
 <Y3ID+jTI4Bf6wvh2@hovoldconsulting.com>
In-Reply-To: <Y3ID+jTI4Bf6wvh2@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 14 Nov 2022 12:22:43 +0300
Message-ID: <CAA8EJpqbrefwFxsudjm=-P8xYSg2Q5tXkvjOSKCt6qqbO5ubPg@mail.gmail.com>
Subject: Re: [PATCH 18/22] phy: qcom-qmp-combo: merge driver data
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022 at 12:02, Johan Hovold <johan@kernel.org> wrote:
>
> On Sat, Nov 12, 2022 at 10:46:53AM +0300, Dmitry Baryshkov wrote:
> > On 11/11/2022 11:56, Johan Hovold wrote:
> > > The QMP combo driver manages a single PHY (even if it provides two
> > > interfaces for USB and DP, respectively) so merge the old qcom_qmp and
> > > qmp_phy structures and drop the PHY array.
> > >
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > >   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 690 ++++++++++------------
> > >   1 file changed, 313 insertions(+), 377 deletions(-)
> > >
>
> > > -/**
> > > - * struct qmp_phy - per-lane phy descriptor
> > > - *
> > > - * @phy: generic phy
> > > - * @cfg: phy specific configuration
> > > - * @serdes: iomapped memory space for phy's serdes (i.e. PLL)
> > > - * @tx: iomapped memory space for lane's tx
> > > - * @rx: iomapped memory space for lane's rx
> > > - * @pcs: iomapped memory space for lane's pcs
> > > - * @tx2: iomapped memory space for second lane's tx (in dual lane PHYs)
> > > - * @rx2: iomapped memory space for second lane's rx (in dual lane PHYs)
> > > - * @pcs_misc: iomapped memory space for lane's pcs_misc
> > > - * @pcs_usb: iomapped memory space for lane's pcs_usb
> > > - * @pipe_clk: pipe clock
> > > - * @qmp: QMP phy to which this lane belongs
> > > - * @mode: current PHY mode
> > > - * @dp_aux_cfg: Display port aux config
> > > - * @dp_opts: Display port optional config
> > > - * @dp_clks: Display port clocks
> > > - */
> > > -struct qmp_phy {
> > > -   struct phy *phy;
> > > +struct qmp_phy_dp_clks {
> > > +   struct qmp_combo *qmp;
> > > +   struct clk_hw dp_link_hw;
> > > +   struct clk_hw dp_pixel_hw;
> > > +};
> > > +
> >
> > It would make sense to keep the kerneldoc here.
>
> I disagree. The above kernel doc is at best pointless and mostly just
> restates what can be understood from the field names.

Well, if viewed this way, 80% of kerneldocs's are pointless, as most
of the fields are self-describing.
In this case I can agree with you though. Especially since the struct
is not a part of the public API.

>
> Note how it also incorrect by referring to "memory space for *lane's*

I assumed that `lane's rx' and `lane's tx' were ugly wording. But yeah.

> ...".
>
> > > +struct qmp_combo {
> > > +   struct device *dev;
> > > +
> > >     const struct qmp_phy_cfg *cfg;
> > > +
> > > +   void __iomem *dp_com;
> > > +
> > >     void __iomem *serdes;
> > >     void __iomem *tx;
> > >     void __iomem *rx;
> > > @@ -899,59 +889,33 @@ struct qmp_phy {
> > >     void __iomem *dp_pcs;
> > >
> > >     struct clk *pipe_clk;
> > > -   struct qcom_qmp *qmp;
> > > -   enum phy_mode mode;
> > > -   unsigned int dp_aux_cfg;
> > > -   struct phy_configure_opts_dp dp_opts;
> > > -   struct qmp_phy_dp_clks *dp_clks;
> > > -};
> > > -
> > > -struct qmp_phy_dp_clks {
> > > -   struct qmp_phy *qphy;
> > > -   struct clk_hw dp_link_hw;
> > > -   struct clk_hw dp_pixel_hw;
> > > -};
> > > -
> > > -/**
> > > - * struct qcom_qmp - structure holding QMP phy block attributes
> > > - *
> > > - * @dev: device
> > > - * @dp_com: iomapped memory space for phy's dp_com control block
> > > - *
> > > - * @clks: array of clocks required by phy
> > > - * @resets: array of resets required by phy
> > > - * @vregs: regulator supplies bulk data
> > > - *
> > > - * @phys: array of per-lane phy descriptors
> > > - * @phy_mutex: mutex lock for PHY common block initialization
> > > - * @init_count: phy common block initialization count
> > > - */
> > > -struct qcom_qmp {
> > > -   struct device *dev;
> > > -   void __iomem *dp_com;
> > > -
> > >     struct clk_bulk_data *clks;
> > >     struct reset_control_bulk_data *resets;
> > >     struct regulator_bulk_data *vregs;
> > >
> > > -   struct qmp_phy **phys;
> > > -   struct qmp_phy *usb_phy;
> > > -
> > >     struct mutex phy_mutex;
> > >     int init_count;
> > > +
> > > +   struct phy *usb_phy;
> > > +   enum phy_mode mode;
> > > +
> > > +   struct phy *dp_phy;
> > > +   unsigned int dp_aux_cfg;
> > > +   struct phy_configure_opts_dp dp_opts;
> > > +   struct qmp_phy_dp_clks *dp_clks;
> > >   };
> > >
> > > -static void qcom_qmp_v3_phy_dp_aux_init(struct qmp_phy *qphy);
> > > -static void qcom_qmp_v3_phy_configure_dp_tx(struct qmp_phy *qphy);
> > > -static int qcom_qmp_v3_phy_configure_dp_phy(struct qmp_phy *qphy);
> > > -static int qcom_qmp_v3_dp_phy_calibrate(struct qmp_phy *qphy);
> > > +static void qcom_qmp_v3_phy_dp_aux_init(struct qmp_combo *qmp);
> > > +static void qcom_qmp_v3_phy_configure_dp_tx(struct qmp_combo *qmp);
> > > +static int qcom_qmp_v3_phy_configure_dp_phy(struct qmp_combo *qmp);
> > > +static int qcom_qmp_v3_dp_phy_calibrate(struct qmp_combo *qmp);
> > >
> > > -static void qcom_qmp_v4_phy_dp_aux_init(struct qmp_phy *qphy);
> > > -static void qcom_qmp_v4_phy_configure_dp_tx(struct qmp_phy *qphy);
> > > -static int qcom_qmp_v4_phy_configure_dp_phy(struct qmp_phy *qphy);
> > > -static int qcom_qmp_v4_dp_phy_calibrate(struct qmp_phy *qphy);
> > > +static void qcom_qmp_v4_phy_dp_aux_init(struct qmp_combo *qmp);
> > > +static void qcom_qmp_v4_phy_configure_dp_tx(struct qmp_combo *qmp);
> > > +static int qcom_qmp_v4_phy_configure_dp_phy(struct qmp_combo *qmp);
> > > +static int qcom_qmp_v4_dp_phy_calibrate(struct qmp_combo *qmp);
> > >
> > > -static int qcom_qmp_v5_phy_configure_dp_phy(struct qmp_phy *qphy);
> > > +static int qcom_qmp_v5_phy_configure_dp_phy(struct qmp_combo *qmp);
> >
> >
> > As you are doing the cleanup anyway, would it make sense to move these
> > functions up to be able to drop these prototypes?
>
> Nah, we want to keep the DP implementation together and for now the
> configuration structs live at the top of the file.
>
> > >
> > >   static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
> > >   {
> > > @@ -1265,11 +1229,11 @@ static void qmp_combo_configure(void __iomem *base,
> >
> >
> > The rest LGTM
>
> Thanks for reviewing all of these these.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
