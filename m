Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4A36CF10A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjC2R2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2R2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:28:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4044682
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:28:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t4so11321202wra.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680110910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZCNxr+oj4cFsqW1MLQR23HStFyvDDXQrrpexBrJfQA=;
        b=vlogCfIt59EF3vLeHX5VIm0sLO1Z11g5kuWxjI6vgJBQJPXhBrFnTXxxLzCqj3CPsI
         mjdMYojOh6lJZGN+tsAPuif6kzwUCSJNvjJjYcDNSEsfPsYBVUHtjZGYJfyPqXxqoJty
         UvI1vbLP1KZqiCPD9mEmtx9NFGzuEukDdVZtbMC1rfyenzGdyhdtJdxi44+0LujyFHvb
         0BnL0rf/6KVBUY6MgDXx5qQgBBV9TsNVI4k0NKmgpuMvAZAuCVWkpC97sVIhIhPWa9J5
         ykGC3t84AikAZRGT22dhJE1p/83FbREZVV02EQXxXmz8S1FXjOG6PK18jOqyqdL9q5oI
         64GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680110910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZCNxr+oj4cFsqW1MLQR23HStFyvDDXQrrpexBrJfQA=;
        b=mefUH6cGNXYJ5feZokiDC/m0GLS9ca6WjD5E8l/85RMX1o82l/5/HJfSgUdkjWbgul
         ZmqAr5+a1jt7usklns1vcnOkzxr2UXkOmthmbssYPutY6e+MvBIl+8jjwE8R4gi6m/2/
         9K3IUfw/0f8TKcGPSlbsnxFtWttYP6NVeIgsRH/UGexZ4s7R8ogUXI54Zys1tnnrisdz
         1BoBsSEOYOti8sJKmj839/HD2y/2bu6CWFYPGCxPSrhQwKLGuiiX0HBgbge3eC+rOZRj
         3i4J35LS6S+g+VbUSPNGPIwqKo4ihosakA2GX6l816HEeir/+GgFGGvVxiiHJYS3yQkS
         0bGg==
X-Gm-Message-State: AAQBX9cb1h2Z9neGmKe062U62dT5ECGFiwzOWidh9oS9hB4HxauXkMSx
        8SD/4qzPMZRuNlUMiASoK/HRXw==
X-Google-Smtp-Source: AKy350ZGeUJMVibVvn0q1wY24TPjN8cv1M4NvOz7Wgb304/gu1m4+JBV7UoNb0UbLTMsjpegdAlJ2g==
X-Received: by 2002:adf:f3c9:0:b0:2ce:9da7:6d42 with SMTP id g9-20020adff3c9000000b002ce9da76d42mr15295791wrp.38.1680110910682;
        Wed, 29 Mar 2023 10:28:30 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id k16-20020a5d6d50000000b002cff0e213ddsm30645860wri.14.2023.03.29.10.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 10:28:30 -0700 (PDT)
Message-ID: <03f2edb2-e747-6952-ac01-d642dfae4fcf@linaro.org>
Date:   Wed, 29 Mar 2023 18:28:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 11/11] mtd: spi-nor: spansion: Determine current
 address mode
Content-Language: en-US
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230322064033.2370483-1-tudor.ambarus@linaro.org>
 <20230322064033.2370483-12-tudor.ambarus@linaro.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230322064033.2370483-12-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/23 06:40, Tudor Ambarus wrote:
> +static int cypress_nor_set_addr_mode_nbytes(struct spi_nor *nor)
> +{
> +	u8 addr_mode;
> +	struct spi_mem_op op;
> +	int ret;
> +

reverse xmas tree in next patch set
