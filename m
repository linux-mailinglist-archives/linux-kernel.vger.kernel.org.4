Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CA07176EC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbjEaGfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 02:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjEaGfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:35:34 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F48399;
        Tue, 30 May 2023 23:35:32 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96f53c06babso918497666b.3;
        Tue, 30 May 2023 23:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685514931; x=1688106931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MT/ursCZpYWc+U/ss5xdCpQN33pNzAamORszl4z68Ow=;
        b=lNMtmamOO2e1wvzgrMy+UcK+VWeJeCrcl3wmYu6uAry5CZ1KJz7U6Ndg/QIjGdbK1A
         tj/wfAIRPI/J4R2dQh4XqtrssizdRRQ4Ab2he1QAQ6UTq3xy20HiwvumCPJYTdHcrwPj
         QzTOJ6izHzvkT0p+Z26cuh7XqRTPEKN50JWbzcaHwvIrQG4KckxKlRIqE1oIH6yqniRT
         i8oK+UudyDh7A07FuNhIKjsbEh2kYKOEi/WHLpXGmPNMl/oQx7wvXzsKSaapzOTMqdYj
         2I4cka+3HmgIUZqP66vK3ZvbW1EJXlg7tdrylvd9KIFyp9IC+NrfXIVqglgMUHPRTAo1
         D2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685514931; x=1688106931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MT/ursCZpYWc+U/ss5xdCpQN33pNzAamORszl4z68Ow=;
        b=AeRPOZPAwg4Q9RALsMA+OzaqiMFzo2cVxE0FijmKJWS8mTLil3sQQ3o/c+t1FsH8Hd
         SmJPUfToJcC+R7II5lS5EnOr0py24rnNtTehBdVg30UCC488XKNKx2HWOz+ZuWvrER2c
         C9WbOp17AGOsJAcrGJA5GKoLWJHUMRD0aQ8IAgErXO8ZQIm4aJtrx9Suj63iz7hifSZ+
         B0lNA7LbG6/R5DQeyswaQmflZfl+8LDuHWvKOyduplGAWKghXTFeO1NRO+E/z2UOBiYu
         qnn7uc3SgWWW3/QEsj9zltP0LCHWGRCybtn7/cr4yl0IbXO/cD5dDObSbHK8MTJtPOpM
         y5CQ==
X-Gm-Message-State: AC+VfDwBuEnYWUIYyONKy+loMzr6cWA3IkwdeD7lhYSjmnuKfYahyo0A
        YLlhYlsWp+JRgDN2CSjKmRKZr3P/lO2+5p0L5OsmfS7eDl0=
X-Google-Smtp-Source: ACHHUZ7TBEY/rdeuLDDeZUIfY2WE5Jm0aucrTE73JNXR6+PzOMvzNGpM8XQdSJdpkAgMbR2VHVDBcGzUMN7RYCZa8dU=
X-Received: by 2002:a17:907:d16:b0:960:ddba:e5c3 with SMTP id
 gn22-20020a1709070d1600b00960ddbae5c3mr4616805ejc.32.1685514930685; Tue, 30
 May 2023 23:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230530154252.7895-1-osmtendev@gmail.com>
In-Reply-To: <20230530154252.7895-1-osmtendev@gmail.com>
From:   David Rheinsberg <david.rheinsberg@gmail.com>
Date:   Wed, 31 May 2023 08:35:18 +0200
Message-ID: <CADyDSO6nY2=UONuHk0PMszWJ_Hnpg6h-VYX40xGtU2CnhTcy+w@mail.gmail.com>
Subject: Re: [PATCH v2] hid-wiimote-debug.c: Drop error checking for debugfs_create_file
To:     Osama Muhammad <osmtendev@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi

On Tue, 30 May 2023 at 17:43, Osama Muhammad <osmtendev@gmail.com> wrote:
>
> This patch removes the error checking for debugfs_create_file
> in hid-wiimote-debug.c.c. This is because the debugfs_create_file()
> does not return NULL but an ERR_PTR after an error.
> The DebugFS kernel API is developed in a way that the
> caller can safely ignore the errors that occur during
> the creation of DebugFS nodes.The debugfs Api handles
> it gracefully. The check is unnecessary.
>
> Link to the comment above debugfs_create_file:
> https://elixir.bootlin.com/linux/latest/source/fs/debugfs/inode.c#L451
>
> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

Looks good, thanks!

Reviewed-by: David Rheinsberg <david@readahead.eu>

Thanks
David

> ---
> changes since v1
>         -In v1 the IS_ERR was used for error checking which is dropped now.
> ---
>  drivers/hid/hid-wiimote-debug.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-debug.c
> index a99dcca2e099..00f9be55f148 100644
> --- a/drivers/hid/hid-wiimote-debug.c
> +++ b/drivers/hid/hid-wiimote-debug.c
> @@ -173,7 +173,6 @@ int wiidebug_init(struct wiimote_data *wdata)
>  {
>         struct wiimote_debug *dbg;
>         unsigned long flags;
> -       int ret = -ENOMEM;
>
>         dbg = kzalloc(sizeof(*dbg), GFP_KERNEL);
>         if (!dbg)
> @@ -183,13 +182,9 @@ int wiidebug_init(struct wiimote_data *wdata)
>
>         dbg->eeprom = debugfs_create_file("eeprom", S_IRUSR,
>                 dbg->wdata->hdev->debug_dir, dbg, &wiidebug_eeprom_fops);
> -       if (!dbg->eeprom)
> -               goto err;
>
>         dbg->drm = debugfs_create_file("drm", S_IRUSR,
>                         dbg->wdata->hdev->debug_dir, dbg, &wiidebug_drm_fops);
> -       if (!dbg->drm)
> -               goto err_drm;
>
>         spin_lock_irqsave(&wdata->state.lock, flags);
>         wdata->debug = dbg;
> @@ -197,11 +192,6 @@ int wiidebug_init(struct wiimote_data *wdata)
>
>         return 0;
>
> -err_drm:
> -       debugfs_remove(dbg->eeprom);
> -err:
> -       kfree(dbg);
> -       return ret;
>  }
>
>  void wiidebug_deinit(struct wiimote_data *wdata)
> --
> 2.34.1
>
