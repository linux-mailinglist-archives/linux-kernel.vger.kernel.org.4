Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034CD714C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjE2OvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjE2OvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:51:09 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31824EA;
        Mon, 29 May 2023 07:51:08 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 6575D320094F;
        Mon, 29 May 2023 10:51:07 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Mon, 29 May 2023 10:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1685371867; x=1685458267; bh=blDq+QHCOBYb/yKUOZLW7MiQVLqb5XmTXJg
        4JUWpDqU=; b=l5Kiwo8L0qIoASMHrJVnZqJXH1sA899gLTcVKooGYR+oxF2Fuuv
        FlyYs3Ms9QLjPlAPC5xdrH8P4TyL3uBA4m2OmYysfYUnwmFiPYR1u4+Nbwx5hgN2
        OqmHtVnWkkTwhC0ClVGcSWy3NxkzzBuy9BqDVWmSWLj8Nn8aR4hVhr+Twa50s9tq
        B7qu6m9yyqccmWtiZFQe6pwBCFCZI+GncUaiQ3iEYd4aZIEzuoJ4aXxfwzBTYxD9
        SwBYc/HnpGUm4wtkj29fKqN1ha6ZHgjfwugDvxXC/KHmSqzIzBfp7l8H/pcGtBnm
        8WgwJQ114LqwRjTLELloR6eFGvFQJu62eWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685371867; x=1685458267; bh=blDq+QHCOBYb/yKUOZLW7MiQVLqb5XmTXJg
        4JUWpDqU=; b=MDacCx16JusqZNc/oTrvXJ7wLNV+YML3jzRHn2S7j6tUq/GrCmz
        kCkPXGbN8OYPGQpq4NGlmVWrAGsR2MJP/5jOuMafsCrMaZVUwKiYE3XUijSE08gF
        myp/XxvwC8FgaeTvGzuFwzxh9BtZTIYYOtg4A2y8lh1OtY94eVlrRZBPE8syMEdP
        mSrQ8JRDspOSi2IpGOvs/JLA8L7oOlmm6UHZAsU7i8yB55j1E9QLnGJuDa2zjsGH
        uNxf8B+DVw8vQBJ4asbpDYYJ4C/e9+iRzq9mTy4Zzw6yzZVAtuT3ovHgvHeWBKPk
        OqSAZXvXyR0yydn6oZ2U8p1PT9xUIGkc5bw==
X-ME-Sender: <xms:2rt0ZKrBD4Z3AutsEkU0yZFHvZ6KABcKpmrFuWemyNg2HaT-YX7ziw>
    <xme:2rt0ZIpNYnk2aq3KULFePjBBCwzAJdIkMh2lPiJ3lh4_-h0wa9b3njpg0tQHg6V3H
    EAusDRBeDqjHWN6igk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekhedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhephfefgedufeetgfetlefgkefgvdejleelvefg
    hfejfffhtdeitdejfeekvdeugfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgt
    rg
X-ME-Proxy: <xmx:2rt0ZPNXHR_u-Ys3UhgEDuyj3n5uiPqOwSFNVaMtVivOx-6VCr5cUw>
    <xmx:2rt0ZJ4waq_UUWSBS0AYq-GQoxWAHdwX6Ebau1ryx8Lpo_njMnwodA>
    <xmx:2rt0ZJ5r0Cmqkz1UsBnAw7sB9L0xT4qODXj981tipAs8Cl_fi2YddQ>
    <xmx:27t0ZJEOVkO6ArkLBhxOwxZRATZumDInn1fqZqOtqr9_BGLPaJv_7w>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C1422C60091; Mon, 29 May 2023 10:51:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <49631ff4-8d8c-4e77-bf13-dd8b0c1819d0@app.fastmail.com>
In-Reply-To: <aeb0313-e845-9134-4136-6347d691bd4@linux.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20230526171658.3886-1-mpearson-lenovo@squebb.ca>
 <20230526171658.3886-4-mpearson-lenovo@squebb.ca>
 <aeb0313-e845-9134-4136-6347d691bd4@linux.intel.com>
Date:   Mon, 29 May 2023 10:50:35 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "Hans de Goede" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] platform/x86: think-lmi: Don't display unnecessary
 authentication settings
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



On Mon, May 29, 2023, at 8:05 AM, Ilpo J=C3=A4rvinen wrote:
> On Fri, 26 May 2023, Mark Pearson wrote:
>
>> If Opcode support is available (which is the standard for all platfor=
ms
>> going forward) then there is no need to have the encoding and kbdlang
>> attributes visible
>>=20
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> ---
>> Changes in v2 & v3: None. Version bumped in series
>>=20
>>  drivers/platform/x86/think-lmi.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>=20
>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/=
think-lmi.c
>> index 1c02958035ad..64cd453d6e7d 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/think-lmi.c
>> @@ -879,6 +879,12 @@ static umode_t auth_attr_is_visible(struct kobje=
ct *kobj,
>>  		return 0;
>>  	}
>> =20
>> +	/* Don't display un-needed settings if opcode available */
>> +	if ((attr =3D=3D &auth_encoding.attr ||
>> +	    attr =3D=3D &auth_kbdlang.attr) &&
>
> Indentation issue here, attr must be at the same column although putti=
ng=20
> the || on a single line might make this easier to read.

OK - will fix.

>
>> +	    tlmi_priv.opcode_support)
>> +		return 0;
>> +
>>  	return attr->mode;
>>  }
>> =20
>>=20
>
> --=20
>  i.

Thanks for the review
Mark
