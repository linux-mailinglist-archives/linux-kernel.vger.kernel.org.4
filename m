Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EE961A731
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 04:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiKEDGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 23:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiKEDGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 23:06:18 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C365E23BCF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 20:06:16 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id o70so7813390yba.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 20:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nGToQRK0DXw7c1IROX4VhPmgoLvBloa1KH2z+OM+UGg=;
        b=CPY+9w/NotyoR2K8mPiZ618PyK22YxCp0SaqY76wYG7svkV22RWzh39pDuI6fnl3FJ
         lFRykuJZDpWiXOOBqTppN7aoJJbtQ0+rE/DWuw+XX0c/dSRay1rp1Ey05/E+WCvZ/Bjg
         igMiRkow60smusWFCyrq66Y2D4f5KUT3uuNRQh+Aw2jKJq1PHnxOyspGtuCpec4Q5C/c
         gx4CNCDSi+NFSNArebSYNtz3DJ7NtHf1Gs46UJtqtk9hgYD0LTl6PCAgyN5xli1snCgU
         op2YDQQyZ7vxi33xnLvxzgSVd/Xb/ncJY0CKciD/67fDX5RceabOytbAHDRo1ymjHMuW
         qmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nGToQRK0DXw7c1IROX4VhPmgoLvBloa1KH2z+OM+UGg=;
        b=hMu/7IV6b8369/K5/yhmXtwTlZJqMFA0xAgwio+eaw6FMWDCJNC64R2v2IFzjS9bAL
         +qdMfT1fxIhYAJEo9C9kCB3p7Y3Gc0OMi6FhiA6HryrRpiYZoagRdx/iu/PZnS+t+mjc
         xej1rFLjt6W1Ek47O1bdUYL1S3RG5hfi7XQZerdXWo5tIpRfjyiCpSjbG0HSHCuq0kNU
         f+Y7tYO5Fper5Ztjk15K17OKBTtdJ+5XPfY+3dUg9TyRUUlcbGogJq8OvnAIPJGNmKic
         qyUnnUDUbH3jWX8pUADQVWQKNHK39O0ZBah9su7i0i7E2vFh5J+EDrrbp/GqcT52gcI1
         hegQ==
X-Gm-Message-State: ACrzQf2U5AhYBQKRjMg2y9e/kP7swcptdzf1mWF8lbTYkmYKQjXs01hY
        ynxXBTjkhSqZFJT43RYTPJeBi7QTQzoYlgWYDXfh0A==
X-Google-Smtp-Source: AMsMyM5mjEha55s4t7TntUfGRbOeZ7n0QwDmEGTRga0tyK+7SOuQhQiic2xIjVB8WFzL1IEvui/sDKGlN11imSJp0FY=
X-Received: by 2002:a25:bc3:0:b0:6ca:6427:f00d with SMTP id
 186-20020a250bc3000000b006ca6427f00dmr34962639ybl.62.1667617575953; Fri, 04
 Nov 2022 20:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221102125936.2176748-1-ajye_huang@compal.corp-partner.google.com>
 <20221102125936.2176748-2-ajye_huang@compal.corp-partner.google.com> <166759787920.2873722.6503685794432759025.robh@kernel.org>
In-Reply-To: <166759787920.2873722.6503685794432759025.robh@kernel.org>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Sat, 5 Nov 2022 11:06:04 +0800
Message-ID: <CALprXBbu1EFNMG2VwHd+k6kVkQXFLjKx1ojNPyKWJA-QPpyPaw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] ASoC: mediatek: dt-bindings: modify machine
 bindings for two MICs case
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "chunxu . li" <chunxu.li@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Sat, Nov 5, 2022 at 5:39 AM Rob Herring <robh@kernel.org> wrote:
>

> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.
>

I Got it.  Thanks.
