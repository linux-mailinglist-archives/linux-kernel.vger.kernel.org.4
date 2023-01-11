Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3325C665FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbjAKPxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjAKPxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:53:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD4FBED;
        Wed, 11 Jan 2023 07:53:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B03361D79;
        Wed, 11 Jan 2023 15:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700B9C433D2;
        Wed, 11 Jan 2023 15:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673452402;
        bh=rr5zFASVU5f5em14U4Ba7dIwrNEf/QsASthAq60dq/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yvyp8KEgEx2hMeaFHEZlur6pkMY/2sOpoDYaLqZZsyojp+PaIhig1NLQJB6tDcUp3
         rxS2dsaHnEG51rwe1GrKoEXIKM7R1t7aC+4c7mcaI0mBVpqGKlcaTevOp9xKwHVeYY
         Z8UzVcXHdvhSBhjVORm12alZkbSdqdxHQpEoROk89FgEyKUPJ/x1JZIfMachRZSHgJ
         snluqhDrWwNBKd1lYRroRwVfMK21LW/daZjudGIoBKHZ+CnXpHTRJ0AEoBdb7wtZhH
         /vTklZmifqezfYbNdEhpgEGuYQ9qa6VmH4M/1n5SLGvA/o6gDDoxD81BOjlOQ3DVY1
         bNZcohMZd2nbQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pFdPq-0001bf-Qz; Wed, 11 Jan 2023 16:53:26 +0100
Date:   Wed, 11 Jan 2023 16:53:26 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Eric Chanudet <echanude@redhat.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sa8450p-pmics: add missing
 interrupt include
Message-ID: <Y77bdsMNxO1ZvPg9@hovoldconsulting.com>
References: <20230111082331.20641-1-johan+linaro@kernel.org>
 <20230111082331.20641-2-johan+linaro@kernel.org>
 <20230111150619.2g737hldisyhceri@echanude>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111150619.2g737hldisyhceri@echanude>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 10:06:19AM -0500, Eric Chanudet wrote:
> On Wed, Jan 11, 2023 at 09:23:30AM +0100, Johan Hovold wrote:
> > Add the missing interrupt-controller include which is needed by the RTC
> > node.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Reviewed-by: Eric Chanudet <echanude@redhat.com>
> 
> Nit: sa8450p-pmics -> sa8540p-pmics in the subject. It was mistyped in
> the commit renaming the file unfortunately.

Ah, good catch. I'll resend with that fixed. Thanks.

Johan
