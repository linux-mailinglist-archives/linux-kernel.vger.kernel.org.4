Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1DC5ED72A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbiI1IKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbiI1IKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:10:46 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD8425EB7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:10:45 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a10so13548234ljq.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=rUICUybu6k0R4UQZStovjdZZu8+1QmB1D6rhkDrri7s=;
        b=zcU6Zt06NfSw6rtHpF/0WoRvYMzJGGOGsQ4PtB8bWas8oYS5jS1kApvxWqN4DZbRNv
         fR5rRyUGz5C2pQHyt2eWNrUzy+XWWLbStre7c9kv1tveT1nUaZJZR8FWRKETK4S5hMEA
         RCoHummTvDbLsCSMmVFR2VvkOasUGWwVc5GbAane2C69s+SLWOuGn3K/Z1R8cMEkQ5vB
         GoTrUJrk3XOEA++b7AlZhvnC5mggUa2okKs5TagDlZQ08FRxBMG5TwBGWljqKchuTcPt
         xjNXMwZE5CIJj6h3jW3ZSk6PcRWyDezypPmF2SusxXPrdavZBqjkakaw/9bAr3C0PrSC
         RpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rUICUybu6k0R4UQZStovjdZZu8+1QmB1D6rhkDrri7s=;
        b=bmdjbwC0Peu2F2OqMYbf519PJA+/SyNG55Vn3+rYxEZ0ecwyRHD0cuXzSAdVgoAGdN
         zepM7BEdHqgLSiATPgoDFJ8U9qrLe+eAvMHrivNnyDsAr2MpmpZAxWLAGHaMIIbjAuSH
         KaMCn40snUpieC9JCz/dG4TXrTMN2AZa2OkU16o7uP3VoWoGIch7mSA+hisLyqrpmuh+
         i6k8JU0wGdJjliazfrf2gd646ttcRbBJs0ejYTk/it+XDacgjMMqcKD1tNgmTvl9PLrZ
         kZUjditiwMMdlEkKt45kD/7a3jFLOZZyEkHgdbKD6f3qyNefYg3NQkWMa+YYJaW1SdS4
         1MwQ==
X-Gm-Message-State: ACrzQf1pssc7kiXA+ojh5tEuEt3ThkJcPCdqI9bcqVIfNxKfkl6/rMfr
        AW8o5TIl+lcPPTSJZV8z5qIocw==
X-Google-Smtp-Source: AMsMyM4GcksiN2jCplk/XJkNgZ4GAeUF9gbGq/34+da9ycl8TtmT37p61IniHzNnRv52dUw/ixEr/Q==
X-Received: by 2002:a2e:9c2:0:b0:26a:cbe5:21ae with SMTP id 185-20020a2e09c2000000b0026acbe521aemr11616443ljj.354.1664352643756;
        Wed, 28 Sep 2022 01:10:43 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s2-20020a05651c200200b0026c12b9b329sm370663ljo.70.2022.09.28.01.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 01:10:43 -0700 (PDT)
Message-ID: <b4b772c6-8dfe-bcba-8850-aac282f38aed@linaro.org>
Date:   Wed, 28 Sep 2022 10:10:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v5 1/6] dt-bindings: arm: mediatek: mmsys: change
 compatible for MT8195
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220927152704.12018-1-jason-jh.lin@mediatek.com>
 <20220927152704.12018-2-jason-jh.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220927152704.12018-2-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2022 17:26, Jason-JH.Lin wrote:
> For previous MediaTek SoCs, such as MT8173, there are 2 display HW
> pipelines binding to 1 mmsys with the same power domain, the same
> clock driver and the same mediatek-drm driver.
> 
> For MT8195, VDOSYS0 and VDOSYS1 are 2 display HW pipelines binding to
> 2 different power domains, different clock drivers and different
> mediatek-drm drivers.
> 
> Moreover, Hardware pipeline of VDOSYS0 has these components: COLOR,
> CCORR, AAL, GAMMA, DITHER. They are related to the PQ (Picture Quality)
> and they makes VDOSYS0 supports PQ function while they are not
> including in VDOSYS1.
> 
> Hardware pipeline of VDOSYS1 has the component ETHDR (HDR related
> component). It makes VDOSYS1 supports the HDR function while it's not
> including in VDOSYS0.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

