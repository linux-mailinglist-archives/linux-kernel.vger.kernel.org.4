Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD6C73DFD5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjFZMv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjFZMvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:51:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB34295B;
        Mon, 26 Jun 2023 05:50:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD03760E9B;
        Mon, 26 Jun 2023 12:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A53C433CA;
        Mon, 26 Jun 2023 12:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687783784;
        bh=2XaQSUe6bhcRx7rwbtKBMrrcXJOv092ZV1BMwhsl5Mg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=i4lnGt7sIDAq99bm+12r84RL3kUovh/OHsTh3B2rXPZDajhQ8tJZGpjuKitmwvP0D
         OZ9U1v7KKCxY9qQw5pXOtgyb1o4kqbhadI2oaivPE0xJWe6n6tsmqzUnwbgLuGVJH5
         mykovk8ZQfdc7dFQl1fInm4m305qFv/oz+GR5P/G8BAka3kMESoT/5sugKrT7N3ceY
         p8PIKTF0NdJPhRG+lDMWHxapVdBcMef0EDW8YpU8EIMqiOT4Q/x2udd639K2XwmmwM
         vnW9N0yUijrDlWLruGywf7fXnyE7qTM7h22RjFfUbbsCjxSlnfqmSEJC+HAY1/3+7F
         lE2xleSRgrdiA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1b03fb998c8so778625fac.3;
        Mon, 26 Jun 2023 05:49:44 -0700 (PDT)
X-Gm-Message-State: AC+VfDyn+RO/eRr230HJfBwVwHxq8HxDWF3c65e2hjw/mUvykzZ0jjaO
        fn9udHJHna75FM7oGf4x81+Oo4yJxOc3gcR6p+I=
X-Google-Smtp-Source: ACHHUZ7XfPJnhcHrGuYbg89fm2tCB5b5TQffRERSATMdzl0F3ODCEIiUcdTUu2SJGZ4WZIe8ZEKv6wMXz7gAQACRdjY=
X-Received: by 2002:a05:6870:d2a5:b0:1b0:49a7:c284 with SMTP id
 d37-20020a056870d2a500b001b049a7c284mr1413445oae.16.1687783783248; Mon, 26
 Jun 2023 05:49:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:11c3:0:b0:4e8:f6ff:2aab with HTTP; Mon, 26 Jun 2023
 05:49:42 -0700 (PDT)
In-Reply-To: <20230626123112.3624-1-youkangren@vivo.com>
References: <20230626123112.3624-1-youkangren@vivo.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 26 Jun 2023 21:49:42 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_qqK1JxtArtGGWuupAYf-mGGZqs=_pvn_WDz1QO_uogw@mail.gmail.com>
Message-ID: <CAKYAXd_qqK1JxtArtGGWuupAYf-mGGZqs=_pvn_WDz1QO_uogw@mail.gmail.com>
Subject: Re: [PATCH] fs: smb: server: Replace unneed variable ret with 0
To:     You Kangren <youkangren@vivo.com>
Cc:     Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>,
        "open list:KERNEL SMB3 SERVER (KSMBD)" <linux-cifs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-06-26 21:31 GMT+09:00, You Kangren <youkangren@vivo.com>:
> Replace unneed variable ret with 0 to make the code clean
>
> Signed-off-by: You Kangren <youkangren@vivo.com>
This has already been fixed by another developer.
Please see:
https://git.samba.org/?p=ksmbd.git;a=commit;h=ccb5889af97c03c67a83fcd649602034578c0d61

Thanks.
