Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657116D9811
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbjDFNXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbjDFNXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:23:08 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B032A24E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 06:22:33 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 2A1C63200077;
        Thu,  6 Apr 2023 09:21:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 06 Apr 2023 09:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680787309; x=1680873709; bh=sq
        PML68DV/2AVgzbY0WB2FUqQA1gP/X2nV3S+ylVMPY=; b=kNplL4707kGSWICP9E
        jvSP3IGDCO8TACGOJA/OdHm2I3etUzbuEd6dgiN765LKaJC2jFdY1DzzPszQYwhV
        XiDvtLzntOXquYKt2AcMUaobvmJUOK8xYQhfGfpFkBWczo+fy+9b1O8k0JpvT25j
        ig5mW9OLFaQeqIJcK6S9Pl6UHwoe9XHgBqKYh3LXCZoTN+n6xkKUwYDhGogIa6c+
        ya74EMrA5iCr8BWVEY9mVrE7G7Gvs99MTlTRKkitRGQHZdEGQ6sm0gY2IQFseUxo
        gyiWpRxSq8KQIi5f/P52KNQGZjKjOBGx6TKtHOIQRTk0Xf+DfNFBHAAy/qLgKudT
        I2dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680787309; x=1680873709; bh=sqPML68DV/2AV
        gzbY0WB2FUqQA1gP/X2nV3S+ylVMPY=; b=mGNstugzxtjWOqRSoe8QsIOTQzgcB
        7Js95mFmM6cCF1+hJRt8bQk7GwoFZWogg+duDF6DwBEew7pLP8Cb/jHI9AEN6mmv
        1q7lNxgsEUmK6N2apaL/zICarmmmB6USeMtBauMAORCKsy1WEb/rGX3iOEiY67DS
        /3VOdyl7q/C76+xAA57dwbrYWLlROd65RojPYtjQTyQKXStF4GPHcQLmbIWTGK0t
        EehQzv/nIjZdYhIk5lAG/R6Wfi+iQJ32vJO8VN4NgTdex1ws68zARp2cS5ZL8beZ
        30l9mlIN8cvNxgMG7rzvo2IPffzMXSu+b4sMjOnqE1R1LV+q+BS4ra8VQ==
X-ME-Sender: <xms:bccuZCfSwd1IqDNiQ2bHme3uedSHq_YV3sCw3HpyJ2yuObhft9_1DQ>
    <xme:bccuZMOgP2QrQ_v7JqH86gT5tDbV0zZbGVHhG22TWcQ7DoOYPEDCdThNou-T0Pa9S
    DImc22uqvViYDKaS3U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejfedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:bccuZDj9qh78Izg1gWFzPpyJi5YfySNms1ODxAUNLltdSDDYni5reA>
    <xmx:bccuZP-M0fLT7mrnUpA-uVqfIZa6gbHdNaDK6c8Yj_B--nwoYOu6ig>
    <xmx:bccuZOvmPQFgQR2LWcihUOzt3-fI7DZq_0LMInoQqVzYXoq-V3vF7g>
    <xmx:bccuZMCjcxR11rliZ36_cfFhopG8RBr3ZGyUwEiG_jRsKz_T0wxcMA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7D0E6B60093; Thu,  6 Apr 2023 09:21:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <c2a6d31f-173b-4d08-b377-e31748f33443@app.fastmail.com>
In-Reply-To: <20230406131755.GA1608262@pevik>
References: <CA+G9fYtVXsKSbdxcTNiLc8oYRTBOZzWNQRF92daLE58NPbOkFg@mail.gmail.com>
 <96b67ae8-98dd-40fe-9dde-302e09d12551@app.fastmail.com>
 <20230406105646.GB1545779@pevik>
 <7234b8ab-db5c-4f4a-bb9e-ddef9f1a50d3@app.fastmail.com>
 <20230406124812.GA1589248@pevik>
 <3c2ba6f9-bea1-4510-8fbb-6521fab74a9d@app.fastmail.com>
 <20230406131755.GA1608262@pevik>
Date:   Thu, 06 Apr 2023 15:21:26 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Petr Vorel" <pvorel@suse.cz>
Cc:     "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "LTP List" <ltp@lists.linux.it>, llvm@lists.linux.dev,
        chrubis <chrubis@suse.cz>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Anders Roxell" <anders.roxell@linaro.org>,
        =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>,
        "Benjamin Copeland" <ben.copeland@linaro.org>,
        "Tudor Cretu" <tudor.cretu@arm.com>
Subject: Re: LTP: list of failures on 32bit and compat mode
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023, at 15:17, Petr Vorel wrote:
>> On Thu, Apr 6, 2023, at 14:48, Petr Vorel wrote:
>> >> On Thu, Apr 6, 2023, at 12:56, Petr Vorel wrote:

> Thanks! I've just searched in musl as well, because it didn't make sense to me
> it'd be a code for LTP.
>
> "to catch the fault on ltp" I wonder if it's not actually musl bug.

No, musl is fine here. The problem is that ltp passes an invalid pointer,
expecting to get -EFAULT from the kernel when that faults in
copy_to_user().

There is nothing wrong with musl sanitizing the data behind that
pointer, but then you get a signal instead of the EFAULT error.

     Arnd
