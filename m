Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C82682AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjAaK5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjAaK5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:57:06 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACD6A251
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:57:05 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id f7so6762143edw.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCW7Bu9eM7Tat1zvwvNXuene7Qwc0Ic2NetBKSDb5lA=;
        b=IB5YW3tMphygyoW35dbhvsJagt+V4nl8gnggOzRzcwiwUJKuS03OwZQM96Qcmp5auA
         nkXs07K3LzBqRJm+PIy1alYvQZhfWsLwUpwPqY+2KJ/Xp45TFcXVqOAZQzxuVbEtJma7
         ZAjX+NRVmx9/FpKAyGkt4LK4VOdDS4eqza6W4nmkhKkoBvGB4Dv7DS61994oJdlcGhrF
         OGneu9IcsCtsAQ16Z45I9/RSVneMD7MDpzOh4xwNDz0HiViTIL364JBwzGpZ6ZWAtw+n
         nmnu1vhvkk8CnT/vpv1lH54K8vzKE7QtUiDNGz1cpWk+eumX0gFra56tS4c7fnQ06aOF
         EMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCW7Bu9eM7Tat1zvwvNXuene7Qwc0Ic2NetBKSDb5lA=;
        b=JoWP2sSsQ5DR66S32WCK9ZLURWRY4sGj3GRTs0frRV5nR8vxYlmH8mNzvFmo/nisCy
         c1I12MWYyz9/rKXKmIiYgUjmk8q+AVBav7fPvpKitucmTDM9iRG4jgxe/ebbLPVAqhhR
         yxCj6wXjgAvCI/O3Ziib/1arEKCrX92t0+DmwCo5B1oE7FgsvVCN8Axe2F9Me93LDUnN
         OhccNpTqjTlhskIWVoCJyi8zXB9FOBbqp/CSDoNNVSAZeRKub7Zc8XmIUqka5PZOERBE
         y3xDB8g9ME30BEIc5lM1AJB6QbDKPzq2fUupBf5Qbdph3poUiTaJqXuOXxs8eRrZj3d4
         qXiw==
X-Gm-Message-State: AO0yUKUcZDKVJ9nLsRFgxu2bEczAt+OW0/52x6bY2/ehNHtpaIe31lgK
        YniXuuikQWO+wLznYvxToWg=
X-Google-Smtp-Source: AK7set9UFmwGXPdeCq6K+KaR/sZcUX1pu6+EKFrwMv8J9ojvjFho/vQGJNN/hbB17DYlI0ycOuX/PQ==
X-Received: by 2002:a50:cd91:0:b0:4a2:4ed3:c14c with SMTP id p17-20020a50cd91000000b004a24ed3c14cmr5800925edi.39.1675162624165;
        Tue, 31 Jan 2023 02:57:04 -0800 (PST)
Received: from andrea ([217.9.231.172])
        by smtp.gmail.com with ESMTPSA id d22-20020a50f696000000b00495f4535a33sm5222045edn.74.2023.01.31.02.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 02:57:03 -0800 (PST)
Date:   Tue, 31 Jan 2023 11:56:59 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        "liaochang (A)" <liaochang1@huawei.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        mark.rutland@arm.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: kprobe: Optimize kprobe with accurate atomicity
Message-ID: <Y9jz+zUDebQ4VLlF@andrea>
References: <20230126161559.1467374-1-guoren@kernel.org>
 <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
 <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com>
 <87r0vc9h4g.fsf@all.your.base.are.belong.to.us>
 <CAJF2gTQZWO8Ubi60nHn-J-8czqBnsp1Kdyoim3uLNkjbYd-H8Q@mail.gmail.com>
 <87ilgntdef.fsf@all.your.base.are.belong.to.us>
 <CAJF2gTTaartwjVdmtmsm1FqmYVuAq5_nGYU5zc6nkdTtCm200A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTTaartwjVdmtmsm1FqmYVuAq5_nGYU5zc6nkdTtCm200A@mail.gmail.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > It's the concurrent modification that I was referring to (removing
> > stop_machine()). You're saying "it'll always work", I'm saying "I'm not
> > so sure". :-) E.g., writing c.ebreak on an 32b insn. Can you say that
> Software must ensure write c.ebreak on the head of an 32b insn.
> 
> That means IFU only see:
>  - c.ebreak + broken/illegal insn.
> or
>  - origin insn
> 
> Even in the worst case, such as IFU fetches instructions one by one:
> If the IFU gets the origin insn, it will skip the broken/illegal insn.
> If the IFU gets the c.ebreak + broken/illegal insn, then an ebreak
> exception is raised.
> 
> Because c.ebreak would raise an exception, I don't see any problem.

That's the problem, this discussion is:

Reviewer: "I'm not sure, that's not written in our spec"
Submitter: "I said it, it's called -accurate atomicity-"

  Andrea
