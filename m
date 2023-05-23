Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEB870DCB6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbjEWMhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjEWMhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:37:15 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7833BC4;
        Tue, 23 May 2023 05:37:11 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E560C5C0210;
        Tue, 23 May 2023 08:37:10 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Tue, 23 May 2023 08:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1684845430; x=1684931830; bh=Kn
        Gn5eb4S+X3iYghnL3L3fVpbv3jSMexyjANQhxZcyc=; b=pDM+Z+AlEZqBx/UAV1
        g4h1NeD5cA+bdcYuh++qDkn4cSaAME3/QaEzUOfTwhXScztogpr0HbWZjMEmNJiF
        1bJG0Jvk4tAlk4pVYsuZqPjI8b1r26LSacTVUoI+f8By0iGPEiu9iDgjHrS+R75g
        C8nobsPVPYiYmqqBCQk3T0UebQAyAMMWr32akQvTDizNRJRnutXteK65gHO7m6fy
        XONvH8yd4Zql+oYxtGIYIZQMptYySY0ns4fzR42MvP4jHKo0sJfMAhLI3yMetb4z
        dZeLWNaF8NcLNV98hER6ATNhh+pPr2lNeCgkpZj+GjeFrIAIUTH1hgxQinceN2UO
        1Y0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684845430; x=1684931830; bh=KnGn5eb4S+X3i
        YghnL3L3fVpbv3jSMexyjANQhxZcyc=; b=PHL1WdgBFZkfFbt9ks6liV5vLMxMt
        xJD+cHdq6P5qn0MRk66rzRemeoK4e1cWU2JOGSedTxCxoO9/bAgaK410z2M+zg9K
        6xEghNyJ3bzRf1CQNbomd9QUPxtlcqhPIPV03F4E8sjm9ChYH+cJ/S3OkPopJBKn
        Qqjec4ZTQ4iej6WTL9K+/qzPoeEMEtb4t2pYcnQCMXkbStTnK2eg/ijqLinVN9ua
        b9iBaEgtj7296vXAB+yBS0bejOU7AZlq7f9LQ17aFSNWfxwQvexfnjfRZcdtgGt+
        Wr8plHpiqbjhPwm03rOeFrjQDCE87qpJu2khPgZruyIGu5cM70QSj0qaw==
X-ME-Sender: <xms:drNsZGg47uNcAt92VBvdajqE-PjiABFJjh2a9_ppLTpt7hX5hUwniw>
    <xme:drNsZHCQ8YqPTkouYQlU73N7Voxj3Tymqw1ypJogd8B58pUaGlezsFvIIzFPDZk6s
    IUBvkdy2f-YJIy7psU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejfedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:drNsZOF3P2_h-awo3bPuNbVafqCqxdJWtaPKZIezpwR5Lc17HbaaYA>
    <xmx:drNsZPScCUpRkEJ1EubMR0uXHJfdtnln9rkISO-C66LAeoqVsAC2tw>
    <xmx:drNsZDzQTq7cuR3d7fMw4mofDmTRVw2ScRVSMGpGKpXz171DyJ5QRw>
    <xmx:drNsZMrSU9o1Zq8KVjskrAL-vBluC9hLsgDINdlDkxpquIItK8P4CA>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 72EFDC6008B; Tue, 23 May 2023 08:37:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <04415f83-64fa-4d70-91fa-4425e163b350@app.fastmail.com>
In-Reply-To: <b79fa66c-b8bc-125c-ccfa-9dae727022e9@redhat.com>
References: <mpearson-lenovo@squebb.ca>
 <20230517181945.3725-1-mpearson-lenovo@squebb.ca>
 <b79fa66c-b8bc-125c-ccfa-9dae727022e9@redhat.com>
Date:   Tue, 23 May 2023 08:36:49 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Hans de Goede" <hdegoede@redhat.com>
Cc:     "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] platform/x86: think-lmi: Enable opcode support on BIOS
 settings
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

Thanks Hans,

On Tue, May 23, 2023, at 6:46 AM, Hans de Goede wrote:
> Hi Mark,
>
> On 5/17/23 20:19, Mark Pearson wrote:
>> Whilst reviewing some documentation from the FW team on using WMI on
>> Lenovo system I noticed that we weren't using Opcode support when
>> changing BIOS settings in the thinkLMI driver.
>> 
>> We should be doing this to ensure we're future proof as the old
>> non-opcode mechanism has been deprecated.
>> 
>> Tested on X1 Carbon G10 and G11.
>> 
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> ---
>>  drivers/platform/x86/think-lmi.c | 23 ++++++++++++++++++++++-
>>  1 file changed, 22 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
>> index 1138f770149d..d9341305eba9 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/think-lmi.c
>> @@ -1001,7 +1001,28 @@ static ssize_t current_value_store(struct kobject *kobj,
>>  				tlmi_priv.pwd_admin->save_signature);
>>  		if (ret)
>>  			goto out;
>
>> -	} else { /* Non certiifcate based authentication */
>> +	} else if (tlmi_priv.opcode_support) {
>> +		/* If opcode support is present use that interface */
>> +		set_str = kasprintf(GFP_KERNEL, "%s,%s;", setting->display_name,
>> +					new_setting);
>> +		if (!set_str) {
>> +			ret = -ENOMEM;
>> +			goto out;
>> +		}
>> +
>> +		ret = tlmi_simple_call(LENOVO_SET_BIOS_SETTINGS_GUID, set_str);
>> +		if (ret)
>> +			goto out;
>> +
>> +		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
>> +			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
>> +					tlmi_priv.pwd_admin->password);
>> +			if (ret)
>> +				goto out;
>> +		}
>> +
>> +		ret = tlmi_save_bios_settings("");
>
> I'm a bit confused about how this works. You are calling the same
> LENOVO_SET_BIOS_SETTINGS_GUID as the old non opcode based authentication method
> without any auth string.
>
> And then afterwards you are calling LENOVO_OPCODE_IF_GUID with
> "WmiOpcodePasswordAdmin:<passwd>"
>
> Won't the initial LENOVO_SET_BIOS_SETTINGS_GUID get rejected since
> it does not include an auth-string and you have not authenticated
> yet using the opcode mechanism either. IOW shouldn't the opcode
> auth call go first ?
>
> And how does this work timing wise, vs races with userspace doing
> multiple sysfs writes at once.
>
> If the authentication done afterwards really acks the last
> LENOVO_SET_BIOS_SETTINGS_GUID call then a userspace based
> attacker could try to race and overwrite the last
> LENOVO_SET_BIOS_SETTINGS_GUID call before the ack happens... ?
>
> If this code really is correct I think we need to introduce
> a mutex to avoid this race.
>
> And this also needs some comments to explain what is going on.

Agreed - and looking at it now....I'm questioning it myself. This was tested so it works...but I wonder if that was more luck than judgement.
Let me do some checking - I think I may have messed up here.

Mark
