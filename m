Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAB06C8904
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 00:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjCXXKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 19:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjCXXKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 19:10:45 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4829813DC0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:10:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-93075ee221bso11266266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679699438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RIbBdv0rR71zWsoyrLAdHdQfi/mJqC2jsnQ8fjq5QOI=;
        b=PZltg+bc4W54ijsUZsOnfPqqbkur/wtkcvTpWzSkHZ6IgJyUQTTCr+3BLnmrwqcSDL
         sKhAy+3dWhyuhu1Ak7DOoi4137fMda4acW71p9P2DAcAAGlOJStBNVZB+5p4Sjk494n6
         bBWjXPfWR/cZHpt7e5H2N7YNwEtMu1ZNZhda0XQILfbKr4O25sTkwXZVEXONYRCM97Fe
         ftEwITbfOPT4Th/o+Z1kddh2UdrwW5tEPUW0q+wKl8HE4KzhywiZSJeTugy8qDI6stn6
         cO/Ra6dG3RDTHegHOfpjwmtUlMqgfnNEKWr5KyJAURM6tKX6hoxSJSizBJv2gizK4t0r
         nDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679699438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIbBdv0rR71zWsoyrLAdHdQfi/mJqC2jsnQ8fjq5QOI=;
        b=wG+kGcfU+K3WtzMoRxF5OCOkGHD5j95CITj87G0iDYGjOgmR7p1l0fLmq8JQe7muNp
         xpEvZUWzy5DE+BCbmqRlDLLH/3io4TunRGEeR7M0bvDW0hKGCztugS5iarB2s/rTTlb1
         REZWIsTIlwmG3oBbO/SKI95dnnrDBsNmaDeXVWuSLj5JAf4u6zTJj+M12aSwpGr1mL8B
         0OJ2Y4DhJPffz3g1XP1cxQ+u9PS/XkBJ8yUXNqrqhqC+2Nzv815t34wxNvJ3uXvwlbq0
         vTq/c9bPA7JYd17tdgkfxa8x3quNdsGSFSvULsFSHgJr0CRtPFhJ+xkpJ0cuqm19LRXz
         4rHg==
X-Gm-Message-State: AAQBX9d0mMkO+9wOSWOjJraACVU7gHuj8UxVwZBbZRnetFgchpzAHWVd
        yqofl485oXAkmIpgRFkYU0jAdvtMaY8=
X-Google-Smtp-Source: AKy350bfe5wYGjTF/L2mD0fFGrMsWgyqhrJ8O9a+eNW2aDX1sa04fcottuCgbUB+I4tyYrqQWykJOw==
X-Received: by 2002:a05:6402:11cf:b0:4bb:afe3:e0a with SMTP id j15-20020a05640211cf00b004bbafe30e0amr4276485edw.3.1679699438461;
        Fri, 24 Mar 2023 16:10:38 -0700 (PDT)
Received: from [192.168.0.104] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id q27-20020a50aa9b000000b004af73333d6esm11360561edc.53.2023.03.24.16.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 16:10:37 -0700 (PDT)
Message-ID: <18590515-9005-01c1-3035-50a4f3b8070f@gmail.com>
Date:   Sat, 25 Mar 2023 00:10:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 0/4] staging: rtl8192e: code cleanup patches
Content-Language: en-US
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1679696777.git.kamrankhadijadj@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1679696777.git.kamrankhadijadj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/23 23:31, Khadija Kamran wrote:
> Fix several cleanup issues reported by checkpatch.pl in module
> staging/rtl8192e in file rtllib_rx.c
> 
> Changes in v5:
>   - Resent the correct patchset becuase mistakenly sent a wrong patchset
>     in the previous revision.
> 
> Changes in v4:
>   - Changed the subject of the cover-letter that was mistakenly edited in
>     the previous patchset.
> 
> Changes in v3:
>   - Changed the description of all patches in order to explain 'why' the
>     patches need to be merged.
> 
> Changes in v2:
>   - Resent patchset with the correct email address
> 
> Khadija Kamran (4):
>    staging: rtl8192e: remove extra blank lines
>    staging: rtl8192e: add blank lines after declarations
>    staging: rtl8192e: add spaces around binary operators
>    staging: rtl8192e: remove blank lines after '{'
> 
>   drivers/staging/rtl8192e/rtllib_rx.c | 73 +++++++++++-----------------
>   1 file changed, 29 insertions(+), 44 deletions(-)
> 
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
