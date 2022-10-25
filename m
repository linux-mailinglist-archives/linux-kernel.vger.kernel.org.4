Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930C360C2F6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 07:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJYFCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 01:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJYFCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 01:02:31 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A49923D3;
        Mon, 24 Oct 2022 22:02:27 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id f140so10867645pfa.1;
        Mon, 24 Oct 2022 22:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=POslLIEXBDfYK4ABMxOxq77d5eAhDDB11QjGPJ0eG0c=;
        b=aH8gb5k6z5JTpt6oCQzY86Zd7Ze6SwYP3rN153VIqXNYGRekLPhYDIvj+KPon/LVTR
         KG4erUk5utOKTzpnFnqjKE+XkyqdiT5AQG62DjwlLU5/MyHE5FsJPAVBXUDO3COy79/D
         JweqnE+Di4OqRyAp5/nn9i8fBIGfhVll/vvxQfyRfQS8cRzDpg0i5xOr56+uIIYfLWRb
         QvvNNte9Dw8U/PQJFxvPUCC3SH7sxCisLeJnnsj+eVrvxVvaoPif4Js9zGVeipQtWCwe
         A2VEmYiwDeyLosCWjMGvM+CrJZqPwFEzMnaSdt1YB3eVVUmahyQXM2+nvoWoMmmcd89w
         1MmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POslLIEXBDfYK4ABMxOxq77d5eAhDDB11QjGPJ0eG0c=;
        b=m2GwfjKfaXrK04VniyXnsD5lRchNY8mQr+eDUdiXAZPs41S7SpjNEXeiLK7+RDYHw1
         cZD1pTelzxShYUInUtNfA3owNds+QQormgp4TpLkGTrr6c2ymee0f376rf4/p8xaXuKV
         DQ6C5e31VaHeyXDvQ193YCMy8IH+UyTuH2nw2f9U0GZ05Ar0amZDZEuCOiLnWFFRMOlg
         sEumZBgMLSy09GkhVA32vI66mtXsnqdo6O0Al/GoDVaflzgL1ld7SsGlrFU79GJ6SoY6
         3JGijuf4ClrZGCuGtNG9zF8mYEwvCTmeLLrFOfUo4eepz53YUQMLuM/qyw1t3L2x39UM
         mU4g==
X-Gm-Message-State: ACrzQf1ByZAwRJNodCx4r0OwGUv+M9gDSadZdd5z661vdFGNfTxmXGIh
        Cbwy6vxikQU/m+K/zZghMVU=
X-Google-Smtp-Source: AMsMyM4zz79IoUx9VVUCip6MbkJm979oeAhO3KE1u86HlkAYAWs2myxi+J8X27uObCpFC9leHWTYgA==
X-Received: by 2002:a05:6a00:1993:b0:56c:7b8:ea37 with SMTP id d19-20020a056a00199300b0056c07b8ea37mr4341265pfl.20.1666674146297;
        Mon, 24 Oct 2022 22:02:26 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:438c:1823:ea84:2984])
        by smtp.gmail.com with ESMTPSA id z184-20020a6233c1000000b00561b455267fsm625744pfz.27.2022.10.24.22.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 22:02:25 -0700 (PDT)
Date:   Mon, 24 Oct 2022 22:02:22 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the input tree
Message-ID: <Y1dt3gwcG6lSpQg7@google.com>
References: <20221025100048.49384530@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025100048.49384530@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 10:00:48AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the input tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/input/keyboard/stmpe-keypad.c: In function 'stmpe_keypad_probe':
> drivers/input/keyboard/stmpe-keypad.c:353:9: error: implicit declaration of function 'of_property_read_u32' [-Werror=implicit-function-declaration]
>   353 |         of_property_read_u32(np, "debounce-interval", &keypad->debounce_ms);
>       |         ^~~~~~~~~~~~~~~~~~~~
> drivers/input/keyboard/stmpe-keypad.c:355:33: error: implicit declaration of function 'of_property_read_bool' [-Werror=implicit-function-declaration]
>   355 |         keypad->no_autorepeat = of_property_read_bool(np, "st,no-autorepeat");
>       |                                 ^~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>   8b96465c93a8 ("Input: matrix_keypad - replace header inclusions by forward declarations")
> 
> I have used the input tree from next-20221024 for today.

Thanks, I'll fix this up.

-- 
Dmitry
