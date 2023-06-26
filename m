Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C614B73E0C8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjFZNgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjFZNg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:36:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0A6E64
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:36:27 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fb10fd9ae9so5504885e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687786586; x=1690378586;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zdAAUjMq1y7wfLWcQNAaxgJmEQr9gQBVn17s0TNFY3s=;
        b=MJvJ+BDDMP5m14GpFy+9WfqZ2oABvFrcpJ3CqyRiZ2jg8XirfxfqsNMA77Y8qdTPpU
         q8So4CfTI5n9kWDxNzU8aaQbpnWvv9Tw7lq0OFa5TuiCTZQl79AppxFtJVA5Kb4pnQVD
         bRXsCzOnXd5ll2dcGFcEwknyDF9bKLWLSy1RwMXzXY0VlVTxsXdupVDy2qcCCdbZIVYN
         qHV/AjkW2uB+/1ngrvSgOqRegouuR0rMxb9OS+Koav95WQVaAbFWqZGEZmNi5l+wGsmu
         Bh+chTDMuL/revbimYTm6krQxnbDYYlMjJ2Gw6sjmzJtOETnBLDNzs7QHsiIFugTegVE
         MDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687786586; x=1690378586;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zdAAUjMq1y7wfLWcQNAaxgJmEQr9gQBVn17s0TNFY3s=;
        b=G8OxF7YgM8b6DTCcWYavGC1q6pPKTm8EgjFI96qRVcQ6z1W/NNEiSfdP4DteazQ3FU
         svHmi/ON29mCw73zL2eyUZwNblyKaGGi7X8+kerQz14TbHP23k+djFkylkRpcgW1KNfC
         lMdHSqwEm4Cy+HCj4bZSk8VanxWwRKLW+kuEnCjdojfCNF7bbin96z+138c3iWnD9L+u
         fzdq1Ic3izwUfuVxNS0n1uatS0cilK3Cq6WOwDZyrCPirc4MSVmRWLy4gE/kPTr+sebW
         f5YPEBM76F7113ASgEjv5XmzvLMdacHDoPWt04aau1ipIgAfQExnvdDNXMHf2EGvhT0g
         PCKw==
X-Gm-Message-State: AC+VfDzOaH8rrAt1zUwSL9Nu5Kj2/wwrG83lT3ahS3qtREwbAg+V6soh
        BEiz3AS3b10HMPSOgn4Pbhog3w==
X-Google-Smtp-Source: ACHHUZ4KDlrxPN0DkcnPjN3hKw3cGBfyGCmIkYwPJYPv7vqp0WhYABootPEQ9XYW8moz8aTWe9XAaw==
X-Received: by 2002:a05:600c:2119:b0:3fb:407e:9b31 with SMTP id u25-20020a05600c211900b003fb407e9b31mr687651wml.37.1687786585412;
        Mon, 26 Jun 2023 06:36:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b25a:b26e:71f3:870c? ([2a01:e0a:982:cbb0:b25a:b26e:71f3:870c])
        by smtp.gmail.com with ESMTPSA id f23-20020a1c6a17000000b003eddc6aa5fasm10574507wmc.39.2023.06.26.06.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 06:36:25 -0700 (PDT)
Message-ID: <41e6d93a-8899-e792-0859-d26360ef5dab@linaro.org>
Date:   Mon, 26 Jun 2023 15:36:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 6/6] arm64: dts: meson: a1: add eMMC controller and its
 pins
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     jbrunet@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        khilman@baylibre.com, conor+dt@kernel.org, kernel@sberdevices.ru,
        sdfw_system_team@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jan Dakinevich <yvdakinevich@sberdevices.ru>
References: <20230607201641.20982-1-ddrokosov@sberdevices.ru>
 <20230607201641.20982-7-ddrokosov@sberdevices.ru>
 <CAFBinCC_g6FhzR=PNDsYwT4OZb4uAXAWYGKSe7vSX7_pWM8pNA@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CAFBinCC_g6FhzR=PNDsYwT4OZb4uAXAWYGKSe7vSX7_pWM8pNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/06/2023 23:11, Martin Blumenstingl wrote:
> On Wed, Jun 7, 2023 at 10:16 PM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
>>
>> From: Jan Dakinevich <yvdakinevich@sberdevices.ru>
>>
>> The definition is inspired by a similar one for AXG SoC family.
>> 'sdio_pins' and 'sdio_clk_gate_pins' pinctrls are supposed to be used as
>> "default" and "clk-gate" in board-specific device trees.
> Let's wait for Neil's response on the other patch for the question
> about pin mux settings
> 
>> 'meson-gx' driver during initialization sets clock to safe low-frequency
>> value (400kHz). However, both source clocks ("clkin0" and "clkin1") are
>> high-frequency by default, and using of eMMC's internal divider is not
>> enough to achieve so low values. To provide low-frequency source,
>> reparent "sd_emmc_sel2" clock using 'assigned-clocks' property.
> Even if the pinctrl part should be postponed then I think it's worth
> adding &sd_emmc

Yeah it's weird to add HW definition and to not enable them,
so please enable them in the board if you add them in the DTSI.

Neil
