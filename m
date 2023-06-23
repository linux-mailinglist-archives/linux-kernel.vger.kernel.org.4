Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF90C73BC56
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjFWQG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjFWQGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:06:25 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACBF2129;
        Fri, 23 Jun 2023 09:06:20 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 099CC5C0246;
        Fri, 23 Jun 2023 12:06:18 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 23 Jun 2023 12:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687536378; x=1687622778; bh=4E
        KvCMTqubzjQT5Lt56FQ//yI5tr7An39f5NmpO/xXk=; b=YSrWn5+/N+WTfAtyd/
        53cZoPdeFShSUIgITzeIjgYNHNXOqrZjWZDSK7vZPvn86V4Yw05EUJYhdHrLnzWc
        cNocaQC6zCAt2MsVuONBJZovGeY0Aspl7Hdm0vvx9v4Otg4RHTtBrrDJZBQb0Utn
        BXO5IC6iKJoMjc3Im7jUcY4YlAae2ePRcJONR+WQOWWQrAQ1avl9QpYJSxvOzlik
        YAhYcMd/8UiBSrfrQCqERZHGAHk/VHTbuJi7HQ1rNDNSOZvgddd5xkcsKTb/ZEio
        xhEFxKBeanAmAAXT6Y85apdJHjOd/HT3B7TU8hcMRbKEOoD21U5J1yp60RE012kt
        IaAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687536378; x=1687622778; bh=4EKvCMTqubzjQ
        T5Lt56FQ//yI5tr7An39f5NmpO/xXk=; b=dGxe5t3VFO/MwRXBe/nYlcBOko2IU
        Nzbt492ATA5r0dnDfrYbs+2C9wBgPy65y6fLFHtYyA5LSLNfCLIB4tlRfFU3mSuT
        VA05wg12hE846yXK1nJv9NfQ1qPdNDaEzDVyLSHvBfpOX/b2ICivEftlcpvlIH0I
        +6sbcj3aKd5HRiipoJuqyIbRasb+grF7VS9BAV2IQ1ndZqCaCDAEydrn8keWCFb6
        z69JZDarzdc2XntSaEbZaTM4TzbfqRw5vbsO0+kyFoUHlFwsv2rt6RHbkRlVlgt+
        LiYb227tIxxQGOdCoAAAQNYVpi6LUI3hkiUK/dRJnbsVb9VAY+t6SQe4w==
X-ME-Sender: <xms:-cKVZOjx5FGmstXBW-vnkYoV1rNcOOrV4Mru8xWtxRrGKBFPfoybUQ>
    <xme:-cKVZPCLpwnzt8fycurOgWRJh7-7XnWXmVClPMLozkR8D3TwjRYrseuhBMDBH3S2E
    CReGDRpKVFVNanLUMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeggedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:-cKVZGGNsLxjbG3FmsUJd2VIzFNtaxtbCsvo2KhmWbqvuUkdMRUcoA>
    <xmx:-cKVZHTEgK5CGUWpiyfbkeH61sCfTbKlSBZ11mcRMpF20YCtHWS8xQ>
    <xmx:-cKVZLyhh-zpUqNiTXeXhyQMbDLFV5KgAQvr47mi0Rub-6vBYe3DOg>
    <xmx:-sKVZCmQkfHSA_1Hky8JfUF-OqiUDXWBLOAwQ5Nm5qsHdg1SvLtW8g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 76137B60086; Fri, 23 Jun 2023 12:06:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <24986b5e-5cd1-4cd5-aff3-b5eab2c0fdde@app.fastmail.com>
In-Reply-To: <7c4622e7-d7a8-ae5d-e381-f726cb511228@gmail.com>
References: <20230623152443.2296825-1-arnd@kernel.org>
 <7c4622e7-d7a8-ae5d-e381-f726cb511228@gmail.com>
Date:   Fri, 23 Jun 2023 18:05:57 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Christian Lamparter" <chunkeey@gmail.com>,
        "Arnd Bergmann" <arnd@kernel.org>, "Kalle Valo" <kvalo@kernel.org>,
        "Kees Cook" <keescook@chromium.org>,
        "Johannes Berg" <johannes.berg@intel.com>,
        "Shiji Yang" <yangshiji66@outlook.com>,
        "Nick Kossifidis" <mickflemm@gmail.com>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        "Christian Marangi" <ansuelsmth@gmail.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] carl9170: re-fix fortified-memset warning
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

On Fri, Jun 23, 2023, at 17:38, Christian Lamparter wrote:
> On 6/23/23 17:23, Arnd Bergmann wrote:
>
> Wait! I want to point out this funny thing is happening in ath too!
>
> https://lore.kernel.org/linux-wireless/TYAP286MB03154F9AAFD4C35BEEDE4A99BC4CA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/T/#mf1b8919a000fe661803c17073f48b3c410888541
>
> And that patch got NACK by Jiri Slaby because like me he suspects that
> this is a compiler bug.

FWIW, that is one I don't see with clang-17 or gcc-13. The one I'm addressing
here is the only thing I see in ath wireless with the default set of
warning options, though this driver does have a couple of others that
are unrelated, when you enable the source data check in memcpy() by
building with W=1.

 In file included from  drivers/net/wireless/ath/ath9k/xmit.c:17:
In file included from  include/linux/dma-mapping.h:7:
In file included from include/linux/string.h:254:
/home/arnd/arm-soc/include/linux/fortify-string.h:592:4: error: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
                        __read_overflow2_field(q_size_field, size);
                        ^
include/linux/fortify-string.h:592:4: error: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
2 errors generated.
/home/arnd/arm-soc/include/linux/fortify-string.h:592:4: error: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
                        __read_overflow2_field(q_size_field, size);

> so, what's going wrong with fortified there?

Kees might have a better answer to that, my best guess is that
the one I'm addressing stems from the confusion between different
union members.

Doing the randconfig builds with the latest compilers, carl9170 is the
only one I see with fortified-string warnings, and there are a few
dozen other drivers that I see with W=1, including one that affects
all wireless drivers.

     Arnd
