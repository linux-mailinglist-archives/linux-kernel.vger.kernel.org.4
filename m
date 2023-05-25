Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B12711787
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjEYTmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240536AbjEYTmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:42:04 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F14810D3;
        Thu, 25 May 2023 12:41:36 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B9D475C01C0;
        Thu, 25 May 2023 15:40:03 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Thu, 25 May 2023 15:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1685043603; x=1685130003; bh=/H
        gMDkSSMwYHgE33LxVKpXZsmvDoxFZ3zo7+14wlNm4=; b=qApdvS0dJq+1BaYYi4
        osll/bnw3NetQcL79fFyonPcsLW2ho+A8DCCVKPdN44bceIe4hFABpXMsfrXsjcJ
        Fm0PFxRMk3vkOK8g6RNii7NM2RE3mqPV8vU4W9UquwRMo4RHts8jc+ej4eNOHjQi
        LDXOqNnTq5UDIhOpQmxQR/iAUOVbIhll5KNPzQrgUPzXNt5oFe8Tp2vv36udomPW
        vDebhBWlhsJTMga0mnlkYxanoXf/SY+Deu0AO1cdo6V6dx+xLhEiETlrt+fyGrDN
        BVqFooHCYY5UHbyWl2VD3TA5nIGbnNGNF4m9JcsbrS1oye7+wYZbsA2zR1FSzFAn
        owWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685043603; x=1685130003; bh=/HgMDkSSMwYHg
        E33LxVKpXZsmvDoxFZ3zo7+14wlNm4=; b=eEVw6xTCR9jhK0XglC3sQjsn3YCBG
        3l2K5SRTieau8bbafncGQZ2xdtdGSkh0tC9xDUZqoeZN5k5s2vwyr8lZ2H0kexDy
        Vi/wB51J6Oly22cKzLahMvbPavNuKG36j6LpMiBCWs7Sw7AHVeTQVzGVMZLClDU/
        oLhmpmjNOzeUJ2ztDSGkgYtKYlRXKJiZF3eL0/KA8OHy/Tx0SiC3Q+GHT/H4lvYq
        RI7SHflgTTYbrB5QprGZz7J3VucQvwp3dxpDkhoUTy8UG20OhWxQ/4S/pCKOseoY
        wXTTvn0pvMDNG2tsKRD20V2qefaJ2T0vE8SXOpFnDXkIvhGtmHXCB2Alg==
X-ME-Sender: <xms:k7lvZAdlpywTSKYcm3v7lR1OuJa4S1pyFON6yMQ0ebr-E_z7ST_KGA>
    <xme:k7lvZCNqdORWrW4PBo6cDAvXRo-lnZI4c78zIXb4qqv_akZxgxaEDLEzyzaID8i7D
    nuAHG9Xr4PGHzgtnNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejjedgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhepieeufeejieevteduvdekteefledtveffvedu
    hefffeejudefvdeijeegudegkefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgt
    rg
X-ME-Proxy: <xmx:k7lvZBj7kAaNqH_xoebbJVNwN-eU51Sd_lo7DFCPwpzJo8MtCwfPPQ>
    <xmx:k7lvZF_lVZw8kV9Vb1YOOst9gRPV34L_-HCfy610V7mv8QeKlff57w>
    <xmx:k7lvZMvHfc4TvB-RjyjhFT9UFVJB1rE2E8ZjAK9X3mRUypH958vBvA>
    <xmx:k7lvZJWdmsNx8s615i3dS0J7JSbqHxJQoFslojbB1JZIgDxMN15idA>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 67253C60091; Thu, 25 May 2023 15:40:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <17963a3d-996f-4bb8-918e-aadba15be9bc@app.fastmail.com>
In-Reply-To: <20230525193132.3727-3-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20230525193132.3727-1-mpearson-lenovo@squebb.ca>
 <20230525193132.3727-3-mpearson-lenovo@squebb.ca>
Date:   Thu, 25 May 2023 15:39:43 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Hans de Goede" <hdegoede@redhat.com>
Cc:     "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] platform/x86: think-lmi: Correct NVME password handling
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

Hi Hans,

My apologies - I completely forgot to add the v2 tag on this patch series...had a complete brain fart.
I assume I should resend them all - correctly named.

I also have no idea why they showed up out of order...I'm blaming that one on the email server.

Sorry :(

Mark


On Thu, May 25, 2023, at 3:31 PM, Mark Pearson wrote:
> NVME passwords identifier have been standardised across the Lenovo
> systems and now use udrp and adrp (user and admin level) instead of
> unvp and mnvp.
>
> This should apparently be backwards compatible.
>
> Also cleaned up so the index is set to a default of 1 rather than 0
> as this just makes more sense (there is no device 0).
>
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
> Changes in V2: None. Version bumped in series
>
>  drivers/platform/x86/think-lmi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index c7e98fbe7c3d..1c02958035ad 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -456,9 +456,9 @@ static ssize_t new_password_store(struct kobject *kobj,
>  				sprintf(pwd_type, "mhdp%d", setting->index);
>  		} else if (setting == tlmi_priv.pwd_nvme) {
>  			if (setting->level == TLMI_LEVEL_USER)
> -				sprintf(pwd_type, "unvp%d", setting->index);
> +				sprintf(pwd_type, "udrp%d", setting->index);
>  			else
> -				sprintf(pwd_type, "mnvp%d", setting->index);
> +				sprintf(pwd_type, "adrp%d", setting->index);
>  		} else {
>  			sprintf(pwd_type, "%s", setting->pwd_type);
>  		}
> @@ -1524,6 +1524,10 @@ static int tlmi_analyze(void)
>  		if (!tlmi_priv.pwd_nvme)
>  			goto fail_clear_attr;
> 
> +		/* Set default hdd/nvme index to 1 as there is no device 0 */
> +		tlmi_priv.pwd_hdd->index = 1;
> +		tlmi_priv.pwd_nvme->index = 1;
> +
>  		if (tlmi_priv.pwdcfg.core.password_state & TLMI_HDD_PWD) {
>  			/* Check if PWD is configured and set index to first drive found */
>  			if (tlmi_priv.pwdcfg.ext.hdd_user_password ||
> -- 
> 2.40.1
