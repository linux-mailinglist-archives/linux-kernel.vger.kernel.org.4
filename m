Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42939615F61
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiKBJQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiKBJPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:15:33 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCD828E07;
        Wed,  2 Nov 2022 02:14:10 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gw22so2715723pjb.3;
        Wed, 02 Nov 2022 02:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yF11JDPivok+OWkX3J34pkNiQiFfff8bNmhNprswwBo=;
        b=MjLIRH4ebdQ8y0kOtg9jywonx4j8Rjh/7IZVtO2m2mLMAxto9zM00Xb8mC4Aiq7/Fj
         Ir9zf2VZ7CDGLQYryLYD3kyummW/kl7TXG4ai4qivhellqqkpJHceeDUDywRvrz5S92S
         noJQloUmJlHhzyRWPu5XiDT/7dijPwc9C05x3rfEq9KYYc+u5MLJrBlE1QvqWtBi8/hZ
         wAPGOzAUHzW40NhCwjXtY0jhClx+O79QR/Kd1H+jrmTvYsaXnTq9W+W5fGzSQkFpaQw9
         9L54DJ/MPwJMjn2lZY96uOP/4TEmiN7rjq+R7/HBVWVfagoBKB8asU4IPunhYg31jvSv
         ne+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yF11JDPivok+OWkX3J34pkNiQiFfff8bNmhNprswwBo=;
        b=zCE64rnGPfxA7pNF3yRR+cf0Lr2MQInrC0Eqp8kDNAjaFXKg1Dim0SOlSe43oL0roz
         5llILpVTc9eYmHrBnpGqEiZS0cI33sFtuiP/RXsptnZ0l7gJS5fxG0pBGwCZEE0qE6V1
         /IM8XulDs/gobuatv3AdyNXEg6a805RnLqHhYaFLCIuo8hprw08PQidexoIHzI3pFo5a
         gtFSrfDhJAMqA8M1EWSyXtJClFP/DndVMKpWgHnn3ZUAsEOpcBTR0nkty8db5LfTPDda
         VBUv5KMqipHGR2RdVXwhP+pTWLMxTkEn4w3ei7BxETssllSh9momD+ryalfOn7nGopBa
         c7kA==
X-Gm-Message-State: ACrzQf2i8V+QZ9fHiydIXWu5IrOmSTtz+ojJtaZ1iEQbaTY3DDU+vloL
        CYOPmj4NlnO0NLaPi76IyvI=
X-Google-Smtp-Source: AMsMyM7PnGkyoDJU7h0/UovvzqN0Vyv4+4dq6KAKTM0Ppu682pPMIYRU1687X6z3nAZ2uW3P5ZoRYA==
X-Received: by 2002:a17:90b:2705:b0:20a:b25d:5d93 with SMTP id px5-20020a17090b270500b0020ab25d5d93mr42137466pjb.218.1667380449845;
        Wed, 02 Nov 2022 02:14:09 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-74.three.co.id. [180.214.233.74])
        by smtp.gmail.com with ESMTPSA id x2-20020aa79562000000b0056dc34467b8sm2979533pfq.154.2022.11.02.02.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 02:14:09 -0700 (PDT)
Message-ID: <0d210871-a24a-8e61-b734-ae6df992011d@gmail.com>
Date:   Wed, 2 Nov 2022 16:13:57 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 0/2] Documentation: Start Spanish translation and
 include HOWTO
To:     Jonathan Corbet <corbet@lwn.net>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, willy@infradead.org, akiyks@gmail.com,
        miguel.ojeda.sandonis@gmail.com
References: <20221024145521.69465-1-carlos.bilbao@amd.com>
 <87wn8ext0m.fsf@meer.lwn.net> <5fd2092e-2f3e-27c0-66a9-94e02efa1e8d@amd.com>
 <87edumxow2.fsf@meer.lwn.net>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <87edumxow2.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/22 05:59, Jonathan Corbet wrote:
> 
> I'm sorry, it was b4 that complained, not git.  To see it happen, try:
> 
>   b4 am 20221024145521.69465-1-carlos.bilbao@amd.com
> 
> There were, in fact, two zero-width spaces in there, and two more in
> Junio Hamano's name.  I've taken them all out, and learned all about
> searching for weird characters in Emacs as a side benefit :)
> 
> Series is now applied, thanks.
> 

Hi jon,

There is still outstanding issue regarding language identifier slug [1],
which isn't addressed yet.

[1]: https://lore.kernel.org/linux-doc/48b4a5a1-2a52-4159-699b-9db73a012892@gmail.com/
[2]: https://lore.kernel.org/linux-doc/Y0ork19pGMhZq8qn@debian.me/

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

