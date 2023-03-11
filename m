Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E25C6B5C99
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 15:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCKOG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 09:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCKOG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 09:06:27 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E5DFEF2E
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:06:24 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q16so7537738wrw.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678543583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fxlq8/uTJgYMEbjtCGelYIUCNqfehue+4g7FgiD0hVY=;
        b=VUi3TsHSKJk/dBQ56YS4I8QSPOtNfTHud3Jgr+GSBFzLYIs/OQU96xnPGSQEzk2ONy
         sQS4StLl0uxIrZTPr1zjHT4dH/VWNuMdATbUbRcO5ydDNkQh04DPe5DX+noDalPl6VVk
         1PS3YDgqH7U3u9Qda9o7Fhucd5NZQVH/7NfrkaHFPsDEwfclBAuvLn9y/gCxHuKqKdCf
         OwwobKfMzwgez1R6W+jY2diQYIBNNuhxe2QDgEjxxE4+Ln8GQCmBsOFiiZr8z8tBsnIT
         UfV1nO5FYOsRkqPJ9jB6DlNoePqPrmkKYQfGZLb/Fyk0gfBfQk+Hq8pV4T+JeWv21uz6
         D1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678543583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fxlq8/uTJgYMEbjtCGelYIUCNqfehue+4g7FgiD0hVY=;
        b=ZUHcHdsw/5kAnNRPtDMeZJNAezV289PTfjoEsYrkueKi919O811OxtNuZKPc/Bq1AR
         LDcyGuNI2V3i9Orn+L/yHIAufjjAvlEYNSdzt8L8slvE9ZDAzhSlGvw8hXp8ANGlh4+f
         cpg8qB9TNcKthu5XPgSCHL+dL8bWj1+sVavlV7F+1O5++05lYH88sA7XFSV7Pu7bDjeY
         p/MVLa74SvDaMAYgBHUKbVTx8Q4VhD1aLuA0qRwGxoTaRxoD5oOvl1mBunIeRpRo3vJv
         27s+6cuwIVZao+li6LVM9V1UCSqQ1IB+qaIEZa2hfWxZyp4F/e1CFQxj39zobrbJI2wO
         rTfg==
X-Gm-Message-State: AO0yUKUez9ZK9uiPXB13x0YIhzMmLevQD2C5XED39M0ZcQaADqOTa4Em
        s1MPgG0qbdZlUAPn9JHiKitBZLMyLoqVTyYd
X-Google-Smtp-Source: AK7set+niR6ndaQ9lj9k0Qtm+UsNN96ToRd2biC72KZoJl9ovhVyeySqVSCqIKU2nFKzshlCcPloOg==
X-Received: by 2002:a05:6000:d0:b0:2ce:a46f:bbc5 with SMTP id q16-20020a05600000d000b002cea46fbbc5mr1167439wrx.34.1678543583210;
        Sat, 11 Mar 2023 06:06:23 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5091000000b002c55551e6e9sm2547829wrt.108.2023.03.11.06.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 06:06:22 -0800 (PST)
Date:   Sat, 11 Mar 2023 17:06:19 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
Cc:     outreachy@lists.linux.dev, pure.logic@nexus-software.ie,
        johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: eclose macro in a do - while loop
Message-ID: <10d2c15b-ff9f-4634-a013-7640c93435a7@kili.mountain>
References: <20230311135919.9129-1-eng.mennamahmoud.mm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311135919.9129-1-eng.mennamahmoud.mm@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 03:59:19PM +0200, Menna Mahmoud wrote:
> " ERROR: Macros with multiple statements should be enclosed in a do -
> while loop"
> 
> Reported by checkpath.
> 
> do loop with the conditional expression set to a constant
> value of zero (0).This creates a loop that
> will execute exactly one time.This is a coding idiom that
> allows a multi-line macro to be used anywhere
> that a single statement can be used.
> 
> So, enclose `gb_loopback_stats_attrs` macro in do - while (0) to
> fix checkpath error
> 
> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> ---

This breaks the build.  You need to compile the code before sending a
patch.

regards,
dan carpenter

