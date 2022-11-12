Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B8D626C9A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 00:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbiKLXLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 18:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiKLXLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 18:11:47 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F56DF77;
        Sat, 12 Nov 2022 15:11:46 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 6422432001C6;
        Sat, 12 Nov 2022 18:11:45 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Sat, 12 Nov 2022 18:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1668294705; x=1668381105; bh=kh
        nIpPk/qP1/uxcosccEQAXtAdWlBTJFtbAinjXeAQE=; b=CPlqXEvFN6Dm/Ovo6M
        u9Ql888+flCL/ICarV+LeiEaazDrAASvwMlsx8aIG8UsgpIwPaP8jZbiwjH20G+J
        d5woO11fp13L0kPW1Roybx+2UsXjW5dWltffGrAf13vv5OMLFJm+XbXeixDyRQCG
        zctKDoDXtKIrycAedMMObGaO3yyTyiRXTt3uJRlA66ahv4qrB/6TS2NI2qRS8kSV
        eUotVCg3QYD4FwMKMxMiDVM/VaBsPo4RJDdIseHb8oFAGowSA9wveQ+dnWb8Apci
        mP1ndbtBDZ0gINXHvrlK16EAsSZEI6kNv+7/0Uo4EyEFMCdRlJB0O20LBE1NlPpD
        fMdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668294705; x=1668381105; bh=khnIpPk/qP1/uxcosccEQAXtAdWl
        BTJFtbAinjXeAQE=; b=uIxYBQr48dhxBYloxVhdiGpxeIeXQTfvjOBnRqRsL4Lp
        FIxE6JZs+HfpjlT3anwQ3Abdaz75mCqZTvjhXav62rN7l4Byomvo06Y2aHkhPf+B
        Ygjt2iftlKT75o2SEeHOWCzcmXv/OpuY1u+u4KsgPgYRHUZU+NEpycQyL1ww4WD+
        i3/6dE+/Yo5XS0UKgfuEta7SNuVIYrCdLIIetPGuxf6oUvo5eEgNeaxAdjCmXdKb
        A629jN9cz9q9ymo9i9/9b9AwwDKDW7tlGBLGp5ZWFk0QXt0PfY+rS1q2ccugbMaz
        YEvhv0w7bzFTd2Oq/WMVDpJXcdcsYVE7MDrkdupx/w==
X-ME-Sender: <xms:MChwY0iVjMtvnPtZkDC1F9dPvaJuFkXZdogwj1Y_gwprIzFQmljQaA>
    <xme:MChwY9BbUE97KPaaT8AUgctJ3pWLZFTK--n8BbpHzHpUCUSM713SnZmRFXZtohGj6
    OTH42eJIbsIijTfbWk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeelgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefghfei
    veeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:MChwY8FP1PKadCop8pLs9tyY8RZYU5u5oMDXB6DcuxgnRluB_OsAvA>
    <xmx:MChwY1TH3EymCS-p1qLdDKWRQ11fmE90y3jHb7AaJZQsMNJCKtaZnQ>
    <xmx:MChwYxwbyuoiMQMIVZxgQ0TBrU1aqQa0DJau3L2yVCSmc5PajZ0xYw>
    <xmx:MShwYzuDqn0cIHkP-a2DZ7zKOhbzZnVjiSest0C1HN4LTEXW47JU0Q>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6016DA60084; Sat, 12 Nov 2022 18:11:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <b9bd0745-3459-4d9f-b19a-819fb4515e43@app.fastmail.com>
In-Reply-To: <dcbf54db-3cc5-6863-2805-4aa1adce234a@gmail.com>
References: <20221112102506.34990-1-sven@svenpeter.dev>
 <1800f8ea-2dde-a420-3e99-56237bde1bb0@gmail.com>
 <f3378173-2e15-467c-b159-7d523533ffc5@app.fastmail.com>
 <dcbf54db-3cc5-6863-2805-4aa1adce234a@gmail.com>
