Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350E06F0AE7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244308AbjD0Rfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244000AbjD0Rfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:35:31 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322F630EE;
        Thu, 27 Apr 2023 10:35:31 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6a5f6349ec3so3669538a34.0;
        Thu, 27 Apr 2023 10:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682616930; x=1685208930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VS2BzFYKAolsNat9wyZK+OK7oQITTHm6Vb53qON0eds=;
        b=Uryly6zb0v8da74g2p8YMUOX4EoPSaMQQS+YrumAruBwcyz2m9vg7jYwz92Ob7Te99
         oVdJDchV1m7pewTnSloZ/IBJpx8luh8Q+jE5U/TNDAbPg1R5COcdU4MVgzl2RYVPO9NI
         Mn4tglkh7zrC7dXjNf8EfrHo97azUrPWuuwk1QfGnR7W5ePZdBUCMzR0eQcbTvcy3Rsf
         OJX+B7kSCA26q45ML5y64YefH3YSu/PRWHE5whNtHK9R1rdTb64hoGF1+b5Y8RZX1TXJ
         WvzNkwdEUV70KHZbSVx4cJ5/St7qYJDMkvFEjUgel79Kf+w+BuQ3yepbHUScDXLNC37X
         kbqA==
X-Gm-Message-State: AC+VfDxfSdlt07deWDiOANd48tdYlioE+lGwBQnveKhcpQwRmz9vjy2Q
        R0W9LPQ4oMl64bQ/mTsE6w==
X-Google-Smtp-Source: ACHHUZ6ddHGGah/wSHp7AFR/6L61y0V+EFA9mkWxr0viW192TYKd7OtQlFDnNHKOzpEZD60myXvxKw==
X-Received: by 2002:a05:6830:2054:b0:6a5:ce05:a5b1 with SMTP id f20-20020a056830205400b006a5ce05a5b1mr1200472otp.3.1682616930360;
        Thu, 27 Apr 2023 10:35:30 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l2-20020a05683004a200b006a43519523fsm3592765otd.1.2023.04.27.10.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 10:35:29 -0700 (PDT)
Received: (nullmailer pid 3205401 invoked by uid 1000);
        Thu, 27 Apr 2023 17:35:29 -0000
Date:   Thu, 27 Apr 2023 12:35:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fei Shao <fshao@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-kernel@vger.kernel.org,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: input: goodix: Add
 "goodix,no-reset-during-suspend" property
Message-ID: <168261692866.3205353.5077242811275926416.robh@kernel.org>
References: <20230427035656.1962698-1-fshao@chromium.org>
 <20230427035656.1962698-2-fshao@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427035656.1962698-2-fshao@chromium.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Apr 2023 11:56:55 +0800, Fei Shao wrote:
> We observed that on Chromebook device Steelix, if Goodix GT7375P
> touchscreen is powered in suspend (because, for example, it connects to
> an always-on regulator) and with the reset GPIO asserted, it will
> introduce about 14mW power leakage.
> 
> To address that, we add this property to skip reset during suspend.
> If it's set, the driver will stop asserting the reset GPIO during
> power-down. Refer to the comments in the driver for details.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: Jeff LaBundy <jeff@labundy.com>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Use a more accurate property name and with "goodix," prefix.
> 
>  .../devicetree/bindings/input/goodix,gt7375p.yaml        | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

