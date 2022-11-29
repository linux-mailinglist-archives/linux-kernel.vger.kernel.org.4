Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634A263C6D1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbiK2RyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbiK2RyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:54:00 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCAF27140
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:53:58 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id q1so13705696pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xli9vLCEDtXh1Vn33pOpeSIt22szJ79NH9QfJ1/hCFI=;
        b=rnete2628Hvjc5JnCt8Q7ltyJnmZdSp9s1qJoUrljVKf2KKDbT5ljd9bWFPCmnTPoH
         xi1/zyERiln1rGEVXHl/1xzQaQ1y7vrXTRP/NYMRHaadv2IatDHf3xBwITkNXkcO+SjO
         +nDh7xGMCoVWGd+f77Z7byqi/iQ/D4MvqFdAyOieVo7HVq+AdkodTeR+BCwbbq/rmO4m
         cj9gMpyU3kTMN6DSqs1EqnvIHm75Y3JRW2n7agG4s0BvNheokyFDGj9ZzZX0gs5EG9z5
         187qFSyHShueZg2m0LaeI/IKReDVF5+snwpg/k4dWb9uyJEsj1z6l47yWEx/BLZpMAQW
         lRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xli9vLCEDtXh1Vn33pOpeSIt22szJ79NH9QfJ1/hCFI=;
        b=BpNI3eYJtOqSeaBRZziU2KTKO04HIYAT0mO3dr4O26xT2CGvpx6/anA8I1VX1Kcbqg
         mAY9FH8LhQpKZjByxL/xTjiMa9HhvmlXOUAQMjBXiWF/u0gD/zmnWucTIASg39GutLNv
         8gFXJ77dFrVNTHZalOEv0t6MjawyVThihvycz2wK8aDhujUJcExu8t/vcD+xRqEbEGQc
         M3RHCZ2+vFm2WoJPhBowtMF0i3SEvIFGiooXJqli5oSCsRL+ed9JE6/BT5Pl0NqhovAu
         2fF2fMSyebbs4LDMdmEQI6MvZrp1MKizyqaYxtaF6leKFP+OnFoVm+Ux8ULBap7IX8j3
         jHwg==
X-Gm-Message-State: ANoB5pk2q8QBxnH9ZzQp0t9vHbU0L1Y/Keppr8H1zlcYnAItMzKjNAQP
        ncY6/fjP2h/sENZRoY5YAEPo8w==
X-Google-Smtp-Source: AA0mqf68+0UInZ79fmb6DL13+mxpSI9oXKNi01Izlzc+q4wolcGLb+Om+efE6TIVJSAwdMBcKg6rbw==
X-Received: by 2002:a05:6a00:1d25:b0:562:5f71:d188 with SMTP id a37-20020a056a001d2500b005625f71d188mr40014334pfx.57.1669744438171;
        Tue, 29 Nov 2022 09:53:58 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p5-20020a1709026b8500b00188c9c11559sm11201218plk.1.2022.11.29.09.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 09:53:57 -0800 (PST)
Message-ID: <bf638161-2193-7403-da2d-d4c5073cc2ed@kernel.dk>
Date:   Tue, 29 Nov 2022 10:53:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 0/5] random improvements and cleanups for elevator.c
Content-Language: en-US
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1669736350.git.nickyc975@zju.edu.cn>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1669736350.git.nickyc975@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 8:46 AM, Jinlong Chen wrote:
> The series slightly improves the readability of elevator.c.
> 
> Changes in v2:
>   - add patch 3 to further improve the readability (suggested by Christoph)
>   - add Reviewed-by tags from Christoph
> 
> Jinlong Chen (5):
>   elevator: print none at first in elv_iosched_show even if the queue
>     has a scheduler
>   elevator: replace continue with else-if in elv_iosched_show
>   elevator: print e->elevator_name instead of cur->elevator_name in
>     elv_iosched_show
>   elevator: repalce "len+name" with "name+len" in elv_iosched_show
>   elevator: use bool instead of int as the return type of
>     elv_iosched_allow_bio_merge
> 
>  block/elevator.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)

Applied, with some commit message re-formatting. Please keep lines
<= 74 chars.

-- 
Jens Axboe


