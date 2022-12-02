Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F09640FD8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 22:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiLBVR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 16:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbiLBVRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 16:17:22 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1663ED690
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 13:17:21 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so9421648pje.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 13:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CWCytxw2GwvkIRyjMsGItc6tSPW6eIa2hCojgQ491Zo=;
        b=bajllRR0W9wmzd4Nw2CalvIXB2XPAXMdlanCcbLZbvVXt1B1Pl6NTxmK3wxwqtM7kV
         CxHsUVrEXom1EL5rOfhhLf59se6NhxPVGd5NRmcIbnlGtNCpS088grJYnYJ0D+/YJFti
         6DL7+PfEWKWxxy02Ch2OcVaic0rs/mH/oVaMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWCytxw2GwvkIRyjMsGItc6tSPW6eIa2hCojgQ491Zo=;
        b=UQWYb14AAr9t1Y5SpqR75un5+v4+8v0/pOVzxo4y3PahH0YnDslWnwfb8yDIEZ0XGy
         c+5hyXlWx5vlwwbZxwqd5emJ+TU55Qdv6dn2FT/SiS40naolDnW0tticNIY84LQFkSVK
         uDtrKrIKfueICEQvwmIqubrUNx38Bt6OZfiwhahLezkqR8rvIZmGS4p/YezraqOPffDc
         rbTXQnNU406KKN6sTj1Fc87tTTtwl5XDdVhuqDyDnElXS6jOgqawQUfjei6HDD63QbR3
         wx5P8IHcINdz3hHJiIgWqu5c5hP8VQCLT/76jWEqhJ+0h5ct27HF+2ckAJXmwZfMsJAi
         KZ6w==
X-Gm-Message-State: ANoB5pmLgiwetzI8I2cZaauOe2wtYnzQ+XeFETq/VPuN6AiwZ1bdTBbB
        wedx5wxJAGV0VUZJdWLIx4xEgA==
X-Google-Smtp-Source: AA0mqf4yK8k4jj9BxYD7YjYVNBTxiTDeEOIyTukBKrDUunylOzFFlU/7UtMvczkInCXPtJNqJ5N5zw==
X-Received: by 2002:a17:90a:b703:b0:20d:7716:b05f with SMTP id l3-20020a17090ab70300b0020d7716b05fmr38392031pjr.104.1670015841306;
        Fri, 02 Dec 2022 13:17:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f88-20020a17090a28e100b001f94d25bfabsm7005868pjd.28.2022.12.02.13.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 13:17:20 -0800 (PST)
Date:   Fri, 2 Dec 2022 13:17:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jason@zx2c4.com, kuba@kernel.org, tytso@mit.edu, elver@google.com,
        yury.norov@gmail.com, linux@dominikbrodowski.net,
        gregkh@linuxfoundation.org, pmladek@suse.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] random: Include <linux/once.h> in the right header
Message-ID: <202212021317.80F5899CBD@keescook>
References: <212adb212cb0234a7d395daf31b2578b9409d492.1670015476.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <212adb212cb0234a7d395daf31b2578b9409d492.1670015476.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 10:13:36PM +0100, Christophe JAILLET wrote:
> <linux/prandom.h> uses DO_ONCE(). So it should include <linux/once.h>
> directly.
> 
> On the contrary, <linux/random.h> doesn't use functionalities from
> <linux/once.h>, so it should be removed.
> 
> All this is true since commit c0842fbc1b18 ("random32: move the
> pseudo-random 32-bit definitions to prandom.h")
> 
> Move the #include <linux/once.h> in the right file.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
