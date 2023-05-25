Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0694F7117A4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbjEYTuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240681AbjEYTuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:50:44 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FBE95;
        Thu, 25 May 2023 12:50:43 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 85D1A5C037D;
        Thu, 25 May 2023 15:50:42 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Thu, 25 May 2023 15:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1685044242; x=1685130642; bh=ZX
        wcbVQTMEseDcnDDWOf0VpDhPSj5ka5jVvD+UYmm90=; b=fM1XQH6M50V7WeyZAJ
        JKnE8GTAte3RjbCEqNcTAnNPJi5Bz/QsYvY5l/0lDHq6I/FhiHO/rbXnREM0PQyf
        HHTz/XreHpobcEb1jh6rZywv+mXT5RmiYBw1EqpvK60Fma1BN7kyAx86jwJqqAVb
        88Sk6DnKKDwil3Pe2H8qTmWT6YS1grlXDlYyPFKgmJGBajgxqtAKZiiYGELm42k4
        v0ovJIYzlGfncOtetft+6clL8ACcjB2O3dBBwNUAlFwVtzV2Iiofr99koI7U7idv
        k6ipESg+pg0yGt64LLSlHFmTQaHKYyM5pWH+4ZHZqeZhrdLobma8pvjX0ZyS72Eo
        3Ctg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685044242; x=1685130642; bh=ZXwcbVQTMEseD
        cnDDWOf0VpDhPSj5ka5jVvD+UYmm90=; b=rdUHcJSygUfURMDpemuC4hLuOnOuP
        LeUzq1r2ippYkisy1NiVhNGcg1uNYg+jvsril/6JGryFpGSjc2sv58jIiTQ+D8Cx
        cPVevTmO42UdPbFLweBn+X+aWRMuBi6gYymqsmhoTel7OkLSLaTZg1AM816DF0y3
        3lL16SwBludOc14rxylc4rsxfsm4Z/4zOCOO3ONm3fNQm9aIgVpRRIWFUKrHdt/h
        3wSKfsTKAcQ8D+Z0LsWVuflGAIX9DrR2ifRrO6sTHEGPpPBRKzPEzlps0ubKmOdg
        0r5s6QB1nULrGZResHje77gXKI0g8J4R/4QDl6Txtc/wDdmF++ttI4DPA==
X-ME-Sender: <xms:ErxvZJawYOwXFhS4BveIdDJdQLIHZB4QecqCRUION9iiAtgiaGmsxA>
    <xme:ErxvZAYQEKoszEvGoPWqDuo05myeZUs1CzQf-g72SSpkIRVDcsGn2cAuwLWAR_4A1
    6yBLXX5ox1YS3Twn6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejjedgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhepieeufeejieevteduvdekteefledtveffvedu
    hefffeejudefvdeijeegudegkefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgt
    rg
X-ME-Proxy: <xmx:ErxvZL-OJMjdBBy_ZVxBA5GnagHLLH1sh73DXZXcqAhi_AVlOpCqTQ>
    <xmx:ErxvZHrNx44K0maWvF6Zoju8hZVPjYRsYWyuFcKzlLn9YLcEiKitNA>
    <xmx:ErxvZErdacIu9pBumkXFXIjIh_ojRIfiU3AeFtR-5cmqETIu1zWwrA>
    <xmx:ErxvZBBOWRQVNI4Sd8uK5Vai3oNOqzbAav4symb6mHIom4yXESCRVA>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 36CD8C60091; Thu, 25 May 2023 15:50:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <f6b0b842-3ef0-4c48-afca-6d9953993c9e@app.fastmail.com>
In-Reply-To: <6e05df16-7125-a634-6b99-3cf3079d3d5d@redhat.com>
References: <mpearson-lenovo@squebb.ca>
 <20230525193132.3727-1-mpearson-lenovo@squebb.ca>
 <20230525193132.3727-5-mpearson-lenovo@squebb.ca>
 <6e05df16-7125-a634-6b99-3cf3079d3d5d@redhat.com>
