Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5486F661806
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbjAHSVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjAHSVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:21:19 -0500
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A8E5F5F;
        Sun,  8 Jan 2023 10:21:19 -0800 (PST)
Received: by mail-il1-f177.google.com with SMTP id a9so3222106ilp.6;
        Sun, 08 Jan 2023 10:21:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHPrSFFcOdEFW5BfMzmDVrL4B9lkfCrfcDCG5MEJwzE=;
        b=A/sGNm5IXLTK5+SRcdmqSMoa1ZvZQGmbuFcckgJasgq3eNj2Htzxw3sxNIGsiT1Gxw
         H8+QYbefhnJ3FaGOTZkeHJWhKB7wbmpeISo/9Ba9Knm8Fpzb9akCiwI0pKRL0IgEXGAx
         nofTNywUHSVZuGeCKu3UV7haF9C1LVHfJTXt9JPG16j/UKEZoE4/yCP0fJseY22/5UdY
         k2xNQkhfwkT1FqKvWaY9Oz5MD5/qMG5KGvpC2QqlFX9baPZCKyNCJhO4sv5lw8yXuU4P
         ObpPv793goiAUHHDbADUOzeOu3s+hwfNBOCli8jwvnNvY4epdJoBsMxo52DozRyxrTEC
         mk5Q==
X-Gm-Message-State: AFqh2kpzMbem7Dm+l3Lcx5XZZQVbh8md+OKIkcsSKJPy2lAqTza+SsCJ
        dFOHZFHVw1R38zGHJfGdoQ==
X-Google-Smtp-Source: AMrXdXtW/tykY+OCJNOyQB1OgqyhEf5PfpUd5IfFo4tWcoieeXJ1mgucy7DueCgIYGtXeiD6jk9h2A==
X-Received: by 2002:a05:6e02:2218:b0:30d:a49f:95cc with SMTP id j24-20020a056e02221800b0030da49f95ccmr1193432ilf.5.1673202078236;
        Sun, 08 Jan 2023 10:21:18 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id b13-20020a05663805ad00b0038308683a09sm1658962jar.143.2023.01.08.10.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:21:17 -0800 (PST)
Received: (nullmailer pid 166379 invoked by uid 1000);
        Sun, 08 Jan 2023 18:21:15 -0000
Date:   Sun, 8 Jan 2023 12:21:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/8] media: dt-bindings: qcom,msm8996-venus: document
 interconnects
Message-ID: <167320207493.166332.7227434609304997534.robh@kernel.org>
References: <20221227144102.79391-1-krzysztof.kozlowski@linaro.org>
 <20221227144102.79391-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227144102.79391-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Dec 2022 15:40:57 +0100, Krzysztof Kozlowski wrote:
> Venus on Qualcomm MSM8996 defines interconnects:
> 
>   apq8096-db820c.dtb: video-codec@c00000: Unevaluated properties are not allowed ('interconnect-names', 'interconnects' were unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/media/qcom,msm8996-venus.yaml     | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
