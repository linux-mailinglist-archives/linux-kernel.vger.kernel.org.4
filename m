Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377495FF511
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiJNVLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiJNVLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:11:11 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA27C1C5A44;
        Fri, 14 Oct 2022 14:11:09 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id u15so6370395oie.2;
        Fri, 14 Oct 2022 14:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmlOf0WqP2VWIwHpJCvrVP8vGAHC8knpaj2VRfeMJhY=;
        b=dfW5sTw1fzQvivqHgem09kBJg/9LNRI0+h5d/lDWGU+o+4YzO4q0crSj3JLbrOSiwa
         3f3oqIhm7N958TnTGVPOQkfp1fdZevIQNi6nrMh1Nw4uIuhLiye0+ReQiIf2Pf1F44dt
         M5nkqf2fLuEoIQVxOTtIB/tknlhLKI13rVomemJ2n+kmYNFYR4qjyJglBG1/7/it7Pkb
         fVY19AL5xwEC6A0CQEBBTPjCGAXyVKDlvO53l6ssryKPKmeFDiR5yYiZoruaKxzGi1Mi
         wQqRNHIQ+TezpFr8vnILA9sxSMGteXDw8Xk9fMiVdfH4h6IAaQ342ZlXjVcPs/xdf4yG
         7bbQ==
X-Gm-Message-State: ACrzQf09+iU8hPR0nRDRD9chc/sPsn8B0HZd/jtTDOfSpKQgwaGUy+Qh
        Np1B4aMeaq1UaWEU1VuNBw==
X-Google-Smtp-Source: AMsMyM5GyjLi8iHeCcE1tstB3RqHJ++cloFXkmlshA3SqL6w/+hImWx0FxD1VAug2ShRqCJY7tcXaQ==
X-Received: by 2002:a05:6808:118e:b0:345:9c3e:121d with SMTP id j14-20020a056808118e00b003459c3e121dmr3480660oil.211.1665781869043;
        Fri, 14 Oct 2022 14:11:09 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n6-20020a05687001c600b0010c727a3c79sm1772322oad.26.2022.10.14.14.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 14:11:08 -0700 (PDT)
Received: (nullmailer pid 2912846 invoked by uid 1000);
        Fri, 14 Oct 2022 21:11:09 -0000
Date:   Fri, 14 Oct 2022 16:11:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, llvm@lists.linux.dev,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] of: declare string literals const
Message-ID: <166578186819.2912776.6771227036062685821.robh@kernel.org>
References: <20221012174622.45006-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221012174622.45006-1-cgzones@googlemail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022 19:46:22 +0200, Christian Göttsche wrote:
> of_overlay_action_name() returns a string literal from a function local
> array.  Modifying string literals is undefined behavior which usage of
> const pointer can avoid.  of_overlay_action_name() is currently only
> used once in overlay_notify() to print the returned value.
> 
> While on it declare the data array const as well.
> 
> Reported by Clang:
> 
>     In file included from arch/x86/kernel/asm-offsets.c:22:
>     In file included from arch/x86/kernel/../kvm/vmx/vmx.h:5:
>     In file included from ./include/linux/kvm_host.h:19:
>     In file included from ./include/linux/msi.h:23:
>     In file included from ./arch/x86/include/asm/msi.h:5:
>     In file included from ./arch/x86/include/asm/irqdomain.h:5:
>     In file included from ./include/linux/irqdomain.h:35:
>     ./include/linux/of.h:1555:3: error: initializing 'char *' with an expression of type 'const char[5]' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>                     "init",
>                     ^~~~~~
>     ./include/linux/of.h:1556:3: error: initializing 'char *' with an expression of type 'const char[10]' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>                     "pre-apply",
>                     ^~~~~~~~~~~
>     ./include/linux/of.h:1557:3: error: initializing 'char *' with an expression of type 'const char[11]' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>                     "post-apply",
>                     ^~~~~~~~~~~~
>     ./include/linux/of.h:1558:3: error: initializing 'char *' with an expression of type 'const char[11]' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>                     "pre-remove",
>                     ^~~~~~~~~~~~
>     ./include/linux/of.h:1559:3: error: initializing 'char *' with an expression of type 'const char[12]' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>                     "post-remove",
>                     ^~~~~~~~~~~~~
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  include/linux/of.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!
