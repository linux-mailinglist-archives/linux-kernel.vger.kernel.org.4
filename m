Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4C25BC54D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiISJ0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiISJZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:25:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E2025EAB;
        Mon, 19 Sep 2022 02:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA3D0B818A4;
        Mon, 19 Sep 2022 09:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E66C433D6;
        Mon, 19 Sep 2022 09:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663579523;
        bh=VYOFlJMYOhC2efc+5NSfiL7HlwpSJjefkN5axUW6Oqo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EpUOv88VA5hPzOWU2hpDWosj4QlIYbx56o81ZCsvFR35RwXcPORryyNr1PUcNUB2U
         EnrJAR7vhAyf6YOOCspJIB1sAa8ktmQRfzMLhiGUDXNFLpvul54TOLgsvi92dBtzOZ
         OmHKZNpqh4sXI3bE+NtnRHB/VhvhxCSafqMRHoB3k5TCSxFW+7ZParFVXcvA77fi/D
         6nRkg3uzoK7AIW0dqZl4z77H6zO5ZRIs2ZA3vl//p4TVAR5ZZnkD+3oObWoM39j/Pj
         a60ZMr4BZzSD2KZNzOifE6A/GZGPZmZJA4B+ADO72ut4s/PDEO7SqpB3KHo2+b5ggP
         LP3zvqpZ1oCUg==
Received: by mail-lj1-f179.google.com with SMTP id b24so3224177ljk.6;
        Mon, 19 Sep 2022 02:25:23 -0700 (PDT)
X-Gm-Message-State: ACrzQf3RsG/C+qVxaP378Kxo0RuRK2FiBXD1mFX/tJifMbB6IPxr0x7E
        A4Ng0xSDRvV2pbZH+THQRvChVOFjLXwAmcExBjU=
X-Google-Smtp-Source: AMsMyM5r6f/GbIxEEIWV8DO03uBjKfE3taIERGNSYwmiVAR4CXPf26OGRS9W9lFMTMQkb5IaBi8WMb0xUDgi4AWxn10=
X-Received: by 2002:a2e:7314:0:b0:26a:ca18:60eb with SMTP id
 o20-20020a2e7314000000b0026aca1860ebmr4523372ljc.69.1663579521479; Mon, 19
 Sep 2022 02:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220919191126.4a3c36f9@canb.auug.org.au> <CAMj1kXFKm2A=zNHRSWtWkwBXWM=tQD=x+Q6-Mv_a66qopiXkjQ@mail.gmail.com>
In-Reply-To: <CAMj1kXFKm2A=zNHRSWtWkwBXWM=tQD=x+Q6-Mv_a66qopiXkjQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 19 Sep 2022 11:25:10 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHsAbn2NtJaT8F0evMd19w4nJON+TXV62k2Jsj+o+LTCA@mail.gmail.com>
Message-ID: <CAMj1kXHsAbn2NtJaT8F0evMd19w4nJON+TXV62k2Jsj+o+LTCA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the efi tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sept 2022 at 11:12, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 19 Sept 2022 at 11:11, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > After merging the efi tree, today's linux-next build (x86_64 allmodconfig)
> > failed like this:
> >
> > x86_64-linux-gnu-ld: drivers/firmware/efi/libstub/x86-stub.stub.o:(.bss.efistub+0x8): multiple definition of `efi_system_table'; drivers/firmware/efi/libstub/systable.stub.o:(.bss.efistub+0x0): first defined here
> >
> > Presumably caused by commit
> >
> >   8fd3c9a90998 ("efi/libstub: move efi_system_table global var into separate object")
> >
> > (or maybe commit
> >
> >   ba2dd31b7588 ("efi/libstub: implement generic EFI zboot")
> > )
> >
> > I have used the efi tree from next-20220916 for today.
> >
>
> Thanks for the report. I'll take a look and fix this asap.

Fixed now on efi/next so we should be ok for tomorrow.
