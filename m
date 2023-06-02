Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAE171FB89
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbjFBIHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbjFBIHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:07:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB6CD3;
        Fri,  2 Jun 2023 01:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B34C660F29;
        Fri,  2 Jun 2023 08:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F132C433D2;
        Fri,  2 Jun 2023 08:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685693219;
        bh=3I5CwM0h7zM2RpqeipzAicM8qi8sXEOoMLfEVMaOBiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qKEdr7hYIE2TEU5V+/owMIpIc7uOBuYb/UzWNkgVPQBNDVIZeR3x7a7Il2LzAESC4
         PUhrg2WUwMnPf9V0fgyExDIqgImzXzwal+0BD9+qyNwpY0Zj55YjQGOafvGqSwVd7I
         I/bddeUQjy6uhu4CnZWe/r/ByPyxI1w2jl3eWRdSyceBh+1HfqJpCfERhZg1OJ7PIB
         3Iy4+r615dW8ZLCc/0CyZXFp7Jsxu78RdeMX0kEtTanSiQh4ycIjEj9sdx0h6RekOr
         JkFeFKuCmz35a6Jq6uUOC8DW+GNHMui1mcNXIHZFX69y7A4eQQqqxDPhx7/nbRmnlC
         P/5NuCpPsHt/Q==
Date:   Fri, 2 Jun 2023 09:06:55 +0100
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Vladimir Barinov <v.barinov@yadro.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux@yadro.com,
        linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/2] dt-bindings: leds: Document Awinic AW2016 bindings
Message-ID: <20230602080655.GN449117@google.com>
References: <20230524113910.196321-1-v.barinov@yadro.com>
 <20230524114056.196518-1-v.barinov@yadro.com>
 <168493088788.3462735.2834416618033227181.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <168493088788.3462735.2834416618033227181.robh@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023, Rob Herring wrote:

> 
> On Wed, 24 May 2023 14:40:56 +0300, Vladimir Barinov wrote:
> > Add Awinic AW2026 binding documentation
> > 
> > Signed-off-by: Vladimir Barinov <v.barinov@yadro.com>
> > ---
> >  .../bindings/leds/awinic,aw2026.yaml          | 92 +++++++++++++++++++
> >  1 file changed, 92 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/awinic,aw2026.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/leds/awinic,aw2026.example.dts:52.3-53.1 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/leds/awinic,aw2026.example.dtb] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1512: dt_binding_check] Error 2

Taking this set out of my review queue until this is rectified.

-- 
Lee Jones [李琼斯]
