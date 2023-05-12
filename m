Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DF9700519
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240736AbjELKUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240272AbjELKTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:19:52 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9436BF
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:19:50 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so88027598a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683886789; x=1686478789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BGXOyAa5DnCzicg1WMhHAiqKUbrBxcr55E83qrHtPDU=;
        b=p3mgnzNzgGt1lPjwZdax27OvFAQBM/nSyCoHX72tTL33HYXvpUvde/Iu6uRkf7SCIY
         RNNXrd9t3jf7M1IUg4qCopsyvK+C4OIpTX3FNt1n4JdAVQBDtXZPIaoLCulJpzM0/3+/
         gScckTwL0249HhrH+/bCcZ/chOS07AvuvIFWjZ636X87Oq0eaomLXBQUtv08zDYpvMpj
         uPBRJZKAQhtq6kQowfKYx94m29yaQ72WbHl4A+CW3rk4odeXcZ2Cd9mG81fegzIQVkIS
         Ppp6OFAC3sloFttjrpoTgqD08UeOO+EztMBSJ2VmZlAKU8Az5FGKqGRzD4xgzbk3/k4z
         hUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683886789; x=1686478789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGXOyAa5DnCzicg1WMhHAiqKUbrBxcr55E83qrHtPDU=;
        b=Xme79OizGzg7BISPgfjQDdKaoz6Lf9VBJYBwBkBuYFllap/RNB66iK7gqguup7lOqS
         /S5LUChdreGKtVoDiTTiS3hh//ht79tDBoT8Al8+qN8545e17b/q4iemTMwezN2YFVgN
         oPV+rz6A+ESi4bBxvidlSjDlR6pO32RTJ/DD+EOC3Htf2ZNiOHd9bvx/Tmxu7IPkq2Pg
         ImZWAKALW0hx27iQur2pgezPxFHlhNrRrYXybKoVTdc8oM247cFjajfx8QJxxr4xZE+e
         4hePjuOsVQSjmJwPdv4tjuwYUBAmzgE4P0jKD46sRDuWLLHK63GcG3NC75anqCac0wb0
         PA3Q==
X-Gm-Message-State: AC+VfDzoCbrPFUFcPRa/pb38hyppe7jU5co/bQBMrkejfg0E38roaqg/
        G94QsWTY41Lqodc2qLWwyAA=
X-Google-Smtp-Source: ACHHUZ6W4jderX18G1+BWeXx4C+KEye5kWMYawE6hxWwofvBTy0dpoWnoqzCvKqODgbPfipf8f76Hg==
X-Received: by 2002:a05:6402:42c6:b0:506:b94f:3d8f with SMTP id i6-20020a05640242c600b00506b94f3d8fmr23402197edc.5.1683886789038;
        Fri, 12 May 2023 03:19:49 -0700 (PDT)
Received: from localhost (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id n10-20020aa7db4a000000b005027d31615dsm3726617edt.62.2023.05.12.03.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:19:48 -0700 (PDT)
Date:   Fri, 12 May 2023 12:19:45 +0200
From:   Jakob Koschel <jkl820.git@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] w1: Replace usage of found with dedicated list
 iterator variable
Message-ID: <xxs6zv5j7s6zmko5b5idhynzotx4nnyjktj35sdvelr6ha4aeh@w52ylfmwguva>
References: <20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-v2-1-259bf1ba44ed@gmail.com>
 <c626e464-64e2-3cdb-7cf3-c76770feb1f0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c626e464-64e2-3cdb-7cf3-c76770feb1f0@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How strange, I just checked and my checkpatch doesn't complain.

I also redownloaded and double checked 
(b4 am 20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-v2-1-259bf1ba44ed@gmail.com).

What's the exact issue you are seeing?

- jakob

On 23/05/12 09:27AM, Krzysztof Kozlowski wrote:
> On 10/05/2023 00:49, Jakob Koschel wrote:
> > To move the list iterator variable into the list_for_each_entry_*()
> > macro in the future it should be avoided to use the list iterator
> > variable after the loop body.
> > 
> > To *never* use the list iterator variable after the loop it was
> > concluded to use a separate iterator variable instead of a
> > found boolean [1].
> > 
> > This removes the need to use a found variable and simply checking if
> > the variable was set, can determine if the break/goto was hit.
> > 
> > Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> > Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
> > ---
> > Changes in v2:
> >   - fix checkpatch intentation issues
> 
> I don't see the differences and checkpatch still complains. Are you sure
> you sent v2?
> 
> Best regards,
> Krzysztof
> 
