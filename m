Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0589361DB9C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiKEPUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiKEPU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:20:28 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4DA1EEC7
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 08:20:27 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso10745423pjg.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 08:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s38vWwYYX2y546V50u15z++E+mYl2BBKlENn8a7JkAo=;
        b=xjrhbtCEQ7zi19qp7WscPoMQFmuuepai1qEr6tH87LKPSBuDArDVPtCmlZ4aPiaPG9
         Dc5U6M7fi5Az5vXCbS3s/TiCythTyGNeE/40zr3S9zezhN7Jl1OgAFhVA9gXkHUyZZOQ
         Fp3r8ObhpXELG+sGJJYboYU7jcDGEk2pzo1LMlJvjSo9fP0aSzdN/Jg7KJb2gJ5RLHOn
         +WqTMrTuJBvTOTrhzdLB1xQolSN48jB89+aVUeujidmq9FsYH01Q6XUGUqklDENrpvgg
         x0zTMAeApuAcJC7GlU9EmaqHbJ56O8A4Z9C4LinMP/SiJmFtZYnfNX/el3xL995B9MSb
         HcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s38vWwYYX2y546V50u15z++E+mYl2BBKlENn8a7JkAo=;
        b=bKwRPmrWsTFc5P4cIOkpaE5Q4ra5Z993dHMsu0e/rjqEv3A1mICKyg5rQmG36gnus3
         LEwvyLUU8belZhu0G4kdrM6YFDsOaUbbBP447NbcxOLBSzVoOsQdYFfMp6KOQ2s7JBqS
         nvSrSFGG2vSH7Joth8MIh+3IZJKmsUp44+HUZjoXyJkrtBgI2vbvhxUY7anzGWxY/fsT
         R/TDO2E/JgXpu9RDK26UJZ+sJqdADjtiS1oS//zGyafwPgBLH5pZJ2qLWQxod8ymyDpw
         g2SClPHVi0FwoWEPOsQ8pnpRLLGJuQHmJCySZZvalgwYMh47N/yWBJ5vfA79zKRsVbOc
         kBUw==
X-Gm-Message-State: ACrzQf366XjuoaywDoCo+ZQ6G+2KM3o+1+xxnRQmr1BWQPJKexzIqjAG
        4onSI7WafmSIT3O9RdtkhWFURQ==
X-Google-Smtp-Source: AMsMyM73TsVCu6Fz4bBIRD5vir6gldEVi3Ttrw6t3Ca1ysCIN3L11vfE+G3InH8PK/06xeQo0xeBBw==
X-Received: by 2002:a17:90a:d901:b0:213:dc98:8b0d with SMTP id c1-20020a17090ad90100b00213dc988b0dmr34154537pjv.11.1667661626869;
        Sat, 05 Nov 2022 08:20:26 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s11-20020a170902ea0b00b0018700ba9090sm1810248plg.185.2022.11.05.08.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 08:20:26 -0700 (PDT)
Message-ID: <fc438fc1-213f-8203-ffc7-f88600030fc4@kernel.dk>
Date:   Sat, 5 Nov 2022 09:20:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH -next] block: Fix some kernel-doc comments
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20221104062014.62656-1-yang.lee@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221104062014.62656-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/22 12:20 AM, Yang Li wrote:
> Remove the description of @required_features in elevator_match()
> to clear the below warning:
> 
> block/elevator.c:103: warning: Excess function parameter 'required_features' description in 'elevator_match'

I'm guessing this was introduced by the recent series from
Christoph? Can you add a Fixes tag?

-- 
Jens Axboe


