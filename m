Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDCE714DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjE2QHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjE2QHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:07:08 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3226CD;
        Mon, 29 May 2023 09:07:02 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id CA914320093E;
        Mon, 29 May 2023 12:07:01 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Mon, 29 May 2023 12:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1685376421; x=1685462821; bh=HuxZRv4TaFAuubZI3zfzO/JeEI/nq2N1lRx
        thCFxnxE=; b=zk9e1VmYz9/vZaI0LP5XXFmBSqchntaT5WDBHIno3JSnnK82o6I
        5betIjbZLTf67ebK/LRllk5CQq5EA0L8pjtHH7XlcaGPeahc/xA2r9xvVFzngXVU
        9Acz/PjHUYgj6+quAYOPUHzbwFcsbJ5Mur8MIYoNDYblKv9FXM0SkIHxfG4nank7
        Df4t2hNGLla3W72E5BQdNCdvZ/3dzmxr6n9zGKUaY5L7ELFROsKV0tGAMXsTy6JL
        6sFd3CZWIZv0jS5CfSHjHT/OOrVQkYpiSj7Rs2cyKPpNyygZeQBlZJMHRhrfvzX+
        vFleOlfXq6CGTokSIh6Ub6cK6TjFOjMqBvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685376421; x=1685462821; bh=HuxZRv4TaFAuubZI3zfzO/JeEI/nq2N1lRx
        thCFxnxE=; b=rAQRL0ZtUTHUDLvK1x8bPpUXCYS0qnh/CabOtLJzPYEZAb036+4
        VVSAlJDzfOo94TOD2pUWsjMfdBfIuW2hCoaxrtbaFh6fHLd7rPo+ovlPyIJuw+zL
        dWzflb4WJW6kEsN3f7Z4MTqktms0+8REJjamnmVo5E5nqUPRZQdvQCPxp/2koyZg
        Ye3/zc0IawxhYnewVmjfKZrgY6N50aUHNm9zU9qjEcpkpokyi+SB1pWvGJoEEZSg
        BxzqBrhwc7kf6U8DZ6rimwvrhUFN6wAtFkPW1d0txHvrt39NpzVVB4G2O39/Q3nN
        rJX1wnKhFof53ux4JVnXQcrpYPpOKHNpb1A==
X-ME-Sender: <xms:pc10ZK8IuY_ieK6Tuc2_WMygF-zrCles7KkYA-IGQ1DIC-2rKBxUjg>
    <xme:pc10ZKsI4Hq5FauR-kDQuGrnEomGpdT8nQEhqJmcnkmdAsip9HuSIJ4KlSkCKeD7E
    674ERvHYV3Tz-Ro070>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekhedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhephfefgedufeetgfetlefgkefgvdejleelvefg
    hfejfffhtdeitdejfeekvdeugfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgt
    rg
X-ME-Proxy: <xmx:pc10ZACrMdhOGP22jqHul710QaF9Zi2UdHz4FBOlezCHLgOPMD3eQw>
    <xmx:pc10ZCc7q5XJyaxJyzPz6jrowW1uaA55BBKjL5triBRsZ5ac15HmkQ>
    <xmx:pc10ZPP9RCfytVsXkAHbvfuWqz49LheTDQuf1bG-wju8jKOW7SgvaQ>
    <xmx:pc10ZIa2iEffnMqNf6f_rT8vgSs_lBHH_Ma80REU_2RESm1sNQgcfQ>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F3927C60091; Mon, 29 May 2023 12:07:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <39791b71-7c40-42dc-8618-a2831fa08440@app.fastmail.com>
In-Reply-To: <2796a7d0-8010-ab14-23a-9f69ee9d465@linux.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20230526171658.3886-1-mpearson-lenovo@squebb.ca>
 <20230526171658.3886-3-mpearson-lenovo@squebb.ca>
 <a52f69f-2dc4-fe76-9f89-e1c143d2bb27@linux.intel.com>
 <709df78f-4313-460a-87da-f4d302ed8912@app.fastmail.com>
 <2796a7d0-8010-ab14-23a-9f69ee9d465@linux.intel.com>
Date:   Mon, 29 May 2023 12:06:40 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "Hans de Goede" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] platform/x86: think-lmi: Correct NVME password handling
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, May 29, 2023, at 11:41 AM, Ilpo J=C3=A4rvinen wrote:
> On Mon, 29 May 2023, Mark Pearson wrote:
>> On Mon, May 29, 2023, at 8:03 AM, Ilpo J=C3=A4rvinen wrote:
>> > On Fri, 26 May 2023, Mark Pearson wrote:
>> >
>> >> NVME passwords identifier have been standardised across the Lenovo
>> >> systems and now use udrp and adrp (user and admin level) instead of
>> >> unvp and mnvp.
>> >>=20
>> >> This should apparently be backwards compatible.
>> >>=20
>> >> Also cleaned up so the index is set to a default of 1 rather than 0
>> >> as this just makes more sense (there is no device 0).
>> >
>> > These two sound entirely separate changes. If that's the case, plea=
se=20
>> > make own patch from the send change.
>>=20
>> Ack. It was all related to the index setting and seemed trivial so I=20
>> lumped together but I can split. This patch series is turning into a=20
>> good learning exercise for my git skills :) (which are limited)
>>
>> > Hmm, index_store() still allows 0, is that also related here? Pleas=
e check=20
>> > also ABI documentation as index default seems to be mentioned there=
 as=20
>> > well.
>> >
>>=20
>> I'd rather not limit it so 0 isn't allowed in case our BIOS team does=20
>> something weird in the future; but right now 1 is the default so it=20
>> makes more sense.
>
> Sure, do what you feel makes sense here. I was just pointing out the=20
> perceived inconsistency in case it wasn't intentional.
>
> It might be useful to add one sentence into changelog about the reason=
ing=20
> so it can be found easier later on (effectively the paragraph you wrot=
e=20
> above with small tweaks is enough I think).

Ack - will do. Thanks

Mark
