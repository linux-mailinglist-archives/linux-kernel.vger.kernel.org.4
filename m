Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D3A6EE753
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbjDYSGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbjDYSGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:06:04 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB83F1720;
        Tue, 25 Apr 2023 11:06:03 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-38e5c33305cso4332998b6e.3;
        Tue, 25 Apr 2023 11:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682445963; x=1685037963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X376wL3T8sy/ZF3e8JDdjXowqGN/pb6h2TwQ05Gxs1U=;
        b=juin3QSPussTE6xyvu5i7yOz0cbqvSQzoOi17NYKyM1F9+DIqP9+bufT1v02snbnPW
         0z0QQcP2UUXVu1iCJl3uMbZHRsjcFod1nP+PQJDoTpXTatgoNBfOg+LJV3nTcLuZg7G8
         t1bhQRneIg6bEWua+4s1hTzncC3G+WuN4aHxzSlC21Oj0NHk3OrlDdMu6UPRlJj0HCOT
         5bJQOS+F207aL5tqM4GEcmbUL7xp6kuQbfXETR8+FOE/HoPm5BxZ3XeVM+WtqCwnmaQ8
         aIG/zennnI/F0DDLR9ftrnH8ke3ss9CAKWW3V/DLpRp5huoY2GpTwPXtxRk01mKNbuLZ
         SSnw==
X-Gm-Message-State: AAQBX9cbpsJaYkfhAkee8epIBax0se4aD8teGn37H9hF/XSQfdJ/Ac9k
        KO6/46sNX6FsS0OUYhg4QQ==
X-Google-Smtp-Source: AKy350ZnwmyDkZuMRppHglz4M32pu2rq/AGDWRh6cTIJ06tg15gqMgSWbRzzsxN4kZf8EtIbVksCgQ==
X-Received: by 2002:a05:6808:2389:b0:38e:2993:be7f with SMTP id bp9-20020a056808238900b0038e2993be7fmr11625977oib.38.1682445962905;
        Tue, 25 Apr 2023 11:06:02 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b24-20020a056808011800b0038c0cf168afsm5852298oie.7.2023.04.25.11.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:06:02 -0700 (PDT)
Received: (nullmailer pid 2025900 invoked by uid 1000);
        Tue, 25 Apr 2023 18:06:01 -0000
Date:   Tue, 25 Apr 2023 13:06:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     Lala Lin <lala.lin@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Cameron <jic23@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, "Hui.Liu" <hui.liu@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-mediatek@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1 1/7] dt-bindings: nvmem: mediatek: efuse: add support
 for mt7986
Message-ID: <168244596061.2025844.2232344223319000455.robh@kernel.org>
References: <20230421132047.42166-1-linux@fw-web.de>
 <20230421132047.42166-2-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421132047.42166-2-linux@fw-web.de>
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


On Fri, 21 Apr 2023 15:20:41 +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add compatible string for mt7986 SoC.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

