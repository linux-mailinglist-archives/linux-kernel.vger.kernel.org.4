Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64411644B72
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiLFSVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiLFSUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:20:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8F9B4AA;
        Tue,  6 Dec 2022 10:20:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76E44B81B32;
        Tue,  6 Dec 2022 18:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A08C43143;
        Tue,  6 Dec 2022 18:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350806;
        bh=YTFPQTx/YrLchW/aZDupJW4/hX85sZqlpGLQlhNNLLU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MvEe/hknFqdvcLrCjmFXzJTUtplFCf2YZ45f+y+1rzgntxjc9M5xsSgQQYU3ki42R
         Fueb7CvmFRSpoyrUPjJm5PIlbc9llNfzxqhlcq464VWZfor191SSLv3gtVN23cCr5M
         ccMSocX73pg8NCDi+c0FJGaWdh9rjSA5RJm4Tcofnpfy0IC5VRGi+bx+gAzdLp0bKT
         SZ+1iUw0x2q8R+kmUJb+S2YBbGKS4/a97W1qYdAxP3dxjrMS6SmTNAi2s8xYAFZtMH
         IzQlk0bXP03NT0lgapvc9tovY7cGqoeCLlLrDUu3+eaCleDn6ZMuXtRt3LmYCHRUz/
         oS23Tip7kbhmw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: qcom,spmi-vadc: simplify compatible enum
Date:   Tue,  6 Dec 2022 12:19:11 -0600
Message-Id: <167035076359.3155086.2312319219959247926.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221027143411.277980-1-krzysztof.kozlowski@linaro.org>
References: <20221027143411.277980-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 27 Oct 2022 10:34:10 -0400, Krzysztof Kozlowski wrote:
> The second compatible item in oneOf is just an enum, not a list.
> 
> 

Applied, thanks!

[1/2] dt-bindings: iio: adc: qcom,spmi-vadc: simplify compatible enum
      (no commit info)
[2/2] dt-bindings: iio: adc: qcom,spmi-vadc: extend example
      commit: 74e903461b178faa5d0873254b77ee18fca5d059

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
