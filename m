Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025D86FC285
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjEIJSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbjEIJSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:18:09 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44B919A3
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:18:08 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f42c86543bso2278375e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 02:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683623887; x=1686215887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5S8LZn4WzfvssoqzDTmShzsL5ol9+ZNi047cFW0IZaw=;
        b=LCg/VC3IM4MzUdXQDjfgRVc3ZqePGI0io4NBS8f8P37gyKzNirXzG8sgtHIzID6BKP
         UZpC8xt5mHLIavU5tvyvwjY5YgolyQZRN+UcL0tM/Q81j39nGQ0qe34IWWCB7CT4GVT2
         vkWKvXpaEil6U5fMpZwgw2wyOUVd46AVav4lzHiW+hjXsuYZN80kv5DOAvQRdxKyDaDF
         z0oRh1sj4rSk0GNc8NasMebKhANRwhbW+mCYV37rpCXea/Wx2DMs8Zj57JgBiDsBOpgT
         SwVp4dmVxbitk61Ub4Ml6a63JOltsfub1Usbko7kP3jgQRVz1aVk8Qtja8AM/q1fDi4N
         f/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683623887; x=1686215887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5S8LZn4WzfvssoqzDTmShzsL5ol9+ZNi047cFW0IZaw=;
        b=eeRyJuXU14j8KWs/o+qBXiMgkzZav2s13GlcoBfpQ146laHDhjgQ0105KWczsDiiUd
         c34OkbmcgicnTcuDZ80VuiigXqV5tsANzno8+jbASYNsXvvB5zGrQTMNJZ2q4tf+JNs0
         20PDJOETCiBhZgPp7rp+J4EbZk8YrUKR7PvsAN0fLT6dU/EKJA1JK8gEC7L3/LgZxGB+
         1OmZmeTBdVLoHw+cGCjmaTeT9QW00ilIUDHZjFykI3WeVdKtKrQwOTpBNTpcxCoTbADN
         dV18iWHdzbnuRSUP+m3DjoeZqPpS/JuxSMPXIgM3ljfHNs4knXQR5VEStl7/0XON9VNM
         uMKg==
X-Gm-Message-State: AC+VfDxM0UoV4wQFYJJPQGzjBW5FNHgrBd02RG2j36L5HTCl0GwRXdiR
        m7RQ7IJmNKlQbJv33nvmUjacoQ==
X-Google-Smtp-Source: ACHHUZ5nsEXhvqb5gJqPsCibvoIo560aykDweYrOjOv4642KGvrDJnC8bpbA0UxE/9M8NvlFwZhgvQ==
X-Received: by 2002:a5d:6a8a:0:b0:306:2d27:2ac8 with SMTP id s10-20020a5d6a8a000000b003062d272ac8mr8138961wru.61.1683623887087;
        Tue, 09 May 2023 02:18:07 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id b10-20020adfee8a000000b002f013fb708fsm13901005wro.4.2023.05.09.02.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 02:18:06 -0700 (PDT)
Message-ID: <1b3aef9e-53ae-d96d-8a8d-5c005a333330@linaro.org>
Date:   Tue, 9 May 2023 10:18:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nvmem: imx-ocotp: set varaiable imx_ocotp_layout
 storage-class-specifier to static
To:     Tom Rix <trix@redhat.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230404183133.1925424-1-trix@redhat.com>
Content-Language: en-US
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230404183133.1925424-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/04/2023 19:31, Tom Rix wrote:
> smatch reports
> drivers/nvmem/imx-ocotp.c:599:21: warning: symbol
>    'imx_ocotp_layout' was not declared. Should it be static?
> 
> This variable is only used in one file so should be static.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---

Applied thanks,

--srini
>   drivers/nvmem/imx-ocotp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
> index ac0edb6398f1..fcea9c04be96 100644
> --- a/drivers/nvmem/imx-ocotp.c
> +++ b/drivers/nvmem/imx-ocotp.c
> @@ -596,7 +596,7 @@ static void imx_ocotp_fixup_cell_info(struct nvmem_device *nvmem,
>   	cell->read_post_process = imx_ocotp_cell_pp;
>   }
>   
> -struct nvmem_layout imx_ocotp_layout = {
> +static struct nvmem_layout imx_ocotp_layout = {
>   	.fixup_cell_info = imx_ocotp_fixup_cell_info,
>   };
>   
