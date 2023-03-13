Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43516B8463
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 23:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCMWAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 18:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjCMWAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:00:48 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3CB8F504
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 15:00:04 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso2931219pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 15:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678744790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BGGPAUzSIdvt5yUBCr9JjruRsWUaP8IK4hLIEPJ1BEI=;
        b=3H7ByH5DwcrEGPels98DU99i5ducimDAuCPRq5PLW49OyNuxi13tdXOX4ci+cLNOmg
         1UO3BocfQJLDKsj6PJqTml7twvABrgepdCUNm/nThJOcaNBv0nN/rGB83YLzrqi1Lkly
         03g/l1gY2HIbqrMxLfIZ2VnH/5EHqVWbVUkwmPZ2eR4xpsBtw12hNM8V3+67cj5p2N3j
         Dnjzsu7jWsBwV99xnIQ/reEuwjkI62et+t2NHnk6Xk2WqqGSRVvB+SgHoN4BdfyqIfUJ
         LyTgWL6Apt4deKEJhiMlWn22kdqeaaZYU/K+UvMuA5bC1od8sGGuWhvCyNB2uEd6uebl
         hdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678744790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGGPAUzSIdvt5yUBCr9JjruRsWUaP8IK4hLIEPJ1BEI=;
        b=c34RyZIfiWviiNh0t3bgvUw3AglCCXdZl1dDiFTGjUkvFjnE4F22QgMxcn3S9jWe7u
         jz7jrim5ni/5sTMUSYZKTsADmnAAJgN2LgZw1qMTAFnhUW+h/W+73m47FYi3E76Kwz3y
         Njs7RGkHTUo+4cmrVsXK74IMldXORlaH5ITcZQG5Z3kqhOlztoNx/e5Q6h+4mmNDIKGt
         g8ksNKGUDPguctboBBXPW2HMtB4fNXcj0YDy4Hv8ZXVrgQQJ9fILNnds3KnM6OQWdpbq
         1W0NUQMB7nYSTQR2Y7JiuBZPPftHSIGOXZO3O/uuC9Rz78BtCS9s5eDAyYB1cspTYyxI
         WSMw==
X-Gm-Message-State: AO0yUKXm0DiMN1DLT4R86N1uiaQT7JyBLlftkB/lA+v0P4j88RmeJgWY
        F1/bXYkNArId/UqLyjxgQ9IuL1/sUMcOYSx8AFCHhA==
X-Google-Smtp-Source: AK7set/duow7nBBTrQI+8mZNwxqsYtCrL/jxIbWlW6VMScKdvhg2hT5E+ZH9WyfDDwtPs6yCmwxDRQ==
X-Received: by 2002:a05:6a20:3ca7:b0:d5:58df:fb93 with SMTP id b39-20020a056a203ca700b000d558dffb93mr300503pzj.1.1678744790152;
        Mon, 13 Mar 2023 14:59:50 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e6-20020aa78c46000000b005d62cd8a3c9sm195750pfd.71.2023.03.13.14.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 14:59:49 -0700 (PDT)
Message-ID: <9cd66e6e-6223-2fac-961e-f030c4424410@kernel.dk>
Date:   Mon, 13 Mar 2023 15:59:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: linux-next: duplicate patch in the block tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230314084625.3530839b@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230314084625.3530839b@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/23 3:46 PM, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):
> 
>   6d114e22385b ("io_uring: silence variable ‘prev’ set but not used warning")
> 
> This is commit
> 
>   fa780334a8c3 ("io_uring: silence variable ‘prev’ set but not used warning")
> 
> in Linus' tree.

That's fine, it's just an older stale merge as I added the reviewed-by
tag before it went upstream. I'll rebase my for-next.

-- 
Jens Axboe


