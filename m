Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24DE714DEE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjE2QLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjE2QLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:11:21 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08BDA3;
        Mon, 29 May 2023 09:11:19 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 061413200923;
        Mon, 29 May 2023 12:11:18 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Mon, 29 May 2023 12:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1685376678; x=1685463078; bh=zmFNdCUGHn2uCiz+5qQpRfAFFMQbxQoxap2
        qHL8X/ms=; b=C8HsizJ7uHz8yNXOwpjTIeOaBKpIlfdzpPkWDnKe39J134TjyDc
        pYUf8cH1TQb5m8WGTas9sWREUbvDqp5lbUooRI6zQipUjFobox3+QZ3roD5M/x2R
        6uxtwTMCQsrqWiTXu84QF6VsIKYy+tMRDX7CgJFcyZCLqzF2IuQffTUNw4BYvC3c
        mfRxftZlKZKoTC+d1DpAqGn+uwCSRzORf7x3YvsaCzrDn1z1bsqHXLFX3rKWILx9
        WhIZCU0BuOaYG2bNRVx0evq3NqKneT/gtwsOBUBCStaooeIZfEEyM54vRBiiBd+v
        6WO3OpILwhry9oY6Bfktp1gLToWbOTH4N/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685376678; x=1685463078; bh=zmFNdCUGHn2uCiz+5qQpRfAFFMQbxQoxap2
        qHL8X/ms=; b=GYSYw4qckWZe1ciWw1mw/TGOlFlcjy4V/u7xraqB5h1I724mX4x
        oXRt+j9RQTlVhytOOtT0A6ntngY9lfK6T0Y1hjML4rTDQvwDP4c0WY5BBgtXSItK
        lVFkc3BKxzmRUyXobJaUi7KLbd21r12Hikk8B2y2Q8SqMZ9A+BxCvkJtXfbKfnTO
        idtbMFhxhwqVLrlR3kY0SRu/7JZg9/glzreStOfGvrk1KH9yJQ9aUSh3pfJ//MfN
        hhXaMGE9XxvQ0loCJ4IhWUnq/KD+3AD9Q80nDa1ymHQnwhYF5QOwJ62k90EqWOPt
        HURxHq91VLmyAFjryxkY7bKGurZU9qmII/w==
X-ME-Sender: <xms:ps50ZHLn4HM2beE92_cIobMNFGeywAxaQ2nCQ7Bc36XznAVeF6Jwtg>
    <xme:ps50ZLITwefxQZD5Uv8IgDk0k_0BcLYLU12ZN5hfshUzflONKPlQ1qfFN4uo0y8j7
    pL1wU7LcExeQqMQ_js>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekhedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhephfefgedufeetgfetlefgkefgvdejleelvefg
    hfejfffhtdeitdejfeekvdeugfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgt
    rg
X-ME-Proxy: <xmx:ps50ZPumX6CIrdnVkoiWPuUIhirOZ3OdfI7XcfjViGbl352WwiU0Bw>
    <xmx:ps50ZAYHBxfMbXLaei6oR2fdEThywcdnZzQpHfd5oxJLM-2ptHh_NQ>
    <xmx:ps50ZOYlGQjBax0GenwfK1LEI-YtXHgve27PJNtWy7eYW_mK4JDR4A>
    <xmx:ps50ZNnJ0LrXI9CTG_BaE12fk-l_w6EOg5DexujAbR1kpJp8nVM0HA>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 40533C60091; Mon, 29 May 2023 12:11:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <fe193fe8-5a3c-4aa6-bb75-5ac53dc5a8f7@app.fastmail.com>
In-Reply-To: <3b2dfd18-a6f2-46a6-19dd-4ee95d5e9471@linux.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20230526171658.3886-1-mpearson-lenovo@squebb.ca>
 <20230526171658.3886-2-mpearson-lenovo@squebb.ca>
 <ff5513d9-ecf-50d3-1bb3-644a1d2c2347@linux.intel.com>
 <e71b1911-5105-4e19-9c86-6146f07a6b00@app.fastmail.com>
 <3b2dfd18-a6f2-46a6-19dd-4ee95d5e9471@linux.intel.com>
