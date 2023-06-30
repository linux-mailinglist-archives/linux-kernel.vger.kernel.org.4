Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E13E744490
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 00:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjF3WNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 18:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjF3WNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 18:13:02 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AC03C24;
        Fri, 30 Jun 2023 15:12:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b80ba9326bso17416165ad.1;
        Fri, 30 Jun 2023 15:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688163179; x=1690755179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=thoT2jC0QZieB1tqlGcvhahvmZEljvo2S9CLE9NXiwk=;
        b=bfn4PAMp/IiOCOx4AkyL59KnGpDp5CSKIgoZyWHUmB7fzTS8K5iygNy/7Arj5CVY4C
         DX5t5jLXmXwHVc7gUkT1tLZilPbyYQ8QGcO8YyFmnL7vdt+tLODVpIXVJtjSebTtTpTx
         qPm+nQutsUTCCSPRcVLl4/hVtfPedF54QYcnTRdeq/YXwYf0EVuUYR4foaoI1mGWyf6W
         HuXPY3xXVEnr0rWMpDjgOIAljAw1GFY/vU7cURa/WsUSfcPC5rWSreUWfjqXkvpYvv+f
         wfeyZ6dDasj6NU04fPa0adicbtZ7KfvAcuVBm5jF6UbGQdft4KFx2i+bSpILHovDn7xy
         s2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688163179; x=1690755179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thoT2jC0QZieB1tqlGcvhahvmZEljvo2S9CLE9NXiwk=;
        b=DMWxr9EtmUhA4rkd4PhQdAURUcdSHwvSB2xlxKAc+RKcm0BxNZcJ33zd7cJS+O0o76
         2o/KftP8J0EOFvLJ8GspzAH/ynYlvRRpPOh7rHUC3Wc4/7hP/m1PGXTHLhKSKlY+gz3L
         2Vb8WE71FttQKWpXfX1lU49NjE3GFixzOKTnE3yzOiwJ5s6twMDizEePCWLUxmFtclTm
         iUvliC0SUCY+22HF57uobeFLypH+j8IvM+wO8YJBUDnSjHhqsgp6ATaI6MhoajsgVMQC
         tHdKktUIky8QHe8tNDUVGpCs4rgyrCRd8UblrZVTGpQy/iYzBOF3fIoviR6KZ0uD/SA/
         j8dA==
X-Gm-Message-State: ABy/qLb0cSf78w5q6F38jYW/BEDr7akGjo9NeV5/k2utrhdD+aFw7MCT
        M+hP6eOyFz4p070JMaFEcKJKWjYQLBqcTDXP
X-Google-Smtp-Source: APBJJlFyldWzSp9PhFA7Agya7H/yUCrkXjkCzYAe0fV4ZlQpjDD4Y0yeYHlSjwVa7BRhU62OzHc1Kw==
X-Received: by 2002:a17:902:7081:b0:1b8:3e15:40e8 with SMTP id z1-20020a170902708100b001b83e1540e8mr2824804plk.56.1688163178998;
        Fri, 30 Jun 2023 15:12:58 -0700 (PDT)
Received: from localhost ([2405:6581:d4e0:1600:c494:2aca:bc01:6f7b])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902e9d500b001b8649e52f8sm2496453plk.254.2023.06.30.15.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 15:12:58 -0700 (PDT)
Date:   Sat, 1 Jul 2023 07:12:56 +0900
From:   Nick Hastings <nicholaschastings@gmail.com>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Lukas Wunner <lukas@wunner.de>,
        Salvatore Bonaccorso <carnil@debian.org>,
        "1036530@bugs.debian.org" <1036530@bugs.debian.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI
 string"? (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
Message-ID: <ZJ9TaCiYMiRAXm81@xps>
References: <CACO55tudULtvt_Hcdg+uqXeYkSAR_NZ1oD=R_KhuE_THSRe88g@mail.gmail.com>
 <MN0PR12MB6101DE067CF85E59AF187763E2499@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CACO55tuqAH5Zt+X9pjLFZ-RcFgxpgjpqmrAHPvm4=fb_DMBHyw@mail.gmail.com>
 <ZHkxYo/a+/uInkLG@xps>
 <MN0PR12MB610181D29933EE4787DE9BC8E24EA@MN0PR12MB6101.namprd12.prod.outlook.com>
 <ed5f982e-c12c-b3a2-1108-62fba50bf9db@leemhuis.info>
 <ZJoSWftrHO65wmxz@xps>
 <35e9ae66-76d0-5a17-31e6-7aa8de5bfadd@leemhuis.info>
 <ZJ9LPZcgkDLscww+@xps>
 <0bdbb7a3-b8fa-1afa-23cf-afde1cec3d25@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bdbb7a3-b8fa-1afa-23cf-afde1cec3d25@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Limonciello, Mario <mario.limonciello@amd.com> [230701 06:40]:
> 
> > > Nevertheless: thx for your report your help through this thread.
> > 
> > No problem. I am willing to try to do more, but right now I don't know
> > how to do what has been suggested.
> > 
> 
> Here is where to report Nouveau bugs:
> 
> https://gitlab.freedesktop.org/drm/nouveau/-/issues/

Thanks.

Done: https://gitlab.freedesktop.org/drm/nouveau/-/issues/241

Cheers,

Nick.

