Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976D56EB232
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 21:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbjDUTU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 15:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjDUTU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:20:26 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6326A1BC3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:20:24 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b5c4c76aaso1934838b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682104824; x=1684696824;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q+NQzP2tJ7rAQ8ZwhNRj+/Iv7lweoLqnetptjsQBlDk=;
        b=nIpyEKKUOGJ/119aoueRuScXCTc1Ig3nO8YmaHHwiRTMRqBiPZzNWSsBu5m27QLZ+t
         QU8wvks/tNZc7eRtHh97LpNaKGfuFFGy0I2f0sDCz8b3yhLQM8r4cqWbbW/HiA0ie1od
         Vg2ssWxKLz/GQej/zBRy6yfRZkIxyU4TsBdCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682104824; x=1684696824;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+NQzP2tJ7rAQ8ZwhNRj+/Iv7lweoLqnetptjsQBlDk=;
        b=hJa95w5ffxSuHkzrjtWFzJUr+53JxKFlhYV/pjp6OtQkgs4VCDnO6E7+YLsrf14O18
         JCzZLlaGGAtdoIl9uiyOAAE+dDpA4FRp72eLKQqZh6lG9AeFGEOocp+sfZeTqsNXS7NA
         dGt1b4WBgBvm4tH5YeSqmCHfHdSmTXrRK0DdpDOyKjPnYvLsHOYWcu32J5d6RAYbFCRU
         5Yb9su5RcY+qDFa3JnNQZnByXwmrxKc2lwyL8lkBf9K4XPj6svEgONuxAtA7h3ir9Bza
         vSvpQqLQHuVNmGAExgQXrPEyYAfj9W6vYQ/BgV2sq9bCKSxSMSwPxgwErqxwFsek7lSV
         Qidg==
X-Gm-Message-State: AAQBX9cV7m3suXyWVV7WraM8jfwbDiaJ/g1+OupmIBM8hy/PmFjAvwfs
        2dUg3GNiA5xIr7F1YuskKT2dlg==
X-Google-Smtp-Source: AKy350bP6V0MjdL2cITxoqg6I10ZLQCL7sM+r8X09UUQI7wENI6RKuAcbpAT25p79w4V1zQZm426Xg==
X-Received: by 2002:a05:6a00:1589:b0:63d:3a99:f9e0 with SMTP id u9-20020a056a00158900b0063d3a99f9e0mr7934979pfk.28.1682104823765;
        Fri, 21 Apr 2023 12:20:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u25-20020a62d459000000b0063d3801d196sm3278628pfl.23.2023.04.21.12.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:20:23 -0700 (PDT)
Message-ID: <6442e1f7.620a0220.b44ce.7a42@mx.google.com>
X-Google-Original-Message-ID: <202304211216.@keescook>
Date:   Fri, 21 Apr 2023 12:20:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v9 02/11] LSM: Maintain a table of LSM attribute data
References: <20230421174259.2458-1-casey@schaufler-ca.com>
 <20230421174259.2458-3-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421174259.2458-3-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 10:42:50AM -0700, Casey Schaufler wrote:
> As LSMs are registered add their lsm_id pointers to a table.
> This will be used later for attribute reporting.
> 
> Determine the number of possible security modules based on
> their respective CONFIG options. This allows the number to be
> known at build time. This allows data structures and tables
> to use the constant.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Nit below...

> [...]
> @@ -513,6 +531,15 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  {
>  	int i;
>  
> +	if (lsm_active_cnt >= LSM_COUNT)
> +		panic("%s Too many LSMs registered.\n", __func__);
> +	/*
> +	 * A security module may call security_add_hooks() more
> +	 * than once. Landlock is one such case.
> +	 */
> +	if (lsm_active_cnt == 0 || lsm_idlist[lsm_active_cnt - 1] != lsmid)
> +		lsm_idlist[lsm_active_cnt++] = lsmid;
> +

I find this logic hard to parse. I think this might be better, since
lsm_idlist will be entirely initialized to LSM_UNDEF, yes?

	/*
	 * A security module may call security_add_hooks() more
	 * than once during initialization, and LSM initialization
	 * is serialized. Landlock is one such case.
	 */
	if (lsm_idlist[lsm_active_cnt] != lsmid)
		lsm_idlist[lsm_active_cnt++] = lsmid;


-- 
Kees Cook
