Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42D7720507
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbjFBO6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbjFBO6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:58:46 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C398123;
        Fri,  2 Jun 2023 07:58:45 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 070103200988;
        Fri,  2 Jun 2023 10:58:42 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Fri, 02 Jun 2023 10:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1685717922; x=1685804322; bh=7Y8TYqKsacvY7VA7C8WB1Ns1VO8mVvWK0oP
        LQKlkwpY=; b=U2O4apWWA78FWG18DmouAFIXOcjKL1zzAONdy5E19Ecz5AJWQVo
        ZfEmysg8/mpFe9/XZKuYQDl4J0+qe+ecyipDLcJr49zaQYOGvh8LC3/843mutNqs
        babtnAWMtzbh6VjCsCkyp5KhteW5Y3kpgWQ2tOmycki/hMW+Taw3T8VoZNQDDaWJ
        PFqDUtjLiw48ap0zFONMpe1Lb2wdCwTcNfd6Mx7pP0UNWeI7TRwL9bdLGxOlqpGP
        JcxIdQ6KB1fQQrF/smcIWWkO6PLVQvSe0DWXfGRRW01qR///LKXdCRNW3x19lFHp
        cPgTdTxy4i38sUrVX7QQeW983s8JfsSemgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685717922; x=1685804322; bh=7Y8TYqKsacvY7VA7C8WB1Ns1VO8mVvWK0oP
        LQKlkwpY=; b=IkfmjnJN7+ffhqNEzf82XaUnTtXhgiYgbGn27+u1No8BrLxXfKL
        YcoNLAZv9BNAiMhCK+Amsb7x+RZhjJoJWXq+IuVPC7V8Ix/KvTSzi5CBASieRlUw
        YjViTSA1qyCk5AZQCRf8DXq237LBVcNt92UahVZP8amOgw8bZfmqwnehF7OiK7aJ
        1tvFRBHx75NJBQyBwncCCm0BzPYI/OO0VblnLjzMv6kKrTMKEH3suz26g5qOKMcK
        BYmA+yBce0W/ZAx6D9Fp6kFVcA9nn5JuXzL4X/xIMMgVV4CPDKAbvs2EcEfwvx7R
        NqUz+i+psGMTS8CvJUjAfv5laQZdtzVqEXg==
X-ME-Sender: <xms:ogN6ZH2r_h08YjMo8lrAVGc9e3T0AF9t0FKogfvEZVKtscWx2Rm6qg>
    <xme:ogN6ZGFus1iBNtYfFyH7eydTZkiGwX2X8q1Rsnl1-9Has84NCpZ9nOJ60MQ1JIKt3
    ZWGK_QGY5Tfr8YLs4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelfedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhephfefgedufeetgfetlefgkefgvdejleelvefg
    hfejfffhtdeitdejfeekvdeugfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgt
    rg
X-ME-Proxy: <xmx:ogN6ZH59XdDijpxPzMXizdaeZT0q5WXKJlFkxwJBB9DRtCGjQ_NAUQ>
    <xmx:ogN6ZM0Ome8_BxF6WRmgp4Xun-s-GyChH9CHfTt11RHLdTmYCpWdZA>
    <xmx:ogN6ZKE_ty6pZYJaKh7tqCplCeX2OPQcaIE68KsmGtDDAQxaKhkKCg>
    <xmx:ogN6ZPQ_NMSPs-gtj1PCJocu1LnLww-TSQMzJeok0J_m97CYmRNO8Q>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 59814C60091; Fri,  2 Jun 2023 10:58:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <3dda4d38-ef79-403c-a233-a8cf774edfd2@app.fastmail.com>
In-Reply-To: <bec3684e-d9d1-d88b-846a-46a1fc481ffb@linux.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20230601200552.4396-1-mpearson-lenovo@squebb.ca>
 <20230601200552.4396-8-mpearson-lenovo@squebb.ca>
 <bec3684e-d9d1-d88b-846a-46a1fc481ffb@linux.intel.com>
Date:   Fri, 02 Jun 2023 10:58:21 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "Hans de Goede" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 8/8] platform/x86: think-lmi: Don't display unnecessary
 authentication settings
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023, at 7:12 AM, Ilpo J=C3=A4rvinen wrote:
> On Thu, 1 Jun 2023, Mark Pearson wrote:
>
>> If Opcode support is available (which is the standard for all platfor=
ms
>> going forward) then there is no need to have the encoding and kbdlang
>> attributes visible.
>>=20
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>
> Thanks a lot, the patches look good now. One small thing for future: n=
ext=20
> time, try to arrange a series such that the patches with Fixes tags ar=
e=20
> the first patches, in here I think it's not a big deal since 2/8 doesn=
't=20
> seem to conflict with 3/8.
>
Ah - OK, thanks for the note, I didn't know that.

> For all patches 1-8:
>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>

Many thanks
Mark
