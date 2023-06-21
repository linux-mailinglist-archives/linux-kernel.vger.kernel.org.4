Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFF2738E21
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjFUSHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjFUSHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:07:14 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1548C9B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:07:12 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3420ed1a745so25637255ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687370831; x=1689962831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xRr9n5Ja/psBKS+6MNHnejSVS97jyA4dH+zKLAsK+/A=;
        b=rz6F2iQOk881Wz6qR5Srwdgd7D/tuciAU82A+dAoQBRy5RkFO3sAtv2NJCd/412bCQ
         GaNjayb0aJl+HOWKvEo/xChZIQF1xulaNHWW1akBOfzj2EvvAMSTuvXJ/qUCC0KjtTsv
         UD24TnHXTjIpwiTiGafs9tNvxY60fGYIrRdWTz02ad1jn0nplNRLorqMS1ZJW9S4uI/y
         v9oe4j4Spv7NXz6LloalAQW9QUNzNeTpljZqSufmjd9SfNNl0McvOjTaaRoVDD+U6jDu
         ObrvZqSlCuFCj4qKaEh+zwcS8UFulhlbkx51pCHLadOf+bSoshNA9FByuuT8CsAgCuQh
         doCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687370831; x=1689962831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRr9n5Ja/psBKS+6MNHnejSVS97jyA4dH+zKLAsK+/A=;
        b=hG9OJgXMXbVPGdwFim/7PIBXZNmn+UN08V17+o8PB21peje6aua+RCgyfcHu5GgFau
         cGD0FFRLI5NRKRl5Vx/rsY88tzNg+PBg24XbX2zaTKcAEBQEffrFZk8sfSGPb0Sj7nK2
         dSuoGhtKhnfMuVu+zS4XWMB/mB3uETgu2z8dJIuqU8bBXeUCx4yoSzXCA0vb8S7iOKUx
         eypPRHNEMh7cWqUE6nnySfBY8ljSgwg/dLfZZXxF7NJWTWyqm3AneB//lGWG8vQZhi98
         Qbl7qpdcN+NFyX7tVCR3qOjKw8+qm6v047XXrpJq1AzpQnDZzS+b1cSnCEHfQwp0GrNv
         9TFQ==
X-Gm-Message-State: AC+VfDwyDBONg4pMop/iMthdwhExagFUEWYpWnp3UBLJG4H8hzzLsMUN
        iXvwrxF9Ajg3N7FNNHtPmHG8ZeIRUD5Ckw==
X-Google-Smtp-Source: ACHHUZ5RDgONO4MUWIB27Rh7PQJDBjcYXRoq7Z0e313xdXem7cqP4wQbrW9ob9jo0eVKalPPx1km6w==
X-Received: by 2002:a92:c10e:0:b0:340:b1af:bc1b with SMTP id p14-20020a92c10e000000b00340b1afbc1bmr15193073ile.23.1687370831141;
        Wed, 21 Jun 2023 11:07:11 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id il8-20020a17090b164800b0025b83c6227asm3508187pjb.3.2023.06.21.11.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:07:10 -0700 (PDT)
Date:   Wed, 21 Jun 2023 11:07:08 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH v1 0/2] bimap API: Add couple of files to MAINTAINERS
Message-ID: <ZJM8TBQJjR40y9/e@yury-ThinkPad>
References: <20230621162626.86033-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621162626.86033-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 07:26:24PM +0300, Andy Shevchenko wrote:
> During discussion
> https://lore.kernel.org/r/20230509051403.2748545-1-lucas.demarchi@intel.com
> I was started wondering why neither Yury nor Rasmus commented on that.
> 
> Hence I wanted to add some headers to the bitmap API MAINTAINERS for
> watching the changes made elsewhere are they may correlate with bit
> operations.
> 
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>

Thanks Andy!

Acked-by: Yury Norov <yury.norov@gmail.com>
