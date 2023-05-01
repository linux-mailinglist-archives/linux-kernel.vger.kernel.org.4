Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B6A6F3253
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 16:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjEAOws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 10:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjEAOwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 10:52:44 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0896010C3
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 07:52:39 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-24782fdb652so1762970a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 07:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1682952758; x=1685544758;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vWKczLk0ay+PirEjdR/euEKVb0wOolvAqOmXbb6hoY=;
        b=fKvrQspeK3vHIkH7HvniQdYwJYS7cUol31iL2lby2obvx8MD2OZBUSOevjDj3XXZDf
         9DqM0CQ/a4jfO6cdPKP50ez2dyj4Y/jHA++LTVLLpnpsukwJMyvuRsmieTnx8X22M66i
         +/7FuD+DkNH3UJjEQHhBGv0DAKdQJNVAtWMCw47GZM+KaDJZnfhAbaZYbG5RLjnlkqSh
         Y1e97qnl51qHkVr+0FILstW6Zxm5T1Rk+H3gow1sHt5qIBjaZy6hdjvXhWv8RvTWe693
         jY35JAImsg5hWT2ubka+M5JEFROoqp88Frcak630myw0g7TrNmKJfRJBA28DeMjGFB/D
         nD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682952758; x=1685544758;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vWKczLk0ay+PirEjdR/euEKVb0wOolvAqOmXbb6hoY=;
        b=eQswM2kNcOOBI0GpjZYtWGwjE1S2BJgg+0S+looITKpT8zlXSKmhWyeV/ywppO5dyE
         EwSXsDKsfQ3torXfyIMf0Ca6xCmeRQWPAMuFKxnsYR1UGpsqUED1xpT1Exbo/cf0ab1R
         uJe/msPV8fSvAYZkDyzkNLLDPmNWVsNbGn2lcMQ1yiDRqjT5XKsSJR6iduG8pVX96SJU
         gcowSYXmw3D/yMmRSZytSirtfr3sFz1+1iEGQImvbGlHryjxRdexYVCazeuxzl/1P+KJ
         bmEM8vnCdpe1DOoY3dL+HWdTtxSHkEcwrFID7ydrjLC314CffR+2e6nGoA8YucsRAJWs
         n16w==
X-Gm-Message-State: AC+VfDzuIQs3rFD7Ocg4jZxTFoxKTMPPYfU13eEIa8Wnq6DRo3zelfsC
        T7DvIa4PipKn8dmxp/INled11Q==
X-Google-Smtp-Source: ACHHUZ7+smUJsucOHCm4fLxW1PuTF5cktUoaYTYRmHrSI81Jva2o7gHqxFrnrDEEQssLEZg1UWS3iw==
X-Received: by 2002:a17:90a:930b:b0:247:1c17:77eb with SMTP id p11-20020a17090a930b00b002471c1777ebmr14612152pjo.27.1682952758235;
        Mon, 01 May 2023 07:52:38 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id f16-20020a17090a639000b0023d0c2f39f2sm19070570pjj.19.2023.05.01.07.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 07:52:37 -0700 (PDT)
Date:   Mon, 01 May 2023 07:52:37 -0700 (PDT)
X-Google-Original-Date: Mon, 01 May 2023 07:52:21 PDT (-0700)
Subject:     Re: [PATCH 1/4] RISC-V: create ISA string separately - not as part of cpuinfo
In-Reply-To: <20230424194911.264850-2-heiko.stuebner@vrull.eu>
CC:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, heiko@sntech.de,
        kito.cheng@sifive.com, jrtc27@jrtc27.com,
        Conor Dooley <conor.dooley@microchip.com>,
        matthias.bgg@gmail.com, heinrich.schuchardt@canonical.com,
        greentime.hu@sifive.com, nick.knight@sifive.com,
        christoph.muellner@vrull.eu, philipp.tomsich@vrull.eu,
        Richard Henderson <richard.henderson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        heiko.stuebner@vrull.eu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heiko@sntech.de
Message-ID: <mhng-1a552bd2-9e29-4095-b932-15d411a1e10d@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 12:49:08 PDT (-0700), heiko@sntech.de wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>
> The isa string is a very central part of the RISC-V architecture, so will
> be needed in other places as well.
>
> So in a first step decouple the generation of the runtime isa-string from
> /proc/cpuinfo - its current only user.

