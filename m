Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B93362780D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbiKNIq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236600AbiKNIqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:46:20 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ED91C138
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:46:19 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id r12so18154187lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ayjb4SbwIOWUmx2oNYBfq/TTYDmZlaBaAub29KPIR70=;
        b=jt8d7u8QhOnfD+ySzp74OJ8+vcd3RhYSFerY0umLTHkcSE6G0dMluSu4ZdAqV0S//g
         8uUyVjfm2JFq02MsUxl5U8b7GD5AM4MJPR811q7JmOB6VMDARxKgtbX7H3jjxqdmaiEV
         vq2HS8HVeiyLIf8AEcVH69Uql4PtpiutAnyPkGCRYbDhdSIlcaSIp9hO5nPJLJgbpQzc
         KFp3SEFddtm+hYQv+Oud+Nz2OzQIA34vZ9yE5e7Z+ySoYF3ajio4tqzjAfjBinhQuSsM
         jOi1eOikYOMd85AcsGzsPJtg7J/SQAiJepwz2LPTHZq/qALpOvlwarCuCpKhYf9vBzPB
         /LRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ayjb4SbwIOWUmx2oNYBfq/TTYDmZlaBaAub29KPIR70=;
        b=W+TaAUlpv+GIM4HhkA49XGMCULhoRhbKGBL36jNY0o/W1KO4JHtRktDOHY13Y47yF5
         eE7p/0YNwiGPDNagJL3Sq92NGMu9o3wIo1BYuvDNgyxORm/O9PJOVo83LwAlm11uLZKu
         o+tqyPcLDig4UZhuSE0CASUfRCiP2TgKGZNT2XhWkhTplck+HHHUpxrnEnryorKiAawR
         0fUF+v4QjPOdKuvt39DA1CGnIkYZrDkPJHg4YnhOZaJqJq6D2PLr53a8fY9k5lYhO64a
         wy2SOjWszL1BuCTpt5bYwwYqhOqmTa4jYtaHkb8BsA1sWIkmG+mAFtLKg0bd1DQ8U5B5
         IVzw==
X-Gm-Message-State: ANoB5plQSHn5FqLfoDmJy3UIfZtL84GCt+Ay9oQ0Ir47nweP8lTlh5rZ
        PSldyfbPL8NAO00Gp7jxynBhDQ==
X-Google-Smtp-Source: AA0mqf5iu4twKL2vLty2ny/0PlQaggz76QRXb+ZgRWLdoaOfeh9gho7WQDbfPdtVWoFFt1HI77O9vg==
X-Received: by 2002:a05:6512:e8e:b0:4a4:2967:78eb with SMTP id bi14-20020a0565120e8e00b004a4296778ebmr3712508lfb.222.1668415578002;
        Mon, 14 Nov 2022 00:46:18 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e10-20020a19674a000000b0049311968ca4sm1730841lfj.261.2022.11.14.00.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:46:17 -0800 (PST)
Message-ID: <de1ff273-acf3-6a2a-6c7f-d97a9bc0a2c3@linaro.org>
Date:   Mon, 14 Nov 2022 09:46:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 2/5] dt-bindings: arm: rockchip: Add more RK3326
 devices
Content-Language: en-US
To:     Maya Matuszczyk <maccraft123mc@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     =?UTF-8?B?Sm/Do28gSCAuIFNwaWVz?= <jhlspies@gmail.com>,
        Chris Morgan <macroalpha82@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221112143411.517906-1-maccraft123mc@gmail.com>
 <20221112143411.517906-3-maccraft123mc@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221112143411.517906-3-maccraft123mc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2022 15:34, Maya Matuszczyk wrote:

Missing commit msg, which is actually easy to write - you need to list
devices you are adding.

> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> ---
>  .../devicetree/bindings/arm/rockchip.yaml         | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)


Best regards,
Krzysztof

