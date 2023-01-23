Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2BC6776B3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjAWItb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAWIt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:49:29 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F1DCC02
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:49:29 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id q8so8367787wmo.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=soja83e34c2eLz9845rol6k2LZ7cLCXqZuSiTiSx964=;
        b=SkRILWqFbm/CTcnfDATfLaDF5BJtzFA1CI607stoaDCCGOpOypRFQjEhH30g/INtaZ
         yyt8orlvR+kuPJQObM77e1o7AKF+IGdiPjQ5XAyqJqeyBJk/wr+2gbampd3Ekng3GNqr
         zt2wQ4Xr+mCyFehQdMguU/qA5p/N/wy7bcBs2kQ4NRrKwG1Skb2PmCJ8inlia+QZo0YB
         AafwA0QDa9PsoFhszpYa7aOiWAxDGgWrqv0jS1a+dZn0szQG0FVKyWNxP3PrhX0+31KU
         V41yWdPzLVE4labU5tdeOdb9SYajAJ1BIk57aQe1sDRQXtULIgSi9ZInbvDBxaUA7+Op
         mDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=soja83e34c2eLz9845rol6k2LZ7cLCXqZuSiTiSx964=;
        b=kIxFuCD7sc0zzXQxKPejLBE/0emoL97TTIZxktmG52z9PIWlFZGheLqwqa1h1afcAo
         BNZPpUO6iJ/cDHjv5EENQc3i2af+Cl5DhWPiZYrFL++FJ+mC0DSvuAoZd833oEMUFCRw
         Sx2b3Jt1C5iKEFsIvBELr9w3Lq/UfYv5Q3roGgYmo6uIaKWoOvcnQH7cI1xFIzcIouVs
         zANAmdAnGkIYyGkeRnmWb0kvsW0qmlj+PEJrrGAohSBH/uUp4VZAiCSXIE7UWlN8F6ph
         yHT9PUbzsfId68ry0i/CiUU+bVDLO11GpdjmqfgxEC7Emmt03HEecTwFldHiqcI9wN9C
         c9EA==
X-Gm-Message-State: AFqh2kqzm5j1YiyF2GIp/9uItHXwXlA2ctynz0HhuCjrgczsL+QzoL5V
        fzSCJGqQN/SFMmHYEIVjkaupKuo35oh8cbST8Hc=
X-Google-Smtp-Source: AMrXdXvwi8oXyhzxtSXMDorQp5ZuNfEJhKBQoqpgabUgwuOh93L8qUifFWtwT3ydPwQM1NZM2ssqCg==
X-Received: by 2002:a1c:cc11:0:b0:3da:1d52:26b5 with SMTP id h17-20020a1ccc11000000b003da1d5226b5mr31095778wmb.14.1674463767626;
        Mon, 23 Jan 2023 00:49:27 -0800 (PST)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c19cd00b003cf71b1f66csm11144887wmq.0.2023.01.23.00.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 00:49:27 -0800 (PST)
Message-ID: <6b4df841-6f8f-4c32-767c-8b8c34108272@linaro.org>
Date:   Mon, 23 Jan 2023 09:49:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] media: meson: vdec: remove redundant if statement
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Benjamin Roszak <benjamin545@gmail.com>
References: <20230123071708.2670751-1-christianshewitt@gmail.com>
Content-Language: en-US
Organization: Linaro Developer Services
In-Reply-To: <20230123071708.2670751-1-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 08:17, Christian Hewitt wrote:
> From: Benjamin Roszak <benjamin545@gmail.com>
> 
> Checking if sess->fmt_out->pixfmt is V4L2_PIX_FMT_VP9 was already done as a
> condition to enter the if statement where this additional check is made.
> 
> Signed-off-by: Benjamin Roszak <benjamin545@gmail.com>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   drivers/staging/media/meson/vdec/esparser.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/staging/media/meson/vdec/esparser.c
> index 86ccc8937afc..7b15fc54efe4 100644
> --- a/drivers/staging/media/meson/vdec/esparser.c
> +++ b/drivers/staging/media/meson/vdec/esparser.c
> @@ -314,8 +314,7 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
>   			num_dst_bufs = codec_ops->num_pending_bufs(sess);
>   
>   		num_dst_bufs += v4l2_m2m_num_dst_bufs_ready(sess->m2m_ctx);
> -		if (sess->fmt_out->pixfmt == V4L2_PIX_FMT_VP9)
> -			num_dst_bufs -= 3;
> +		num_dst_bufs -= 3;
>   
>   		if (esparser_vififo_get_free_space(sess) < payload_size ||
>   		    atomic_read(&sess->esparser_queued_bufs) >= num_dst_bufs)


Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
