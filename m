Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268796A4D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 22:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjB0V2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 16:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjB0V2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 16:28:53 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFB821950
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 13:28:49 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-536c02c9dfbso213763707b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 13:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KmeRELRjX+toI8U9S0q+sHldmJmMtE+gM2tXQFayu+U=;
        b=y4E6zHRqFiXuN7c7PneeDu+wNuShz4nVMZLDBPxHPc3IA1/g6oiV5bwS1dwa2qJlig
         KK4dWSPTjhffcVsaO4aTSzFFcUYefVckve3Lqz/d23Ku1SkxUs2z95BXpGkjq0SBaGDR
         xikjSnYwK3gGAR02DOI66/HgvXTQaH7Z8BsB8Nl057AR/dZ0ooaifnLjYdXRJc9YhxUZ
         cIQ1U9NO8IuUbe7aSJuaGMQsftOEbRyzhzqMum27EV68+cp4U1hkmPU6Gk2hwEqhr7+z
         867smwfEWVpn5Clzl4UCKbsxtFx0VU6oT1hlR5vB9Id0crzEpWjB5n42WVV09TrTo5HJ
         WsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KmeRELRjX+toI8U9S0q+sHldmJmMtE+gM2tXQFayu+U=;
        b=xjJSc3CKXqUP8S/J53jgncD7zXfDH7qUn2uPZi1gTD9jCEzb7Y+s9kHf9LulfV/1+S
         nppsinlhJLheMASIVL+g139VJIOQ2Nh8gpPI9lyu5W+msTwF+bnOAldyvloxO4C8Fw4Y
         xPs25tWymLbaeCgSNzvRGBQGjqsd53wUjxt6KmGNazdC+B18Vd7CrN+lMA+iPwzP576W
         W8Zo0JpyiVzOZR5HXS4paRV2sp0LMnzj7JYaKpZKJ6uRuwkAUUxSAYYU8XsQblMj0ewm
         bwxu6opa7scg5sYiPvn7Z9ufQKhRG5IFZgks0Xc/16xnsZvaHju5tWfkpb8McpYqYcUG
         tlSw==
X-Gm-Message-State: AO0yUKUsanHjlEv+cTAdTxRZ+/5ArWXxKYqbiVSRZ0pVqoCt/bfrI+EW
        rbgnZNQgv2G9hxYx/PNwNoHF0QINajaHMrWza2cPnw==
X-Google-Smtp-Source: AK7set9Fm6aG84DkHYFF3B61/XmBl2EHBKxyDQxJVBl73mnj2YUhHJ2iyh2VMkT65oKlT4cTP/s5LNQWjMHpy1cdbI4=
X-Received: by 2002:a5b:8b:0:b0:932:8dcd:3a13 with SMTP id b11-20020a5b008b000000b009328dcd3a13mr105010ybp.5.1677533328652;
 Mon, 27 Feb 2023 13:28:48 -0800 (PST)
MIME-Version: 1.0
References: <Y/cBB+q0Ono9j2Jy@gondor.apana.org.au> <20230224231430.2948-1-kunyu@nfschina.com>
 <Y/cy5wUtk10OahpO@gondor.apana.org.au> <CACRpkdYyB=-UnE1bmdVszSSB5ReECZ0fUoWJX6XtYbKHEe52tA@mail.gmail.com>
 <Y/c7iVW67Xhhdu8e@gondor.apana.org.au> <Y/hQdzsKMYgkIfMY@gondor.apana.org.au>
 <Y/yIbPBVCPx9K/0s@gondor.apana.org.au> <CACRpkdZC4z2Xng4=k94rmM=AFzNzTdXkvtkArMnK7afouz=7VA@mail.gmail.com>
In-Reply-To: <CACRpkdZC4z2Xng4=k94rmM=AFzNzTdXkvtkArMnK7afouz=7VA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 27 Feb 2023 22:28:36 +0100
Message-ID: <CACRpkdb3xVYspjHTZ+z8Xh0mgd+Ht3VCA_F6xon90gyK-bdPhQ@mail.gmail.com>
Subject: Re: [v3 PATCH] crypto: stm32 - Save and restore between each request
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Lionel Debieve <lionel.debieve@foss.st.com>,
        Li kunyu <kunyu@nfschina.com>, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 10:17 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> I am trying to debug!

I am confused by the use of the state flag HASH_FLAGS_INIT in this
driver.

In stm32_hash_write_ctrl() that set up all the algorithm properties
this flag seems to mean "initialized the control register", as it sets
the flag after initializing the register and then does not write it
again if the flag is set.

I wonder if this is in line with the crypto driver expectations of that
flag.

I am wondering because at the end stm32_hash_dma_send()
you set this flag, and that function calls
stm32_hash_write_ctrl() first thing it does which will set the flag
unless it was set already.

Yours,
Linus Walleij
