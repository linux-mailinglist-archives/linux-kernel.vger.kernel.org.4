Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45045EA19D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbiIZKwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237009AbiIZKuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:50:19 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5225C58B61;
        Mon, 26 Sep 2022 03:27:18 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b23so6217663pfp.9;
        Mon, 26 Sep 2022 03:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=C8rX11bO0E5A9d+MVyn6i3C/40tS4roRj787StsOFrw=;
        b=lbODLGrycZbW3aySNFBK2tNaiw+EJ9Hs7QLs5p2ZS4dbB/I8xFEzRe9/44qLPmmg5o
         YiZTJYC9CRsURi3DjHKUL8pzTk54WUrd7xki+q0dZhulhKrUhjKCq4WNL2ItD9ZdOPVz
         qXUQYEuUtiSf0L56gO5+9PqCEbzhRFj12C3BgEYAjuV8b8YnhbbnWFjo8sZ9PHQ2Rl67
         ztdRdL5z5izMfb3LaYymCDvsHN3slUfwQtckZ5V3GPXI33zJJn0zAmTTcV7Su6atEKr+
         sPG6oVoVT2qf5HSHB45J+fPoPoi55hhovs38h18SeMJOzk+g9oeqoyTYraVphqOplFh/
         MK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=C8rX11bO0E5A9d+MVyn6i3C/40tS4roRj787StsOFrw=;
        b=2MZPX6XP/05yJ53em4PyOIkjwlOEIsK4oZdr3WxA7H0Fm93u6NZQj0eZUEBTyOlSmb
         rC1rBKVMFf+LDeivT8RgNL1La+LFpClUsn1jPCMlZ3mcRGqp9L9PRAxVXAfPB97cRmdf
         Vwi/izqQ1THzuodphvVsvqjlAy/vMQkDDRB5etJwWHljsaRxUCg2d2pH28SVOsKe5zMN
         sSetgIbWjhvCrP2Bwo5dW9xLq2SUbrpGXmwBaP1bqQfxpVdqqSqxr/wrsHhzPzCS8nr4
         qyhkdEZJBhaNrCE77QUQS5B7rhotAJWKpjQe63Np31V3pgZ7qjnVKgXrQKXFQL/OruLa
         tuvw==
X-Gm-Message-State: ACrzQf3tUEvK90mXaIMOfOINJBVVRc8IVAcP1kgqfGVYgotw2rKfZRFK
        /QcCyCCnKWRtkE4YFAKcNnz+8IEwnC4MO8Rpw5I=
X-Google-Smtp-Source: AMsMyM5DrN3IbbsoTe5WI4Fp/tfb0WeoIEJzl3snUphNtI1RjqLbpPr1YKNGATrULX5M8to6GHbfEA8Shm8pZYH5vgU=
X-Received: by 2002:a63:1f49:0:b0:43b:a2df:857 with SMTP id
 q9-20020a631f49000000b0043ba2df0857mr19845053pgm.137.1664188037524; Mon, 26
 Sep 2022 03:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsP0znm9pS-MiKtyxTXR7XiyFVqen0qzNpicGHDZKCzbwg@mail.gmail.com>
 <4e7992e2-c635-e571-faa3-08fd9ee5c975@leemhuis.info>
In-Reply-To: <4e7992e2-c635-e571-faa3-08fd9ee5c975@leemhuis.info>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 26 Sep 2022 15:27:06 +0500
Message-ID: <CABXGCsPg4mEe0RfJeXCGQ_WatbHgGi16Xw9DFKxPLV8QNi777A@mail.gmail.com>
Subject: Re: After commit 44fa75f207d8a106bc75e6230db61e961fdbf8a8 Wi-Fi
 (mt7921e) speed significantly decreased
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     jelonek.jonas@gmail.com, johannes.berg@intel.com,
        lorenzo.bianconi83@gmail.com, sean.wang@mediatek.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 9:38 AM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> FWIW, there is a patch under discussion fixing a problem found in that
> commit:
>
> https://lore.kernel.org/all/20220829144147.484787-2-jelonek.jonas@gmail.com/
>
> To quote the first para:
>
> ```
> This patch modifies the annotation of supported tx-power levels for a
> wifi device in ieee80211_hw. This annotation was introduced with commit
> 44fa75f207d8a106bc75e6230db61e961fdbf8a8 to be able to operate on power
> indices instead of absolute power values, providing better support for
> different hardware capabilities.
> ```
>
> Not totally sure if that might be relevant to your problem

I checked this patch and it did not solve my issue.

-- 
Best Regards,
Mike Gavrilov.
