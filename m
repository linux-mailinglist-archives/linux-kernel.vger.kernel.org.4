Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4270568C677
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjBFTLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjBFTK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:10:59 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26ED25292
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:10:57 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so1009417wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 11:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJ35SbYv7NGdql48VXYsLrxi0PK6KgusSlcq8eJhSMU=;
        b=kFCqpf2J9E7tr/qLs0vt5jthfd1kKsH5kNiqeeanBtEGDD7CYpUbZ5H1ONcf27h24Z
         SV/dmPXgho9c1ScWFIYGYP3cCDEoHspFirS+FSQeLxHS0oRE6gV0GCyDVK5NEuufrQoD
         aJ+N3QURBexzVe/QFmteNE/jkL8D2PbHFNCTN6Ms/78nv30Q2bZMS03inIyCkuNTEU2w
         yK6wDEu8j/DOLOSYq5IvLB500bGEBFkMNmDNgryfQDCkYVtxDpHOfXwSPcrclnfgCem7
         kvwoj4ILSQC7fDvY/8wu84saoGffain2ipVRySoeehUsUS5cexd8t+/19rmwWkTLsMIw
         4E6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJ35SbYv7NGdql48VXYsLrxi0PK6KgusSlcq8eJhSMU=;
        b=RFTD+YnvNQMk8ZlCz0b7LbhNiPbQm/ZAW+kXI0IXXXz98jdDhXIdqoRB8dqJMlrdj4
         sfxo+Ii3GAILSzoINZgnoIQFpVsWFR1Znn15K+GIjOITnsHBbHwKmP3xnkYoQyxlM0Ez
         wJxmMEuYpsxOpRQ46osbiYttKxJMl5qTVfSk62Qpjskb3wz4YXH003lbComuzuaKlzjp
         EdyhuHm5f5z8iX7DJug+stVuo4sFVSx0A9Xyyxd/rgNeA+MWfaLL9flGvF1qAquWLDSO
         Gl0n0GgzgZEkdK38RC0FBNA3hA/DedU3oiEE8NO/hG3sxz4lb2Tm04QrGyRn/r7Z9pAZ
         MNlw==
X-Gm-Message-State: AO0yUKUtGU3gO0+F76x+3IOCx1KxPTwVRUWvqcUXBfLm+JCaluMfdZFT
        WrPJVwvR6e03rcCChHLdVkGppA==
X-Google-Smtp-Source: AK7set/n8vlvMulK6/8IoZIsLl8tl4ERJICO0rXpurEpfoRkJl63bdL+Fskt8n2wb8Pwgoo61c+SwA==
X-Received: by 2002:a05:600c:807:b0:3dc:eaef:c1bb with SMTP id k7-20020a05600c080700b003dceaefc1bbmr690356wmp.35.1675710656403;
        Mon, 06 Feb 2023 11:10:56 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c190e00b003daf681d05dsm12848398wmq.26.2023.02.06.11.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 11:10:55 -0800 (PST)
Message-ID: <7617f172-e3c7-f60a-f3c2-f02403ec9047@linaro.org>
Date:   Mon, 6 Feb 2023 20:10:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/7] ASoC: dt-bindings: meson: convert axg tdm
 interface to schema
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230206153449.596326-1-jbrunet@baylibre.com>
 <20230206153449.596326-2-jbrunet@baylibre.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230206153449.596326-2-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 16:34, Jerome Brunet wrote:
> Convert the DT binding documentation for the Amlogic tdm interface to
> schema.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

