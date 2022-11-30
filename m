Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C4263D4E3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiK3Lrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiK3Lr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:47:29 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B862FC0E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:47:28 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id be13so26546615lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rB7pzeHRqSrByuPF9pY+gAHOjNGOoHl6IRVtffSweXY=;
        b=SQfKBnc8CdblkDxXdof//gkPsqXO0d6H9KvhOcaWZj/P+QFmTq9wd91RRN2C38+x4z
         IKcSfl8qcJHb6R3Q4wOxQQ1PCWPSzks2AR4QSal5k0cAcCp7QZww9yxjFx19LVrzrR4o
         6scatwgsrKcF5VQ3A/KnzDc1ahWseUtv+8Ms54QaUWiRLhvzfLiqo66wYRCpNr/tVMt+
         QWfHz9hsqspvB3ZuzBS4PZIFhRjgfEyOGZ3eYvMlG6X3nb7Xndn2KuiWRQsK4rK3PV7f
         xGKwP6eaqZLrEtqRLdlPk3IjhGYqKYR3fW8N+fF4FKJpkc+WRaTeYvExy0/rfbXodzOE
         F5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rB7pzeHRqSrByuPF9pY+gAHOjNGOoHl6IRVtffSweXY=;
        b=po+ijeR7k6IHC7XPtbTKj9Ka1FzqMRxDPisfo717S8NxngKO7Ep7V+7RsNlb633I6J
         k6eNSMkEDEa0LwVwJT/cdZMeBxXZejn6UhuzbZBQPqnWDhkoYbpNMa9zFxNwbEqg/MpG
         hBwrTfNcw6zXa73A+lZzmnQWTBT13TAmS4pnkdAMpZQWFbYPwNSOFLnlL8taA0VC5n+F
         FwxdRtkxpwwi/Xr+nM+A7ezYT5t10WP4qzfE7+mcA3AOGuFgTuVrMgBZI598OYNXlevP
         qx/tDVgXOYqPGkOaj0fDZuJlqw5V50meMOhttpZC4jGS5ezl6gimwbumekzl/+pUKUN+
         zn9Q==
X-Gm-Message-State: ANoB5plM2mtPui2qj8V7GraY2FghqwdDSsg67qSmCokDdmhhdQGHOYu/
        7U0YQW2ieF6n8iswMeSYFEFPPA==
X-Google-Smtp-Source: AA0mqf5c3J6XXyRMdMQcw6oNGd8Cqr2ESOw/rcMuA8kc80RlsND2j8R0sqYZzKOFAmBPTO9OXvT2vg==
X-Received: by 2002:a19:6458:0:b0:4b1:d925:da5b with SMTP id b24-20020a196458000000b004b1d925da5bmr20006262lfj.149.1669808847191;
        Wed, 30 Nov 2022 03:47:27 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d25-20020a193859000000b0049602a81111sm223902lfj.107.2022.11.30.03.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 03:47:26 -0800 (PST)
Message-ID: <18a86f17-3cea-c880-0ba6-b83f3a48ce00@linaro.org>
Date:   Wed, 30 Nov 2022 12:47:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] dt-bindings: mfd: da9062: Correct file name for watchdog
Content-Language: en-US
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-kernel@vger.kernel.org
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        devicetree@vger.kernel.org
References: <20221130101426.5318-1-cniedermaier@dh-electronics.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221130101426.5318-1-cniedermaier@dh-electronics.com>
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

On 30/11/2022 11:14, Christoph Niedermaier wrote:
> Replace the watchdog file name with the name currently in use.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

