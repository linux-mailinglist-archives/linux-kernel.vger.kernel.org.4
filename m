Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433285EF02B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbiI2IRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbiI2IRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:17:39 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF35A13E7DE
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:17:38 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so659788pjk.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=uxKV0hmuNi7HP7JM+JV05JaLDwv4wJC8kpd8+KQjoIY=;
        b=oYzJRQvSo6u9Xs9THmztzkJaD4vqr4SD+N0djnhvGyVnbVBjIRn9/CHoxFeB8+JEe9
         QojU3w38taF6uFYOhKp4S7Dc8dJJVTY5i55eYdjq6kZakBLqQYwWSyjxEkEX8MRKBucH
         hv7uQO+rZX07SLqzJoDQcwUBYtZn141ptiFt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=uxKV0hmuNi7HP7JM+JV05JaLDwv4wJC8kpd8+KQjoIY=;
        b=EG8HM3Q+zwyH31wYHQokhALNgbiczcIZ8ztbWRDZnkkWkWzaCUOLsMU7u1ZAlK+zbL
         uK3uK5lvhxJgr4ikCaaJneMENucGZL1rK/AeYP6GKlkpVxhX/W/e8RX3LMNLmgiMhI6/
         +qcOuVMDcvQ2E1sFkN1Ny5yPy3ISbaZv5VNwG2A+2zqk86DfU0gzmloUKqZ7YzhCZHz6
         gGefaiCMVU3iTiSzs9i4QCtapgOyiGKwGCJut03CEV5SVhjDWj8kfEoOacrwCg9aK84v
         G1RFmYVbPk2LkRK74qGUxCjrNNbWxvMAN3EG5L3OefoXj0XpUfY7TOByb1GLmT5dUbvP
         92/g==
X-Gm-Message-State: ACrzQf2Z1VtLcfqoYi1stBtqPc3bHkn1Mi5WvgLQsPM56Gqg3jBDtsbW
        X3e7aKXFKmcYtsdUsCRMg7+mLg==
X-Google-Smtp-Source: AMsMyM5yoAwH1Lbl8y4hHePaW6bZtsQ/MSFrp6Jcy1LA9hrzzFyz5A7Q7Y+noemhCpHrqWSfzhCrNw==
X-Received: by 2002:a17:90b:3144:b0:202:e2cd:2d2a with SMTP id ip4-20020a17090b314400b00202e2cd2d2amr2381272pjb.39.1664439458453;
        Thu, 29 Sep 2022 01:17:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090322d000b0016d8d277c02sm5330020plg.25.2022.09.29.01.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 01:17:37 -0700 (PDT)
Date:   Thu, 29 Sep 2022 01:17:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sachin Sant <sachinp@linux.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-mm@kvack.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [powerpc] Build failure include/linux/compiler_types.h
 __alloc_size__ (next-20220928)
Message-ID: <202209290116.AF9A13DF@keescook>
References: <E3F43AE3-E1AA-4992-9308-C0E790478445@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E3F43AE3-E1AA-4992-9308-C0E790478445@linux.ibm.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 11:49:28AM +0530, Sachin Sant wrote:
> Linux-next  6.0.0-rc7-next-20220928 fails to build on powerpc with
> following error:
> 
> make -j 17 -s && make modules_install && make install
> In file included from <command-line>:
> ./include/linux/percpu.h: In function '__alloc_reserved_percpu':
> ././include/linux/compiler_types.h:279:30: error: expected declaration specifiers before '__alloc_size__'
>  #define __alloc_size(x, ...) __alloc_size__(x, ## __VA_ARGS__) __malloc
>                               ^~~~~~~~~~~~~~

Apologies for the breakage! This should be fixed by:

https://lore.kernel.org/lkml/20220929081642.1932200-1-keescook@chromium.org

-- 
Kees Cook
