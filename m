Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44818678C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 00:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjAWXk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 18:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjAWXk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:40:57 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AAE367EA;
        Mon, 23 Jan 2023 15:40:54 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id r205so11855683oib.9;
        Mon, 23 Jan 2023 15:40:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wK5PABXkfzdiB1g3c1gMSB7i4iF75W1sq+ualRLeyc=;
        b=daUU2UdA4XVy2FJ3pjTH906S3M7hnDcBtvpsUQ8+Q+Fs260mfAbG3U4jr9Pt+f0ycR
         hnPwwfs1biUanA3B1+RSRbF2/uP60HDpKpHIKlZoDn/VC//O0vWzKfXIebnSuawy+Ci0
         HAOrc3fVTfPOzLcrvVA6Inu0tk+XDzvkZvvQFgA0a+Q32f1dPps8i2Wjpu3BgFDHhjpn
         J8b/TRpI3o5GCX0rA4IvgPVWjyoA2iHhjAkWNi61zX1F2pVAQEiIH8iKlCDZJf2WD0wy
         m9ZZIB/mBHSe/xkVp2gWlqQqKw5HVGcADCwZOem02/na7Vqh10uLqz+j+wEKAJlEga03
         u/lQ==
X-Gm-Message-State: AFqh2kpnBm3RtbwGxKpYsSOHbaUTMXdbf6KsMKmCL06dSykk3Tpdd1dA
        Uc1VkDtJZ2PPlrx/VdkVJg==
X-Google-Smtp-Source: AMrXdXvvqgytI5Uqat11KEJnf0hgg8jRMVvWRGAu5sUAStS8C71u1HjpTnLwT/e93lDRhMm6Yz6awA==
X-Received: by 2002:a05:6808:105:b0:36c:9c19:2667 with SMTP id b5-20020a056808010500b0036c9c192667mr9867323oie.50.1674517253381;
        Mon, 23 Jan 2023 15:40:53 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bg10-20020a056808178a00b00363ea5be014sm363345oib.3.2023.01.23.15.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 15:40:53 -0800 (PST)
Received: (nullmailer pid 2923815 invoked by uid 1000);
        Mon, 23 Jan 2023 23:40:52 -0000
Date:   Mon, 23 Jan 2023 17:40:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     broonie@kernel.org, srinivas.kandagatla@linaro.org,
        judyhsiao@chromium.org, bgoswami@quicinc.com, andersson@kernel.org,
        robh+dt@kernel.org, quic_plai@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, agross@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, swboyd@chromium.org,
        konrad.dybcio@linaro.org, alsa-devel@alsa-project.org,
        quic_rohkumar@quicinc.com
Subject: Re: [PATCH v3 2/2] ASoC: dt-bindings: google,sc7280-herobrine: Add
 platform property
Message-ID: <167451725163.2923757.17021900748065338882.robh@kernel.org>
References: <1674468802-14834-1-git-send-email-quic_srivasam@quicinc.com>
 <1674468802-14834-3-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674468802-14834-3-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Jan 2023 15:43:22 +0530, Srinivasa Rao Mandadapu wrote:
> Add platform property in sc7280 machine driver bindings for including
> platform subnode in dai-links.
> This is required for binding the frontend dai driver to do dynamic pcm
> routing in ADSP based platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
>  .../devicetree/bindings/sound/google,sc7280-herobrine.yaml   | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
