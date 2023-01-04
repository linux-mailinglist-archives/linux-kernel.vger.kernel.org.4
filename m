Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7732E65CB12
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238867AbjADAqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238797AbjADAqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:46:05 -0500
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DDA14D1F;
        Tue,  3 Jan 2023 16:46:04 -0800 (PST)
Received: by mail-io1-f42.google.com with SMTP id 3so17434045iou.12;
        Tue, 03 Jan 2023 16:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYTjG8GCc5Aam78lNOykbDVzCxlEeNQJMUTyXaDxzn0=;
        b=HCcAqPaTcAzSysoo+gPr9SXqQrvQOII/AYqyo5DzxglEZkawWiihT+Ul1T3akENur+
         HqnWxTpjJVNxYENasTOuEftYr+0+QPSYLgcwCiV5aa0uLf4hsqndHMVasUIu5A/Jgiiz
         V7/8y0A5A6Xf5eCJyLxKzjEyaPqMEoQ0pmUKdpQIiV9CvX1/zdaD161VJSjPZ0n6IZBp
         GfWQQiWRHPKGNQ+NSRSdq34k1IiHSFNpMH7K56UlNK/RyBLsuOURM7UbIabuY9rnc8A3
         msyMVRgqlHNNzWZzH16WI0CMVirBdFtfTdxzpbyFy6E6njucs5E2gFdU4qU5PdnuVQuH
         kLAQ==
X-Gm-Message-State: AFqh2kqPC75GyZFJlCnzYw5Y5+X89Ms1ghVT6nKiZQ+8l0p9ulXJ7aFr
        KYA6qtAvk9D1vA2Z06R1+w==
X-Google-Smtp-Source: AMrXdXsWV4asgKuRcEaeOGPIrP5ORSRvZkL1qGMk9WDOAYYyZwy5Wz4WwdbRmFrb2qwV+WobJ7PE3w==
X-Received: by 2002:a5d:984a:0:b0:6bc:d715:b8fc with SMTP id p10-20020a5d984a000000b006bcd715b8fcmr37831242ios.11.1672793163313;
        Tue, 03 Jan 2023 16:46:03 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n12-20020a056638110c00b00389d6a02740sm10218240jal.157.2023.01.03.16.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 16:46:02 -0800 (PST)
Received: (nullmailer pid 167203 invoked by uid 1000);
        Wed, 04 Jan 2023 00:46:00 -0000
Date:   Tue, 3 Jan 2023 18:46:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, linux-usb@vger.kernel.org,
        alsa-devel@alsa-project.org, perex@perex.cz,
        linux-kernel@vger.kernel.org, mathias.nyman@intel.com,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        quic_plai@quicinc.com, broonie@kernel.org, andersson@kernel.org,
        quic_jackp@quicinc.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, tiwai@suse.com,
        Thinh.Nguyen@synopsys.com, lgirdwood@gmail.com, agross@kernel.org,
        bgoswami@quicinc.com, linux-arm-msm@vger.kernel.org
Subject: Re: [RFC PATCH 14/14] ASoC: dt-bindings: Update example for enabling
 USB offload on SM8250
Message-ID: <167279315912.167137.6150924644437546616.robh@kernel.org>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-15-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223233200.26089-15-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Dec 2022 15:32:00 -0800, Wesley Cheng wrote:
> Add an example on enabling of USB offload for the Q6DSP.  The routing can
> be done by the mixer, which can pass the multimedia stream to the USB
> backend.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  .../devicetree/bindings/sound/qcom,sm8250.yaml      | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
