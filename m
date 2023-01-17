Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D901C66E1A6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjAQPHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjAQPHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:07:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562313D0B1;
        Tue, 17 Jan 2023 07:07:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1965BB811D5;
        Tue, 17 Jan 2023 15:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C8AC433F1;
        Tue, 17 Jan 2023 15:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673968046;
        bh=X+HCcwyHt3MGqJpCaG1w/tkEuW0Iyo5TQOJGa6JrvVk=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=TJQpMrvJ9qB8909TeONz1R6biPQQygs8ny3R6d/l9ajusEPnL6GgNJVQAX0G9XJmP
         2CKC4t3Dqv4r6fhZPhIHw1V/1CALEnRqz9RbioWZSQFCpmlEudF7fT3aUnekrwVfOo
         4JkDdwM+w8MZeIjdCo5zFZQK3A17TGxInbF2kDaxg5iSxAi6QMaZ43tk+JvjfIpoJ8
         mjmSowZTxOvJLWmo2qEWzrZmy3+dbYYTN4lg/h8swEdS+J3uTIJ1Yiw3cVZHBVGQgB
         oeO9z1ZNi/KZPDAlUTGyDIe4o4Tv5r+9K0eon6bwwyXDlqPW7SbYUefCy5I6whx9Ix
         qzE8tXJqEwlbA==
Received: by mail-ot1-f53.google.com with SMTP id v15-20020a9d69cf000000b006709b5a534aso17975183oto.11;
        Tue, 17 Jan 2023 07:07:26 -0800 (PST)
X-Gm-Message-State: AFqh2krRtkHAqguAW+FOJ7t8t2Q/SdLhZkknPHbcV27XXohxOgBFUuvH
        MHfg0giya0AHmJutgV8POvDmeuXrxeSxgQjyYp0=
X-Google-Smtp-Source: AMrXdXvNc2KsleS8qULIJRtcQbD1k0ix52exYOBhVwkrr0Fc4FenlKU+EAe4BgoPnMj/LMgGFAneAyK9pxVmIKkiUSA=
X-Received: by 2002:a05:6830:3883:b0:684:ed12:d614 with SMTP id
 bq3-20020a056830388300b00684ed12d614mr191726otb.190.1673968045873; Tue, 17
 Jan 2023 07:07:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6802:195:b0:49c:ff2e:6ecb with HTTP; Tue, 17 Jan 2023
 07:07:25 -0800 (PST)
In-Reply-To: <TYCP286MB23239EE29037F6051CFE5691CAC09@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB23239EE29037F6051CFE5691CAC09@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 18 Jan 2023 00:07:25 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8AjjzXWEmMDydgRm1p6F7Fo-s836iWryRGeQPYbjcQTQ@mail.gmail.com>
Message-ID: <CAKYAXd8AjjzXWEmMDydgRm1p6F7Fo-s836iWryRGeQPYbjcQTQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] ksmbd: Minor performance improvement & code cleanup
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        hyc.lee@gmail.com, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-01-15 19:32 GMT+09:00, Dawei Li <set_pte_at@outlook.com>:
> It's a small series mostly aimed at performance improvement and code
> cleanup.
>
> Among which, First three ones are performance related commits, and
> other ones are minor code cleanup.
except 0005 patch, Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks for your patch!
>
> 1 & 2: list => xarray, acclerating index based lookup.
> 3: rwlock => rcu primitive, enabling write & read concurrency.
> 4: Simple duplicated code removal.
> 5: Minor code rework and exception handling.
> 6: Simple typo fix.
>
> Dawei Li (6):
>   ksmbd: Implements sess->ksmbd_chann_list as xarray
>   ksmbd: Implements sess->rpc_handle_list as xarray
>   ksmbd: replace rwlock with rcu for concurrenct access on conn list
>   ksmbd: Remove duplicated codes
>   ksmbd: improve exception handling and avoid redundant sanity check in
>     loop
>   ksmbd: fix typo, syncronous->synchronous
>
>  fs/ksmbd/asn1.c              | 19 ++++---
>  fs/ksmbd/connection.c        | 54 +++++++++++---------
>  fs/ksmbd/connection.h        |  1 -
>  fs/ksmbd/ksmbd_work.h        |  2 +-
>  fs/ksmbd/mgmt/user_session.c | 98 ++++++++++++++----------------------
>  fs/ksmbd/mgmt/user_session.h |  6 +--
>  fs/ksmbd/smb2pdu.c           | 52 ++++++-------------
>  7 files changed, 93 insertions(+), 139 deletions(-)
>
> --
> 2.25.1
>
>
