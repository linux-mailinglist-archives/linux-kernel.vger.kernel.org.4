Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5D5681CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjA3Vbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjA3Vba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:31:30 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C48E7A81
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:31:29 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 141so8671398pgc.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t3DGLS6aiN2haRQRmmZBIBnI3OUSAOT+GVNpjSj7IVI=;
        b=swoStqpnzaDcsLLq3p6Foz1OK+scWwFGMhGJHCEGy1ZVxsIy5nGbpMH+5RL8iJfzkY
         cFeNC/bfYu6xT05Hkd0Cn173lLcZ0t823ihlYMAvo/w+yg+ltyplmfhcW3w57Xe6LzhD
         Ktd1da4tPuRvhRe5ieMnKrKdHWT9MYfee5QkqQ2mE0SQmjSZEkLRomflmLCdycOXPmRN
         4/eeHf6Z1TGDSrA9/H1Vpmtm4Wc3o7VUAK8tHqBu/Jx7zB/orQGzTF0Pg5yyunFZUIS3
         o0yl8ewSLqJkl/0PtPf8+/6kekjp+Te4i2HGe7W0sd7n/rAwq3sgrseeAETWARElimMN
         1uUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3DGLS6aiN2haRQRmmZBIBnI3OUSAOT+GVNpjSj7IVI=;
        b=5C8RkWVh3Y3IYEfv7XV8+XDadnVkCUxFII6CoKLYar88rpI5X2rOrt3ZozffPUWrSy
         sk2qeVwkKucBXh2wVt2tDLGq/CwKnMbp6xAQvMBvDk21F2EAa2cHgq80aYCxlkgQcR9s
         xM+4L8Pad4LWZB/3XJgYtY77LOpSYwkiMxOBxCit6/l6Tv2JP/9kLrGHbXcXlSu5BPff
         c6waKKUue+pb6RE2FKAdLiCinvKRo4TPWPudO8jEXHMAdPeBO1Yp+trX9r7+De69Ejp9
         MUjSQaDfD77SncCwepzY6d30zhG6VPRk6TKgTtaMwOw12RSaxO3ooZZVrSLgVBTx9Xct
         i2JQ==
X-Gm-Message-State: AFqh2koUnimtNjwLFuPSBZ0MjLqzS3AbraPVw5rTdBQItPqqSFoAMNzn
        IB0B9anz9koFonOWbS+vfschtMq9xBbHAj1KY6PyQw==
X-Google-Smtp-Source: AMrXdXt1VPRf5Qrcdy3mk9H7780cdO6g1p3VIEb2Iaqi3/NvNnSWViMH0oG2iS2J8ac4puLS4z8TluhGi/+NvlgT5BY=
X-Received: by 2002:a63:1706:0:b0:497:3785:812e with SMTP id
 x6-20020a631706000000b004973785812emr5230436pgl.13.1675114288305; Mon, 30 Jan
 2023 13:31:28 -0800 (PST)
MIME-Version: 1.0
References: <202301300732.QfTDtiab-lkp@intel.com> <7c25f24f-4acf-404e-88d0-65b55c017f34@app.fastmail.com>
In-Reply-To: <7c25f24f-4acf-404e-88d0-65b55c017f34@app.fastmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 30 Jan 2023 13:31:16 -0800
Message-ID: <CAKwvOdkeM6bNaXds7YpHbVBBZvwGq-Jky32+88PzoBxCpsDHcw@mail.gmail.com>
Subject: Re: error: Undefined temporary symbol .LBB5_-1
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kernel test robot <lkp@intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 2:06 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jan 30, 2023, at 00:48, kernel test robot wrote:
> > Hi Christophe,
> >
> > FYI, the error/warning still remains.
> >
> > tree:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > master
> > head:   6d796c50f84ca79f1722bb131799e5a5710c4700
> > commit: a9f17d0c0778dd971dc9770fa0a2085a41d8c5e4 phy: ti: tusb1210: Fix
> > an error handling path in tusb1210_probe()
> > date:   10 months ago
> > config: arm-randconfig-r006-20230130
> > (https://download.01.org/0day-ci/archive/20230130/202301300732.QfTDtiab-lkp@intel.com/config)
> > compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project
> > 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
> > reproduce (this is a W=1 build):
>
> I reported this as a clang-16 regression, the tusb code looks fine:
>
> https://github.com/llvm/llvm-project/issues/60346

Thanks for the report.  I think I have a fix for this.
https://github.com/llvm/llvm-project/issues/60346#issuecomment-1409326875
clang-16 just branched, so once the fixes land, I'll make sure to
cherry-pick them to the clang-16 branch so that this issue is avoided
before the initial clang-16 release.

>
>      Arnd
>


-- 
Thanks,
~Nick Desaulniers
