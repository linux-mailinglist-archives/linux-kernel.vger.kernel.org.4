Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5243C661850
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjAHSsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjAHSsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:48:41 -0500
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA286E0FE;
        Sun,  8 Jan 2023 10:48:40 -0800 (PST)
Received: by mail-io1-f46.google.com with SMTP id 3so3484050iou.12;
        Sun, 08 Jan 2023 10:48:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7PW/o/diRa7/Am41wioDqKkxsPy6fmQIpL6zIC43hc=;
        b=vTsJHc7+RmSS+bfy9ggWLgFHBEqyDRgE3rl1Bbmsi0lRDGYARl+33e6ZicRtPyK1x1
         QBx046IBcVUlEY6YtVV6i7BzsU2yzcO4d0gScilAYmMyvi1vRuOGnYY+PJulHMZqMUIW
         DYCyF5x00DlJf+yy/p0x8/VyEh0ISwBQJsXUs41Ptrvl8l6NmeIHPNVmeqU87koc+eIL
         jjZLDmcxN0rN8C0P70vpNyMHlNYoa+n1fMGLgxe3nbYcozrnv3BSdNkNUGftKF3fUltG
         2+DxvYc3m5SKtW93T8KYvcOeYHEW2GFw/ykYrYK+2aUHefYx4qgKMC4ZM8S8uMgo8j7O
         AKwA==
X-Gm-Message-State: AFqh2kpA785GGHDBnfWo/X9a9wRTuZ+XgCqWNQA5rtmS8YyFzJFI2k4e
        MOiWCBYKUZqtodNR0edmRfmzeq692Q==
X-Google-Smtp-Source: AMrXdXuhtO+M08JC7/4QfqX/IMjxH1Y4noojp79hTVa1fRuwb/wcR+bpS6KM3MVMHeIkYcbBuHX5Bw==
X-Received: by 2002:a05:6602:394e:b0:704:44a6:663 with SMTP id bt14-20020a056602394e00b0070444a60663mr1149378iob.15.1673203720080;
        Sun, 08 Jan 2023 10:48:40 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id a17-20020a92d591000000b0030be6c79645sm2089120iln.68.2023.01.08.10.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:48:39 -0800 (PST)
Received: (nullmailer pid 196978 invoked by uid 1000);
        Sun, 08 Jan 2023 18:48:30 -0000
Date:   Sun, 8 Jan 2023 12:48:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        vkoul@kernel.org, robh+dt@kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kishon@kernel.org,
        heiko@sntech.de, linux-phy@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v1] dt-bindings: phy: rename phy-rockchip-inno-usb2.yaml
Message-ID: <167320365145.195794.14991903357914132463.robh@kernel.org>
References: <99794484-d67e-ee1f-4e76-200de20a879c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99794484-d67e-ee1f-4e76-200de20a879c@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Dec 2022 12:39:17 +0100, Johan Jonker wrote:
> Rename phy-rockchip-inno-usb2.yaml to a more common format of
> rockchip,inno-usb2phy.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Apply after:
>   dt-bindings: soc: rockchip: grf: add rockchip,rk3288-dp-phy.yaml
> ---
>  .../{phy-rockchip-inno-usb2.yaml => rockchip,inno-usb2phy.yaml} | 2 +-
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/phy/{phy-rockchip-inno-usb2.yaml => rockchip,inno-usb2phy.yaml} (98%)
> 

Acked-by: Rob Herring <robh@kernel.org>
