Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B7A714DD7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjE2QGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjE2QG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:06:29 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5D7B2;
        Mon, 29 May 2023 09:06:25 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3B1103200908;
        Mon, 29 May 2023 12:06:23 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Mon, 29 May 2023 12:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1685376382; x=1685462782; bh=Kl2w2yf8ESTuCzBcYvOTQ7d0QCjmY58J4ju
        tHuI/gho=; b=Jjq5esziC9a4A6/qQtFHElr2sTkmSXc+1uymseRzAfrnj4zMVni
        6LNP7HDemHbCFsaULjv4Nv3ZtPCRB0ronxNuJFZYKFl0kHAm021Ipz0YzfxvWgpx
        TB2akyVGTS1hCW9dyPAPJLGhIrJc9VTuSx3vTo+Mv1qo4FzQDNQScoy8EZYmScob
        P/gDNQye/s5hdkR5aXq5QByrav/V6MgzdjCLNrbjjioFDBnpAbNPpo4DguBYwAPa
        lmY/eFX9dpYXiGekx9/jrjZNNnkmumaEK84TkQ+etde1hGv43cYp1G7zCQIhoBdf
        SjLybqCzOoc5DbcV3OwYPtNCJUs36rhX4GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685376382; x=1685462782; bh=Kl2w2yf8ESTuCzBcYvOTQ7d0QCjmY58J4ju
        tHuI/gho=; b=reQxgBSTjEz6mfB4JhL+l4j8MUMhVZK77wrS9tAuX9zuIhTYiI0
        Pw6v717Q2w0Iy+pOOtVDkRpyWFC8l/nXyAwF3fSQG/vv5Og/KOkS0ykDqjlvWRyo
        Fa43F2YZmWMjG28qDmUws90MTnHLTTX0u+NubDY1JkQoBzoyNA1jNqIlPrp9H0EB
        6ONVqcTHM2riAJPdTgmfLToHFdjvg2Qqa5zOC/P0ZtOV/KcexNuj5s+DP5XTSkLY
        b95jtDvXCFNn13FgtK0Oz8bUJtJRaPqg82oaXtPZI5yKS9wQ69hcykPJBOSa5Szn
        fYHLUipVcOdvkgsO3pKckGYS+HEIcqIBllA==
X-ME-Sender: <xms:fs10ZCUUvl5y_UauZOHKCgDayZQanKt8B90GeRx0EqOKgSbwgGNTcg>
    <xme:fs10ZOntGQ3ZGPXfUFodIOKnvxU4JglPQFJ2SXql3ozMb19Uq4rx_i8uu-eoyfE6a
    5KsJtN_m-Yx9fnsdZ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekhedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhepfeejgedvudegvdekhedvffefjefhuedthfdt
    heehkeffuddvgfetjeegjeeufefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghr
    shhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:fs10ZGb69Tctqq2fZ1GhoTYX2P_Tc-b0bsrIa_15mzlMYh4VafaYtA>
    <xmx:fs10ZJWtnmHfKFfeULvLEJfTMWk2WPrmFvHAIcfBLaYUxOHLJmlLwQ>
    <xmx:fs10ZMmKI5hrYCzN4AiEGBZKxMiywqMb1tHKBDqsf3C-1lX-CsKVng>
    <xmx:fs10ZBzIn1JqtIEArMwmXXAy0JcRtoA-BFrQZIomNPDfeFjKlSY53Q>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7A281C60093; Mon, 29 May 2023 12:06:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <37f3c2b1-84d7-4b6e-a489-656a23e5cf88@app.fastmail.com>
In-Reply-To: <93f28f8b-67d4-496b-577d-12c106fe435@linux.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20230526171658.3886-1-mpearson-lenovo@squebb.ca>
 <0e11913-ba27-e3a-fafe-bd5e48db8b6b@linux.intel.com>
 <90de5786-085c-4cff-8125-215c9ae20ad1@app.fastmail.com>
 <93f28f8b-67d4-496b-577d-12c106fe435@linux.intel.com>
Date:   Mon, 29 May 2023 12:06:02 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "Hans de Goede" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] platform/x86: think-lmi: Enable opcode support on BIOS
 settings
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



