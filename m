Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FC86910F0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjBITG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjBITGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:06:24 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF76F6A305;
        Thu,  9 Feb 2023 11:05:56 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id x15-20020a4ab90f000000b004e64a0a967fso311621ooo.2;
        Thu, 09 Feb 2023 11:05:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urg+eaKblq3L8ne5lHKwBHgDVzOQbYqpVZVsI1JK9JU=;
        b=25GIWdsLWnfzps01tq32rEAsY1tMWmH97ACgJ9CsHG9F1apAnDFkAeZAqlXlY33Zx9
         C2HEbz40H7n1r+RNBWY3Cip0Tv9KrOBwnbB5RzORoGEw0RGqu1winFWaQ4EXP10MiwNb
         8YswXDro0BrYDtI5ReLad+32CGQrxpCrn+0trIT+mklnSqPV0ooLEHjox8SDVDfAC5IK
         zO0AytAColqlVprbyRzAkKJxyOIe+vWyPxxQv7NYhz1QHSsnhAh1nofAkTrI6uUZkkkm
         bpfghi9LRNQCj7TGpRsVGS646ucc4X7//XPu1j09fXRgSRq9LNGUd7PgG91HHsOkOjEr
         lAvg==
X-Gm-Message-State: AO0yUKVBsoJy6aYPeD1EbmiPjtqgHhIkrqQhJGhxqVBjGkoPyN5smwUJ
        mnY5eJY2lf/wkqrbZ+OODw==
X-Google-Smtp-Source: AK7set+X2fhODBsNXBrX5cbrghiX/x1jE483HtaRu+qBarbWD/hb6POuqdG0rL7h/UlsrX/sPKTFNQ==
X-Received: by 2002:a4a:e385:0:b0:519:b605:9d78 with SMTP id l5-20020a4ae385000000b00519b6059d78mr5794383oov.7.1675969556165;
        Thu, 09 Feb 2023 11:05:56 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w17-20020a9d6751000000b0067781a9292asm1089490otm.2.2023.02.09.11.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 11:05:55 -0800 (PST)
Received: (nullmailer pid 645960 invoked by uid 1000);
        Thu, 09 Feb 2023 19:05:55 -0000
Date:   Thu, 9 Feb 2023 13:05:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 03/12] dt-bindings: remoteproc: mediatek: Support
 MT8195 dual-core SCP
Message-ID: <167596955460.645898.16236583347331840174.robh@kernel.org>
References: <20230209074021.13936-1-tinghan.shen@mediatek.com>
 <20230209074021.13936-4-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209074021.13936-4-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 09 Feb 2023 15:40:12 +0800, Tinghan Shen wrote:
> Extend the SCP binding to describe the MT8195 dual-core SCP.
> 
> Under different applications, the MT8195 SCP can be used as single-core
> or dual-core. This change keeps the single-core definition and
> adds new definitions for dual-core use case.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../bindings/remoteproc/mtk,scp.yaml          | 145 +++++++++++++++++-
>  1 file changed, 141 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

