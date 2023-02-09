Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4C968FF07
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjBIEcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjBIEbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:31:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510003F281;
        Wed,  8 Feb 2023 20:31:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B67FCB81FF2;
        Thu,  9 Feb 2023 04:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B02DC4339C;
        Thu,  9 Feb 2023 04:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916507;
        bh=OHLpBrJ0hjdIxLyMLRBE1hql53zytqHQsAHsFhOj2ME=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UIJmL7tPxuLhruaMSzbR1oY/iqNyz2uHD4HmzzM6OHBMmnLZrUafkQVmtub3S2+E/
         f14PJX91JWGyfGoEiOTwXy/IcB73lbyYDqPlRjxtG5aSBZ9qIWkCUNT/VG995kaaGl
         kuMJ/AiFoOJHiAhMrxeZy4hQAf6fuwBiY2pWb0auguriE2j6aPSBUdS+8MCpfT+iPK
         vpEGQqOuGj0kabvzRVtkF29U7om0oJTxpPB9a0UjA9vCrZ15Pq/XbRaS28CthPOfzw
         uHoiKAWOgncH81tvCRrzkycwffi0CxiDk1kYCo536odggB8WkVf2q9nsWFncLfXQuY
         JgeFhda8hMqvg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, linux-gpio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 1/3] arm64: dts: qcom: sm8350-hdk: align pin config node names with bindings
Date:   Wed,  8 Feb 2023 20:23:03 -0800
Message-Id: <167591660370.1230100.8387648997702407659.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201154321.276419-1-krzysztof.kozlowski@linaro.org>
References: <20230201154321.276419-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 1 Feb 2023 16:43:19 +0100, Krzysztof Kozlowski wrote:
> Bindings expect pins to be named with certain pattern.
> 
> 

Applied, thanks!

[1/3] arm64: dts: qcom: sm8350-hdk: align pin config node names with bindings
      commit: 9927f8a59f42b6c0bde9ba770ffe9d9d9bce79da
[2/3] arm64: dts: qcom: sm8350-hdk: correct LT9611 pin function
      commit: cd06d923304355762d426b030a30d99fdf765b84

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
