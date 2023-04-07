Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391736DB3C8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjDGS5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjDGS53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:57:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34408E071;
        Fri,  7 Apr 2023 11:55:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0A2D64B44;
        Fri,  7 Apr 2023 18:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4C4C4339E;
        Fri,  7 Apr 2023 18:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680893687;
        bh=q2DFWXZh9VpJXrTG+i+kUw612Wl0GNl/pGZTQRJN+Uw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WkwesuhKFVqGeubL90x3xTTS3Tp6Guk7I7wF6WUTL5TOi5iUdPZKFThAdJdOnaLrD
         ijo1Ry2ww/7W3tYpmgPCqjRPMBb/t+iR9aVsPgqcgJNSI4aYcgtS1FoWuOH+uuL1SC
         jOv4rKRBxk/PwRIzWS+H3zXsAolVIDx2JomQam1iaB2nLxm5uL2WujeAiPfNX2AfKL
         xIarHE0BSLKZbd0JKVPMkYiFtdxAaGJnwvJind9PqFMYKlRlN+QJm/IMNsLlcJSS/h
         6I8YpNa2AAXcs2p/oEv6F1FtEZgflgjljfPMLopl4K85vklvccuNSC2YeJ/X5tJkk1
         1DjBnpKxABGKw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] arm64: dts: qcom: apq8016: remove superfluous "input-enable"
Date:   Fri,  7 Apr 2023 11:57:34 -0700
Message-Id: <168089385287.2679377.1753693028271734407.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230407180045.126952-1-krzysztof.kozlowski@linaro.org>
References: <20230407180045.126952-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Apr 2023 20:00:45 +0200, Krzysztof Kozlowski wrote:
> Pin configuration property "input-enable" was used with the intention to
> disable the output, but this is done by default by Linux drivers.  Since
> patch ("dt-bindings: pinctrl: qcom: tlmm should use output-disable, not
> input-enable") the property is not accepted anymore.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: apq8016: remove superfluous "input-enable"
      commit: 8624e6063cb15cc7ceeee6d54fc1761ab3d0baf7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
