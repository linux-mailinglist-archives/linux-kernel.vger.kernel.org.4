Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9CE6E21D5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjDNLNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjDNLNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:13:17 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A443976A7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:13:16 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id c9so5802271ejz.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681470795; x=1684062795;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=psY0d5ToWBTg5sHC9IG5B2CfYcgXjgvgXdRnCXIvLBU=;
        b=L1SdmjBfahNJn6+qCg42lXiaQ8oVkiuh3DDL9mvcUay6+HkM8H9AIjQxRXhbSln1c4
         QdjG5e8IJO6WSxfFD/FR7oL6RUP+eYeuV83HrIPlBlWRSZE37yi+fUKratpNGwJJocEu
         uPUFi0AOYGJmCm2hytvoT55811pfwXdV4gZ+b7SZH9wCHJD7hHM7ZX4qbSpZAPSSye/7
         R2OOgw6tkOQl2zVNwqNGW7jlkfCg5cMQHE+n3QWLQ3XzklI5FwfZmuN/Ew/6M06jbXpo
         YWqh8wKZruqr7HRwRmL56zPGRYQouzt6P+MxbDcy2VwpucwkBb1TlW77Yt0r9q9/CLH9
         DyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681470795; x=1684062795;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=psY0d5ToWBTg5sHC9IG5B2CfYcgXjgvgXdRnCXIvLBU=;
        b=ZzXDRkmzyPo9kK8zAazVYMrepND/XjRm12e+VER7Fy5cf46rZtcbKnMUnTqQAMcjGu
         6IJRa7Jn4/0sJxL2YjigvrMAKvk9hm6LS0Itpao864pVw+r0KiZOQoNk/kg8YtP9hl0k
         Z+teWXGoHHMwBCSPbL0SqfSQD78xGyrx3cYJx50ZpMKOd8/mnhiHl9F0QOtxoVfv3tDV
         V47TzA0MXEpQsOlPh7qsUw7+UhrqtVjYyzmFKwZGiPocfMwkGJbLO7mfpLpoEDgvBJUD
         5X71/YAw4BsuinuK5DFf91mQR0mye2TfoBUZycCcKNJCcP4Ai5yI3yJwF5ftPRapFBMO
         klZQ==
X-Gm-Message-State: AAQBX9eCLtHQS1WcN9qCgVuMD9Jh71dP5ti0j+J1B483Qx6OIrlGkLQJ
        ZvWzEsJbPCjOv1R+C7WeBBYewyddeycN2PnSvZE=
X-Google-Smtp-Source: AKy350ZNOGwbZFE6W13wrEpGlT+5R6yJewG1QyRR1QUdQmTg8TtllCrMa/iTvjufFd8f1ucdM1Szvg==
X-Received: by 2002:a17:906:77c9:b0:94e:d688:c36d with SMTP id m9-20020a17090677c900b0094ed688c36dmr2993391ejn.38.1681470795069;
        Fri, 14 Apr 2023 04:13:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:40b9:8c57:b112:651d? ([2a02:810d:15c0:828:40b9:8c57:b112:651d])
        by smtp.gmail.com with ESMTPSA id ca15-20020aa7cd6f000000b0050477decdfasm1988151edb.3.2023.04.14.04.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 04:13:14 -0700 (PDT)
Message-ID: <a1fa95e1-e21a-dacb-d6da-8832eb6fd912@linaro.org>
Date:   Fri, 14 Apr 2023 13:13:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 1/2] dt-bindings: spi: add loongson spi
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230412045152.4694-1-zhuyinbo@loongson.cn>
 <20230412045152.4694-2-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412045152.4694-2-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 06:51, Yinbo Zhu wrote:
> +LOONGSON SPI DRIVER
> +M:	Yinbo Zhu <zhuyinbo@loongson.cn>
> +L:	linux-spi@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml

The path is not correct.

Best regards,
Krzysztof

