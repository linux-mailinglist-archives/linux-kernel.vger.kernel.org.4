Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6FD5F62A8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJFIaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiJFI3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:29:54 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5548C167CE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:29:53 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id x40so1359812ljq.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 01:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=uAYIfN3N6hYQLcdG5GZs69RpxPFHvLDVLJ8F8G3QEWo=;
        b=pw9hGkYx2KQyN2wfgY9vSshmp+Fj+edTmCL4mkANcmIVu84iXMHCUubYCirf6CIc9r
         Ozrums9nd51THvGi6STK86s5aMKbzb4cCKT3E+BpEkjKxLl9b0ioJTLq4hkHbtsMWUZ2
         kFkpyKREUTVHZ5rFBRaOI3/7cb5ti8bJuSgfbdURYZTR+kXXIT6jUA/aB4aVrEDa9g1C
         SLgDVQVQG5wnbzmhbCowEm0AHE7VkDpTUK9ysKxDQZuSnrrhJspR7o7LtYDfCXyDWNGk
         EUB9SYp3dOPN3AnSABZihqNpYnfSMfHJ8UPi+Qm3Bx2GbOECp7JNXaFqXqS8Z9nTcd2O
         YvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=uAYIfN3N6hYQLcdG5GZs69RpxPFHvLDVLJ8F8G3QEWo=;
        b=bol2LqpuN/2IisDl7PkFhyHqhe53ADRzohlxJrkGukfS1Hg9/5vjwT+3d05MOiVGbh
         PX55c65aqvrul6CN0B8x7k3QLqazjZ0j5N6Bl0Iq4kqCK/1wdXNB5oEHk+8iktqkpRbx
         Eoi8TTPK/gsgmPB93F4LMtKMuSCxaLUe1rUnw9eyegJUO9JKM9KT21WlT3WJeuzuv2Cp
         tKVn5pjAZ6S19/08xrFl1pEd6JwytNq7GTK73EuObIbeetjO9pZKWmuu3oTyLcYzAaHs
         UvNd8tiA6qwGiVD1VligTXJ4eIKOcGr6i5GaAE7CQsrDDURP6kcYgiMoeAkOyU7Lhemi
         Uz4w==
X-Gm-Message-State: ACrzQf0kIXCliuuMnu6goMJpAOe1NmsHGdwDfNewJJMiXLZS1au2l8Jr
        NImD+h4KHcG8dOlAifX6svnfSA==
X-Google-Smtp-Source: AMsMyM5WvUbcQT6uavWgb+MuZ7ljzT285yhajFAuaHxWUbLbKif7P7D7eXzbR0OpJlpLn775T1I1+w==
X-Received: by 2002:a05:651c:44f:b0:26d:ff1e:131e with SMTP id g15-20020a05651c044f00b0026dff1e131emr1231310ljg.308.1665044991429;
        Thu, 06 Oct 2022 01:29:51 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k17-20020ac24f11000000b0048b365176d9sm2616201lfr.286.2022.10.06.01.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 01:29:50 -0700 (PDT)
Message-ID: <8259cc0c-93e2-4e62-3ce5-9372e2b40397@linaro.org>
Date:   Thu, 6 Oct 2022 10:29:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFCv2 PATCH 2/4] bus: add Wiegand bus driver
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Za=c5=a5ovi=c4=8d?= <m.zatovic1@gmail.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl,
        gregkh@linuxfoundation.org, jeffrey.l.hugo@gmail.com,
        andersson@kernel.org, Michael.Srba@seznam.cz, saravanak@google.com,
        mani@kernel.org, hemantk@codeaurora.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20221005145746.172138-1-m.zatovic1@gmail.com>
 <20221005145746.172138-2-m.zatovic1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221005145746.172138-2-m.zatovic1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2022 16:57, Martin Zaťovič wrote:
> The Wiegand bus driver spawns devices and matches them with
> drivers.
> 
> Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
> ---
> The bus driver currently assumes that any new Wiegand driver will
> have a matching entry in the devicetree. It is currently sufficient
> as I will only be implementing the GPIO driver. If someone
> implements a Wiegand driver that will not use devicetree, he will
> also have to edit this bus driver, in order to match properly. Is
> that a correct approach?

(...)

> +static struct wiegand_device *
> +of_register_wiegand_device(struct wiegand *wiegand, struct device_node *nc)
> +{
> +	struct wiegand_device *dev;
> +	const char *val;
> +	int ret;
> +
> +	dev = wiegand_alloc_device(wiegand);
> +	if (!dev) {
> +		dev_err(wiegand->dev,
> +			"Wiegand device alloc error for %pOF\n", nc);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	ret = of_property_read_string(nc, "compatible", &val);
> +	if (ret) {
> +		dev_err(wiegand->dev, "%pOF has no valid 'compatible' property (%d)\n",
> +			nc, ret);
> +		goto err_put;
> +	}
> +
> +	if (strcmp(val, "wiegand,wiegand-gpio") == 0) {

This does not look right. Bus can have any device attached, so limiting
some bus behavior to a specific device is not really scalable.

Anyway device and node matching should not be with strcmp but rather
of_*_match().

Best regards,
Krzysztof

