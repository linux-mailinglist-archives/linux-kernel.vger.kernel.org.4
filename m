Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D25677642
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjAWI00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAWI0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:26:25 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF7A1D907
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:26:21 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id n7so9999721wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4OyEqQ+MPaCJjl+5bc+htOaVgXu7C6B0ahGerYRngFs=;
        b=Yot68LPq/zPPMz+gliIgJ+xrNnwHICXK8Ug1sU9Eb3RKEArklM3cSaAH+OgUhQuqe7
         tZJfCADkH8EVYghTVM+9mZZphtqDBR8JHH2luUUIWLZ6Pc1Q2uboPFtmWZNhSWcf4w7C
         UAGBMi/9oqkO/9vEQ2yu0/x209MLX9BBeGB6bjzUEkxbIdw223V3gCvBSNQ8lGz9TYtw
         k8JbWQ7JrUAvp4kst+GxhNgdBZ6oFbfZtnfWYf/v/Be1GdeqgWGtDjIvKNugGa9k2nZO
         8CKZihD0XyBv69ey1pL3OG20vYTTMIYwT23OGqxOoFIENEjlpQl90Yq7aqb+pTOso85s
         p77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4OyEqQ+MPaCJjl+5bc+htOaVgXu7C6B0ahGerYRngFs=;
        b=Iw4zVmaj1ON8Rc/kqhSVc05KOJKkQvT7xiTGTGcye/sUmZw9b9rtnAm/PTOAVclj96
         ZxAVK5+2q54DmO4XwFHbYtSkISybqhNZHfXB1mzwXCe7k0TIsBUzY3MxTf2NK799Hjml
         Kn6VaePNinylrbVnRtEOjfuq7xgR+tr9CjQdEGkKi0rKnRz6tL4+7fm6f6UzQYUHGZbv
         71M38lfSA0v9ieFTdru/3FQDHoA95S6HuKSVdQunKVWehjsDl5VMycqW5XZuCkB51wbE
         aleXp7Ej69d0JoZcLi+rSrrdYdm5duiFms+b31VBnGbY5LeNCweVcRVTcLc6vZUg/jAz
         vmIA==
X-Gm-Message-State: AFqh2kqw1ztnr8nj331iQtKyg7/tUyzJNyThvMpWmVf7PmLIu8z5HVNh
        X8fTM0jdlf8H5MbxknzRjff/9Q==
X-Google-Smtp-Source: AMrXdXsnQX08twuodihLWSXyOBsor8H0am7znOAcpXXLnyu4LgGzwEYPCD40u4XbV1cKmTD4bDItqQ==
X-Received: by 2002:a5d:6a86:0:b0:2bb:e805:c1ef with SMTP id s6-20020a5d6a86000000b002bbe805c1efmr20300391wru.52.1674462379831;
        Mon, 23 Jan 2023 00:26:19 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id q11-20020a05600000cb00b002be53aa2260sm8840610wrx.117.2023.01.23.00.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 00:26:19 -0800 (PST)
Message-ID: <329fc9bc-017d-412e-a03e-2c3f1f3bcede@linaro.org>
Date:   Mon, 23 Jan 2023 09:26:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH qemu v3] x86: don't let decompressed kernel image clobber
 setup_data
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, pbonzini@redhat.com,
        ebiggers@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, ardb@kernel.org, kraxel@redhat.com,
        hpa@zytor.com, bp@alien8.de
References: <Y69fUstLKNv/RLd7@zx2c4.com>
 <20221230220725.618763-1-Jason@zx2c4.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221230220725.618763-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/22 23:07, Jason A. Donenfeld wrote:
