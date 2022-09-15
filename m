Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D635B9652
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiIOIZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiIOIXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:23:33 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0906A9836D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:22:54 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 465702B05F8B;
        Thu, 15 Sep 2022 04:22:53 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 15 Sep 2022 04:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663230172; x=1663233772; bh=9mKn6blmYA
        NFuaZ0dtOqisfOd8Rd6vzhg19KJ8Gas0w=; b=dkrfo0E65c8JJoicwHhtCyqEqn
        YT0dufOKnphOC2mruIY0Kz6gecCS6aPSgDCZgJ2lsTrk26ZDmaNEmuWWn5kq0ng7
        gB7/cv52eEujaA4q5hFiFrS1MQ9XA3vZzgZVfXVNLebKz+s77esbMuU5R2nQry3S
        gTniSwul5hXnk0az9QzN10tzkrB/D5LN3xHcNj+AbAkxF9XcvWO+EILkMkH7wh0o
        Gv33ba7NZRONh6Lp2kaVfDWq8NXpp3YciblIkbJSalMubRjLVhNiWLbcu2Vke1sN
        lKLOVJMH/vsOfV7y4aCdyTsHrz1QNc/gQECipkXGyCf4yGDpQLEuc1ixTbbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663230172; x=1663233772; bh=9mKn6blmYANFuaZ0dtOqisfOd8Rd
        6vzhg19KJ8Gas0w=; b=b5KYyzw/+DD85iAltMyHonE25aj06cE00CMmDAPxOurs
        a/95BYFawT3nExW/s8f1MtE+KAGK1PQ5jjnL+ghzpb2AtcnJKDJMZJ8cR7XfA350
        ixLfi7T2+GOYxTWjKklX5sQNkwrdKf09tGWs2iAKxwhE423vXMdFVALEBL0P8yYO
        AzAkNIRr9ilbcRPM0enDKQjzxDEEA/AeKxW31Gj7sAPjCWwvnPdp0cAmtSAtZtzt
        QUfXP/kkYWdAan1j29e3tUDKg/1k8ph65DynFNbTo+l/Hc5nfaBYbsf9tzUH1dxF
        LYVmqwYLjfl7uAhCg68obx1joWFOXjKtJKtb/NOnXg==
X-ME-Sender: <xms:3OAiYySPNMKSYXvCYn0TCnaSKrHPnT4ktLl9nvUVInfBGVpaX_yRuA>
    <xme:3OAiY3xmIV6quYyP88EM_eZ-wltM6yJSLRtzvn3RifHB9k8vfjU8qM-xlgx9DlnGU
    jCiK9drjD098L39M0Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedukedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepjedvvddvudeludehjeeitdehheeivdejgfelleffiefgvefhhfeuudfhgeef
    feehnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:3OAiY_1i_A8Rd3fptBIsk42F3KxhhdZbYB9eY7OMq3dreoyZrStVDw>
    <xmx:3OAiY-DfhHt1oyooXdM_vkHByJ-LrFP6u4jvjR_YC3OT1ckhMsE5QA>
    <xmx:3OAiY7hWetdX_yG-F1ikv5nVUuuitiBOYnX1sJwIXh879KvAC9ippw>
    <xmx:3OAiY2UFNMDExF4xlJNDTWFKPMVGPds_vT6O_1SGqGpootahV39reYvp-78>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6F2D9B60089; Thu, 15 Sep 2022 04:22:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <b66ea89d-c62e-4772-b3d7-6e236da837af@www.fastmail.com>
In-Reply-To: <20220914211057.423617-1-nhuck@google.com>
References: <YyEQr//Iq7bautrm@dev-arch.thelio-3990X>
 <20220914211057.423617-1-nhuck@google.com>
Date:   Thu, 15 Sep 2022 10:21:47 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nathan Huckleberry" <nhuck@google.com>, nathan@kernel.org
Cc:     error27@gmail.com,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        llvm@lists.linux.dev, "Nick Desaulniers" <ndesaulniers@google.com>,
        trix@redhat.com
Subject: Re: [PATCH v3] staging: octeon: Fix return type of cvm_oct_xmit and
 cvm_oct_xmit_pow
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

On Wed, Sep 14, 2022, at 11:10 PM, Nathan Huckleberry wrote:
> The ndo_start_xmit field in net_device_ops is expected to be of type
> netdev_tx_t (*ndo_start_xmit)(struct sk_buff *skb, struct net_device *dev).
>
> The mismatched return type breaks forward edge kCFI since the underlying
> function definition does not match the function hook definition.
>
> The return type of cvm_oct_xmit and cvm_oct_xmit_pow should be changed
> from int to netdev_tx_t.
>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1703
> Cc: llvm@lists.linux.dev
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> ---
>
> Changes v1 -> v2:
> - Update function signatures in ethernet-tx.h.
>
> Changes v2 -> v3:
> - Move changes below the scissors --- so they don't show in commit msg
> - Add reviewed-by tag

The patch looks correct to me so

Acked-by: Arnd Bergmann <arnd@arndb.de>

but I have two more general comments:

- For your changelogs, it would help to include the diagnostic message
  from smatch that you link to.

- This has probably been discussed before, but why is this only
  reported by smatch but by clang itself when building with CFI
  enabled? It appears that CFI enforces stricter C++ style type
  compatibility on enums while the warnings only catch incompatible
  types according to the normal C11 rules.

     Arnd
