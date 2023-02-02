Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A585C68891B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjBBVko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjBBVkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:40:42 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880BB6DFFD;
        Thu,  2 Feb 2023 13:40:40 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 888C332007F1;
        Thu,  2 Feb 2023 16:40:37 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 02 Feb 2023 16:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675374037; x=1675460437; bh=DDfcc2rjMs
        Ww3IOfSJ0qffIQzoNY80OiBacRdlNiNBA=; b=CA3qgblvftrjd7Hb+PjMXQSRzj
        qcYfPwrpe1Yf7VdgtCRxiEx45dvjoFxhgvmMYIN5VmqrwAFKIQ0UIo+tzRSyDXbH
        Z/2WqFK/EOPzHIEuGdQTFR9fpyw1QYq81aWHtwY7Xy4yXccMxrgTv0EHz8sgnSbv
        0Xavifu2v/rFQ6yhqAjU/Ovl8UGVwWXL2I4V8ngUDC+XP3rs5QHe+oUFScUAmevd
        zE75nMU2Zaj+v2S+J5gscvNNsCrJ46/tfqpagMWsP5dygpU9+eE7/QWsACuTkpvD
        kX0d36ZNQtMPGFiyp64px13qWoLTiVkAhvu4mwpj9vXfrczKqKwz31CGVJZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675374037; x=1675460437; bh=DDfcc2rjMsWw3IOfSJ0qffIQzoNY
        80OiBacRdlNiNBA=; b=RaLgUlsUYok9usfx+FS2csyDJUWssZAOwtvyKmdZ8ojv
        VfJbR/4QGcusVEDtmA1E0aSWqMRCgsPfl1GeiIDiPt6pha09/XCAzxXrdxoU5VOD
        6dtDQ+tGLto2j+wvCB8ZrnnbsOKsiY7yZxBS06QorH1iIWXJZWPs6sX+t1siIIaq
        f1470xC3zq4joiC7i8lr+5jfPCaRzbB/mOqr2nnROObFJGlIgiDUFpMfl5paHPA+
        CSEEaq3Snax4vlBeN7q0M9j5OHwopmUBfD/Ut9huCV7FuDSUdkIon1Sh2ew7gXLY
        EDf4iRiipRjhdr1hYhn1z0/M/JfN052H3DuoJLH+dQ==
X-ME-Sender: <xms:1C3cY0qx2CHlrVbDilb06LTgB9k2aZnrslDODgFj0SNoE8Lz24jsGA>
    <xme:1C3cY6oUuvwcV1RGH7dl7r4n--ghdYh_pPcPcGp5Z3g5mTblLBDzp6jPjgq8sYHwV
    QcVmYU4FchtBKYRgQs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefkedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:1C3cY5Pg4znUAZoo5GcHVZXtu89zXiNMFMwZrp81MraR_RS2FTqcyw>
    <xmx:1C3cY74cMihizykFkvFl-HAjqs6ZoKQxEpdS5mZp8s35xG1nrCBOUw>
    <xmx:1C3cYz61lKJBb785tbiR6CEoVlWRZZLTfUnYgInLNqtQLtm9Z_1tCg>
    <xmx:1S3cY5RRGTxTrayOZJDYkAf4Q-jdQxN4GOyp3jYh_Sa8dJ6-GM2rsA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4B30AB60450; Thu,  2 Feb 2023 16:40:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-107-g82c3c54364-fm-20230131.002-g82c3c543
Mime-Version: 1.0
Message-Id: <a648eee8-62a3-4a92-b2bd-1e0d8d2fa6a3@app.fastmail.com>
In-Reply-To: <2b11d9f4-f32b-7214-3181-a49a8d190f0a@redhat.com>
References: <20230202210312.544277-1-arnd@kernel.org>
 <2b11d9f4-f32b-7214-3181-a49a8d190f0a@redhat.com>
Date:   Thu, 02 Feb 2023 22:40:17 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Hans de Goede" <hdegoede@redhat.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
Cc:     "Sakari Ailus" <sakari.ailus@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: atomisp: add I2C dependency
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023, at 22:34, Hans de Goede wrote:
> On 2/2/23 22:02, Arnd Bergmann wrote:
>
> Actually the i2c_get_adapter() call is gone in the atomisp pull-req
> which I send to Mauro for 6.3, it is removed by this patch.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git/commit/?h=media-atomisp-6.3-1&id=4f205ce7a915ffa4ae0fb24f48714604d39baa29
>
> So adding the I2C dependency is no longer necessary.

Ok, nice timing then, I must have done thousands of randconfig builds
with atomisp enabled without ever hitting it until today ;-)

     Arnd
