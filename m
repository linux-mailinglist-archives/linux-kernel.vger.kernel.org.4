Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A8C67127E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 05:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjAREQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 23:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjAREQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 23:16:09 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D36C54105;
        Tue, 17 Jan 2023 20:16:04 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 373685C018A;
        Tue, 17 Jan 2023 23:16:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 17 Jan 2023 23:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674015361; x=1674101761; bh=K6itsPMSQy
        EXatY96I1BSdmbxr1P254JlFRIOidkA/M=; b=PCB6xQEcu7RnFazfi/dRFk6DZB
        SuqA0AXIwIJdYzXeHY+bH+Sl1LsdGviJY5fbRtjTLsM5uLL+mackW/MvId5Op0Cz
        lAbQSeLdqhLlmMCPrtCB+OhrW6CNgNxjfuEfMEg87wZiNXsYPssKpnM7hhvfAGGr
        MtRDE5jSi295tj8TAlVEkHXavWQ5NUQBIC7QcpVebIA1TM0lvJ7Te/TufMWfP3of
        M1c2Uz6yJykPNga0WAC+d2h2D7VwK5xgL+Y2OILgFd1CbxgRHfmt/Vqh2sMwztlv
        ZlV3Os//SE/0PEASiLrLDbokbxwUGVpFti4GqI3js6BcJtDEblYZfB0qzSuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674015361; x=1674101761; bh=K6itsPMSQyEXatY96I1BSdmbxr1P
        254JlFRIOidkA/M=; b=SNihib3RXg1o+vPGK+yPPW2uEOsOgRAPjL5gJ0QbDDJX
        myTM4snpprbny/QWpA4Yhsh2W7bH5/GWr11Yr3WPva5qvNj9Qr089iDY7N2vBt8i
        hpopcvnjLBzBJV+yZnu4xH7qJK1KUlI1pkvslqo77C/0fDiDKUILylQbEOhK3zIf
        4SAjYBqZQjBviPK9lPDnGqtv/t5Vw5ZRVmcv4sql6/Wz18+hKOYp35Avj24zy88y
        DTEadqo8HBLr/IWIz+r+fwJiXa5vv4rDyMVul4ebv8SHIyBtowW7rTHqeZYIcxfO
        bbQNej8kwixzRo4nAQeRtuj3xtLtUp3H4hOCwqpKrg==
X-ME-Sender: <xms:gHLHYwYTiaO7rR1qOaKDHrRzOCuWdmS0r1yFvekC1LKgZ87Yrw5wBQ>
    <xme:gHLHY7aZ8s131qHgSaH7kh7BZ7kOO-V4B5ImGrF6ev3Zy58dV7-SFINzjZGQcA-Ag
    Zlkw34JkZPCOoXDGDQ>
X-ME-Received: <xmr:gHLHY69OjSWR1eggVmLtGa4NefVoeSbyhOZfFTYzsVeOdug2Nw2L21gWmLo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtjedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihlhgv
    rhcujfhitghkshcuoegtohguvgesthihhhhitghkshdrtghomheqnecuggftrfgrthhtvg
    hrnhepvdehvddttdfhfefhtdfgleehfeeggfdujeeuveekudevkedvgeejtddtfefgleei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghoug
    gvsehthihhihgtkhhsrdgtohhm
X-ME-Proxy: <xmx:gHLHY6omE4IDUKII8bEcJHjMD8Jv3lTVD1ALit9tYjgBcqWLLiD9yQ>
    <xmx:gHLHY7r23-MRpsrwF-6XkfpwD9UYWoDsDFNXNh82eNvXI0fKDBGuiA>
    <xmx:gHLHY4TFZX6VjHKS5mLm8qV4cIzdeuZek7ObXElFquMnVe1LK7m4Qg>
    <xmx:gXLHY8dFGSI8ylqxF-d25v7_MTHN9slxbWQH4Y85pc91IBsG200w9w>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jan 2023 23:15:59 -0500 (EST)
Date:   Tue, 17 Jan 2023 22:15:57 -0600
From:   Tyler Hicks <code@tyhicks.com>
To:     Quanfa Fu <quanfafu@gmail.com>
Cc:     john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [apparmor] [PATCH] apparmor: make aa_set_current_onexec return
 void
Message-ID: <Y8dyfZIAhFfIvVBn@sequoia>
References: <20230114164952.232653-1-quanfafu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230114164952.232653-1-quanfafu@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-15 00:49:52, Quanfa Fu wrote:
> Change the return type to void since it always return 0, and no need
> to do the checking in aa_set_current_onexec.
> 
> Signed-off-by: Quanfa Fu <quanfafu@gmail.com>

This looks like a safe change to me. There's nothing to error check
within aa_set_current_onexec() so returning void is fine.

  Reviewed-by: "Tyler Hicks (Microsoft)" <code@tyhicks.com>

Tyler

> ---
>  security/apparmor/domain.c       | 2 +-
>  security/apparmor/include/task.h | 2 +-
>  security/apparmor/task.c         | 5 +----
>  3 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
> index 6dd3cc5309bf..bbc9c8a87b8e 100644
> --- a/security/apparmor/domain.c
> +++ b/security/apparmor/domain.c
> @@ -1446,7 +1446,7 @@ int aa_change_profile(const char *fqname, int flags)
>  		}
>  
>  		/* full transition will be built in exec path */
> -		error = aa_set_current_onexec(target, stack);
> +		aa_set_current_onexec(target, stack);
>  	}
>  
>  audit:
> diff --git a/security/apparmor/include/task.h b/security/apparmor/include/task.h
> index 13437d62c70f..01717fe432c3 100644
> --- a/security/apparmor/include/task.h
> +++ b/security/apparmor/include/task.h
> @@ -30,7 +30,7 @@ struct aa_task_ctx {
>  };
>  
>  int aa_replace_current_label(struct aa_label *label);
> -int aa_set_current_onexec(struct aa_label *label, bool stack);
> +void aa_set_current_onexec(struct aa_label *label, bool stack);
>  int aa_set_current_hat(struct aa_label *label, u64 token);
>  int aa_restore_previous_label(u64 cookie);
>  struct aa_label *aa_get_task_label(struct task_struct *task);
> diff --git a/security/apparmor/task.c b/security/apparmor/task.c
> index 84d16a29bfcb..5671a716fcd2 100644
> --- a/security/apparmor/task.c
> +++ b/security/apparmor/task.c
> @@ -93,9 +93,8 @@ int aa_replace_current_label(struct aa_label *label)
>   * aa_set_current_onexec - set the tasks change_profile to happen onexec
>   * @label: system label to set at exec  (MAYBE NULL to clear value)
>   * @stack: whether stacking should be done
> - * Returns: 0 or error on failure
>   */
> -int aa_set_current_onexec(struct aa_label *label, bool stack)
> +void aa_set_current_onexec(struct aa_label *label, bool stack)
>  {
>  	struct aa_task_ctx *ctx = task_ctx(current);
>  
> @@ -103,8 +102,6 @@ int aa_set_current_onexec(struct aa_label *label, bool stack)
>  	aa_put_label(ctx->onexec);
>  	ctx->onexec = label;
>  	ctx->token = stack;
> -
> -	return 0;
>  }
>  
>  /**
> -- 
> 2.31.1
> 
> 
