Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AF466A6E2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 00:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjAMXSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 18:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjAMXSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 18:18:43 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AD9BCB2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 15:18:41 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id g23so9329688plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 15:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RH6/aARHUNUhyFQHu9t9yEl6Nmo/HiToLqjqiJwfA98=;
        b=FK8KWLDkKMzQxAU4w06i36FksP91naWtT/GjskgM4ZTa3afu/yCa75h5VJVCR/UbwQ
         353vMXDT/J+ej0jz8Qk1CjAsJEw8vZ+cPYU/En2i1gbbpotOy+OiR32woEPltauq2I4I
         9tQJR1uKTmUabdbnK90TNLXGg5GvrUuBGTT4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RH6/aARHUNUhyFQHu9t9yEl6Nmo/HiToLqjqiJwfA98=;
        b=gWUu2WuDc6qtAysUDOt5jamZbQo4KvDUWon1JSJhxIn6smE/PZRnE4VBUAT+NMSfk4
         WXzRhtst26waBOCQUziL0LOg6tOfN5r+WEwBNVGBs3SD3SnmAlKc0Tpo99dAvEDPJxS8
         DcRY+P++rWs0j5m6WnQxq4r6csxNub3WZzH9NN982bW4ES5OJekNzaaD5RIyfJ3STC7C
         zNyTfi9DU2Ba/gvh/B0itC6POxdiey4dlkLy1ELUe95S/BYeiCS0aXErA6VPl4xoph8W
         P8tcAT7SsJknz6zsRKBDSvK2sEw/RepIa4jnuYaFXg9mQgyHPKPoOeeAdOPrQ/H3Au3H
         ZFww==
X-Gm-Message-State: AFqh2koFgdnjoMFjaOS4d2jPkcUR5njaSc4T8c4sHZscxI9acj6ZbiBL
        f1hC0vOFUaTaksRH7a/udTfiiS8pfHahahsn
X-Google-Smtp-Source: AMrXdXuggMjjm+hq7HQmcERftDBLU/ITd8+ppErogkqm/zMy/PWzkUo5TeJqrxw8nKX/EmEj+wmFgA==
X-Received: by 2002:a05:6a21:3294:b0:9d:efbe:a122 with SMTP id yt20-20020a056a21329400b0009defbea122mr123564891pzb.50.1673651921400;
        Fri, 13 Jan 2023 15:18:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902780800b0019117164732sm14610196pll.213.2023.01.13.15.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:18:40 -0800 (PST)
Date:   Fri, 13 Jan 2023 15:18:40 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
Subject: Re: [PATCH] gcc-plugins: Fix build for upcoming GCC release
Message-ID: <202301131518.D19579178@keescook>
References: <20230113173033.4380-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113173033.4380-1-palmer@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 09:30:33AM -0800, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> The upcoming GCC release has refactored the gimple plugin interface a
> bit and unless gimple-iterator.h is included before gimple-fold.h I end
> up with a bunch of missing declarations when building the stack
> protector plugin.
> 
> Link: https://inbox.sourceware.org/gcc-patches/CAFiYyc2q%2Bc-0uZb-zAskmR_U%2BM%2BxQfp-W00ZbLErfjx=j5qHGg@mail.gmail.com/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Eek, actually, I've unapplied this. It breaks on GCC 12.

-- 
Kees Cook
