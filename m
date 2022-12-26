Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18ED8656578
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 23:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbiLZWh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 17:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiLZWgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 17:36:20 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0896238A8;
        Mon, 26 Dec 2022 14:36:09 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1442977d77dso13821548fac.6;
        Mon, 26 Dec 2022 14:36:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8uuUFV9lNVBUl4JTj97LHUM/xGa74AJRrukYSs5QNU=;
        b=Y9OKMWh+Hnls0J3Fihxe0/PAbsagKqi/JmRa41Tv/87AQHiH9X3VrNbJt3QyeGcIni
         En3IiojCv8iKHLWtetRCXtEGwWdtTJgd2nr8k8jT5pRjdEdx955tr6tLPOLxtBOGE4YG
         CPjJKED5irp8xkitiKT65zdu6sifZTpvPQfJIGVzdbuxytzLFVYgspnl1n8NxZgK13Ir
         GkzGDbCziFhcXFz+jOMNwKjUib60UtN8cJxzX14UGZykAuLyL78YRPmv7LFPdTkELkXj
         /OXuTXBgS/8oaOUYrsP8wOLVOHJJGFVQPj1VPw2/hWhRK9R6bO+VwPT6ZFIRs/zphHor
         WFZg==
X-Gm-Message-State: AFqh2kqOcjbrp/AkUyferctpyz/BfJwmcs7rs3M+jC0nBtHFnWbu0/S9
        Kret0iuddde4YIiavQfYMA==
X-Google-Smtp-Source: AMrXdXtJvskK+GjeKsygNF2zFzW3iflF8QjGcHz5bHiOqHCE/YBGgFxWhNfuduIh72HAEUsstCDEqg==
X-Received: by 2002:a05:6871:4691:b0:144:e56a:1a3a with SMTP id ni17-20020a056871469100b00144e56a1a3amr8999629oab.4.1672094168358;
        Mon, 26 Dec 2022 14:36:08 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80e8:2792:eb0e:539f:f657:547b])
        by smtp.gmail.com with ESMTPSA id s20-20020a056870e6d400b001375188dae9sm763146oak.16.2022.12.26.14.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 14:36:08 -0800 (PST)
Received: (nullmailer pid 40042 invoked by uid 1000);
        Mon, 26 Dec 2022 18:50:48 -0000
Date:   Mon, 26 Dec 2022 12:50:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abel.vesa@linaro.org, festevam@gmail.com,
        devicetree@vger.kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        abelvesa@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org
Subject: Re: [PATCH] dt-bindings: clock: imx8m-clock: correct i.MX8MQ node
 name
Message-ID: <167208064819.39973.9894207215176809086.robh@kernel.org>
References: <20221223030540.62018-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223030540.62018-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Dec 2022 11:05:40 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8MQ CCM is at address 0x30380000, so correct it.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/clock/imx8m-clock.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
