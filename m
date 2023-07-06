Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBFC749E8F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjGFOFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjGFOFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:05:45 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083ED1FF6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 07:05:35 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1a35f67d8efso136361fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 07:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1688652335; x=1691244335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h5Hk27JWeoUUW7MPiiyKSEfcKWdx6NZyJMrzAcIyDls=;
        b=F281iNWr9Y97BH7qzddr6No9TtGRKPhfnJAPYnN6WK6jaw7YwjMdGPju296dqQKxsQ
         SDjXsd0/sFjaXFAbqR0ZCJjPFdcWuVFl2gat/pLa6oMG7vynCyYIbjN72ZnlgQYh2Vvq
         fr8UGum/50Vbm6ht9SA4zQS55kWX2bbBspRUT0faf65FRK5Yb19BLqjBtXiLCXYWubMb
         G4F39vJq6TMPdD5LNpShc531rhk3Di6+JzHzb9cfobs6ekHn+afUvoDpaYdhhgnl0a32
         qcGDy7TNL8/QTaOIFiKr6TDlMOw1WVmPSiYZc5+YN81r/j2COIjiGNQ75qDFkgSXYmKm
         w0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688652335; x=1691244335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h5Hk27JWeoUUW7MPiiyKSEfcKWdx6NZyJMrzAcIyDls=;
        b=V8HxAYy1z3SarwT+wgkMPL+tIXrrKKw2FjSFHoSNmPWKf3ZmzqDluxwJE/c71uXobv
         6IsG6eSMr7W2Rf/CbP/Y+Z/2W5tBX/PM4qZbPXny+FUU1CDHFIeyne+gJmNreBvThOu9
         0FagxjqENEhlD/oRQWsNxeErObeE2J7miU4dIFBP4zK98EQQuFTh+Bx+7h3Kwnj0ChzL
         FxtkK0P6QpIMKeibXYcuvQNRavw7u4XMH3q7gt4nciP5hs4p2niWnrfO44dOUspPRLEE
         Qcha5RPPpNk3j3fs/kNUXTPDYU8s6R2yzQexIimkdbloaF02tsSexNQohsCTBE/KkTCM
         UzEA==
X-Gm-Message-State: ABy/qLafg/Q4EfLQzX1IkPYiibznMH+o5VXfklaNAsLZW5m1e/5bb40w
        kNZP7CNDesd7vabc9e/MCy4Hng==
X-Google-Smtp-Source: APBJJlHCDicryIiGGIxfyQUrJBwM1mCXFh7KhcZ6gVkvXTm0yW2/DPUG8DxSh4F+y3mxHyDG7jlv9A==
X-Received: by 2002:a05:6870:c094:b0:192:6fce:d3be with SMTP id c20-20020a056870c09400b001926fced3bemr2226347oad.1.1688652335162;
        Thu, 06 Jul 2023 07:05:35 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a199600b00263ba6a248bsm3440900pji.1.2023.07.06.07.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 07:05:34 -0700 (PDT)
Message-ID: <cf70cba0-3ba2-3907-542d-c80216068f7b@kernel.dk>
Date:   Thu, 6 Jul 2023 08:05:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] io_uring: A new function has been defined to make get/put
 exist in pairs
Content-Language: en-US
To:     Lu Hongfei <luhongfei@vivo.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20230706093208.6072-1-luhongfei@vivo.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230706093208.6072-1-luhongfei@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/23 3:32?AM, Lu Hongfei wrote:
> A new function called io_put_task_refs has been defined for pairing
> with io_get_task_refs.
> 
> In io_submit_sqes(), when req is not fully sent(i.e. left != 0), it is
> necessary to call the io_put_task_refs() to recover the current process's
> cached_refs and pair it with the io_get_task_refs(), which is easy to
> understand and looks more regular.

No point having a helper for just a single caller.

-- 
Jens Axboe

