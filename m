Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1522A626C30
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 23:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbiKLWqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 17:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiKLWqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 17:46:46 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE54D15A3C;
        Sat, 12 Nov 2022 14:46:44 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C949D32002D8;
        Sat, 12 Nov 2022 17:46:41 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Sat, 12 Nov 2022 17:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1668293201; x=1668379601; bh=UR
        6IZENSs9Hhv2gtReWHrfdfYMNRxyX0JgKvZaNESMM=; b=gqmiTzPVUIKICbV0rT
        mYa/C3SOcK3X4P0ZSAxIYw5XX/9zm+iy3FRh02ISej1X6QSUGFnDkf5MJgq42UXG
        7dsRMfcpvZoTo5s7cYmi4SHoRKzgUjVZ869jm2hUPbgG9GoCj+LDNSmYtTYfSe+F
        UKQ2bj8VPaZTXZ2gl23zSnwtEGPg/i9DvlG3NMCzTAvUYZ0YpL1RZq347QH79ux8
        br3Q+kzL/ufOhEV2AYUFpnTkmVGe0omDxzdfPPTgE6uPqu5DNQxZPJpLXEX+3ICA
        zYnC+ERsPHlD6iq5Yne2ba4eAcrzuh+1FZRtd5/kMOPjYK1oQniVCLK4amVrdH5Q
        g37Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668293201; x=1668379601; bh=UR6IZENSs9Hhv2gtReWHrfdfYMNR
        xyX0JgKvZaNESMM=; b=QZ2bB0r3zIF4kBQgSYHmtzqd0hii9X91zrRLeLrmb/Fl
        ro8qPsKnJ44OcHKgh+PkrSbd5je148LiMQU2dCgUIQ2W0l8gzf8GG6qo5rWde9U2
        G4tLUH5Jd84sfniPiruyPntl7YERjnfTtfhREGVAGFzaFJ8+vnb7/mYYl5fPeXgk
        QnulMaIi4ARTpKZnEfZGVdg7tRm2osNwGBicEt7hE6RNf5B//lhsb3k4JcRTBmRX
        MCB66rXHgKZ9uTyFla470S5xwvDm8FCCweD6lPRk8fbKihOf7br7ts5qz1mckMdY
        qnDV1qBqLGcjFXeEhhi118i8QwPUx/0qEjH7geZE8w==
X-ME-Sender: <xms:UCJwYyrvkZkXszrrPN7gpZdYr7IjkREz_uMKX8yE6IY17G2r-wY9hg>
    <xme:UCJwYwqtsK5h1Vkj8Xh9XduQVPOlwE0DkYx-YJZOs8fk7MABOVFR1LHCPZTIBwYg2
    drdxy5GhE_eUF_h41I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeelgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefghfei
    veeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:UCJwY3MBSUUZVTvODuISst857emTpFL1HAd0hUuXDbX-lnMrsvhD0Q>
    <xmx:UCJwYx5cSmxf4TfBTUDoAZEXxxKpMwi-VfVNaFJeNh50ARnF235QVQ>
    <xmx:UCJwYx7xVxbSrW0o_HVQtW7Oe-XdZ6S77WNw_xD25DzHL_5eyiMRLw>
    <xmx:USJwY00mUeXTQCvjvI47wKPthQbd75cqjXm-Pac1EVZl8OfVwbfA_w>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D94A7A60084; Sat, 12 Nov 2022 17:46:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <f3378173-2e15-467c-b159-7d523533ffc5@app.fastmail.com>
In-Reply-To: <1800f8ea-2dde-a420-3e99-56237bde1bb0@gmail.com>
References: <20221112102506.34990-1-sven@svenpeter.dev>
 <1800f8ea-2dde-a420-3e99-56237bde1bb0@gmail.com>
Date:   Sat, 12 Nov 2022 23:46:19 +0100
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

Hi Ferry,

On Sat, Nov 12, 2022, at 23:15, Ferry Toth wrote:
> Hi Sven,
>
> Op 12-11-2022 om 11:25 schreef Sven Peter:
>> Usually, first the PHY is set to the correct mode and then the host or
>> device side of the controller is initialized afterwards. Otherwise a PHY
>> that's already used has to be reconfigured.
>> dwc3_core_init_mode() does this correctly for both host and device and
>> __dwc3_set_mode() does it correctly when switching to device mode.
>> When setting up host mode however it first initializes xhci and only
>> then changes the PHY's mode. Let's also do the operations in the correct
>> order here.
>> 
>> Fixes: 958d1a4c40dd ("usb: dwc3: core: program PHY for proper DRD modes")
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>> ---
>>   drivers/usb/dwc3/core.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index ad4d644e21a4..759d23d908fa 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -212,14 +212,15 @@ static void __dwc3_set_mode(struct work_struct *work)
>>   
>>   	switch (dwc->desired_dr_role) {
>>   	case DWC3_GCTL_PRTCAP_HOST:
>> +		if (dwc->usb2_phy)
>> +			otg_set_vbus(dwc->usb2_phy->otg, true);
>> +		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>> +		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>> +
>>   		ret = dwc3_host_init(dwc);
>>   		if (ret) {
>>   			dev_err(dwc->dev, "failed to initialize host\n");
>>   		} else {
>> -			if (dwc->usb2_phy)
>> -				otg_set_vbus(dwc->usb2_phy->otg, true);
>> -			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>> -			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>>   			if (dwc->dis_split_quirk) {
>>   				reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
>>   				reg |= DWC3_GUCTL3_SPLITDISABLE;
> This patch breaks usb host mode on Intel Merrifield platform. I am 
> testing this on top of v6.0 +
> * my 2 "usb: dwc3: core: defer probe on ulpi_read_id timeout" patches 
> (otherwise tusb1210 will not be probed on this platform)
> * Revert "usb: dwc3: disable USB core PHY management" (with/without this 
> patch makes no difference)
> * usb: dwc3: Do not get extcon device when usb-role-switch is used 
> (with/without this patch makes no difference)
>
> ftrace shows tusb1210 is indeed still probed, nevertheless in host mode 
> it seems vbus is not powered as my connected smsc95xx based hub is not 
> active (seems not plugged).
>
> Flipping the switch to device mode gadgets work fine.
>
> Could it be dwc3_host_init() needs to be called prior to otg_set_vbus()?

Huh, thanks for testing!

For the platform I'm working on I need to set the phy mode before dwc3_host_init()
and then found the same code further below in dwc3_core_init_mode,

static int dwc3_core_init_mode(struct dwc3 *dwc)
{
[...]
	case USB_DR_MODE_HOST:
		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);

		if (dwc->usb2_phy)
			otg_set_vbus(dwc->usb2_phy->otg, true);
		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);

		ret = dwc3_host_init(dwc);
		if (ret)
			return dev_err_probe(dev, ret, "failed to initialize host\n");
		break;
[...]
}

so I'm quite surprised it causes issue in __dwc3_set_mode now.
If otg_set_vbus indeed needs to happen after dwc3_host_init it should probably
also be called afterwards in dwc3_core_init_mode as well.


Best,


Sven
