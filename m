Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD03F6D87A7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjDEUFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDEUFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:05:21 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D463A268B;
        Wed,  5 Apr 2023 13:05:18 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-177ca271cb8so39867443fac.2;
        Wed, 05 Apr 2023 13:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680725118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jnLNhgHegwlksR6QMEavxXDZkqPjONybl034vvnWzPc=;
        b=HiJ0NJorOc4gkxW3fGbhTxLMvU+aZPzT/MPyGFj8wPOuLsCcO/9SqqBSgfVMqvBqB2
         a6+pATtsjGGPFiisH3Kk9gLMY11+HzvIBawLyza0rzsXlmh+egc7xkA1XupIddGceoD5
         91dUBp7cuS0XdyhgoOg8lhdvG+DdX9qT7ItPmYJ23vcTW6szhaFNe2R+guxavLVmVXot
         AQv+7teZ9irvTFCLgYp0lbKIRp3OtElcVEZQDTXd0a58aqxbDZKBXZBx1lS3UIjy9Lln
         k5GNslobz/FoshP2bnfdtdvAjNC06L91cOWAN4eC4aHbpX6lb2xNTK9qX6Bt/ZLM0rw1
         gDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680725118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnLNhgHegwlksR6QMEavxXDZkqPjONybl034vvnWzPc=;
        b=NGOSpe94G/PdasXaMDUbVAPkqNGl5edzfWZf/0+murT1jpipFTWPQT3LhERXXFsWrY
         VcpnZYc7cqm6tMILUrWS3ftisN7uPvzz2yECI+s+Bub+TZwlJYp4JzOLOG1rc9aI/rHW
         xeQRZAwn4u9so5gx9ieQtBkHc2QVIc/1ZXqaVt0CWS4vGilp9E4ZBjwSQev3AcxNvbQt
         04Rh8re/d//htqbqEv7rFkeL9wCCMzmQoUrmflRJZDyBwP54zO8eYg+oq9YF5RUHmWZO
         xPii0Nry+kdfi8SyVwlMIElKOh2XsloJUcQ+p7890oLRStp5sDRcN72QMWiDpcYOUGzI
         LLDQ==
X-Gm-Message-State: AAQBX9fyKuAN9dt9YHQMFYRNOM3buo1DY2XhcDOhCdCRIrJPcpEYAEGk
        8pTiygJuSSGTH1vr+P3eVX0=
X-Google-Smtp-Source: AKy350bPX/bQq1ufAW8x/lXcs8DDhXaJi4hxMKxMZ+9Fk8b3+ynSE5RZxYWZGxqhXDKOfIOZ2b5YdA==
X-Received: by 2002:a05:6870:832a:b0:180:7b07:2845 with SMTP id p42-20020a056870832a00b001807b072845mr4111048oae.47.1680725118085;
        Wed, 05 Apr 2023 13:05:18 -0700 (PDT)
Received: from wedsonaf-dev ([189.124.190.154])
        by smtp.gmail.com with ESMTPSA id i18-20020a056830011200b006a0ae1c4263sm7339186otp.48.2023.04.05.13.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 13:05:17 -0700 (PDT)
Date:   Wed, 5 Apr 2023 17:05:10 -0300
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 01/13] rust: sync: introduce `LockClassKey`
Message-ID: <ZC3UdivcMmcZ5MTJ@wedsonaf-dev>
References: <20230405175111.5974-1-wedsonaf@gmail.com>
 <2023040519-crank-quarry-ef26@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023040519-crank-quarry-ef26@gregkh>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 08:00:15PM +0200, Greg KH wrote:
> On Wed, Apr 05, 2023 at 02:50:59PM -0300, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> > 
> > +/// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
> > +#[repr(transparent)]
> > +pub struct LockClassKey(Opaque<bindings::lock_class_key>);
> 
> Will this disappear into "nothing" if lockdep is disabled in the build?
> 
> If not, it should, if so, I couldn't see where that option was, sorry
> for the noise.

Yeah, the C definition of lock_class_key is an empty struct, which is a
zero-sized type. So instances of this type will occupy 0 bytes.

We'll still have the cost of passing pointers from Rust to C of instances of
this type, which we could add an alternate version (dependent on lockdep being
enabled or not) in Rust to avoid, but since it will be optimised away when LTO
is enabled and doesn't add up to much when LTO is disabled, we chose the simpler
option of having a single implementation.
