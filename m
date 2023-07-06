Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58FA74990A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjGFKKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjGFKKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:10:52 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A631B6;
        Thu,  6 Jul 2023 03:10:51 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b2f0a140b7so427042a34.3;
        Thu, 06 Jul 2023 03:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688638251; x=1691230251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kx3DJGY59x5qx6tz/6ohgRRDY+wGMD0R71MPKdi07jo=;
        b=e8JMwlQPc+gYtBBRJboS3hfvsvTzqhyQl/9DfKQ/ICXRvm+KBVL6eTQsy7TnDuim6c
         ICpVe0GMEFUUOaCVxpEgkeSa1EqCY5TBbHcFrHznap9MOrWm6S2a/o37IPxUwvpSSqn2
         9WgeuHBbKZNdakQyN13zlxNYAD481745dO0s+raSBgmId5UVUx65Cszavj24XDb1bzGy
         5/ntYG+cKy3V6vHp5EY6UDJRNi3isfI4rKSW0maZUzj8G8aij+ztvYKhp5xvWRAmNRxm
         ao/cHpqrnzb3ACc3MTYFbpyEnpYzLkeDMzNuP0q9hK93auW/HS4NyAAexFPu3kffe1GK
         bDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688638251; x=1691230251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kx3DJGY59x5qx6tz/6ohgRRDY+wGMD0R71MPKdi07jo=;
        b=d2dxFuOBzk1CHalNwEJRne2R1M+Sk6fpPaQTHA/si23uj1DFOVp91Qkj6Z1MpDEmkT
         MU5H0La2+FhNqfLk2uWAlGIklFJ2MMvd78u5oA1Jj3u6g4O7uPBI9XIbBlvLg7E5kzxP
         pA183fGwGkIGUZOBIIK3VE649ihxL539sGwiPE1zWwvtHZhUNBTBf+ShpGjWrMmPv+Jy
         jn3EfAhuwT/HlspNdRBxai25V9OZXPJdE+U7uiC45RCVDBV06G9r/okjBBJeT2m6+1Jr
         vaIJvlnpg2SujfkYzBSbUaXe/RjmRV2pFU6552wym/aIqcRPQJwhCkSjPn8a7DkW0CNs
         RcZA==
X-Gm-Message-State: ABy/qLbFrCwz7I8w6TMD9bzJsXK+gZU3B4Ny91OT21F7gi/6AkcFbmbK
        Vorm7nQFI8O8Z8TOtVBg5Co=
X-Google-Smtp-Source: APBJJlF31OKCVWJMZ6cBjLI34YgMbSK7Y/GYtRBcrZgl/d++hencuN8S5/dGoWXZjBhpnBYiFOecwg==
X-Received: by 2002:a05:6358:9910:b0:134:ddad:2b4f with SMTP id w16-20020a056358991000b00134ddad2b4fmr1792759rwa.18.1688638250907;
        Thu, 06 Jul 2023 03:10:50 -0700 (PDT)
Received: from [0.0.0.0] ([5.180.77.117])
        by smtp.gmail.com with ESMTPSA id c10-20020a62e80a000000b00658670ebe7dsm954738pfi.119.2023.07.06.03.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 03:10:50 -0700 (PDT)
Message-ID: <62ddcb9d-ecb2-f2bf-9709-fd02584b4af8@gmail.com>
Date:   Thu, 6 Jul 2023 18:10:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V11 0/5] riscv: Optimize function trace
To:     Conor Dooley <conor.dooley@microchip.com>,
        Song Shuai <suagrfillet@gmail.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, guoren@kernel.org, bjorn@rivosinc.com,
        jszhang@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230627111612.761164-1-suagrfillet@gmail.com>
 <c7090e76-b054-1f0d-8c05-18f041904b22@gmail.com>
 <20230706-crumpet-chemist-84b1dce8b155@wendy>
From:   Song Shuai <suagrfillet@gmail.com>
In-Reply-To: <20230706-crumpet-chemist-84b1dce8b155@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/6 17:53, Conor Dooley 写道:
> On Thu, Jul 06, 2023 at 05:35:49PM +0800, Song Shuai wrote:
>> Ping...
> 
> A context-less ping is not very helpful - what are you looking for here?
> More reviews? For example, someone to look at 5/5? >

Sorry for the context-less ping. I hoped someone could look at the 5th 
patch.

>> 在 2023/6/27 19:16, Song Shuai 写道:
> 
> If it's application you want, you sent the patch only last week - which
> was during the merge window, making it unlikely to be applied.
>  > Either way, please try to explain what it is that you are looking for
> when you do a ping!

Thanks for your correction, I'll follow this thread after the merge
window closes.

> 
> Cheers,
> Conor.
> 

-- 
Thanks
Song Shuai
