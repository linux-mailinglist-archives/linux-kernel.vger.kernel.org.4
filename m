Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E14D736BE6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjFTM0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjFTM0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:26:15 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F2F170A;
        Tue, 20 Jun 2023 05:26:10 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666eb03457cso1779513b3a.1;
        Tue, 20 Jun 2023 05:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687263970; x=1689855970;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XMzjdDcWatbWNdORl/WAlXXoG9KE2sOD4/NeGpll6Ck=;
        b=Ml7p19DiZD3pT0kEU2uO1Mu/goUuQAHgi/2wWxr7MaBcsQ8dQesQMuX1yInGohwad/
         m3fCxnvmqtg2vh31Kyd/dq5oqCFPMn82HvRLHJ1yBpTGQno5DvZDr0FSqCFTWopotmCu
         1i3wzlWFiylAeLSeqM+4HGmrVpp3jP5NZlIcYmRr4MT71xz15Vkw5s5fZ4BCnXIVQgJO
         KAaxMoc11boG4n+t3kwdCoLWk8nfbdAP2lNURcKIFwPRoAongUbjhvJJdzDiEPp9dbos
         zTebr1pQkSpBGndNeeINDKIaKMH3Q1coW3UNNL2sxusH1etrmhpaufGP/VkP+YBlJosK
         rObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687263970; x=1689855970;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMzjdDcWatbWNdORl/WAlXXoG9KE2sOD4/NeGpll6Ck=;
        b=BJjI/LLOmovs9HRlnLrB3bSmpedg1PL9OZB4otdrfvGTcje4cW+bkP3h28l3N++lMa
         liwp8zuVC4j8238MhYv0TEolnBjKEFTgzz0mvl0wjXWZe4dwOve2tNiN60QcccOVnC15
         4BwyGoDV89hBTGWTMo9WlOxAiw1ZfkLueaQ8kwHwY8JRsQI8kLN3B4kWQ0335YTnpXD3
         PSIsKWwsQKZhxhhGoZhp5/2CtmAFZEfADbRHweuaiKDfP01xH1keO+AhpegcLNM2Tstb
         TwmC7ySw8rdAG4EVOUovWACCARG0krYScSNQ8g+Ao0dQWQtSRoMzzMdJEX6EyyHOPuGk
         RX4w==
X-Gm-Message-State: AC+VfDyROFxUNqnyr2t+OeNEj84QWZh9Pxv4SWoYsC30NJkMpuUoA0C/
        Re35SZ9ovH3R5+vLGNmO011L30R+HLSbhQ==
X-Google-Smtp-Source: ACHHUZ7h+AU05ndOleXii7rbNbOSmHtEb7hInHvBQ/nPNlLR7lRc7IunpV+ugkjECtjwRZRFGXnPsA==
X-Received: by 2002:a05:6a20:48a:b0:111:1bd6:270b with SMTP id 10-20020a056a20048a00b001111bd6270bmr6990892pzc.7.1687263970104;
        Tue, 20 Jun 2023 05:26:10 -0700 (PDT)
Received: from [192.168.0.103] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id c24-20020aa78818000000b00640f588b36dsm1278693pfo.8.2023.06.20.05.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 05:26:09 -0700 (PDT)
Message-ID: <4ce78431-d397-a7a5-cb3d-905c61d47cc4@gmail.com>
Date:   Tue, 20 Jun 2023 19:25:50 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: iosm: detected field-spanning write for XMM7360
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Klink <flokli@flokli.de>
References: <dbfa25f5-64c8-5574-4f5d-0151ba95d232@gmail.com>
 <0826b484-8bbc-d58f-2caf-7015bd30f827@leemhuis.info>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <0826b484-8bbc-d58f-2caf-7015bd30f827@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/23 16:12, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 20.06.23 10:44, Bagas Sanjaya wrote:
>>
>> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
> Bagas, you can't know this, as we didn't have such a sitaution until
> now, so FYI:
> 
> Please don't add "field-spanning write" warnings to the regression
> tracking, that's not worth the trouble (at least for the time beeing).
> Just forward them to Kees, who might look into them if the developer in
> question doesn't care. That was the approach we agreed on here:
> 
> https://lore.kernel.org/all/f1ca3cea-01ae-998a-2aa8-c3e40cf46975@leemhuis.info/
> 

OK, thanks for another tip! I always forgot to double-check everywhere...

-- 
An old man doll... just what I always wanted! - Clara

