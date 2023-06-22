Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AAA739386
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjFVAFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjFVAFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:05:43 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381251BD5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:05:16 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b53e1cd0ffso29202475ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687392239; x=1689984239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xq0dkv7azkvedb0KULWF4WuIbSO15dlwApz3MpULLXE=;
        b=AwtajXI8+J6DndfxRUIKzXCkBY8xGz60/k5sDcezJKwVGjGClzxX4hXpgteDe2dQ9h
         4d2HnnsDKY90T8y0a3ww96+rL99eVgWq1UXwqto72GaZgsChKyMxxDHywAY92C/ZdF6T
         X74yKEqM1f90KQ6KGhb8eT7QKMRkG+1RM2z/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687392239; x=1689984239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xq0dkv7azkvedb0KULWF4WuIbSO15dlwApz3MpULLXE=;
        b=Xs98sYxKgf7BjCwhrusP53vLFpdAainE5YgO6sh6NXlIe2hoLh9LKMUpJnZMUsmdVQ
         zoiEfypZaNCONcc74rxycVzQEmLUUVvbsr/TJuVhQAaptXANns8XDh1/zn08d0taj+Hm
         m5RuDcv91Ae60dbIH8RtMUhEP5O9byUiBScIGi9dWnKg4BxnJDuO7ojvCkZqH7rM7aRB
         Y6EZlciC+Ojy7IdAb0x6kKiEXabZAThjZF5oC1YzeS4Ck+tnkKyK0dGnS2S2ncj9xfjE
         4xxUQMg7RkeAEJvnk/sD7hez7mjAP23xwzS3q6NZp1+l87a1ObGJZNFFqAy/FKGPVayL
         RUtg==
X-Gm-Message-State: AC+VfDyxbOW5CcHY+v0yqeK5G22M6gU6nbvutjdMF4170KBSxJzx8ZKU
        5SxrN2U6ZKm+uQbCMkajX8dN8aRj5Mn6Y2Z7mjg=
X-Google-Smtp-Source: ACHHUZ53xmAEhlIo0pgHgTU4ZsSk7xwA4q8JgCHr72rMOhDtXySNGOwMcP4W8fBuxFBj5os20ReXhQ==
X-Received: by 2002:a17:902:e544:b0:1b6:7c9a:3a53 with SMTP id n4-20020a170902e54400b001b67c9a3a53mr6912803plf.67.1687392239478;
        Wed, 21 Jun 2023 17:03:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id lg13-20020a170902fb8d00b0019aeddce6casm4013845plb.205.2023.06.21.17.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 17:03:58 -0700 (PDT)
Date:   Wed, 21 Jun 2023 17:03:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] reiserfs: Replace one-element array with
 flexible-array member
Message-ID: <202306211703.9AC418A@keescook>
References: <ZJN9Kqhcs0ZGET/8@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJN9Kqhcs0ZGET/8@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 04:43:54PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in direntry_uarea structure, and refactor the rest of the code,
> accordingly.
> 
> Worth mentioning is that before these changes, the original implementation
> was returning two-too many bytes in function direntry_create_vi():
> 
> fs/reiserfs/item_ops.c:464:     int size = sizeof(struct direntry_uarea);
> ...
> fs/reiserfs/item_ops.c-490-     size += (dir_u->entry_count * sizeof(short));
> ...
> fs/reiserfs/item_ops.c-517-     return size;
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/290
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
