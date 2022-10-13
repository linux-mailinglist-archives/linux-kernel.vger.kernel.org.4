Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8545FE27C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 21:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiJMTLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 15:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiJMTLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 15:11:17 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F238A159D57
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 12:11:14 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id d142so2169445iof.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 12:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N+RbCQy6agOrxRsXF3maxSmd+zszRbvT93/fk5OmsGs=;
        b=ccqpLlPlBB3Jy1Ohcx3z7+UxLsMlmrDCF2KwUIdyosdD4tZj8HtaiweG/Faz93gBzD
         0W3PoBEtXNEO4pmYpf6Cgkwq8Ct7u/le0NP2MVBpyEH22HqPrh+jqwsG6YrhCcf0uZ7u
         fH/T6wJFmxWtz9Z+GnPOZRnpIb5IeZ78nZxUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+RbCQy6agOrxRsXF3maxSmd+zszRbvT93/fk5OmsGs=;
        b=CNoHHALSnZ0OJ7MW6ME1YvWvjhfPpWXj/WTEeos75qeqvtVskG1fXRxhR+U0hIsYLG
         f9SwtxURm1S4IUYo2k/185b8QrkAwwZCUKE3MSw7YEIrh/g1/yk0uW9djTj3l5lzJdGl
         XWK85Pvv2buUAyaes6CxMVrDakGMoxySKLuzepsi3fC6whwYfbRIC57B664uia7dvrEG
         n4923NusN2B7jFZFu2ag4vqheBZqjQ9y3uHgufDl4TiK0UZgzlmLP1HHfIyE8MgogJQv
         5rzvY391DDeMQ6rG/McmbCGYb+bHXAWxzJlh6W+JR5hfWQbGwEtTRuku+6afEZ5KhiJd
         e27g==
X-Gm-Message-State: ACrzQf3Y3d4ywlPLaonL+wFSeyCb7EWXfGtLBK3dUVHFeVXFiosPv6TY
        jvh+wUZHc02BsseF+QZvVCUmyg==
X-Google-Smtp-Source: AMsMyM4oTcUb8lWKanp+jNZ78fPMYGbbFQOmyUiD+MqQV8JNfESL+heUotuzGkbCPBfz9ZlkZXcPOw==
X-Received: by 2002:a02:bb9a:0:b0:363:ab69:2514 with SMTP id g26-20020a02bb9a000000b00363ab692514mr868581jan.200.1665688274113;
        Thu, 13 Oct 2022 12:11:14 -0700 (PDT)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id g100-20020a02856d000000b003639ef62d08sm268603jai.84.2022.10.13.12.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 12:11:13 -0700 (PDT)
Date:   Thu, 13 Oct 2022 19:11:12 +0000
From:   "mka@chromium.org" <mka@chromium.org>
To:     "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>
Cc:     Miao-chen Chou <mcchou@chromium.org>,
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
Subject: Re: [PATCH v1 3/3] Bluetooth: hci_qca: WAR to handle WCN6750 HW issue
Message-ID: <Y0hi0CDzSLq2ewxj@google.com>
References: <1651228073-1999-1-git-send-email-quic_bgodavar@quicinc.com>
 <1651228073-1999-4-git-send-email-quic_bgodavar@quicinc.com>
 <0D3D8346-0F64-4CAF-8BED-940F189A3E97@holtmann.org>
 <SJ0PR02MB713538E5BBB40CDEF2E050A0F8FF9@SJ0PR02MB7135.namprd02.prod.outlook.com>
 <CABmPvSFiAC474WthmMX0nE20UEOxUD5dEYBVbiKh7HOovCnCkA@mail.gmail.com>
 <SJ0PR02MB7135746D204F13550E9BAE77F8B29@SJ0PR02MB7135.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ0PR02MB7135746D204F13550E9BAE77F8B29@SJ0PR02MB7135.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 07:27:21AM +0000, Balakrishna Godavarthi (QUIC) wrote:
> Hi Marcel/Miao,
> 
> We are working on new driver, by 7/29 we will submit initial patch for review.

Has this ever been sent? I skimmed through the list archives and couldn't find it.

