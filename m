Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F6E64CF1E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbiLNSGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238945AbiLNSFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:05:45 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D206B862;
        Wed, 14 Dec 2022 10:05:44 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3cbdd6c00adso7920657b3.11;
        Wed, 14 Dec 2022 10:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FBRUrtrmsnAbZI5Nq3EYtelch9Q3LJeA6lHE1domVys=;
        b=UHRRC0pGANkudw+xnCH/GIFzypLC4qzzMt/5EgGaoOEOiufocLdP8vszChtH4SvV0f
         zdxSIqX0sxkGsITNjKdCdFW0FqYf3Yp+5vfonJvQZZbu2oyn9iIlor22eh6KaDPoZsEf
         IFTP29bRpmUiLtR1Px+ulRtw15C5VY4dJx4HMND0ANnW12gQFUSPsC/niRf+r5cRmGa0
         oGhokcBD56S0L9AMqMCmURXRy2MUuFiLbPPA5JL2RDfZX/M3urqBGYfJfaUfswkgjU05
         HTzNqoxWfhnchIUe3OhvwfEKl3S2NnqXAu+hIczRzouVxcrWJWujw35c3f5Cwtq/o+Pq
         MZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FBRUrtrmsnAbZI5Nq3EYtelch9Q3LJeA6lHE1domVys=;
        b=yN8PZDRmMvgf19HXpNEiCpGEXK30w45BNGcuX8Z2RHqgtMgcnwNJ/pU4qDVGv70qsz
         4Dx0KQCCUIr/arLQ5Dfr7wTcywZK5dZCxQIG/k435+lCtCrst4Gvs2iZO1bK/6oZX6qf
         OUNmxiqh5pIKSujvytGdqbCJtfx8nMvI3hfeIrAmP9XXAugdaaohzBU+jSML/sRT/uaI
         9yS29z1wVnLJ9SQC5kyYncM6/okAfS98wXBaUmNUI7fc36FWBBSNuUrgEofCM5BnJGRZ
         NH408ONCePpWpRvLaRoLM3JR+cSX4+nzJaDtfTGIZrGE2x3r10207pVM5qW8zGRz6MXg
         5G8w==
X-Gm-Message-State: ANoB5pkC67eZ7DcqFj+QAbtHLEsX82EE1Bu46SfdS1ZWw0DAflu/uPIR
        jvvhTFJ7nt0+yXgGUHfhDjXizGlB+/U=
X-Google-Smtp-Source: AA0mqf6v2QbgQCgvdvoe/fB3DWofrvjz8e6NUAkz5YvYVc6gRIOBp/Ze8goIdkeETwTJc2tQ0aqkFw==
X-Received: by 2002:a05:7500:4889:b0:df:add0:8dbd with SMTP id gr9-20020a057500488900b000dfadd08dbdmr2653895gab.7.1671041142596;
        Wed, 14 Dec 2022 10:05:42 -0800 (PST)
Received: from [10.4.10.38] (pool-108-26-182-112.bstnma.fios.verizon.net. [108.26.182.112])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a0c4700b006fc8fc061f7sm10363309qki.129.2022.12.14.10.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 10:05:41 -0800 (PST)
Message-ID: <52c581ff-c2ee-8832-1f49-bcf40847d0b5@gmail.com>
Date:   Wed, 14 Dec 2022 13:05:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] drivers/mfd: simple-mfd-i2c: Add generic compatible
To:     linux-kernel@vger.kernel.org
Cc:     linux-input@vger.kernel.org, lee@kernel.org, lee.jones@linaro.org,
        michael@walle.cc, Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20221202113226.114465-1-Mr.Bossman075@gmail.com>
Content-Language: en-US
From:   Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <20221202113226.114465-1-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Are there any updates?

On 12/2/22 06:32, Jesse Taube wrote:
> Some devices may want to use this driver without having a specific
> compatible string. Add a generic compatible string to allow this.
> 
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
>   drivers/mfd/simple-mfd-i2c.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> index f4c8fc3ee463..0bda0dd9276e 100644
> --- a/drivers/mfd/simple-mfd-i2c.c
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -73,6 +73,7 @@ static const struct simple_mfd_data silergy_sy7636a = {
>   };
>   
>   static const struct of_device_id simple_mfd_i2c_of_match[] = {
> +	{ .compatible = "simple-mfd-i2c-generic" },
>   	{ .compatible = "kontron,sl28cpld" },
>   	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
>   	{}
