Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9586DDDAD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjDKOXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjDKOXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:23:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C611981;
        Tue, 11 Apr 2023 07:23:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF090622B8;
        Tue, 11 Apr 2023 14:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D67C433EF;
        Tue, 11 Apr 2023 14:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681223009;
        bh=RYp9PSxqskSUe2q+xTZXJgu3eD5j3kMspk1QMyArBVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EZW4+YMK9xErYZ677MSbj6zEmKjeL567xcJXBQ2dLLi7+OZgFxoka8ZhybWB0FTIZ
         Mx/21y40YfNKTOu715BWXXRiGF9WcjOo1Ta60ueNAvKlEiQSCd7E1gemdDVR/fbmdD
         YsCCfLgwkzQCeBe1869hulrjfJBG2OS9om3wGuQH9WpkjXQ0Lah/k4wXWyLne7Mm+M
         hnBbwIVOoeNGuJP3iUeNVxEW10Kwh+jtz03X2lyaeTIgrw2zoKwNp91aGdM+GRoyVz
         mduSQ1RARZ1/NbrID228mp/SlPV0GK3u56noWFaq1mj/8VOgPHKW3iypspNXAxHHc/
         1FcTJ7z3Ye+yA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pmEu6-0005Lc-5e; Tue, 11 Apr 2023 16:23:26 +0200
Date:   Tue, 11 Apr 2023 16:23:26 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-lenovo-thinkpad: correct pin
 drive-strength
Message-ID: <ZDVtXkCON8DFUDjh@hovoldconsulting.com>
References: <20230407180710.128815-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407180710.128815-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 08:07:10PM +0200, Krzysztof Kozlowski wrote:
> Fix typo in drive-strength property name.

In the future, please try to use the established commit-summary prefix.
In this case:

	arm64: dts: qcom: sc8280xp-x13s:

Johan
