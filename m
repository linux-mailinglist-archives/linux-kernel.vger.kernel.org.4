Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FC867A4AA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 22:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbjAXVOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 16:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjAXVO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:14:29 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A7245225;
        Tue, 24 Jan 2023 13:14:27 -0800 (PST)
Received: from booty (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2917120003;
        Tue, 24 Jan 2023 21:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674594865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLO6IC4VLOlTEyFjq+sy4xgqFEeyoTwAMmJNZzryGtw=;
        b=hHhy4kx7JrvVZA7Y931aeVeOn2yw7yaXASKNTPcZubHgXvRlHc2ZxV9s4aou1ozqXqJjlE
        4VmrG7rkATwQfp17mAr8BWTYB6wAddayfw5Evn2DlsuGvG0s/LEpCvrivDsaFzefknZHRo
        INIpXikmJvV0kBMAytwxAWQZpY0kODjRxKVSVVjoxye8N6830sGDXm0xfbycxmuD/flqTb
        cyZHaD0nxKGBqS7Tks5ctbySaUwE/OASzleG9ZUeKhqV4tTCk6sQpHyRKKQq3T7Yv5EEB3
        nKLIU/BRp/yBV8fUjJ4IyYka/n6kWVAea2dDJyrhceCZg2NUcwLJHfoZPcp8Sw==
Date:   Tue, 24 Jan 2023 22:14:21 +0100
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 02/21] dt-bindings: display: tegra: vi: add 'vip'
 property and example
Message-ID: <20230124221421.2d45a532@booty>
In-Reply-To: <cdc91bc4-aa76-f824-36c9-d2995c17fb18@collabora.com>
References: <20221229133205.981397-1-luca.ceresoli@bootlin.com>
        <20221229133205.981397-3-luca.ceresoli@bootlin.com>
        <cdc91bc4-aa76-f824-36c9-d2995c17fb18@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Tue, 24 Jan 2023 20:02:39 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> On 12/29/22 16:31, Luca Ceresoli wrote:
> > +        vip {
> > +            compatible = "nvidia,tegra20-vip";
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +            channel@0 {
> > +                reg = <0>;
> > +                ports {
> > +                    #address-cells = <1>;
> > +                    #size-cells = <0>;
> > +                    port@0 {
> > +                        reg = <0>;
> > +                        vi_vip_in: endpoint {
> > +                            remote-endpoint = <&mt9v111_out>;
> > +                        };
> > +                    };
> > +                    port@1 {
> > +                        reg = <1>;
> > +                        vi_vip_out: endpoint {
> > +                            remote-endpoint = <&vi_in>;
> > +                        };
> > +                    };
> > +                };
> > +            };  
> 
> In the changelog you said that the channel@0 node is removed

Thanks, you are right, this is a leftover. I must have forgotten about
updating the example. :-\

It will be fixed in v4 obviously, I was waiting before sending it in
case of any feedback on the other patches.

Best regards.
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
