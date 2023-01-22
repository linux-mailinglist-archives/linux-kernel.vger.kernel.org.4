Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA71677271
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 21:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjAVUtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 15:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjAVUtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 15:49:04 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A8C1C305
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 12:49:03 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id bj3so10037519pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 12:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5WJZMQA7v4Th1qcxlhjbVBkGKPGVYQAd/RZT7qOQl8U=;
        b=kt0tafUOm0RxWZP0+BbaOKGRYiP89lUi7mOxliO2REmvNBNgn9fWT/DAzXu7XM80pa
         rPM2c1goiHbQvBrorvYNcJrw4hH5ecLv9x5JD3v3ge5Q7xOmfjLweHJfYaeMxVKZB2De
         mO5XMZz42JyiZZPhCDrr3U2JXm0lhDXDjXqETAxBrjxTMNUQieZldZbCnW1k8I1nnB/V
         CIdwKKY9zbKcppBWDB7ZuScmHMuhVjtGvPNuCbDluI7dU/71myIXe/9ncMi4g4D3ufbr
         quI/wu9Iezx4w6+VeE5QV60qhFYxrPDYtlH925ztGlqdwqW7MCjWE+isA3HWV6r4qc2H
         qItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WJZMQA7v4Th1qcxlhjbVBkGKPGVYQAd/RZT7qOQl8U=;
        b=RqbrbhMFol5NX0AYmdY7JF4y28z1VhPDCP6jPiJcIoud+5iJ5/qA9p4bvlLisOExPp
         lHaeM4XdN5dSClbtsAC4+zroOm5gTw35FjUrJXlUP51vF43vDMSOT6WNrXF4aKXCnPfg
         lg4MSpHNDKbrkBjAoufNYWKG2KyNKArTcm2ByZbnLHQGyOOURpRW7ldFt7/hsKLuploY
         0dyzEDIsQ59sBntGJqcQqno6f3DKVQOznZQ0pmyfhILSTlLK44QXq0YJi95RYAZ+H4+Y
         TQo1rKT1kiphIsRF2OJZT885jf0BARKhErfychRH/v/7g56DgGClNOa+O1je2lG5+MyD
         Eicg==
X-Gm-Message-State: AFqh2kpyKtZza9YW4j7NDrOzIxGsuoK+CvexSUzpKoWEaerT6c/paQBM
        mtweeNsw6ahe4lFngFeDWqCVhVyO18IXVzlm
X-Google-Smtp-Source: AMrXdXvyQSV+qYXNvJm+cGGxO2TAXRsOirLpHAx65emFQK0O6KYlUqfGqEx6JIp+BtRNcviWHOKlbQ==
X-Received: by 2002:a05:6a20:429e:b0:b5:f664:b4bc with SMTP id o30-20020a056a20429e00b000b5f664b4bcmr7108121pzj.2.1674420542819;
        Sun, 22 Jan 2023 12:49:02 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u64-20020a627943000000b00581816425f3sm29636220pfc.112.2023.01.22.12.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 12:49:02 -0800 (PST)
Message-ID: <1a501bc9-7058-6c47-0ebf-44459bc0e730@kernel.dk>
Date:   Sun, 22 Jan 2023 13:49:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] paride/pcd: return earlier when an error happens in
 pcd_atapi()
To:     Tom Rix <trix@redhat.com>, tim@cyberelk.net, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230122154901.505142-1-trix@redhat.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230122154901.505142-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/23 8:49 AM, Tom Rix wrote:
> clang static analysis reports
> drivers/block/paride/pcd.c:856:36: warning: The left operand of '&'
>   is a garbage value [core.UndefinedBinaryOperatorResult]
>   tocentry->cdte_ctrl = buffer[5] & 0xf;
>                         ~~~~~~~~~ ^

Has this one been compiled? I'm guessing not tested...

In any case, this code is going away hopefully shortly, so let's not
bother with changes like this.

-- 
Jens Axboe


