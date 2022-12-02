Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3251A640D45
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbiLBSbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbiLBSbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:31:32 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94517E988D;
        Fri,  2 Dec 2022 10:31:31 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id m19so4136133wms.5;
        Fri, 02 Dec 2022 10:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeBhZUYHhg3CPbWZDIA1bo33xmoBi75eG+8d6a4d4JY=;
        b=Y/oq5S7OnRLJDxbRbTYzisUArF80/DfLBpchOwLA6Mv560zDfYg++CZpyQpW0N8f+y
         KDiHkI6OwZJCS+wwlZpUE18WdmOuBLMuXq8S0hDvtgu+LyVCdXfA5WeL5Hm6uH9WnMoy
         sos2rOZ7w1XtpyZKa0uaK70iJFbom1x2lgS1X29RCore6e/tNos3ZFEtDuLQnBjZxAvq
         nKllZsn0ykwlmBZLZB7Z9/9hUzAzHdqBJktNNQz3g8+hlrZpdSiXjJ5Gxq4lIXDkFFZ7
         nu8U6OEeGEl8gxLI7Oca7P0PuA5zTdfr15eYsYkMBvel3/A8NDSsJUuZHs3HoLACu3Qv
         PKHg==
X-Gm-Message-State: ANoB5pkZU8Z/C9St++MrNEnqiqqkw4z0XajERrcjpWpHz1uhslbFf1hC
        GePFLSUpafR2FoFyZjB/T8o=
X-Google-Smtp-Source: AA0mqf7YWKGvbFv+NOe0n2Yc1e6eeWilHkTtWIurM/uPaNtOOJy7RvYMSBoV4Ge/JPFs2Cz6gtSnAg==
X-Received: by 2002:a05:600c:1e89:b0:3d0:7d89:225a with SMTP id be9-20020a05600c1e8900b003d07d89225amr6390068wmb.167.1670005890235;
        Fri, 02 Dec 2022 10:31:30 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id i1-20020adfaac1000000b002238ea5750csm9459625wrc.72.2022.12.02.10.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 10:31:29 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:31:27 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     ojeda@kernel.org
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2 25/28] rust: add `build_error` crate
Message-ID: <Y4pEf731ylXUkzhF@liuwe-devbox-debian-v2>
References: <20221202161502.385525-1-ojeda@kernel.org>
 <20221202161502.385525-26-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202161502.385525-26-ojeda@kernel.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 05:14:56PM +0100, ojeda@kernel.org wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> The `build_error` crate provides a function `build_error` which
> will panic at compile-time if executed in const context and,
> by default, will cause a build error if not executed at compile
> time and the optimizer does not optimise away the call.
> 
> The `CONFIG_RUST_BUILD_ASSERT_ALLOW` kernel option allows to
> relax the default build failure and convert it to a runtime
> check. If the runtime check fails, `panic!` will be called.
> 
> Its functionality will be exposed to users as a couple macros in
> the `kernel` crate in the following patch, thus some documentation
> here refers to them for simplicity.
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>
> [Reworded, adapted for upstream and applied latest changes]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
