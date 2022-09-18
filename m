Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948F15BBF50
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 20:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiIRScH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 14:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIRScE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 14:32:04 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D43216591
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 11:32:03 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id m9so20424570qvv.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 11:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date;
        bh=KSyqvIWwtUotF2HrIRHShso2jQmc/sac+p9JqHe9WDA=;
        b=d947wcsMEr6HobdTV/6itvRrz/5I6ieym/XGLFGQIJypIHn6NHldSxhJLZUiiXVzzK
         G9BxZeOWmFX3QIt33k89YwzFtbaEjJtknqCVNpgRqQX88dj7A1WX7IeSfMkmSnq/V+WX
         q1I1Q/YXpDyN76qmumRkOPqLiL/efFyaXSe+8lpHCZj+CL5RTIcx67eDeCTcODqoHN3e
         g5X08tuBisDNnk6IMPxkyTSVTg70v0C7drIcgxB8PaRo7scvZF1R78bQz5HQPfrVlaLW
         dgEDRF1jIMCyfvnhng2zgTPtGVM/cQwcKzL7g9IhzKrIKXf6ygRq7TIshD/hnU7CaOeN
         5kbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KSyqvIWwtUotF2HrIRHShso2jQmc/sac+p9JqHe9WDA=;
        b=F2LwAJXxytxHptlGjwX9/9Ltxk7Psy8ywFBILq1H2UjRXpdXAhLH1zq6QbFsEZfFLB
         0sb8TXTqaLZqQZ3XMftTGb2K2Zkb3iXl6YiJ9hmT1k04aBQsclqjRCUaPyejBIU6F9Ti
         klO/JuYiYwgGB38/9XMMb/D9iTk6sMmvht0W31t4zOs03AftE/Gb4UWsnwoDCFizziVe
         uj0LpRFbEGJCbUWHuLIjATACRobCQXr185IF24RnoQy0YBTZPgAHIlBVIX80FYsg3gdN
         0gv3PwXVD8wv+FGCy5F0qaPiRdrlt6PEupxCsjLEuhk3Z2u1wSFCM7ALxc8IPF+c1PSn
         K5ww==
X-Gm-Message-State: ACrzQf0TZeRxscmLDLMZNwBxNHF/+u6hx1Ox1UokAszvK2jGp0+vV3B0
        jvtPQ+FDLRAtOGlCv04Nz9g=
X-Google-Smtp-Source: AMsMyM7oR7+1u1eRmRzImyDDRd1B4eRKJmnV6txlbemZowfNWzf8yeU2nAwEV1A4icNwBzme+RijLQ==
X-Received: by 2002:a0c:e00f:0:b0:4ad:40f:4c8a with SMTP id j15-20020a0ce00f000000b004ad040f4c8amr12216406qvk.92.1663525922413;
        Sun, 18 Sep 2022 11:32:02 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id bs37-20020a05620a472500b006cbb8ca04f8sm10879484qkb.40.2022.09.18.11.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 11:32:01 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7FEEB27C0077;
        Sun, 18 Sep 2022 14:32:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 18 Sep 2022 14:32:01 -0400
X-ME-Sender: <xms:IWQnY-XTKqcbar-3M-DekwKKsXnvlSSlXLVs0Px5Fyvr04rOsonSCw>
    <xme:IWQnY6kSrtwqz36RHKR-MFgqufXH2om4OwkA4ztcT1Hjbg5X8og2spkqXWaY-khIS
    H3to2vCMwQUHxuC8Q>
X-ME-Received: <xmr:IWQnYyYgDhRb3MEe0PoPgcByk8FilHjzB4S5zLdBTlFcJK1hEH-c1xpynA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvhedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:IWQnY1VA0Ra7thARItMCs8z6l6Ue7kg_1kT8ySnFKqG8rs9-72xssA>
    <xmx:IWQnY4mGhPdUE1uTfIAD_drHmNXNcaCHOvZcssUStuI7dWmxVaboMg>
    <xmx:IWQnY6f6fsnMmJbPA9njqCeEJIozmWlExYXxiKy8eEGagf-SAp7JAA>
    <xmx:IWQnY3vRgQa5CfU1ObFd0icWMZicWIgZPwu16Iu75lalLpU9BkPguA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Sep 2022 14:32:00 -0400 (EDT)
Date:   Sun, 18 Sep 2022 11:31:46 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lockdep: report name and key when look_up_lock_class()
 got confused
Message-ID: <YydkEtcVc0GtCizz@boqun-archlinux>
References: <55111c45-0f8f-c6f9-640c-6919939b77dd@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55111c45-0f8f-c6f9-640c-6919939b77dd@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 12:01:30AM +0900, Tetsuo Handa wrote:
> Printing this information will be helpful.
> 
>   ------------[ cut here ]------------
>   class->name=slock-AF_INET6 lock->name=l2tp_sock lock->key=l2tp_socket_class
>   WARNING: CPU: 2 PID: 9237 at kernel/locking/lockdep.c:940 look_up_lock_class+0xcc/0x140
>   Modules linked in:
>   CPU: 2 PID: 9237 Comm: a.out Not tainted 6.0.0-rc5-00094-ga335366bad13-dirty #860
>   Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
>   RIP: 0010:look_up_lock_class+0xcc/0x140
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  kernel/locking/lockdep.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 64a13eb56078..a22469dbeeee 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -934,8 +934,10 @@ look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
>  			 * Huh! same key, different name? Did someone trample
>  			 * on some memory? We're most confused.
>  			 */
> -			WARN_ON_ONCE(class->name != lock->name &&
> -				     lock->key != &__lockdep_no_validate__);
> +			WARN_ONCE(class->name != lock->name &&
> +				  lock->key != &__lockdep_no_validate__,
> +				  "class->name=%s lock->name=%s lock->key=%ps\n",
> +				  class->name, lock->name, lock->key);

Maybe more human readable information like:

	  "Looking for class \"%s\" with key %ps, but found a different class \"%s\" with the same key\n"
	  lock->name, lock->key, class->name);

?

Regards,
Boqun

>  			return class;
>  		}
>  	}
> -- 
> 2.34.1
> 
