Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA426F117B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 07:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345296AbjD1Fuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 01:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345256AbjD1Fuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 01:50:37 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557182D65
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 22:50:35 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 6145A3200961;
        Fri, 28 Apr 2023 01:50:33 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 28 Apr 2023 01:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1682661032; x=1682747432; bh=4V
        Rpcnmw8YOwTpruFzNVpvXYH+RCLbyYv0y6SxCAJIs=; b=S4kxZxrmSartSNQLJ1
        1XnFPLbDHPoP+W2BCgPepNGJVWHk5K93kyBeTm3o6NQIgNx0Vummy/sDmdEzyRK+
        vedTmQso+ZmguYspySnVIMcH9b/jhUbFLMuIWNl6NBmcpK4Hh716Y33mDOsoh1aJ
        i7As5CfwzRNKFtAdXQp38Qgf9+Uv8W9emWTFgxoif+XyR9+Ye2eqji1ydWFMlZpC
        AtlLUbR6rknc3SJfSnZDiwg0HRJNvcpmETutfubYUpUd81viNNcv8DReRS5c33Vl
        XFb4YenMvc5c2PwzI/N1ATZUb6eQpWU7MA8DchAIga5GwlggAgDgSSQIqn312p3k
        4HYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682661032; x=1682747432; bh=4VRpcnmw8YOwT
        pruFzNVpvXYH+RCLbyYv0y6SxCAJIs=; b=CbH3P3EQl85u6rk3SRgiEBHvsztVH
        XyVza1qq/Ggr+Zkg/dAbZGaUMJdEmktn6FOReTDeoW8l91tZvaCrIErbgniU0CFP
        Ouolf+lJGTy9UymxEnkPpH9TivmLYVcYbqpmy2JsbA4nWcsA2UIttDIgdRa0zPli
        e4lX8A/XpYrcY8Jrt8d6GAIpej7poMrkQL/4buC8KWLs2mSjnmGzypGN/Ct4JUnl
        6JSNIxL4qlTDD346/kytvnHrgugJ2zTUhjlwlR2ZfBH+LhSExWAwMqulkXnyjvjN
        XfCmIURvgKOScyRLQ0VF3s+KG3DN4QZENsc5ooehm8V4gHe4cQKbcJxaA==
X-ME-Sender: <xms:qF5LZDdVvjXLYe-79xD7NZAxwpm5LwpFlB43SfI25HYQ5ZIGbve-Ew>
    <xme:qF5LZJPOQ2sFinBdvQ6BZqjSk622OvXIO-b097qP3SuFT-gTBVFU5_bJa-V9LN-Sm
    zwOeln9ci9bHCwavG8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedujedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:qF5LZMheW3hwYF7ROYUqhA05DsPvOjWXpr3s_2-JWTDebtVGzE9vtg>
    <xmx:qF5LZE93UmvIdbfOb8saCQhaADK3FvBMxUBKF5aCXoQBO-MfHeUd4Q>
    <xmx:qF5LZPuKZYRZBhXm9Y3aSgkFNBEDaENzlyisHYjVEZoEYkv4g-tGkg>
    <xmx:qF5LZI7cetq517PbIlgv5PRV6xCc54_YZrWphp9Z6EgokNU0kxIG3g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 67143B60086; Fri, 28 Apr 2023 01:50:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-374-g72c94f7a42-fm-20230417.001-g72c94f7a
Mime-Version: 1.0
Message-Id: <688fe177-5f00-4434-ba08-2348a8e5ee15@app.fastmail.com>
In-Reply-To: <MN2PR11MB4093C51F94BC3CDDC1F34968E5659@MN2PR11MB4093.namprd11.prod.outlook.com>
References: <20230423135124.55196-1-kilobyte@angband.pl>
 <MN2PR11MB409305D13E46C371321AC2F0E5649@MN2PR11MB4093.namprd11.prod.outlook.com>
 <20230425115210.GA4151911@angband.pl>
 <2023042502-resolute-divisible-fbff@gregkh>
 <20230425152720.GA4155584@angband.pl>
 <a8840c41-6245-4531-8b23-5c4e594c1ca9@app.fastmail.com>
 <MN2PR11MB4093C51F94BC3CDDC1F34968E5659@MN2PR11MB4093.namprd11.prod.outlook.com>
Date:   Fri, 28 Apr 2023 06:50:27 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Tomas Winkler" <tomas.winkler@intel.com>,
        "Adam Borowski" <kilobyte@angband.pl>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexander Usyskin" <alexander.usyskin@intel.com>
Subject: Re: [PATCH] mei: make hdcp and pxp depend on X86 && PCI
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023, at 19:11, Winkler, Tomas wrote:
>> 
>> On Tue, Apr 25, 2023, at 16:27, Adam Borowski wrote:
>> > The problem in mainline is inconsistency: out of 6 config items, 4
>> > repeat the "depends on X86 && PCI" line, the other 2 do not.  There's
>> > indeed no immediate functional issue, but I'd argue that a dormant bug is
>> still a bug.
>
> The MEI protocol (CONFIG_INTEL_MEI) is not PCI or X86 dependent. 
> INTEL_MEI_GSC is PCI dependent but not X86. (Hope I correct also on 
> implementation side)
> They HW layers are currently X86 dependent. 

Ok, so in that case the dependencies should be relaxed like below
I guess, in order to allow using the MEI on non-x86 i915 devices.

      Arnd

diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
index d21486d69df2..7c6e3b4588d0 100644
--- a/drivers/misc/mei/Kconfig
+++ b/drivers/misc/mei/Kconfig
@@ -2,7 +2,6 @@
 # Copyright (c) 2003-2019, Intel Corporation. All rights reserved.
 config INTEL_MEI
        tristate "Intel Management Engine Interface"
-       depends on X86 && PCI
        help
          The Intel Management Engine (Intel ME) provides Manageability,
          Security and Media services for system containing Intel chipsets.
@@ -39,7 +38,7 @@ config INTEL_MEI_ME
 config INTEL_MEI_TXE
        tristate "Intel Trusted Execution Environment with ME Interface"
        select INTEL_MEI
-       depends on X86 && PCI
+       depends on X86
        help
          MEI Support for Trusted Execution Environment device on Intel SoCs
 
@@ -50,7 +49,7 @@ config INTEL_MEI_GSC
        tristate "Intel MEI GSC embedded device"
        depends on INTEL_MEI
        depends on INTEL_MEI_ME
-       depends on X86 && PCI
+       depends on PCI
        depends on DRM_I915
        help
          Intel auxiliary driver for GSC devices embedded in Intel graphics devices.
