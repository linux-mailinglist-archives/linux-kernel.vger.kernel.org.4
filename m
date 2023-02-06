Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD1D68BCC9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 13:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjBFMbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 07:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjBFMa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:30:58 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A3C12052;
        Mon,  6 Feb 2023 04:30:57 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id bg10-20020a17090b0d8a00b00230c7f312d4so1761532pjb.3;
        Mon, 06 Feb 2023 04:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UzR+7bfBn88TNgGWNySKkAyet59cFaJHBbPCeOSCdtA=;
        b=G8Bxhlzr6grk1WAHKTK0YfCMCdl7oJ0vqQ2mCf+gHZAf3KyHbWpZK7Nv8O+kc4O95g
         +ZSuylHhZN8DjsOW50hBrJ4czEyQwgyrV/zf/4B+YZwnzE02y9QUAyqN9r+CXgNYFvd6
         1G7R7KIId+3aAvWAme6k6BzPGUNSULFhPUEDDiHLVeCBHNwKPhBBu5beDq78hSfFMXQf
         BpvNvr/DHYqV/24+y//1VLTzrCFu+nwfJIbMZn/IwtvikFdKJ6/kB9QgaBhTSn9Fggs/
         mB+4q3Vnu6OrILSqFgoyc4o60e0JzV39prncsppeeCXQF6ko40OWng/hvs5SycgJh+r7
         RmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzR+7bfBn88TNgGWNySKkAyet59cFaJHBbPCeOSCdtA=;
        b=QIwkWPohyXqYkvsKXxk7X9SZWmRIY++87diM7k6bDARw4oL0ZfOG63Wz9v0D1Ea/2V
         Rcb1vugSlsdhuPs9vV4UzLJKg1JHcVE0h2KwSBHQNFsAcocnpgDdUMOJWly/NQT4jo7x
         ysDu0mfgSWlQXx1HIzdwfTar217Pc+0NMUZaIE+MSGNDysyp1apFHygmRy/4Zy5ZvMtu
         LpQ+feoIhJ5Om4dNlC5HOHrLs6JwSSRO5ySe0AGEj7sK6E5D9pEcYTpFWJ8IZuXksCL3
         IGmk4SmnCHW//HgdjPJ16YRxrZAOeo2f3kqM1jO1LSoPawATlqFhEFQybY+Tr8g6WCiW
         nK6w==
X-Gm-Message-State: AO0yUKW36P2g2GTox5RnEzl2OK8ruQGFTWbXWfRnCsPwo+BVLUrlABrz
        CjLsRaYCXyBCvwAhvPROj80ffYohFmg=
X-Google-Smtp-Source: AK7set/15OSvUgJp+pFr7odeROumCwhDUOWGVDVXQ12Igwe2FOTkRQZqKoQEJekck8mmjd1ZR892RA==
X-Received: by 2002:a17:90b:38ca:b0:230:d786:4a22 with SMTP id nn10-20020a17090b38ca00b00230d7864a22mr588483pjb.24.1675686657134;
        Mon, 06 Feb 2023 04:30:57 -0800 (PST)
Received: from [192.168.43.80] (subs09a-223-255-225-74.three.co.id. [223.255.225.74])
        by smtp.gmail.com with ESMTPSA id p2-20020a17090a284200b00213c7cf21c0sm5976777pjf.5.2023.02.06.04.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 04:30:56 -0800 (PST)
Message-ID: <02f7d17d-18f6-3f42-6a42-33502f73e34d@gmail.com>
Date:   Mon, 6 Feb 2023 19:30:49 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: linux-next: build warning after merge of the usb tree
Content-Language: en-US
To:     Dan Scally <dan.scally@ideasonboard.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg KH <greg@kroah.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230206145004.6e043ed3@canb.auug.org.au>
 <93b56558-b25c-401a-031d-971fc644054b@ideasonboard.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <93b56558-b25c-401a-031d-971fc644054b@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/23 14:45, Dan Scally wrote:
> Thanks Stephen, and sorry Greg - I should have noticed that, I'll figure out why I didn't. Does this just need a patch on top or some other process to be fixed?
> 

Please send the fixup on top of recent usb tree.

-- 
An old man doll... just what I always wanted! - Clara

