Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA99B5EF92B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbiI2Pfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbiI2Pdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:33:55 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD801B263F;
        Thu, 29 Sep 2022 08:33:35 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id c9so1984617ybf.5;
        Thu, 29 Sep 2022 08:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=aXaeQFl7WeBGM1OGQQKe5SOEmDdnmC4Z6lKLU12QUBw=;
        b=g6RhftYXeZcYpBxrpOfyc4VefrqsfhcLmEVqC8sATZDdsTl9waWQlqIg7pTBDmTAhs
         8rEV62yD1c8833Fk/ymXMAoLLb7EcbXJA+npk34Rk0WnQz07h+Blva3s5QnvtEBN5G/9
         Po/I6b5uquQK9gfIr5StbAWqv1RzkI2KRcq/VAo34sQVBn34/xEeKKe/wBNoW+ssRkk8
         wsk61DM1mHjJ0lKxe4NQQv/j4vwXjIv9CROt5jCStZAMhlX+wn6qIW//nxazrOjl8wRt
         +f6CW/pO7kyEmQVVHVNAq0NgJizggmiS9JJJbAUQd5mROQOjHQjn2IkS/Gsh4D3eub7i
         cNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=aXaeQFl7WeBGM1OGQQKe5SOEmDdnmC4Z6lKLU12QUBw=;
        b=GhjiyKYk+dLjmLA2FQF5yrQlT5eVNHIeggBmOAAGbkNaTth9O6O8tpvJSnonTVtFPo
         3bR/qveAiEGVY28QOhM6PuoUs+5nA7eyJDnmoeJ1gjByLaBqB7hYZPryJnXtaqgU/RXp
         kRM9klpBaYfVSTeuQYi9QDnn/ToYd/Nr1De5iH2ujkmRqtCF2BdSHs8zmJwm8yrL2pDc
         6TNZdeM1Jjk/m6wyZspg6U2zdzywK6JN7MvHIPJNeLSFES8mDaeFwUFUozkTpQF/R/eg
         d7tc5PSdD7C/5sPmVkCIUGADowwR4Qs7ADHPq8cHcpb98THfh8/IGNIgkjWwvGfs9Ug+
         V2/g==
X-Gm-Message-State: ACrzQf298m1JQDKiIgsDH9GUpySdJjBQHkXEmfEtr8GBs1ZNp0CC7ZNN
        1p6YWbbd03hE+DQ5qA8ue7/cmQ2cJPzau80kgYg=
X-Google-Smtp-Source: AMsMyM4Sdv0hIIfsBVFD5fjzLKQMsYtCX9dgkbEmSQRlCy0yCX0lUGRJa0EMdijIOlrV6c6c/UR3kKaykbj3FB+Q5kg=
X-Received: by 2002:a25:9b43:0:b0:6b3:9cc2:a651 with SMTP id
 u3-20020a259b43000000b006b39cc2a651mr3606130ybo.485.1664465614724; Thu, 29
 Sep 2022 08:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220929101515.354-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220929101515.354-1-lukas.bulwahn@gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 29 Sep 2022 08:33:23 -0700
Message-ID: <CAMo8Bf+MHVLOh-U0EyP1DoJPDSHscC=st0TYZ9L76+xgfBxaOQ@mail.gmail.com>
Subject: Re: [PATCH] xtensa: update config files
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 3:15 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Clean up config files by:
>   - removing configs that were deleted in the past
>   - removing configs not in tree and without recently pending patches
>   - adding new configs that are replacements for old configs in the file
>
> For some detailed information, see Link.
>
> Link: https://lore.kernel.org/kernel-janitors/20220929090645.1389-1-lukas.bulwahn@gmail.com/
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  arch/xtensa/configs/audio_kc705_defconfig   | 1 -
>  arch/xtensa/configs/cadence_csp_defconfig   | 4 ----
>  arch/xtensa/configs/generic_kc705_defconfig | 1 -
>  arch/xtensa/configs/nommu_kc705_defconfig   | 1 -
>  arch/xtensa/configs/smp_lx200_defconfig     | 1 -
>  arch/xtensa/configs/xip_kc705_defconfig     | 1 -
>  6 files changed, 9 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
