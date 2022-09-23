Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDE55E72E7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 06:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiIWEZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 00:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiIWEZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 00:25:49 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E430115A63;
        Thu, 22 Sep 2022 21:25:42 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y136so11292449pfb.3;
        Thu, 22 Sep 2022 21:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=hd3EpiDY5Yp5kjyghC+w8xTY5Gtmr6LFsGwoEFrFfQQ=;
        b=jaTSYnPiUKQJZpq63Nj3ZjxDcZtrSwU9JNlC09jquN4REPFd7hg759VNephG44c4en
         SID+SdrMn15447U9frGUH7T1JmQuEGa5vQArpl4FeViseJ0Xycp22E98hQNCJt09g7Q0
         ejOyTO4sCcRdY4LWI806i4o2/73MDzBH0uPYF5i/D43wNTNpBZWppQOCa6i1MHxc+hxb
         2O3konf5Fb4wM9Ha632TB17rGJisAdsp/OrldNf0oMYSXe06MwzymZP8AhC9SPSMMJDd
         7JrZVz5PsMZHntkt89RaZZoiqB4TeiiHRkf6zU3RWfAfrLnO78h/XhfU/QveEBLzOnkD
         EiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hd3EpiDY5Yp5kjyghC+w8xTY5Gtmr6LFsGwoEFrFfQQ=;
        b=elfBs4THGvNt7BBcPAj0kv42urosWfIKCByd8HqTeSAHfjpWPXCs7MKJOuo8lqjkRm
         LtqDsUzxygd4XnW0k1NSTHKgLo/zNxgRxRMUHzGqsXCAjeANH2rihN3tz1qkFzFGBaVw
         oFNQpcd4zYWHhae/Eov6sgqOc9WrTp00EkP78hNS5srLlxtJKs2+zwfdsUxQl9ENJme/
         kHXJjzkv6rVlYGnZzTgxW2z4551GhQ2eoQnM3Xkyw2Gsjv/nO1UKgSjlhL2s6Hffka92
         AG+Q5DIfVrG1nKu4fuvVjPPevZIHhhVD2S1oLtYau4ZQl4Y1EMPQkvjLYrgfPOqbJ6O6
         BedA==
X-Gm-Message-State: ACrzQf18+DDl+ZwLGl9gEwvdJktsTbKMvD/rzdPhQag1iODI9MONsIYt
        FCVE7rGwwYGhTlouLRYPtq8=
X-Google-Smtp-Source: AMsMyM68aod5tm2PwBh0vxUAIo5yNFhUrzCMAEhsDmjtNgN2CrPCApVUdgUYjV+6Rex1yw95h644Ww==
X-Received: by 2002:a63:1215:0:b0:43a:827d:dd with SMTP id h21-20020a631215000000b0043a827d00ddmr6141561pgl.98.1663907142045;
        Thu, 22 Sep 2022 21:25:42 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-23.three.co.id. [116.206.28.23])
        by smtp.gmail.com with ESMTPSA id o126-20020a625a84000000b0053e84617fe7sm5247361pfb.106.2022.09.22.21.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 21:25:41 -0700 (PDT)
Message-ID: <0ce29b47-1e4b-6c3a-27fa-47e442f1f21e@gmail.com>
Date:   Fri, 23 Sep 2022 11:25:35 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 7/7] docs: put atomic*.txt and memory-barriers.txt into
 the core-api book
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
References: <20220922204138.153146-1-corbet@lwn.net>
 <20220922204138.153146-8-corbet@lwn.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220922204138.153146-8-corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/22 03:41, Jonathan Corbet wrote:
> @@ -0,0 +1,18 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +   This is a simple wrapper to bring atomic_bitops.txt into the RST world
> +   until such a time as that file can be converted directly.
> +
> +=============
> +Atomic bitops
> +=============
> +
> +.. raw:: latex
> +
> +    \footnotesize
> +
> +.. include:: ../../atomic_bitops.txt
> +   :literal:
> +
> +.. raw:: latex
> +
> +    \normalsize

Shouldn't warning like "This documentation isn't in RST format and included
as literal block" be added?

-- 
An old man doll... just what I always wanted! - Clara
