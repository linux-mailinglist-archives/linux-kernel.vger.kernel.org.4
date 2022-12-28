Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C29657688
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 13:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiL1Mhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 07:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbiL1MhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 07:37:18 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F1710FF7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 04:37:16 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 1so23443690lfz.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 04:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=szUYv0uneyN7YHYxEv+1bpNF1FTM8iygqyO0FKMlC7o=;
        b=WOVDjahbgzvlWA+I1nfhLWRgkZ9OLauPupQIX9iHFBEbdG8UN1RK9cBk1C1lyT3fTt
         M8sP2kN+ZfEc0G/6RdgTqJ8VY/1ISqEaKr6aGlvBLyAp1z+6nm656TsD+NlwlHqAqUup
         6K1j9LRupJG4y9A3X8omkxFf7AoNQ2HTj5Jq/V8I9J0C+nIOWRdneTA+I4UZ/UiAHjAi
         ahjoVbi51mljf696KPwr8etfQCOeRJYRFbfXjkDtECh+NQiS182weSxvczkUsV01bKTf
         9FbvEHLrlGbTsDPaiqZBZsi68TiUfCAbJejheVLEvaTvdgfLnLO/DxzpGHofAqiqCkej
         I4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=szUYv0uneyN7YHYxEv+1bpNF1FTM8iygqyO0FKMlC7o=;
        b=fGgfcUaiuIEDjNaLsHV4jqZKWTyxINylYRjjgfzh393qUmPKuI3JpoJBK/I3pzHgOj
         5PInQeNWhziuk0ThDFbFfmGDjv/O5DmIZpnpyPmf28eOQNWR2kaB0Y0KZj4x3biRUgRL
         7E/FzsNkxSnMJZ8M710m7wf3FczWJ3V5vYb5D9xf+6wKMvj6MZFNPYbm9EXu1Db6uWKX
         3ZQfB7DzGArt5S8UpxvJxqZK/v1+oXr5dq/my/1LD+LdffSqqC0o5d1ejBvsDI+XakoQ
         2yCtuIZfgGdJP+KvcikUGB0yKaslm+VxMFFSZGCFFDnvBgqzkmQzHiIh+jOSGW5BYWTw
         sg7w==
X-Gm-Message-State: AFqh2kojCgT1HQRJKDc0qv2ptbj2oTJvQUIs/Ahx3w0vEtUDY3MszD6n
        J1vsP6Kf4Ra0hEGqhp7ixhoHlQ==
X-Google-Smtp-Source: AMrXdXvZp7CP84l0lYhtw+B8zuMLZIv9fPypPu/nFTNLtiVo6H2Eh797Bsi99jc32fqou298yyIzXg==
X-Received: by 2002:a05:6512:228a:b0:4b5:7f79:f8bd with SMTP id f10-20020a056512228a00b004b57f79f8bdmr9812553lfu.22.1672231034559;
        Wed, 28 Dec 2022 04:37:14 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q21-20020a19a415000000b004a46f92a15bsm2661813lfc.41.2022.12.28.04.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 04:37:13 -0800 (PST)
Message-ID: <cae5273e-aac5-0c4c-6686-fb2cbc5379e3@linaro.org>
Date:   Wed, 28 Dec 2022 13:37:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] ASoC: mediatek: mt8186: support rt5682s_max98360
Content-Language: en-US
To:     tongjian <tongjian@huaqin.corp-partner.google.com>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        perex@perex.cz, tiwai@suse.com,
        angelogioacchino.delregno@collabora.com, nfraprado@collabora.com,
        jiaxin.yu@mediatek.com, chunxu.li@mediatek.com,
        ajye_huang@compal.corp-partner.google.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221228122230.3818533-1-tongjian@huaqin.corp-partner.google.com>
 <20221228122230.3818533-2-tongjian@huaqin.corp-partner.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221228122230.3818533-2-tongjian@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/12/2022 13:22, tongjian wrote:
> Add support for using the rt5682s codec together with max98360a on
> MT8186-MT6366-RT1019-RT5682S machines.
> 
> Signed-off-by: tongjian <tongjian@huaqin.corp-partner.google.com>

The author and SoB should be full name. Is this correct (full)
transliteration of your name?


Best regards,
Krzysztof

