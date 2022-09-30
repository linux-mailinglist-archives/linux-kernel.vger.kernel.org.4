Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E015F0A8F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiI3Lct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiI3LcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:32:09 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0455105016
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:22:55 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id s6so6383485lfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=olwAjHoumqUjw9lGDWhVpKlTWEmE2o9jVcYAXDcHQHg=;
        b=t07aS2xSWqO60oG2FsdL262bo9zDBNQ+TIfnubA5o9yzDcPbAcyN++6N5g+mYY2rm0
         rNIrQrNC+Sng9fn+pUDoVCbPRCqXlMhu7hIduyk7O6gGTPGdkplExVPj1v1kIwJkk0tF
         nj4ZPGLh5maYOkUistyC3EGQJkVM75fd0PZuiy3ROCv2KhcTxjvA+i7FR/WjNKLB0xvq
         +LcfqBaDZyVwhG/JQTulgRlwFVggmEfy6EbaiX06ae2inObekUQp33ip7+vk3LjeDml0
         ddQMIWvjMopGYpRaRsSfhKkcUmGP0MOZ0j5X4pSzrnRZDYV1RU6Ny5FOS0Hu7atB3dfS
         9QuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=olwAjHoumqUjw9lGDWhVpKlTWEmE2o9jVcYAXDcHQHg=;
        b=zbDMtcR9+SWZN8zUzIRsrd1hkNQa3qyNFQMi6T2/fS/AVx6dRmcDLi6l4+mFZ/WyVL
         f5YrGCrC1hptVNK2bcZVkw7eHwsyuiOSylHTS5fxnLOYePjKwLoMqhEHk5T+quYXbRit
         el1H4xua624KGunSbWRzocydyqc0+sIp50OsW+0SCgMYRyz5G7+ThqMDpP4uVAAP4CLx
         q7+8s5q+e8iZo0dQ36GqeTOYE8GLRWmUUA6rWdcNZuAFJtGM1dCXHdRHw3AW+C28/xNm
         OnRre5WJgIWZAmC60WW5tWfUgWhSCHQ+w6M5jveHAdjkuvQ/l3fmdlDeb3gmrtBQMo2Q
         u/sg==
X-Gm-Message-State: ACrzQf1xNy+OBswZ1Z4T9QELob5KNd3iepdk8nNqPC6My3vfrFATtKGz
        Vr6W3bcWWSF0LEQ1gWr7yGr7Tg==
X-Google-Smtp-Source: AMsMyM7NEPzsg5WNkOctCoFuHB4s3AMcWguXCPh4rsF4DEngfxkiNjt1Zhv4EmpXJgI5GvsStN7wwA==
X-Received: by 2002:ac2:4e14:0:b0:49b:67f3:e450 with SMTP id e20-20020ac24e14000000b0049b67f3e450mr3372325lfr.591.1664536974252;
        Fri, 30 Sep 2022 04:22:54 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d7-20020ac25ec7000000b004949a8df775sm269136lfq.33.2022.09.30.04.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 04:22:53 -0700 (PDT)
Message-ID: <dba43c3d-83a6-74c2-f2a5-0d7a02154745@linaro.org>
Date:   Fri, 30 Sep 2022 13:22:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] RM: dts: stihxxx-b2120: fix polarity of reset line of
 tsin0 port
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alain Volmat <avolmat@me.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <YzXuU/60TI3tc6ii@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YzXuU/60TI3tc6ii@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 21:13, Dmitry Torokhov wrote:
> According to c8sectpfe driver code we first drive reset line low and
> then high to reset the port, therefore the reset line is supposed to
> be annotated as "active low". This will be important when we convert
> the driver to gpiod API.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Typo in subject - s/RM/ARM/

Best regards,
Krzysztof

