Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A4A64B983
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbiLMQWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbiLMQV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:21:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35433218A4;
        Tue, 13 Dec 2022 08:21:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEB21615DB;
        Tue, 13 Dec 2022 16:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC71AC433EF;
        Tue, 13 Dec 2022 16:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670948518;
        bh=Jk85M6LBW3nYMcfFJnJRi+cnyvWHxdySu0OtkbTJtqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HDlhvcn+PZXyb6Wblwz3d1R3uGiy7rey5CJRz1fBELd4XzT3rMmdh5rs7PDsDHDbP
         Oedvmp8l8ua+Fs8U+nof3cLEk/NIrXSbTVJQlNbkR3RrC3Tc7YJtviivQR3tVaiz51
         V6SpILsaBpTFiPVS51k9sRilAs/Ii6nrH0zfcZt7Jzy15yVRc8K2t1OgvsELKmrI6S
         tGG9ybDu0Fyv3Ck7DuGeYkYxyuASMxixknSmZ7g/dxgfSVgKw/c0x8KPDP/KxAuFLY
         SKEQft681VGwGRrowJyIaXXguRK5zSoJ38RT5xssNKbCSo0ZnbioTWHMnD2NVw7dd5
         U5B2CCn67ds7A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p582y-0005rW-39; Tue, 13 Dec 2022 17:22:24 +0100
Date:   Tue, 13 Dec 2022 17:22:24 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc8280xp: rename i2c5 to i2c21
Message-ID: <Y5imwEsHGdSc/z4L@hovoldconsulting.com>
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-2-bmasney@redhat.com>
 <Y5iSDehp72mQPc+h@hovoldconsulting.com>
 <Y5iXjTQnEtMCZy7W@hovoldconsulting.com>
 <114e960f-3b63-8c8f-9d4a-87173049d730@linaro.org>
 <Y5ibG29yKQgD54Dn@hovoldconsulting.com>
 <Y5ihczgZs1RBJ0IN@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5ihczgZs1RBJ0IN@x1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 10:59:47AM -0500, Brian Masney wrote:

> I noticed another inconsistency with sc8280xp.dtsi compared to other
> platforms. I left off all of the pin mappings in sc8280xp.dtsi and
> added them to the sa8540-ride.dts file since the existing sc8280xp.dtsi
> file contains no pin mappings. Other platforms such as sm8450.dtsi,
> sm8350.dtsi, and sm8250.dtsi contain the geni pin mappings. My
> understanding is that these geni pins are fixed within the SoC and
> don't change with the different boards. Should I also add the geni
> pin mappings to sc8280xp.dtsi?

The pins are fixed but the pin configuration is still board specific.

This came up earlier and we decided that keeping all pin configuration
in the board dts was the way to go (e.g. for consistency and as it
allows the integrator to easily review the actual configuration).

Johan
