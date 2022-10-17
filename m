Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA240601D69
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiJQXMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiJQXMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:12:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAFF1C409;
        Mon, 17 Oct 2022 16:11:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57C6FB81B97;
        Mon, 17 Oct 2022 23:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAE8C433C1;
        Mon, 17 Oct 2022 23:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666047878;
        bh=Vf3xA5TrinOrw9G35eyRU2BxOfP7zSWhAKDNIu7HvqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I6d3EAaXDjt+T+tJgKO/Bvh+DDA+FqHPnCb6zpxnrfR5DxUEFSiWidPGgZCEUQNVD
         dzKRBcckSvrAqMd2mxBRpucSiaVMDiIiTrtrJHcQH84u/CXuwXuLU3O79bloWaLpSB
         ydfDJTe3vg0waZrzdniibl8gkAuEyDuVr02pXMJa9HPI0g7MIBuElb1IceoG5i/F4Y
         OoPzshq7EmJ/bp40UkcTeTN5E3Nfi8gSEWkxaUCGlOBH3B1tBdm2BgXrwAXNRZG4PD
         lyCeSC8484fV/2IHC+IVMCAIG7EZh9GxWazwL3SWmI+ZJ3RXe3k+BWsioS7duT3wqY
         qfSURtKFb0rqg==
Date:   Mon, 17 Oct 2022 18:04:36 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Caleb Connolly <caleb@connolly.tech>
Cc:     Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/7] arm64: dts: qcom: sdm845-cheza: commonize uart6
 pinconf
Message-ID: <20221017230436.227x62q6ftnmtfbh@builder.lan>
References: <20221016143300.1738550-3-caleb@connolly.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221016143300.1738550-3-caleb@connolly.tech>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 02:33:53PM +0000, Caleb Connolly wrote:
> -----BEGIN PGP MESSAGE-----
> Version: ProtonMail
> 
> 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
> =lHx9
> -----END PGP MESSAGE-----

Can you please resubmit this in a way that I can read it, with
cover-letter and proper threading?

(Or let me know what I'm doing wrong when trying to look at these
patches?)

Thanks,
Bjorn
