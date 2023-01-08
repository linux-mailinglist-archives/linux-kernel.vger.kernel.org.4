Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A92A66180F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbjAHSZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjAHSZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:25:41 -0500
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9132E6450;
        Sun,  8 Jan 2023 10:25:40 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id p9so3456654iod.13;
        Sun, 08 Jan 2023 10:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yr2hhSB7GL5Kd6wgGFzyMQISAMjSImaCNUgJ33s1aBw=;
        b=PFHLsvdezIqK/Xy+zdjVDDHBWvGwqCHtsq6UBWVjiVSMn1eEtovZvunrSlqy1zfdRW
         Le8Vyt1Lly4Z/EWyWX0vcBweSKqCGKds7/DQud9ROFNyCIb6etLF2XYLLgH1X0MUcN0x
         4H0GGrwaQiDW4wYI2TEMvD2w+inpwmqTIHZdlwGqCvlU2ZVN+rA3q4HYoN5w+YsNhJrI
         Zlm+YghWo4mLO0MC8xw87KKJIDoPIzvFfybjApN+jtVYzpe8RhJtdrQall4QjLatU+Qq
         5nhtDBlsM5/7MGA9s+704E6k/6rRl14H52Aa2KJ0GOL485iBURiNGFgx6qvbO6WEWQ9Y
         H+8w==
X-Gm-Message-State: AFqh2krKKpjJUOmXyvRaGnf6N2tZCcS2bdvHI2KFgIHwp7klqp7htZmP
        DU360ZkwQyabiahbF5AUaA==
X-Google-Smtp-Source: AMrXdXsaLP3wj63l0sP39dRbwHe55qNhh1PT0jiJMojqWWYV7dK9l/8pvgVUk28hdMBQHvOvcz2POg==
X-Received: by 2002:a6b:dd08:0:b0:6df:f420:8999 with SMTP id f8-20020a6bdd08000000b006dff4208999mr47696494ioc.15.1673202339830;
        Sun, 08 Jan 2023 10:25:39 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id g12-20020a05660226cc00b006ddb3b698ffsm2470562ioo.23.2023.01.08.10.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:25:39 -0800 (PST)
Received: (nullmailer pid 171152 invoked by uid 1000);
        Sun, 08 Jan 2023 18:25:36 -0000
Date:   Sun, 8 Jan 2023 12:25:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 5/8] media: dt-bindings: qcom,sc7280-venus: document OPP
 table
Message-ID: <167320233604.171080.12898983539956730185.robh@kernel.org>
References: <20221227144102.79391-1-krzysztof.kozlowski@linaro.org>
 <20221227144102.79391-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227144102.79391-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Dec 2022 15:40:59 +0100, Krzysztof Kozlowski wrote:
> Venus on Qualcomm SC7280 uses Operating Performance Points (both in DTS
> and driver):
> 
>   sc7280-crd-r3.dtb: video-codec@aa00000: Unevaluated properties are not allowed ('operating-points-v2', 'opp-table' were unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/media/qcom,sc7280-venus.yaml          | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