> -----Original Message-----
> From: Miao-chen Chou <mcchou@chromium.org> 
> Sent: Tuesday, May 10, 2022 8:47 AM
> To: Balakrishna Godavarthi (QUIC) <quic_bgodavar@quicinc.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>; Andy Gross <agross@kernel.org>; robh+dt@kernel.org; bjorn.andersson@linaro.org; linux-arm-msm@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Johan Hedberg <johan.hedberg@gmail.com>; mka@chromium.org; linux-bluetooth@vger.kernel.org; Hemant Gupta (QUIC) <quic_hemantg@quicinc.com>; Sai Teja Aluvala (Temp) (QUIC) <quic_saluvala@quicinc.com>; quic_rjliao <quic_rjliao@quicinc.com>; Alain Michaud <alainmichaud@google.com>; Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Subject: Re: [PATCH v1 3/3] Bluetooth: hci_qca: WAR to handle WCN6750 HW issue
> 
> Hi Bala,
> 
> When is the estimated start date and timeline of the driver development?
> 
> Thanks,
> Miao
> 
> On Fri, Apr 29, 2022 at 8:09 PM Balakrishna Godavarthi (QUIC) <quic_bgodavar@quicinc.com> wrote:
> >
> > Hi Marcel,
> >
> > -----Original Message-----
> > From: Marcel Holtmann <marcel@holtmann.org>
> > Sent: Friday, April 29, 2022 8:24 PM
> > To: Balakrishna Godavarthi (QUIC) <quic_bgodavar@quicinc.com>
> > Cc: Andy Gross <agross@kernel.org>; robh+dt@kernel.org; 
> > bjorn.andersson@linaro.org; linux-arm-msm@vger.kernel.org; 
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Johan 
> > Hedberg <johan.hedberg@gmail.com>; mka@chromium.org; 
> > linux-bluetooth@vger.kernel.org; Hemant Gupta (QUIC) 
> > <quic_hemantg@quicinc.com>; Sai Teja Aluvala (Temp) (QUIC) 
> > <quic_saluvala@quicinc.com>; quic_rjliao <quic_rjliao@quicinc.com>; 
> > mcchou@chromium.org
> > Subject: Re: [PATCH v1 3/3] Bluetooth: hci_qca: WAR to handle WCN6750 
> > HW issue
> >
> > Hi Balakrishna,
> >
> > > The patch is workaround for hardware issue on WCN6750.
> > > On WCN6750 sometimes observed AON power source takes 100ms time to 
> > > fully discharge voltage during OFF. As WCN6750 is combo chip for 
> > > WLAN and BT. If any of the tech area ON is triggered during 
> > > discharge phase, it fails to turn ON.
> > > To overcome this hardware issue, During BT ON, driver check for 
> > > WLAN_EN pin status. If it high, it will pull BT_EN to high 
> > > immediately else it will wait for 100ms assuming WLAN was just 
> > > powered OFF and then BT_EN will be pulled to high.
> > >
> > > Fixes: d8f97da1b92d2 ("Bluetooth: hci_qca: Add support for QTI 
> > > Bluetooth chip wcn6750")
> > > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> > > Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
> > > Signed-off-by: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
> > > ---
> > > drivers/bluetooth/hci_qca.c | 30 ++++++++++++++++++++++++------
> > > 1 file changed, 24 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/bluetooth/hci_qca.c 
> > > b/drivers/bluetooth/hci_qca.c index eab34e2..c3862d1 100644
> > > --- a/drivers/bluetooth/hci_qca.c
> > > +++ b/drivers/bluetooth/hci_qca.c
> > > @@ -219,6 +219,7 @@ struct qca_serdev {
> > >       struct hci_uart  serdev_hu;
> > >       struct gpio_desc *bt_en;
> > >       struct gpio_desc *sw_ctrl;
> > > +     struct gpio_desc *wlan_en;
> > >       struct clk       *susclk;
> > >       enum qca_btsoc_type btsoc_type;
> > >       struct qca_power *bt_power;
> >
> > I am really against these intermixing of Bluetooth and WiFi details. There is work ongoing to do some sequence power procedure. Maybe that is something you should look into. This is a mess.
> >
> > And again, we are still hacking around hci_qca.c instead of writing a clean serdev only driver for this hardware. I have the feeling that nobody listens to review comments these days. It is just hacking patches together to get hardware enabled somehow and then disappear.
> >
> > [Bala]: We are working on serdev like driver for our QCA platform.  We are in initial stages of discussion, and soon we will start the driver development work.
> > In mean to stop stability or functional issues we are trying to add these HACKs in QCA driver.
> >
> > Regards
> >
> > Marcel
> >
