Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03273683640
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjAaTQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjAaTQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:16:51 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D3758646
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:16:49 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso8618866wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9MPbe5iwRaaP/IhZCNpsudukeeF99kTQgmfKMrip8BA=;
        b=z5ogbM37k1wr3/oCWnDbpLVmf2A2QM+l1gRn1csf3YTqwBpp2Pt0BzMzp8SHaJvf1i
         4lR23QOEODZ8w1IbL6qMPoA4n1gsfxVdvafWi9rVCY+Pm04RaKDYjC4D6MEWAEto2qm2
         TXBcOxoop/r+Q9zPKYxlV5kyoq2i9I/a7rlpZ8x8OjEdy7YrWtFMn6uZGXTMJCDYQjju
         CmoqnfQVLVLK+mx3ZPtmxIg4E7JKKIo0QSBlhi+ZrU2e0FAjD585kR8XgLWGX81IPrji
         tgo0KonsNDSc2yeRdfRR5JnYWIsTwTUb85Cz1chcZyCP9O+INl+8mX1lqtLNDowc5Sm7
         oHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9MPbe5iwRaaP/IhZCNpsudukeeF99kTQgmfKMrip8BA=;
        b=lB79Dj1SQESOzxyqgUF/LiVUcBtNV8+x4IQL9YUgUAL8N8XAH4sISRrfB9/lVN0KdT
         20/Y6UNMMrPLJfIq3NBuhDvzw/lQbzJeM4UlzEh1tU54ZbPT7Q4vp2UrOqDAXbWaTrP7
         0/MN/45ITQxQeYwPhyTRwv95rMrCzyvsa8/viGAZwjkBk24a/VWzls6H76cw/WCDK7jk
         umBhaMKsgeFouBYLrqSjya6nUQXBOowZFvK/DkQCHCpJS6tSrXlzUmcLiMVBc5iBKI1M
         UuSDI+t6Umb+jbmFEZfS5JWYphrRzYlMn1GNkcPEGMcTkxy7l99dPzbyhSJ0HgcIvP+t
         ty1A==
X-Gm-Message-State: AO0yUKVmnvIvLxf2xKmoR1EIaNvX50Ykjhcw7XREvaTfuwRK3cARPv0W
        rKlAqsO1RLDnrBW0LYJIvd7fpw==
X-Google-Smtp-Source: AK7set/LpiB/mUdZaDfwthxd/ezxlPemqRQ7sUPZnHU1TMciOsezu5qImknY4ffAJhBqQbGcoL7QEw==
X-Received: by 2002:a7b:cd87:0:b0:3da:fa18:a535 with SMTP id y7-20020a7bcd87000000b003dafa18a535mr280865wmj.29.1675192608325;
        Tue, 31 Jan 2023 11:16:48 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c130e00b003dc541c4b13sm8320321wmf.21.2023.01.31.11.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 11:16:47 -0800 (PST)
Message-ID: <b510b2e1-8f0c-f942-75c2-65f1f3efdbfe@linaro.org>
Date:   Tue, 31 Jan 2023 20:16:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] dt-bindings: mmc: Add cap-aggressive-pm property
Content-Language: en-US
To:     Hermes Zhang <chenhuiz@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     kernel@axis.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230130064433.962712-1-chenhuiz@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230130064433.962712-1-chenhuiz@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2023 07:44, Hermes Zhang wrote:
> Add a new property: cap-aggressive-pm to enable the
> MMC_CAP_AGGRESSIVE_PM feature for (e)MMC/SD power saving.
> 
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>


We did not finish discussion from v1 as you did not really answer my
concerns there. Don't send v2 because it looks like you cut the
discussion and ignore the feedback.

Best regards,
Krzysztof

