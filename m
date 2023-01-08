Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9B066192D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjAHUPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjAHUPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:15:10 -0500
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C919DFE1;
        Sun,  8 Jan 2023 12:15:07 -0800 (PST)
Received: by mail-il1-f175.google.com with SMTP id m15so3961404ilq.2;
        Sun, 08 Jan 2023 12:15:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLlUIpZ0yRF5inoLVaECHxmgQGy5BGFowv/igmFsU9s=;
        b=L+nJisr4aFR+nD49f5cJTdAitV/FzJX5ngQmow15aL2kjbqiL9NbDG/5ePoAXc5ZIJ
         AeXJX+xEas9i9F/01cd5wv/DytbWzhoKYuUe7KcBl3pXizf6KHBvf804VJRuf4l/dK6g
         qrMmoYMUXbgX1BQaSXl/r1WmulT/qw5QNpiaR7rocruLfSxN41GZt6C/X9/KBT1P1tUP
         h5TSSuWgQ40yF1IoPlqJpYxNVyo8Xc3cJKhfOR8jTGyQmFUXLwviDBDIvDmSxt+AA7YT
         yvOmAyv0LQKd7SzyIreaXfECcnS2vZOUQRK6IOJozAZ2mqQK1AaueTSn2Dkm7C8tSrQI
         LMjw==
X-Gm-Message-State: AFqh2kpmsOq5rlUXrGpJvHSkA4MBYgU4dftZauFuqvdanW17FBqhWw4A
        Z9rCZrj7xdIjZAOdqVw4eQi86C6AEw==
X-Google-Smtp-Source: AMrXdXt+l2Cwca4cuUyaO+DlZLxTsM4wlJRK+RtREIPn2jPU65LC3w7wpndBn5rpd0775jRjQGjhYA==
X-Received: by 2002:a92:d94a:0:b0:30b:f4af:b32f with SMTP id l10-20020a92d94a000000b0030bf4afb32fmr38771210ilq.23.1673208906726;
        Sun, 08 Jan 2023 12:15:06 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id z17-20020a027a51000000b0039e296bf18esm2202153jad.167.2023.01.08.12.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 12:15:06 -0800 (PST)
Received: (nullmailer pid 220563 invoked by uid 1000);
        Sun, 08 Jan 2023 20:15:03 -0000
Date:   Sun, 8 Jan 2023 14:15:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lux Aliaga <they@mint.lgbt>
Cc:     linux-phy@lists.infradead.org, marijn.suijten@somainline.org,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        martin.botka@somainline.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 2/6] dt-bindings: phy: Add QMP UFS PHY compatible for
 SM6125
Message-ID: <167320890262.220493.12109738826337104873.robh@kernel.org>
References: <20221231222420.75233-1-they@mint.lgbt>
 <20221231222420.75233-3-they@mint.lgbt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231222420.75233-3-they@mint.lgbt>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 31 Dec 2022 19:24:16 -0300, Lux Aliaga wrote:
> Document the QMP UFS PHY compatible for SM6125.
> 
> Signed-off-by: Lux Aliaga <they@mint.lgbt>
> ---
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