Date:   Thu, 25 May 2023 15:50:20 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Hans de Goede" <hdegoede@redhat.com>
Cc:     "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] platform/x86: think-lmi: mutex protection around multiple WMI
 calls
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, May 25, 2023, at 3:41 PM, Hans de Goede wrote:
> Hi Mark,
>
> On 5/25/23 21:31, Mark Pearson wrote:
>> Add mutex protection around cases where an operation needs multiple
>> WMI calls - e.g. setting password.
>> 
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> ---
>> Changes in V2: New commit added after review of other patches in series.
>> 
>>  drivers/platform/x86/think-lmi.c | 46 ++++++++++++++++++++++++--------
>>  1 file changed, 35 insertions(+), 11 deletions(-)
>> 
>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
>> index 64cd453d6e7d..f3e1e4dacba2 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/think-lmi.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/acpi.h>
>>  #include <linux/errno.h>
>>  #include <linux/fs.h>
>> +#include <linux/mutex.h>
>>  #include <linux/string.h>
>>  #include <linux/types.h>
>>  #include <linux/dmi.h>
>> @@ -195,6 +196,7 @@ static const char * const level_options[] = {
>>  };
>>  static struct think_lmi tlmi_priv;
>>  static struct class *fw_attr_class;
>> +static DEFINE_MUTEX(tlmi_mutex);
>>  
>>  /* ------ Utility functions ------------*/
>>  /* Strip out CR if one is present */
>> @@ -463,23 +465,32 @@ static ssize_t new_password_store(struct kobject *kobj,
>>  			sprintf(pwd_type, "%s", setting->pwd_type);
>>  		}
>>  
>> +		mutex_lock(&tlmi_mutex);
>>  		ret = tlmi_opcode_setting("WmiOpcodePasswordType", pwd_type);
>> -		if (ret)
>> +		if (ret) {
>> +			mutex_unlock(&tlmi_mutex);
>>  			goto out;
>> -
>> +		}
>>  		if (tlmi_priv.pwd_admin->valid) {
>>  			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
>>  					tlmi_priv.pwd_admin->password);
>> -			if (ret)
>> +			if (ret) {
>> +				mutex_unlock(&tlmi_mutex);
>>  				goto out;
>> +			}
>>  		}
>>  		ret = tlmi_opcode_setting("WmiOpcodePasswordCurrent01", setting->password);
>> -		if (ret)
>> +		if (ret) {
>> +			mutex_unlock(&tlmi_mutex);
>>  			goto out;
>> +		}
>>  		ret = tlmi_opcode_setting("WmiOpcodePasswordNew01", new_pwd);
>> -		if (ret)
>> +		if (ret) {
>> +			mutex_unlock(&tlmi_mutex);
>>  			goto out;
>> +		}
>>  		ret = tlmi_simple_call(LENOVO_OPCODE_IF_GUID, "WmiOpcodePasswordSetUpdate;");
>> +		mutex_unlock(&tlmi_mutex);
>>  	} else {
>>  		/* Format: 'PasswordType,CurrentPw,NewPw,Encoding,KbdLang;' */
>>  		auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s,%s,%s;",
>
>
> I haven't take a really close / good look yet. But at a first glance
> I think it would be cleaner to just take the mutex at the top
> and unlock it after the out label to which all the existing goto-s
> already go ?
>
I did consider that - and it was in my first implementation; but then I got concerned
about if the mutex_unlock could potentially get called without mutex_lock having been 
called beforehand. I couldn't find any good reference as to whether that was safe or not.

I ended up deciding that a few extra brackets and unlock calls wasn't that ugly and was 'safer'...and 
so went that route.

Happy to change it - but do you happen to know if it's safe to call unlock without a lock? If it is then
that implementation is cleaner.

Mark
