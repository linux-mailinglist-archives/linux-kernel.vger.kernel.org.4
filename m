Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366BA7288E1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbjFHTnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjFHTno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:43:44 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0782121;
        Thu,  8 Jun 2023 12:43:39 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso45974039f.3;
        Thu, 08 Jun 2023 12:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686253419; x=1688845419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7U0zTc24ytGGzlyel1Af7i7P3XOznRaJPq/P7jBwwD4=;
        b=SHGojOHzjVOaOTXzgZivCOlbwr2CgBKOA1DSDffZqoIDwTkpKiChPJWVAEcVHU6wCs
         bI4EwXJoLHe24Sf2eI/qr4yl2DDlc6PaX7w6TwmFJ4W+pLw1csp3Kn6+EHsPMrlJpOTJ
         nU2WsgOlPRmXfWx24mwabRKDUZKZqYVf+GwPEVuTKKnwZhaahe6CTHJuNtlQOy/UZHdF
         luO8bLkeTCFoLw60J3hQpO3aQmdwYRWm0oc2Tc4I6TeQx34ohaSnwavM6JJg8Fifh4/i
         519wULDO0AU+KmJFhU2gPPvOrgo5na1CDfJRaeJu+rQ6mkzSewWvQXnc/cGyFoqsFYWB
         T2mA==
X-Gm-Message-State: AC+VfDwLJ+1UhAdiVgPcEFfRUk3wPGEe3nMEXi/GykDwCiJ6m+Xq6rBo
        G539wKlsFydvBQgfz96dCg==
X-Google-Smtp-Source: ACHHUZ54Jwao0CPoPCS4+xl//513zcQj8+ClMRRpaFOyEBKjv879tBuFbVNST9e1frlYL5+vlHfg5Q==
X-Received: by 2002:a6b:7614:0:b0:779:c221:eb6c with SMTP id g20-20020a6b7614000000b00779c221eb6cmr6984169iom.19.1686253419023;
        Thu, 08 Jun 2023 12:43:39 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id d19-20020a02a493000000b0041a9e657035sm471429jam.48.2023.06.08.12.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 12:43:38 -0700 (PDT)
Received: (nullmailer pid 3284394 invoked by uid 1000);
        Thu, 08 Jun 2023 19:43:35 -0000
Date:   Thu, 8 Jun 2023 13:43:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Caleb Connolly <caleb@connolly.tech>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH RFC 07/10] dt-bindings: display: panel: Describe Samsung
 SOFEF03-M Display-IC
Message-ID: <168625341521.3284336.6842644080474323088.robh@kernel.org>
References: <20230521-drm-panels-sony-v1-0-541c341d6bee@somainline.org>
 <20230521-drm-panels-sony-v1-7-541c341d6bee@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230521-drm-panels-sony-v1-7-541c341d6bee@somainline.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 21 May 2023 23:23:09 +0200, Marijn Suijten wrote:
> Document the SOFEF06-M Display-IC and 1080x2520 panel found in the Sony
> Xperia 5 II (6.1").
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  .../bindings/display/panel/samsung,sofef03-m.yaml  | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

