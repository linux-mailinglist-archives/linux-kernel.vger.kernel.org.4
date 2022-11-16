Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA0862C083
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbiKPOIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiKPOHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:07:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA4F22B14;
        Wed, 16 Nov 2022 06:06:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5592261E0E;
        Wed, 16 Nov 2022 14:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129FCC433D6;
        Wed, 16 Nov 2022 14:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668607614;
        bh=0ZZmHsE+ZetUyx3SQZEkVcL6Y/AmL4g/cMMkXY/RiXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VtbMqZakYHn3Co/wX/hjghGULqHCgGdJmfDYNZIQE+CAqa1AN237fEAVvDP69b9WZ
         zFN5TTdEfILBHh6LpcNDdMU2VUJSRPNeSAlKNMUAR1WQ2/dRr9lybRxuv68QrDrVGq
         zWF//scHJ50CuA+a2Cj51yoeCA1XfqqvKuQtB19Dqg9MkugQ24GwSiq54GLkEm1SPW
         SrdpW369mu3dEMWEjGFSYIjvJ6tfaZPO3+QK25BTn4u0EGl+MIugs/ZzrH6PTQ+hWS
         MW9diP2TDQaM5kG1NpxM/+vXOLRu+J9cFVo9CKAxo01E4V5JUbY71cp8LvahIQFzV1
         lwIYzeKRRLahQ==
Date:   Wed, 16 Nov 2022 14:06:48 +0000
From:   Lee Jones <lee@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afd@ti.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: qcom,spmi-pmic: support more
 types
Message-ID: <Y3TueOD5UvRbw3WY@google.com>
References: <20221031173933.936147-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221031173933.936147-1-luca@z3ntu.xyz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2022, Luca Weiss wrote:

> * 'adc@' is either spmi-iadc or spmi-vadc
> * 'charger@' is either pm8941-charger or pm8941-coincell
> * 'usb-vbus-regulator@' is usb-vbus-regulator
> * 'vibrator@' is now in yaml format, so add it
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes since v1:
> * Change dcdc@ to usb-vbus-regulator@
> * Link to pm8xxx-vib.yaml
> 
>  .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml  | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

I fixed up the subject line for you and applied, thanks.

-- 
Lee Jones [李琼斯]
