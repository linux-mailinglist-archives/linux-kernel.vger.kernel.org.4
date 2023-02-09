Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E64691028
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjBISPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjBISPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:15:36 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3BA643F6;
        Thu,  9 Feb 2023 10:15:31 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id 70-20020a9d084c000000b0068bccf754f1so794670oty.7;
        Thu, 09 Feb 2023 10:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGKDzpQl36bGqwBBeYFJNy6u4C/uzXcd+jWKiDdMto8=;
        b=0Qz0r9x9usQq3yBfH/pgVzxPCA38fLIEphBF7YY75CgYEI6wKwYSPuIq1PAaw9hFOk
         i5w3PXm3IWc/JzBFjxdK0k3dnJNUNc29YgNenzMEiRvqfo0WAEssRXwofeL7e4VjaczD
         fDTMITb5v5P/xpTzQ/yHEz5vOLaEAEPRHoHgAGCoZ7iKb5Aoz+PMD+cevOsLTssqeoFV
         GNbt8EIKI6BQD5Cmv7O24Y8mA+VxfIYTUIMsHWWvjwyCnxodErwKtz7D0D/sCFp4ctnJ
         f0qenBR1R+UlA9p35mwq3ezHT2TeFfAAY0Gj03IdcgCs0mU2ZEyka0ZsxrC747MrOrPe
         AGkg==
X-Gm-Message-State: AO0yUKXszCRU7rDhJG/4//UBZSL+W0GmJnr+m8Am0Ol7+ujNTcHDuVJ/
        dT5Uz33NO7AB/QQuP/BDzQ==
X-Google-Smtp-Source: AK7set/vKPnpTPG7LfxGY3SZG4NkXDy5WVxyF5/HKjTtS2pCGvrXXIv4QnhMbYB01iQJ9u0d1Jyjkw==
X-Received: by 2002:a05:6830:6102:b0:68b:d679:9530 with SMTP id ca2-20020a056830610200b0068bd6799530mr9249542otb.1.1675966530910;
        Thu, 09 Feb 2023 10:15:30 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w3-20020a056830144300b0068d4292f4c0sm994977otp.35.2023.02.09.10.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 10:15:30 -0800 (PST)
Received: (nullmailer pid 588545 invoked by uid 1000);
        Thu, 09 Feb 2023 18:15:29 -0000
Date:   Thu, 9 Feb 2023 12:15:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        steven.price@arm.com, airlied@gmail.com,
        tomeu.vizoso@collabora.com, devicetree@vger.kernel.org,
        alyssa.rosenzweig@collabora.com,
        linux-mediatek@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/9] dt-bindings: gpu: mali-bifrost: Add compatible for
 MT8195 SoC
Message-ID: <167596652912.588493.7192091258835336091.robh@kernel.org>
References: <20230208103709.116896-1-angelogioacchino.delregno@collabora.com>
 <20230208103709.116896-4-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208103709.116896-4-angelogioacchino.delregno@collabora.com>
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


On Wed, 08 Feb 2023 11:37:03 +0100, AngeloGioacchino Del Regno wrote:
> The MediaTek MT8195 SoC has a Mali G57 MC5 (Valhall-JM) and has the
> same number of power domains and requirements as MT8192 in terms of
> bindings.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

