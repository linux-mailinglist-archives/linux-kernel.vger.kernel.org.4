Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4291071718F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjE3XVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbjE3XVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:21:02 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00447129
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:20:55 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-25669acf1b0so2862342a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488855; x=1688080855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kJ6a9RtH2F2C5B3qsSQMBizrWtQVR2WGvbW6bWVaocA=;
        b=gcrM0wofjm3uTk2EqNaBReNhxZhQOm2fsXojumGzkhhMcX5YZeWAyb/hi7Z/f1B5/j
         VPApEkU3QnJHTT+Kn3Dj9YwPgoDLxMLJi5TIBEt6rbTjGjKhdaQjQRV0sFxry15VZl3u
         mksosL1lOmQAyskBHC3HRUpxVXByfu0Bsa0Uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488855; x=1688080855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJ6a9RtH2F2C5B3qsSQMBizrWtQVR2WGvbW6bWVaocA=;
        b=MPVT6ZW1aV0cTxT5l5BlvgVtvkPLjX7sFXZqTZ65b22l5rqJQW/A67dxZTLRdtAg0R
         EGIKBsFWMgADXnGuDeteeqy6MJZIvbe2tWvKHCNqhwzy6yoGB/0sjMTD/d7Th6ch9t46
         TN1wscJrIBy/i4p/Uhd9whh+GnUMhe8HsRBV/F6zVVs69Dxxq0pi7nQDrCeAFai/i+rW
         sDSnJ8bjID0ujyN0YyaZaDy/J2KyNx9yWtD9FbGGkBDmILumME1rgRZalVS+uoiPz0vf
         ldcNbSsPa++49BvUXCsugkjrPLiitnPxGfIoHdg9sNd/c1u2l8fjWFPcSNikVARq4k3m
         L/EQ==
X-Gm-Message-State: AC+VfDwrlrXgi9Y+uh+Exvf9YF7Vu532FlWtxDUnhR29uQhDpOdZmwBq
        J06nvxEEUv3cGH/jueh8x9541g==
X-Google-Smtp-Source: ACHHUZ5NIdQACilyOEd6vOtwPBrrplnflmqMi/bQOXKPE2KJZEl3cT2WLDvF40ib0I/zSXsic8GeMw==
X-Received: by 2002:a17:90a:6c64:b0:247:2874:a6a6 with SMTP id x91-20020a17090a6c6400b002472874a6a6mr3936156pjj.2.1685488855367;
        Tue, 30 May 2023 16:20:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o2-20020a17090a678200b0023fcece8067sm3510889pjj.2.2023.05.30.16.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:20:54 -0700 (PDT)
Date:   Tue, 30 May 2023 16:20:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Dinh Nguyen <dinguyen@kernel.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nios2: Replace all non-returning strlcpy with strscpy
Message-ID: <202305301620.346CC541@keescook>
References: <20230530162358.984149-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530162358.984149-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 04:23:58PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
