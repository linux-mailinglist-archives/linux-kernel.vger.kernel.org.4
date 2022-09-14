Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F035B864A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiINKY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiINKYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:24:37 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2201A3B8;
        Wed, 14 Sep 2022 03:24:34 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 158B75C012E;
        Wed, 14 Sep 2022 06:24:32 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute4.internal (MEProxy); Wed, 14 Sep 2022 06:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1663151072; x=1663237472; bh=4G
        22fVvk8WenHj+MqQ5LUF2d/Do37iHoErDy2LmjSsI=; b=WoXoLduZdD0A/zwR2u
        F46C3h7JVMPJNFXf7tyKpug5kWyz8WwHCuy1S9+AAQISvWBuGV6oIf4mnonUNnSJ
        RK71YHXZ5RC6vMoEOk8OraLcQn9KODZ+61uVg+haHZYzsNRVHWXfcN+3NfL5KNrb
        29kCiA1vNH+n1ChV86KToIfj7vFFImX2oyeWmTpZ/Eu/1Cl+qOISo/uqcNV3AFDy
        wZg6ChwVRc6rp+wYwGAuSGMIxLpiZAG82acbER4k9RsNv2//o0j2rbA+JsT6KwoU
        SuO+V9Zg7TWoZe/NA2zWk/+Ra1C7wAAkeGqacQ/00m1qE8JcyAATlMfPcm+vvBKr
        JsFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663151072; x=1663237472; bh=4G22fVvk8WenHj+MqQ5LUF2d/Do3
        7iHoErDy2LmjSsI=; b=uX4R/6iTXxay5Hge23f5YU/fR9kYxTndXlKGC4xHhUOh
        BELyAlklBKr0mTi7nBDpbJydLAn8ccuSBhozuaw1mcKXlFgeNbiD6lvV9I4VrvQ9
        abtaDXajji36BoPrMg5C1FW9k+aTgoKuvYE6ziwN4xvqJ66VU6iDWOo3GVcX8s6G
        6454HfSLZmZDUfvL0DU8nzDRbenGsle9h7if+bbn9SMlrhuna0kWY3fqHqfBN7Hr
        tGkJDrfqMf50ob/5kiTmoljtafjiVhl3vDmDStc73edCwvZvDtlpeAV/c0izckZU
        Y8u9wErp333iTByZXgQ3s/Pe9wYuVAETtFClAvdcCw==
X-ME-Sender: <xms:36shY4P6iPXQtg_Nb3__sIq61wZoYeAxeGVB94KlHNGlZW95BGTetw>
    <xme:36shY-93Hm_KYMHirHZtBz8L-RNd_wkyg9i5wwpt3U6tLhCsBCkCv0fpHyzlNzVF3
    G3gOiQfZP57PIpfnBk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeduiedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdforghthhgvficuofgtuehrihguvgdfuceomhgrthht
    sehtrhgrvhgvrhhsvgdrtghomhdrrghuqeenucggtffrrghtthgvrhhnpeejtdejffelke
    ekueekueegteevjeeljeekkeffieeiudeiffeltedvkeelkeevgeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghtthesthhrrghvvghrsh
    gvrdgtohhmrdgruh
X-ME-Proxy: <xmx:36shY_Qibnk0yfGHdkLQH6cB8LHg5fBADG1jaUO_mPQf98wdXf3dFg>
    <xmx:36shYwuGH73gXmWgfqjy5JiZmbtT4oeXuRneoz-U2xuqFWqxJlwIwg>
    <xmx:36shYwe5QTEZMmnMvqUjD0i-QWud3nJA7wQwYXYnlh_vLVmK7vqyNQ>
    <xmx:4KshY4kqedC-PjAvgUIgtlgpmW6X8cYUGv3-FeH9GET4eHOBwYoPEg>
Feedback-ID: i426947f3:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C85B9234007E; Wed, 14 Sep 2022 06:24:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-934-g6274855a4c-fm-20220913.002-g6274855a
Mime-Version: 1.0
Message-Id: <7c1c705f-65b4-47d3-afae-68e70b85ab3b@www.fastmail.com>
In-Reply-To: <20220914101207.GA938301@roeck-us.net>
References: <20220914053030.8929-1-matt@traverse.com.au>
 <20220914101207.GA938301@roeck-us.net>
Date:   Wed, 14 Sep 2022 20:24:12 +1000
From:   "Mathew McBride" <matt@traverse.com.au>
To:     "Guenter Roeck" <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] hwmon: add Microchip EMC230X fan controller driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022, at 8:12 PM, Guenter Roeck wrote:
> On Wed, Sep 14, 2022 at 05:30:27AM +0000, Mathew McBride wrote:
> > The Microchip EMC230X (formerly made by SMSC) family of fan controllers
> > provide PWM control for up to 5 fans (in the EMC2305). The EMC230X is
> > capable of maintaining (closed-loop) a target RPM speed through PWM.
> > 
> > This driver has been tested with the EMC2301 (on our Traverse Ten64
> > appliance) and with the EMC2305 demo board (ADM00879).
> > 
> > The driver is by no means complete, for example, further work would
> > be required to support the different PWM output frequencies for
> > voltage-based fan speed control. (So far this driver has only been
> > tested with direct PWM capable fans, like the 4 pin fans found
> > in recent PCs)
> > 
> > The emc230x driver also has thermal subsystem integration which allows
> > the emc230x-controlled fan(s) to be used as cooling devices.
> 
> I just accepted a driver or emc2301/2/3/5. Please submit improvements
> on top of that driver if needed; we won't have competing drivers
> for the same chip in the kernel, and replacing a just accepted driver
> smply does not make any sense.

My apologies, I was unaware of the separate effort! 
Mine has been out of tree for a long time and I finally had time to work on it recently.

There are several changes I can see that need to be made to the accepted one to work for our usecase.

> Guenter
> 
