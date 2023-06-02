Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B1A71FD48
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjFBJM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbjFBJMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:12:30 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B26FE52;
        Fri,  2 Jun 2023 02:11:24 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 258945C007F;
        Fri,  2 Jun 2023 05:11:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 02 Jun 2023 05:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1685697082; x=1685783482; bh=AP
        AvZ+7IxRhfLRjzPSOa/K0myZhAJEYLPd6OAOyyhBE=; b=snQVbPZ5si+eWAoLyH
        1Ta1hjw0H9HLebxhopTdG1vEEJdJ6oqUuCEyuEH5q7/MC0eHZPZ2ujKMKoPFjfdd
        /9pDzi2yBt7LvkjcGJPxw38duY+ZNmfydn4cnNfgNfuiGyrj4xo83TwO3Wue1YBe
        nl7ebcZ/stOKNIyYQOruFzAtdEwGAuSqMLOWziI2kE2SpUUJhGuH1O12M3+83/Kh
        mq3+5kvoWeSxsWQ1xwa7IFapPiDKnPaQ2Z2BQAlT29YdGaw56ljfUOHlMsKqKosS
        dyemSxWg+8BWQfin31u7vLkMlmdvguSjRUt6p0jLA3wyAYJzS4Ajt6OZVe4S4rkj
        cQ1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685697082; x=1685783482; bh=APAvZ+7IxRhfL
        RjzPSOa/K0myZhAJEYLPd6OAOyyhBE=; b=uOn5XeP6ZPV6FOIZBzvvUsqRTFqIu
        yYDgLHoQpGKVYy64B8t5IG6K5WLmzR0WfTjRdM6FhVcnm158F32X/m5W7O24Qxjb
        2+oP+gobwGRWLOgTQs2/1QKrSC4DVrCMaKKDBSDcRNVcrS4f8foVqyIkwr+j7a9Y
        LLuJQiaeb+ov/uNoL/rQ1qFLxf3nd/0oydtRAOTJADRuPb9tmXbE8suLs1BZ7UU7
        +W9wQhR5FlFsqsW1F1MKe0G87yQIePEqzbID+noG7xDozWpkCwXK+tgK1fb6up4B
        lgHYUpYXGHKFtEGKeap1iE/afgQCUVKpUqhne7av2XiDyyv5MBAeLkLSA==
X-ME-Sender: <xms:ObJ5ZMQEog263-qA1fp65RtwtSqpQgEwUjeJ6OkcZVVvExnmSeXW4g>
    <xme:ObJ5ZJw76gLUgl8EnMNgebe441QSixgT4p9e-gXpD2RotHndxxGu0zBa9ilH0pxzm
    YgX1Wb1V990ssjd6lQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelfedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ObJ5ZJ3heeJkJwZecF6tYDIfvvW6ODHZWjAqRfFN6KsIyW_f5jEN9w>
    <xmx:ObJ5ZACKN1btlqbPbGCXvrHY6BunWtzI5y7FWLVXhnfIrbiWlvY2yQ>
    <xmx:ObJ5ZFiG5Q92PcPsWmQZLqiNy_P7NJn-OKyOOSn7MHkpBTOQRbJaqw>
    <xmx:OrJ5ZDbbWMoRSGhAB5y7mcDNkd6YNjptZ_mQAS7_UTJ7G2gmZc2eRg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D2DEFB60086; Fri,  2 Jun 2023 05:11:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <0d627109-483d-42c2-86c7-337c2d38fadb@app.fastmail.com>
In-Reply-To: <ee67348af01d729a959563f5cb2ecab7534f2e53.camel@intel.com>
References: <20230601213246.3271412-1-arnd@kernel.org>
 <ee67348af01d729a959563f5cb2ecab7534f2e53.camel@intel.com>
Date:   Fri, 02 Jun 2023 11:11:01 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Zhang Rui" <rui.zhang@intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     "Sudeep Holla" <sudeep.holla@arm.com>,
        "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Cristian Marussi" <cristian.marussi@arm.com>
Subject: Re: [PATCH] powercap: intel_rapl: fix CONFIG_IOSF_MBI dependency
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023, at 10:04, Zhang, Rui wrote:
> On Thu, 2023-06-01 at 23:32 +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> When the intel_rapl driver is built-in, but iosf_mbi is a loadable
>> module,
>> the kernel fails to link:
>> 
>> x86_64-linux-ld: vmlinux.o: in function `set_floor_freq_atom':
>> intel_rapl_common.c:(.text+0x2dac9b8): undefined reference to
>> `iosf_mbi_write'
>> x86_64-linux-ld: intel_rapl_common.c:(.text+0x2daca66): undefined
>> reference to `iosf_mbi_read'
>> 
>
> IMO, it is the intel_rapl_common.c that calls IOSF APIs without
> specifying the dependency. Thus it should be fixed by something like
> below,
>
> --- a/drivers/powercap/Kconfig
> +++ b/drivers/powercap/Kconfig
> @@ -18,10 +18,11 @@ if POWERCAP
>  # Client driver configurations go here.
>  config INTEL_RAPL_CORE
>  	tristate
> +	select IOSF_MBI
> 
>  config INTEL_RAPL
>  	tristate "Intel RAPL Support via MSR Interface"
> -	depends on X86 && IOSF_MBI
> +	depends on X86
>  	select INTEL_RAPL_CORE
>  	help
>  	  This enables support for the Intel Running Average Power Limit 

I think that has the logic slightly backwards from a usability point
of view: The way I read the arch/x86/Kconfig description, IOSF_MBI
is a feature of specific Intel hardware implementations, which
gets enabled when any of these SoC platforms are enabled in
the build, and the INTEL_RAPL driver specifically only works
on those, while the new INTEL_RAPL_TPMI driver works on other
hardware.

More generally speaking, I think it is a mistake for a device
driver in one subsystem to use 'select' to enforce a build
dependency on a driver in another subsystem when the other
symbol is user-visible.

>> The driver can work with iosf_mbi completely disabled, so add a
>> dependency
>> that still allows this configuration, but otherwise forces it to not
>> be
>> built-in when iosf_mbi is a loadable module.
>
> On the other side, I agree with you that the TPMI driver should work
> with iosf_mbi completely disabled.
>
> A cleaner way to do this is to move the rapl_defaults setting (even the
> rapl_primitive_info setting) from intel_rapl_common.c to the I/F
> drivers, as this is really interface specific.
>
> Maybe we can use the above patch as a quick fix, and remove the
> IOSF_MBI dependency from RAPL common code as a long term solution?

I agree that your long-term solution is the best way to avoid the
build dependency, but for the short-term fix I think my patch
makes a little more sense than yours. 

Either approach is of course enough to address the build
regression, so no objections to your patch if you still
prefer that.

     Arnd
