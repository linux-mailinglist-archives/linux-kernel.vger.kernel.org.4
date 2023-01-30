Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37C4681F63
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjA3XJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjA3XJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:09:31 -0500
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F16126CD;
        Mon, 30 Jan 2023 15:09:28 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id u199so6041115vkb.12;
        Mon, 30 Jan 2023 15:09:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOZ/a/SQfzaB8OpqfQljcm6jzA6bCXlv0etoBEMgm64=;
        b=CF8ugefu/7JmYbya8UO1VmFQutkd3NTrLe9AI3aZok8O7lzRtVm6+DEKc4DrpAt4Yr
         hYpi2hq/7n9z5H42ugLAiN8YO3F9unib4cgXLx5HkZGSZVsDAQXs5/vDIkfULyR/Z2Cd
         ZTQfn4bvsljK2Se1ZjVCUntF5rGJSxbbM6FixS2aLOA42OxCKXMrHVlvtp1uBCRtf3fI
         qqQHwvvs9xXaROVh33jUtYtjoGK14Rs2lMmHOI+AObPvt/RFUr6Hn/lSWMyBfXAoE3wl
         6VcgsSR34HHIl5uYmLv10rzxQQ6joeLyRe3oBgiHa4q7K4sC+hsS8HCTVIhPDt2y+L3s
         bIaQ==
X-Gm-Message-State: AO0yUKWPoiHnKZo5dnlHvn2HEUSYBY02MnU86w0v2OeLrkZMHWv0xo0R
        j7bNBVpP3hpBz1IiTP0OxtANSai7PA==
X-Google-Smtp-Source: AK7set/85L3+MkE/aCToHwES4+6UO7kpE68qnzNps8sebYJyR98m5xeDo8E2Pa63mmMStJo1ofAUuw==
X-Received: by 2002:a9d:6a8:0:b0:68b:cbe3:ad57 with SMTP id 37-20020a9d06a8000000b0068bcbe3ad57mr3436404otx.1.1675119613013;
        Mon, 30 Jan 2023 15:00:13 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x10-20020a05683000ca00b0068bd6cf405dsm1078503oto.1.2023.01.30.15.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:00:12 -0800 (PST)
Received: (nullmailer pid 3684096 invoked by uid 1000);
        Mon, 30 Jan 2023 23:00:11 -0000
Date:   Mon, 30 Jan 2023 17:00:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manuel Traut <manuel.traut@mt.com>
Cc:     devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v9 1/4] dt-bindings: input: pwm-beeper: Convert txt
 bindings to yaml
Message-ID: <167511961144.3684036.7470666558018354603.robh@kernel.org>
References: <20230130135650.1407156-1-manuel.traut@mt.com>
 <20230130135650.1407156-2-manuel.traut@mt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130135650.1407156-2-manuel.traut@mt.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Jan 2023 14:56:47 +0100, Manuel Traut wrote:
> Converts txt binding to new YAML format.
> 
> Signed-off-by: Manuel Traut <manuel.traut@mt.com>
> ---
>  .../devicetree/bindings/input/pwm-beeper.txt  | 24 ------------
>  .../devicetree/bindings/input/pwm-beeper.yaml | 39 +++++++++++++++++++
>  2 files changed, 39 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.txt
>  create mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
