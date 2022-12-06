Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5408A644B71
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiLFSVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiLFSUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:20:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18B2AE4D;
        Tue,  6 Dec 2022 10:20:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86BEA616C6;
        Tue,  6 Dec 2022 18:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD56C433D6;
        Tue,  6 Dec 2022 18:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350808;
        bh=I1Xd2WNg5Rk0ZL/CxH/TW0kPfYLSpjTjCQHtAALsm70=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JR/YDHkRzSzpRhSEWvKDpApK9FVbNAWD4TOys8RDgSvev/12cyKb0JqekbD5tSIUc
         2e99cKWze6TcDiURDHyNaJF5Ll1tvG3qqlMAaR3LYh2ECftgaxZvCSrV39rytOIJdI
         oVX0D73YtHoEqVM15ry2OdlSMcamhZXUtHJYhV/FrfDD32rSAGv96Py8GF3VdjNbfo
         pekMYsNv0nUN1BAnsIQJ1XBfXx4gIP4gmi/BurLzkDwzebaAURisU/rsPjaxEDDtH8
         9T+DjTouwnO5w98yRtUr2WPdyFX9826YSAdjMFugCdjP5Tov9kD0kowklRej+sTfT5
         5cTnNF65gzWVQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: (subset) [PATCH 2/2] dt-bindings: iio: adc: qcom,spmi-vadc: extend example
Date:   Tue,  6 Dec 2022 12:19:13 -0600
Message-Id: <167035076359.3155086.7047590726633000099.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221027143411.277980-2-krzysztof.kozlowski@linaro.org>
References: <20221027143411.277980-1-krzysztof.kozlowski@linaro.org> <20221027143411.277980-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2022 10:34:11 -0400, Krzysztof Kozlowski wrote:
> Cleanup existing example (generic node name for spmi, use 4-space
> indentation) and add example for ADCv7 copied from
> Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml.
> 
> 

Applied, thanks!

[2/2] dt-bindings: iio: adc: qcom,spmi-vadc: extend example
      commit: 74e903461b178faa5d0873254b77ee18fca5d059

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
