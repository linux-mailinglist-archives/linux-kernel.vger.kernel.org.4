Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386B76C4E5D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjCVOog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjCVOnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:43:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA9D65461;
        Wed, 22 Mar 2023 07:42:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73989B81D18;
        Wed, 22 Mar 2023 14:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854DFC4339B;
        Wed, 22 Mar 2023 14:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496145;
        bh=83rFJOj72h2otVmPYSXMIPmjDm0T4QapKTkkaypppxc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YuBYIQMK/lDar7ae5tcTIEF2HnTBaMOnClMUEhzOm/rMZKMZ6KkwxPQ+ESEcJJ3kb
         x69abIUyX/6Ckx/517qoILiFyokYk+7ZEnl55Y3Tzp0fH/mjsEo0XtqCcDpOLmsfgG
         cIHy+nJ2X60w9k48MVWi7pHNvi3IIbENpFVUhOun8mL3UezBiTf4MouckwF0zOU3CA
         tCejyIdDAY7ZwgNDhv9lYQurJCs9A9btRvpSB4JAOTbnuzLVXMQ9oDVBJxKuj1A2fz
         zqxwMgwptvMryG7Pefa4VIWuM0TaNlrJZ7K5LMQ84opl0k3rZRiFqFVIU7zumuu7Af
         K7bYm9z1Y7MKA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: pm660: align thermal node names with bindings
Date:   Wed, 22 Mar 2023 07:45:17 -0700
Message-Id: <167949631652.1081726.3964723384805236083.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305154308.241651-1-krzysztof.kozlowski@linaro.org>
References: <20230305154308.241651-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 5 Mar 2023 16:43:08 +0100, Krzysztof Kozlowski wrote:
> Bindings expect thermal node names to end with '-thermal', so fix pm660
> and pm660l:
> 
>   sda660-inforce-ifc6560.dtb: thermal-zones: 'pm660', 'pm660l' do not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: pm660: align thermal node names with bindings
      commit: 6b056f38f07d6fe48e9c0ea9bbcf68f11c1a388b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
