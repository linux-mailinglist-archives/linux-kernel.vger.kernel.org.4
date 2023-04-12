Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C886DF919
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjDLOxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjDLOxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:53:21 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138637696;
        Wed, 12 Apr 2023 07:53:19 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1842e8a8825so14002388fac.13;
        Wed, 12 Apr 2023 07:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681311198; x=1683903198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6npOgLSoX86yqEOWkbukw/PQ5Tk1RFse3UDbaQVnCTE=;
        b=SRox12NGv0eTadFBPwXzow9CTz4QdWBY8ixhxIhAEWse8CzDR5bd6IVXLQohIVRZXr
         4P8qrxUMof/MYONAHofGh0JhNZeZ7eHpy8UQT7IXztIcqsKRTvynPPFv/uR+lu5tyB7t
         q4tOmios+X2Cn52Om1YKjlk027yNcsgwKOg4uBm1khF/z9PHlwZd5K56GqDvpU/CHGtZ
         ldJMLtQ+CPFeMXdHp46QVbdFUdNlGblOqr6Do40dTfWpvx6WwhUZS2HW4JteWjFAeE1H
         +XoCK3D6QMjWxzUBVX5Boz5oz1f598JeOwXxxUmTtL6/ikAgWg5V1NAJU/gbDoJO66D6
         cZmg==
X-Gm-Message-State: AAQBX9d6sgbQSuVcYRA0B0jGqd3xSoriLMycRH8qo+J7rwc/RhR9KpCJ
        z1teweeEJZLPqs0c6liz4A==
X-Google-Smtp-Source: AKy350ZErMCsEeMFmEHLUAlfqYmrh5Q1Yg0DoBMD2Ft6O6PNi9iiDFrqW2FTgRsQyek4L9mUQ2S3jA==
X-Received: by 2002:a05:6870:fb87:b0:184:1ca3:1dd9 with SMTP id kv7-20020a056870fb8700b001841ca31dd9mr1429735oab.8.1681311198119;
        Wed, 12 Apr 2023 07:53:18 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bd16-20020a056871b31000b0016e8726f0d4sm6268478oac.3.2023.04.12.07.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 07:53:17 -0700 (PDT)
Received: (nullmailer pid 2350917 invoked by uid 1000);
        Wed, 12 Apr 2023 14:53:17 -0000
Date:   Wed, 12 Apr 2023 09:53:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     dmitry.torokhov@gmail.com, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, linux-input@vger.kernel.org
Subject: Re: [PATCH V3] dt-bindings: input: pwm-beeper: convert to dt schema
Message-ID: <168131119588.2350838.9982497201627531639.robh@kernel.org>
References: <20230407075259.1593739-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407075259.1593739-1-peng.fan@oss.nxp.com>
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


On Fri, 07 Apr 2023 15:52:59 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert the binding doc to dt schema, and also fixed the
> example from fixed-regulator to regulator-fixed.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
>  V3:
>   Drop description for pwms
>   Simplify description for amp-supply
>   update beeper-hz range to 10-10000
> 
>  V2:
>   License update
>   Don't need to show providers
>   Make example complete
>   Decrease beeper hz
>   Misc update
> 
> 
>  .../devicetree/bindings/input/pwm-beeper.txt  | 24 -----------
>  .../devicetree/bindings/input/pwm-beeper.yaml | 41 +++++++++++++++++++
>  2 files changed, 41 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.txt
>  create mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

