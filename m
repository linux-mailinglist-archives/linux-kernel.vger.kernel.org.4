Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9280611D62
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiJ1WXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJ1WX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:23:28 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FEA24D891
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:23:23 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id m6so5963961pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFnoJJc5jH9h4ZyR1/8puw/12uZIyqbNMSZteb25A9U=;
        b=PQbmsXb2a72NLiB40rax6kZnW53XFelVILJp/xijhdqRs2/D4aDixRl81wGJ1w+0Ki
         TNaAMtHem7R0pCI7UFADgRuBa45arIsYNYd8tmnNoTACpKqeTUmT9QBb+8d1mSXVc212
         PuXO8oAVpf0MXN1wVLYKClEPJbPWVgDuv9tC/XU3NyloWN4U3muoUiNUf+edZnilZK6C
         plmObKu9DfpspMAkY9PuKZb4eqkIBGbbTCE7XodKFNksTBtDeL23eRTBsIEWikSDwVNF
         jLErOxB2wwAXvmt/H43XdkKNGBTi+43VElI4gEqHuWmlbJVxRXBfkvj/ljdcUNs882Ju
         o3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFnoJJc5jH9h4ZyR1/8puw/12uZIyqbNMSZteb25A9U=;
        b=d6P69BzjXVTs1ZvdUVjyHSnH52dB2MRrLqcJ7ihEy0AWtY7s4BaeshiKX6HWcuR9qm
         jSNDilujz8P7phzeLJQjPEkOUW5JNnBWKODgZ7TEe/DUXOmEqKHIqB2h8zS2micP8+du
         sZtClPIUFOxbWLUTdOOrEjaC3wgtXTFW2jRbMhrJnaQjjsgUhlsRrbp01HdqFaaW20Yu
         zButMm3/sdGnjd0YYWH6GRO/g3X95+1vjqyWthB+nvJhPE30pS3uaOlyxzY9u+n5cpyG
         jwIlH+bZ0FWIJdpqhT64Nh9/i4Prs3/NkxVS74hn1dz1v6zUAcnOU32qN/tNDYkO8LhU
         ikNQ==
X-Gm-Message-State: ACrzQf32pFMKIYalG8fzWy/Z1Qm6mnMpVu7pHfvdiLtxXJq5Al1IPhsN
        PEjV0ZqHYd2bGliJiV4X+Z2rAQ==
X-Google-Smtp-Source: AMsMyM6qhNyvCpqBCc9JD9kPANbFBQ9f31s9FXgZAwzTnrQqHNVrj3TSSTGoMRINKP2BKoJPLBrkpw==
X-Received: by 2002:a62:7b0f:0:b0:56b:e472:9e81 with SMTP id w15-20020a627b0f000000b0056be4729e81mr1353988pfc.13.1666995802757;
        Fri, 28 Oct 2022 15:23:22 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902d14300b0017f637b3e87sm3442257plt.279.2022.10.28.15.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 15:23:21 -0700 (PDT)
Date:   Fri, 28 Oct 2022 15:23:21 -0700 (PDT)
X-Google-Original-Date: Fri, 28 Oct 2022 14:51:10 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: fix styling in ucontext header
In-Reply-To: <Y0/PfL5SWNw8HCLr@wendy>
CC:     waterdev@galaxycrow.de, Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Message-ID: <mhng-036eff83-1a93-4e98-9810-a4abb79e55e7@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022 03:20:44 PDT (-0700), Conor Dooley wrote:
> On Wed, Oct 19, 2022 at 12:07:58PM +0200, Cleo John wrote:
>>
>> Hey, because I am new to Kernel submissions I wanted to ask if there is a way for me to see / track how far this commit has gone in the pipeline of commits?
>
> https://patchwork.kernel.org/project/linux-riscv/patch/20221010182848.GA28029@watet-ms7b87/
>
> IIRC you sent the patch during the merge window, so it wouldn't be
> applied for v6.1-rc1. You'll get an email from the patchwork-bot when it
> gets applied.

Yep, this is one of the more confusing parts of the Linux development 
process for new folks (or at least was for me when I was new): you send 
a patch and it's not super clear what's going to happen to it for a 
while.  The merge window is generally a pretty hectic time, so stuff 
like this that's not fixing a bug or adding some frameware that other 
patches depend on can kind of get lost in the shuffle.

I always feel kind of bad for folks about that, but patchwork should 
help some here as at least we can get the smaller stuff called out.

This is on for-next, thanks!
