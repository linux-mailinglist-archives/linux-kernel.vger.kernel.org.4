Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5F4647F92
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 09:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiLIIwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 03:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLIIwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 03:52:50 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B56AE086
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 00:52:47 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b3so6005409lfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 00:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t8D1QHQCpi29rzUZgRP89fJD5YqRNF7ocoA5T9SiKjU=;
        b=cIiLqmfm+vYdVKmG+GNYNX5be0nbheIFzXVWtAlhWk+RkRzT7DmA5ieXvUPqdLNHJg
         7qKKpuS8ObSV0MARDlnM5CAo+7MDTX4ak8jXAHFIS0mwxsbjEh6pZXJaa5jxfXT/uZL4
         MGplh7lO0U5fL0q1KZIf6j9+8p65W1FDt94xvRdrW8kjyd89qAvLVK+gWiIX5yZ3Os2D
         phjLCO4Rjv9T5HxiLUb7PLxZ1moW0LtDI4OdEbwwKryEji5GMBwNNeSkBKt4Gk9UX5JJ
         mbMesFVcZTlLQFBYv+zCzyyYw5Wjis1uudk2Z0hR3i+EWE0JSofRkSx+MA8lLXRhvjcf
         oDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8D1QHQCpi29rzUZgRP89fJD5YqRNF7ocoA5T9SiKjU=;
        b=MlfUJuvA0gsVfyWCjZtpfUKi4SdsWYq70HVK/gBMz2T1C3PrdwRqwPiMOFDwEyHs06
         Y6il94ozxkeT78sOmcGcaWMIBrjKB/CWFs/JxOzDfkxZVWWyT3WQojDjREoSwVYTGsiE
         J6gS1M10/aEOV9nMiP7Zu4TKz6j1jtixZmCo58YaHl43sjzvybK+HeoaNYhVxtMuwOdZ
         zRZriggBqA+xsamksX3JrPiCXKSv+56xpkffPsZa+8CSU5EcFBPWsakp4jK+q6mxxuzf
         40Lxq9QBP+Ye8BHWBSF+nCoohoFZfdOBPD1zmRYE8QQ1ejgrvm/EEhBCgZYQM/3jOFtB
         KkVw==
X-Gm-Message-State: ANoB5plTn5qgqhAZZ4LU9X5C2zBy1LNzqI1hywIw4A7BbJr39wbxl+39
        tW86YEe6b9edA9wrV51quCPs5A==
X-Google-Smtp-Source: AA0mqf4s8dwZrPgP5uaIipu4vmk7CP2r3nM7cQ0pGxmNAWVLRsr7PWOLyYeq0TYAdB7CiUq+wPdd9g==
X-Received: by 2002:a05:6512:10cd:b0:4b4:b8b9:e304 with SMTP id k13-20020a05651210cd00b004b4b8b9e304mr1712294lfg.22.1670575965824;
        Fri, 09 Dec 2022 00:52:45 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j7-20020a056512344700b004a100c21eaesm172948lfr.97.2022.12.09.00.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 00:52:45 -0800 (PST)
Message-ID: <500f9bdf-0de1-d6b2-1f09-11128699ce3a@linaro.org>
Date:   Fri, 9 Dec 2022 09:52:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 7/9] dt-bindings: mtd: Split ECC engine with rawnand
 controller
Content-Language: en-US
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, benliang.zhao@mediatek.com,
        bin.zhang@mediatek.com
References: <20221209064317.2828-1-xiangsheng.hou@mediatek.com>
 <20221209064317.2828-8-xiangsheng.hou@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221209064317.2828-8-xiangsheng.hou@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2022 07:43, Xiangsheng Hou wrote:
> Split MediaTek ECC engine with rawnand controller and convert to
> YAML schema.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

