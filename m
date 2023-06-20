Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2DD736CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjFTNBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjFTNBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:01:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577311710
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:01:05 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f769c37d26so6149198e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687266062; x=1689858062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WP5vpynYgNMXy8TaoMzt2xjr96MBAbBOAmB71QFroMo=;
        b=j/mm2xaykap2KR0u/lkGswya0XJZf7Cwz+3donGqSzF3lZjQxbSkCPJCkKFd+5Oazh
         0C1zt8jSSrfzfT44oKzfGxQN/HsNnc6VvSVVB4MV/CdYjvoMR+hkKVPvBunJYUyjcqEZ
         IlGYQOBxX6kQMbNve5XwkqqmwZJ6ETkNDDUtyGQ/f9l02nGpwkjGza0Gzn0o4Z1SiMgv
         mNDYJWg6PO8cOd25V/dQxqMxIfIKGLUSSAn3gsc09vdhWx2QV7405O51IR/B3YHu0SgA
         6oEB6g0f56xWsZyyTq7QN2/yoyNH8fnczeoGZuKvQvL6CMGzvPnjLejpnnUEzM6TpVrX
         ueRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687266062; x=1689858062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WP5vpynYgNMXy8TaoMzt2xjr96MBAbBOAmB71QFroMo=;
        b=SWK4ZbrFB94IvXzSzjLS5UxiFEYK/efPmufldQQkW/2rZFU2Sebj2NhNKy1COYfM+5
         0J5LsvKvKGIoybV52fERFooB8v6ttp7LSmR92/d7JzBTHs8SH7n0qU3gLMOKLYlRfvZs
         Pj2OPoQbAl2+nyuWjgTKb/Pr+hcNV2zsWVAuCfqIVDrXJ7njT/UC0bC4LD1gI9UPVjLm
         W2qAGe6DaMhr5U3cvgA9KqL2CUm4q3H47TwtLEQhRy+1+VcC6DfBA5jWuAQLPyplnKdD
         wPLNJFvq27IpLx2AjA0pCCvuo5nBWKVMkSAsmH3zrMo60Fbio3O6+Grskzh2xcu7bQ45
         N4pg==
X-Gm-Message-State: AC+VfDyDu1u037J2H4P+bJCh/nqGMQm6c9ku9qS7ocNph5wHzg+DQ/9+
        Zjzxo/EdexUFp6KfQANmKO0=
X-Google-Smtp-Source: ACHHUZ5RZklLoxiYrBsJGz4Y7/hRtqLQMLNOq1dWXSnvJ3TXtvVT5SAQ8CYFLM6UQjcsgkz465BcVw==
X-Received: by 2002:ac2:5b1e:0:b0:4f8:5d15:99e5 with SMTP id v30-20020ac25b1e000000b004f85d1599e5mr5660162lfn.32.1687266061915;
        Tue, 20 Jun 2023 06:01:01 -0700 (PDT)
Received: from [192.168.50.244] (83.8.116.77.ipv4.supernova.orange.pl. [83.8.116.77])
        by smtp.gmail.com with ESMTPSA id ep8-20020a056512484800b004f26f437ad8sm358976lfb.53.2023.06.20.06.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 06:01:01 -0700 (PDT)
Message-ID: <52d0771d-b184-8154-6a1a-3f7bc223ac3a@gmail.com>
Date:   Tue, 20 Jun 2023 15:01:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] gpu: drm: Optimize the unused variable ret
To:     Li Dong <lidong@vivo.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230619113154.1980-1-lidong@vivo.com>
Content-Language: en-US
From:   Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <20230619113154.1980-1-lidong@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2023 13:31, Li Dong wrote:
> Use zero as the return value instead of the unused variable ret
> 
> Signed-off-by: Li Dong <lidong@vivo.com>
> ---
>  drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> index 102e1fc7ee38..fec0d014fd0e 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> @@ -66,7 +66,6 @@ static void s6d7aa0_reset(struct s6d7aa0 *ctx)
>  static int s6d7aa0_lock(struct s6d7aa0 *ctx, bool lock)
>  {
>  	struct mipi_dsi_device *dsi = ctx->dsi;
> -	int ret = 0;
>  
>  	if (lock) {
>  		mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD1, 0xa5, 0xa5);
> @@ -80,7 +79,7 @@ static int s6d7aa0_lock(struct s6d7aa0 *ctx, bool lock)
>  			mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD3, 0xa5, 0xa5);
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int s6d7aa0_on(struct s6d7aa0 *ctx)

Commit "drm/panel: s6d7aa0: remove the unneeded variable in
s6d7aa0_lock"[1] already does this.

Best regards
Artur

[1] https://cgit.freedesktop.org/drm/drm-misc/commit/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c?id=c5dacfe2e6c1251276e29b4cdac771f504593523