On Mon, May 29, 2023, at 11:36 AM, Ilpo J=C3=A4rvinen wrote:
> On Mon, 29 May 2023, Mark Pearson wrote:
>> On Mon, May 29, 2023, at 7:51 AM, Ilpo J=C3=A4rvinen wrote:
>> > On Fri, 26 May 2023, Mark Pearson wrote:
>> >
>> >> Whilst reviewing some documentation from the FW team on using WMI =
on
>> >> Lenovo system I noticed that we weren't using Opcode support when
>> >> changing BIOS settings in the thinkLMI driver.
>> >>=20
>> >> We should be doing this to ensure we're future proof as the old
>> >> non-opcode mechanism has been deprecated.
>> >>=20
>> >> Tested on X1 Carbon G10 and G11.
>> >>=20
>> >> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> >> ---
>> >> Changes in v2: Update comment for clearer explanation of what the =
driver
>> >> is doing
>> >> Changes in v3: None. Version bump with rest of series
>> >>=20
>> >>  drivers/platform/x86/think-lmi.c | 28 +++++++++++++++++++++++++++-
>> >>  1 file changed, 27 insertions(+), 1 deletion(-)
>> >>=20
>> >> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x=
86/think-lmi.c
>> >> index 1138f770149d..2745224f62ab 100644
>> >> --- a/drivers/platform/x86/think-lmi.c
>> >> +++ b/drivers/platform/x86/think-lmi.c
>> >> @@ -1001,7 +1001,33 @@ static ssize_t current_value_store(struct k=
object *kobj,
>> >>  				tlmi_priv.pwd_admin->save_signature);
>> >>  		if (ret)
>> >>  			goto out;
>> >> -	} else { /* Non certiifcate based authentication */
>> >> +	} else if (tlmi_priv.opcode_support) {
>> >> +		/*
>> >> +		 * If opcode support is present use that interface.
>> >> +		 * Note - this sets the variable and then the password as separ=
ate
>> >> +		 * WMI calls. Function tlmi_save_bios_settings will error if the
>> >> +		 * password is incorrect.
>> >> +		 */
>> >> +		set_str =3D kasprintf(GFP_KERNEL, "%s,%s;", setting->display_na=
me,
>> >> +					new_setting);
>> >
>> > Alignment.
>>=20
>> OK - I assume you want the new_setting lined up under the bracket.
>> I've not seen that called out as a requirement (https://www.kernel.or=
g/doc/html/v4.10/process/coding-style.html) but I don't mind fixing....b=
ut if you can point me at the specifics it's appreciated
>
> Yes, I meant aligning to the column following the opening parenthesis.
>
> I guess it's not a hard requirement, however, there's a benefit from=20
> certain things aligning because it helps in the brains in the process =
of=20
> converting text into structure with less effort (when not specifically=
 not=20
> focusing on that particular line).

Not a problem. Happy to make this change along with the others. Was just=
 curious :)

>
>> >> +		if (!set_str) {
>> >> +			ret =3D -ENOMEM;
>> >> +			goto out;
>> >> +		}
>> >> +
>> >> +		ret =3D tlmi_simple_call(LENOVO_SET_BIOS_SETTINGS_GUID, set_str=
);
>> >> +		if (ret)
>> >> +			goto out;
>> >> +
>> >> +		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password=
[0]) {
>> >> +			ret =3D tlmi_opcode_setting("WmiOpcodePasswordAdmin",
>> >> +					tlmi_priv.pwd_admin->password);
>> >
>> > Align.
>>=20
>> Ack.
>>=20
>> >
>> >> +			if (ret)
>> >> +				goto out;
>> >> +		}
>> >> +
>> >> +		ret =3D tlmi_save_bios_settings("");
>> >> +	} else { /* old non opcode based authentication method (deprecat=
ed)*/
>> >
>> > non missing hyphen.
>>=20
>> non-opcode I assume?
>
> I think the most proper English would be non-opcode-based since "opcod=
e=20
> based" belong together (but I'm not a native speaker here).

I am a native speaker....and I don't know :) (English is weird...)
Let's go with non-opcode; adding the based on there feels wrong to me (s=
omewhat arbitrarily).

>
> --=20
>  i.
