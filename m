Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8807072495E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238241AbjFFQkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjFFQkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:40:46 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D637010C2;
        Tue,  6 Jun 2023 09:40:44 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f62cf9755eso2715037e87.1;
        Tue, 06 Jun 2023 09:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686069643; x=1688661643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=norESNq/iGPk1UB7TAGxhH8PXhOkHVXlC8bXJqdAByE=;
        b=MyU3pryKLoA3UVgvjV92Bc7JqT2MkUT3l6INkZZYfWD4Oavm1JcKHBdB3dAVTFhuCw
         PFlgeOhj6guDRAYm1JyAWM/NB5JSM36F2PxEkOaS0TRrb7ci6dg3oiuZxkn1WEhXvWJG
         9SCL8V3SYr7kx32iZzlr7WFRo4qDZCd2xcpkDsGy5dqsoNhqXGmA1aiQzNufBpNETM8u
         wSUJp5XHZPXao1HlhgEgjCzNGaXxFjzD35ixfQCnBsRjrhDL8kA+HaC/2ju/wgrM2DiG
         RMma3AtoPGJCTq/hx/qMUgQWopCZduj9rQP4keqnKErsY1mc1zqHh9fHb5MXx4LBb67m
         xaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686069643; x=1688661643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=norESNq/iGPk1UB7TAGxhH8PXhOkHVXlC8bXJqdAByE=;
        b=ELjUevAHNCnceHOMUlTirY4iZSbJaDYlWPx1i+JtMHQupQVfqUffadY7TLHgPpoRXb
         zslaNbdAgvIHIbmVa5p2Mgp2MwV8Zy4xZ1JPUfQagfAsdBsfzf9Rr0fnUnjDt6bUrxqC
         eBOaNEsEvTth/TIwGi0M26AkL6TtyxTMk7qN+GdIyKy+By0AOPJ65QYu2LngMefhE1B6
         QP8pKUk1+s9GsZo8lxTwXfn8FKZfeKENRkaTHxuVG6wGIwph62qabV4AVCZl9AAy5hWW
         N8h0nmx6XP+Wtu6R8G5xk3OXkHycOBWglpi7qOcZaylDhXda8cHXxor2JlqSYgwwRWzH
         L3wg==
X-Gm-Message-State: AC+VfDxVo/tCyG4N0OOeFROuW9Lh1bc3WkJ5kdzkmBwwztSs9jdzKxu8
        uZjAFVr5xO4msfnpC6H42OI=
X-Google-Smtp-Source: ACHHUZ7Z722i/xWTtbac8UrrnqqzXTdipL6Up2noyjRPmLNyTuQ82H1SwFMmUFDND/SxWY9hWgGaSQ==
X-Received: by 2002:ac2:4ace:0:b0:4e8:5112:1ff2 with SMTP id m14-20020ac24ace000000b004e851121ff2mr1180745lfp.27.1686069642782;
        Tue, 06 Jun 2023 09:40:42 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id d7-20020ac24c87000000b004f252003071sm1510897lfl.37.2023.06.06.09.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 09:40:42 -0700 (PDT)
Date:   Tue, 6 Jun 2023 19:40:40 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Abe Kohandel <abe.kohandel@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/2] spi: dw: Add compatible for Intel Mount Evans SoC
Message-ID: <20230606164040.s3ozznrkcclozugx@mobilestation>
References: <20230606145402.474866-1-abe.kohandel@intel.com>
 <168606867693.49694.16483038401822255147.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168606867693.49694.16483038401822255147.b4-ty@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 05:24:36PM +0100, Mark Brown wrote:
> On Tue, 06 Jun 2023 07:54:00 -0700, Abe Kohandel wrote:
> > The Intel Mount Evans SoC's Integrated Management Complex has a DW
> > apb_ssi_v4.02a controller. This series adds support for this controller.
> > 
> > No SoC level chip select override is provided and as such no DMA
> > configuration is done for the controller.
> > 
> > Thanks,
> > Abe
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Mark, next time please wait at least for a few days before applying.
Give me a chance to review.)

* In this case I have had a question regarding the in-code comment
which may have been needed to be fixed a bit.

-Serge(y)

> 
> Thanks!
> 
> [1/2] spi: dw: Add compatible for Intel Mount Evans SoC
>       commit: 0760d5d0e9f0c0e2200a0323a61d1995bb745dee
> [2/2] dt-bindings: spi: snps,dw-apb-ssi: Add compatible for Intel Mount Evans SoC
>       commit: 7bac98a338d63efb0b44ce4b79d53838491f00df
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 
