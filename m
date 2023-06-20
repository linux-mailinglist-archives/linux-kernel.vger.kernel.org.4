Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582B773747E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjFTSnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjFTSm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:42:58 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466931735
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 11:42:52 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-668711086f4so2104381b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 11:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687286571; x=1689878571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l+Plwr1huw+Iprthw8GSo9mwUqiU0W0HO5ZTEyvRXxM=;
        b=ky7pjJzMtQWP1zNtVfoPIiocJ5Jjmz3iNOCu22pPgRJ4IKBDArGJn/fwGyzo3UioAR
         He6IkG//7leBnBUqOmTMyScv+sRQmvzUHonIIvdPFuBCHhc9olFgH1HsitbSs7F7lvml
         fT25rEFkDoERwbsxJYyGjK+WRwU/fdTKFC/0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687286571; x=1689878571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+Plwr1huw+Iprthw8GSo9mwUqiU0W0HO5ZTEyvRXxM=;
        b=N4TrooD10fUZ8YimqTXPPSkPMDB+AnsayqXuhcS8lM8prX5JSBPCddYSSKBi4zxvB2
         JOob/xTcJgDCuhvN3DfnzOQH+ZV82LumxndsmMbPq7nLrQh4a/6jnRICOQlgS7t3HsEB
         vzuni+mZGDqkklxLyDEo+NUc+PBo4xbkdCNlMREidsS1PfcSycYDt8pDy3XTWmU202wD
         hd6jgn7LYUIzyOTzRJORkJUMCCSB3DWoeNV7IwzgPLp0d41nrP8EFfjBlqmxfEYoqtVk
         LHl+3JXWvXcuvJb/ADwAjBhhUFe1iy9ObtztLcmXrmYLdTPp6oNW3nBRzEjQ4oykU6Dh
         0Nvg==
X-Gm-Message-State: AC+VfDwMz8Mka9Wd12X6aHIj1QEw8KIONiKD4b01XmZ7Vzp0M1W7zMOu
        4/YTKqpZMDSBnCX9rNzED10yqA==
X-Google-Smtp-Source: ACHHUZ6xyUn85z6Ohu6udB7Pzp4abdWNuTB2aieXWsmYAErGG6uR+KUaoZPZKjpuZDilSEYoGKMxhA==
X-Received: by 2002:a05:6a00:2353:b0:666:b22d:c6e0 with SMTP id j19-20020a056a00235300b00666b22dc6e0mr16497710pfj.11.1687286571456;
        Tue, 20 Jun 2023 11:42:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r23-20020a62e417000000b0063d670ad850sm1662655pfh.92.2023.06.20.11.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 11:42:50 -0700 (PDT)
Date:   Tue, 20 Jun 2023 11:42:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] readdir: Replace one-element arrays with
 flexible-array members
Message-ID: <202306201142.235D900@keescook>
References: <ZJHiPJkNKwxkKz1c@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJHiPJkNKwxkKz1c@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 11:30:36AM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> members in multiple structures.
> 
> Address the following -Wstringop-overflow warnings seen when built
> m68k architecture with m5307c3_defconfig configuration:
> In function '__put_user_fn',
>     inlined from 'fillonedir' at fs/readdir.c:170:2:
> include/asm-generic/uaccess.h:49:35: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
>    49 |                 *(u8 __force *)to = *(u8 *)from;
>       |                 ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
> fs/readdir.c: In function 'fillonedir':
> fs/readdir.c:134:25: note: at offset 1 into destination object 'd_name' of size 1
>   134 |         char            d_name[1];
>       |                         ^~~~~~
> In function '__put_user_fn',
>     inlined from 'filldir' at fs/readdir.c:257:2:
> include/asm-generic/uaccess.h:49:35: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
>    49 |                 *(u8 __force *)to = *(u8 *)from;
>       |                 ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
> fs/readdir.c: In function 'filldir':
> fs/readdir.c:211:25: note: at offset 1 into destination object 'd_name' of size 1
>   211 |         char            d_name[1];
>       |                         ^~~~~~
> 
> This helps with the ongoing efforts to globally enable
> -Wstringop-overflow.
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/312
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks! We're getting closer every day to killing this code pattern
for good. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
