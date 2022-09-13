Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4ADC5B6BE1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiIMKqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiIMKpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:45:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473A24330B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:45:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t14so20102802wrx.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=y+BBxnKoWouAVhBZw8lJ2J6Kb99WrytidhJJguewIJ0=;
        b=vcbcnOeM77RS/TlFUyx9du/9bqkZlxdb9lj9LYxyye8qvkT0L/zkVtzQodzWVvJK/N
         B1POyYN5lM/1tH7IGhzNWLv9vGcqi6noaZ83MwKSoGnLB+hMG+JGvdP9JscWI1VbzHwL
         nkk5ASmMwdLbnp6FPs2YPER7btwQ2qc5XGnlqTKKKsgsg/JbfHusIFDp48fIWX5crX6V
         3vV8f/52JtUmqYyajAgn22zMUQBsDfN9iRHX7uNbipi3jnPb3out+BE5rwQjPvMEZlH7
         ie+Tlzp+MNCkVUo3P3UwA+BdZlMbpgr27ciRA+0ElbZtUa7GrUJDbAA6yuzR94p19GIL
         SdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=y+BBxnKoWouAVhBZw8lJ2J6Kb99WrytidhJJguewIJ0=;
        b=xIb0S5IQtC/7R/bTiDvL/solWbjA/QntiW9MGsDXL2oo4NXytXjSSCyO+ZUnp2WM50
         NryNDWqNev1tiZcW9WoLLnqKiSzm6Gc5afV1K5j65IqE2kgnMbY1zwlgcINDxhHzO3KO
         pfUTiHQBDhdKU3XionZJEvVMdnou3LWySaox276sl3Fs9gibNPx9tttamqL7ZsiFpMcL
         4r3C223hJCi1TzrkQfsWQCIhO5pO1jnVNoVWox7GUWoZj4qfU3/1sMm47wLSERG8F5UB
         42s87MYeYZV7ovQDHdTDAKGVlm9tlAQdqaTTR7IHZ2fPtvdozcfdVUVJn1dDDWxcPp/h
         H2lw==
X-Gm-Message-State: ACgBeo2i3kK54i8QxoFjgYVgOQevcvjALTYpVuyEdKsO+jt2eKzuhD7P
        eOY46rzgU4vhA0lGyXPuRLQNPA==
X-Google-Smtp-Source: AA6agR6GBqm41tfpUFo8c7vfgFrizDHLp2shQbi8UtlYJqZOFyBauxdYzQ+IiT+4oteAjUdlRpVEtQ==
X-Received: by 2002:a05:6000:552:b0:228:6296:3b33 with SMTP id b18-20020a056000055200b0022862963b33mr19100885wrf.615.1663065950698;
        Tue, 13 Sep 2022 03:45:50 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.70])
        by smtp.gmail.com with ESMTPSA id i1-20020a05600c354100b003b497138093sm2149014wmq.47.2022.09.13.03.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 03:45:50 -0700 (PDT)
Message-ID: <f35e2803-03d8-86ae-8049-074b3896f6d4@linaro.org>
Date:   Tue, 13 Sep 2022 12:45:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V3 1/2] dt-bindings: clock: imx8m/imx93: introduce
 fsl,always-on-clocks property
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "abel.vesa@linaro.org" <abel.vesa@linaro.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20220913092136.1706263-1-peng.fan@oss.nxp.com>
 <20220913092136.1706263-2-peng.fan@oss.nxp.com>
 <DU0PR04MB94170E9F1324C345A66C750688479@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU0PR04MB94170E9F1324C345A66C750688479@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2022 11:29, Peng Fan wrote:
> Missed to cc: devicetree@vger.kernel.org

This does not work.

Please resend.

Best regards,
Krzysztof