I'm also going to leave this one out, both because it fails to build and 
because the proposed second user isn't going to fly.  I'm not opposed to 
the refactoring, but too late for this merge window.

> The resulting string should not differ from the previously generated one.
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ---
>  arch/riscv/kernel/cpu.c | 70 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 62 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 3df38052dcbd..ebc478f0a16c 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -193,10 +193,33 @@ static struct riscv_isa_ext_data isa_ext_arr[] = {
>  	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
>  };
>
> -static void print_isa_ext(struct seq_file *f)
> +static int strlen_isa_ext(void)
>  {
>  	struct riscv_isa_ext_data *edata;
> -	int i = 0, arr_sz;
> +	int ext_len = 0, i, arr_sz;
> +
> +	arr_sz = ARRAY_SIZE(isa_ext_arr) - 1;
> +
> +	/* No extension support available */
> +	if (arr_sz <= 0)
> +		return 0;
> +
> +	for (i = 0; i <= arr_sz; i++) {
> +		edata = &isa_ext_arr[i];
> +		if (!__riscv_isa_extension_available(NULL, edata->isa_ext_id))
> +			continue;
> +
> +		/* string length + underscore */
> +		ext_len += strlen(edata->uprop) + 1;
> +	}
> +
> +	return ext_len;
> +}
> +
> +static void strcat_isa_ext(char *isa_str)
> +{
> +	struct riscv_isa_ext_data *edata;
> +	int i, arr_sz;
>
>  	arr_sz = ARRAY_SIZE(isa_ext_arr) - 1;
>
> @@ -208,7 +231,8 @@ static void print_isa_ext(struct seq_file *f)
>  		edata = &isa_ext_arr[i];
>  		if (!__riscv_isa_extension_available(NULL, edata->isa_ext_id))
>  			continue;
> -		seq_printf(f, "_%s", edata->uprop);
> +		strcat(isa_str, "_");
> +		strcat(isa_str, edata->uprop);
>  	}
>  }
>
> @@ -220,19 +244,49 @@ static void print_isa_ext(struct seq_file *f)
>   */
>  static const char base_riscv_exts[13] = "imafdqcbkjpvh";
>
> -static void print_isa(struct seq_file *f, const char *isa)
> +static char *riscv_create_isa_string(const char *isa)
>  {
> +	int maxlen = 4;
> +	char *isa_str;
>  	int i;
>
> -	seq_puts(f, "isa\t\t: ");
> +	/* calculate the needed string length */
> +	for (i = 0; i < sizeof(base_riscv_exts); i++)
> +		if (__riscv_isa_extension_available(NULL, base_riscv_exts[i] - 'a'))
> +			maxlen++;
> +	maxlen += strlen_isa_ext();
> +
> +	isa_str = kzalloc(maxlen, GFP_KERNEL);
> +	if (!isa_str)
> +		return ERR_PTR(-ENOMEM);
> +
>  	/* Print the rv[64/32] part */
> -	seq_write(f, isa, 4);
> +	strncat(isa_str, isa, 4);
> +
>  	for (i = 0; i < sizeof(base_riscv_exts); i++) {
>  		if (__riscv_isa_extension_available(NULL, base_riscv_exts[i] - 'a'))
>  			/* Print only enabled the base ISA extensions */
> -			seq_write(f, &base_riscv_exts[i], 1);
> +			strncat(isa_str, &base_riscv_exts[i], 1);
> +	}
> +
> +	strcat_isa_ext(isa_str);
> +
> +	return isa_str;
> +}
> +
> +static void print_isa(struct seq_file *f, const char *isa)
> +{
> +	char *isa_str;
> +
> +	seq_puts(f, "isa\t\t: ");
> +
> +	isa_str = riscv_create_isa_string(isa);
> +	if (!IS_ERR(isa_str)) {
> +		seq_write(f, isa_str, strlen(isa_str));
> +		kfree(isa_str);
> +	} else {
> +		seq_puts(f, "unknown");
>  	}
> -	print_isa_ext(f);
>  	seq_puts(f, "\n");
>  }
