Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0B36C36D0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCUQTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjCUQTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:19:47 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0E7FF31
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 09:19:44 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x3so61814012edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 09:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679415582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B6iMXpkdTBzAvk0Bh7ViMsoVWjT2+jjmNi/B2I7tj10=;
        b=avbUlHQu5Bqw3de3EPureIEvBQCp716UugSanvkDNN9xp2NVjNS6nzLrLlmaoMIE3x
         94xIgxta3uQRCTZ7WkuyR5iCblzmV5q9nWZyIILY8KQyEmtSFKSKdngqTnah7S0R593f
         m5QTlzLpsasw32na6cZTZ0W93ExtG43F7oaLLypTgZFCiRWzzBtzj5AmuxBGh2dmAWUF
         tMNGBrLn6BAIXz3QIHI05H5Nq1Bk01NKrd59ZaypfPoPbOW4GFBYKNSz1GICMNtw78zb
         lJZ7xINyAP6J+7IAF4ZmwR2r6Kd3hqimyPuiPrsjNZe/z8GXN+wxCCrDIEzJN5qqSAJk
         U1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679415582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6iMXpkdTBzAvk0Bh7ViMsoVWjT2+jjmNi/B2I7tj10=;
        b=ZVpK8DifWnFV9hwn2cOWoZeaIA0VHJQPVf/+vac9JRN1p/sEy02S/zVJMpOK0PFjtt
         LE2lRt4bqQgwvbMEm9Q2FFjLqu8zUHzgUKRNT+O0RK1ctupIc7y2h9vRgzv9ZsXiDTQ9
         t+CeU3mEAuzTlDbWXoESgAYah230aagZjFjdG/Y0SYH4a2m6vtYknyQu6pw5qpQ2ey+v
         fD7tDf5FFzoJtEC3caWnqyUJEuYM5ogH8j/mnVUSSJBG6NSinjSXLr/PTEBNfVm9O2I2
         6xEWdTxgIyojakXyby0JRqAOZVIjHUzqEZSJXWR855Er5VIAXD9FOibyovT4RApFWABw
         25+A==
X-Gm-Message-State: AO0yUKVwTE+R3+fBcOy0of+jxNsUjFLIQqCMqOrE9EQoizGd16SXXd1o
        YbHWQeI6HkikAtowcu67Nwj35lZ8Fv3+esyb
X-Google-Smtp-Source: AK7set9p03aB4xAlmTjjUmP38B+MsSpdkCnEx0PZ2gqZUecs0e6I5KszVMjC/DocweeV5Lxwjjv98Q==
X-Received: by 2002:a17:907:2059:b0:8b1:bab0:aa3d with SMTP id pg25-20020a170907205900b008b1bab0aa3dmr3470462ejb.8.1679415582370;
        Tue, 21 Mar 2023 09:19:42 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id rk28-20020a170907215c00b00933b38505f9sm3415222ejb.152.2023.03.21.09.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 09:19:41 -0700 (PDT)
Date:   Tue, 21 Mar 2023 21:19:27 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fix line ending with '('
Message-ID: <ZBnZD5alylOgjhYd@khadija-virtual-machine>
References: <ZBhNOkQbG4ygNF98@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBhNOkQbG4ygNF98@khadija-virtual-machine>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 05:10:40PM +0500, Khadija Kamran wrote:
> Splitting function header to multiple lines because of 80 characters per
> line limit, results in ending the function call line with '('.
> This leads to CHECK reported by checkpatch.pl
> 
> Move the first parameter right after the '(' in the function call line.
> Align the rest of the parameters to the opening parenthesis.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  drivers/staging/greybus/audio_topology.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
> index 62d7674852be..08e6a807c132 100644
> --- a/drivers/staging/greybus/audio_topology.c
> +++ b/drivers/staging/greybus/audio_topology.c
> @@ -24,9 +24,8 @@ struct gbaudio_ctl_pvt {
>  	struct gb_audio_ctl_elem_info *info;
>  };
> 
> -static struct gbaudio_module_info *find_gb_module(
> -					struct gbaudio_codec_info *codec,
> -					char const *name)
> +static struct gbaudio_module_info *find_gb_module(struct gbaudio_codec_info *codec,
> +						  char const *name)
>  {
>  	int dev_id;
>  	char begin[NAME_SIZE];
> --
> 2.34.1
>

Hey Outreachy Mentors,

Kindly take a look at this patch and let me know if I should wait for
the response on this patch or submit another patch.

Thank you for your time.
Regards,
Khadija

