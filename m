Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7788D6154AF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiKAWFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiKAWFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:05:15 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08BDAE75
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:04:48 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q71so14604843pgq.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 15:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RVvLVWD0SwVO5uuYDW/raVqjoQRxgka09rcDVfoxsVg=;
        b=JTPX3LPX80RfqLtGt8ZES0LkcLA4OD0C3LhC4KCbDqOJU09Lmf5Ju6icnIvviUWwJT
         ccON6ls/fqIrea4ffsNGL3MPShWxM/TgwFdmzQ/oycBFIFSeUYzFH9h9MxjGfg69xCuG
         X+dwSd4VzvVMcavX+QTBxWvPI6vCrRBrgPhX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVvLVWD0SwVO5uuYDW/raVqjoQRxgka09rcDVfoxsVg=;
        b=fU1CrjxUYQoO8SeiybH8Y6AUjKEPwPGiCl4CXzo3KetmImV5RLHMfDWmvBlV0wMrFP
         ohKvKQ3x1c+xZfg2XD3JAzaK5CwDvaFSgBtiY48ON1mQZMwB1XNqkKuGvIy1EV7ciCBe
         5eO7n7Pn3EsPukj83tLQUBnfH6hHpYDb8wc2lKDMU7qx9kApZD52kSLvcCQKWz8O/shD
         rZyIF/LxOp1sKcYAbrXGcc9uwj1oXSDqNZW7NQ1C4CP2SQuBK1w9Xaqq+4l27ex0ZKOC
         EaUm5TSvSqf+jk9PKhapehTKtrgEufeVl5IrYLk9UUQrrI0RxNiY0fs47vgIlJ5Be5un
         OxxQ==
X-Gm-Message-State: ACrzQf1yKnVrSgjpxLG1KImIwvfgQv5JLxamTtZWHuAR642BztvxPCBq
        HamtW4hND8cY2nD9+cKTgAtRWmCkdr7hlg==
X-Google-Smtp-Source: AMsMyM481JiojcLSf14Hk6/OSNDq4NNy73X2FY8pOwcjt+8Vk3ZZJiNm6ZrAsoOR+o9F9x4ZnHVhgA==
X-Received: by 2002:aa7:96c7:0:b0:56b:c569:99c with SMTP id h7-20020aa796c7000000b0056bc569099cmr21927166pfq.4.1667340288321;
        Tue, 01 Nov 2022 15:04:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m14-20020a63fd4e000000b00460c67afbd5sm6393561pgj.7.2022.11.01.15.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:04:47 -0700 (PDT)
Date:   Tue, 1 Nov 2022 15:04:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit/fortify: Validate __alloc_size attribute results
Message-ID: <202211011501.CD0E5A9@keescook>
References: <20221018082559.never.406-kees@kernel.org>
 <CABVgOSneaxVgAQH=bN0pxOkN3irtpYVwFhPhNJRoyTcRfEoWhQ@mail.gmail.com>
 <202210182237.C65BCCE2@keescook>
 <CABVgOSn359J8W4DFBO4n8SW=L=-PaVKi9G4R9u67jSBs1zGoGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSn359J8W4DFBO4n8SW=L=-PaVKi9G4R9u67jSBs1zGoGQ@mail.gmail.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 02:29:44PM +0800, David Gow wrote:
> [13:55:44] # alloc_size_test: EXPECTATION FAILED at lib/fortify_kunit.c:91
> [13:55:44] Expected __builtin_dynamic_object_size(p, 1) == expected, but
> [13:55:44] __builtin_dynamic_object_size(p, 1) == -1
> [13:55:44] expected == 51
> [13:55:44] __alloc_size() not working with kmalloc_node(size++, gfp,
> NUMA_NO_NODE)

So, this turned out to be a rat-hole de-ja-vu. The short version is "I
was using Clang 16 where this doesn't manifest", and the long version is
"some inline attributes are broke on all versions of GCC[1] and on Clang
until version 16". :(

I will send the work-around series I've put together to address it. At
the end of the day I now have a WAY more robust set of __alloc_size
KUnit tests. :P

-Kees

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96503

-- 
Kees Cook
