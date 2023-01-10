Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7731B66474E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjAJRVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbjAJRUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:20:35 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2505F49C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:19:07 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-4bf16baa865so162260967b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+pIR1imfCvqODCp5Ce7sb3iOjvWIQIzon43M7wnw22o=;
        b=MRbadR54PUQDdCIai9nJWMaeKj5ncad8pWKlcT7e04GbC6M3gwJlojUB0qAc+uLpvO
         IS08JsnGRYIs97dXEH7k2Q27+tW9YdC8Dh/XNqNj09mf5jo/rR5oxo2scQafRDgKp30/
         S/siWqkNp+nC6Kxf9I6OGhIOiG5UVIyQmaF/OX/YvyGoPhwGFcFlbUoAI7ZekIEqJmLw
         SXlKkiXfX83tS/To0WX2f3RELMAm+6+991rB3ALW0DoT5bK+4hVVBVB18B72jKkaudnz
         pGOSCLklBu09OTvj3xkSFairxub63+6L262bEdHQzwtpsg/U6Kl5eF2kDQi9nQNS1i8f
         G2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+pIR1imfCvqODCp5Ce7sb3iOjvWIQIzon43M7wnw22o=;
        b=Cgtw1wVIjAXdbVVFYj/GaUTBU6lG1peaG8P8jW0e/iD3GZRZGTu+O6lewmA5os7Oxe
         5QcyGYiSYY4HjeK6PbqdRR4yu39B0kn3tL9iSr/YJwcUGiFYfkgfKQMRB4NPZCLQ4U5F
         iAsYJ6eMycIZpUCCYNZmalaQj7eG0ceh5ymrQudelBNQWhRQ/jygY8j4ldA2mLTHHdhu
         L1+NvH99b7CxTLWkTljXz3kCU7lEXFvnP7DRwiauOvtZ6g8v1csumjRqiM49ATJjVy1w
         bMDmeKLEN2x2FQZtgSPKr1DfIIXnkenVidNAzdcReGV8sLl5sQH+e4dgP512Ipqbdtds
         0jSA==
X-Gm-Message-State: AFqh2kohTX0WsnWk11op5qajRW0i2SecDay2NLJjwXemfIov9BVFqN6t
        xaYX7CGBMymF3uQ/EVs48tRfU001x4ydM454kM42DA==
X-Google-Smtp-Source: AMrXdXsqgQXm7Kgt01NaJGDiQufRhFUocj8hmyB9Qed/vzpPjWBQitOJZD0yCuctSmrr6bZGwmuCrBiI6yHbWm7eyLk=
X-Received: by 2002:a81:4a56:0:b0:4aa:36f9:a625 with SMTP id
 x83-20020a814a56000000b004aa36f9a625mr3236828ywa.269.1673371146769; Tue, 10
 Jan 2023 09:19:06 -0800 (PST)
MIME-Version: 1.0
References: <20230110094246.1497d12e@canb.auug.org.au>
In-Reply-To: <20230110094246.1497d12e@canb.auug.org.au>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Tue, 10 Jan 2023 18:18:55 +0100
Message-ID: <CACMJSescGSdZ4imkNkOEUzfkkwuy=ydHLC3gxwzBywO1bmcZMw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the davinci tree with the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2023 at 23:42, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the davinci tree got a conflict in:
>
>   arch/arm/mach-davinci/board-dm365-evm.c
>
> between commit:
>
>   fef6ca600ba7 ("ARM: davinci: remove unused board support")
>
> from the arm-soc tree and commit:
>
>   84bde55c050b ("ARM: davinci: fix repeated words in comments")
>
> from the davinci tree.
>
> I fixed it up (I removed the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell

I backed out this patch, thanks!

Bart