> The setup_data links are appended to the compressed kernel image. Since
> the kernel image is typically loaded at 0x100000, setup_data lives at
> `0x100000 + compressed_size`, which does not get relocated during the
> kernel's boot process.
> 
> The kernel typically decompresses the image starting at address
> 0x1000000 (note: there's one more zero there than the compressed image
> above). This usually is fine for most kernels.
> 
> However, if the compressed image is actually quite large, then
> setup_data will live at a `0x100000 + compressed_size` that extends into
> the decompressed zone at 0x1000000. In other words, if compressed_size
> is larger than `0x1000000 - 0x100000`, then the decompression step will
> clobber setup_data, resulting in crashes.
> 
> Visually, what happens now is that QEMU appends setup_data to the kernel
> image:
> 
>            kernel image            setup_data
>     |--------------------------||----------------|
> 0x100000                  0x100000+l1     0x100000+l1+l2
> 
> The problem is that this decompresses to 0x1000000 (one more zero). So
> if l1 is > (0x1000000-0x100000), then this winds up looking like:
> 
>            kernel image            setup_data
>     |--------------------------||----------------|
> 0x100000                  0x100000+l1     0x100000+l1+l2
> 
>                                   d e c o m p r e s s e d   k e r n e l
>                       |-------------------------------------------------------------|
>                  0x1000000                                                     0x1000000+l3
> 
> The decompressed kernel seemingly overwriting the compressed kernel
> image isn't a problem, because that gets relocated to a higher address
> early on in the boot process, at the end of startup_64. setup_data,
> however, stays in the same place, since those links are self referential
> and nothing fixes them up.  So the decompressed kernel clobbers it.
> 
> Fix this by appending setup_data to the cmdline blob rather than the
> kernel image blob, which remains at a lower address that won't get
> clobbered.
> 
> This could have been done by overwriting the initrd blob instead, but
> that poses big difficulties, such as no longer being able to use memory
> mapped files for initrd, hurting performance, and, more importantly, the
> initrd address calculation is hard coded in qboot, and it always grows
> down rather than up, which means lots of brittle semantics would have to
> be changed around, incurring more complexity. In contrast, using cmdline
> is simple and doesn't interfere with anything.
> 
> The microvm machine has a gross hack where it fiddles with fw_cfg data
> after the fact. So this hack is updated to account for this appending,
> by reserving some bytes.
> 
> Cc: x86@kernel.org
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Changes v2->v3:
> - Fix mistakes in string handling.
> Changes v1->v2:
> - Append setup_data to cmdline instead of kernel image.
> 
>   hw/i386/microvm.c         | 13 ++++++----
>   hw/i386/x86.c             | 50 +++++++++++++++++++--------------------
>   hw/nvram/fw_cfg.c         |  9 +++++++
>   include/hw/i386/microvm.h |  5 ++--
>   include/hw/nvram/fw_cfg.h |  9 +++++++
>   5 files changed, 54 insertions(+), 32 deletions(-)

> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index a00881bc64..432754eda4 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -741,6 +741,15 @@ void fw_cfg_add_bytes(FWCfgState *s, uint16_t key, void *data, size_t len)
>       fw_cfg_add_bytes_callback(s, key, NULL, NULL, NULL, data, len, true);
>   }
>   
> +void *fw_cfg_read_bytes_ptr(FWCfgState *s, uint16_t key)
> +{
> +    int arch = !!(key & FW_CFG_ARCH_LOCAL);
> +
> +    key &= FW_CFG_ENTRY_MASK;
> +    assert(key < fw_cfg_max_entry(s));
> +    return s->entries[arch][key].data;

Shouldn't it be safer to provide a size argument, and return
NULL if s->entries[arch][key].len < size?

Maybe this API should return a (casted) const pointer, so the
only way to update the key is via fw_cfg_add_bytes().

> +}
> +

> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index 2e503904dc..990dcdbb2e 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -139,6 +139,15 @@ void fw_cfg_add_bytes_callback(FWCfgState *s, uint16_t key,
>                                  void *data, size_t len,
>                                  bool read_only);
>   
> +/**
> + * fw_cfg_read_bytes_ptr:
> + * @s: fw_cfg device being modified
> + * @key: selector key value for new fw_cfg item
> + *
> + * Reads an existing fw_cfg data pointer.
> + */
> +void *fw_cfg_read_bytes_ptr(FWCfgState *s, uint16_t key);
> +
>   /**
>    * fw_cfg_add_string:
>    * @s: fw_cfg device being modified

