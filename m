Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2E56A76B6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 23:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjCAWTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 17:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCAWTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 17:19:01 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1B1474C2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 14:19:00 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id h19so16109615qtk.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 14:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+jqKSehvjQWC1EOCPbF8m9aVkKIe1OZTk6hTi4G4sOk=;
        b=Ts5PzH0HkbaorXR5DioO8sIiQL3k4jnzQt2NgMmN3jFkQI/2bS36gC/D9nQa7wdzBv
         6UJOqW9MhQUL/nKn6203RrWK9FoR6ckeUpMDl/NRnDEH+hx7BVW6onAjM7v+cAFiGWsk
         ohhqgK9OPzKz7xaQFs+xbwgICEnFhBynnhjhye1vzDX2H0+qA1k6jnQv46fCAko/lQ/4
         yWL21Lw3lwoaHh+qXZLETLYvgb6+ASjTmh5Z3SbldrvYPx2hvmUdfYLNys2uOM10oWXo
         4rfmhu8nLqjNI1YXq04XP25r7EabIXW7QWotlWWhz9YcU7pRxTX1jb+XTs7Mmzqg1Xid
         P0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jqKSehvjQWC1EOCPbF8m9aVkKIe1OZTk6hTi4G4sOk=;
        b=7PMcjpixJ9urZxT5MFN2NJSV83Gh2FJo3zOUx/6hM+c48Mh2seOJf162daXO/NhuHQ
         MO0y2freiOSpri4PbimXOSiUHSbhBkuOmphI0w7JdDlfSf//WTuxYv3s1wTDcnQdNQtu
         yruQdbeaflPtZSthhFrhIo44eUVxSNCGu1sECduD4WNLTXMXeXLBjLvupd3ZQWfeb0xZ
         MSEmtvCf5PLuHvJwHGbBOuKnY/6TcabLrgOWEm5APHO/F/ctVjnUb4tLPdx336b1lgjA
         WysbN+JtwCKHDLh7HQuWerMhCBraq0nHfg0FGk39DyYzRBA55lcs0rtRfPcyo/AhASv1
         iDRA==
X-Gm-Message-State: AO0yUKWVsNDeLX18dsDDpDX9G2/trH+3B6dEcCHHmoQSNJ69xzYzAZu+
        nrNuzkOvTD8Vg/jipCdSs3beBQ==
X-Google-Smtp-Source: AK7set9FtgcFB2eVz2Np08Jn1hOMIkiMk2aiDuI56GeAVTTKG+dTkDQmZaTx1Iv1+TCiGA0uCUHl4A==
X-Received: by 2002:ac8:7f0c:0:b0:3bf:b614:bcaf with SMTP id f12-20020ac87f0c000000b003bfb614bcafmr14296580qtk.67.1677709138947;
        Wed, 01 Mar 2023 14:18:58 -0800 (PST)
Received: from ghost.leviathan.sladewatkins.net (pool-108-44-32-49.albyny.fios.verizon.net. [108.44.32.49])
        by smtp.gmail.com with ESMTPSA id n3-20020ac86743000000b003bfbf3afe51sm8939439qtp.93.2023.03.01.14.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 14:18:58 -0800 (PST)
Message-ID: <ce6204a1-1e37-1cf6-d402-8340a42fd66e@sladewatkins.net>
Date:   Wed, 1 Mar 2023 17:18:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] x86/mce: Schedule work after restart from sysfs update
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org
References: <20230301221420.2203184-1-yazen.ghannam@amd.com>
From:   Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <20230301221420.2203184-1-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 17:14, Yazen Ghannam wrote:
> A recent change introduced a flag to queue up errors found during
> boot-time polling. These errors will be processed during late init once
> the MCE subsystem is fully set up.
> 
> A number of sysfs updates call mce_restart() which goes through a subset
> of the CPU init flow. This includes polling MCA banks and logging any
> errors found. Since the same function is used as boot-time polling,
> errors will be queued. However, the system is now past late init, so the
> errors will remain queued until another error is found and the workqueue
> is triggered.
> 
> Call mce_schedule_work() at the end of mce_restart() so that queued
> errors are processed.
> 
> Fixes: 3bff147b187d ("x86/mce: Defer processing of early errors")
> Cc: stable@vger.kernel.org

Yazen,
Despite Cc: stable@vger.kernel.org being here, the list wasn't Cc'd on this
email. Figured I'd let you know in case you create a v3 or resend at any point :).

Cheers,
-- Slade
