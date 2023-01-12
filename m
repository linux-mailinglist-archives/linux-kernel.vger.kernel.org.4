Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E26966874A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjALWuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240570AbjALWuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:50:04 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3595E64F
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:50:03 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id y1so21687030plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YeyAehJ1+RpbbyKeSeI182mikP/hWhpWtc+icM9rV9Q=;
        b=LRhcyfx/gJrJ613xcnpLoHxo/rRB8wFX8vEVKquTu7z1/Lg1HGxSwA8bxtV7XODtji
         stKDzRYqwx6OPVhHfj5j369tTog4pVrAkwnMy0+BF17inAH4JWw63ZWuDb97/Kf6zk9i
         U9KLt/YedDyjUP8Ut+itFQaAcMhcTYUR+9Uks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeyAehJ1+RpbbyKeSeI182mikP/hWhpWtc+icM9rV9Q=;
        b=fsborCWviLavKG1j+s7Mje8we2iUcPyfLJF7aDFHqPyql5HY7hjRAKIH1mFuKLMVvS
         /drLtno0qGaNzn54Ga/9y+smM7rw3Pddn/y+VVkqq+dYxgwmDwPtGREHuzvyRcu4x6rQ
         5eZ2pKeHor7lJBOd+nxSFQpudK73WNH9JAYMIj00l6byklqYZbcEO0Mnre0ZLV0kl78P
         gVzjwABoFIxXwPfx6/qk9KhT6bDL6s8hvW+4DTfOKeOvnW1hKptoQWSbI9JDa4tVJgYL
         1MXnLikbJE2R6OMYqIVUpnR91mOpRuEG0urS6/6c8PIIWOM/i7HO11/BUDDuujZTbG/i
         KCuw==
X-Gm-Message-State: AFqh2kra0t4qKm0Fus+gYzcH9l2+RYQR9hOiW7UWXa2Oam3CvmEsxaut
        VpV/2wB5s5a9ccUMP92g6ukYjC3wP1K7sM9Q
X-Google-Smtp-Source: AMrXdXscOB5DMopj230A+iRjb+JA0VFUMffsTa29UCCUsv1241CuexvhrVtH+xb/y6XgpLjfsB7JiA==
X-Received: by 2002:a17:902:ab11:b0:191:33e2:452d with SMTP id ik17-20020a170902ab1100b0019133e2452dmr71359028plb.24.1673563803297;
        Thu, 12 Jan 2023 14:50:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902dac100b0019141c79b1dsm12673819plx.254.2023.01.12.14.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:50:02 -0800 (PST)
Date:   Thu, 12 Jan 2023 14:50:02 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] x86/fpu: Replace zero-length array with
 flexible-array member
Message-ID: <202301121450.E16A538D9@keescook>
References: <Y7zCFpa2XNs/o9YQ@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7zCFpa2XNs/o9YQ@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 07:40:38PM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated[1] and we are moving towards
> adopting C99 flexible-array members instead. So, replace zero-length
> array declaration in struct xregs_state with flex-array member.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [2].
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
