Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD00680DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbjA3Me4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbjA3Mey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:34:54 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62E5135;
        Mon, 30 Jan 2023 04:34:53 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id k4so25788032eje.1;
        Mon, 30 Jan 2023 04:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZPYmwHfLn3+zPuA4jB9uhcMgYXmS2S43QBTKHYDEVY=;
        b=hgx9vAeJcB+19sb12HidMj6YiApnBqjt98wZprsw32KVnt43olR0xWwvk/EFS6Zv/v
         8jEGiCVSxCLtQ9c/GOteT0Ie2mC6EYC+sHHaviyygic5bxUqo26P2ogwI6I4nX1aCZcO
         /tv2UNaMI5f4P9Qu9dpNDNeINkkaHCGyfm5Q7//MMf5HsV6vJjODqlGuRiwfNIX03mhm
         p0QCUiwY1TBe5JZMvkBebI9choXB77FwfwINEdPuBOQQMemWBkoD49x1KI/FYX0fIrTY
         5NpLhReZhHcvpNCUOoABC1dNgsiXkhlfSZubG+berF8zNAfSSGPAR6UAD8P3gLj/5sDd
         bOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AZPYmwHfLn3+zPuA4jB9uhcMgYXmS2S43QBTKHYDEVY=;
        b=mvDW1F5zh5wWBVHEGsrbDHbKq4tCjonSbkcQ+ELobYp+iH/qyjmVmQaPmbkxmkei4H
         wZwymO/ZXNrOJCpWJaeJJcqJePRbqvgjr0pSLPEPecZFfcBBH5XOEasy31tBnlcxzySO
         PrW5LSdcCzhPdsve17RTX4Ho4SxnbPNCDVDRQQ8r2sfaBDCO0obMsBo+wbR3qlbhl6Hr
         aehi8jrPbke21CjN4yrIpgrbDpUQgD4W6QBDuqFyYKKulzqD0eee9MfTrqGnjWkT6pGr
         95k1Y44xSTskFJfLrW0QmggpMxW5qlCLFMANYDVytjh810dSytAjSGnD3D2iZVD7jo2v
         oAuw==
X-Gm-Message-State: AFqh2krhaazZiESMnj8oz9xFtzZAHy5pnDw3dNAY7uPFOSZppwB/qK/1
        sRwr3E/ADyiKFMBSB1fqsrc=
X-Google-Smtp-Source: AMrXdXubbbc3ANrtFDzp7mHIhFuDED7OefphcSdHx1tpmZav9D/0ndJCdGP34Ptrn/5rjhZgbmH3MQ==
X-Received: by 2002:a17:907:7da0:b0:871:89ac:decb with SMTP id oz32-20020a1709077da000b0087189acdecbmr68130945ejc.76.1675082092189;
        Mon, 30 Jan 2023 04:34:52 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id gv21-20020a170906f11500b0086dd8f20a6asm6830581ejb.77.2023.01.30.04.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 04:34:51 -0800 (PST)
Message-ID: <4c1173f3-18e9-e46d-c50e-1febb90b426c@gmail.com>
Date:   Mon, 30 Jan 2023 13:34:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH V3 1/6] nvmem: core: add nvmem_dev_size() helper
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u-boot@lists.denx.de,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230127125709.32191-1-zajec5@gmail.com>
 <20230130115654.0041716d@xps-13>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20230130115654.0041716d@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.01.2023 11:56, Miquel Raynal wrote:
> Hi Rafał,
> 
> zajec5@gmail.com wrote on Fri, 27 Jan 2023 13:57:04 +0100:
> 
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> This is required by layouts that need to read whole NVMEM space. It
>> applies to NVMEM devices without hardcoded layout (like U-Boot
>> environment data block).
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>> V2: Drop "const" from "const size_t"
> 
> It would be good if you could always add a cover-letter, just so that
> we can reply to the whole series. In my case I wanted to add a global
> 
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> Because I gave this series a quick review and it looks good to me.

Good point, I'll keep that in mind and do that in future for all bigger
series.
Thank you.
