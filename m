Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34946574D6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 10:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiL1JmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 04:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiL1JmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 04:42:09 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FAE6456;
        Wed, 28 Dec 2022 01:42:06 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id b81so7207897vkf.1;
        Wed, 28 Dec 2022 01:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fwLk0wjxGIvhAq7dgs3jTc6JAPT5yAloCtLTEegt4xo=;
        b=Rj3269mP+Zl4qhDW7MsDPLmDP6tF+49SIZwkN+VgicWg0Lh+MM6wfzfed8Yevd11Ca
         IXyS/nw13+lolANzO+oXGSYaN0xQEv2Mx1ioSVy5ptMu1e1Pbc+2VAThBj0lsbhse7Su
         fqfFjpkPCyS0FRZ3NorPCwDa1AVLENVVNGVkae8Dp32EJNnQKP5SZI+bVNX4IChMwlqX
         AzDABDnLY7gtuzKSCBNcJkBFSiTVnq/Yz3F0XqyXhoKzHzcQ9uOLLJeMh6pfHw5Hlpp0
         n2nSwjObsMi9NuCQDWCA/zsGxwsBswa1D2NdCFScnjJJurb3Si0pz9n+TNrrZFva3FoP
         tJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwLk0wjxGIvhAq7dgs3jTc6JAPT5yAloCtLTEegt4xo=;
        b=1JDZ+NH0OgenhagGrtqq1G+7JfI/6saeSKnjC6YTP7Ye0z98mLoxsnmhfhFO7/z9/N
         6/pewt3hZ9oVti1+4Tk/KtMnpVpmWomKZFMYX3iviYJqz6wAReoFcRpekAGUJfb97wZM
         tUt+sFuStSqOJgA6tWvhafQQFGQF/th+H5PHGMcnyvdX+gU0qyjq6lbenPogEjYcp/MA
         EB8oB5WbTohs4y9gUVjatb+Ga/6tmjzKn9IHlK5h9uBJvtMAQpYpUi49RDEdcqBStEfs
         p7nxp1/xBl/Byw2OWFABIKwkrRcCRRhnpyW1Dru7yHpyD8OdGj+36xtmKSf5jPNy1+FR
         ctnA==
X-Gm-Message-State: AFqh2kpFfE5HppD5uQQ8YH6Tdz2tNtFeUcft2lcDvznZy7xuBJlmX+3Y
        SlL/iNNo+c8yj/47ZZH0T8HKrx096nCAlTE9wv8=
X-Google-Smtp-Source: AMrXdXuiO15bKKKO/sD+d/YsDkXXMmVgtIh2UUu6LekwHNnzWeW8s6XUBfaregIYgxtO4eVYcere42BjzWOrSO+I02A=
X-Received: by 2002:ac5:c382:0:b0:3bd:e0b8:e350 with SMTP id
 s2-20020ac5c382000000b003bde0b8e350mr2671281vkk.25.1672220525745; Wed, 28 Dec
 2022 01:42:05 -0800 (PST)
MIME-Version: 1.0
References: <20221227095123.2447948-1-milkfafa@gmail.com> <20221227095123.2447948-3-milkfafa@gmail.com>
 <0a3ece05-c94f-3d7e-2f90-b72b777617e5@linaro.org>
In-Reply-To: <0a3ece05-c94f-3d7e-2f90-b72b777617e5@linaro.org>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Wed, 28 Dec 2022 17:41:54 +0800
Message-ID: <CADnNmFp-RD6-6PUOJzF4GNW4zBoD+Zk6v0dGnmofLBxMWMEaow@mail.gmail.com>
Subject: Re: [PATCH v10 2/7] media: dt-binding: nuvoton: Add NPCM VCD and ECE engine
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, kwliu@nuvoton.com, kflin@nuvoton.com
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

> Subject - it is "dt-bindings", not "dt-bindings".
>
> Use subject prefixes matching the subsystem (which you can get for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching).

I'll correct it in the next patch. Thanks for the remind.

Regards,
Marvin