Date:   Sun, 13 Nov 2022 00:11:24 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Ferry Toth" <fntoth@gmail.com>
Cc:     "Felipe Balbi" <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Thinh Nguyen" <Thinh.Nguyen@synopsys.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] usb: dwc3: core: configure PHY before initializing host in
 dwc3_set_mode
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, Nov 13, 2022, at 00:07, Ferry Toth wrote:
> Hi,
>
> Op 12-11-2022 om 23:46 schreef Sven Peter:
>> Hi Ferry,
>> 
>> On Sat, Nov 12, 2022, at 23:15, Ferry Toth wrote:
>>> Hi Sven,
>>>
>>> Op 12-11-2022 om 11:25 schreef Sven Peter:
>>>> Usually, first the PHY is set to the correct mode and then the host or
>>>> device side of the controller is initialized afterwards. Otherwise a PHY
>>>> that's already used has to be reconfigured.
>>>> dwc3_core_init_mode() does this correctly for both host and device and
>>>> __dwc3_set_mode() does it correctly when switching to device mode.
>>>> When setting up host mode however it first initializes xhci and only
>>>> then changes the PHY's mode. Let's also do the operations in the correct
>>>> order here.
>>>>
>>>> Fixes: 958d1a4c40dd ("usb: dwc3: core: program PHY for proper DRD modes")
>>>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>>>> ---
>>>>    drivers/usb/dwc3/core.c | 9 +++++----
>>>>    1 file changed, 5 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>> index ad4d644e21a4..759d23d908fa 100644
>>>> --- a/drivers/usb/dwc3/core.c
>>>> +++ b/drivers/usb/dwc3/core.c
>>>> @@ -212,14 +212,15 @@ static void __dwc3_set_mode(struct work_struct *work)
>>>>    
>>>>    	switch (dwc->desired_dr_role) {
>>>>    	case DWC3_GCTL_PRTCAP_HOST:
>>>> +		if (dwc->usb2_phy)
>>>> +			otg_set_vbus(dwc->usb2_phy->otg, true);
>>>> +		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>>>> +		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>>>> +
>>>>    		ret = dwc3_host_init(dwc);
>>>>    		if (ret) {
>>>>    			dev_err(dwc->dev, "failed to initialize host\n");
>>>>    		} else {
>>>> -			if (dwc->usb2_phy)
>>>> -				otg_set_vbus(dwc->usb2_phy->otg, true);
>>>> -			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>>>> -			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>>>>    			if (dwc->dis_split_quirk) {
>>>>    				reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
>>>>    				reg |= DWC3_GUCTL3_SPLITDISABLE;
>>> This patch breaks usb host mode on Intel Merrifield platform. I am
>>> testing this on top of v6.0 +
>>> * my 2 "usb: dwc3: core: defer probe on ulpi_read_id timeout" patches
>>> (otherwise tusb1210 will not be probed on this platform)
>>> * Revert "usb: dwc3: disable USB core PHY management" (with/without this
>>> patch makes no difference)
>>> * usb: dwc3: Do not get extcon device when usb-role-switch is used
>>> (with/without this patch makes no difference)
>>>
>>> ftrace shows tusb1210 is indeed still probed, nevertheless in host mode
>>> it seems vbus is not powered as my connected smsc95xx based hub is not
>>> active (seems not plugged).
>>>
>>> Flipping the switch to device mode gadgets work fine.
>>>
>>> Could it be dwc3_host_init() needs to be called prior to otg_set_vbus()?
>> 
>> Huh, thanks for testing!
>> 
>> For the platform I'm working on I need to set the phy mode before dwc3_host_init()
>> and then found the same code further below in dwc3_core_init_mode,
>> 
>> static int dwc3_core_init_mode(struct dwc3 *dwc)
>> {
>> [...]
>> 	case USB_DR_MODE_HOST:
>> 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
>> 
>> 		if (dwc->usb2_phy)
>> 			otg_set_vbus(dwc->usb2_phy->otg, true);
>> 		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>> 		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>> 
>> 		ret = dwc3_host_init(dwc);
>> 		if (ret)
>> 			return dev_err_probe(dev, ret, "failed to initialize host\n");
>> 		break;
>> [...]
>> }
>> 
>> so I'm quite surprised it causes issue in __dwc3_set_mode now.
>> If otg_set_vbus indeed needs to happen after dwc3_host_init it should probably
>> also be called afterwards in dwc3_core_init_mode as well.
>
> Maybe there is a difference between the case USB_DR_MODE_HOST above and 
> case USB_DR_MODE_OTG touched by this patch?

Would be surprising but who knows. I'll see if I can move more of the PHY
initialization on my platform to the power_on callback so that it'll also
work there with the current code.
I just thought this was going to fix a bug but if it breaks things it's better
to just drop this patch.


Thanks,


Sven

