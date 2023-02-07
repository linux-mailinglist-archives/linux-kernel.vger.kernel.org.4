Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADE668DF49
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjBGRuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBGRt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:49:59 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C0610D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 09:49:58 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id v5so8253097vkc.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 09:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq2WTnUOKOlouEj9rhMJsPCKZ636O+FLTpfvi8EpzGk=;
        b=pNLJpHP1McY8BIX7M1KsXNR98xK6Okw7ZLSmxEa32RZd0YLzSdnwNLUhsjf3X6bJLB
         z9gEGsARi7VW48nVivnQPt56f45T5UZdiinjUT61tgJVB+zINfshW6/gXyix5/11BiTj
         uKF/Ju6nWBzKVgVfja85yNQOoG1RC3UCNVFtvu6Q5+WUxgcqjZf8g+NuLIu9xhsflbqO
         RAKou2GKXaNNxlrtcO3zIuKYUF3wYRwwHblR5w33XbCoGoFfSzNJa5jG2aRUPQYH7UeL
         obAT5bXPijJF8CXWz3fv5CWeeFNfkujMGR9MLiXm+GPyPgkV9WUoNS7CUtRW152LxF0e
         t3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jq2WTnUOKOlouEj9rhMJsPCKZ636O+FLTpfvi8EpzGk=;
        b=RoLu9BFI7Z6yeN3t59bn51B1Vy11SmaOOp1qvVR/S4d1xq3ChOcdR+PmwRIPZmlPoN
         8XR71GmgfLnMw4lIi98aPJlA5I/vszE/6Y85ePmqijyUpGhV9wB/0BvYf/8JN1Fx+wbS
         A6IQCYXRW5dnuLnIE1dcGlFiy88zLqJst4xzok6abtgIVMNhiCGFxuUH8HVKN++pF9jY
         CSpqSXoNg6jrxRcCXwfqqmCEvqCOmAsq5bNeNitXEnaqLRZz56Dree5TIkkexBYUshM8
         6ddKwHzkA9w4jkUQ1gIYpo194MrVBUVLItgWA+95+O8UGRfx2b9dG2rDFmB5jibXjDSh
         Ppyw==
X-Gm-Message-State: AO0yUKWXpURVgFcf+pCNeKpe9s97JLHQHWlJUZ+nj9Ed21bQMMH2wtRZ
        GSQ0YLdySE+53mHbDbHoskQf6Zbwv2yZqcApgMMK9J8R0bxvNob5
X-Google-Smtp-Source: AK7set+6EsmzH/1uinKsBljoDIrb4rmosrnVxPNeqIwTFKopf7huIhtQL1p9wYVL2AhexhvDRphZZ4Gd6ODYQ3L+Z1U=
X-Received: by 2002:a05:6122:226:b0:3ea:49cf:10e2 with SMTP id
 e6-20020a056122022600b003ea49cf10e2mr591913vko.19.1675792197917; Tue, 07 Feb
 2023 09:49:57 -0800 (PST)
MIME-Version: 1.0
References: <20230207091443.143995-1-colin.i.king@gmail.com>
In-Reply-To: <20230207091443.143995-1-colin.i.king@gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 7 Feb 2023 09:49:46 -0800
Message-ID: <CABXOdTePo76u1UAP0VsYBJZiPaOEk=hZe1cLeMseRvcFOsJ_Mg@mail.gmail.com>
Subject: Re: [PATCH][next] platform/chrome: Fix spelling mistake "Attenetion"
 -> "attention"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 1:14 AM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> There is a spelling mistake in a dev_warn message, make it lower case
> and fix the spelling.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 71f5d7d8e055..a673c3342470 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -1020,7 +1020,7 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
>                 cros_typec_handle_vdm_attention(typec, port_num);
>                 ret = cros_typec_send_clear_event(typec, port_num, PD_STATUS_EVENT_VDM_ATTENTION);
>                 if (ret < 0)
> -                       dev_warn(typec->dev, "Failed VDM Attenetion event clear, port: %d\n",
> +                       dev_warn(typec->dev, "Failed VDM attention event clear, port: %d\n",
>                                  port_num);
>         }
>  }
> --
> 2.30.2
>
