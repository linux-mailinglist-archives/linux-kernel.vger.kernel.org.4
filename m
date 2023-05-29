Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1B1714C77
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjE2OuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjE2OuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:50:10 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F276CF;
        Mon, 29 May 2023 07:50:09 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 713A332000D7;
        Mon, 29 May 2023 10:50:08 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Mon, 29 May 2023 10:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1685371808; x=1685458208; bh=mRoTwqCPa4SqPzkuEvlHPj4el7jXPMfh87t
        jw6CCRuQ=; b=Te+YXCqxcCRQyX4Z38hyGcttKZyo6v8e9vuVCYPQYD4NruPaucJ
        WGV33p07z/OFxneQRSU5UYZUXWzmfxt3ULSeD8dH6hn1aYrrgMs/oW1UCbITceUv
        /1vvjbr0RIU5/5l2P2gwVcdV3yr3gDZV+kFV6FQQKyGLkcx6vPusn9sSHcwQ8P/C
        /xyTrYRNGRdYla710PWHD1Zd9gjUxqIiXWqTb42c6Xj5uRpXK1ptqSf5NWzMRrWP
        /01q3ZQ7esvsAvX49pX+MCJYutXCczEh4kGtX89+Gb5+Q/yFsd9EgzucKtyeW0CZ
        bNoVEeRrGlAF/1wf1ez3bLJOarvA6ThNqKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685371808; x=1685458208; bh=mRoTwqCPa4SqPzkuEvlHPj4el7jXPMfh87t
        jw6CCRuQ=; b=liDstJ5ZTRYIB8VRA6PD9YPL8TEy2V6cxnXuvGiv+mN8DyZXt2B
        6RnAG0amA8KAQtkR3mtDPFhvNjmhp+q7wsDIKiWKKK6PoBP6Ka36USnZ3VbwKpPu
        w/8bBxTzM1jznzU/FYOtUNEUR45z6TnZSywhieYijlJ+MfWsvzp1cRL5petHmF2V
        nFPGjRbR6R0OQ3qFFVzrIGfCCDp0N9edTWfuPz+xa4Q5KFW8AoPTsoFsUK4Fft0g
        pNVDM+lpvP/NqRiWVHHD+WyKaei1exNZsKskx9KvO9npJncA8wpKRAfC46Om3UDK
        /zRoX7tKLdcrjZ/hVghTnt5ktBEMGPRnL1g==
X-ME-Sender: <xms:n7t0ZAiu07wZ9fZUYZhrLOhIVAjcAlnA5Rbrs30yKrXy7b3MQonIeA>
    <xme:n7t0ZJBl0jvPrubHIaMauzpUfMCtBFGqeL8GgEqZoOMs6TOPO-5a8b9QSBZpNqsuk
    FeNF-dTV9Q9RMjg-CA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekhedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhepfeejgedvudegvdekhedvffefjefhuedthfdt
    heehkeffuddvgfetjeegjeeufefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghr
    shhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:n7t0ZIH29PcGolzwtke5nkNyfplEmnxoLsWl39thWOoztImc4nla3w>
    <xmx:n7t0ZBRHlAqyi5lL2KPjbsT3BUYDXd8JRnSn8cAwrlD6IjeAs3vRwA>
    <xmx:n7t0ZNz_sdM752r0Vx1lkUDP7dIf0cnidGyrZCknSdOzCJQTpimDLA>
    <xmx:oLt0ZI-scjPKx4T_Et4cTWqVf2eFODJ-yrxPs3xj-Z_qzNwKXgbu7Q>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 549F6C60091; Mon, 29 May 2023 10:50:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <90de5786-085c-4cff-8125-215c9ae20ad1@app.fastmail.com>
In-Reply-To: <0e11913-ba27-e3a-fafe-bd5e48db8b6b@linux.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20230526171658.3886-1-mpearson-lenovo@squebb.ca>
 <0e11913-ba27-e3a-fafe-bd5e48db8b6b@linux.intel.com>
Date:   Mon, 29 May 2023 10:49:46 -0400
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



On Mon, May 29, 2023, at 7:51 AM, Ilpo J=C3=A4rvinen wrote:
> On Fri, 26 May 2023, Mark Pearson wrote:
>
>> Whilst reviewing some documentation from the FW team on using WMI on
>> Lenovo system I noticed that we weren't using Opcode support when
>> changing BIOS settings in the thinkLMI driver.
>>=20
>> We should be doing this to ensure we're future proof as the old
>> non-opcode mechanism has been deprecated.
>>=20
>> Tested on X1 Carbon G10 and G11.
>>=20
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> ---
>> Changes in v2: Update comment for clearer explanation of what the dri=
ver
>> is doing
>> Changes in v3: None. Version bump with rest of series
>>=20
>>  drivers/platform/x86/think-lmi.c | 28 +++++++++++++++++++++++++++-
>>  1 file changed, 27 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/=
think-lmi.c
>> index 1138f770149d..2745224f62ab 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/think-lmi.c
>> @@ -1001,7 +1001,33 @@ static ssize_t current_value_store(struct kobj=
ect *kobj,
>>  				tlmi_priv.pwd_admin->save_signature);
>>  		if (ret)
>>  			goto out;
>> -	} else { /* Non certiifcate based authentication */
>> +	} else if (tlmi_priv.opcode_support) {
>> +		/*
>> +		 * If opcode support is present use that interface.
>> +		 * Note - this sets the variable and then the password as separate
>> +		 * WMI calls. Function tlmi_save_bios_settings will error if the
>> +		 * password is incorrect.
>> +		 */
>> +		set_str =3D kasprintf(GFP_KERNEL, "%s,%s;", setting->display_name,
>> +					new_setting);
>
> Alignment.

OK - I assume you want the new_setting lined up under the bracket.
I've not seen that called out as a requirement (https://www.kernel.org/d=
oc/html/v4.10/process/coding-style.html) but I don't mind fixing....but =
if you can point me at the specifics it's appreciated

>
>> +		if (!set_str) {
>> +			ret =3D -ENOMEM;
>> +			goto out;
>> +		}
>> +
>> +		ret =3D tlmi_simple_call(LENOVO_SET_BIOS_SETTINGS_GUID, set_str);
>> +		if (ret)
>> +			goto out;
>> +
>> +		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]=
) {
>> +			ret =3D tlmi_opcode_setting("WmiOpcodePasswordAdmin",
>> +					tlmi_priv.pwd_admin->password);
>
> Align.

Ack.

>
>> +			if (ret)
>> +				goto out;
>> +		}
>> +
>> +		ret =3D tlmi_save_bios_settings("");
>> +	} else { /* old non opcode based authentication method (deprecated)=
*/
>
> non missing hyphen.

non-opcode I assume?

>
> Missing space at the comment closing.

Will fix.

>
>>  		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]=
) {
>>  			auth_str =3D kasprintf(GFP_KERNEL, "%s,%s,%s;",
>>  					tlmi_priv.pwd_admin->password,
>>=20
>
> Except for those style issues, it look okay to me:
>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>
Thanks for the review!
Mark
