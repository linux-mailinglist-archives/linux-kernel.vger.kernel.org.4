Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEC36F6DB8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjEDO37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjEDO34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:29:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7A549CA
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:29:55 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1puZxs-0002f5-I1; Thu, 04 May 2023 16:29:48 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1puZxr-0003en-HH; Thu, 04 May 2023 16:29:47 +0200
Date:   Thu, 4 May 2023 16:29:47 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     jun.li@nxp.com, Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org, andreas@fatal.se,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: usb: gpio-sbu-mux: add support for
 ss-data lanes mux
Message-ID: <20230504142947.imc3raeszxsz7xgj@pengutronix.de>
References: <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-0-3889b1b2050c@pengutronix.de>
 <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-1-3889b1b2050c@pengutronix.de>
 <168320933573.1721948.14807819257456373317.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168320933573.1721948.14807819257456373317.robh@kernel.org>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-04, Rob Herring wrote:
> 
> On Thu, 04 May 2023 15:46:50 +0200, Marco Felsch wrote:
> > This adds the support for GPIO based USB-C SS data lane muxing.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  .../devicetree/bindings/usb/gpio-sbu-mux.yaml      | 82 +++++++++++++++++++---
> >  1 file changed, 71 insertions(+), 11 deletions(-)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/usb/gpio-sbu-mux.example.dts:96.47-98.27: ERROR (duplicate_label): /example-1/tcpm/connector/ports/port@0/endpoint: Duplicate label 'tcpm_hs_out' on /example-1/tcpm/connector/ports/port@0/endpoint and /example-0/tcpm/connector/ports/port@0/endpoint
> Documentation/devicetree/bindings/usb/gpio-sbu-mux.example.dts:103.47-105.27: ERROR (duplicate_label): /example-1/tcpm/connector/ports/port@1/endpoint: Duplicate label 'tcpm_ss_out' on /example-1/tcpm/connector/ports/port@1/endpoint and /example-0/tcpm/connector/ports/port@1/endpoint
> ERROR: Input tree has errors, aborting (use -f to force output)
> make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/usb/gpio-sbu-mux.example.dtb] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1512: dt_binding_check] Error 2

While adding the example I thought about the need for it. Is it okay for
you if I drop the example since most of it is just copy'n'paste.

Regards,
  Marco
