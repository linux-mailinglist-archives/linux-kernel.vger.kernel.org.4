Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9AB74A4D2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 22:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjGFUW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 16:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjGFUW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 16:22:56 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66AD173F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 13:22:54 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id F1C2E32004E7;
        Thu,  6 Jul 2023 16:22:49 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 06 Jul 2023 16:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688674969; x=1688761369; bh=gW
        OQqakoZqzCWe3j5esuZLBOmbkLOkQAymhYFAOynco=; b=ZhE4tZph3V/LB4k634
        OM6QlpOqYnRKa59ql3C/YFIHJWZyIQJOZUrepOaW810Ykuj3CtxA66VXZtahQPLN
        HnmxRfIGBMIB6YR4U9UQMkMzM2xA7kaY7RPtr/TfwvVRe8d2NroLouqAFrtum5by
        e0pgDY4loK3GfgmCXpLtqQV6BhkQU+W1KChBdCd+ovXMlGQPR93db4pHXknhxGgj
        iYJhjZQX31gBd2zqHD5ckp6o1Ev//IzvvLBEKcRTKXYgxCu0IN4eVdWFRJ9VW3s2
        r0MUinnT6v3shU6Hk1vNjBi6GkjuEkmdbhmpwoT2LMsmfRTFR5SyPl7BhdbPKVYk
        F91A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688674969; x=1688761369; bh=gWOQqakoZqzCW
        e3j5esuZLBOmbkLOkQAymhYFAOynco=; b=OTund/UUD/UF67LU9cGIrcDy1DPOM
        Bf2U4la6lULU78z+h7JawJVWerFRi/qh3Gfuir7KS3YyOrjEY9T95bgDb5nV/GXC
        QSUJDGb7SEgI+gcKBbIYSWTKwL0UAMOMywbF2Bbwrw48YCX3y89Z2IIvTJlj2HBY
        U0uMSZu++SANSirr2gAqrYE0k7+8QZU2KTWlQInaO7oOnug2BZY+fxkyh8z8Gi9j
        sh/s08g9h3CAxsHnwwsqbN2IL/JgDlcmZTHuo5+wP+SXQSCzeMHk5PzCX33ILDns
        vjYoapCBOcv4yb7/FlhsbGPvVDL3LhfI9+42iLIac/8yUn57TaCa4DQAQ==
X-ME-Sender: <xms:lyKnZL_BxDx_Wqisz84f_EwxRR2zVjGASZgiuYIOYAL5SY4gtQr-fQ>
    <xme:lyKnZHs04iuJTCvL5YAVKhxOB3abrQCAUuD7IGyBs5fMsqPyFy06lAzipxKPqqeYM
    xV-mAkEjRuL6dWANco>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgddugeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:mCKnZJAyO-2oW5uCWQYSarXkxd6Jk0VClp4MNHJ0FAzIk19m9Sj1EA>
    <xmx:mCKnZHdTRfOImVYufBSsMwG-xCe2C0W9bDHVIEmqdoaNJEzUwOXWaA>
    <xmx:mCKnZAM4eT1DOczXneERYy-akPfWYXSBj2B-8_-xnPo5x6INLaMBrA>
    <xmx:mSKnZHfT_cKZF5yKs6nip8o6x_YfhiR7WEJEVhuoT5Xn2qhlsg7MZA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DCA47B60086; Thu,  6 Jul 2023 16:22:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <2d9bb146-e1ec-4fc2-a4bc-e1c67cfda723@app.fastmail.com>
In-Reply-To: <20230706190217.371721-1-thuth@redhat.com>
References: <20230706190217.371721-1-thuth@redhat.com>
Date:   Thu, 06 Jul 2023 22:22:07 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Thomas Huth" <thuth@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Remove the arch_calc_vm_prot_bits() macro from the uapi
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023, at 21:02, Thomas Huth wrote:
> The arch_calc_vm_prot_bits() macro uses VM_PKEY_BIT0 etc. which are
> not part of the uapi, so the macro is completely useless for userspace.
> It is also hidden behind the CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
> config switch which we shouldn't expose to userspace. Thus let's move
> this macro into a new internal header instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Fixes: 8f62c883222c9 ("x86/mm/pkeys: Add arch-specific VMA protection bits")
Reviewed-by: Arnd Bergmann <arnd@arndb.de>

It looks like this was introduced right after the uapi split,
and probably is the result of an incorrect rebase.

     Arnd
