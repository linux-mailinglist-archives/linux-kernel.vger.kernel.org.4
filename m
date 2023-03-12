Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C6F6B6B9F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjCLU72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjCLU70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:59:26 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427911C7F8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 13:59:25 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id cy23so40955595edb.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 13:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678654764;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ojmHiospp0l2w82k9fYofqE/qnmF5HNMtDT4Ay91tEk=;
        b=CWdN0yO5/2LGAIiveuSyPFt0GHP9BZbWKjdusuqV4gMdxv72onNNlQAN8MViOab00/
         +zDoGTYao+pTtD6Bu1lGTmbIRHkatu4PrCUrVROcPd/7VTXlYU0TV9XqcXebKrthbx2L
         SFmQzUb7EbsErvQ8gLXD+fu7/R7VzUsoPLiKd0dk4XyEUk5EfFxpF9W+UfvAyON4Tjqr
         5YNcpjpEswefP8+HP5UpYv5Ff/UfjpdrOItjFiktoS79A/pkOCJcLiS8/cUKbFwubli1
         9YoyNJFgjJxWNBaHPqoIycdOYAT4Uw6HC9tqNsOzHWHq56YRQYRYUF4CxLxCjJXW8xpj
         UtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678654764;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojmHiospp0l2w82k9fYofqE/qnmF5HNMtDT4Ay91tEk=;
        b=sXDdmYCYDcv9WtChrWxYJtDJlQpdAKtQw3r/1zYR0UJbHWbVHHFhMfZmpQxw0WJpEx
         6WYh9vm2OV1fVtfLy1HI3nSQCy/bPuFp+WVj+HFGV3/K3xEiN65Bzv2DOcJP8OZfNd1K
         VoTiM3pv+pm82GebKeOtVy014QEFj6tvuo0vVBP3OHr/oZ+iYtOw4AqbqXsewFTPd5w0
         IrRpMok7J3sivmC0wGx8CYhf0rDuI2oAqC9sj5dG6Bk+4xtHMqKHdnTQIvwjqZom67I8
         ecY2bQf1625CV1jcryNPMm4v1VRDRbtGgKTF4L9C60+RyRZ56vkXwiHvgCatFb2j3Kbh
         mBHQ==
X-Gm-Message-State: AO0yUKVrRpnvQBSJM62LXNqhSRxAMAn2+Xg+PvO+00nN1LL/KC6cqzGT
        mky/9VWNARogWbCm1slgiuzAqQ==
X-Google-Smtp-Source: AK7set+kdX1DUZ3VExD9apqtNUWI6HQBytcpCuYbTvfr0ahW3vdKucREs/UQjFIenjiorzikl9UNGw==
X-Received: by 2002:a17:906:1d01:b0:923:1714:b3d0 with SMTP id n1-20020a1709061d0100b009231714b3d0mr4291673ejh.19.1678654763760;
        Sun, 12 Mar 2023 13:59:23 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709061c8700b008b980c3e013sm2613225ejh.179.2023.03.12.13.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 13:59:23 -0700 (PDT)
Message-ID: <572cdb2c-1b13-d412-d3cf-7d4138b297a1@linaro.org>
Date:   Sun, 12 Mar 2023 21:59:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: add compatible string for
 Tolino Vision
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        marex@denx.de, max.krummenacher@toradex.com, leoyang.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230312205236.2281466-1-andreas@kemnade.info>
 <20230312205236.2281466-2-andreas@kemnade.info>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230312205236.2281466-2-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2023 21:52, Andreas Kemnade wrote:
> This adds a compatible string for the Tolino Vision eBook reader.

Do not use "This commit/patch". but imperative mood. See:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

