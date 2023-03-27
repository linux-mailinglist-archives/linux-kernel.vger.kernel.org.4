Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150A16CAB86
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjC0RI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjC0RIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:08:31 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3CC35A9;
        Mon, 27 Mar 2023 10:07:28 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so9592122pjt.5;
        Mon, 27 Mar 2023 10:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679936848;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4xly0GzQvPfILGOWv1mMDVBgOAznYSMXIGKYil5doN4=;
        b=kPECvF8v9MrjYejXS1kTs26xLMq5QuebytHoSLEu0lLafedcZeLRjO0XvDiqPNdle1
         lspbWT4KByO1YXO7YRzn//6xQ2RgqpIC2cwzF8bixBiaIF00oIRsxoBhe0zk/6gsj1ou
         Fz3d1iMe7CWqep+NZc88OZ+8SG43swPScXCnV3D4E0tcy7EsJ2wnyZGk2DQhDmdkK5B7
         TvyHN9bD0R5/3QtsEyul54sIXQgnh4F+yl31jcgrCsHzGiXls/U7PzZ44k6a9omyVeRn
         WxQwzsw868WsC5X2scMvf/kdbzIoTreQUJaWmBPVjKACN6fIDO3c40dvmwPFnraoLzfF
         dUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679936848;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4xly0GzQvPfILGOWv1mMDVBgOAznYSMXIGKYil5doN4=;
        b=phfY4H3GK+7lTnik8FOrvNmxLd8OLrmsw7/+N5xyIEE0JlakHJirsT/ODZIM8VwR+9
         18iMihnwoTkoBRPKmypKWCrXSSWNN2da1kLSmJ1clbTr3QAfiHq5Vx6M8L9uO+O4i9l8
         BLtNNB3li9zvk1a0o3ElTfc6eLvz9RCl9UCrRzOyCqmZ5YkLuALxKuX59Xzy4aSmUPqb
         BZ1KV+1Fc6lH92MgPABmmZKkzDh5zB/lCXUt9zYgtbSu/961n2Y0+HJOHxTAouc/B8Zi
         YBT+ZsTM8POGKLwpC5/+zyJSELa2n8vLAE0Vcz66JlRtzX9In3FQ1NGTmLaWuTGEoP7u
         mjkw==
X-Gm-Message-State: AAQBX9dO/QtXEYFd6+jWXTRTdEFVt5rykPqq4OCnnMdcRXEUUdyJhz/O
        03D62QtR+wJm/RDw4YB4lJk=
X-Google-Smtp-Source: AKy350b5i1zL+7Kc62BGEJOvl18jMSAOVQSlGlHcYfpt3b3Kh4/hMZv0Lolgjp0OESx8lwvFOgkRww==
X-Received: by 2002:a17:902:d492:b0:1a0:57df:861c with SMTP id c18-20020a170902d49200b001a057df861cmr20430671plg.1.1679936847754;
        Mon, 27 Mar 2023 10:07:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u23-20020a170902a61700b00192fe452e17sm4979449plq.162.2023.03.27.10.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 10:07:25 -0700 (PDT)
Message-ID: <cbb30ff5-d247-e545-23df-ff9d393ba57c@gmail.com>
Date:   Mon, 27 Mar 2023 10:07:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: rng: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230327170153.4105594-1-robh@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230327170153.4105594-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/23 10:01, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml | 4 ++--
>   Documentation/devicetree/bindings/rng/brcm,iproc-rng200.yaml | 4 ++--

Acked-by: Florian Fainelli <f.fainelli@gmail.com> #brcm,iproc-rng200
-- 
Florian

