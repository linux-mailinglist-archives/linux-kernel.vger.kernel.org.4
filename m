Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2607460215B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiJRCoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiJRCnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:43:55 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD5897D7B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:43:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so12694680pjl.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M9bVbKjcMFy6WPGWlEhUD2iI062qF6nYT+c2WdgY1Q8=;
        b=gWp2faJnrCBXaa/EzcdaiT2psb/PKcsg9+6LtqyyYDhruCaHVeQ7fUSv4MDU7UZlmZ
         c2YFULQTK+7bF1Z6M4M7iVyKxo/AQs0mJp2x4jSD2wADIhZyAfCmCLAfyTpAXNo5Am1Y
         n9AWDMbyh9I0/jm5RxLt8JfNAgM6LjGg0lqN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9bVbKjcMFy6WPGWlEhUD2iI062qF6nYT+c2WdgY1Q8=;
        b=Gf1t2Jub0fA7KiUbBEvDed1XSay1xv/44KCzbI5NP9UJBuOvrlr89k7iksaeKpsPkC
         CWPqveTmFQOF0o0bpsMwliqIIfBRhWKlL++IFEWNe8LJbxzd2AY+BanObL0ETV4KpniZ
         +uDDgPMIE+yK6Tfo6Jt3TDarB7aNbi+A7tlMPDeYoBgqzDorX0MlR5P7xLbC7MQBzMNA
         vfJreJAKKzDzjLe2VhlBlNcnOKjanaA/mtIycNcFEP36b9CXnso8giY1MwJYgpV0ZzuZ
         57BkNALLulC5AEIdCbyOjnAM9L3JWVSqduXrhunpXNx6WxwGPFjlaQYFBt15mbLF0KmV
         xK2w==
X-Gm-Message-State: ACrzQf3407UcprocGZxFpsrhodJN+PP9N5ecQSAFVIfPcRGm4YyC9X2L
        /Mq2gvkAjF/zOg8rWcpIZcDmlA==
X-Google-Smtp-Source: AMsMyM47Y1NyZHdqz1//0n1330NKrwJOAGp7q/D/pp97k2bhIugRMB78h4i6pLlpQLE0EUIevEe13w==
X-Received: by 2002:a17:902:d717:b0:17f:6155:e578 with SMTP id w23-20020a170902d71700b0017f6155e578mr717658ply.31.1666061031803;
        Mon, 17 Oct 2022 19:43:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b001811a197797sm7274765pll.194.2022.10.17.19.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:43:51 -0700 (PDT)
Date:   Mon, 17 Oct 2022 19:43:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/6][next] ipw2x00: Remove unnecessary cast to iw_handler
 in ipw_wx_handlers
Message-ID: <202210171943.1B5E6B85@keescook>
References: <cover.1666038048.git.gustavoars@kernel.org>
 <421a4b4673da8fb610850f674d0994ad46bc1ed6.1666038048.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421a4b4673da8fb610850f674d0994ad46bc1ed6.1666038048.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 03:34:48PM -0500, Gustavo A. R. Silva wrote:
> Previous patches have removed the rest of the casts to iw_handler in
> ipw_wx_handlers array definition, and with that multiple
> -Wcast-function-type-strict warnings have been fixed.
> 
> Remove the one cast to iw_handler remaining, which was not removed in
> previous patches because there was no -Wcast-function-type-strict warning
> associated with it.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>  /* Rebase the WE IOCTLs to zero for the handler array */
>  static iw_handler ipw_wx_handlers[] = {
> -	IW_HANDLER(SIOCGIWNAME, (iw_handler)cfg80211_wext_giwname),
> +	IW_HANDLER(SIOCGIWNAME, cfg80211_wext_giwname),
>  	IW_HANDLER(SIOCSIWFREQ, ipw_wx_set_freq),
>  	IW_HANDLER(SIOCGIWFREQ, ipw_wx_get_freq),
>  	IW_HANDLER(SIOCSIWMODE, ipw_wx_set_mode),

I'd just collapse this into the previous cfg80211_wext patch...

-- 
Kees Cook
