Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0D9729D1B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241558AbjFIOjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240056AbjFIOjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:39:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50B8359D;
        Fri,  9 Jun 2023 07:39:34 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f6d38a140bso14485905e9.1;
        Fri, 09 Jun 2023 07:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686321573; x=1688913573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CkTk/I2vJ7u5Kgxyjnr/M7EFdjdjE5R1J++r5jqjZYk=;
        b=dkNyG7XkCxcLXXvDrfl0Nk2GcQt1r6wldGM8N+9rl6hd7psFwlVLlMVe9sT2ypfetd
         hjTn3HBDLw9T5+WcgPAbAo7FV0W6DOxa8RDNuqCzcjdnBdwGejh7tgUdHDvcNV/4oQhS
         gK1WOQlWDEZgTKLhSRzVjn7gUubIJ2RmzYrQ8egF+8qPjt0hRXTgvYP/JST15ANuRMVB
         Ntz0K8eiaSAJA7GmL1nI5M1ANmLRa39qkIb+05oWHywriz5uG/2oWhPA00QCYSTk+Jox
         E7+yzCRKMRb0htjbG+jPtu8u5r3SXTyJhnMkc+bXevXsDw0V8Xniq88Ivmwt3wOzIdS1
         zsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686321573; x=1688913573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CkTk/I2vJ7u5Kgxyjnr/M7EFdjdjE5R1J++r5jqjZYk=;
        b=eWNcMCkEYP2CDq7xkmeVgF10UrMO9FsA0tAUOpW+4h09AVUAWMapvzMJyY/AerLbwf
         LE522/lDIDvcV5xRJFH5Qg2wDUGaoSPHxlMWuSEQJvpdewH1H5Rhp5KzGWgjSWRH0dCI
         3pY8iuie7yCOf542c6l7YeIqVPg1ZjRV82d2mjIuA3vdjVJOfBd0GjCPzK4vHj+hEPaZ
         +tM2dn6GDox81nIFrocWiUHMd1jYL8EtiwFqRAXQmYHtLbMQJpKmQbYO0WDIgMDWuvr2
         27E7pxtJjC4+/UcsIFhTavpBSp9IH+bM7+ZvZUx0uZdylYoj0I330MQWAszgK6KNpRmP
         bhpQ==
X-Gm-Message-State: AC+VfDwKEuhg8+KVH94iGKfbaHVzpNJTAdAsX0DOLEA4kA5ksgkdpZZa
        beSGUDwllPC86gJfzawYOKc=
X-Google-Smtp-Source: ACHHUZ4XeIuOaMJ3DqlHaX6FKCIBcclWXNEcRhBX/xprbU/C314K41du+V9pZsffr/MVyBXzjOYZ/w==
X-Received: by 2002:a05:600c:3793:b0:3f7:2b61:4c98 with SMTP id o19-20020a05600c379300b003f72b614c98mr1625635wmr.13.1686321572880;
        Fri, 09 Jun 2023 07:39:32 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id u3-20020a05600c210300b003f6028a4c85sm2901015wml.16.2023.06.09.07.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 07:39:31 -0700 (PDT)
Message-ID: <ad9bc224-7e3a-49cb-40c7-c1fc0876599d@gmail.com>
Date:   Fri, 9 Jun 2023 16:39:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 0/4] Add mt7986 thermal
Content-Language: en-US, ca-ES, es-ES
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Hui.Liu" <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Lala Lin <lala.lin@mediatek.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>
References: <20230530201235.22330-1-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230530201235.22330-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/05/2023 22:12, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> This series add thermal related devicetree-nodes and necessary
> dt-bindings.
> 
> I left pwm-fan for r3 for now as i cannot test this completely due to
> missing 2 pin-jack and 3v3 pwm-level which my fan cannot handle (starts
> spinning at ~3V). Only checked voltage of pwm there.
> 
> changes in v3:
> - efuse compatibles into one line
> 
> changes in v2:
> - drop highest 2 trip points as they are not yet used
> - leave already applied patches
> 
> Daniel Golle (3):
>    arm64: dts: mt7986: add thermal and efuse
>    arm64: dts: mt7986: add thermal-zones
>    arm64: dts: mt7986: add pwm-fan and cooling-maps to BPI-R3 dts
> 
> Frank Wunderlich (1):
>    dt-bindings: nvmem: mediatek: efuse: add support for mt7986
> 
>   .../bindings/nvmem/mediatek,efuse.yaml        |  1 +
>   .../dts/mediatek/mt7986a-bananapi-bpi-r3.dts  | 31 ++++++++++
>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi     | 62 +++++++++++++++++++
>   3 files changed, 94 insertions(+)
> 

Applied 2-4, thanks!
