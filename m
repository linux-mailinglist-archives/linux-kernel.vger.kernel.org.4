Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527A46685AA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240729AbjALVlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240392AbjALVkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:40:39 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F15F6087C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:32:14 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id cx21-20020a17090afd9500b00228f2ecc6dbso119187pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oYWg76MlT465qYm5zxxJzeCoJpElzxW7j04ayS6Gkfo=;
        b=IxiMGx32/xjZAc1vwPbmnRqZseYpKs2kN4m4itm5HGK3gKjlx8IhN5F2dfpUDi3iV7
         iSx3o+T6ODNt+TyxQ0rvSPsx3EzwOynXeDSBh3AphQQKVyyo6PMuFaGmE2jXLEODpxG8
         B2NzXkP7cHc5a2GZHWMAemd7B0Ne7wvlMFizo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYWg76MlT465qYm5zxxJzeCoJpElzxW7j04ayS6Gkfo=;
        b=Q9UFjwQ15PLeR3YAYxpBJlp6tiedzsaHhJSjgSe892kL5AqjrEvLI3m1Q74yUkeJAM
         XHz95uhWiWM9M2LxxBjC7uOWFfPBYaimnZOL5/kxxZx7nlpXJTXgH8rqNp96WBdQV+pv
         Q/q15GOUKD/Q0bqIB09CemIqQQcdGVAJPj4BWbjDmNyYuk/JRO1tbVrlvhwWo7LeS3E/
         S9M2sT3PUvdQgvvbsJZ04d7+n5n8CSyvIWOjCtvbWe054VtTrndv0RbBm2iZZdsKWZnA
         KC0HcgnEPLr5m+akFaglfh8AvpyBtldDLz3lsip5mBDK3/Gs/mYkU4saWsRe4UU61nUj
         yOtQ==
X-Gm-Message-State: AFqh2kp3a9wLiJe+VfIFwStpcE7OKcvjJ0/HC4FrBe6UTQgHJhtDAd2M
        coOsUXjweG/5E6pUouQXIMGDfQ==
X-Google-Smtp-Source: AMrXdXtjOihZr3A+kApmyR1KJIPIcvqN7dphaaqD7LoNbiTIX8M4rVl8rzsIWN1VGtw5eAq6PNm0Og==
X-Received: by 2002:a17:90a:65c5:b0:226:5900:f2f4 with SMTP id i5-20020a17090a65c500b002265900f2f4mr9009536pjs.4.1673559133836;
        Thu, 12 Jan 2023 13:32:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l15-20020a17090a72cf00b002192529a692sm13272431pjk.9.2023.01.12.13.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 13:32:13 -0800 (PST)
Date:   Thu, 12 Jan 2023 13:32:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sohil Mehta <sohil.mehta@intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/vsyscall: Fix documentation to reflect the default
 mode
Message-ID: <202301121332.1305BA2A@keescook>
References: <20230111193211.1987047-1-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111193211.1987047-1-sohil.mehta@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 07:32:11PM +0000, Sohil Mehta wrote:
> The default vsyscall mode has been updated from emulate to xonly for a
> while. Update the kernel-parameters doc to reflect that.
> 
> Fixes: 625b7b7f79c6 ("x86/vsyscall: Change the default vsyscall mode to xonly")
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
