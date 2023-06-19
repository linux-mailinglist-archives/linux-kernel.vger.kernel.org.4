Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE97735DD9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjFST1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFST1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:27:02 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4195A9F;
        Mon, 19 Jun 2023 12:26:58 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D4AAD5C036B;
        Mon, 19 Jun 2023 15:26:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 19 Jun 2023 15:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1687202815; x=1687289215; bh=RkdhSqLZgVEX1NN/WLsswvWnrGRK9C1YpT+
        3WFY7fJs=; b=lqi9LNlWDqkiNo12WAlGf5470UOr5JZtzm/5UlrqyrtS4Ly5E7Q
        yHm8eP7v/j6Eb/H+WfNdf9H2W0gE4YQ5172dDEyqM+1/1kMu/nhwrkPx/RSnW7kZ
        QzM9l2t85HLrsuNAEWPomJ69F5BBNI3X300UdjF4Tr1lYFMhX6UiQWT4k4JXX4If
        WzXR2V/C1ZGnVTrcNh+/rRasL0MCiGg01GUdac0dypFkDUi8XPJ6G+nLtDCi0Lry
        PWrCa88MRHkbJ+MsfUWoqWoWWvzrWT9bFqKYuiYnjxVW3+OU7rj9Y2FYOS6plDXy
        1YlF8JhK7aeKKce8Wa9WC/CM3H7aixVeU8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1687202815; x=1687289215; bh=RkdhSqLZgVEX1NN/WLsswvWnrGRK9C1YpT+
        3WFY7fJs=; b=p01IQHTz6KkHuhYq6u3hE/P9uumBXV8balAzp1bvsZZOkXSHFR9
        VkxLLFw1ovBtOtphGc/uGPFpOKmp8OgwjnDJb7CuK5vl4kQwvVrcSxvDywxKdlp6
        qCelVMvzPT8bBEyk4hyoX4O3UVYaW8RSCqvy6K7OVXomWxncQiqKpt+MetIC5LDl
        pZ99b8qxIgT5+W2mI70GJKZ1lto7SQHVZs3dPobjFZmxKJFMaPE1S1Tr7Vh9DnGc
        GQItxtdPo7AH3wEBhE4lYkL2NZ6ErqMsf/2XSaHgw0iCWXdwgmUZ2EomQDifvG6S
        F+/foTtq8vuPLQUi5b0PZg85tyftLkdWHYg==
X-ME-Sender: <xms:_quQZLmpyV9ZI1dQ2Zeyk08OAiJGtYzpvde6aA4eAbjK7s6kWv6BFA>
    <xme:_quQZO2V2yP1UKBSub2bBdHetWkwQORL-FdSLfMG0iUjvHPulxJVBFKNQ0RDkVsAp
    Kex7apeFIF9Nrv5pQ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefvddgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:_quQZBocDkFMAUMCbVoJ_7I69BiuZ7RTpfAmOfFlWZw1f2BeMtxhIA>
    <xmx:_quQZDm_HBnodVkCpUQrsm3jc6JmfIlK87dUVxV5wD2VB7_NKaqjFg>
    <xmx:_quQZJ1l2ndt4OZwHsiEQyNWqN6AELxAekS4ytcm5SAAs4s9tTTs_A>
    <xmx:_6uQZCI_RFTqzhbpNr5nwcRDafw5iXhWDAmRToH3HnaC3OHt-kY8kg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CDAB4B60086; Mon, 19 Jun 2023 15:26:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-496-g8c46984af0-fm-20230615.001-g8c46984a
Mime-Version: 1.0
Message-Id: <300ecb3e-8747-4399-8452-77724f85330b@app.fastmail.com>
In-Reply-To: <d9f088d1d548c8735b393a15d5a16dbd914ddeca.camel@collabora.com>
References: <20230616144854.3818934-1-arnd@kernel.org>
 <20230616144854.3818934-2-arnd@kernel.org>
 <e264ac3a15e0f115aa7e941a77eb312429b8f65e.camel@collabora.com>
 <063a8886-fd31-425f-901c-fc830512eca3@app.fastmail.com>
 <d9f088d1d548c8735b393a15d5a16dbd914ddeca.camel@collabora.com>
Date:   Mon, 19 Jun 2023 21:26:34 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nicolas Dufresne" <nicolas.dufresne@collabora.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Ezequiel Garcia" <ezequiel@vanguardiasur.com.ar>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
Cc:     "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        "Benjamin Gaignard" <benjamin.gaignard@collabora.com>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: verisilicon: change confusingly named relaxed register
 access
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023, at 20:29, Nicolas Dufresne wrote:
> Le lundi 19 juin 2023 =C3=A0 16:49 +0200, Arnd Bergmann a =C3=A9crit=C2=
=A0:
>> >=20
>> > In this text you spoke about potential performance side effects of =
existing code
>> > and your changes, but its left all very vague and theoretical. Have=
 you done any
>> > measurement ? Do you need help with the manner ?
>>=20
>> I don't have this hardware and have not done any measurements.
>> Obviously the only point of using relaxed accessors is to
>> improve performance in critical code paths, but from the way they
>> are used here it seems that this was instead just an accident
>> and nobody else did any comparisons either.
>>=20
>> My guess would be that if one wanted to speed up the register
>> access, a better way would be to use a regmap cache to avoid
>> reading registers when the contents are already known.
>
> All I know is that for the majority of registers when programming stat=
eless
> codecs, each 32bit word of registers are fully written too, the read v=
alue is
> not always meaningful (its a value from last time the HW has been trig=
gered) and
> should be ignored, so better to not do that. As for regmap, there is f=
olks that
> have reported regmap to be completely overkill for this type of hardwa=
re.

Right, most likely neither the cache nor avoiding the readl() is necessa=
ry,
and that was exactly my point to start with: don't add potentially dange=
rous
microoptimizations like relaxed accessors unless the obvious optimizatio=
ns
are also needed and used.

Obviously, testing my patch would still be a good idea before applying i=
t.

       Arnd
