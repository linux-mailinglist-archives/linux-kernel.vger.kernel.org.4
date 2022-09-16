Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB0A5BB209
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiIPSWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIPSWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:22:30 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E94A8968
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 11:22:27 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id r20so15869213qtn.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 11:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=21s3mIokPi1HbguXYtTformDqpF6+8/wpnpcqA84+18=;
        b=aYW28XOAShH4DgqCVHJ0J3MfJ4tVEwpgNUx0A624qDKd8D69tbmH6Uy4jdDSNq6vLI
         L02xpnuOVkjFgISK4nqDcYEy7mSJo2icvX2uGJu1ONncR+9RuYrdHZt5l/apVxHSO9Gt
         V6SdGs8grxqotmdQJ7FM/cwhdI51jTH/SQ9fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=21s3mIokPi1HbguXYtTformDqpF6+8/wpnpcqA84+18=;
        b=3NQ6AD5pcpxDnNqT8q02tzdHY5/yGJ6Sj4RgFOi/9U5Jpkcyji6haYgN/0vl1nZAco
         0Yl2yTJWzZ405x9QIdCWkmV8PO/TduNjSD2cOpMGy1JQkIOSy54ASKrR2plt36o6YeXg
         6KBJpmtIGY3JVyTjPR3qfUtq27kpkggijA5Sc+1LvAhrdGJUbUlBpZ8QevlgxUMdtflP
         +VdCPgJMp/cVJlXiSBdENK47rxElwTObE1TfTxRhKW50H0zKVkmyyv8VqChW7Civtinf
         1ecU8yjU3lUI5AKN26a0y1FOfMkTQU0PcpCrqLB3vBakqCfakB69iaoIFERQLQSozVh/
         KhvQ==
X-Gm-Message-State: ACrzQf3n6kXJkrKht9YKxQJHA2y3Ca0qwvnwzITqrHfIndV2DPMdaecL
        /hw7ZJXeixYI9zayCxpOXGzff+M3ICgfUramFUE2EA==
X-Google-Smtp-Source: AMsMyM7Yy+7V8SmcBWCwTKZgsSDsOmHXEw3oK4FftBX0NEWQUH3mg2HUHfuk6KX9JnRiq7Oa2G+UAiJjKARFawqsFhw=
X-Received: by 2002:a05:622a:4ce:b0:35b:417d:ab68 with SMTP id
 q14-20020a05622a04ce00b0035b417dab68mr5418502qtx.282.1663352546954; Fri, 16
 Sep 2022 11:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <CACeCKackdbDZrk5fk7qyMwSdTdzyTS=m1vHPFnQOj672W=2nOA@mail.gmail.com>
 <20220628182336.GA711518-robh@kernel.org> <CAEXTbpex9nxP-nyPWvSBchAW4j3C4MZfVHTb=5X0iSLY1bSAKg@mail.gmail.com>
 <CAEXTbpf_jxK-R5aA81FCbpAH4bChA2B9+8qExZUbA7Y+Ort=Gg@mail.gmail.com>
 <CAL_Jsq+C04RXLtm6Ac85Ru3EGwJbqV_UD3_dDWVrKvFSvdm7Ng@mail.gmail.com>
 <CAE-0n53ers881LOTCEmKDDxJQt+5vvXJSURs=o6TcOiR5m_EAw@mail.gmail.com>
 <CACeCKacJnnk4_dXEX7XiboOWrYpfAcE=ukP63agVAYUxWR9Vbg@mail.gmail.com>
 <CAE-0n50jm1ovUcBC0GCQJszk-4u+0vDQtAxHxsu9SLyn_CkQuQ@mail.gmail.com>
 <CACeCKadtmGZ5iuTHdMms6ZHGn-Uv=MbcdtqmUzqCb=5WHuPj2Q@mail.gmail.com>
 <20220712174551.GG1823936-robh@kernel.org> <YxGzk6DNAt0aCvIY@chromium.org>
In-Reply-To: <YxGzk6DNAt0aCvIY@chromium.org>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Fri, 16 Sep 2022 11:21:56 -0700
Message-ID: <CACeCKad9WtvTu_8_RfiCnkcFnagZvm+Rpx_Vrj8OORQ_=u2snQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] dt-bindings: usb: Add Type-C switch binding
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Allen Chen <allen.chen@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

