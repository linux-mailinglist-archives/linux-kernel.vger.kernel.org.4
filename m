Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468626BEA31
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 14:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjCQNgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 09:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCQNgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 09:36:31 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF87EC6432;
        Fri, 17 Mar 2023 06:36:23 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 66AEF3200925;
        Fri, 17 Mar 2023 09:36:19 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Fri, 17 Mar 2023 09:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1679060179; x=1679146579; bh=D4qZmi4tQdocreiuKoNZm8CZB/39Lps/+6Z
        IMnudQMM=; b=B6r623IXyrgTpjDsZkajnJEW4MtD+ukaf8X1PFZZWn/2IDBsU1t
        Ng0shyKd63Yyn/K7fpg2WIApi17QXiisi9M/Z3AZE02vCKUPOshWNlLgP3nkfEZL
        22xm0Z73srLJTM1188zBWNLnFjjErfqWBHd82BaQ+UbJs8VXt2Ej+pVew+bf6i2A
        fKUpAGuRaWe1hCGEwEynTEmlaNa9Sj4aQO6J62Y/fUMqyHAb2FrqHuN8RCmGoaqD
        6gWNOoaUvyjlVUu433Hfolv6XzXK8UM5sMTCVOIf6tHgL9mgCWtJPxLyjqCLWbri
        ubaKeZvFBnyoLaRYVUh2pnbxHDFr/cE0BvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679060179; x=1679146579; bh=D4qZmi4tQdocreiuKoNZm8CZB/39Lps/+6Z
        IMnudQMM=; b=gCoIg16TY15EsO4aKj8cieT3M4r3tlvD/vdaxTx+vq3ph3MNZgV
        mBumIa9EZ+J5a3DECqct5JtyFbXV8kG8qxe05Yeik7yPOXtT0FrVl36VN2CvvnqE
        j4yPQ4wRA2Ri02qDVfsEg9BqgsugfV27NrJBBegcHkHy/7WiY89MFlSsKklht4Wr
        TgI5ZfpX3IPNtorEq/tuZ0TP9or5T3kh5MdYBW+WMAmae0IOmvhE41Kc/FO+9/UP
        KpEkVS6+ToM1SHBkTbKgjF2Nsn086186r3QFYxXze6YowqsfgV2hh1Dp5xfveDSA
        w5IjDIaecLcvngNbQFO+C4mk235UhqBqFxw==
X-ME-Sender: <xms:0mwUZFoF7u04NKwkVperOuUl6nO0mT-PTkqsiuVysNFohmkhVLr-dg>
    <xme:0mwUZHo_FWo4g2YeTX6CnC3gleVMLrBSnCugm6EvNmhDydllBILemmltJSWQRwrJG
    3yO3v965_uKFrbf6eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefvddgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhepfeejgedvudegvdekhedvffefjefhuedthfdt
    heehkeffuddvgfetjeegjeeufefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghr
    shhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:0mwUZCP764mDJLFv3R4L3ITC1ecR8rQ-y2w3ZxVZOfqW8lgXchlJNQ>
    <xmx:0mwUZA7MQuDEcLycVN6fjEM-eTGWW4hhxZBvRNBmqQ8BnBjm7Odhiw>
    <xmx:0mwUZE468fwwCif6RK619O6m41t5LEyHW-voV0JMKGio5za5NqqN3A>
    <xmx:02wUZCnSuBoV_bHKeWc0_b8d7BlowF9xcpudRIknq_SrhU0fenEBBg>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8C001C60093; Fri, 17 Mar 2023 09:36:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <d4fcab71-1381-4f71-90c6-8a51b0284d3b@app.fastmail.com>
In-Reply-To: <ce7d4c80-a0cb-0f50-f0b4-1dd2a89fe096@redhat.com>
References: <20230312-think-lmi-status-v1-1-4e9f36322cc4@weissschuh.net>
 <ce7d4c80-a0cb-0f50-f0b4-1dd2a89fe096@redhat.com>
Date:   Fri, 17 Mar 2023 09:33:41 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Hans de Goede" <hdegoede@redhat.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        "Mark Pearson" <markpearson@lenovo.com>,
        "markgross@kernel.org" <markgross@kernel.org>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: think-lmi: Properly interpret return value of
 tlmi_setting
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on a couple of my platforms - all looked good.

Tested-by: mpearson-lenovo@squebb.ca

Mark

On Thu, Mar 16, 2023, at 10:44 AM, Hans de Goede wrote:
> Hi,
>
> On 3/12/23 04:47, Thomas Wei=C3=9Fschuh wrote:
>> The return value of tlmi_settings() is an errorcode, not an acpi_stat=
us.
>>=20
>> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>
> Thank you for your patch, I've applied this patch to my review-hans=20
> branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers=
-x86.git/log/?h=3Dreview-hans
>
> Note it will show up in my review-hans branch once I've pushed my
> local branch there, which might take a while.
>
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.
>
> Regards,
>
> Hans
>
>
>> ---
>>=20
>> Note: This is only compile-tested.
>> ---
>>  drivers/platform/x86/think-lmi.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/=
think-lmi.c
>> index 86b33b74519b..c924e9e4a6a5 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/think-lmi.c
>> @@ -1353,7 +1353,6 @@ static struct tlmi_pwd_setting *tlmi_create_aut=
h(const char *pwd_type,
>> =20
>>  static int tlmi_analyze(void)
>>  {
>> -	acpi_status status;
>>  	int i, ret;
>> =20
>>  	if (wmi_has_guid(LENOVO_SET_BIOS_SETTINGS_GUID) &&
>> @@ -1390,8 +1389,8 @@ static int tlmi_analyze(void)
>>  		char *p;
>> =20
>>  		tlmi_priv.setting[i] =3D NULL;
>> -		status =3D tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
>> -		if (ACPI_FAILURE(status))
>> +		ret =3D tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
>> +		if (ret)
>>  			break;
>>  		if (!item)
>>  			break;
>>=20
>> ---
>> base-commit: 81ff855485a366a391dc3aed3942715e676ed132
>> change-id: 20230312-think-lmi-status-0d76cbe1b7d9
>>=20
>> Best regards,
