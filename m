Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39925EB063
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiIZSnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiIZSmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:42:04 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF83F62;
        Mon, 26 Sep 2022 11:41:16 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id cm7-20020a056830650700b006587fe87d1aso5006270otb.10;
        Mon, 26 Sep 2022 11:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=NQTujgk0bsMYEmOwwwiGoFnr2ZfITkyj1lKMg8vNYRA=;
        b=VcG4xD6xTkvN4OZo77FfqRaAf1hW6M5xF8oZM1pd1l6n2fjzN/oRN0EtajapMo2GR7
         roHrThzzsodQuNL3BidAbqeqYZEUy7ms4IptcAcePx8+jKVc4Cj41zTGYX9gOfkMU51O
         oXXYA7qEpNXpCyl7mDUiuIO5KO3G1JGnX4/9Hl6J8rxCuFVBaUnOw92uK0bz0E4AsdTa
         wGb3CVPq5JYJv5tTGXiz1EX0tOUJljHjSB2FupjtVbXW13ANob/AT+C+Lv66kr3Fb7OJ
         bZXpDM35N4+CrbPnL8t0kGzN+mBysM0cb/WW/LxbtLdFGkHW1z9YDCfBE4VOOpz2rdge
         UJyg==
X-Gm-Message-State: ACrzQf1RxINY52Uz0hmCbczQWdu4Esd0WP75WcrQJzLizl9u+8dN+yZh
        3UjNI/UmWL9w0riZ1A+iXA==
X-Google-Smtp-Source: AMsMyM7EmvpGiar0USof2quKxi3nPNn2k+LZWqyN4+LnEMnDftJdZm+WxA4p0gAltLrFbpTcT7k+nA==
X-Received: by 2002:a05:6830:442a:b0:65a:f06:68da with SMTP id q42-20020a056830442a00b0065a0f0668damr10494182otv.336.1664217675296;
        Mon, 26 Sep 2022 11:41:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cj26-20020a056830641a00b0065689e13f52sm8096577otb.71.2022.09.26.11.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:41:15 -0700 (PDT)
Received: (nullmailer pid 2550335 invoked by uid 1000);
        Mon, 26 Sep 2022 18:41:14 -0000
Date:   Mon, 26 Sep 2022 13:41:14 -0500
From:   robh@kernel.org
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        shawnguo@kernel.org, l.stach@pengutronix.de, robh+dt@kernel.org,
        s.hauer@pengutronix.de, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com,
        Peng Fan <peng.fan@nxp.com>, kernel@pengutronix.de
Subject: Re: [PATCH] dt-bindings: power: gpcv2: correct patternProperties
Message-ID: <20220926184114.GA2550274-robh@kernel.org>
References: <20220923075427.985504-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923075427.985504-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2022 15:54:27 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8MQ has pgc 'power-domain@a', so correct patternProperties
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
