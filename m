Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5422E6A4620
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjB0Pc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjB0PcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:32:10 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DBE2310C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:32:06 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id ky4so7121430plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vzLIC74mB4AwHY8XZKujyRlKy1H/v8jLcorp2jlzWKI=;
        b=rn2fD9rsD+flcfwbZ84UDOjziBTFna+IHPFzXHCPW1Yzl4fraiAdSBPnSJyrxvCOLB
         92iPch09wt00afbcOo/z92y+270U/I8xPA1HmCsvRioGbFgK4eV7IYUqHZNeh6NeIAuX
         JYgz5bOAQrkTqd9Yi8gjFD62Mvn/LfZ9nLh9DxzINU63gJJfTRnnzk6ibXC1N0xvt0zn
         CZNBVGnU1NVzWfshIig6wTqCwSQsPBh+oYa6pehfaTwmYnIgfAZC23UlBjvmWXq/CxU5
         466+NRjzW1Zibn4WN1YfwH1grqJRpdONzLm27Bw8Btuk9yCZRWBhXp1AEujakFQDVH1m
         nxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vzLIC74mB4AwHY8XZKujyRlKy1H/v8jLcorp2jlzWKI=;
        b=QohGKOw5qUqRhQFmbdpeoWFJJFRzBNvsnwLSvv8B60BLTU2ei9oVVzREmm4okEOWiO
         AIJSQqSUfE6CCI19XP8SB070ryOGrC2fHOeVsRqzAJkDkmy++tldLP9biZB3NaCM//ur
         heZRZSnxa+UCmcttRq2MzE6QI/Uo4+XYfmgUaJ2zMQu5UkqpdC7ygL9Y54j80+wstU0V
         jQtvHmUURXoPNJgKucd7eM/lkhPXBLIOQ60ehMaiKNx8Cmla6cDEi1nNd5AiM9iMZP5J
         E0HgM8jiKH7ggPZCFzbYsxwqPeFM0HKUb/AxzEq9Iuwy3Rh+87/SlUstgWq+C5W8R/LJ
         ai8A==
X-Gm-Message-State: AO0yUKUr8doYqWlQ+fBiT/Du3tUFs4F4un0nEUwArLLWhs0XUdC4OLtn
        YQmE5qKLRh9oBz1kR64G0mX27+YiINcf5zGbMoOySQ==
X-Google-Smtp-Source: AK7set/ieFVvPk5OsQRJ/WKQ5w2et0AxhClz7JOXVNp6TN5ekbvqgj9/a9oDkKRVv7jSrVMImvXaObbch9JIl078zXs=
X-Received: by 2002:a17:90b:fd8:b0:236:855f:f9a8 with SMTP id
 gd24-20020a17090b0fd800b00236855ff9a8mr4890098pjb.9.1677511926439; Mon, 27
 Feb 2023 07:32:06 -0800 (PST)
MIME-Version: 1.0
References: <20230223141402.23979-1-swati.agarwal@amd.com> <CAPDyKFoGmHpdt5UckyDTWQSK7OmZ789g9Owz7sPP4VJ6ezJbsQ@mail.gmail.com>
 <6e037df0-8f59-9277-3f40-c22278e02430@amd.com>
In-Reply-To: <6e037df0-8f59-9277-3f40-c22278e02430@amd.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 27 Feb 2023 16:31:30 +0100
Message-ID: <CAPDyKFoJUS01wFVPbri05SdJa-Y5qhmBxWnnXFUGnsm+zCpUfw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add support to request the "gate" clock
To:     Michal Simek <michal.simek@amd.com>
Cc:     Swati Agarwal <swati.agarwal@amd.com>, adrian.hunter@intel.com,
        michal.simek@xilinx.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@amd.com
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

On Mon, 27 Feb 2023 at 16:09, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 2/27/23 15:56, Ulf Hansson wrote:
> > CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
> >
> >
> > On Thu, 23 Feb 2023 at 15:14, Swati Agarwal <swati.agarwal@amd.com> wrote:
> >>
> >> Add support to read the optional "gate" clock property and request the
> >> clock which will be used to ungate the DLL clock.
> >>
> >> For Xilinx platforms which has DLL module, dll clock must be
> >> ungated/enabled when SD controller operates at higher frequencies like 50
> >> MHz, 100 MHz and 200 MHz. This will be done by explicitly requesting gate
> >> clock from the driver.
> >
> > I guess we need to update the DT bindings too?
>
> DT binding has it already. It is just not used.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml?h=v6.2#n110

Aha, thanks for the pointer!

Kind regards
Uffe
