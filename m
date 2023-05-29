Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669C0714C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjE2Op1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjE2OpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:45:25 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB49DE;
        Mon, 29 May 2023 07:45:20 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 07AA23200908;
        Mon, 29 May 2023 10:45:17 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Mon, 29 May 2023 10:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1685371517; x=1685457917; bh=WJxq4N+ZYhuPBmoFeu+Q4lGnhwZGhN4Qelh
        mxlMc/pQ=; b=3f4nf005K7VFu9z3CcuPkq9tUCZm5Zt8q3rRAcJWPvIRQ/EtkAN
        kV+GAfZpgGUXxApFwS5PT+M9TiaRPc+0kFe2+EPQX1FIhQ1VwzlYUU1Cpgm3DL5+
        F0bY0/P2MPbnY0jmw9Dp2hHzJdEaTJceuCgsPT16W/J//5nNHT60qlfofiQN294v
        8nm9B/N8YYd0Q41VJsRfbutyJY0a/sJwYu5mIvKmNJhTX0aL/rfRORakyHO8LKks
        AXIiy6w4ygXdTAxPiUdjKGlgfGEaYJ9GhB9Nd8exWc5ZtcGSWXk05kAxbGoCd4zx
        yjbWThPpjf6CGK64X2st3S7nF4QKmWUU2aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685371517; x=1685457917; bh=WJxq4N+ZYhuPBmoFeu+Q4lGnhwZGhN4Qelh
        mxlMc/pQ=; b=fgfo85/Q1BdtHz7YWEywDUdnSEIqgNU4Q58Fwr3IZcg8qsHAg62
        GTv6b+tfD2U6/Psn4m/FCh094Jeqy157TEGQiSzTrPygBZtNwq9Sdu3nZV6fzd2n
        GfbqikyCaeyIaK553P4s08aKUXGjbea9o5j40fIRCRJTwsnelkBoU+zLe78GDe1S
        8Y9Po7TlIzBfsh1ne0uMWWP+ToqfueBiEPJ1BFEWsHcq6qLnkcz8EE6GRW8UjGzJ
        yNsGYiTZwEU9Ax3dP9rfCMiC8bco9cQujJGiV/IWB3l1J78nWUIcs7m5wTahoa/Z
        CjmOekEjFHzUvWKxlkre/yT9gOvS7sBbDFQ==
X-ME-Sender: <xms:fbp0ZNGoCvJGIAOcnqQvLFtPISuRv5fzPFzWZ1Mc9nNwEUnKXmbGSQ>
    <xme:fbp0ZCXD18hRSUI6P8c7PhDl5VuYeMsXYOIRGrCu3lbCfwmmVLOBEjyiwWNiBCOlU
    TYodweYZWkBJyWsEIE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekhedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhephfefgedufeetgfetlefgkefgvdejleelvefg
    hfejfffhtdeitdejfeekvdeugfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgt
    rg
X-ME-Proxy: <xmx:fbp0ZPKsrVBfFIGiYEaLm6xbSt_aBSQwioPwiIJk3uhfDaOkowjKmg>
    <xmx:fbp0ZDF7T_O7x6B1kXst8uSWf1wDBicIeg0EuLBU2Ckp3nSj2575ow>
    <xmx:fbp0ZDU-9UzQUEC0L51pwONCOHseE4vIk4naGkiqe3IqwK3LeR675w>
    <xmx:fbp0ZAj9s-KFX1oz3yMY8MGboucslc3v127XMeav1gz2oArM6rd6Rg>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5BE4FC60091; Mon, 29 May 2023 10:45:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <e71b1911-5105-4e19-9c86-6146f07a6b00@app.fastmail.com>
In-Reply-To: <ff5513d9-ecf-50d3-1bb3-644a1d2c2347@linux.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20230526171658.3886-1-mpearson-lenovo@squebb.ca>
 <20230526171658.3886-2-mpearson-lenovo@squebb.ca>
 <ff5513d9-ecf-50d3-1bb3-644a1d2c2347@linux.intel.com>
Date:   Mon, 29 May 2023 10:44:57 -0400
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

Thanks Ilpo

On Mon, May 29, 2023, at 7:36 AM, Ilpo J=C3=A4rvinen wrote:
> On Fri, 26 May 2023, Mark Pearson wrote:
>
>> The system password identification was incorrect. This means that if
>> the password was enabled it wouldn't be detected correctly; and setti=
ng
>> it would not work.
>> Also updated code to use TLMI_SMP_PWD instead of TLMI_SYS_PWD to be in
>> sync with Lenovo documentation.
>>=20
>> Correct these mistakes.
>>=20
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>
> Missing Fixes tag?

Yes - will add.

>
>> ---
>> Changes in v2:
>>  - Updated define name to be SMP_PWD instead of SYS_PWD
>>  - Clarified in comments what each password type is.
>> Changes in v3: None. Version bump with rest of series
>>=20
>>  drivers/platform/x86/think-lmi.c | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/=
think-lmi.c
>> index 2745224f62ab..c7e98fbe7c3d 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/think-lmi.c
>> @@ -168,11 +168,11 @@ MODULE_PARM_DESC(debug_support, "Enable debug c=
ommand support");
>>   */
>>  #define LENOVO_CERT_THUMBPRINT_GUID "C59119ED-1C0D-4806-A8E9-59AA318=
176C4"
>> =20
>> -#define TLMI_POP_PWD (1 << 0)
>> -#define TLMI_PAP_PWD (1 << 1)
>> -#define TLMI_HDD_PWD (1 << 2)
>> -#define TLMI_SYS_PWD (1 << 3)
>> -#define TLMI_CERT    (1 << 7)
>> +#define TLMI_POP_PWD (1 << 0) /* Supervisor */
>> +#define TLMI_PAP_PWD (1 << 1) /* Power-on */
>> +#define TLMI_HDD_PWD (1 << 2) /* HDD/NVME */
>> +#define TLMI_SMP_PWD (1 << 6) /* System Management */
>> +#define TLMI_CERT    (1 << 7) /* Certificate Based */
>
> Whe you're adding Fixes tag, please make this change minimal by just=20
> adding TLMI_SMP_PWD.
>
> The rest of these define changes are a good too but it's unrelated to =
the=20
> actual fix so they should be in a separate patch. And once you move it=20
> into own change, convert to BIT() while at it.
>

I was asked previously to clarify what SMP stood for so added the commen=
t and it seemed odd to only clarify one and not the others.
Can I push back on this request. Doing two separate patches for just tha=
t doesn't make sense to me.

Thanks for the review
Mark
