Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541C7607BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiJUQLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiJUQLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:11:13 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C90D254367
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:11:13 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13b103a3e5dso4134833fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0WJj/Xm68bjTUQLzpFK8ciTVE6HKPCLS1ySBCZyagU=;
        b=m/whR+PkvunDysIgKB+mtr6JlxgiRlZZrPeqhbPPgzbSGfPJEdfJEGXVvmP8dO0g+o
         HSPFO7eu0/dAPyubEn7gBnYmrpuZkwVL/eFPiSeoLCUeX4QVDY19kyFYwql/MsTeYlzR
         AJG94aCUoyJ/bc8EIfvMD9cMcF5/gUCMnubwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0WJj/Xm68bjTUQLzpFK8ciTVE6HKPCLS1ySBCZyagU=;
        b=OtwVYFlvBNx+1O1aGtJME6d4ghUe4cQ8lsUO1ft8i0R0XHFYlUpFBzwlQR4hr2pRPa
         B0zrZFzLzowJkvbYzs90Kmnqu+3V/TYELli4mmBzBA6DwLsw8A5/+nbHYV+cpTeSp5ZR
         GCYUuxKAIr/TLtbwRsqfZwlpUaFc71owCgqsOEARX1Ms6CgFbW5nirwtz6bIFXywS+2X
         V50lwtBD09RB2t6P26xCb/mX9oNXVVIvJPZeCDztlRBoGyZsTiRC2HKaLMbA4PiOip6A
         B5gJM5HMXfGrEHbOBjcmNRlhIxLRihwyQkVcOye/XKGust6XfhZATA2361dJr9xcXW6X
         ed2Q==
X-Gm-Message-State: ACrzQf2BOuL5BnvCqtie+COZnl/GtyfsXGnmHq+Qm8TyVgDjWuu7joXL
        WsPTdb3inOwUDDzxDpIU5MoG0DiSCG6HpA==
X-Google-Smtp-Source: AMsMyM5Ped1GymghFX3fXxoQdhGpI06mVB4mjwiuR1szQNHQ/Kth5nOp3MCuU9p3NfrBvmu5zmRnHA==
X-Received: by 2002:a17:90b:4b4b:b0:20a:926f:3c2e with SMTP id mi11-20020a17090b4b4b00b0020a926f3c2emr22444744pjb.87.1666368662046;
        Fri, 21 Oct 2022 09:11:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a9-20020a1709027e4900b00176ea6ce0efsm14888186pln.109.2022.10.21.09.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:11:01 -0700 (PDT)
Date:   Fri, 21 Oct 2022 09:11:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Dan Li <ashimida@linux.alibaba.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] compiler-gcc: be consistent with underscores use for
 `no_sanitize`
Message-ID: <202210210910.5085358FBC@keescook>
References: <20221021115956.9947-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021115956.9947-1-ojeda@kernel.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 01:59:52PM +0200, Miguel Ojeda wrote:
> Other macros that define shorthands for attributes in e.g.
> `compiler_attributes.h` and elsewhere use underscores.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
