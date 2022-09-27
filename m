Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C08C5EC0E7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiI0LSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiI0LSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:18:05 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CDA11BCDD;
        Tue, 27 Sep 2022 04:17:37 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id m3so12701437eda.12;
        Tue, 27 Sep 2022 04:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=5+kF5Y0/203zzrdLAOZ9QTBoJ3rERNsk4sXaumVZuYA=;
        b=P1pr7qRYb3951aLNn/CBQ8BqiBgzZ1kad+bR3TfANi+ZSu6uwdQ6EEpnR59OnNd8TF
         MjC8/3hV5xTTqni2mubK+aEfbxmfXd8RXzDMVB+qd+Vq5By5znhsLcSpH1TmvKqsQaCK
         ru1nw5fXw+0rVBx/gNRV59cNoQpQXtwcqPFXhPUMU6luhkhlaS8tfMeCExPcwMxflka5
         +ooTe81Df7g6xdLrjZX4d8/cCWo0wa7LuGnl9/lAWLUcZ/s6SO0O5HEnTi2p8zkkQKcm
         dz4AuZuOnfwstR6DjyoCUR81W4sHXnJ2HsqpWGg79ZftZ0+V/hTqnJp/UazY1EZdFpeT
         WaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5+kF5Y0/203zzrdLAOZ9QTBoJ3rERNsk4sXaumVZuYA=;
        b=vbah14I7F4GSkin+x0bHCQAsHaRYJuX2RJTha8I3XIEJngz2GAaLEvVz5RZNFcSKM6
         u5c3sSMh7VsKP9rU/kIYfXxNl670OTMK3h3H97Cx0fKjUyISzUhzY9lO7eavS7oQ/jxq
         L091EiAQNyUCtKJxsQuVNY0bCLSssO7RttyiKBFEvlA6Rf7NGgsyytG/0a211jXtoxC6
         c9Lp7HdcNZfzSradtlg3586IjPqqmN1ftr3ZLj9lAsdkuXDzhx9OV4HfssM+m1dLTDvT
         zsaN5JWB+6Fm3cx1UtNWfSVp9Cyky08Fj9KWt2vjsuXaKRIKncUQ2juzGfJT6J/4N9xT
         DjMQ==
X-Gm-Message-State: ACrzQf1/zBAIgRYAGHebeddcqEs8HeC+gQQJBZBkze+uK+3wC0/n2bKT
        ruO1KyixNKDSO5GCbmsnoJxTPKtRbms=
X-Google-Smtp-Source: AMsMyM7Ba26gbv0elp/pmHXdzEJc+KV4yTb3jSaLl1tIyeaybPhJvPLItfQ4DfNN8miR7/bjWmHp5w==
X-Received: by 2002:a05:6402:3552:b0:451:2037:639e with SMTP id f18-20020a056402355200b004512037639emr27811797edd.136.1664277455225;
        Tue, 27 Sep 2022 04:17:35 -0700 (PDT)
Received: from [10.23.0.4] ([37.120.217.82])
        by smtp.gmail.com with ESMTPSA id r17-20020a17090609d100b00781d411a63csm624283eje.151.2022.09.27.04.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 04:17:34 -0700 (PDT)
Message-ID: <93a51c6f-40f4-1808-dbd6-4cd57bbaa3ed@gmail.com>
Date:   Tue, 27 Sep 2022 13:17:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] platform/surface: Split memcpy() of struct ssam_event
 flexible array
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20220927004011.1942739-1-keescook@chromium.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20220927004011.1942739-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 02:40, Kees Cook wrote:
> To work around a misbehavior of the compiler's ability to see into
> composite flexible array structs (as detailed in the coming memcpy()
> hardening series[1]), split the memcpy() of the header and the payload
> so no false positive run-time overflow warning will be generated.
> 
> [1] https://lore.kernel.org/linux-hardening/20220901065914.1417829-2-keescook@chromium.org
> 
> Cc: Maximilian Luz <luzmaximilian@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks!

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

Regards,
Max

> ---
>   drivers/platform/surface/surface_acpi_notify.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/surface/surface_acpi_notify.c b/drivers/platform/surface/surface_acpi_notify.c
> index 44e317970557..50500e562963 100644
> --- a/drivers/platform/surface/surface_acpi_notify.c
> +++ b/drivers/platform/surface/surface_acpi_notify.c
> @@ -355,7 +355,8 @@ static u32 san_evt_bat_nf(struct ssam_event_notifier *nf,
>   	INIT_DELAYED_WORK(&work->work, san_evt_bat_workfn);
>   	work->dev = d->dev;
>   
> -	memcpy(&work->event, event, sizeof(struct ssam_event) + event->length);
> +	work->event = *event;
> +	memcpy(work->event.data, event->data, event->length);
>   
>   	queue_delayed_work(san_wq, &work->work, delay);
>   	return SSAM_NOTIF_HANDLED;
