Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C24661940
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbjAHUXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjAHUXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:23:41 -0500
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDA6F599;
        Sun,  8 Jan 2023 12:23:40 -0800 (PST)
Received: by mail-il1-f175.google.com with SMTP id y2so3960246ily.5;
        Sun, 08 Jan 2023 12:23:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/RUYZ6zFkymzHQkSJ67aW6tJEdK11q0qpSv8WytCTvE=;
        b=1+DIm0EDZ7953/t/OClFj1NTixlaqp7OyS4EMfFYAFazfSNvahsuO6hBF7C5zZIP/V
         RDiQvi/0e8KT1xG0WAx5fRfTHxhJQ1+fqcHQ3sbbNknTHLBjS6zCpi5bfzfI60tkUEVg
         lhoaWxYVv7XLvVL+my5xdJSG+3r75k0bq2W79BgwWMoc+EqA6EfQQiKFlplvsPUomV1I
         tSKFG+KFID5VP5h5HTHxPua+hBSmL3/55n0q+8N6BsvF12fnqkTk3IiRr/vVJbbkqsFS
         y8L6Ocif/PPPbAMpj46a1RkEJtgemB24dhlzJBZXcnJJAtgZVNVfXARSBFw4BxxnULyu
         ruFw==
X-Gm-Message-State: AFqh2kr8UN8mAdxgA+bIO6NCL/Y2lRiwNgxk2WO3QC3GdWvHYyTg+FFq
        ySEgepcZLBHuv7pWHJc/tQ==
X-Google-Smtp-Source: AMrXdXsDj5T9y4ilX42yDZ+W2rfpkG4YmtliGaBA5E5UOPjsdh2yQ433Lfn0/CFTQnMUY18w2rW4Pg==
X-Received: by 2002:a92:dc8d:0:b0:30c:4c54:87f4 with SMTP id c13-20020a92dc8d000000b0030c4c5487f4mr16995592iln.3.1673209420129;
        Sun, 08 Jan 2023 12:23:40 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id t9-20020a92cc49000000b0030bb7c67efcsm2198954ilq.16.2023.01.08.12.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 12:23:39 -0800 (PST)
Received: (nullmailer pid 229453 invoked by uid 1000);
        Sun, 08 Jan 2023 20:23:30 -0000
Date:   Sun, 8 Jan 2023 14:23:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bernhard =?iso-8859-1?Q?Rosenkr=E4nzer?= <bero@baylibre.com>
Cc:     linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-mediatek@lists.infradead.org, sean.wang@mediatek.com,
        chunfeng.yun@mediatek.com, zhiyong.tao@mediatek.com,
        linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        lee@kernel.org, gregkh@linuxfoundation.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        angelogioacchino.delregno@collabora.com, maz@kernel.org,
        linux-kernel@vger.kernel.org, nfraprado@collabora.com,
        matthias.bgg@gmail.com, allen-kh.cheng@mediatek.com,
        robh+dt@kernel.org
Subject: Re: [PATCH v7 4/7] dt-bindings: pinctrl: add bindings for Mediatek
 MT8365 SoC
Message-ID: <167320940963.229372.8143524067884633693.robh@kernel.org>
References: <20230101220149.3035048-1-bero@baylibre.com>
 <20230101220149.3035048-5-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230101220149.3035048-5-bero@baylibre.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 01 Jan 2023 23:01:46 +0100, Bernhard Rosenkränzer wrote:
> Add devicetree bindings for Mediatek MT8365 pinctrl driver.
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> ---
>  .../pinctrl/mediatek,mt8365-pinctrl.yaml      | 197 ++++++++++++++++++
>  1 file changed, 197 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
