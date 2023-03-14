Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C255C6B8FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjCNKV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjCNKVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:21:30 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D1E65137
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:20:57 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id EAA9C5C007D;
        Tue, 14 Mar 2023 06:20:51 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 14 Mar 2023 06:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678789251; x=1678875651; bh=OC
        0QtT0CmMdzOgvvgDISmSIwG3dqCBGJQVy7c3zl5sU=; b=VyD/CGq7lvQFmNZ/jF
        gGRdoDyzEzORFiesMXHx6XKLoiSnpB6CKwOxsraWRqdhuJ4Dl1Qh/AQZVF+wb+lP
        BXu1+EC6xuiVddiiWA+7YSWbaWnJq14aaO4OeOIwaBPfVrurQYOwFNJ7yd/7UTOr
        sd6qldD/59YTpgGoceAlRO95JzPHTT4NL5JHVq1Fn9HwiAP9oO76AGrnn/ODhKLJ
        5fdoSM1N7pUPDZQe1IwEUatFZDhPLOtyGbG/FJwjjtZGBF1KNTHZL1GFx9pbLGLs
        +Uqq9zbb8TelpY/AYGzreK8wGYFV2pz6VqIUya7k/5B47KW+pcn1oxH5sZJ401JA
        Wqvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678789251; x=1678875651; bh=OC0QtT0CmMdzO
        gvvgDISmSIwG3dqCBGJQVy7c3zl5sU=; b=P8UyaMGybA3Drfncc+tWhXxFWsoCF
        blE+PbVLD9WVBElI0SsPDTT+LEEFO1Y6cIwbMP2ZL9+wiPWyK+QkznBQUFfBXJRX
        j5iR4S9Kgwd7f647rDVKWF2CGIfAh6LeAPOb+2NfwyZGkXgeK/Obs2/mgg46h/Uc
        fXjJZq5McUo3VaY2If47DnLXW74XWPPTgGree8E7kU8WjrP0Iiibujq7Z3JbaSR+
        3IET05NfriHcs0qKFBFDmFBtwMMgUpH9U1GB3G42crAFmjW+2zm1OJXErASYlEAl
        YdaozWIhiuRvmxKIw774zNCD0rH0MIPOGB+3KJv8Y7XxccoYJa/bkwYiQ==
X-ME-Sender: <xms:g0oQZIIsGHNzRVbrbjy-PNrQ1vEs1UMo1haZFeMq988uvP_OQpyEmw>
    <xme:g0oQZILbFcX1xNaDmeATx-DDPCmtHIThh8c7rtkC4IGpmXH1CPGfHppCN_vn5hQLu
    Z4UTK96UF6GU-_mWaM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddviedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:g0oQZIuavZxIIwP9tfVoCs1bYgvqDhNr7IDw6V1QFj9Kb4RmBC17vQ>
    <xmx:g0oQZFYbm1yBdt8u_W--GYMEiKi4_OUtfg2KYRzQ5l2qZjxr97-Nwg>
    <xmx:g0oQZParJcypRp0MjEfmHiTDk_O-5PNukrHNTtkzOrUp93dps_vOsw>
    <xmx:g0oQZLEvXeawWMgWHv93DRxS5LgcMkZfejOQZZPiHE3Q2o_5Jgl70g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9A211B60086; Tue, 14 Mar 2023 06:20:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <390eefe7-c7c4-47b4-88f2-dcaa8bfaf8a8@app.fastmail.com>
In-Reply-To: <08e7bd6ed16f4bde95b674db940783ec@monolithicpower.com>
References: <08e7bd6ed16f4bde95b674db940783ec@monolithicpower.com>
Date:   Tue, 14 Mar 2023 11:20:31 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Noah (Wensheng) Wang" <Noah.Wang@monolithicpower.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luke (Lijie) Jiang" <Luke.Jiang@monolithicpower.com>,
        "pebble liang" <pebble.liang@monolithicpower.com>,
        "Eva (Ting) Ma" <Eva.Ma@monolithicpower.com>
Subject: Re: [PATCH] char: add driver for mps VR controller mp2891
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023, at 10:18, Noah (Wensheng) Wang wrote:
> Hi Arnd, Grey:
> Thanks for the review.
>
> This driver will be used by facebook. This driver provide a device node 
> for userspace to get output voltage, input voltage, input current, 
> input power, output power and temperature of mp2891 controller through 
> I2C. This driver determine what kind of value the userspace wants 
> through the mp2891_write interface and return the corresponding value 
> when the interface mp2891_read is called.
>
> Signed-off-by: Noah Wang <Noah.Wang@monolithicpower.com>

Hi Noah,

From your description, this sounds like it should be either part of the
drivers/hwmon/ framework, or drivers/iio/, but not a custom character
device.

Have you looked at those?

      Arnd
