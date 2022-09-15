Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BC65B9358
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiIODiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiIODhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:37:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF89290194;
        Wed, 14 Sep 2022 20:37:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1067962081;
        Thu, 15 Sep 2022 03:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42643C43140;
        Thu, 15 Sep 2022 03:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663213043;
        bh=bPpdmFa0b0G5qqR/+F55Iemq+gPQDO/ZKeK4GM6KN/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eVEKUBEpQ68Xr8xQf73Q97Sydgh6v0J7ROumKfgfCwosFZKBlTE+al0d40JVd1kg4
         JcTKXQijk/OwG8Qz5QhDMm01xiLdLQAVsJVZhZmWvL50Hzk8o7miO0uG3c8EQeFosF
         9P7pM8oEUc0DYes03FH60z+XpKIALIkco43mAot2X+xWMki49Ssnkq0Xrx3r/H+tuj
         gsFT0/OKDuCtN+aEk4Ey/fxo0nbaaDWkMgn+Q/dSAOvkfnK1UTCCzF5PNhpD8BsoJc
         zoSu5TfntS2e9xtVdOh0aITFcHh++WojVLhNmeVAzUtRvhPy66CbLyGvyjpdhR+f5C
         Uf1iUtFa3jt8Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, lgirdwood@gmail.com,
        Bjorn Andersson <andersson@kernel.org>, bgoswami@quicinc.com,
        yassine.oudjana@gmail.com, broonie@kernel.org, tiwai@suse.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org, perex@perex.cz,
        krzysztof.kozlowski+dt@linaro.org
Cc:     alsa-devel@alsa-project.org, y.oudjana@protonmail.com,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/3] ASoC: dt-bindings: Add bindings for WCD9335 DAIs
Date:   Wed, 14 Sep 2022 22:37:04 -0500
Message-Id: <166321302051.788007.14749048847607855302.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220622161322.168017-1-y.oudjana@protonmail.com>
References: <20220622161322.168017-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022 20:13:19 +0400, Yassine Oudjana wrote:
> Add DT bindings for WCD9335 DAIs and use them in the driver as well
> as all device trees currently using WCD9335.
> 
> Changes since v1:
>  - Make header guard match path
>  - Maintain the alphabetical order in msm8996-xiaomi-gemini includes
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: Use WCD9335 DT bindings
      commit: b504af6c9912502efa9af162b50cd589351b6894

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
