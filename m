Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0756695BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjBNH7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjBNH7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:59:32 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC38321A30
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:59:23 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bk16so14678980wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/JB9QIrDQG4CfUwnJnmJHURss8n6y5r0NU4FF1ybcOY=;
        b=qAqxgSODzxDyTtcq/4YzRq+cGiwOq537sThYsXbWUrr5I5oLLGPfz4qdc80jwI47/n
         gQP6Bm5uNsOcBxgWjtvFBotw6uphu74pfr63/o2XibHhrdxbxZFpZ4mzPLQ/z/gyeZ7d
         2m4NLSl1vE6Dea1RQnILnVM/71nYhLyQ/JkQP0rhqhxhMkS72pFADqFLyd3kGes7tEg/
         Vb1/NtOebPktNHxCvT9ncSlx/4RcJIMsbsEfWT74GiiSmejvt4OAb76vsjeNz0jbnTwO
         XtJZHz+t4YlkaWX6+ZRG1RF4kiKwZEFLwtNas416NVqVDPVKU7Fsr3NpizAAVgGn7aiw
         JH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/JB9QIrDQG4CfUwnJnmJHURss8n6y5r0NU4FF1ybcOY=;
        b=It+PLREOe6xSPD86gwmeidBz8lZmbJXe8FE/dAvEse5Nw2zkUSY6UzJxmHrejhPDZI
         PEmVeUjWKE/XxBFjoOLSua1phpDKMBvYFEZuEJxNl61SYYGFH9I3nHeQBZ8xtE6azvEz
         1pYivPa6LwSq3znt85qflkKkqnc7G+/t7f7Yfdm9+KY1D3jAQvKfFhpIKZfmeVRncX24
         SpeZwqfikEkxDoS3tsDw+R4HlwNqE+/Zb5x+3c6xmi3co6pKeTtjv8TwQqkJslpLoh9d
         RU1sU3GeykRqr48/PVf8IpmT1Q2ndwSQQTxG7q1IRhhGjhBD7+iCm7msLQOVb3XO6hoa
         h47Q==
X-Gm-Message-State: AO0yUKWzZ0ebOAjB0Bdqd6mSAy/uz/cPynThMWBRKZsQfo/1dRe9+HM7
        xOLO3JNiu4NBpUeqaJ4ntK4/nw==
X-Google-Smtp-Source: AK7set+98H5eySUi1t645pCzonFEeQEPFX4XngrbFuT3irGY+a2DKk2pDb3xXXSGM8p4h3E3VbzrSw==
X-Received: by 2002:adf:f744:0:b0:2c5:5521:a79d with SMTP id z4-20020adff744000000b002c55521a79dmr2105691wrp.67.1676361562026;
        Mon, 13 Feb 2023 23:59:22 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d12-20020adfe84c000000b002c3f03d8851sm552777wrn.16.2023.02.13.23.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 23:59:21 -0800 (PST)
Message-ID: <95318688-fee7-25e3-6614-16d03aea5ce5@linaro.org>
Date:   Tue, 14 Feb 2023 08:59:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: PCI: qcom: Fix msm8998-specific compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230213211408.2110702-1-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213211408.2110702-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 22:14, Konrad Dybcio wrote:
> In the commit mentioned in the fixes tag, everything went well except
> the fallback and the specific compatible got swapped and the 8998 DTSI
> began failing the dtbs check. Fix it.
> 
> Fixes: 7d1780d023ca ("dt-bindings: PCI: qcom: Unify MSM8996 and MSM8998 clock order")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

I don't see compatibles being touched at all in this commit. This is not
correct commit to fix.

Best regards,
Krzysztof

