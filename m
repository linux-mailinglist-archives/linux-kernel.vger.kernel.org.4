Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF0874F5D1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjGKQnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbjGKQnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:43:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D7310C4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:43:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E41561572
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 16:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16386C433C7;
        Tue, 11 Jul 2023 16:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689093813;
        bh=eA2bGBHEF0CP+7ab4OmsDTkFauO4Whvf5Zoc+ACWKGo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=km9rbw9lLJXhEDqO6HEKU0oO5DBp2/07Xsyhp+pVcStemfdZrgwprWzznd1V6fA9E
         5SCJpg4nxyTuzZw1bvbp491zxP1paDRq8HQELuCVL7dUQ8avgzSg51AQyAoEolnKsu
         uTzXdberEhUoA7PNXcbuwxazXn4HRF1BnhYhXWpT5z7/kiHp9YbFfSjQ1lW/6crCph
         RWkWdkJXxNd7gUJuQ3B/HMOgheYkdPbHYrVXwNqmbnuKD65Iw2c0rKSHze4Ktr/TNz
         0pQvV/SbCtBBwRM7Umnvwf2GuyPYVYbsCmVwg2rkV4nz0M4yutyLz7jSaIsXvYYj97
         6j0tloE8K5DDA==
From:   Vinod Koul <vkoul@kernel.org>
To:     linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        schnelle@linux.ibm.com, eli.billauer@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, derek.kiernan@amd.com,
        dragan.cvetic@amd.com, linux@dominikbrodowski.net,
        Jonathan.Cameron@huawei.com, linus.walleij@linaro.org,
        tsbogend@alpha.franken.de, joyce.ooi@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, tglx@linutronix.de, maz@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        frowand.list@gmail.com, kernel test robot <lkp@intel.com>
In-Reply-To: <20230707135852.24292-1-bhe@redhat.com>
References: <20230707135852.24292-1-bhe@redhat.com>
Subject: Re: (subset) [PATCH 0/8] Make several Kconfig options depend on
 HAS_IOMEM
Message-Id: <168909380572.208562.4889103848181230553.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 22:13:25 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 07 Jul 2023 21:58:44 +0800, Baoquan He wrote:
> In thread of one patch posting, LKP test robot reported some compiling
> errors, paste the LKP report link here:
> 
> https://lore.kernel.org/all/202306211329.ticOJCSv-lkp@intel.com/T/#u
> 
> In the config file, several Kconfig options are like below:
> ------
> '# CONFIG_PCI is not set'
> CONFIG_OF_EARLY_FLATTREE=y
> CONFIG_DMA_DECLARE_COHERENT=y
> ------
> 
> [...]

Applied, thanks!

[1/8] idmaengine: make FSL_EDMA and INTEL_IDMA64 depends on HAS_IOMEM
      commit: 33629b377856fe5722a2a813b83d21e88281d474

Best regards,
-- 
~Vinod


