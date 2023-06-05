Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF247221F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjFEJUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjFEJUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:20:18 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DF5DB;
        Mon,  5 Jun 2023 02:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685956808; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=m4uRcZTdGpY6O23Yo0XI9B+fj1vW+KPTQMgxYCjub+eUGbiVVjTDGJ5jhCz6NyCAW7
    iQwx0rqVW/e9nHEG9RTN4onp3G3P4s8bl4YEhRg8AfYu/bPm69Y++7wYsSG8nles6Jml
    uXQ1URGDCs49PsVQ26HG/vcifmd5W82tVZIV2P0WMfkOH/OUGW9a3ytBG66LmgrbzhfY
    eeyrkO7XdaFTPE52MkY4Dsi0UwXSF2oLsquCl7bbdtJLrVMIPb57S6YR+3heMrLkGFVy
    mT1GTeUG19itnHWU6BryK0Wp3Hm9wNHm0tXrmk3f4msU/yXsumy8u5GPrVU/x0ytelv3
    zZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685956808;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=MlXEhXVts0zXguUGPAgythd13QOVvJ80llw2yo6ICys=;
    b=CR0jKlurcILZmEpNRWFW3tcXFFxiwTCi2vEv7ozBgTl7pq6lArZlaftMoJvQotCpTK
    80wtr3FyBZG1B1kkWYT5+aPvK6H0/9ZOTOiUyGHyvVWMySRdbMXQkPOoVGCtdI8pUxW1
    cBPhspcnHguaopqHxg/gjVAnl7gHN4IeQaOiRfVVuk69/OcvIqLD678Z3K8/xicQbura
    45ynJu98mpPxBmYceD2i5NkpygIOJAd+7WP1u+yCs/YlCRASus6ox3XqOKl+6vGR+2wi
    LG9dlNhDomJqREnxkbC9IZO3kr5xtG4e8Vt/P6YzggVKyg55aE+emr8zZK41FN+X/V8p
    dC9w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685956808;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=MlXEhXVts0zXguUGPAgythd13QOVvJ80llw2yo6ICys=;
    b=T9kmbRniu6zkkvfB6h2cC+UgctOIBskfAN23RmW5kx2pylZv6sgBGBwYoWe9UbFiFQ
    Wag2evxe0ScFuooQHWKTbVVRSuXBxbgjCp6NkK9HrsGg6/JFDBMJ2IUK/sE4SZKMfCjB
    31wAHih9vJ8ZoOxwqQ/crOiCsd8I7hOZT5o65yXVGA/vywKEpNw4W+lDwRmk+5kfC1W/
    pY5LN5iW1MfjwrmwLzCIYs32uiG7FybdDzaPFPNWZl6XZ6hHPHJMBK0XH79bmRRH74Qg
    8DPZzFGL4rsKTyrkXPbUqK69DiHrRgax/qtvjrZGff4CHZWqM4bHM6rxR/kCADSjFvwa
    lluA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685956808;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=MlXEhXVts0zXguUGPAgythd13QOVvJ80llw2yo6ICys=;
    b=ntCEvpxhroMHANwwBpmJz3BUQHmMwjPEo+tyBiV3N7GnNkFqNe7m4l5S8AGqjoWDJr
    mxE7qjverPZvdaW0wkBA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z+J1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z559K89S5
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 5 Jun 2023 11:20:08 +0200 (CEST)
Date:   Mon, 5 Jun 2023 11:20:07 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH 06/14] dt-bindings: soc: qcom: smd-rpm: Use qcom,rpm-proc
 in example
Message-ID: <ZH2ox9ZaGPDR-Xvt@gerhold.net>
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
 <20230531-rpm-rproc-v1-6-e0a3b6de1f14@gerhold.net>
 <168595403816.208946.12766625011186229177.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168595403816.208946.12766625011186229177.robh@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 02:33:58AM -0600, Rob Herring wrote:
> On Mon, 05 Jun 2023 09:08:22 +0200, Stephan Gerhold wrote:
> > Use the new top-level rpm-proc node instead of having a dummy top-level
> > /smd node that only contains the RPM but not other remote processors.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> >  Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.example.dtb: /example-0/remoteproc-rpm: failed to match any schema with compatible: ['qcom,msm8916-rpm-proc', 'qcom,rpm-proc']
> 

Huh? The schema that matches this compatible is in the previous patch. :)
Perhaps this error is related to the dt_binding_check problem on the
patch before (which is caused by applying the patches to the wrong base
branch).

Before sending this series I verified that there are no dt_binding_check
and dtbs_check warnings or errors when applied to the correct branch.

Thanks,
Stephan
