Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678686FD399
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 03:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbjEJBm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 21:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjEJBmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 21:42:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED163596;
        Tue,  9 May 2023 18:42:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B01246389E;
        Wed, 10 May 2023 01:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79BAC433EF;
        Wed, 10 May 2023 01:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683682972;
        bh=f/rcaaI0vOxfs1ijETmOM15ICYB5wdv1jc5B+TEIPJ4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=W4RjvBr2p+u/Q4LGfwnGvSjdWOgdtFDInkNQ8PfaZz0iNLHiyQxq5nxmlA5jktPPM
         ww6WOsu2GkXXn6exT7sHrV2bRvaHkXxv05JZvra4aR093Hkn4ZQNpUTlRNHemRVP6E
         k9kGgNC0Y2k/XXdDQqGhPPWOPy9ERoIVoYkbZ6kfY25od9U6NleE4UpPo+HDJoMgvH
         kKfx4AHOLI1W0czyptASUScCtXBwaKq7mKngpC/c7UMJyyWlRNjgF4bpl8fS5GonFM
         fmP62JH1RCz9ICG9GGKYve3+3tdAltooNjYaT/2hf1mWrHlU/H8PMsxvX4y4Ui41Fi
         z4PWqloKcABcg==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-54f2ae4b825so2555039eaf.0;
        Tue, 09 May 2023 18:42:52 -0700 (PDT)
X-Gm-Message-State: AC+VfDw2MnWcWSOZpsJcPVgSoQhdqZSwrVNkZk1I55x8ALewh/kX6cn6
        MjGg8m/DpnmD6GCsDcXRxTE27liS93BthyhJh0g=
X-Google-Smtp-Source: ACHHUZ439VAAMegvsPiMPVTxgTWk+w3QZywrOAPF38lmCJ+XBlvQi+He+rwyYvcEi0Uku8fNESdEAa1o0B5E1Rw2EJ8=
X-Received: by 2002:a05:6820:291:b0:54f:51f3:48b0 with SMTP id
 q17-20020a056820029100b0054f51f348b0mr2313500ood.7.1683682972035; Tue, 09 May
 2023 18:42:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:290:0:b0:4da:311c:525d with HTTP; Tue, 9 May 2023
 18:42:51 -0700 (PDT)
In-Reply-To: <20221017213303.862794-1-colin.i.king@gmail.com>
References: <20221017213303.862794-1-colin.i.king@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 10 May 2023 10:42:51 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_ReyuZWQp6uMkaz6+fmWjtN0yrdfbEsF=fJTn84+5dpw@mail.gmail.com>
Message-ID: <CAKYAXd_ReyuZWQp6uMkaz6+fmWjtN0yrdfbEsF=fJTn84+5dpw@mail.gmail.com>
Subject: Re: [PATCH] fs/ntfs: remove redundant assignment to pointer m
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-10-18 6:33 GMT+09:00, Colin Ian King <colin.i.king@gmail.com>:
> The pointer m is being assigned a value that is never read, it
> is being re-assigned to a NULL later on. The assignment is
> redundant and can be removed.
>
> Cleans up clang scan build warning:
> fs/ntfs/file.c:194:3: warning: Value stored to 'm' is never
> read [deadcode.DeadStores]
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
