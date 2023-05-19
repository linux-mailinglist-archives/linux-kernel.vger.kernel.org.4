Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5E9709D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjESRLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjESRLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:11:44 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A30C183;
        Fri, 19 May 2023 10:11:25 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6238200c584so15090466d6.3;
        Fri, 19 May 2023 10:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516284; x=1687108284;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGxaJU3wXmLhgQhPbHfNF0PkJYRSV+j79jPJoquYGkU=;
        b=JPjei1lSPz1C3CaDc/ODlJEX52Zp9eQxvsdfX6Q2Ia8fuOyZ7A4TuAXqnxJYcTHvJL
         yBzTp+i8m8xhIdxzyg9UMskjKeNaCPOA4ysHeCcfcDSPGBO3Txci+3e7j9AJLvdLQNuq
         DBhC9pncy7kly4FepBFgIzPsTzT5Ye2teHuFDUdhiIxjm+WZ6bjcY2UTT3YajJOHLLXt
         Tqlk6oacXFRTw55JBFuPNoNlU8JvhMwwJo3kg6zna9MAtdWtshpW0+h/miKdTetRAP5f
         bLZIY9dUXiwHLjhvZBatcVrMpt8XW/N4PWP7evDx8FtOWG47xoEqL45t4dHgn/GPYIp3
         X6JA==
X-Gm-Message-State: AC+VfDycO8hDulYFJ32oRqqCLEZ7EO4iFBqvOpPiy4Xx0yfnat4CgXrf
        vYkJNobsXoFBx79jxfXG2CvpSLrh1sfOEfIE
X-Google-Smtp-Source: ACHHUZ5QS3Zff4eGUEuErzcyjwnrF++6oXqZS5FOfgsBboIiM5Y3LRujQZIjGY9rtrzPS6JSjPWTMA==
X-Received: by 2002:a05:6214:21a3:b0:600:5dbc:c31a with SMTP id t3-20020a05621421a300b006005dbcc31amr6162633qvc.7.1684516283559;
        Fri, 19 May 2023 10:11:23 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:311e])
        by smtp.gmail.com with ESMTPSA id mm19-20020a0562145e9300b005dd8b934579sm1451861qvb.17.2023.05.19.10.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:11:23 -0700 (PDT)
Date:   Fri, 19 May 2023 12:11:20 -0500
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [tip: objtool/core] start_kernel: Add __no_stack_protector
 function attribute
Message-ID: <20230519171120.GA1939377@maniforge>
References: <20230412-no_stackp-v2-1-116f9fe4bbe7@google.com>
 <168440808395.404.16801982965854981978.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168440808395.404.16801982965854981978.tip-bot2@tip-bot2>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 11:08:03AM -0000, tip-bot2 for ndesaulniers@google.com wrote:
> The following commit has been merged into the objtool/core branch of tip:
> 
> Commit-ID:     514ca14ed5444b911de59ed3381dfd195d99fe4b
> Gitweb:        https://git.kernel.org/tip/514ca14ed5444b911de59ed3381dfd195d99fe4b
> Author:        ndesaulniers@google.com <ndesaulniers@google.com>
> AuthorDate:    Mon, 17 Apr 2023 15:00:05 -07:00
> Committer:     Josh Poimboeuf <jpoimboe@kernel.org>

Hi Nick, Josh, Peter,

Do you have an ETA for when this will make its way to Linus' tree?
clang-17 built kernels have failed to boot since [0], so it would be
nice to get this in sooner rather than later if possible.

[0]: https://lore.kernel.org/all/7194ed8a989a85b98d92e62df660f4a90435a723.1681342859.git.jpoimboe@kernel.org/

Thanks,
David
