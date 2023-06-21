Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB56D737C20
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjFUHIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjFUHHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:07:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011B91704;
        Wed, 21 Jun 2023 00:07:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 921186148F;
        Wed, 21 Jun 2023 07:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EAFC433C0;
        Wed, 21 Jun 2023 07:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687331274;
        bh=kN+4TA7hOi5aHNRfw/fpGeCplr4/QRLv8TMeQlLQpXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BTQkhk0mIay5EeH9GTQe6bvPrjgIfDdIsjHsUIzcV4AA9YzNSAUmwkKLaxQ41K0tS
         JOlfHUKN5VDDwlWmLx6EFJPfdzK4kGR9ajPuSTe/JKe+NgTSGeagOeW3rpCngOYRth
         e3etVlRFgdLyWKkk18sUyheDd9raxlka5vdGVf9Yc6Pyzra+gSt/OzoqALYnmF8V4w
         NMjiiWeQw7BEE2aj5yyLQA/0/hmRYdGNZARAkz3FoeR4zZahsNnLGNEHoyBWEvEcfG
         TlG4d27XbL+xJ6tPHdDe9qjffKfk4kqgCUFg0n3zyNUcnJFCmYbGzZFYeLRHPmnZTs
         OvgW0qIiEQ7Tw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qBrwa-0005ay-Iy; Wed, 21 Jun 2023 09:07:56 +0200
Date:   Wed, 21 Jun 2023 09:07:56 +0200
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
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc8280xp-crd: Fix naming of
 regulators
Message-ID: <ZJKhzApSUfUCY3qI@hovoldconsulting.com>
References: <20230620203915.141337-1-quic_bjorande@quicinc.com>
 <20230620203915.141337-2-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620203915.141337-2-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 01:39:15PM -0700, Bjorn Andersson wrote:
> The external regulators in the CRD seems to have inherited their names
> from the X13s DeviceTree, correct them.

Yeah, without access to the schematics that's a guess as good as
anything. Fortunately, you're there to dig out the names. :)

> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
