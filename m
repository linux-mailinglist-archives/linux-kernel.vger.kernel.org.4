Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0204612BC2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 18:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJ3RRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 13:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3RRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 13:17:41 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECA5B1E8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 10:17:38 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id r3so11419919yba.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OQ7uJLBIhN6i85bshrC6bijT/YDWeXqFsg9Tc3UQLxY=;
        b=ACnpJ5mK07YWG7SrKB+AOsI1oo2Cp/w8OGk3mQBSzEp43U510vT9y1sDXj7kgfoR/k
         Lb4MTUfVAQEaNtlB9DUy/FlxCwzU6uoisLyvszi9/IZTu74T4T1pjpBLCKJ35QkIFf5r
         wROu3WZep4MOF23gRdXFUpcjC3JtSfFACYh6cGlCINAetusBTnY4S3JQ+e9IlaQJBuvE
         CFdYmyc3ue62bk8OO7fd8VH1MnAXnT1VDOQ0yjlkHJrjSiLIw5vCRtwsBo37nVqYlKjt
         PrbVOpy+7ZIgT6iedcx2c+Sc+x5eTA+0Fb5hLARVqt/vGk0aoTLeHXbKZEvc8TNQh/6i
         nIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQ7uJLBIhN6i85bshrC6bijT/YDWeXqFsg9Tc3UQLxY=;
        b=MkJm73teYFVHS5gmbWyWlkrYivRs5xZepQ6lF/6GUtMDQhMcY0E93Vq9x3b9Fsj0gs
         3yItpk4ED1xOMr599SD62U9gXdI7sQNhUEGzuOOtXo1j4lQ0pSiKcDNcoto64bH6ppiX
         nY7hrmXqVAXM5yXNRVzCCpPIIZGAW8A6uEK9SDOvn6EkSdGa/WLUfuPBz+SgzYoRIUha
         m5e27WduX04Ii19GzRVoXTkvKMTmOHwKJJ+9wCvAAtbq8tPEKT8dwo7cmXYC7cS8hq5x
         TS5/fPpmtBleJP6pLTYyYbAsNLgSyMoDE1Mnk96TbFM1MtTHfsTq2WlejtzTRxUKGcLC
         OCkA==
X-Gm-Message-State: ACrzQf2JzPrAWucTSME4ejPMGpy+GKF3YxZc6xh3yVbYCnxS+OnBs1jB
        PlAw7rrO68dj8u3Cn2XGSSKq00Q3g+1tnhrjv/gEgA==
X-Google-Smtp-Source: AMsMyM42BGs2fhx99u/w9idGVeX58S0wuZSo8XELt8XRKWvIHOSt9iOpY08Tsg+YGY4VPcICFow8CroCW2E0+u21gME=
X-Received: by 2002:a5b:241:0:b0:6b0:90e:1d4d with SMTP id g1-20020a5b0241000000b006b0090e1d4dmr8985854ybp.648.1667150257212;
 Sun, 30 Oct 2022 10:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221030085358.1619285-1-ajye_huang@compal.corp-partner.google.com>
 <20221030085358.1619285-2-ajye_huang@compal.corp-partner.google.com> <166713668618.965877.11108951663566363754.robh@kernel.org>
In-Reply-To: <166713668618.965877.11108951663566363754.robh@kernel.org>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Mon, 31 Oct 2022 01:17:26 +0800
Message-ID: <CALprXBYwi9SpgOSN9kx6JqyY9tnc0jWbZqWv-iJ6Sq079rSTnA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ASoC: mediatek: dt-bindings: modify machine
 bindings for two MICs case
To:     Rob Herring <robh@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        "chunxu . li" <chunxu.li@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob Herring

On Sun, Oct 30, 2022 at 9:50 PM Rob Herring <robh@kernel.org> wrote:

> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.example.dts:29.35-36 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.example.dtb] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1492: dt_binding_check] Error 2

Thank you for your review, and I will send the fixed patch again  thanks
