Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EE76C89F5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 02:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjCYBUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 21:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjCYBUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 21:20:46 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C7A1BAD3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 18:20:30 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id o11so3438288ple.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 18:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679707227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xRU59Fp1LPCf2L9u79Fxev0jeYDDSl0nAnmtEcwYt0k=;
        b=Gblh5P6wOi+3Vk7yht26IljnWQaGUVcIHVDJfTW5QQIE2S7Jc+welPvGIGUK3Arv7o
         lRY6zU6X6eS/dJDuSm83CcsKMEXtCK+DpamswOkkiZ+SUhF2+F2vknhjXPThDKb3WovF
         EP1sjpoYg2ry6q03v/LrZy3x3hnv+tNZ03CkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679707227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRU59Fp1LPCf2L9u79Fxev0jeYDDSl0nAnmtEcwYt0k=;
        b=MFT4cu8QA78D/dxBnT8NrnOuRlcbnMA80pN5raQrFIM692YqVMB7GGesBf4icH4VAc
         wmKmq0WOrQWwoYBLHPIt5PVLKkFr/wgN1y9NCZVy5BddreiQtLf5E2H28lX/IHDzwPsY
         BD6MaXvuWp9VX+YOVQ+oYtucRfxYk0I+T6MEwl2BYI89+pbS/n+w+hpL2xjArI64axen
         qwR65y0daV5foVbH2t7dvM46YIwc4dwIt2pCmogOMuOR0mk1CjYvNdAAKIEby8FrVx7s
         ve3N+VRPj6iHvkZ44VTnJK6z/ZLNXMX7Nr2DeEb5Vv2QHHTszhfqySQK5Igui5Cunwm3
         ua3g==
X-Gm-Message-State: AAQBX9fSAtikNHdpSMLFzzDvdhjQpbdLG9gDaNOow4a26TkXfLM4XapP
        CDQSaby0uZcVM0YAbl8br9y6zA==
X-Google-Smtp-Source: AKy350ZzS7Y6pc1qWAFsV1Kr4heRJSNrsm+/JeoaH9QVVJn4GXIZCCUZPXrtKpXfaSfy+Z6kX9PdTQ==
X-Received: by 2002:a17:90b:38cd:b0:234:67ef:304b with SMTP id nn13-20020a17090b38cd00b0023467ef304bmr5082656pjb.37.1679707227397;
        Fri, 24 Mar 2023 18:20:27 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id n3-20020a654503000000b004fb997a0bd8sm13917727pgq.30.2023.03.24.18.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 18:20:26 -0700 (PDT)
Date:   Sat, 25 Mar 2023 10:20:22 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Tom Rix <trix@redhat.com>
Cc:     linkinjeon@kernel.org, sfrench@samba.org, senozhatsky@chromium.org,
        tom@talpey.com, nathan@kernel.org, ndesaulniers@google.com,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] ksmbd: remove unused is_char_allowed function
Message-ID: <20230325012022.GH3271889@google.com>
References: <20230324173056.2652725-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324173056.2652725-1-trix@redhat.com>
X-Spam-Status: No, score=2.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/03/24 13:30), Tom Rix wrote:
> 
> clang with W=1 reports
> fs/ksmbd/unicode.c:122:19: error: unused function
>   'is_char_allowed' [-Werror,-Wunused-function]
> static inline int is_char_allowed(char *ch)
>                   ^
> This function is not used so remove it.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

We have a copy of that function in fs/ksmbd/misc.c.
