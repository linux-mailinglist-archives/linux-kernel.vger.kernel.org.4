Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C786F82FE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjEEMc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjEEMc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:32:26 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C601CFE2
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 05:32:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-965ab8ed1c0so275635066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 05:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683289942; x=1685881942;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m5omqk/hpCJeATo0rNTnZV84JSlja//TXerFzgl7Kd4=;
        b=jvwIIPuBxo9RVg2kci2vS6w4S3wac7x/LYTWBMWIET5UDNGLeUG/RonGSskaclwp9I
         T3yLGRcVLgpaYR64TKOQOSDE2f4Xt366YXPTRSArfStsJD7GSkRPB4ibITEg/dKSn/8w
         iJXWecyta8xnNRvQprvjq+KzRzh5OWMvZfXmzUmElundzjM/duf8uArl7c114JdGxGCM
         K/7KXSazXmoFRvJtjzeV+KXy2QOeSTD3HPS0Msa/UGtpAdGefqYAIFMy33sRlQI6tOOe
         lsMfGDsQ5mArJkyVK3cAH6/2woy3VZ++RAa5c63P+0VeX27uIoDFvnUOD/KyhZ+iFP9h
         0o2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683289942; x=1685881942;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5omqk/hpCJeATo0rNTnZV84JSlja//TXerFzgl7Kd4=;
        b=ehImdWQny4SXDKFd3vq/F+uy/Z0ViutdOmiWMemxfNtlm9VRtz1zGaOjQMbOmGIKIL
         1ythDQgNV70JBsYaam4cu0Muk0oGXICS0sOJcN/JWMZ680wgIsGy617ZHnRyuIIG+Ri2
         a2BsRna2Gs9TOVw56BLbpSDZSrU/S6V6nCygC8F0EjhGj0N97gEqY+W3wMxkljhU+R1c
         Db95V6CbC2IKN/z2qzd5ytgIYXzkbHSDd8cvPkeBNTxcgriXu+UcqkJ7NGuiowunY3NL
         AqFmuOnTZJdlNk5o5DLq0Gc986S8o8JqmvU72AboXlTfMWBLgyPZbOQ1SY4wFklSnPaH
         r2BA==
X-Gm-Message-State: AC+VfDxA+f2rqq76Gi7myb8C49NC+7Pqfo0LxJ4r0E4QjxJ8AGC94YAv
        UG3Lg4mo+mipgLjipfT0j7PtEw==
X-Google-Smtp-Source: ACHHUZ4+6P359EPLf/Xig5/oQyDJN8Le9JY0QT5lpJA262gEFJ+jWYEY1pr79v2B+E4zLxTFMf1ziA==
X-Received: by 2002:a17:906:9b8a:b0:931:df8d:113 with SMTP id dd10-20020a1709069b8a00b00931df8d0113mr1272957ejc.26.1683289942345;
        Fri, 05 May 2023 05:32:22 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id u3-20020aa7db83000000b0050c04bcc3b2sm1737285edt.64.2023.05.05.05.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 05:32:21 -0700 (PDT)
Message-ID: <14ec49cf-c232-7dee-8dc2-8bc7d40f1716@linaro.org>
Date:   Fri, 5 May 2023 14:32:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/2] clk: mediatek: reset: add infra_ao reset support for
 MT8188
Content-Language: en-US
To:     Runyang Chen <runyang.chen@mediatek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Runyang Chen <runyang.chen@mediatek.corp-partner.google.com>
References: <20230505120108.26603-1-runyang.chen@mediatek.com>
 <20230505120108.26603-3-runyang.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230505120108.26603-3-runyang.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 14:01, Runyang Chen wrote:
> The infra_ao reset is needed for MT8188.
> - Add mtk_clk_rst_desc for MT8188.
> - Add register reset controller function for MT8188 infra_ao.
> - Add infra_ao_idx_map for MT8188.
> 
> Signed-off-by: Runyang Chen <runyang.chen@mediatek.corp-partner.google.com>

Same problem.

Best regards,
Krzysztof

