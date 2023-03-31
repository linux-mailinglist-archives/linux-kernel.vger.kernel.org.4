Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5641B6D288D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 21:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjCaTOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 15:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjCaTOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:14:44 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C0023B45;
        Fri, 31 Mar 2023 12:14:35 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 55EBC5C0110;
        Fri, 31 Mar 2023 15:14:34 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Fri, 31 Mar 2023 15:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1680290074; x=1680376474; bh=M8
        yTenHIQIM6QQ0XJZebwpz+kQ/3G+bdcTDWf2j0Cd0=; b=bzsPuPMgWRcZH02xtG
        ecm/PulD5fP2oMz8dHRIEQbO3rTqCSa3G+bE2wZjqjqqbrFFxi3F3tKALnkLjeh0
        p5JI68ZYJorX37BtMhLdEnge+4eWaFz5Om1Hq2QxrIyL95FLcAmF/add9XTwKfDP
        63xqvzRbIWc/4cPYdrw4ZlHHbyo6A81A0ie+u0TuMub8HRgquS9kdm9kg6Eb1+IS
        xKQDfZMfMIPq7R4gkxh3RuF58hEtOqVBwoiL50/Q/g9+/7KqnO5NvrfZ/IAF2Zcu
        P3VpxDqz3QiDTy6luyW6WM+9+DFkXYhn25dWD1yYSa29JR/NX9afXj0XE3UqiUaF
        zKIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680290074; x=1680376474; bh=M8yTenHIQIM6Q
        Q0XJZebwpz+kQ/3G+bdcTDWf2j0Cd0=; b=H5uC/a+mQ2dNbG1BvenIepy65wbBZ
        4arzYYcev44V4NBQtWEdLagwURKHs/DXDK2rwMarOJjbh3lLsO2hrIT9kVOQYLzf
        8OroFXHQPMEG2XuRjr4D898x/3V9xe1KUcXVZUfWFR0RS1l83oMS1ILeY+ex0N65
        ivmvls5DBwFM6m4uf6bAyoleFEQqGTQYTQvYataJ4NHw3ryaPub5J6QSiS80L0Ld
        Et6jPv3BVpThw/YsDWrlCYv87972cbM5ZeGtb3QkYgB8fx3sWjBOtllNjXUjY8x6
        ivOvLloK5ZtTL1r3HRbeBCm8XUK1RkqpBKiCm7+YljCdkYWAPtYzviTUw==
X-ME-Sender: <xms:GTEnZGRROox4F7qT6yUHkhyjXKuwWt0BteaAI8Q984xdCp3y8JLnbw>
    <xme:GTEnZLybGiKXPvKwbAX9aTbwCvwsEMaewa977U9UgiSN1its5X1KK83VYzDhCM9OH
    engHZjVAo3aspnKKqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiuddgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhepieevtdekfedtfefhudfgleegheeiiedvfeff
    keejteduvdeuieejgfejkeduvedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghr
    shhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:GjEnZD2P7_1AbGGk6GS67aHkrfj2A25HzjZ59ucrITos6PqhdadeuQ>
    <xmx:GjEnZCA30JAlBGngowE3yc4pGn_DMLTfRC_it_KfEbHgSzckk_xb8g>
    <xmx:GjEnZPj88YdKzsSYuxDiaFvsZq9dBuAzeSfVTExRY0BFkLf0GfK1Mg>
    <xmx:GjEnZPiMkuGL4vhk3Joxv85dF0yqLhl8MB7RUP8MEATV3eq2Jep7cQ>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E5B2EC60093; Fri, 31 Mar 2023 15:14:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <2233a8da-aaad-4265-b583-f3db27f75667@app.fastmail.com>
In-Reply-To: <20230331180912.38392-1-W_Armin@gmx.de>
References: <20230331180912.38392-1-W_Armin@gmx.de>
Date:   Fri, 31 Mar 2023 15:14:13 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Armin Wolf" <W_Armin@gmx.de>,
        "Mark Pearson" <markpearson@lenovo.com>,
        "Mirsad Goran Todorovac" <mirsad.todorovac@alu.unizg.hr>
Cc:     "Hans de Goede" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        "Greg KH" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: think-lmi: Fix memory leak when showing current
 settings
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Armin

On Fri, Mar 31, 2023, at 2:09 PM, Armin Wolf wrote:
> When retriving a item string with tlmi_setting(), the result has to be
> freed using kfree(). In current_value_show() however, malformed
> item strings are not freed, causing a memory leak.
> Fix this by eliminating the early return responsible for this.
>
> Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> Link: 
> https://lore.kernel.org/platform-driver-x86/01e920bc-5882-ba0c-dd15-868bf0eca0b8@alu.unizg.hr/T/#t
> Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface 
> support on Lenovo platforms")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> Changes in v2:
> - Add Reported-by: and Link: tags
> ---
>  drivers/platform/x86/think-lmi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/think-lmi.c 
> b/drivers/platform/x86/think-lmi.c
> index cc66f7cbccf2..8cafb9d4016c 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -930,10 +930,12 @@ static ssize_t current_value_show(struct kobject 
> *kobj, struct kobj_attribute *a
>  	/* validate and split from `item,value` -> `value` */
>  	value = strpbrk(item, ",");
>  	if (!value || value == item || !strlen(value + 1))
> -		return -EINVAL;
> +		ret = -EINVAL;
> +	else
> +		ret = sysfs_emit(buf, "%s\n", value + 1);
>
> -	ret = sysfs_emit(buf, "%s\n", value + 1);
>  	kfree(item);
> +
>  	return ret;
>  }
>
> --
> 2.30.2

Thanks for doing this - it was on my todo list but you beat me to it.

As a minor note - the Fixes tag should, I think, be
Fixes: 0fdf10e5fc96 ("platform/x86: think-lmi: Split current_value to reflect only the value")

As that's when I believe I introduced the issue.

Mark
