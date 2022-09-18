Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2855BBE6A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 16:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiIROdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 10:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiIROdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 10:33:47 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7586E1FCC3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 07:33:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u9so59168376ejy.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 07:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=YdfdEKjpvf/n0/5C+OJTZ4gPftWh1t3E7BZU/XgU5qI=;
        b=DV3lmQEbtVxYC64nZl6YwDfxGmol8kxKwEV4JgyPGVslvMM0vZd6NcJyxRI8K++ou8
         bKB0cGNqRf4qoWUfDdAXp/gJE7lJdLDC2teU4INKNGUCvsnwoDRgzG/Yc1yPG3iSl/p8
         KIAQKym2j/Vb/LJNcbYLy6idXOzS7EosM4w/0nmiqdIQNdLz7MNquw1THfOYA0ohjAwy
         dXMYlSPbE8tMzvEqpYqel6fQ88iQJWoFYzi6fBbwgSARrJcws40WKoI89aS2wxBq+2ih
         micPwtjabhoYXouGfiBU4RlyIFERpDNBbtJHaB0SqJbjPdozY2Lp0Bwu+bNTZdbfGfOM
         1ZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YdfdEKjpvf/n0/5C+OJTZ4gPftWh1t3E7BZU/XgU5qI=;
        b=4YY6aYqdgPcDP1AoU9jNv2G/QGESp227EV8Y0V55FbZlh7xGmV1uRlen59WqV4l0ZR
         vaZbmnWb9l4lUtCS9+XdWfyUZu9NuNf93faodZgnWjhZcJstDHSP+/vbgTMMfERK/7Pq
         hLZQWecwTiQHdcTi8vrxBgWVp/Mul0EkQ4hvf7DIpM0mQtChBd8TDJdyK0TWgOnO5a/S
         e4/IdzcKfL4iTQE6QupUKJUCfmmTPVoHL8yRV2sk0laP0EAStezwSDCuTFfCw5WtF2IR
         9RmNqEgfJ7c1Hl7eyLoj+DmcDXn/ju0yJRcyi6xrTEQ6sxpyO72tOS/bABFS1gUjXEPX
         zVMQ==
X-Gm-Message-State: ACrzQf1ZheWsB5u3GAEAcutTi8FnqjHxz/NiDrgeRJNiLGuBkfernI/G
        CKZ4pbOh9y/+B07owvm/0ebCxoy5M5B/SOQzhZ+d9ojPWZXMHg==
X-Google-Smtp-Source: AMsMyM5hyowI3kuMOb7eoIT5Ld+NVGfFijI7wklVVj+nEnMlh4wrBMxNl0eHyDQ4IlRMMRnpP+w19OuuJ5ZOtPJj4fY=
X-Received: by 2002:a17:907:e9e:b0:77f:9688:2714 with SMTP id
 ho30-20020a1709070e9e00b0077f96882714mr10055429ejc.208.1663511624980; Sun, 18
 Sep 2022 07:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <202209170232.grVMomkJ-lkp@intel.com>
In-Reply-To: <202209170232.grVMomkJ-lkp@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 18 Sep 2022 16:33:33 +0200
Message-ID: <CACRpkdYGMToSn1XR0Zrvv3yKeOX7_tw0=y0NKhOXN7O8KL-Ntg@mail.gmail.com>
Subject: Re: [linux-stable-rc:linux-5.4.y 5364/5387] drivers/infiniband/sw/siw/siw_qp_tx.c:32:37:
 warning: cast to pointer from integer of different size
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 8:19 PM kernel test robot <lkp@intel.com> wrote:

> commit: e7f78835d551bb2deb5aa3346d84c8f03ade313d [5364/5387] RDMA/siw: Pass a pointer to virt_to_page()
> config: riscv-randconfig-r013-20220916 (https://download.01.org/0day-ci/archive/20220917/202209170232.grVMomkJ-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 12.1.0

So if RISCV32 ...

>     31          if (paddr)
>   > 32                  return virt_to_page((void *)paddr);

Think that passing a (void *) to virt_to_page() is a problem:

> warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>       32 |                 return virt_to_page((void *)paddr);

I would think this is a problem with RISCV32.

What has this arch done?

This is a few lines up:

> dma_addr_t paddr = siw_pbl_get_buffer(pbl, offset, NULL, idx);

dma_addr_t is a different size than (void *)?

Given that the patch raising this problem looked like this:

-               return virt_to_page(paddr);
+               return virt_to_page((void *)paddr);

I doubt that it has created a bug that wasn't there before. Passing
a dma_addr_t to virt_to_page() might be wrong, but that is what the
driver has been doing all the time.

siw_pbl_get_buffer() claims to
"Gets physical address backed by PBL element."
Why is that even passed to virt_to_page() if it's no virtual address
but a dma_addr_t to begin with?

I certainly don't understand SIW, but this bug, if it is a bug (or a type and
documentation bug) is clearly not new.

Yours,
Linus Walleij
