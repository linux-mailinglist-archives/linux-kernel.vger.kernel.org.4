Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7024745482
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 06:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjGCEV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 00:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjGCEVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 00:21:55 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B747D188
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 21:21:52 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b88e99673eso4634285ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 21:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688358112; x=1690950112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4yCyxORhZQcSjW6+wQb0JHG8SHx3C9xb2wsZB0KAdpI=;
        b=hrs8TxzWqVROATb1+OO+b2scKvbkRUaPXE8wiQC3gOk/SRBZqMzOVrYrs/f17rNkqd
         NywN86FFrtLqy8fAMv8FhNiblVyHqCyz6vpyZqebVrvgO3ev+tC/Cr38by1gy0KG70fA
         iZKR0qUNE2EJjOhywKGq6YJbVbpAvoDclCTraEjqcN+v/H4gbKfk/V7N5Ztj+uKHMSwH
         vpyLcw/nk4GmAR1AUZiMrfPCXtucNbwSEFzKSkyctwPD653hxDFnHtYc3bSRmNiPA+em
         Sn9tlpzPXU0uirbvBbONeafLp0kQ72U0lHiVMaRQUsIycH/5jX2iUvG89jTxTRzebevg
         vt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688358112; x=1690950112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yCyxORhZQcSjW6+wQb0JHG8SHx3C9xb2wsZB0KAdpI=;
        b=Gm3GEhK/4PcaUsnsYso3Nuh4fvc+3+4nzBW9Msck3X1i2MokDDJtVi1sBpoGFhrICV
         maLe3z62LqgL9iei5oArdje1XJ2adiesDVXouZQj7sP5GnKenQ6MSa+UmyAcq/ImpKUq
         bFfPLcx7H09NdM0EeKFNzsIWGCBWybgITGFF8D/P3zPW12+sLJD3M45et5CipvaCRY++
         tfs5pSE7N0uFke+MJBoHV/o17hR/uDGX+7VvaeKDquPUv/Tf4mGRUjo29j5/ziwKf9D6
         ndLFRUrKzIhbMRKBVKhr1WoIHeMBES63Fw5uD0Kj7bXIMxKmT9k1AHj2ybL/wBmQG270
         rGwg==
X-Gm-Message-State: ABy/qLaY25t/Cq/D8cuPvNMhYHjouC6rPvRasTzJk7o2QiQjgXb70ot4
        Y0XkevLfvCz0i5rpeYEfR2c30g==
X-Google-Smtp-Source: APBJJlEuGGj6sFTOjEj6zdUt3a4LaoFocfAFlTOucF+WBrGmLI99yG1sSNGh9BMAqTV7PHKonGRnxA==
X-Received: by 2002:a17:903:1250:b0:1b5:5059:e733 with SMTP id u16-20020a170903125000b001b55059e733mr9689916plh.17.1688358112035;
        Sun, 02 Jul 2023 21:21:52 -0700 (PDT)
Received: from sunil-laptop ([106.51.184.72])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902bd0b00b001a9b29b6759sm14296207pls.183.2023.07.02.21.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 21:21:51 -0700 (PDT)
Date:   Mon, 3 Jul 2023 09:51:41 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Yunhui Cui <cuiyunhui@bytedance.com>, ardb@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, mark.rutland@arm.com, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com, alexghiti@rivosinc.com
Subject: Re: [PATCH v2 1/3] riscv: obtain ACPI RSDP from FFI.
Message-ID: <ZKJM1fG3JXEBApfj@sunil-laptop>
References: <20230702095735.860-1-cuiyunhui@bytedance.com>
 <20230702-headway-dreamlike-d7ba39ac4910@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230702-headway-dreamlike-d7ba39ac4910@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunhui Cui,
On Sun, Jul 02, 2023 at 02:47:41PM +0100, Conor Dooley wrote:
> Hey,
> %subject: riscv: obtain ACPI RSDP from FFI.
> 
> This subject is a bit unhelpful because FFI would commonly mean "foreign
> function interface" & you have not yet introduced it. It seems like it
> would be better to do s/FFI/devicetree/ or similar.
> Please also drop the full stop from the commit messages ;)
> 
> Please use a cover letter for multi-patch series & include changelogs.
> 
> +CC Sunil, Alex:
> 
> Can you guys please take a look at this & see if it is something that we
> want to do (ACPI without EFI)?
> 

We have supported ACPI only with UEFI. The current booting contract
between firmware and OS is to pass only one of DT or ACPI, not both.
This approach brings another booting contract for Linux mixing ACPI and
DT which affects RVI specs. As per policy and since it can affect
multiple OSs, a frozen RVI spec is required for taking this patch into
linux. So, could you please bring this topic for discussion in [1] and
get agreement?

Isn't it simpler to provide a minimum UEFI configuration table and
stubbed BS/RS? 

Have you done a PoC? I am curious how do you handle EFI memory map
dependencies.

In case this is approved, I am wondering why do we need new FFI?

[1] - https://lists.riscv.org/g/tech-brs

Thanks!
Sunil
