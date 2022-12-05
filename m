Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2671643536
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiLEUDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiLEUDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:03:12 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFAA10CB;
        Mon,  5 Dec 2022 12:03:10 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id cn2-20020a056830658200b0066c74617e3dso7963040otb.2;
        Mon, 05 Dec 2022 12:03:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+W1sj6RAGXizx4i/Qzvpsvihqw6KYbgIgrAWRGb7Mos=;
        b=rS2Hjmd1NI/0ZJb0kFceq8+fyQwI4LUfsJAv3U2QDZfxatyDN7WxFS+srZ8TauCUMz
         JzyRZklCIMFthCscsUJ7Ofpmj5WsKydOqAY6jvNh+vo2nlIu4jpMZEealcjOSzSNg4DP
         aGzLbaCdmaH2tKTbBh9+HVIGd13GYPKOPpG+Zl2XxxKgIjLiAN2ZXipbWb4ChfceJBKO
         0eOBARM42qDap9xruyzx5XTRsobuWD9QjD1NcnVz2wFVvTUFOUSqo63spWTUUm3N1Eym
         dmHeBMBVG8L0CAVokc7PYhDgyioUDS55jyqXtAamECGnvISF3ZpF66ZUU7uiQU4IS+Pk
         6chg==
X-Gm-Message-State: ANoB5pl8CSIlkO1Shd5VCuvq7OOCGCeHqea4BsCdJayLHsR68YF+eRq/
        sV1msEFRsb4qcM9486HWXA==
X-Google-Smtp-Source: AA0mqf4cy9gGp0M4GuPbOqNQwOUFNqLWLBMdSYtbIP79ziXVLqNr5+8hFB9zk2AYaadp3H7A0yZHoQ==
X-Received: by 2002:a9d:2941:0:b0:66c:2a6d:e5a0 with SMTP id d59-20020a9d2941000000b0066c2a6de5a0mr30900337otb.373.1670270590064;
        Mon, 05 Dec 2022 12:03:10 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u19-20020a4ae693000000b004a0cb488f14sm1601735oot.23.2022.12.05.12.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 12:03:09 -0800 (PST)
Received: (nullmailer pid 2500878 invoked by uid 1000);
        Mon, 05 Dec 2022 20:03:08 -0000
Date:   Mon, 5 Dec 2022 14:03:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, linux@armlinux.org.uk, linux-hwmon@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, corbet@lwn.net,
        jdelvare@suse.com
Subject: Re: [PATCH v3 3/6] dt-bindings: hwmon: Add hpe,gxp-fan-ctrl
Message-ID: <167027058851.2500814.11700544023248077261.robh@kernel.org>
References: <20221130200846.4226-1-nick.hawkins@hpe.com>
 <20221130200846.4226-4-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130200846.4226-4-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Nov 2022 14:08:43 -0600, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Create documentation for the binding to support control of the fans on
> HPE platforms.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  .../bindings/hwmon/hpe,gxp-fan-ctrl.yaml      | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
