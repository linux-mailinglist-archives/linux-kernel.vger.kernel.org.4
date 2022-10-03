Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACA85F33B7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 18:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJCQj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 12:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiJCQjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 12:39:21 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DCC26499
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 09:39:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bj12so23349232ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Sz/7ENEAx45gBAphCQu33YD+axd5XhAo6fkcJvfvnk8=;
        b=JVacrpnErD67nRcN3/GqMUQgbWz4niG4/GMA6pkm1e/D2gHV2pAVfi28SOWOMIRDWk
         8U+wFi5gh6FWsQTLspeDrU3joJcCOxMneKytB0E5SBmXh8TqsHz7Gy87cFU2gbuGF9hR
         99+oa5BXWFbL/iXD9YwtO/6Fl1qWStvVHJyHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Sz/7ENEAx45gBAphCQu33YD+axd5XhAo6fkcJvfvnk8=;
        b=7rygDD/MaobiQwZQcPxvToa2J/uIUOUiFrv2Dycdh4sau20/N59jz4eY8KtF96SOJR
         pcFkLu0B0n1sCHhPXnWg0jXgsK6RaYwQKD68KD4bCWG/cqxXVl3tCQ+Kxh0+BKdOyvoy
         eS7zLKhZOPwwQR/4P+Nfd0JMyA/LPwWHhdQTAJ05ngUxzbVJi4+3JNRFAI8/Qg4ZlBtK
         Y0D1t2lEbiesGYAjeeLzLp4ounROIcYLwDUCJtryidqD4CZTnxWB9Hmuk9phO2AtwRGC
         DvoRmO8jRgUkvsMwfbT/GBMo3R7dmDsm2jTNUac1aA0FwtUNsuDiqJhEk++R9KZnu1tG
         A09w==
X-Gm-Message-State: ACrzQf3tOYZ1Kbci35RhnBhhMgYSNXPkP14loI3sSaxCdxHQk8zXM7jq
        w9jb1c/81yI1jLIkymRR1l1R7si6aqAsEk8EEfDSAH36AmI=
X-Google-Smtp-Source: AMsMyM6xIFILRmwJkVXhTIhh1kNVEjhYvcCInbiOMF9fGMFarE4DYfYfqeZfW4cB4B1Axl+ynZ4gZkZ3XnsMoj3vsBI=
X-Received: by 2002:a17:906:9751:b0:783:87e0:4e38 with SMTP id
 o17-20020a170906975100b0078387e04e38mr14945082ejy.257.1664815158410; Mon, 03
 Oct 2022 09:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221003110533.GA9355@alpha.franken.de>
In-Reply-To: <20221003110533.GA9355@alpha.franken.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Oct 2022 09:39:06 -0700
Message-ID: <CAADWXX8ESLDdwvUFvehj2CTPX_9reSedh1cXXirqMpFpvmQJaw@mail.gmail.com>
Subject: Re: [GIT PULL] MIPS changes for v6.1
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 3, 2022 at 4:05 AM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.1

Pulled. However, the reason I'm answering the email is because it was
caught in my spam folder.

There is nothing bad that stands out to me, and it has proper SPF records.

It's probably something you can't do much about (like your ISP having
spammers on nearby IP addresses), but I thought I'd mention it anyway.

There's no DKIM - setting that up *might* help, and distinguish you
from the bad people.

                  Linus
