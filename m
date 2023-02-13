Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABE0693DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 06:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjBMFNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 00:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBMFNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 00:13:53 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2198FE3A7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 21:13:52 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id o8so9964823pls.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 21:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1/rXlbQZUiYssX0GWdtn60fAH8aeaRBmLehOaQBY1mE=;
        b=BczA9Dit8WldsIfP8UBgYlgc8TWJhovdzXsusWUlS+5qwERWfEecSRfNvw2jdkipTt
         FftWA7ruHlkUk3JVzZ1R2/G95S9ueaU75uXAfKH/d+o6Wvx4A4+tsy2UkZIZma/LHypW
         b1HtPzukBNiYeS0/OLsWF5NHpFKXqO/xMwlEYEGDKUzBZ8D91k9sx7/8fVBaxjddDALw
         /YCfRX/nPAgzOb51JRnSuTkMLiQr0ZQA5dXciGNdnFXKrI+gu84pYpUm/ENQNd65VC1s
         ugorSZLeiHIEBj3MNBjGdwfT2IeeGdw1kY8bm8vt05A2ZhJTkpwI5IEJNhKGy16PpfJv
         i99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/rXlbQZUiYssX0GWdtn60fAH8aeaRBmLehOaQBY1mE=;
        b=7woVO8dIiqRSYsOaha2k0fqRxOBM6OyQkahtjaswnSOU7AhcGJDq9CjbbU7fXDoxyQ
         3Q+zruTw71YzaE8P13LIKeG+Iq30CfqI9S9BoeYYyLoJASXj69SUN4Gly+xp5Q8BMXnI
         ITMtkKKlJ28ZU72KX71GhLVlnrsMoO0TaOdU79K4jb+GS98g+X6wlPZPjtSJ6hau54M7
         1RNT0AAs1DnIeSMRzUODR3jHYpmpqmN126sgkq4rcQcqp6k4ZbLyK/33DG3RPVP/69rK
         SfzMMNFMIJOpAa8ZQ3ahJNojifFTG/i2+hOJz2RYppYnK1NYY0sQjnTEICyE9pI+C8eO
         6j7g==
X-Gm-Message-State: AO0yUKXgS/mC7XwSr1EGVpW+yOsyQKEma4Y2BmJmPldPQqX3xVEjLPtA
        hf3TBtoU1DdC/s4Qhtt9jJV5hg==
X-Google-Smtp-Source: AK7set+HBd/TKOpekO2R5ZNBdJ5nlE4W2Q0OVyhq7zVLBYibkTxtu4XeGFM4NuzAT9/O7iEzdrKiyA==
X-Received: by 2002:a17:903:24c:b0:198:a715:d26d with SMTP id j12-20020a170903024c00b00198a715d26dmr25510023plh.8.1676265231494;
        Sun, 12 Feb 2023 21:13:51 -0800 (PST)
Received: from sunil-laptop ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902784900b00198f9fa23a3sm7079601pln.287.2023.02.12.21.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 21:13:51 -0800 (PST)
Date:   Mon, 13 Feb 2023 10:43:42 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Robert Moore <robert.moore@intel.com>,
        acpica-devel@lists.linuxfoundation.org
Subject: Re: [PATCH 02/24] ACPICA: MADT: Add RISC-V INTC interrupt controller
Message-ID: <Y+nHBivfemYR2NGD@sunil-laptop>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-3-sunilvl@ventanamicro.com>
 <Y+P/BDbP68vNTOao@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+P/BDbP68vNTOao@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 07:59:00PM +0000, Conor Dooley wrote:
> On Mon, Jan 30, 2023 at 11:52:03PM +0530, Sunil V L wrote:
> > The ECR to add RISC-V INTC interrupt controller is approved by
> > the UEFI forum and will be availabl in the next revision of
> 
> nit: available
> 
Thanks!

> > the ACPI specification.
> > 
> > This patch is not yet merged in ACPICA but a PR is raised.
> > 
> > ACPICA PR: https://github.com/acpica/acpica/pull/804
> 
> I had a quick check with git grep, and as this doesn't appear to be a
> regular pattern in the history, so could you please make this a regular
> Link: trailer?
> 
This patch should be merged in acpica repo first and then we will get
this in standard format. Until then, it exists to allow other
patches get reviewed. I believe by the time we get all other patches
reviewed, acpica will have this merged.

Thanks!
Sunil
