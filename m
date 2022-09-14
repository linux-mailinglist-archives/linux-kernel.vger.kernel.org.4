Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A915B8EAA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 20:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiINSNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 14:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiINSNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 14:13:33 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED39930F63;
        Wed, 14 Sep 2022 11:13:32 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso15206719pjd.4;
        Wed, 14 Sep 2022 11:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Z6XbQYQrL3hibLXcs9Qu2WQKlcrTEXAiBTewPjwbvI8=;
        b=ZZFFOTNzRXOnjQm+TMxLNjuV0QU8eRzrmdrOZGtS1MBevBLNUOEg6BudAEsibqF+8z
         tk0LCKUgi1WTarJREuQznibhsy7f5C/xagb3vVH5mz2duK9MhcI9nHS3gTywr5iNSVVM
         Hf7S06uUBQRioFGdS7URdA2l/7eBi1l1fY1LtPtpYiHX9fxE7ZDl7d3L5kg42rX2dRt5
         z8ULCWlONGQU4KxVWLLovHQvoPqk1x7aBXrSHgKFfHVkhjkDv5dF0lusXjQaB5WWyBn+
         eZZR/WD6XzrQN1oVov7LYUeqjZAcgiA6MlOSqIIjmOK9FyuUMZUOuev/2q8XzbMh8EaA
         PqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Z6XbQYQrL3hibLXcs9Qu2WQKlcrTEXAiBTewPjwbvI8=;
        b=eCi1iJAfpJ11IJ38AETm+eO/z5FdcAIsVUSIP1AuV7JeVaZxBZd+HgfPfFhdD0iQqi
         Iyjn/UfFpFU3OaKyxqut2S5inD0jUpl3idMUDn01rHUf1PgfTOxFzOsPhgKfgt172eN5
         rRGbR3G7JSok66dd4xYPcrtIxoAmk5uoCcq710bSZ79gKjFDCMoxeYVfepyMpcDCtVz/
         wo3CJ1mYf3mfl9UAIexw4xrP4euhmBz8GSI82AtPTTAGL+2jrz4X7h6MbBFkSK9+f7t9
         EkeaTXhOVktuJXMycgtmwwR7mBueKUqVVVzlpOzy86l5p2YxG5uDxoDSBHmI7FR2IUm3
         0YaA==
X-Gm-Message-State: ACgBeo1LZ2DAVuOiQti0GMb3p4sl85sWQd7/xayvbhTqqQPCJRHSvv9e
        ktliZmDcoVWiVZ5bypB1u+I=
X-Google-Smtp-Source: AMsMyM5fZthu4Ufl4nx1rAnN7OIJ9+p6ypeQYud2S/IB/+gY/0t6HXNQkPujoybWI4VEqBpsQ136qA==
X-Received: by 2002:a17:90a:6401:b0:200:b8ed:ca6 with SMTP id g1-20020a17090a640100b00200b8ed0ca6mr6296772pjj.0.1663179212243;
        Wed, 14 Sep 2022 11:13:32 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:2f68:fe7:a2e6:7595])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090a2b4500b00200b866d061sm9472692pjc.30.2022.09.14.11.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 11:13:31 -0700 (PDT)
Date:   Wed, 14 Sep 2022 11:13:27 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, chen.zhong@mediatek.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 0/2] MediaTek PMIC Keys - DT schema conversion
Message-ID: <YyIZx9j6HCluvRW+@google.com>
References: <20220914103021.43593-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914103021.43593-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 12:30:19PM +0200, AngeloGioacchino Del Regno wrote:
> This series converts the old mtk-pmic-keys.txt binding to DT schema,
> documents the missing support for key press/release interrupts and
> adds a compatible for the newly introduced MT6331 keys.
> 
> Changes in v2:
>  - Removed tests leftover interrupts/interrupt-names from examples
> 
> AngeloGioacchino Del Regno (2):
>   dt-bindings: input: Convert mtk-pmic-keys to DT schema
>   dt-bindings: input: mediatek,pmic-keys: Add compatible for MT6331 keys
> 
>  .../bindings/input/mediatek,pmic-keys.yaml    | 114 ++++++++++++++++++
>  .../bindings/input/mtk-pmic-keys.txt          |  46 -------
>  2 files changed, 114 insertions(+), 46 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
>  delete mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt

Applied the lot, thank you.

-- 
Dmitry
