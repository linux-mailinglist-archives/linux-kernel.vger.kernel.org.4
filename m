Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A12628AC9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbiKNUuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbiKNUuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:50:03 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C23A62C7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:50:02 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v17so19063821edc.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbXFOKeTUlYXn2Mg9KmKqBvEsVbH8a0lnnF+t/CHaYg=;
        b=My3IJzngB/YmGua1bnDr4KRu/psqtSBrjcP49Gz4NDfNxNbefC/yBb47pIj8h7ry+d
         VcFJX5+pYd3EpAtPYndWLxoXJDJaexmUGaosAK5p/GlJ4yQx1UeiTy/YMnFKS1UJuyC+
         0/M4iZ1nNABU8xtIkYFKEmtSMHwEov1KmDNEMd9xQnRmPod+cI9oBGtONSfsdN7WNU/7
         8EWNotEOdHHEMk48RzK2XJUJ1CKWhLs+Mh9x+ChVOo8xnON1Rh0/5RCHEqCIyOvDS2rD
         S93dH2Fi0lNvMHUne65iYpnZkIsXaePGmIgAraHs2vi1qzrqZUnCemkTrNb9rRQdfri0
         WjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbXFOKeTUlYXn2Mg9KmKqBvEsVbH8a0lnnF+t/CHaYg=;
        b=diFXXKhfUCB7ytFvw34WUZOkoc4bn18w+FuL6bdtKbcrf2w5km9hAwjyhXL/IhtGue
         U3CEhJz7H024yfac9gUCBi7+4e+zjBieJZ7n+PeBE/iOxkQ5BZlELentRbkx1x4wymUJ
         E5Kor2z0MpnGveuphWnlZIaPN5ZxVuxDezOIoOVvRHPzQ57uO2MR+KRRvp13BIv4fXz5
         mYaNnNbUkg/PLegt4echA5FYOT47+xTAo8TpBjzz/OCz/Qe3nDrDOaCqcraIIOZ8U60N
         JVeyEVUbXM/8rn2i3/6xc43BybSbxsGDB00fqWM9LspgaheLQNiqzJ0n6+Pb1bUS8VVE
         uQuA==
X-Gm-Message-State: ANoB5pkBIcxqLV2j2kvi2yvZ/R8tux2rlYYtJYwDsWGwaCCWX3eg052Z
        ePmyH3Bknrr5tPXvTKStQcg=
X-Google-Smtp-Source: AA0mqf7JKyTLxwyn9ebdI2jJKDOugaX3DChyW0LE9ULhC7qV0de1AoKqcbD5HjYp/rHBaR/CC5pqlw==
X-Received: by 2002:aa7:c446:0:b0:468:74:9820 with SMTP id n6-20020aa7c446000000b0046800749820mr3304216edr.288.1668459000719;
        Mon, 14 Nov 2022 12:50:00 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id v2-20020a170906292200b007aacfce2a91sm4605452ejd.27.2022.11.14.12.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 12:50:00 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 2/3] bus: sunxi-rsb: Support atomic transfers
Date:   Mon, 14 Nov 2022 21:49:58 +0100
Message-ID: <3506150.LM0AJKV5NW@jernej-laptop>
In-Reply-To: <20221114015749.28490-3-samuel@sholland.org>
References: <20221114015749.28490-1-samuel@sholland.org> <20221114015749.28490-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 14. november 2022 ob 02:57:48 CET je Samuel Holland 
napisal(a):
> When communicating with a PMIC during system poweroff (pm_power_off()),
> IRQs are disabled and we are in a RCU read-side critical section, so we
> cannot use wait_for_completion_io_timeout(). Instead, poll the status
> register for transfer completion.
> 
> Fixes: d787dcdb9c8f ("bus: sunxi-rsb: Add driver for Allwinner Reduced
> Serial Bus") Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


