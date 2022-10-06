Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DB95F5EAF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 04:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiJFCTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 22:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiJFCS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 22:18:59 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82E8691A6;
        Wed,  5 Oct 2022 19:18:58 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id p89so167433uap.12;
        Wed, 05 Oct 2022 19:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=eGPq4sodvo6Ap9hA+OuAlGWDufhHddw15s6Ys0QiE3Y=;
        b=HDtDXYS75xd0PAP+M6i2luT8JCAbCP0wSNHecW8HBU/QhdM9dmMtCo278eHPByDvT7
         6me3WTvEBgVxj3zV5A3Ro23L5e/AzkXyD+ydc2paazYC7YrZyFOpMxDYznFu90wXL8wg
         p/g/R808ehu5n1OxHs6eisBogkoA7JkX+/RywEZ6iaqc1P6KWsfRNpYNiqVdv2saFU77
         eHGwFHRZf95CKFzj1Yh7CgVbWJQ5bL8afGwmQNgO8+oCP33BJ+h9EJqC8mi9cp16GwTj
         qZORsIXFDOPMig+9wFupUz0X/y82NhvM4MgZowd22av91AGToKBprtBKppqltBTXrPVf
         H0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=eGPq4sodvo6Ap9hA+OuAlGWDufhHddw15s6Ys0QiE3Y=;
        b=exw3OFjGfRmoRokzG9yugX9ypUmXkJLuZixgSLqeykqzOM25KaBVLoBiq0+WfJkgdA
         ViIccpLnGPLvcdWxPeuXFq+keOSZ2y0dyw3mppoZSUKR20rqmQaGfSqtPIM7a57urFnK
         YGwIQ2sjogxjcg0YGEhqDiVQVx5eTmfrGR5cgmwFgFYQpcecw4qtZRH8Qj4f0oGJwZD3
         QK2zyCk88OaRURaG/sQKXQDr07PGRwstuU+i0LyDg1UR3GXhncZJpc3CvnKBqY0u0N+3
         ltSpLAE5CJ0pLewe4MqAQuvqmWiNUUfhlMA7wvmDBa0xHoyDqCf+fOhlTF/dgtX5TfyW
         Zkxg==
X-Gm-Message-State: ACrzQf14hWb6b52k8yjmBV7DXVZN7e+ei4f1cj3vhfStqZrqCFrCKKHh
        8hjvo2pikV21mliRYloQjTn7BGk7yCTuemebyqFW8Eky
X-Google-Smtp-Source: AMsMyM5sPGObQZoB1XH86vMDw8pG4NjBxWkzpDRI5o//71KuFWzKAip2PEtTXTZfRD7Iwh1lYDM65RmYHYsJ7JC/fqM=
X-Received: by 2002:ab0:7c7c:0:b0:3d9:d475:29fe with SMTP id
 h28-20020ab07c7c000000b003d9d47529femr1360633uax.4.1665022737841; Wed, 05 Oct
 2022 19:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221006103009.35fca676@canb.auug.org.au>
In-Reply-To: <20221006103009.35fca676@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 5 Oct 2022 21:18:46 -0500
Message-ID: <CAH2r5mtRMbwbpFCBgiN6qJhYkCjAeZ5WL=6gN7yZeq34TDxgKg@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     CIFS <linux-cifs@vger.kernel.org>, Paulo Alcantara <pc@cjr.nz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed

On Wed, Oct 5, 2022 at 6:30 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   395381a6c0f7 ("cifs: fix uninitialised var in smb2_compound_op()")
>
> Fixes tag
>
>   Fixes: 5079f2691f73 ("cifs: improve symlink handling for smb2+")
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Maybe you meant
>
> Fixes: d689449ef101 ("cifs: improve symlink handling for smb2+")
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
