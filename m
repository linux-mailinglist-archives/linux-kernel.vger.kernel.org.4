Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C352B645045
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 01:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiLGAWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 19:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiLGAWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 19:22:07 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4BA4B98F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 16:22:03 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id p24so15568309plw.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 16:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nZhJ0nE0ZA5jKgN6BxcI03RxJNuTqmjNb4Wo31gNIu8=;
        b=edSzeXolpnKR8kADHnUK5zDys8w7c/jQPn2qCC6ekRSfaXbFtqBwv0XoZxBORA0zTl
         ChqrF6t4xh14HtTCdCUDCNhISCwfi/5unLVxR43QJ9F4+06QN81+fejH9KA76DnF/GcK
         SiQk4RONCboetv53VudXNWYOI9arbADgrCvt1c/z0xcGdj9k7pyXNFrWlMW9ICDAaOey
         otqVF9lR2b5yofFVCsI10JLo3NZU9eqHGlbKkUsvFpHBHXpuvKWVAl6ipTmhgIgp336s
         0G+bm6I69oD22pqtkxqRrnnBcnYLrrlrc7WAm0MqWDyxEbOfQgALUIRQtRyh4v3ucelw
         HZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZhJ0nE0ZA5jKgN6BxcI03RxJNuTqmjNb4Wo31gNIu8=;
        b=LDFLDOzE5rwAaEPCcI/3/oN6cN9Utu5dIKaNYOKjh9JTNMnsZ9THPNdNvPagx6IzU5
         EEZuCOfqWjX31J/dwE3/c7WSFw6gQAgKqatt+fULXwWiBHn2AWRaIkY208A5wm5caRGd
         0sG5Af+lUghSWzmi5GPfQmw8PlWBZmy9B2vFzZqf0gLvOa+wP6BVl7bxpHNWyIPCTCuT
         KBvRBxs5VEHYA1GbgNIdEmjh4YlNrS1qO/wavdwojGeBIPHoVRSLQZMT3FaBfnREFICx
         1vE5JXtV/Nj0OWDdW3alaXicbnzKNAxLsu3PmT8iWoejxBP7y5fBYVEiljYrjhaxk/OG
         a1zg==
X-Gm-Message-State: ANoB5plzTyTQ+cNiAGIpymfaDsmmMUG2qK3E1T/2zz2zcF5tQYiolLxG
        rBhjbUg+gfmNH9rUvPqlOuAmbkex4KsK759LEIeN
X-Google-Smtp-Source: AA0mqf6cvEPgX23p93rWiv3bSVkuS1vJ7qoNkXPGDUutb2voDjMTIY23GZ6EZ4OWKfWGlLTZ9MT0ToagGrwU5HpQmL0=
X-Received: by 2002:a17:902:9892:b0:186:c3b2:56d1 with SMTP id
 s18-20020a170902989200b00186c3b256d1mr73317153plp.15.1670372522573; Tue, 06
 Dec 2022 16:22:02 -0800 (PST)
MIME-Version: 1.0
References: <20221128144240.210110-1-roberto.sassu@huaweicloud.com> <20221128144240.210110-3-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221128144240.210110-3-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 6 Dec 2022 19:21:50 -0500
Message-ID: <CAHC9VhRx=pCcAHMAX+51rpFT+efW7HH=X37YOwUG1tTLxyg=SA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] lsm: Add/fix return values in lsm_hooks.h and fix formatting
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     casey@schaufler-ca.com, omosnace@redhat.com,
        john.johansen@canonical.com, kpsingh@kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 9:43 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Ensure that for non-void LSM hooks there is a description of the return
> values.
>
> Also, replace spaces with tab for indentation, remove empty lines between
> the hook description and the list of parameters, adjust semicolons and add
> the period at the end of the parameter description.
>
> Finally, move the description of gfp parameter of the
> xfrm_policy_alloc_security hook together with the others.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/lsm_hooks.h | 221 ++++++++++++++++++++++++--------------
>  1 file changed, 138 insertions(+), 83 deletions(-)

Thanks Roberto, I've merged this into lsm/next with one small tweak (below).

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index c35e260efd8c..6502a1bea93a 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -677,7 +695,7 @@
>   *     indicates which of the set*uid system calls invoked this hook.  If
>   *     @new is the set of credentials that will be installed.  Modifications
>   *     should be made to this rather than to @current->cred.
> - *     @old is the set of credentials that are being replaces
> + *     @old is the set of credentials that are being replaces.

Might as well change "replaces" to "replaced".  I'll go ahead and fix
that up during the merge.

-- 
paul-moore.com
