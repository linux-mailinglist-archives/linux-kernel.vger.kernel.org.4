Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A6E681CA2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjA3VYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjA3VX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:23:59 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A5B30E9D;
        Mon, 30 Jan 2023 13:23:58 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id u12so10595436lfq.0;
        Mon, 30 Jan 2023 13:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tFZC+05wFKTwfBGiPm2JG45yZl9PbUY9aQpOd0L6E7g=;
        b=fvW/6D2DrtdIJ/6d1hceaPOF1h6ipkEhchDRSrdREgCUCtR1zBw/xxWtzoW7u+RWZA
         QlKyRmo5JZ6/HthrfJYHTuni2Xj7HzrkiZE+4PlbaWOqTpVyq2vDY/sQjWE9KgplrCSW
         oa41bbYwyXV4w5cPBfQG0je+JEYjN+zeINDdofYB2w4XDo50ulHPOOEagSlzsnGpv0II
         +9HA7a7kVzVifHDIJegD5/6IaD3a0k4CDdcwc3Tip3tWICRc/ot7YS10O0czTg4HrlKu
         ud5E2PRByaqtBVwaDyZvdM/EyvZquoU6o2ssHh8CcGp11ERPI27Azy4ooowpvw0Fco2P
         AzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tFZC+05wFKTwfBGiPm2JG45yZl9PbUY9aQpOd0L6E7g=;
        b=NRUIr9Y6Hu3APUf5hD1RmBpLDzwUbz3XnT0oTXc3nv+ilRjLNhwAbXN29br+Vaeq/8
         PSUF75yhTEv6A3nF7Lke4aKKPn8hMP6ptXX5yVeGGZdO/6KuYqfVWR/ddBNWkrHpZUBr
         VhpQwDAjn8DXE+FoZHw3wzDs0IXHpMF/9S88xeZsjw+OHbKJDu8CgNWAln4zRTZ6mur7
         GHUXFDBm4ujGSiwOLEEN0zRqEz2U/I+eDeIsiE2UR8lZ8Hm6LoTPS5V08L73gUQt3vsl
         05jsG4E+xNUETmv9Vqz562sxWzSupHfUWGtgRU1vBmx6vnsf6hk/28rGrUqjlt4u7CpZ
         4LHw==
X-Gm-Message-State: AFqh2kqsQi6386om28J7Sa5igWgt4lQ8LWO5Ajl9SqK/NNmDr8AMkDhy
        f0Q5iDTutR8zk8v85fLuJt9CkxLZ0o/O6CzePgM=
X-Google-Smtp-Source: AMrXdXvScZZA1kRbAk5eq+Cm5AtTeHfnPzL3YpC02jU2WGXCjtQ75wxhNZ0xCWwOKZnFsmPA4u7gld7fYRAcikFfpz4=
X-Received: by 2002:a05:6512:3f03:b0:4cb:20b3:e7f4 with SMTP id
 y3-20020a0565123f0300b004cb20b3e7f4mr6707926lfa.194.1675113836316; Mon, 30
 Jan 2023 13:23:56 -0800 (PST)
MIME-Version: 1.0
References: <20230130092357.36730-1-colin.i.king@gmail.com>
In-Reply-To: <20230130092357.36730-1-colin.i.king@gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 30 Jan 2023 15:23:45 -0600
Message-ID: <CAH2r5muFzyAW6YYFRmoZ89AFPYETPZU59-DR+2H8zAxsZbnwkw@mail.gmail.com>
Subject: Re: [PATCH][next] ksmbd: Fix spelling mistake "excceed" -> "exceeded"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

added to smb3-kernel ksmbd-for-next

thx

On Mon, Jan 30, 2023 at 3:26 AM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> There is a spelling mistake in an error message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  fs/ksmbd/connection.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
> index 56be077e5d8a..0f7eab5aa04c 100644
> --- a/fs/ksmbd/connection.c
> +++ b/fs/ksmbd/connection.c
> @@ -312,7 +312,7 @@ int ksmbd_conn_handler_loop(void *p)
>                         max_allowed_pdu_size = SMB3_MAX_MSGSIZE;
>
>                 if (pdu_size > max_allowed_pdu_size) {
> -                       pr_err_ratelimited("PDU length(%u) excceed maximum allowed pdu size(%u) on connection(%d)\n",
> +                       pr_err_ratelimited("PDU length(%u) exceeded maximum allowed pdu size(%u) on connection(%d)\n",
>                                         pdu_size, max_allowed_pdu_size,
>                                         conn->status);
>                         break;
> --
> 2.30.2
>


-- 
Thanks,

Steve
