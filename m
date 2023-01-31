Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2EC683A7E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjAaXbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjAaXbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:31:43 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E2B1B54A;
        Tue, 31 Jan 2023 15:31:42 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id e21-20020a9d5615000000b006884e5dce99so5932241oti.5;
        Tue, 31 Jan 2023 15:31:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZpJmY/vAV7sw0j3Od6zi4sNY3jQ6TPDxOUi/nS8wLk=;
        b=UohOjijQeBMW7MdK8KEsBYZ694XDZXKBEWH3FqZzXNwSFEAeWJyCxqMU5kGAvv2Bjb
         8VoOHQB01cP5U25LgCICe4jMlOlRt+lkyGk18eTWEQ9GxeJ5AYgB1hRtaNPn1brebzEs
         YyGul+a6Trh59Jh3UUXvrbS1mKbid0u4GWBMQ6VFiJ60tnYNIuHh6WIV1muuCh3/D24L
         5QdLUqcn403ahxjw/aGUpd48zKhEFwEeFpGpRPEews1qJmeMVpRNvJNBb9YihzVwTLzb
         MmPUYHYYkPZiJNT9cn7rczD+LtVUJm1xa6GE5Gl28oaD8UFDbHC+KLeSNIA8g/Py1mX4
         GueQ==
X-Gm-Message-State: AO0yUKXCEznd8cBvJNC0bSLJZ0ZttrTNszvktarrZifeDi6yLBvxdsCC
        cYR98wxz2UnAo371XiX4sg==
X-Google-Smtp-Source: AK7set+BBz0gJ5CqmiuWeP3KhWKRo8i/jf4fw+lWqawuBRxcBnA1EmuHreG3qjsJ/5nSau954Woy3A==
X-Received: by 2002:a9d:1283:0:b0:68b:ca10:4ad with SMTP id g3-20020a9d1283000000b0068bca1004admr210144otg.31.1675207901843;
        Tue, 31 Jan 2023 15:31:41 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j14-20020a056830014e00b0068bce2c3e9esm3407206otp.14.2023.01.31.15.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 15:31:41 -0800 (PST)
Received: (nullmailer pid 2150609 invoked by uid 1000);
        Tue, 31 Jan 2023 23:31:40 -0000
Date:   Tue, 31 Jan 2023 17:31:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH] dt-bindings: display: msm: Drop type from 'memory-region'
Message-ID: <167520789076.2150394.10201291390999389232.robh@kernel.org>
References: <20230125221357.3057655-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125221357.3057655-1-robh@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Jan 2023 16:13:56 -0600, Rob Herring wrote:
> 'memory-region' is a common property and already has a type.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/display/msm/gpu.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

