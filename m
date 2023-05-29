Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A40714C95
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjE2O6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjE2O6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:58:32 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7939AD;
        Mon, 29 May 2023 07:58:31 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E0D2532005D8;
        Mon, 29 May 2023 10:58:30 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Mon, 29 May 2023 10:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1685372310; x=1685458710; bh=YkweKgJ4f/SmRu5LsICpz+G7m78ta5lebbS
        sHFR7Ozk=; b=dCUp61NUgFO3iSm/DUEUtFNnC/RcH2VFIFEzBzZsxN2dPEYSi3o
        tzetlFCygea+TNgx7hXBDBZtIIJAXCUfT076ysJEB59bMSDbIpZ9dOLV6xdZ2WKN
        u8riGsKyoGjp94JMU9282S0E2YDk17J1y6bMy8Acls13I/hfjHHxngQgrfawx94w
        eUNf2jF8LmRXvhTpB7/Hsm89/dTaYmuRL9SfA8tHwpve8EwW3qjXye6ZZDo/6Dr6
        s5tGUz58h+xPUQxeWCul3ajh3kUefLc1Vw+W17yUMjt552S5BmifTEjlGM8pnwTn
        MDJ3aGI+ozLT0kvvHYZ4OQBSy2fFPeld2Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685372310; x=1685458710; bh=YkweKgJ4f/SmRu5LsICpz+G7m78ta5lebbS
        sHFR7Ozk=; b=jRrD5F4bKmo0sbOrENH8E/8FVR3At2GrQ6eGhA18L3WWrVyWeEK
        WoHPGXruK2tplkblehHWX8uEU5TfGCpX70CBqqnhI7QbFeEBeTDQm5mXHYa2P4iI
        9fyhSsCI66uwUGz6zExXtDGIW6rHGWtKBCZBWypzm8YFWwxZ0ZbBWkfiFutqYVPA
        9wYHIVWTMhv0zFX60T4Z/tnwrxgBSuwJlz+jMgIJlCChaSqV4NqfG+2JhqK8IaBt
        8U1d08uWlQQTZ8NfNAz1b6B+LYR4v4juYE/ZUhdFXh6u6qf58wpg/l42U9GkhcTp
        qGBMqzuZG9Gkm7br04vGX8vjE7EGV6SM9eg==
X-ME-Sender: <xms:lr10ZKcI1MHO0DLcLZkDsvDfKov-HFnmZjRGrc6zN9U2r5aLZWxhaA>
    <xme:lr10ZEPV9xq3Yz7otqJVo6B1kyrvga2LR5OBnyFsg8AmLxGuOW5bTjqRgE4Cul6d7
    ZSA1rYaO2IzjgmP8Ik>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekhedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhephfefgedufeetgfetlefgkefgvdejleelvefg
    hfejfffhtdeitdejfeekvdeugfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgt
    rg
X-ME-Proxy: <xmx:lr10ZLhXRNAuHCOuSlfTNtG9xd1f_HdUFP9QfqJqSxH_qVT7peB-9Q>
    <xmx:lr10ZH8VbMY0hfDHIb-hNIyMu3PDocJ4V5KQtwGiRep7CjZGsel25Q>
    <xmx:lr10ZGsFrcY9ZahiUtTyg7mVtNXPxmhoxS0Ss9KkUzRKTtJdN38WHg>
    <xmx:lr10ZP407QxZ-4iIItVo0gOecejN31V1HzMm-_pXGMvs7XS_tJJ2fA>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 35570C60091; Mon, 29 May 2023 10:58:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <709df78f-4313-460a-87da-f4d302ed8912@app.fastmail.com>
In-Reply-To: <a52f69f-2dc4-fe76-9f89-e1c143d2bb27@linux.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20230526171658.3886-1-mpearson-lenovo@squebb.ca>
 <20230526171658.3886-3-mpearson-lenovo@squebb.ca>
 <a52f69f-2dc4-fe76-9f89-e1c143d2bb27@linux.intel.com>
Date:   Mon, 29 May 2023 10:58:08 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "Hans de Goede" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
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

Thanks Ilpo

On Mon, May 29, 2023, at 8:03 AM, Ilpo J=C3=A4rvinen wrote:
> On Fri, 26 May 2023, Mark Pearson wrote:
>
>> NVME passwords identifier have been standardised across the Lenovo
>> systems and now use udrp and adrp (user and admin level) instead of
>> unvp and mnvp.
>>=20
>> This should apparently be backwards compatible.
>>=20
>> Also cleaned up so the index is set to a default of 1 rather than 0
>> as this just makes more sense (there is no device 0).
>
> These two sound entirely separate changes. If that's the case, please=20
> make own patch from the send change.

Ack. It was all related to the index setting and seemed trivial so I lum=
ped together but I can split.
This patch series is turning into a good learning exercise for my git sk=
ills :) (which are limited)

>
> Hmm, index_store() still allows 0, is that also related here? Please c=
heck=20
> also ABI documentation as index default seems to be mentioned there as=20
> well.
>

I'd rather not limit it so 0 isn't allowed in case our BIOS team does so=
mething weird in the future; but right now 1 is the default so it makes =
more sense.

Well spotted on the ABI documentation - I had completely missed that. I =
will address that as well.

> --=20
>  i.

Thanks for the review
Mark
