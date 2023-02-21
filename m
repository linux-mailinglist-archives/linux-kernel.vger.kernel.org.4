Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C60069E5DC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjBURWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjBURWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:22:51 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B9B2ED5C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:22:36 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id x24so6791885lfr.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qtT5hlg+/zC4hXH3H1IGc+jG9+X5kax+Az1cVRZz7sA=;
        b=JuVb3HrEF7XAO5m1HiEPAHKpNSvsgyl6feJwt8zMcG+YgxopwHWfnfkpkuOWztddEk
         l/P5NPjzMvO/ckGYobYNUipMpAaZTd3AeT2rp4DkQsBPp0UCJvmpuWhnJUcRhcLxLfJf
         Svnpwd/saTUHjrS/llRi7kzz7le7VHYqHtuV7GFekOj5ov4vGRzrHW0ntO+Lqnp3TjhP
         96iM5IU5Uu8cu4HUMhm7ddhPJVtUtJb76s8nZCksVUY8NO9uz2DJJyfvNyVYWcRJTAjF
         cGxT93SBWpWHQo4IgSl4tZn8SMfFyNLk5lq7iEQFXGXWiK/1Ep1pftii8qZy0Mu4IycJ
         l4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qtT5hlg+/zC4hXH3H1IGc+jG9+X5kax+Az1cVRZz7sA=;
        b=vkGG0OGH8P7ezc+EhqmyBGCYENNopLo85Ff+JpsoKWvrCDQm5sxzGRdx8pweeWfEsB
         7aIYkgQoyqJv6vygMG6erR/TVHXO6OTHBZqItxoN7AvRQjL7ZqGUk2tBlvXNK8EQSkbg
         ly9qtB1+dWjudw/BKm6eiTsT4i0dYg9H961nL+c2tVqGwuLoK8DI0nOQREa5KKIfEfY9
         h7srbR+LDaWYa7HRGayIAa58bAtwsrKeZgmaYuKDVjKZNlwpUVrcOiRHgDTjsbq9qYRb
         TkXjqhJiJhnG9nsx9KWen2IkdsuobKOku3Fx9cJG0xisklQmN/yvmfZqAw0HvXj8pPJv
         lfaA==
X-Gm-Message-State: AO0yUKXAYrcDS7YhL9bBH4O28K0orNU6EoYjlP4rI4bt+xXDccr3R9/D
        emtGcN+upTDKinSDWKl+0WCLHIajh4PGoZlnCyIzzg==
X-Google-Smtp-Source: AK7set+KdhF45hWyHg8ZBJ/+kClV9+ACFxSG/TGyjfXFlzAtNI/SuNRpZaShduJOZVKOMcAIA1az6xKMY5DlrM0TfRw=
X-Received: by 2002:a19:ee06:0:b0:4db:3ab2:896e with SMTP id
 g6-20020a19ee06000000b004db3ab2896emr2015400lfb.6.1677000154581; Tue, 21 Feb
 2023 09:22:34 -0800 (PST)
MIME-Version: 1.0
References: <20230217222130.85205-1-ilias.apalodimas@linaro.org> <20230221091458.7d026652@kernel.org>
In-Reply-To: <20230221091458.7d026652@kernel.org>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Tue, 21 Feb 2023 19:21:58 +0200
Message-ID: <CAC_iWjJO6-C+v5dRHxqvpCy_miwhG7g6J2=o8YzfumfMHiKZ0Q@mail.gmail.com>
Subject: Re: [PATCH v3] page_pool: add a comment explaining the fragment
 counter usage
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, alexander.duyck@gmail.com,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 at 19:15, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Sat, 18 Feb 2023 00:21:30 +0200 Ilias Apalodimas wrote:
> > When reading the page_pool code the first impression is that keeping
> > two separate counters, one being the page refcnt and the other being
> > fragment pp_frag_count, is counter-intuitive.
> >
> > However without that fragment counter we don't know when to reliably
> > destroy or sync the outstanding DMA mappings.  So let's add a comment
> > explaining this part.
>
> I discussed with Paolo off-list, since it's just a comment change
> I'll push it in.

Fair enough. Thanks Jakub.

Regards
/Ilias
