Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738E661F827
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiKGQBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiKGQBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:01:11 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DAC1A3AE;
        Mon,  7 Nov 2022 08:01:09 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B3F2A5C0089;
        Mon,  7 Nov 2022 11:01:08 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Mon, 07 Nov 2022 11:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1667836868; x=1667923268; bh=Oc
        MqlVPjKlmKhzuxKa/KdFDe8vaSPreulhqqsYoyPb4=; b=Up9vkF7jYQ1ujCZ/jg
        9tR1Fodo8WoCA38omMpmbTKogh7+VsfyUZmzQ+fNBR3u0lEtBkd1JS7vXC03ARS8
        P6HHgQY70t5+z6rTSfTA2bhPyBA7ugGprWAXrzp+PyKuYXUqVj/3pLFS7pa9lXzQ
        R2/FMn8tLnCddF50pImXfny+KkhkA5/5QMAKGL777+dciORgveJF9vXGGwmzJuVk
        mRq/Wm17dUQY3+F9jqBAwLzsYOqnWXD/4a/Noc8h9BkQ1YpOiqjx8W5fWXexGUUf
        qunHhDLgYlQCEDjyaWf90MAlG1TbW0cxqadTrFjjFth1Pc2oi83CGQ3i2dOB0dbA
        DNlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667836868; x=1667923268; bh=OcMqlVPjKlmKhzuxKa/KdFDe8vaS
        PreulhqqsYoyPb4=; b=ivKfXQ13nP9UNGqwk1nOVSNfuQh+VttwMZtlqnh5X28+
        WKEIfuMFKCNK3LbwOnSq6sS0SoSJgCYHFnuGtTt4KvIEKRI/ZBDcw/fPcAxA4ocH
        +tVkc5BFqyGo/2ojaWntoG788LQZ+VxBkJAM0TrwFMNceB8g4Q5/5yB7GGMf2qjI
        tcTp3DEBtDWK4xAakDZcVVFPUt6j9/mxjBeuEVkOf13kvX5xshuG2OUPtvsUE2V5
        OCjFeFi/jQi5K0mFEMDdz+3uQCivf/8EokYl6qJaeTF7WsS0hMEPivsmTvsnaTJL
        A0+zGL0YMI1dVQ5mK7sQFaE77REbahc4UFA3+pvMBw==
X-ME-Sender: <xms:wytpY4Q9ubqgOYIIoU7btC0XVb9HB-Bo24nQ_ANmFN8Ni1kEkDhQjg>
    <xme:wytpY1zlyWNaIXIegmj-exZgT-4fOx6zWoIVlkpmAL7PZsLCKzELxwXfsj45OTaTq
    WrPVGY0mT-YOllfWmE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdekgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefghfei
    veeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:xCtpY12oNxHYaqKGZv5tZS1BffNlMwuhSc-3wHgQBCUhlWau8cAb7Q>
    <xmx:xCtpY8CplXYN-aa9GmIIp2QLRTD0vVvrONBNqAvmGj504BaAf01frg>
    <xmx:xCtpYxiLfy3iLPstkNtKrOi_FsH9HSeBmTUUcv2BOo9WDRVnYVijeA>
    <xmx:xCtpY_buKGjdSvF1x8m6WLwB607VZT-TBk5_HHW5YiFNj1NYLZn1Pw>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D70BFA6007C; Mon,  7 Nov 2022 11:01:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <0bc7b309-6f3b-4821-81d0-435671d64e2f@app.fastmail.com>
In-Reply-To: <Y2jrQgj53z/mhHmm@smile.fi.intel.com>
References: <20221106214804.2814-1-j@jannau.net>
 <Y2jrQgj53z/mhHmm@smile.fi.intel.com>
Date:   Mon, 07 Nov 2022 17:00:47 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Janne Grunau" <j@jannau.net>
Cc:     linux-usb@vger.kernel.org, stable@kernel.org,
        "Thinh Nguyen" <Thinh.Nguyen@synopsys.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Andrey Smirnov" <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: dwc3: Do not get extcon device when usb-role-switch is
 used
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022, at 12:25, Andy Shevchenko wrote:
> On Sun, Nov 06, 2022 at 10:48:04PM +0100, Janne Grunau wrote:
>> The change breaks device tree based platforms with PHY device and use
>> usb-role-switch instead of an extcon switch. extcon_find_edev_by_node()
>> will return EPROBE_DEFER if it can not find a device so probing without
>> an extcon device will be deferred indefinitely. Fix this by
>> explicitly checking for usb-role-switch.
>> At least the out-of-tree USB3 support on Apple silicon based platforms
>> using dwc3 with tipd USB Type-C and PD controller is affected by this
>> issue.
>
> We don't care about out-of-tree modules, do we?
>
> OTOH, the problem you are trying to workaround is probably in a (mis)use of
> deferred probe somewhere.
>
> Btw, does it prevent the system boot or you just see the extcon in the list of
> deferred devices after booting?

Which extcon? The commit description already mentions that the issue is that there
is no extcon and that the dwc3 probe gets stuck with EPROBE_DEFER forever.

This happens because the code after Janne's new check looks for the PHY and then
just assumes that if the PHY has a "port" that the other end always is an extcon.
It then tries extcon_find_edev_by_node which will always fail with EPROBE_DEFER
if that node never registers an extcon.

If "usb-role-switch" is used and configured in the DT there is no extcon.
There actually cannot ever be a working extcon with "usb-role-switch" because
the very first thing dwc3_drd_init does is to look for a role switch partner
and then skip the entire extcon setup:

int dwc3_drd_init(struct dwc3 *dwc)
{
	int ret, irq;

	if (ROLE_SWITCH &&
	    device_property_read_bool(dwc->dev, "usb-role-switch"))
		return dwc3_setup_role_switch(dwc);
[....]


This entire issue was actually first fixed in ab7aa2866d29, then broken
again in 0f0101719138 due to a merge resolution, then fixed again with
7a84e7353e23 (where we actually had a brief discussion about this already
on the ML) and then broken again in d182c2e1bc92.

Janne's fix is much less subtle and should hopefully survive this time.

For the patch:

Reviewed-by: Sven Peter <sven@svenpeter.dev>


Best,

Sven
