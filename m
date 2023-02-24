Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2516A142D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 01:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjBXALb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 19:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjBXALQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 19:11:16 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B56B5EEDD;
        Thu, 23 Feb 2023 16:10:39 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 130so4143453pgg.3;
        Thu, 23 Feb 2023 16:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677197436;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MoT6gaRYPtnh8k1ngr4M8vOub0Wg4UYVI0g6XpMS9dA=;
        b=WYapsYYcy8reSKaTmTX7Sf2qze8b1lJ6e5lrN93dRyoFA73MiDv8fYlmKuYx48RZDR
         ms+lX1GivT57dw17JHGeEXRMpw1y+nhAs1JuWnqxKnPLj0bWtZ7HdzNiXPLMAvm0Y0q/
         ZJdlhfqZmnhLa7uOJ6QfQYGYA0Hryajqh9hrOklpWOdiGjehMyvtcJbMiVP7R21gAJdm
         gmgBJyftQ0H10qBSL7Ggy1AtD0zNQ6ugYAqvSxrJ0B4Zb4rqO+SGsHxTPzGadMmMpbsO
         yjeODjrqmnz0nxcmOVKEWg47CWDKcqsGJssWFuH16LIAgADXU215JR5ohQL4cUiR/p/b
         +9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677197436;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MoT6gaRYPtnh8k1ngr4M8vOub0Wg4UYVI0g6XpMS9dA=;
        b=l4JDFmrLp6Hhlq+QMtNYbW71qVD1TOMcWtwpKBRCTmHBGF8lUC35b1VUPksAcu09aT
         W9JRfYf0zlDz8cjDOQ60ejh/yfvsppkQ61sHwaqd1+7HfMgGhg5NBhkM4o+Zj6PP5wSE
         +GwQez2oi+u4zixa28Jzy/cEWbSo8dOnyfWL+NF9AfH2JdzpCDLDAjmKGobaC3agTexa
         28HdGRyWhwY49/g0SQsO1fu/hsLWQ3Zg4BQPNm3OVeyAJ7FN2FyN7hlY6PS6qXeTy8yS
         Pro8HlEZsRnKuUBtE7h7/QHZgNwPJdfEXxo7Q0xtPUIxNCDeyJsZ1bA9xjiCsg7GjyGS
         Nw9Q==
X-Gm-Message-State: AO0yUKW1Nm/h1q+bFPMZ5onS8p6PmLPMx7msTXMPLj/ZFKlgcYet2clb
        rK5erPbZjLC1Pw5vujWB1LSrLLnQIur8xk2hL7GkKNBysPc=
X-Google-Smtp-Source: AK7set+H1KfqQ0rDAp24SajDp5b3exSzqpNDhSxbT82t3yc1G36eDZ2qfdY/DQOlb2xwvhIBNK8tcVuzp9GJ6wgKVyQ=
X-Received: by 2002:a63:715e:0:b0:4fc:27c2:840d with SMTP id
 b30-20020a63715e000000b004fc27c2840dmr2296661pgn.12.1677197436490; Thu, 23
 Feb 2023 16:10:36 -0800 (PST)
MIME-Version: 1.0
References: <CAMr-kF1LxzoOShd7nkE1Pc0ZZgTusB42rDep5ROPirLK9xK55g@mail.gmail.com>
 <1c1c0a3b-10d0-ef9c-e96c-a415bbe0bf33@infradead.org> <CAMr-kF0rCQZ6OQkb5g5pAzWddFKDv4CGYLFzDQs=hYLjJMsuQw@mail.gmail.com>
 <6dc4d3ce-005c-13be-971b-1c026e3272c1@infradead.org>
In-Reply-To: <6dc4d3ce-005c-13be-971b-1c026e3272c1@infradead.org>
From:   Hanasaki Jiji <hanasaki@gmail.com>
Date:   Thu, 23 Feb 2023 19:09:59 -0500
Message-ID: <CAMr-kF29=r_W3VD7vx4SdDW7CXs9XD0KipRyThOzqfAUPzEtVg@mail.gmail.com>
Subject: Re: .config and "make" / turning off all debug
To:     LIST - Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
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

CONFIG_DEBUG_FS appears to be a relevant to kernel development.  So,
turning that off should be fine for me.

The below are from grep SELECT.  Looking each up, none seem to enable
DEBUG/TRACE elsewhere. However I am still somewhat a newbie.
CONFIG_PROCESSOR_SELECT=
CONFIG_B44_PCI_AUTOSELECT=
CONFIG_B44_PCICORE_AUTOSELECT=
CONFIG_B43_PCI_AUTOSELECT=
CONFIG_B43_PCICORE_AUTOSELECT=
CONFIG_B43LEGACY_PCI_AUTOSELECT=
CONFIG_B43LEGACY_PCICORE_AUTOSELECT=
CONFIG_MEDIA_SUBDRV_AUTOSELECT=
CONFIG_INTEL_SPEED_SELECT_INTERFACE=

If interest are the keys for grep LEGACY or _LEGACY
which, semantically, I would hope to be able to turnoff/disable on
hardware more current than perhaps 3-5 years ago or a KVM or
VirtualBox VM.  Your thoughts and input are appreciated.

Thank you,

On Wed, Feb 22, 2023 at 7:29 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi,
>
> On 2/22/23 16:21, Hanasaki Jiji wrote:
> > Hello,
> >
> > Thank you so much for helping out.
> >
> > Might the below accomplish the task?
> >
> > cat f | grep -v DEBUG| grep -v TRACE | grep -v TRACING > newConfigFileWithout
>
> It will disable CONFIG_DEBUG_FS.  That's OK if that's what you want to do.
>
> But this will just give you something to begin with. It will need more work.
> There are lots of config options that use "select" to force another config
> option to be set/enabled. Even if you disable an option and you have one of
> these other options set/enabled, they will just enable the DEBUG/TRACE options
> again for you.
>
> When you find one of these, they pretty much have to be checked and tuned
> one-by-one. It can take a lot of time to do that.
>
>
> --
> ~Randy
> https://people.kernel.org/tglx/notes-about-netiquette
