Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1B566008D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 13:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjAFMv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 07:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjAFMv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:51:56 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAE466981
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 04:51:54 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so3476911wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 04:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTsgZ28jw0QdfrpJIONpqgGy2v8hslyq6OA+g4F+h4g=;
        b=QKz4eUtWJGIN6xx+hgENT3rYclWDWorckUkLY2b6epk5NAQyzG/2rigaT0TizpLUFE
         ALfsOB35gYpVVqt8Cgv+z3AwMavRkDwXbC+d4dZX1C1HRDGNX6r7dVmJ/qKgxXV95Iac
         nMSElVESL61gXwbisyFgmoMVcEB2mPNhbI+b5xq9MqtbexFZx8cHvT2xQKsgfikuiM9f
         n7f+g/lF1f1IhWUw5u0lK9k49scLWs/vjIVbnP0Rx4wm5tZLQDtuapQm6jUbd9/i5Oei
         1QHcxS2O1V2xYPkOIlXuV26SsofQhFl+QD82RzOt7q4V3wnH/9H3fZNgVsn89IeQ9loW
         E8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTsgZ28jw0QdfrpJIONpqgGy2v8hslyq6OA+g4F+h4g=;
        b=jInToNjtKJ6hIls6f3aw6SpdcMWMTJNE/nZDZvsawyqaKvyqA/Ey9Fe8j6lt4GLLy2
         QzxHy9L5DgADV4IARmlJ+zzYr3CUoRi+kDa0MXjyPMlLyTuy+00zdsN8OmO0o342GUeY
         B/HJWL7vQDmTnWZPJdeALO22F+qxRgiome3Jw25VJC0vWQJFGdyTFVxOjbFwIs+8Ikf4
         zXVnkKcGNAFTCU+1EEBg2NZ8Lobi+9zMLgOqqZ9W+tF4qReUUg6MGFTcn1Pphg1xSrq8
         cgcoRLaNi9BdhfIhK01rxCfFDSCbtdJhc6hHqXfU0RAbxmx477nEjZFQFs2uAF/xIWF9
         0aag==
X-Gm-Message-State: AFqh2kp+H1xq/aJ6ifN4lnkn1JL8x86ClzmZBkZkyPMZ9yCc1/tKKcOQ
        iU19fYPqW6rNrv00CWQo0PbPfQ==
X-Google-Smtp-Source: AMrXdXt5ojTkfrGJboYK1DOEsuCMBlujKf37GSSKrlMZUfz9L62/8O1IxRWaAJjnDohiyFLrZq9ilw==
X-Received: by 2002:a7b:cd99:0:b0:3d3:5506:1bac with SMTP id y25-20020a7bcd99000000b003d355061bacmr39829602wmj.30.1673009513375;
        Fri, 06 Jan 2023 04:51:53 -0800 (PST)
Received: from [192.168.1.102] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b003d9d23ab449sm1659288wms.29.2023.01.06.04.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 04:51:52 -0800 (PST)
Message-ID: <3b4fba35-c34d-b8d5-99e7-e44456b67803@linaro.org>
Date:   Fri, 6 Jan 2023 13:51:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 10/13] ASoC: dt-bindings: mediatek,mt8188-afe: add
 audio afe document
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de
Cc:     angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230105081606.6582-1-trevor.wu@mediatek.com>
 <20230105081606.6582-11-trevor.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230105081606.6582-11-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2023 09:16, Trevor Wu wrote:
> Add mt8188 audio afe document.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>  .../bindings/sound/mediatek,mt8188-afe.yaml   | 208 ++++++++++++++++++
>  1 file changed, 208 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

