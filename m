Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A5D737BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjFUHEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFUHEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:04:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068BC10FB;
        Wed, 21 Jun 2023 00:04:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96F8161484;
        Wed, 21 Jun 2023 07:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027CCC433C8;
        Wed, 21 Jun 2023 07:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687331039;
        bh=aCXNvBbGN7pPK5koTOHF3M4Z68BI9UMBxyPP5ZFnl3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uwpoNgSTATgL3Wvlqmz0vG/f0IeJ4DVM1UJ8iixChI9TCH1k9nThl5efamiClfI7U
         AOFtILAjo28KIECc+JimCpav+lSEKGDKOkp1Xnu1oXW2bHek/Mqj0F/mT1usP+OUq6
         TVUgeV7ug5KB3Mv/swy3CU8BcIxhEqzQqoSdQgZFuIKlJHMQGEbcmoX6zN2RcVd9Gh
         gfvNnM+ufX3IOqZFs19z+xKZNZL3ZqApp0/boLOzkFfOjsvpy1IH9NAUXW6fpyKd8r
         84q7XwFs3Hln/A26YQhR3TVtGf/bFWmdsbdIiPzgVzNB6Omg+qexDoWBU0b/Nnr5U+
         FAdxdL+JbnfuQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qBrsn-0005Yz-CX; Wed, 21 Jun 2023 09:04:01 +0200
Date:   Wed, 21 Jun 2023 09:04:01 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sc8280xp-crd: Correct
 vreg_misc_3p3 GPIO
Message-ID: <ZJKg4XJHlgWGGNiZ@hovoldconsulting.com>
References: <20230620203915.141337-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620203915.141337-1-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 01:39:14PM -0700, Bjorn Andersson wrote:
> The vreg_misc_3p3 regulator is controlled by PMC8280_1 GPIO 2, not 1, on
> the CRD.
> 
> Fixes: ccd3517faf18 ("arm64: dts: qcom: sc8280xp: Add reference device")
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

The old off-by-one again. Both of these are apparently configured as
outputs and driven high by the boot firmware.

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan
