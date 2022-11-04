Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB3A61928B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 09:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiKDIOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 04:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiKDIOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:14:49 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C84D2655A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 01:14:49 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8592F5C00C3;
        Fri,  4 Nov 2022 04:14:48 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 04 Nov 2022 04:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667549688; x=1667636088; bh=CldNyn4VaM
        Jwpbw91Bc/YLggaVVkQGItaw4hX9Ok9s4=; b=MP1cmgfdN5swbbyeFBlvVKoP7x
        VujycihGEQzRhu/3QW40WwNsnoNDkqq9uC1UopuFSDhosuMiWVf5iB0TSw8okfG9
        /GjCoG9F9GAtEYgOdVTI2zCIGT8+5ANWp6CLypepM6AsFJEVTaqGUTxHdP2zYuoV
        T0K3R4Na2LzLG7e2iiozZtO3lNAdo30RtOeb/seoosJxDfYrGomkBQYLXN8PTdf1
        Er2sfikgYOjmr+sgHJaD1Jdx+e2OmaziPy7wezoz4hHDuRpqE2JUrtUM6JFjoIym
        YFvHGrH41VX+1zGrthKnpH6Hr4VtPkY+JfFlLk44I/SnaeXHJ2/JrsccLXQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667549688; x=1667636088; bh=CldNyn4VaMJwpbw91Bc/YLggaVVk
        QGItaw4hX9Ok9s4=; b=E9XgBCu4hGlWH4f6Yn7wgjP+jxPw7wOsnxUJ6RyCxlcz
        Ext+hty4kkHV/eqjeh52ERFQCj5sMARr8fqcNIjg3m1L9ZocwV+NmL29+w8yeGo1
        B67Q6A1FDBsDtFn6KVBI0pc0s4vLmdP1i5JHApIqolgDplV1f8JJ5CS1w707LMu3
        ar/8R1Wx6WajMdXuAn7dO/iUtdR+BEa7W8oh3F3Q/3QiRloR9BU1oZwAV2Mn1UTZ
        bJ9LT/dPjtFpMApqPmlMhoxmxVfNdzsF9wW81l2QJth2l+ffZbh3lN3C5riFlW+9
        k6PGgRHTVpcAvtWiz1hbd7qIV0tSGXL5UT35aXaDiA==
X-ME-Sender: <xms:98lkY73Gyj-pBK8n07eCzbPvvh47d1-prqxneOr1sqTK392dGqS-8A>
    <xme:98lkY6GIFrw0YYmoqJCqCV09K_oKWXsQnMYpPIeDzCFP2Z9PrO9-cZXzEgB23rWfH
    wvVEM0EMDgVhYnNvwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvddtgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:98lkY74qJd7Gh366iJlLOB2szXardAdGfDLoaDz56teNYq6pMGoIVA>
    <xmx:98lkYw1TRWoyZLM2oQKMwDKMtb6X53zS0jRynckCW0af8frOOKNhvg>
    <xmx:98lkY-HOYZo8Ef56TrBfUNWBCC8LrN2O7gwiz7EUNbNHd5gyL2R-jg>
    <xmx:-MlkY6CC72B0Bktx_cor_eu8tJVnzoPZuTJlZX4qAw_xuHNTdz6uSA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D669DB603ED; Fri,  4 Nov 2022 04:14:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <26ce1ec2-effc-435f-8349-a12667973d92@app.fastmail.com>
In-Reply-To: <202211041544.R0jV58vk-lkp@intel.com>
References: <202211041544.R0jV58vk-lkp@intel.com>
Date:   Fri, 04 Nov 2022 09:14:29 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "kernel test robot" <lkp@intel.com>,
        "Sven Peter" <sven@svenpeter.dev>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, "Hector Martin" <marcan@marcan.st>
Subject: Re: drivers/soc/apple/sart.c:190:38: warning: cast from 'void (*)(struct
 device *)' to 'void (*)(void *)' converts to incompatible function type
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

On Fri, Nov 4, 2022, at 09:01, kernel test robot wrote:
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>

Thanks for the report!

>>> drivers/soc/apple/sart.c:190:38: warning: cast from 'void (*)(struct device *)' to 'void (*)(void *)' converts to incompatible function type [-Wcast-function-type-strict]
>
>            ret = devm_add_action_or_reset(dev, (void (*)(void *))put_device,
>                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sven, can you send a patch to add the missing helper function that calls
put_device?

      Arnd
