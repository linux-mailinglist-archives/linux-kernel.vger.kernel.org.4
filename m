Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892E371715E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbjE3XJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbjE3XJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:09:31 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1F810C
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:09:02 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-53f832298acso1971496a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488141; x=1688080141;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kP6xoLgo+W3UFM9iUDnh50drl/ACCDEWlsOwLhL2LMA=;
        b=FLQRcEvT0dWyqrpaS7g6xY/u1/polSDUHRwQAzjJUnhtqk/GMhEzN1cQmVBBu0kdwY
         LZ15k5n4Hpvj0j/VtlBsQSf7+XtHJGr2pjXMzt9DNcGugQrwFHnSS2H07qwHKuokEqZK
         6kz9wpht26owRmztGH+u5wkgG4AakQ/9xP5fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488141; x=1688080141;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kP6xoLgo+W3UFM9iUDnh50drl/ACCDEWlsOwLhL2LMA=;
        b=lwxIGa938cfLQkphiQwyspoz3xDJrXQ8QKZOHNyVfDNhgT6LrdYCTB2QDvPX/ZvLcj
         7BeB2WnOhgNoVqXR4AQuE5ZVv01+RE00jsyjCjLRlBL3BZYff+bpp55kl92oTVj6+PJJ
         fST71mTl5uvHF8zGE6+/bZJJHjtlLNSFlKr6QH27OmxyK0tiRZYdvmjr7/KAxI4Fbc6H
         55+/WL32bNG3+cMk3MoFPAGBysfzim4HboWoi5ga0vJEm1jjwyV9BL57k45sCos3w3I0
         E8ypkI+fkgZqt5E9pjhIRovjT9xW/TcCSNE48Av+zV5XEe/21hXl0ghrN5Wj1XIKMU5J
         x6Zw==
X-Gm-Message-State: AC+VfDxAGktP3UYfL86MH45n7xPI3iNFdgBalSC6MAcgB9e57dfhq193
        yGLQoGFXSZuZvOWljBtuWRfTfA==
X-Google-Smtp-Source: ACHHUZ6UnvTtQtqkOPBXL5NJ3Vrguvf2WtjDMIRPIFelYGZKYRHwptGMv2c22jtDs055oKWN4TRaww==
X-Received: by 2002:a17:90a:e396:b0:256:f86:fa6e with SMTP id b22-20020a17090ae39600b002560f86fa6emr3417317pjz.48.1685488141455;
        Tue, 30 May 2023 16:09:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bo7-20020a17090b090700b002567501040csm4602346pjb.42.2023.05.30.16.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:09:00 -0700 (PDT)
Date:   Tue, 30 May 2023 16:09:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] firewire: Replace zero-length array with
 flexible-array member
Message-ID: <202305301608.741EEDDD@keescook>
References: <ZHT0V3SpvHyxCv5W@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHT0V3SpvHyxCv5W@work>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 12:52:07PM -0600, Gustavo A. R. Silva wrote:
> Zero-length and one-element arrays are deprecated, and we are moving
> towards adopting C99 flexible-array members, instead.
> 
> Address the following warnings found with GCC-13 and
> -fstrict-flex-arrays=3 enabled:
> sound/firewire/amdtp-stream.c: In function ‘build_it_pkt_header’:
> sound/firewire/amdtp-stream.c:694:17: warning: ‘generate_cip_header’ accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
>   694 |                 generate_cip_header(s, cip_header, data_block_counter, syt);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/firewire/amdtp-stream.c:694:17: note: referencing argument 2 of type ‘__be32[2]’ {aka ‘unsigned int[2]’}
> sound/firewire/amdtp-stream.c:667:13: note: in a call to function ‘generate_cip_header’
>   667 | static void generate_cip_header(struct amdtp_stream *s, __be32 cip_header[2],
>       |             ^~~~~~~~~~~~~~~~~~~
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/21
> Link: https://github.com/KSPP/linux/issues/303
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
