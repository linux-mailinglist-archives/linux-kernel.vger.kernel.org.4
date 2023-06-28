Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F333F741574
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjF1Plz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:41:55 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:53633 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjF1Plc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:41:32 -0400
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-78362f57500so1092239f.3;
        Wed, 28 Jun 2023 08:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687966891; x=1690558891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+l0t342YajPczddg3NeDWb3a/OrxF8h1Xy5klh6ycWw=;
        b=XkjTjz05p7URLpk6mYEvgGPvC1yZ9tAfJ4xC8XtILS7wuqRRlO16AjGNuRgCjhqG6t
         f6EhHGnsbdNbuampDlm93v3Xh8fMIQY65wehOJwX0vsxIQbyl0uah27ANN7pLVH/Fe6p
         bXJxABm+uhgfrt6ok5ABH/wY2OnT1aqW8nfBhzlBxMqFqCDwi1hIzYMsKWNzMxUhFuHP
         W1izzCz0+IEuHM973aAU3NMweeHe38Gbk4pP9XsnV1Uiqx1LzLTvBAGvWrtTtgJ3Hh/Y
         8jqheuaMx++Q9H3hLxwqSST8vseUUlIDUYTXANC8x1BEQJqHXYkH2pv/eKg/c7fUnDKE
         VWvA==
X-Gm-Message-State: AC+VfDx7U4s5tayHdIXi4SaCPPBtRbWYalJBlFAMhfUWDS9tH0cwv3pC
        Ege23f9si2LQRcyIqDH9Ow==
X-Google-Smtp-Source: ACHHUZ5z1KhArl5WVBvoeAffyfwPgt5CoRj5pu9y5bbLS+G4RJIbaL86Jp/4BB3uTKG2VX7LEPJDuQ==
X-Received: by 2002:a6b:f219:0:b0:783:72b9:ed6b with SMTP id q25-20020a6bf219000000b0078372b9ed6bmr5979826ioh.12.1687966891575;
        Wed, 28 Jun 2023 08:41:31 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h19-20020a0566380f1300b004267a5abce9sm350066jas.53.2023.06.28.08.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 08:41:30 -0700 (PDT)
Received: (nullmailer pid 526885 invoked by uid 1000);
        Wed, 28 Jun 2023 15:41:29 -0000
Date:   Wed, 28 Jun 2023 09:41:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     cy_huang@richtek.com
Cc:     krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, broonie@kernel.org, conor+dt@kernel.org,
        lgirdwood@gmail.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: dt-bindings: rt5739: Add compatible for
 rt5733
Message-ID: <168796688888.526832.3830907816457044210.robh@kernel.org>
References: <1687942037-14652-1-git-send-email-cy_huang@richtek.com>
 <1687942037-14652-2-git-send-email-cy_huang@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687942037-14652-2-git-send-email-cy_huang@richtek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Jun 2023 16:47:16 +0800, cy_huang@richtek.com wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add compatible string for rt5733.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

