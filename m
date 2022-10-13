Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0925FE315
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJMUHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiJMUG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:06:58 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC92413ECEB;
        Thu, 13 Oct 2022 13:06:54 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b2so4135964lfp.6;
        Thu, 13 Oct 2022 13:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJZAZ2fnNu2AnK6OSOS++lr4vZhBiubylvgO1aOnDIw=;
        b=KUtyVWkrxGwvjvOwdDGw67pg1QuwUw7e2d8ZQcdBHirSNt3LdaUpn+UiDcoxY47xeR
         5hAPWy8fS+LSOCjQM5+ayls/JvSSyLV4jkTHWt1c5If2o/t8WpOiex3wIVAtR1+RteWq
         X2qoudsAkcgOTEjfhm6ZB3VRoqo05g1Pyu7MIsnmcKeUdRuFHAIH933of/38MMSjTCkc
         Lg3U//bnTFJ/xXgmNLFg04XkZJfy2M9FR3qJwSyDRNsFfiWGEGGc4VzYGcrkyBxw218X
         MJG2DAYo7XD9kRy1clT3BkOZ4FbOBiaT0B/mWvPUMXOt0lRBbaifOKsMklyL7GbnO2sS
         geiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJZAZ2fnNu2AnK6OSOS++lr4vZhBiubylvgO1aOnDIw=;
        b=XMyNPxzSeaEZCR9WRFLimiirhkwshfhlF2umZ+m1DkdBAtnpgRSg2UAJwoBilJ1+R/
         apt0mGl7tI7eVRwiLR5+GcR8qSQTgwWJsV78Xm4aI0HPgJls7hUSx5YbCeRdNL6xe5LM
         pj5lCGMB8UHBz7u9R632ga46rYtdUDz/zOsu8m7f/IgSfKH3g9FkYg6oaBBy2YmzDBNm
         8yE+dmUGuUZZtB3LTz5E0DEwqHrcBk28XJU7W+dzPMUv/SXvGa2oA6fXh5NbLKB7iRMr
         w736ge3DZiLYnFuIDSSMnGEmsdWqvKF08Z26EhgYHPvYDTHkUVZWZ9iejTbbote3lKPK
         XUEw==
X-Gm-Message-State: ACrzQf1weimqNiIMj9BRKtQTw3NJM3s/y0Bq8uW0upjZG854zNppBDv4
        mr2SYzwEuKKRCD/vYi+p2z8UZia9MkUfzCE8N97LtTcH
X-Google-Smtp-Source: AMsMyM75x7lKi30GnrE9xoGjKnBAVoi4lBYLqVM/SmdxWX5LcF2ya/d1DYUYk66SwXYTmeW84sG5+QKZlFnT5VdVXm0=
X-Received: by 2002:a05:6512:34c9:b0:4a2:2b33:5358 with SMTP id
 w9-20020a05651234c900b004a22b335358mr432845lfr.106.1665691612948; Thu, 13 Oct
 2022 13:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <1651228073-1999-1-git-send-email-quic_bgodavar@quicinc.com>
 <1651228073-1999-4-git-send-email-quic_bgodavar@quicinc.com>
 <0D3D8346-0F64-4CAF-8BED-940F189A3E97@holtmann.org> <SJ0PR02MB713538E5BBB40CDEF2E050A0F8FF9@SJ0PR02MB7135.namprd02.prod.outlook.com>
 <CABmPvSFiAC474WthmMX0nE20UEOxUD5dEYBVbiKh7HOovCnCkA@mail.gmail.com>
 <SJ0PR02MB7135746D204F13550E9BAE77F8B29@SJ0PR02MB7135.namprd02.prod.outlook.com>
 <Y0hi0CDzSLq2ewxj@google.com>
In-Reply-To: <Y0hi0CDzSLq2ewxj@google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 13 Oct 2022 13:06:41 -0700
Message-ID: <CABBYNZ+OCUKTYGW0SOkQMEawzGOPR_1GqxFBhnjpSPHCXd_7Eg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] Bluetooth: hci_qca: WAR to handle WCN6750 HW issue
To:     "mka@chromium.org" <mka@chromium.org>
Cc:     "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Andy Gross <agross@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>,
        "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>,
        "Rocky Liao (QUIC)" <quic_rjliao@quicinc.com>,
        Alain Michaud <alainmichaud@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Zhengping Jiang <jiangzp@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 13, 2022 at 12:29 PM mka@chromium.org <mka@chromium.org> wrote:
>
> On Wed, Jun 22, 2022 at 07:27:21AM +0000, Balakrishna Godavarthi (QUIC) w=
rote:
> > Hi Marcel/Miao,
> >
> > We are working on new driver, by 7/29 we will submit initial patch for =
review.
>
> Has this ever been sent? I skimmed through the list archives and couldn't=
 find it.

If you are asking if it was applied, not it wasn't, it probably needs
to be resend since we were expecting a follow up on the set.

