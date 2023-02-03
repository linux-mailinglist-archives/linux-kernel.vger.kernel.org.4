Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D926689380
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjBCJVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjBCJUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:20:50 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F3D95D24;
        Fri,  3 Feb 2023 01:19:47 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id jh15so4629913plb.8;
        Fri, 03 Feb 2023 01:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B/K5nwMA8gvVa10PeMZSw77e4QnQnF6l8GwdE0FA3W4=;
        b=luBjfbvqSaQ7qCAtGVFiqUWy8FH5HsgUOP8afdGlDZAq+nE0K4nyTcB+gtX8x2nCs5
         /NBt9Kzh0EJeREIj7zfZ64jlel4aobpLlESPqAxQKaU5zr3heb1V4UciwZcbGrmlkI/a
         TSIZRo51WZ77BufXUtTZ1FACt665zphwXLclJHSripRXRenn9DRJW5eHsECYU7DMafUI
         6F8ln1JwqcmNqtKmDeC/vOcT+SnT7ukwgEuUoe40aStBjojhXq6gvkvBiHySWwLHq4y5
         78hRysrNaQXBLo8eUfi3g8pjwHiX+YfCnuKvxSv1x+EY021w5mbIXJrwf/xRmxaI6gJq
         LOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/K5nwMA8gvVa10PeMZSw77e4QnQnF6l8GwdE0FA3W4=;
        b=Da8j3e6JN3MRkbEHGqohYbhRSEAc87Kqhep5JaMNsH5z2s7pkxPlKngFKFovvbbesU
         UDZe3j6MmrGVV2lrYNZ3vAPGh8TMgliHFfGeoTbkMWTJX/FC0a73ConFxgxS7u9fbTiP
         TeoaNWjsVdJm+zKeVCArJFuhztshlStSkn57bxeORVdM4l/vgl1VQM+BFVcX+U9/dnr/
         I28+2xKL0eE/ZIRRVB3OxJsyUeXavgncAkBT0RE8Chlb2NXKKf48umaSDyCr+IEXhRmm
         ABGytmLuBe4LMdX8THabEf6FPeu2Vd5tW2nyscrIa7GEzGIQGaBt47i62kkDrmkKeqwR
         1PCw==
X-Gm-Message-State: AO0yUKXnPKTPiJYBv2qopAl/WNvI0W0Kx1Jj+WEs4fGlmgaWTyLXfYXE
        uNrh7eCL878z7A2oHVIhOcI=
X-Google-Smtp-Source: AK7set//VeLBQllO4lSM/GQi7Dl1r/947yKqKjU+0e76B/DeM4FjHh/tIjcVf6py4FWhAU1xPv7NZA==
X-Received: by 2002:a17:902:f2d4:b0:197:8f72:aed8 with SMTP id h20-20020a170902f2d400b001978f72aed8mr7116572plc.5.1675415986633;
        Fri, 03 Feb 2023 01:19:46 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-91.three.co.id. [180.214.233.91])
        by smtp.gmail.com with ESMTPSA id z3-20020a170902ee0300b001960441f604sm1084907plb.277.2023.02.03.01.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 01:19:46 -0800 (PST)
Message-ID: <7370dc9a-8a14-4c38-028e-f44cd099dbaf@gmail.com>
Date:   Fri, 3 Feb 2023 16:19:41 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] tracing/histogram: Wrap remaining shell snippets in code
 blocks
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kernel test robot <lkp@intel.com>
References: <202301290253.LU5yIxcJ-lkp@intel.com>
 <20230129031402.47420-1-bagasdotme@gmail.com> <871qn8vsro.fsf@meer.lwn.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <871qn8vsro.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/23 01:14, Jonathan Corbet wrote:
> So this is a good cleanup and I'd like to apply it, but it doesn't come
> close to applying to docs-next.  Which tree did you do this against?
> 

for-next branch (linux-trace tree).

-- 
An old man doll... just what I always wanted! - Clara

