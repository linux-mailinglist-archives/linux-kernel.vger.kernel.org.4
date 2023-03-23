Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C679E6C711C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjCWTgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjCWTgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:36:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043771B2D9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:35:53 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l37so1320745wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679600152; x=1682192152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=voH3eMjhhyaut+22MPGFHGPMcDal/7FwDZOTpsj04SI=;
        b=OUB2ED/FwjUpQ0e0blSs+/H7lKEKtqqbnLJ86iWyLHz86f5U0RSyENZMyncuKfDh+h
         ovzTvUI3T4g7FdwnEdKSceZ1sUYlUIzud4ehFNidstPI89Sghu+/1DD6zPiP68lSlJM+
         z1ctCQjtmFiPg7iA0KpG+IloiBWsyE2crvqIwWgKr4aR0+DFRWdfGxM4XuozquJQ7GFY
         UKM+8GLxj+b1ecKGC4kYbNKQ++x2Z/yEd1Q/GvdtPGfVDqeB77IC2AX8ycu5llTL7TeP
         yq60cxIf7VU2GWx9YTohmx9rQ4QUTfZc6Dc+9iZKvVGhV5rDpQH1SPFfWRZ7kZu+/1zJ
         ZNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679600152; x=1682192152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=voH3eMjhhyaut+22MPGFHGPMcDal/7FwDZOTpsj04SI=;
        b=DfH9EOzTHJNRORB/uYhvBdDYQSs1bFZswEsug2PVL+3+oSUwfYHXy9KwhTY+uQVy+B
         wtK9CroQzhZk7nHznwzkVoNBWXQd8i0N+tbvRXb4NTl9fP4EoWRKthIRFub9ImHhz2Pe
         eVFp7y9egzkMB8V3TJyAFJYWkuMpjqKWcI4cAitAm6BbLQx64gAXlyw6NkVD1f0KaB9o
         L5b1zE1dIPSVoluotXdAMk44sC/F2LgQaYwk09KGHb5MUX+zrNlTIroAtEiPQRejtd0O
         dgwTRjFWjaUW4/sYL1rR9jSjXJ1epsCm/TtFjGRXxGJV0o3D06hwcDrkYK07RW575oN+
         sERA==
X-Gm-Message-State: AO0yUKWJTadzNltQGxBQDpcd8Ov7pw5f4qUWk0HKT8Ai+56cZNHal69K
        Uc+b1YfFpdNf1SEmzXtZZIk=
X-Google-Smtp-Source: AK7set9sUQp9ktBvPWcuSNp0GfPFC5fxoLwxzfiIdqzt5xrlt9Gl/CH1kOJou/mwlbViWbzxd5lPYA==
X-Received: by 2002:a05:600c:1c18:b0:3ee:52fb:6dd9 with SMTP id j24-20020a05600c1c1800b003ee52fb6dd9mr687433wms.4.1679600151878;
        Thu, 23 Mar 2023 12:35:51 -0700 (PDT)
Received: from [192.168.0.104] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c1d0f00b003eb2e33f327sm7633360wms.2.2023.03.23.12.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 12:35:51 -0700 (PDT)
Message-ID: <c8ada96d-a7da-f149-3fda-64abd7e21064@gmail.com>
Date:   Thu, 23 Mar 2023 20:35:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/4] staging: rtl8192e: code cleanup patches
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1679598576.git.kamrankhadijadj@gmail.com>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1679598576.git.kamrankhadijadj@gmail.com>
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

On 3/23/23 20:19, Khadija Kamran wrote:
> Fix several cleanup issues reported by checkpatch.pl in module
> staging/rtl8192e in file rtllib_rx.c
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
