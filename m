Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D44C6A52F2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 07:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjB1GYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 01:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjB1GY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 01:24:26 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BF9C149;
        Mon, 27 Feb 2023 22:24:22 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id l1so5486112wry.12;
        Mon, 27 Feb 2023 22:24:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JSFEmiCY7GlwBzQ4MM0I77A4tzCllZnWLJDMQOA4vhM=;
        b=Aov6VbRttGZ+wnV2o+nx/vzJX6hBRQqrPE3QYtG/QnePYbP462xkYB6sd7mHQUEQyL
         XZe6aRX8USC4fdw4tYoys9FOkn7Ijr4GrsUBUUGoD7M2h7wRRfBMrhqZ0bLffH7bs26F
         4kMmhDHe+s6wwwwLg+w2KtgkfAVOtI5QZp+T3Nwtp08zwvFE/mTUkcCK8gO2Ona+UNLs
         qO5fFJBjWy0IJ2Dw1xFaA8Tarm+sGA8RQAOConYDRwzdpUIAFxPdychT309CrgLNGqJG
         iwZw7+1skAk1M03gR7qcqZesqBd8jyXIud6Gz7/0ueN/NdshvU6C+2UYzSFI8GihiS3B
         X6nQ==
X-Gm-Message-State: AO0yUKWivKGyuoy8jq6sRzqpwk0I56dCBbgAlO0o10eGMaVaF+lmx5VL
        GUvGpzoxee+htfaCn6rQt9A=
X-Google-Smtp-Source: AK7set813NgE+JXA2LmEDUpjrI6tJNr7GSYV2cXIp41bN5NgWSQU0zg4D2fdIH4eMOD0d5vUZRCalg==
X-Received: by 2002:a5d:5009:0:b0:2cb:de45:77ff with SMTP id e9-20020a5d5009000000b002cbde4577ffmr1270868wrt.28.1677565460340;
        Mon, 27 Feb 2023 22:24:20 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id b15-20020a5d45cf000000b002c703d59fa7sm8747091wrs.12.2023.02.27.22.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 22:24:19 -0800 (PST)
Message-ID: <3cab55f8-b8b8-d244-3c27-a3f84286020e@kernel.org>
Date:   Tue, 28 Feb 2023 07:24:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] Revert "tty: serial: fsl_lpuart: adjust
 SERIAL_FSL_LPUART_CONSOLE config dependency"
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, gregkh@linuxfoundation.org,
        sherry.sun@nxp.com, jindong.yue@nxp.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230226173846.236691-1-trix@redhat.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230226173846.236691-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26. 02. 23, 18:38, Tom Rix wrote:
> This reverts commit 5779a072c248db7a40cfd0f5ea958097fd1d9a30.
> 
> This results in a link error of
> 
> ld: drivers/tty/serial/earlycon.o: in function `parse_options':
> drivers/tty/serial/earlycon.c:99: undefined reference to `uart_parse_earlycon'
> 
> When the config is in this state
> 
> CONFIG_SERIAL_CORE=m
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_FSL_LPUART=m
> CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
> 
> Fixes: 5779a072c248 ("tty: serial: fsl_lpuart: adjust SERIAL_FSL_LPUART_CONSOLE config dependency")
> Signed-off-by: Tom Rix <trix@redhat.com>

Acked-by: Jiri Slaby <jirislaby@kernel.org>

thanks,
-- 
js
suse labs

