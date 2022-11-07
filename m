Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8623A61FF5A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiKGUPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbiKGUOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:14:37 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24002AE2C;
        Mon,  7 Nov 2022 12:14:17 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-12c8312131fso13973042fac.4;
        Mon, 07 Nov 2022 12:14:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTyYkKmk0ZFg6NKvx4h4V1/U52aTfp/VeufT5wgxfcc=;
        b=I7bZUySGszkcRdSlKYWtFVls6P8OpQifPfnf1mn5MI/kouqqsmF5102ifR5rK0HqFY
         OkM9/HV4bIvX1HrjBUDqbi2fZICzwDcJB3+ZnRBbJjbPUCfjNlvOrRlk6TZ2duR0HSoy
         s/VX3JJ3wHIkt12w27u5bUvwFEyIzGF5/9sRHLKgznzW/DKHyhx0P/4qywaiWw/190Tu
         E32SqHpPzJ+wXtbtyjax9Lsd1ceWhaNSoc4hZ2osdh/tQyW4eHeMrmWnKWiT2dpJ+lJ4
         KG3pSRqnA3z+8IolrDWVmRzKgzal6FCzaooA4Bw0XySw2H6ddc9AsZ6r3sukqresKDLc
         zgGg==
X-Gm-Message-State: ACrzQf0a23OwHQtgRA6S/aylFyyl5D65TIe/+Y3sjwUx8LapAXYV+lFm
        8pQog7x9NmwxzdB2oBxJjw==
X-Google-Smtp-Source: AMsMyM6l8LCWIiDxDxh5d5EhXJYIhBoM5GfAns5QmBWc/1EDDKO5IT5GRvoB+Q7S+gfwtSLmjmGiWA==
X-Received: by 2002:a05:6870:590:b0:13d:755e:10df with SMTP id m16-20020a056870059000b0013d755e10dfmr17202267oap.236.1667852056923;
        Mon, 07 Nov 2022 12:14:16 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x10-20020a056830114a00b0066c45517c8fsm3296237otq.52.2022.11.07.12.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 12:14:16 -0800 (PST)
Received: (nullmailer pid 1570941 invoked by uid 1000);
        Mon, 07 Nov 2022 20:14:17 -0000
Date:   Mon, 7 Nov 2022 14:14:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sandor Yu <Sandor.yu@nxp.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, kishon@ti.com, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        tzimmermann@suse.de, lyude@redhat.com, javierm@redhat.com,
        ville.syrjala@linux.intel.com, sam@ravnborg.org,
        jani.nikula@intel.com, maxime@cerno.tech,
        penguin-kernel@i-love.sakura.ne.jp, p.yadav@ti.com,
        oliver.brown@nxp.com
Subject: Re: [v2 02/10] dts-bingings: display: bridge: Add MHDP HDMI bindings
 for i.MX8MQ
Message-ID: <20221107201417.GA1568945-robh@kernel.org>
References: <cover.1667463263.git.Sandor.yu@nxp.com>
 <0e1f631c22207c6af41ea512be85213b3953b44f.1667463263.git.Sandor.yu@nxp.com>
 <d5fb79bc-c05c-8de1-e8a4-9e19cc5c8e1a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5fb79bc-c05c-8de1-e8a4-9e19cc5c8e1a@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 09:42:03AM -0400, Krzysztof Kozlowski wrote:
> On 04/11/2022 02:44, Sandor Yu wrote:
> > Add bindings for i.MX8MQ MHDP HDMI.
> 
> Typo in subject - bindings.

And 'dts'. It's 'dt-bindings: display: ...' Same for the rest of the 
series.

> 
> Also in the subject - drop redundant second word "bindings".
> 
> > 
> > Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> > ---
> >  .../display/bridge/cdns,mhdp-imx8mq-hdmi.yaml | 67 +++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-hdmi.yaml
