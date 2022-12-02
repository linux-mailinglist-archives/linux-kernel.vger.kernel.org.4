Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D16640D4E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbiLBSc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiLBScx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:32:53 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF6A37F8E;
        Fri,  2 Dec 2022 10:32:50 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id w15so9069102wrl.9;
        Fri, 02 Dec 2022 10:32:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPMI3+zK71UDugRLfvvjNZoXPuW3L0kj2lPu6Tc7ooM=;
        b=PZ2SBb35YHOXylVqc7daqMUbAJ0UbVHRnpYdm1IFb0CEFehrWf1LCIvNfZTPE0Wv88
         6ker0qcXTdsUgoJwGBapF6au4CY1G5/htzo2T1vFJZfkjYH6QOQ5Ocf3NIaRjywmq3fK
         zMzXcqMomEeoLCFJTYh74l/8LnISBKmTiCg/mehoXmxC0+2ReDOEO/6v7ocXDwgbidOT
         w2nfudOx8vrqIUs96gAKJn++DHs4wj78iDXTgy1r0Dbq5glHfGixbhpaaVmxZmxYADHQ
         twnMYPbFminhMFINCGMuJIxH8518WOyjy8RAuRbtUhX80/N9GMrHSXs5OCTK9mfQzb8G
         2R/A==
X-Gm-Message-State: ANoB5pmVsWfQhFMXf2b+pAOgxQjQshWKVRpJ59bOKFyzUf/cnfwAGIiV
        ADYs+CbxxC71dEv/5b879sU=
X-Google-Smtp-Source: AA0mqf6YqRlHZN2hozxkeZwQrDln42/fBDSISeGrupnXTaC7vfUgHTO/zDo75j9GUPu8GYUhgRPeZg==
X-Received: by 2002:a05:6000:18cd:b0:242:26ed:2d69 with SMTP id w13-20020a05600018cd00b0024226ed2d69mr10428691wrq.3.1670005969130;
        Fri, 02 Dec 2022 10:32:49 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n12-20020a1c720c000000b003c64c186206sm8950653wmc.16.2022.12.02.10.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 10:32:48 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:32:47 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     ojeda@kernel.org
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2 26/28] rust: build_assert: add `build_{error,assert}!`
 macros
Message-ID: <Y4pEzzSs9vO7cvjT@liuwe-devbox-debian-v2>
References: <20221202161502.385525-1-ojeda@kernel.org>
 <20221202161502.385525-27-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202161502.385525-27-ojeda@kernel.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 05:14:57PM +0100, ojeda@kernel.org wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> Add the `build_error!` and `build_assert!` macros which leverage
> the previously introduced `build_error` crate. Do so in a new
> module, called `build_assert`.
> 
> The former fails the build if the code path calling it can possibly
> be executed. The latter asserts that a boolean expression is `true`
> at compile time.
> 
> In particular, `build_assert!` can be used in some contexts where
> `static_assert!` cannot:
> 
>     fn f1<const N: usize>() {
>         static_assert!(N > 1);` // Error.
>         build_assert!(N > 1);   // Build-time check.
>         assert!(N > 1);         // Run-time check.
>     }
> 
>     #[inline]
>     fn f2(n: usize) {
>         static_assert!(n > 1);  // Error.
>         build_assert!(n > 1);   // Build-time check.
>         assert!(n > 1);         // Run-time check.
>     }
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>
> [Reworded, adapted for upstream and applied latest changes]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
