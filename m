Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35616718641
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjEaPZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbjEaPZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:25:10 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAF019D
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:24:33 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2563aaceda9so3183619a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685546669; x=1688138669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rPSS5zQqe8ryZeOShTWH96vVGNFc7PFZ5mRpSM2TTFE=;
        b=nX08p9cv7nCtNXRqU+C84NdPXJiL9DJRvK37U5ML9l9+5th2Bdsyk68Qq8HzQ6Qy/L
         9FkJVTd2zF/vPSoVQHRDhi5kt0Gwi74kcguT5wXqg7YIXjmYaHUK0jguzNqbCGSSc03O
         t3cy+xNRtuKKF1+6+XwXEQKU7fznVCzLqz8dGz31UC1caoEqq3Kbbq+fmRE49zvuuN0E
         2iiZMRfYMA5sXIkrhM0PNcLYGGlAZhLhBWdP3hUGpl9vvjacS5te5NqT8p9FR7BA0bQq
         8/HVZd/PebzRZCGkwiPnfDPpT3NnAOOZ5RGDaJ2mqoLORwXgSCDROZ318MXFyLJMtwPT
         ARLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685546669; x=1688138669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPSS5zQqe8ryZeOShTWH96vVGNFc7PFZ5mRpSM2TTFE=;
        b=dXTdSL0tG+uZJUe9ZoLj44K1gXc+JBvVs9NDFyAQOjx9fCLldbp0LeJ1IriCY/TIu2
         i3aOrWaSAeoSQMOkQKCCuUt2Et6nv+ULvFlhCDZGuqbqfgOxDUM6UJSdIrJcsJg+jqO2
         qAzPQdFFeSOIRw7FyKDLdlLlJ+WeQbMmAZTO2G3uPxmYHKJ5ZR3PdZbN7ttnUkWxNGpy
         i4X9y9Kec/Si1AiqVDoFWba4lh25jjvuLXR2UKvZYkzUesxri+1MdVPqluoUaiuo7H3O
         tSRwni3VFTX0PrPR6hN2YENvJe09zXdyZidUR98uSnqQtx5flnSUjbbZtBNaki6VrhGm
         6ClA==
X-Gm-Message-State: AC+VfDwHDBciz/vqut9nbXACESvyY2Upl5AGEfW8NHodWsVD687iKzq4
        M7wpeelSqMPw7LBUrLckYPSIMLXKGFdxAiOid7Q=
X-Google-Smtp-Source: ACHHUZ6F0bIA1CaJkts2ObAlZP3QStOZu7gocHi+t2NPRvIBg45mSKznx4RgQBbcs569WD1exfShchtsOLY2eD9LI4E=
X-Received: by 2002:a17:90a:600f:b0:249:748b:a232 with SMTP id
 y15-20020a17090a600f00b00249748ba232mr5001436pji.25.1685546668647; Wed, 31
 May 2023 08:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221217001554.554913-1-lstoakes@gmail.com> <Y51L496TjNuiSxsG@casper.infradead.org>
 <Y51/Mt70d++6Zzzq@lucifer> <20221219100734.jag6zejp4tug77yq@techsingularity.net>
In-Reply-To: <20221219100734.jag6zejp4tug77yq@techsingularity.net>
From:   Lorenzo Stoakes <lstoakes@gmail.com>
Date:   Wed, 31 May 2023 16:24:17 +0100
Message-ID: <CAA5enKbsmy99-GCNuVcDRbjESZaLuE4=s8+6PzWP8J-wmOZwEg@mail.gmail.com>
Subject: Re: [PATCH] mm: remove unused alloc_pages_bulk_list()
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Marco Elver <elver@google.com>,
        Michal Hocko <mhocko@suse.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2022 at 10:07, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Sat, Dec 17, 2022 at 08:34:58AM +0000, Lorenzo Stoakes wrote:
> I reckon we should give it another few months until May. There has been
> one user recently that tried to use list but it turned out arrays were
> more appropriate.
>

It being May 31st, it feels appropriate to chase this up :)

David's series at [0] did initially use this function, before
switching to the _array() variant. Other than that it seems that it
remains unused.

Cheers, Lorenzo

[0]:https://lore.kernel.org/all/20230522205744.2825689-1-dhowells@redhat.com/

> --
> Mel Gorman
> SUSE Labs



-- 
Lorenzo Stoakes
https://ljs.io
