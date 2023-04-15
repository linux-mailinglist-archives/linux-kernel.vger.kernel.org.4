Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2CD6E3397
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 22:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjDOUhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 16:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjDOUhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 16:37:20 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD5A40EF
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 13:37:17 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3e69924e0bdso12983511cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 13:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681591036; x=1684183036;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kk8ZDIfxLCG8+Fb2zlArJsIFsidceD+Wa1cjWuMYXg4=;
        b=HqBWSoVsgccd/VDUUovfZgnCUSJ273IVT4G1DjDnkvXsQJCyfkgEyYhpaDzwMwDrLJ
         84ftbBUoGn7LgIAljOa9R6qLge/JJWKAZkTX1yXLy17UtnNpZf8diF8ZtwgdusTYGdAW
         asvVik5RvzOmoxd7fjKijuSXPqnyBIrYpb8dc7RVuYSPHIQfnDImzRkA++BRASiVnOTw
         e97QlNYpxCalBnc50UzReiKg2owJHjK59mBHmuCPARTKSX23KVQoZ0ckWsinKmMU5ZPx
         4q3GbsmvxNXAxtKqBe2OIKUsc5nOqS7emUxt239Blq00l/QbfqUV1Ebt75VDQURO5P3b
         L56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681591036; x=1684183036;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kk8ZDIfxLCG8+Fb2zlArJsIFsidceD+Wa1cjWuMYXg4=;
        b=YckmC0NYLfAGn50JkFEd6hT5sLXq9cKzMVV5etqVUuU4CTLTKUM45enpOB7h9KqbsD
         xuF2cNa3qrpBk9jYmoxApm3/ddCQuwU4Dvm67FMBEjeTxUvCwOYuXEqwpuhX3n6ZC791
         y9512isTF3UgiJLwOom7qUXRdha+Thms1RV6XWJ+i/TuJP3vvKWosuHdRfq+4e/4UkCh
         0uc6Xvgh1dAwOMGGTRy/NBlK2YccZutwe4jb2MfsJLFGomN93w03VsKDusgwbsrsUGZN
         q+wkpNz6wc0IqQyCHaRacVgMW2Tt1RavwleWx1MXzq+2hg1hZAceYV0D6EGH+DFipR6N
         RJCg==
X-Gm-Message-State: AAQBX9cl68UnufZg8mK5I9NymRXLbTVfn2Tz6l9ajpr0dKa+njABekis
        7mgDbP3TvwBcDTs3PrC7ExQvHh+NuyZTf0hD2dA=
X-Google-Smtp-Source: AKy350Z9ODzqq5C4gHIbrN/9jNzN8ynLtH8T5actXC+/+ZyAX2ylhlE2aOlIqywSsx3UliAPbJSxgg==
X-Received: by 2002:a05:6214:300e:b0:5ab:af50:eb45 with SMTP id ke14-20020a056214300e00b005abaf50eb45mr9930229qvb.3.1681591036418;
        Sat, 15 Apr 2023 13:37:16 -0700 (PDT)
Received: from [172.19.131.144] ([216.250.210.6])
        by smtp.gmail.com with ESMTPSA id dy6-20020ad44e86000000b005ef6b124d35sm280827qvb.4.2023.04.15.13.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Apr 2023 13:37:15 -0700 (PDT)
Message-ID: <89bb54a0-56f7-a999-c50b-ed34e7f68eba@kernel.dk>
Date:   Sat, 15 Apr 2023 14:37:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH liburing v1 0/2] io_uring sendto
Content-Language: en-US
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        io-uring Mailing List <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
References: <20230415165821.791763-1-ammarfaizi2@gnuweeb.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230415165821.791763-1-ammarfaizi2@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/23 10:58 AM, Ammar Faizi wrote:
> Hi Jens,
> 
> There are two patches in this series. The first patch adds
> io_uring_prep_sendto() function. The second patch addd the
> manpage and CHANGELOG.

Looks fine to me.

-- 
Jens Axboe


