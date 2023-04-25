Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0586EE7CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbjDYSu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbjDYSuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:50:32 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F2C17A19;
        Tue, 25 Apr 2023 11:49:50 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-546ee6030e5so3286458eaf.3;
        Tue, 25 Apr 2023 11:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682448566; x=1685040566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHmR4Qsjqoa48btsGXrh3RZ/bVlluGDvo9DlMJv65rY=;
        b=FFSBqHFFa5WRkjjtNUiPPBv/lqPM3EJVtyRryHyCTNOzkL13nvTSw+mPXA/AZYKfp1
         IToYvRSM0LRNOJqQR/JbJ4iRVyqYwPuE3myafWOk3dAyvQdH2hZDUgExPH2+8bacZZk/
         Td0oiJErtpuIChqneh/rwEK/IkoPEE+9yMobuJLW3LMb3OigIeGPg7Et43ddz4/gHeej
         NcT64FAQe5Urxc/qoetnlV265ilOpIEHjUP3d77LQvYU2/H33hSna7GKlNElGG9a80Xn
         H6FXXyWVt3ikfL8fdqQlj76D3T4vdPDyywk3RyaXvqlyZlGiFCfg5WkjNgSBgHiXcx99
         Z/bg==
X-Gm-Message-State: AAQBX9dP+aSIiCxSeXpZVWxDeZe0MZDzShAiR6xv2Gi3XaKxBjM3t0Dd
        /DPnCJTJemw61/aKkxJ+fw==
X-Google-Smtp-Source: AKy350YvGuIditQzAj7OJfnQwyAGgcpTjKiJnQkwrKj4jn0Coz5+UcgUbeZXcM0pjNMOTVfiLVXv2A==
X-Received: by 2002:a4a:d749:0:b0:547:6481:799 with SMTP id h9-20020a4ad749000000b0054764810799mr6353560oot.8.1682448566469;
        Tue, 25 Apr 2023 11:49:26 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b5-20020a056870d50500b0017b21991355sm5440434oan.20.2023.04.25.11.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:49:26 -0700 (PDT)
Received: (nullmailer pid 2073438 invoked by uid 1000);
        Tue, 25 Apr 2023 18:49:24 -0000
Date:   Tue, 25 Apr 2023 13:49:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 02/13] dt-bindings: display: st7789v: add Inanbo
 T28CP45TN89
Message-ID: <168244856451.2073379.1600632526272371970.robh@kernel.org>
References: <20230422205012.2464933-1-sre@kernel.org>
 <20230422205012.2464933-3-sre@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230422205012.2464933-3-sre@kernel.org>
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


On Sat, 22 Apr 2023 22:50:01 +0200, Sebastian Reichel wrote:
> Add compatible value for Inanbo t28cp45tn89 and make reset GPIO non
> mandatory, since it might not be connected to the CPU.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  .../devicetree/bindings/display/panel/sitronix,st7789v.yaml  | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