> > -----Original Message-----
> > From: Miao-chen Chou <mcchou@chromium.org>
> > Sent: Tuesday, May 10, 2022 8:47 AM
> > To: Balakrishna Godavarthi (QUIC) <quic_bgodavar@quicinc.com>
> > Cc: Marcel Holtmann <marcel@holtmann.org>; Andy Gross <agross@kernel.or=
g>; robh+dt@kernel.org; bjorn.andersson@linaro.org; linux-arm-msm@vger.kern=
el.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Johan Hed=
berg <johan.hedberg@gmail.com>; mka@chromium.org; linux-bluetooth@vger.kern=
el.org; Hemant Gupta (QUIC) <quic_hemantg@quicinc.com>; Sai Teja Aluvala (T=
emp) (QUIC) <quic_saluvala@quicinc.com>; quic_rjliao <quic_rjliao@quicinc.c=
om>; Alain Michaud <alainmichaud@google.com>; Abhishek Pandit-Subedi <abhis=
hekpandit@chromium.org>
> > Subject: Re: [PATCH v1 3/3] Bluetooth: hci_qca: WAR to handle WCN6750 H=
W issue
> >
> > Hi Bala,
> >
> > When is the estimated start date and timeline of the driver development=
?
> >
> > Thanks,
> > Miao
> >
> > On Fri, Apr 29, 2022 at 8:09 PM Balakrishna Godavarthi (QUIC) <quic_bgo=
davar@quicinc.com> wrote:
> > >
> > > Hi Marcel,
> > >
> > > -----Original Message-----
> > > From: Marcel Holtmann <marcel@holtmann.org>
> > > Sent: Friday, April 29, 2022 8:24 PM
> > > To: Balakrishna Godavarthi (QUIC) <quic_bgodavar@quicinc.com>
> > > Cc: Andy Gross <agross@kernel.org>; robh+dt@kernel.org;
> > > bjorn.andersson@linaro.org; linux-arm-msm@vger.kernel.org;
> > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Johan
> > > Hedberg <johan.hedberg@gmail.com>; mka@chromium.org;
> > > linux-bluetooth@vger.kernel.org; Hemant Gupta (QUIC)
> > > <quic_hemantg@quicinc.com>; Sai Teja Aluvala (Temp) (QUIC)
> > > <quic_saluvala@quicinc.com>; quic_rjliao <quic_rjliao@quicinc.com>;
> > > mcchou@chromium.org
> > > Subject: Re: [PATCH v1 3/3] Bluetooth: hci_qca: WAR to handle WCN6750
> > > HW issue
> > >
> > > Hi Balakrishna,
> > >
> > > > The patch is workaround for hardware issue on WCN6750.
> > > > On WCN6750 sometimes observed AON power source takes 100ms time to
> > > > fully discharge voltage during OFF. As WCN6750 is combo chip for
> > > > WLAN and BT. If any of the tech area ON is triggered during
> > > > discharge phase, it fails to turn ON.
> > > > To overcome this hardware issue, During BT ON, driver check for
> > > > WLAN_EN pin status. If it high, it will pull BT_EN to high
> > > > immediately else it will wait for 100ms assuming WLAN was just
> > > > powered OFF and then BT_EN will be pulled to high.
> > > >
> > > > Fixes: d8f97da1b92d2 ("Bluetooth: hci_qca: Add support for QTI
> > > > Bluetooth chip wcn6750")
> > > > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> > > > Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
> > > > Signed-off-by: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
> > > > ---
> > > > drivers/bluetooth/hci_qca.c | 30 ++++++++++++++++++++++++------
> > > > 1 file changed, 24 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/bluetooth/hci_qca.c
> > > > b/drivers/bluetooth/hci_qca.c index eab34e2..c3862d1 100644
> > > > --- a/drivers/bluetooth/hci_qca.c
> > > > +++ b/drivers/bluetooth/hci_qca.c
> > > > @@ -219,6 +219,7 @@ struct qca_serdev {
> > > >       struct hci_uart  serdev_hu;
> > > >       struct gpio_desc *bt_en;
> > > >       struct gpio_desc *sw_ctrl;
> > > > +     struct gpio_desc *wlan_en;
> > > >       struct clk       *susclk;
> > > >       enum qca_btsoc_type btsoc_type;
> > > >       struct qca_power *bt_power;
> > >
> > > I am really against these intermixing of Bluetooth and WiFi details. =
There is work ongoing to do some sequence power procedure. Maybe that is so=
mething you should look into. This is a mess.
> > >
> > > And again, we are still hacking around hci_qca.c instead of writing a=
 clean serdev only driver for this hardware. I have the feeling that nobody=
 listens to review comments these days. It is just hacking patches together=
 to get hardware enabled somehow and then disappear.
> > >
> > > [Bala]: We are working on serdev like driver for our QCA platform.  W=
e are in initial stages of discussion, and soon we will start the driver de=
velopment work.
> > > In mean to stop stability or functional issues we are trying to add t=
hese HACKs in QCA driver.
> > >
> > > Regards
> > >
> > > Marcel
> > >



--=20
Luiz Augusto von Dentz
