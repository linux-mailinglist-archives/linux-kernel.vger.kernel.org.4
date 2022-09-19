Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859F15BC38A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiISHgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiISHgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:36:42 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4A31A052
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:36:41 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l14so62459555eja.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LJdpyyNzLvr7q0tv893y8yCUamy2mFkSZIFkDptOKRs=;
        b=WxX1SLlG7RySGDUrJgpIvCZZPOssO0ZtizKfWPWRs+5lQjNpAmzhQqphs3N3pqHbYK
         7nfow4jfMKFVe3+BuHiyCKqnxEM5j+VZ8HfUiJrI7UqTFYXzzQS4rLeZnHCpWHW5ese/
         HcUo1WqcEx6SPwPqDNGF+wrKxjuXjkk/VyqZrmr2vFz6eYhL2RFVhJEug66zgqLKbpal
         Evs5NTiPeIGUYmGth3G4ZMFUcyreG8fLCFs9yxnxyMfumpQRuIbPCz9YRuMkD1iftHIO
         CY+Lw97wGCPjzTvP8GSeNkNnB9o8htmtUfNbkUBJGQ8GBqaGMrlCd1b0bKVWsnru7THL
         jaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LJdpyyNzLvr7q0tv893y8yCUamy2mFkSZIFkDptOKRs=;
        b=Toz0RRzzyJhZ3budH3MBCNfrPyTVf7RkTh8+gLz5by+txlDZa3TbPvTdewYquO1fct
         Gvw9jW1APb67qGHzydt4JMPf3RKdGiff6LjdahmoDAFgQ/kuS5TLnO0QDtPk4pQ+8Prg
         y7Hq7kFDsXnwt54+1dlByYs2pIV1DIKqk/I6cQY1D13ErTJgTghLaMc1EDDfxXRDtS30
         k58cl091CRl62VWDChf9YCHjZjyZNXEOO9VHSEaSzdjmdJ/qv1K2ZvbBdHpFjKtNAVa1
         sdGtnoR0QolpuZTwRUImZB7sf25ivePWLxFRPX4A9Me0SZi0w+qun3dMsOI99i0GaIF5
         0Kvg==
X-Gm-Message-State: ACrzQf3V9mVMdeklnnL4IMwHQXP2rzRu7uH8vIw7kg4NjPkydsbbAx4g
        nokgum/XjN3G8R6GMHndfBfJaRk6vghJ2qOVSvyVew==
X-Google-Smtp-Source: AMsMyM6z2r0A0G+YdJLW3c67eEpmz7sjf/h+lw90SncbokiYqAFsrj/PbvoVlJmRC5aTissCILOP6IQch32RwI/lzpM=
X-Received: by 2002:a17:907:7e94:b0:77a:c48b:c80 with SMTP id
 qb20-20020a1709077e9400b0077ac48b0c80mr11281824ejc.690.1663572999689; Mon, 19
 Sep 2022 00:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220919065435.27747-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220919065435.27747-1-lukas.bulwahn@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Sep 2022 09:36:28 +0200
Message-ID: <CACRpkdbGAJ1Zcwvit1mau-mCLvCZyMhT47MVnm4nhGzVv7DMDw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nomadik: remove dead code after DB8540 pinctrl removal
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 8:55 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit b6d09f780761 ("pinctrl: nomadik: Drop U8540/9540 support") removes
> the DB8540 pin controller driver and its config PINCTRL_DB8540.
>
> There is some code left-over in the generic nomadik pinctrl driver, i.e.,
> drivers/pinctrl/nomadik/pinctrl-nomadik.{ch}, that is still around for the
> removed DB8540 pin controller driver.
>
> Remove this remaining dead code.
>
> This issue was discovered with ./scripts/checkkconfigsymbols.py.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Nice cleanup, patch applied!

Yours,
Linus Walleij
