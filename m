Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3430C62CCB5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbiKPVf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiKPVf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:35:27 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0034F6357;
        Wed, 16 Nov 2022 13:35:26 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id t19-20020a9d7753000000b0066d77a3d474so7406128otl.10;
        Wed, 16 Nov 2022 13:35:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idXPUIxAsf+qYf9EThRcS2M6+paxv2xPXD1qKx/fNK8=;
        b=TPCBg6qvlL6CW9P6NJJSWmZd4+enSSBwl/1QT/Fe6QWFbX1W+Tk4RCJJ9BP9+MxcMg
         QgyV0/Q7y+Nd2W6Sv8iNoDauReW320wAr0sG43Ci8jODlQ9xnx9uvoo34S6Sl+kU+Urb
         xbQOCOPmxCnPxNmnbKBNWE7ngi6O/CLA0Ms57iLLIg7in+1SZlsZ/P5y8bbZboTGhLRW
         dJlz9aKDQGnNiek+BvdrV4Tmt7xNugXzPwLIp4BAWYihWSKqBhJDa0emUYe2fxr9VP97
         SWAnwX63ibyGlyW+cOb7mYK68zF0JRFP75+DvIGyvFm/LsTjdqTBcfMXcKjvkjvNxmos
         8BDA==
X-Gm-Message-State: ANoB5pktXDve8++FW7QqrT8lgAINUrRBhFhojVUGR3WJ+KNE0x92ipwX
        QVnodOZQzE7SCgTVyTfaaHpOG0FQrA==
X-Google-Smtp-Source: AA0mqf4tDzAedQ8aJ/Bq9xOKRwGQfaKwu4TK0IcHeYg6gaUp0BcHkF0oJkzDGWl29bu14DUJSYbVtA==
X-Received: by 2002:a05:6830:1605:b0:662:883:99f1 with SMTP id g5-20020a056830160500b00662088399f1mr40102otr.42.1668634526225;
        Wed, 16 Nov 2022 13:35:26 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t25-20020a4adbd9000000b0049427725e62sm6489225oou.19.2022.11.16.13.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:35:25 -0800 (PST)
Received: (nullmailer pid 1004914 invoked by uid 1000);
        Wed, 16 Nov 2022 21:35:27 -0000
Date:   Wed, 16 Nov 2022 15:35:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: rzg2l-thermal: Document RZ/Five SoC
Message-ID: <166863452714.1004682.13190739210497231524.robh@kernel.org>
References: <20221115121629.1181667-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115121629.1181667-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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


On Tue, 15 Nov 2022 12:16:29 +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> The TSU block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,r9a07g043-tsu" compatible string will be used on the
> RZ/Five SoC so to make this clear, update the comment to include RZ/Five
> SoC.
> 
> No driver changes are required as generic compatible string
> "renesas,rzg2l-tsu" will be used as a fallback on RZ/Five SoC.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
