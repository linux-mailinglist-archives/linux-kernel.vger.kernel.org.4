Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2FE721777
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 15:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjFDNfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 09:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjFDNfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 09:35:13 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3ACA8DA;
        Sun,  4 Jun 2023 06:35:12 -0700 (PDT)
Received: from [192.168.20.2] (unknown [77.239.252.99])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 9FB2D1407E3;
        Sun,  4 Jun 2023 13:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1685885711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hWSdLvdNVWuD5AVS9UvtS8NdUTlSKL3owLdgzwv6oRQ=;
        b=XzHiyYY8t9XMYJATI9brPQhkzMKLrRnM67HCzUAb9CMZ9qsod9uCiBLufJ1oDGM29ORz/I
        C4n2TqYDRsxR+zemBOBC0l8UWorC42CQEOGFqmuqpVjU8MwHwW62ERD7ESLinn53y+GCgo
        KUASu+xuJBy/G6iiLMpW3sl2EDA+lLc=
Message-ID: <06cd3bc1-ce97-3b62-c5f1-98b22c8c24b0@postmarketos.org>
Date:   Sun, 4 Jun 2023 16:35:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] dt-bindings: remoteproc: qcom,msm8996-mss-pil: Add
 SDM660 compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230604061421.3787649-1-alexeymin@postmarketos.org>
 <05658f98-ddc1-702b-ea4b-4ea95d0b3313@linaro.org>
From:   Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <05658f98-ddc1-702b-ea4b-4ea95d0b3313@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.06.2023 12:11, Krzysztof Kozlowski wrote:>
> You also need to restrict/constrain power domains and resets.
> 
> Best regards,
> Krzysztof
> 

If I understand correctly, power domains and resets should be already 
restricted together with msm8996+msm8998 by "else" branch [1]?
Am I missing something?

[1] 
https://elixir.bootlin.com/linux/v6.4-rc4/source/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml#L311
-- 
Regards,
Alexey Minnekhanov
