Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106D462CD97
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbiKPWYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbiKPWYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:24:24 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23AB205E7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:24:22 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p21so17757218plr.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uMDsmZ/IUw7ru/rt5ERiFe4h7p8p+vkqkxTomonVF6U=;
        b=Ix1YKinoAhe3dCxswHWHCc1RxI3t4TMEkO/tpVvs6L1nHRzFVWJ1jiWjP+mJCbVw6D
         6cdZn99JYKZn/qPn/eEwTN9HCAqccYjxeioI/WFfk+JSo4sCnlXfSewPaqlEEaXBjLo6
         KH5nh8tZtaLN1LjwEUxtUFA5hkxqW/aIU0kVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMDsmZ/IUw7ru/rt5ERiFe4h7p8p+vkqkxTomonVF6U=;
        b=JB3dYLKQfmM6yjEqFs+RjJNddKxPkTUbc80nGhSCHVtHEdpjFzrQ3laE8g1ZtFdmSC
         R87HErgjYjik7j9VtJi7jfwU8x9YIzrTQ4k3mziTuexQU1sDtghXxX7GMUYaJ2daopN/
         LU3W7E6cjaJ2b1Mi42YxVE6U3QYGyeZaTLYBsgXXDR+QJDFeZ8hbCC4rqHwlQ+XQlMtG
         TG/6MkoU3WG78zQmoFNmRElqRmK6N49r4qzsjH+VbGVF2lIJ059EnMafMkJ9g1W5K/zS
         RvPu6XMQsQRVpE81Wb8FeDqJyOM5tWY88hp8Bxz9DJJMSjxNo0xtb9rsPahhQyLa2W5T
         G2jw==
X-Gm-Message-State: ANoB5pkUZVHoATxBj2fTLetFllN/UBRN+Lfb3OLHr0vbQniqFFLmrnzs
        96r1x43ZGy+KCmC6UiY3wrr/eQ==
X-Google-Smtp-Source: AA0mqf6t/39Bdq//9MoHoTR+aiQxctk6tP7YwkRq4P+AN17UObmeRm1pYSv4/YXRFLoty1P9m9tztw==
X-Received: by 2002:a17:902:7881:b0:186:fe2d:f3cb with SMTP id q1-20020a170902788100b00186fe2df3cbmr10674351pll.132.1668637462348;
        Wed, 16 Nov 2022 14:24:22 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s15-20020aa78bcf000000b0056b3c863950sm11407534pfd.8.2022.11.16.14.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 14:24:21 -0800 (PST)
Date:   Wed, 16 Nov 2022 14:24:21 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ksmbd: replace one-element arrays with
 flexible-array members
Message-ID: <202211161424.642BCD6@keescook>
References: <Y3OxronfaPYv9qGP@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3OxronfaPYv9qGP@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 09:35:10AM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> members in multiple structs in fs/ksmbd/smb_common.h and one in
> fs/ksmbd/smb2pdu.h.
> 
> Important to mention is that doing a build before/after this patch results
> in no binary output differences.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE routines
> on memcpy() and help us make progress towards globally enabling
> -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/242
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
