Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6E3661859
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbjAHSt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbjAHStx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:49:53 -0500
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A91BF02B;
        Sun,  8 Jan 2023 10:49:52 -0800 (PST)
Received: by mail-il1-f171.google.com with SMTP id a9so3244331ilp.6;
        Sun, 08 Jan 2023 10:49:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBfc6frQTYTBFojIsbaKyBhhX3b6E0jigcJZMgl0JrQ=;
        b=Fbpidt+5WWJvsfmWuF9jsmQHlQwSQqsNUM8iTf1hVpLgFpMITB1SA9fpzQSXUQX0zW
         6z3fUWHMKuu7/kLqNq8yMgkOicri6ZBYOcBlLZNNKwIqkP0EHE92cGxUbRcrrEfAGaAR
         +8TOs9fge+6oGRNW3y5BrKqMJZUJdLLs5vYBJqsLc0pEjSWCHwGAfl1jRIGrLHjAil63
         1jszdZUEIxM6qr9TgnJEWnxngbKUEARyM5aJwsYAIQV26ARF+r0yTciBHDTDhl8c4NX1
         Xj5x1S/LZnxzr20hJ8j/Egc4aLT68RbQxcm/ju1rF6ShLlFoeRe2zMAjLnoL74viYqyb
         YVgg==
X-Gm-Message-State: AFqh2kpOpDypJY9dVALoqou6x8eQY7TNYjZKPY3qn2G/73MbnjHy7UAL
        LKQtjf2719X/1kla/+UELFnfP4E+XA==
X-Google-Smtp-Source: AMrXdXvo7DMW/eAXa4+8ljdaOX7G+IzIj8Y/rjrLDEP2koe94ISfRyigR9jNMkceX3Z/Wfm9LeXAZQ==
X-Received: by 2002:a05:6e02:112:b0:30c:3204:5fbd with SMTP id t18-20020a056e02011200b0030c32045fbdmr22652957ilm.31.1673203791274;
        Sun, 08 Jan 2023 10:49:51 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id e32-20020a026d60000000b0039e583abceasm2160636jaf.68.2023.01.08.10.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:49:50 -0800 (PST)
Received: (nullmailer pid 198525 invoked by uid 1000);
        Sun, 08 Jan 2023 18:49:47 -0000
Date:   Sun, 8 Jan 2023 12:49:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     robh+dt@kernel.org, quic_mkrishn@quicinc.com, daniel@ffwll.ch,
        andersson@kernel.org, robdclark@gmail.com, airlied@gmail.com,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        sean@poorly.run, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, freedreno@lists.freedesktop.org,
        quic_abhinavk@quicinc.com, swboyd@chromium.org
Subject: Re: [PATCH v3 1/1] dt-bindings: msm: dsi-phy-28nm: Add missing
 qcom,dsi-phy-regulator-ldo-mode
Message-ID: <167320378648.198458.147612299624075109.robh@kernel.org>
References: <20221229124438.504770-1-bryan.odonoghue@linaro.org>
 <20221229124438.504770-2-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229124438.504770-2-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Dec 2022 12:44:38 +0000, Bryan O'Donoghue wrote:
> Add in missing qcom,dsi-phy-regulator-ldo-mode to the 28nm DSI PHY.
> When converting from .txt to .yaml we missed this one.
> 
> Fixes: 4dbe55c97741 ("dt-bindings: msm: dsi: add yaml schemas for DSI bindings")
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../devicetree/bindings/display/msm/dsi-phy-28nm.yaml         | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
