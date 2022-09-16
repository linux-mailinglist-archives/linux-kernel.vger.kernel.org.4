Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0699C5BAF40
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiIPOZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiIPOZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:25:24 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6D9A50C4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:25:18 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id j9so3257232ljg.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=KDdbJY+6Lwuy0ZMU2F8sRoi82Pbj6XOA2IBLb/eM6QI=;
        b=KXcEsEm30D38YxlIGLkoYYPnodQAmfcqk8DkXGK46gKBXp/A2XcbeDg0gTIbWt6pM8
         j12ShDHRzqATdHQQxaSUZWHeWpKdhBKB5nRSvtm45ITz4MiJJxIidPT9iitoRhhy30Zw
         +KRC78zutPHNQxYvCSSpiPwahuY1ljCPJjbW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KDdbJY+6Lwuy0ZMU2F8sRoi82Pbj6XOA2IBLb/eM6QI=;
        b=Fm84nLivLJ1KcNbELb2uudKG2ffQEtyTNLnzMy1SsnpK/eM+GfXw2mbjaG5X2LF5AI
         DmNBMLXh53H5ZW+AK8uhHm9udh5Z2Wyn9O0ez4NWp0x8gdhdinpyDOyaGl1D7FwyzhQS
         VjlGiS7Lwl5klubSnI6Y+0DyU00NopimFI3KF8wXlSMb6VtuuG2+lnR3qRCYChgxiNC/
         YaEkkAWfVosb/Pflna2X9rsGtQPICJWu3yRfbVZCyN+pevO78luXrW8LMcRqR8C51Vpl
         76+ULwMt+Zin0FrgjlU2gZop/KSEz9UDURLU2XVox/QU2qNiLPOFPxeakdLflEwCrU1q
         6wYA==
X-Gm-Message-State: ACrzQf3q/0nr6kG6uzNpeMHKAvByXLOn9d9+mTYju78X/KRNjvZj+MMJ
        WZ5xp23gGAnXXUibzOFNb2HYZYuSANAognuS
X-Google-Smtp-Source: AMsMyM5EbL4UvAmLdaEgBalaxv6ZR1eBIlsuORgEkbsE3yyqzhXvsuItFu9AL2r7rNLUGqaGBA2JfQ==
X-Received: by 2002:a2e:9c2:0:b0:26a:cbe5:21ae with SMTP id 185-20020a2e09c2000000b0026acbe521aemr1582368ljj.354.1663338317093;
        Fri, 16 Sep 2022 07:25:17 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id l6-20020a2e9086000000b00261bfa93f55sm3711966ljg.11.2022.09.16.07.25.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 07:25:13 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id l12so26199755ljg.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:25:11 -0700 (PDT)
X-Received: by 2002:a2e:a602:0:b0:264:5132:f59 with SMTP id
 v2-20020a2ea602000000b0026451320f59mr1620436ljp.0.1663338310469; Fri, 16 Sep
 2022 07:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220915002235.v2.1.I7c0a79e9b3c52584f5b637fde5f1d6f807605806@changeid>
 <YyNIOg1mtnzQz1H7@zx2c4.com> <CAG-rBijUSQ-kA0-pS=JCVX9ydeaSCd9Ub=yryGk4zsbcv3dTzQ@mail.gmail.com>
 <YyQWPcxG1Xc1qRWE@owl.dominikbrodowski.net>
In-Reply-To: <YyQWPcxG1Xc1qRWE@owl.dominikbrodowski.net>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Fri, 16 Sep 2022 10:24:58 -0400
X-Gmail-Original-Message-ID: <CAM7w-FV8Vn_jUz1ExA5HHVz66sDzYw4vZw9EoxCHuGh_Fm3YiQ@mail.gmail.com>
Message-ID: <CAM7w-FV8Vn_jUz1ExA5HHVz66sDzYw4vZw9EoxCHuGh_Fm3YiQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] random: move add_hwgenerator_randomness()'s wait
 outside function
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        Alex Levin <levinale@google.com>,
        Andrey Pronin <apronin@google.com>,
        Stephen Boyd <swboyd@google.com>,
        Rajat Jain <rajatja@google.com>,
        Eric Biggers <ebiggers@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominik,

On Fri, Sep 16, 2022 at 2:24 AM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> Indeed, our patches address different issues. I'm fine with both approaches,
> i.e. my patches to be based on Sven's, or the other way round.

Sounds good! May I suggest then that you try to rebase your patch on top of
mine. With a bit of luck, it will become simpler, with fewer kthread related
footguns. I am available to help review.

If your patch becomes more complicated however, we'll work the other way
around.

How does that sound?
Sven
