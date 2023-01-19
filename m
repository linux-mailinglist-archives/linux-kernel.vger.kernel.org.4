Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66178673E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjASQLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjASQLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:11:35 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E724B0;
        Thu, 19 Jan 2023 08:11:34 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1322d768ba7so3069493fac.5;
        Thu, 19 Jan 2023 08:11:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVoqcEE/mE1nAc4xlSJ9CtChRn1MVQqfn7xu81kzvTI=;
        b=MafrfJc2qjEJT7bPH1T1F1yCXxXY4mEdodP4hk+ZNNvGGWer+I2ruExrteid7jq2vu
         DXlqIxp/QOBoY+1DRD2qCl5E+Xl9W9zGFJ13eXncUrvj22vLv8qqPxlCGhwuJFKuRYeb
         VBX7O4BK+J+QjXzn0r9V+8fYEFrLyTNt0yFBYAgXJeJbGymOTwGyz/fPCoe6HZTwbx3v
         y/VGhjp0FPjjVZPeYFaz7Dl72Axau/mBWwn6/+oqSpNEZy8qWUVrPbGcVOMSWp56mfkS
         kgOjssXQi1VCc2VbW526W0pkk2RDNOXNDEo3F3Rd1BpoKBOQfYzhE7nTAJLREf11SmNf
         WUNw==
X-Gm-Message-State: AFqh2koahVPS/D1bzQ2bVFhMzPmA9Xdz2gyA5H7c8R7d1dlLPVmYFV32
        Nh1EQwuFmAFOBBHYOD/4e9wbNcy3Ow==
X-Google-Smtp-Source: AMrXdXtTcmMpQKehdIg9OF67l3H3i4RUIlKJXC2cknp/qUfSYcsT55f1yd5jy9ypzmtE9EzKERPZOg==
X-Received: by 2002:a05:6870:e88:b0:15f:5fd:b914 with SMTP id mm8-20020a0568700e8800b0015f05fdb914mr6419640oab.25.1674144693310;
        Thu, 19 Jan 2023 08:11:33 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r10-20020a05687032ca00b0014ff15936casm20332063oac.40.2023.01.19.08.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 08:11:32 -0800 (PST)
Received: (nullmailer pid 1967593 invoked by uid 1000);
        Thu, 19 Jan 2023 16:11:32 -0000
Date:   Thu, 19 Jan 2023 10:11:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
Message-ID: <20230119161132.GA1880784-robh@kernel.org>
References: <20230113041115.4189210-1-quic_bjorande@quicinc.com>
 <20230117175657.GA3275060-robh@kernel.org>
 <20230118180811.GB3322341@hu-bjorande-lv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118180811.GB3322341@hu-bjorande-lv.qualcomm.com>
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

On Wed, Jan 18, 2023 at 10:08:11AM -0800, Bjorn Andersson wrote:
> On Tue, Jan 17, 2023 at 11:56:57AM -0600, Rob Herring wrote:
> > On Thu, Jan 12, 2023 at 08:11:14PM -0800, Bjorn Andersson wrote:
> > > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > 
> > > Introduce a binding for GPIO-based mux hardware used for connecting,
> > > disconnecting and switching orientation of the SBU lines in USB Type-C
> > > applications.
> > > 
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > > ---


> > > +    tcpm {
> > > +        connector {
> > > +            compatible = "usb-c-connector";
> > > +
> > > +            ports {
> > > +                #address-cells = <1>;
> > > +                #size-cells = <0>;
> > > +
> > > +                port@0 {
> > > +                    reg = <0>;
> > > +                    tcpm_hs_out: endpoint {
> > > +                        remote-endpoint = <&usb_hs_phy_in>;
> > > +                    };
> > > +                };
> > > +
> > > +                port@1 {
> > > +                    reg = <1>;
> > > +                    tcpm_ss_out: endpoint {
> > > +                        remote-endpoint = <&usb_ss_phy_in>;
> > > +                    };
> > > +                };
> > > +
> > > +                port@2 {
> > > +                    reg = <2>;
> > > +                    tcpm_sbu_out: endpoint {
> > > +                        remote-endpoint = <&sbu_mux_in>;
> > > +                    };
> > > +                };
> > > +            };
> > > +        };
> > > +    };
> > > +
> > > +    sbu-mux {
> > > +        compatible = "pericom,pi3usb102", "gpio-sbu-mux";
> > > +
> > > +        enable-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
> > > +        select-gpios = <&tlmm 164 GPIO_ACTIVE_HIGH>;
> > > +
> > > +        mode-switch;
> > > +        orientation-switch;
> > > +
> > > +        port {
> > > +            sbu_mux_in: endpoint {
> > > +                remote-endpoint = <&tcpm_sbu_out>;
> > > +            };
> > 
> > Don't you need a connection to whatever drives SBU? Maybe your case is 
> > fixed because the phy does the DP/USB muxing? But the binding needs to 
> > support the worst case which I guess would be all the muxing/switching 
> > is done by separate board level components.
> > 
> 
> Perhaps I'm misunderstanding your request, but I think this is the worst
> case you're talking about.
> 
> &usb_ss_phy_in is a reference to the PHY, which does switching/muxing of
> the SuperSpeed lanes in the connector, but the PHY provides no control
> over the SBU signals.
> 
> So this sbu-mux is a separate component between the SBU-pads on the SoC
> and the usb-c-connector, referenced through he &sbu_mux_in reference.
> 
> 
> So upon e.g. a orientation switch, the typec_switch_set() call the tcpm
> implementation will request orientation switching from port@1 and port@2
> (no orientation-switch on port@0/HS pins).

'port@2' is supposed to define the connection to what controls SBU. The 
mux here switches the signals, but it doesn't control them. The mux 
should sit in the middle, but the graph terminates at the mux. You don't 
have a connection presumably because you know what the connection. 
Perhaps because there is only 1 connector and controller.

Suppose you have 2 connectors and 2 controllers which drive SBU 
signals. Also assume that the SBU signals are completely independent 
from what's driving the altmode SS signals. How would you describe that?

Rob