Date:   Mon, 29 May 2023 12:10:57 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "Hans de Goede" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] platform/x86: think-lmi: Correct System password interface
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


On Mon, May 29, 2023, at 11:50 AM, Ilpo J=C3=A4rvinen wrote:
> On Mon, 29 May 2023, Mark Pearson wrote:
>
>> Thanks Ilpo
>>=20
>> On Mon, May 29, 2023, at 7:36 AM, Ilpo J=C3=A4rvinen wrote:
>> > On Fri, 26 May 2023, Mark Pearson wrote:
>> >
>> >> The system password identification was incorrect. This means that =
if
>> >> the password was enabled it wouldn't be detected correctly; and se=
tting
>> >> it would not work.
>> >> Also updated code to use TLMI_SMP_PWD instead of TLMI_SYS_PWD to b=
e in
>> >> sync with Lenovo documentation.
>> >>=20
>> >> Correct these mistakes.
>> >>=20
>> >> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> >
>> > Missing Fixes tag?
>>=20
>> Yes - will add.
>>=20
>> >
>> >> ---
>> >> Changes in v2:
>> >>  - Updated define name to be SMP_PWD instead of SYS_PWD
>> >>  - Clarified in comments what each password type is.
>> >> Changes in v3: None. Version bump with rest of series
>> >>=20
>> >>  drivers/platform/x86/think-lmi.c | 14 +++++++-------
>> >>  1 file changed, 7 insertions(+), 7 deletions(-)
>> >>=20
>> >> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x=
86/think-lmi.c
>> >> index 2745224f62ab..c7e98fbe7c3d 100644
>> >> --- a/drivers/platform/x86/think-lmi.c
>> >> +++ b/drivers/platform/x86/think-lmi.c
>> >> @@ -168,11 +168,11 @@ MODULE_PARM_DESC(debug_support, "Enable debu=
g command support");
>> >>   */
>> >>  #define LENOVO_CERT_THUMBPRINT_GUID "C59119ED-1C0D-4806-A8E9-59AA=
318176C4"
>> >> =20
>> >> -#define TLMI_POP_PWD (1 << 0)
>> >> -#define TLMI_PAP_PWD (1 << 1)
>> >> -#define TLMI_HDD_PWD (1 << 2)
>> >> -#define TLMI_SYS_PWD (1 << 3)
>> >> -#define TLMI_CERT    (1 << 7)
>> >> +#define TLMI_POP_PWD (1 << 0) /* Supervisor */
>> >> +#define TLMI_PAP_PWD (1 << 1) /* Power-on */
>> >> +#define TLMI_HDD_PWD (1 << 2) /* HDD/NVME */
>> >> +#define TLMI_SMP_PWD (1 << 6) /* System Management */
>> >> +#define TLMI_CERT    (1 << 7) /* Certificate Based */
>> >
>> > Whe you're adding Fixes tag, please make this change minimal by jus=
t=20
>> > adding TLMI_SMP_PWD.
>> >
>> > The rest of these define changes are a good too but it's unrelated =
to the=20
>> > actual fix so they should be in a separate patch. And once you move=
 it=20
>> > into own change, convert to BIT() while at it.
>>=20
>> I was asked previously to clarify what SMP stood for so added the=20
>> comment and it seemed odd to only clarify one and not the others.=20
>> Can I push back on this request. Doing two separate patches for just=20
>> that doesn't make sense to me.
>
> I did not mean removing TLMI_SMP_PWD's comment from this patch just to=
 add=20
> it in the another but the comments to the other bits which should go i=
nto=20
> their own patch. The thing here is that fixes should be made minimal t=
o=20
> comply with stable rules.
>
OK....seems odd to me to be honest,  but not something I'd lose sleep ov=
er.=20
I'll do that in amongst all the other changes.

Thanks
Mark
