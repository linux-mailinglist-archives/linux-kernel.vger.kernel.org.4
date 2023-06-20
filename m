Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DD5736EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjFTOmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjFTOmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:42:04 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDDF1738;
        Tue, 20 Jun 2023 07:42:02 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-77797beb42dso171151239f.2;
        Tue, 20 Jun 2023 07:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687272121; x=1689864121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wn93qMspQemea9YhXaQZljSR2Ed4VY8kRFqzKyHo9fc=;
        b=SRFqb3eA9AQq94sv8Zhy+QksLAi8TVAwV8M8pw7ZZBgS9J9nIPRXfwxvrPRKoGrraZ
         qsEcMzRNr4KBEAfo1pbuGWi44iCh+np8k6TYmtd5N6gyppCycN5SZglUwqovKmJu/dCp
         jI8m96pyjxSVJfvLd7u9FGiUMUJPSLBuSCRdPVGdW747yipOet82jPQLW/HdT2g/zi6y
         IPUEFZx3atXmaL4UkasX/KNqcXDvFURG1YMxcE4RRrY5Ba9/5jAT6l2t3Ri9bo07ro23
         565C2GnOvKC8Nzzm7+vJOO81XR3xu6Qe8RB+bTIX8eKt/wYDlwBytqZsAEmnDeFCuh9H
         CH4w==
X-Gm-Message-State: AC+VfDwvR5iPd9F2MsW4OBez6P/w2CAZs9mDAWtJvOY8cEAkfsJddKRl
        Q56AY0Rf1KGq0HRB49Z7m7GXRFRODg==
X-Google-Smtp-Source: ACHHUZ6rbJILuh3J5fBffSGZ6A7UKWkr0D2mSMMgy83pJeLFSCQKsOo/gCKTQ53n9i89G+XAxemxZw==
X-Received: by 2002:a92:c10e:0:b0:33f:f183:f9c4 with SMTP id p14-20020a92c10e000000b0033ff183f9c4mr4010729ile.23.1687272121544;
        Tue, 20 Jun 2023 07:42:01 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t13-20020a056e02010d00b00341e955a541sm653188ilm.16.2023.06.20.07.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:42:00 -0700 (PDT)
Received: (nullmailer pid 3563950 invoked by uid 1000);
        Tue, 20 Jun 2023 14:41:59 -0000
Date:   Tue, 20 Jun 2023 08:41:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: spmi: mtk,spmi-mtk-pmif: drop unneeded
 quotes
Message-ID: <168727211697.3563865.3536184415967824360.robh@kernel.org>
References: <20230609140655.64529-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609140655.64529-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 09 Jun 2023 16:06:54 +0200, Krzysztof Kozlowski wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

