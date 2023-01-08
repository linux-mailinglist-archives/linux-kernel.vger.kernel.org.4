Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CE066180A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbjAHSXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjAHSXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:23:51 -0500
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102C56588;
        Sun,  8 Jan 2023 10:23:50 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id q190so3479539iod.10;
        Sun, 08 Jan 2023 10:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAXEvPdpM2kliNVQ/ZuMWFb6hfZghbWNnQ2pkqNy9Dc=;
        b=qPUHiXbGhqkFGUVAO9xKrYjs1zSaCPH3Ky5M5uNX9Jl5VCyLOzEqVygbErY7gue/6J
         +3/YlLSfIwToEmY07F/Xwgp8xQ6+lg4jrtea/QZKAWng28orqD6C/BF+iW+h00EUqVzc
         oQ6a3vjZoBeR5QVr+Zqg/YeKrtASgkw5R7Hj8NFemtV9HBUlS8YRNN8DMl2z5m2Ep0N/
         tTfcsvYPE6MNNFsGzmGvmnlqRjJ5IRLyw42ZnACoa7abRo08bEDm7VZ9C5GWPXoWgkac
         ePaHHzrEXn5dgh9PdHOeDTQE5NCYB8ALgGVshAnsi2NqKeoWWXPzncfDWW1YBGYDrPs3
         JSbQ==
X-Gm-Message-State: AFqh2kqStDB4+lEo91kxbqglNUmDmyA6VPP6+HL5vh5u7dbrZ7z51v+a
        w82Y642ZI4dD0YBRYo7KqQ==
X-Google-Smtp-Source: AMrXdXuuvYHqMGOXkOJFdTxq7XmPbecJbhIaUgQoMuUA0T083eL6RkRNCKW9wjWBxp/57240NTNnxA==
X-Received: by 2002:a05:6602:398e:b0:6e3:120d:f9ed with SMTP id bw14-20020a056602398e00b006e3120df9edmr47124329iob.19.1673202229293;
        Sun, 08 Jan 2023 10:23:49 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id n31-20020a056602341f00b006884b050a0asm2458045ioz.18.2023.01.08.10.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:23:48 -0800 (PST)
Received: (nullmailer pid 169099 invoked by uid 1000);
        Sun, 08 Jan 2023 18:23:44 -0000
Date:   Sun, 8 Jan 2023 12:23:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: Re: [PATCH 4/8] media: dt-bindings: qcom,sc7180-venus: document OPP
 table
Message-ID: <167320219708.168130.12102311075221051817.robh@kernel.org>
References: <20221227144102.79391-1-krzysztof.kozlowski@linaro.org>
 <20221227144102.79391-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227144102.79391-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Dec 2022 15:40:58 +0100, Krzysztof Kozlowski wrote:
> Venus on Qualcomm SC7180 uses Operating Performance Points (both in DTS
> and driver):
> 
>   sc7180-idp.dtb: video-codec@aa00000: Unevaluated properties are not allowed ('operating-points-v2', 'opp-table' were unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/media/qcom,sc7180-venus.yaml          | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