On Fri, Sep 2, 2022 at 12:41 AM Prashant Malani <pmalani@chromium.org> wrote:
>
> Hi Rob,
>
> On Jul 12 11:45, Rob Herring wrote:
> >
> > That's not the right interpretation. There should not be some Type-C
> > specific child mux/switch node because the device has no such h/w within
> > it. Assuming all the possibilities Stephen outlined are valid, it's
> > clear this lane selection has nothing to do with Type-C. It does have an
> > output port for its DP output already and using that to describe the
> > connection to DP connector(s) and/or Type-C connector(s) should be
> > handled.
> > Rob
>
> Below I've listed the proposal binding (for the Type-C connector) along
> with 2 sample hardware diagrams and corresponding DT.

Any thoughts about this proposal?

>
> The updated binding in usb-c-connector would be as follows:
>
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index ae515651fc6b..a043b09cb8ec 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -183,6 +183,30 @@ properties:
>        port@1:
>          $ref: /schemas/graph.yaml#/properties/port
>          description: Super Speed (SS), present in SS capable connectors.
> +        properties:
> +          '#address-cells':
> +            const: 1
> +
> +          '#size-cells':
> +            const: 0
> +
> +        patternProperties:
> +          "^endpoint@[0-1]$":
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            description:
> +              Endpoints for the two SS lanes. endpoint@0 refers to SSTRX1 (A2,A3,B10,B11)
> +              and endpoint@1 refers to SSTRX2 (B2,B3,A10,A11).
> +            additionalProperties: false
> +
> +              properties:
> +                reg:
> +                  maxItems: 1
> +
> +                remote-endpoint: true
> +
> +              required:
> +                - reg
> +                - remote-endpoint
>
>        port@2:
>          $ref: /schemas/graph.yaml#/properties/port
>
> Here are 2 examples of how that would look on some existing hardware:
>
> Example 1. 2 usb-c-connectors connecting to 1 drm bridge / DP switch:
>
> Here is the diagram we are using on the MTK platform:
>
>                  SOC
>         +---------------------+                                              C0
>         |                     |            +----------+       2 lane      +--------+
>         |                     |            |          +---------/---------+ SSTRX1 |
>         |                     |            |          |                   |        |
>         |    MIPI DPI         |            |          |  2 lane           |        |
>         |                     +------------+ ANX 7625 +---/-----+    +----+ SSTRX2 |
>         |                     |            |          |         |    |    +--------+
>         |                     |            +----------+         |    |
>         +---------------------+                                 |    |
>         |                     |            +----------+ 2 lane  |    |       C1
>         |                     |            |          +----/----C----+    +--------+
>         |    USB3 HC          |   2 lane   |          |         |         | SSTRX1 |
>         |                     +-----/------+ USB3 HUB |         +---------+        |
>         |  (host controller)  |            |          |       2 lane      |        |
>         |                     |            |          +---------/---------+ SSTRX2 |
>         +---------------------+            |          |                   |        |
>                                            +----------+                   +--------+
>
> Some platforms use it6505, so that can be swapped in for anx7625
> without any change to the rest of the hardware diagram.
>
> From the above, we can see that it is helpful to describe the
> Type-C SS lines as 2 endpoints:
> - 1 for SSTX1+SSRX1 (A2,A3 + B10,B11)
> - 1 for SSTX2+SSRX2 (B2,B3 + A10, A11)
>
> A device tree for this would look as follows:
>
> // Type-C port driver
> ec {
>     ...
>     cros_ec_typec {
>         ...
>         usb-c0 {
>             compatible = "usb-c-connector";
>             ports {
>                 hs : port@0 {
>                     ...
>                 };
>                 ss: port@1 {
>                     reg = <1>;
>                     c0_sstrx1: endpoint@0 {
>                         reg = <0>;
>                         remote-endpoint = <&anx7625_out0>;
>                     };
>                     c0_sstrx2: endpoint@0 {
>                         reg = <0>;
>                         remote-endpoint = <&usb3hub_out0>;
>                     };
>                 };
>                 sbu : port@2 {
>                     ...
>                 };
>             };
>         };
>         usb-c1 {
>             compatible = "usb-c-connector";
>             ports {
>                 hs : port@0 {
>                     ...
>                 };
>                 ss: port@1 {
>                     reg = <1>;
>                     c1_sstrx1: endpoint@0 {
>                         reg = <0>;
>                         remote-endpoint = <&anx7625_out1>;
>                     };
>                     c1_sstrx2: endpoint@0 {
>                         reg = <0>;
>                         remote-endpoint = <&usb3hub_out1>;
>                     };
>                 };
>                 sbu : port@2 {
>                     ...
>                 };
>             };
>         };
>     };
> };
>
> // DRM bridge / Type-C mode switch
> anx_bridge: anx7625@58 {
>     compatible = "analogix,anx7625";
>     reg = <0x58>;
>     ...
>     // Input from DP controller
>     port@0 {
>         reg = <0>;
>         ...
>     };
>
>     // Output to Type-C connector / DP panel
>     port@1 {
>         reg = <1>;
>
>         anx7625_out0: endpoint@0 {
>             reg = <0>;
>             mode-switch;
>             remote-endpoint = <&c0_sstrx1>;
>         };
>         anx7625_out1: endpoint@1 {
>             reg = <1>;
>             mode-switch;
>             remote-endpoint = <&c1_sstrx1>;
>         };
>     };
> };
>
> // USB3 hub
> usb3hub: foo_hub {
>     ...
>     ports@0 {
>          // End point connected to USB3 host controller on SOC.
>     };
>     port@1 {
>         reg = <1>;
>
>         foo_hub_out0: endpoint@0 {
>             reg = <0>;
>             mode-switch; ---> See c.) later
>             remote-endpoint = <&c0_sstrx2>;
>         };
>         foo_hub_out1: endpoint@1 {
>             reg = <1>;
>             mode-switch;
>             remote-endpoint = <&c1_sstrx2>;
>         };
>     };
> };
>
> Notes:
> - On the Chrome OS platform, the USB3 Hub is controlled by
> the EC, so we don't really need to describe that connection,
> but I've added a minimal one here just to show how the graph
> connection would work if the HUB was controlled by the SoC.
> - The above assumes that other hardware is controlling orientation.
> We can add "orientation-switch" drivers along the graph path
> if there is other hardware which controls orientation.
>
> Example 2: 1 USB-C connector connected to 1 drm-bridge/ mode-switch
>
> I've tried to use Bjorn's example [1], but I might have made
> some mistakes since I don't have access to the schematic.
>
>
>                   SoC
>   +------------------------------------------+
>   |                                          |
>   |  +---------------+                       |
>   |  |               |                       |
>   |  |  DP ctrllr    |       +---------+     |                 C0
>   |  |               +-------+         |     |   2 lane     +----------+
>   |  +---------------+       |  QMP    +-----+-----/--------+ SSTRX1   |
>   |                          |  PHY    |     |              |          |
>   |  +-------------+  2 lane |         |     |   2 lane     |          |
>   |  |             +----/----+         +-----+-----/--------+ SSTRX2   |
>   |  |    dwc3     |         +---------+     |              |          |
>   |  |             |                         |              |          |
>   |  |             |         +---------+     |              |          |
>   |  |             +---------+ HS PHY  |     |   HS lanes   |          |
>   |  +-------------+         |         +-----+----/---------+ D +/-    |
>   |                          |         |     |              +----------+
>   |                          +---------+     |
>   |                                          |
>   +------------------------------------------+
>
> The DT would look something like this (borrowing from Stephen's example [2]):
>
> qmp {
>     mode-switch; ----> See b.) later.
>     orientation-switch;
>     ports {
>         qmp_usb_in: port@0 {
>             reg = <0>;
>             remote-endpoint = <&usb3_phy_out>;
>         };
>         qmp_dp_in: port@1 {
>             reg = <1>;
>             remote-endpoint = <&dp_phy_out>;
>         };
>         port@2 {
>             reg = <2>;
>             qmp_usb_dp_out0: endpoint@0 {
>                 reg = <0>;
>                 remote-endpoint = <&c0_sstrx1>;
>             };
>             qmp_usb_dp_out1: endpoint@1 {
>                 reg = <1>;
>                 remote-endpoint = <&c0_sstrx2>;
>             };
>         };
> };
>
> dp-phy {
>     ports {
>         dp_phy_out: port {
>             remote-endpoint = <&qmp_dp_in>;
>         };
>     };
> };
>
> dwc3: usb-phy {
>     ports {
>         usb3_phy_out: port@0 {
>             reg = <0>;
>             remote-endpoint = <&qmp_usb_in>;
>         };
>     };
> };
>
> glink {
>     c0: usb-c-connector {
>         compatible = "usb-c-connector";
>         ports {
>             hs: port@0 {
>                 reg = <0>;
>                 endpoint@0 {
>                     reg = <0>;
>                     remote-endpoint = <&hs_phy_out>;
>                 };
>             };
>
>             ss: port@1 {
>                 reg = <1>;
>                 c0_sstrx1: endpoint@0 {
>                     reg = <0>;
>                     remote-endpoint = <&qmp_usb_dp_out0>;
>                 };
>                 c0_sstrx2: endpoint@1 {
>                     reg = <1>;
>                     remote-endpoint = <&qmp_usb_dp_out1>;
>                 };
>             };
>         };
>     };
> };
>
> Notes:
> a. This proposal doesn't deal with the DRM bridge HPD forwarding; I
> believe that is covered by Stephen's example/proposal in [2], and
> can be addressed separately. That said, this binding is compatible
> with the proposal in [2], that is, make the "mode-switch" driver a
> drm-bridge and forward the HPD info to the upstream DRM-bridge (DP controller).
> The driver implementing "mode-switch" will be able to do that, since
> it gets DP status/attention VDOS with HPD info from the Type-C port driver.
> b. If both SSTRX pairs from a connector are routed to the same
> hardware block (example 2) then the device would keep "mode-switch"
> as a top level property (and the fwnode associated with "mode-switch"
> is the drm-bridge device).
> c. If SSTRX pairs from 2 connectors are routed to the same
> hardware block (example 1), then each end-point which is connected to
> the USB-C connector will have a "mode-switch" property in its end-point.
> There will be 2 mode switches registered here, and the fwnode for each
> "mode-switch" is the end-point node.
>
> b.) and c.) can be handled by Type C mux registration and matching
> code. We already have 3 mux devs for each mux [3].
>
> For the single mode-switch case, mux_dev[1] will just refer to the top-level
> mode-switch registered by the DRM bridge / switch driver (example 1).
> For the 2 mode-switch case, typec_mux_dev[1] will have 2 child
> typec_mux_dev's, each of which represents the mode-switches
> registered by the DRM bridge / switch driver. Introducing this
> indirection means the port driver / alternate mode driver don't
> need to care about how the connectors are routed; the framework
> will just call the mux_set() function on the mux_dev() or its
> children if it has any.
>
> The benefit of this approach is existing bindings (which just
> assume 1 endpoint from usb-c-connector/port@1) should continue to
> work without any changes.
>
> Why don't we use data lanes for the usb-c-connector
> endpoints? I guess we could, but I am not a fan of adding the
> extra data-lane parsing logic to the Type-C framework (I
> don't think drivers need that level of detail from the connector
> binding). And even then, we will still need an extra end-point
> if the lanes of the USB-C connector are routed to different hardware blocks.
>
> The Type-C connector spec doesn't specify any alternate modes
> with < 1 SSTRX pair, so the most we can ever have (short of a
> major change to the spec) is 2 SSTRX end points for a
> connector each being routed to different hardware blocks.
> Codifying these as endpoint@0 and endpoint@1 in the usb-c-connector
> binding seems to line up nicely with this detail of the spec.
>
> Thanks,
>
> -Prashant
>
> [1] https://lore.kernel.org/linux-usb/Yv1y9Wjp16CstJvK@baldur/
> [2] https://lore.kernel.org/linux-usb/CAE-0n52-QVeUVCB1qZzPbYyrb1drrbJf6H2DEEW9bOE6mh7egw@mail.gmail.com/
> [3] https://elixir.bootlin.com/linux/v6.0-rc3/source/drivers/usb/typec/mux.c#L259
