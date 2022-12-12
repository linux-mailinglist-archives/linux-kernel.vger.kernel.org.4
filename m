Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0057649796
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 02:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiLLBGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 20:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLLBGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 20:06:15 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3360BF70;
        Sun, 11 Dec 2022 17:06:13 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1442977d77dso6726994fac.6;
        Sun, 11 Dec 2022 17:06:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vUpFTZBMKKlxn2nEmImzz/3st4eQplEl/+QPXcu+kE=;
        b=oPzydKHDMjWQpxXpnK/LG6EJfaDh/CaB5ZXbiriu/I6vIXPm8/5pt8GqdZ09rNj81W
         6cVtqAG5DGW6Cfm3gtu+f6tl+lB+FNaofD+ftfwzFyr40J8FlvdRKlqCMyiZ5MnLDLoZ
         FoBB4+eQRn9CYvpyf6n58/9TXFnAdJBXHuls+19qVVCpqLoNzZFzy67dardirFCalezR
         cm1mnwDijRrpUwoVbgt1JTja7WrMAibmBLl9ylCJ/46bBLAh+nSD/XefUxY58RiPSf1i
         Xwvlgo9FjFFDiBMxRuLw1X4Wjvtg/Fs5VW9I87PaON7qUUlv0BkpgSBjwZDtMOtmHqhx
         rBnQ==
X-Gm-Message-State: ANoB5plmKpiH/T4dH1rnSw8y4pHiQ7W1BzcxshP4sM3XsB5lY6Zp0T5y
        unZJdVz6XDQhWKTf+8IzxyUi/ClhZw==
X-Google-Smtp-Source: AA0mqf40N78mo/x1fsa2MnvoJoT/Vzze8wwWPprpDUU4FLp0E6I4QJis/E4K3TL9zLwYvlmLCi6Cog==
X-Received: by 2002:a05:6870:cc87:b0:144:ab2f:5d36 with SMTP id ot7-20020a056870cc8700b00144ab2f5d36mr6393579oab.13.1670807172919;
        Sun, 11 Dec 2022 17:06:12 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v19-20020a056870b51300b00143c7a9bdb0sm4277041oap.27.2022.12.11.17.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 17:06:12 -0800 (PST)
Received: (nullmailer pid 4116432 invoked by uid 1000);
        Mon, 12 Dec 2022 01:06:11 -0000
Date:   Sun, 11 Dec 2022 19:06:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Yi Xin <Yixin.zhu@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        Mallikarjuna reddy <mallikarjunax.reddy@intel.com>
Subject: Re: [PATCH 1/2] dt-bindings: leds: intel,lgm: Add missing
 'led-gpios' property
Message-ID: <167080716921.4116336.13808624836163787569.robh@kernel.org>
References: <20221207204327.2810001-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207204327.2810001-1-robh@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 07 Dec 2022 14:43:26 -0600, Rob Herring wrote:
> The example has 'led-gpio' properties, but that's not documented. As the
> 'gpio' form is deprecated, add 'led-gpios' to the schema and update the
> example.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/leds/leds-lgm.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Applied, thanks!
