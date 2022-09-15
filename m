Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217A45B9343
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiIODhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiIODhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:37:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A34901AB;
        Wed, 14 Sep 2022 20:37:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C221FB81D84;
        Thu, 15 Sep 2022 03:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769E6C433C1;
        Thu, 15 Sep 2022 03:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663213032;
        bh=Gb7t8DiH7SOhhau6IWe9thIcIHW6pfAjHKJqNetuUHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EOnnpxSeD1il8bNSK66nnMYDooGtB7mwUiRrmPZHqYgk0tF4iN9W08Ta5ORUc2phH
         KD0ESXUd5gAWB3MdSeK0SJfRbBkOvkWPVlTW9TMN1YyrguGzn2vwTwb08kKJLLTSZ5
         3VjGSbViJ5FO6VZz1ZoOfhWzSaAOk07P0j/pzkU2KWvltwE26ZP/Qnw840U6hP7F2+
         lCrtwr0o9T6hqQX2SYt1t8schzsp24DjGuG0TRD989wNxLYQMgjBfLU4kCm0D5XjKF
         GLxdDmaG5q1TZMF1vDdusA03OFHHyVyG5OHeszMH9A0EA3lWs7ATmtvCis+lKt7K2X
         FahWQAg3ioenw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ~postmarketos/upstreaming@lists.sr.ht, konrad.dybcio@somainline.org
Cc:     agross@kernel.org, angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, rnayak@codeaurora.org,
        jamipkettunen@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        martin.botka@somainline.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] dt-bindings: power: rpmpd: Add SM6375 power domains
Date:   Wed, 14 Sep 2022 22:36:54 -0500
Message-Id: <166321302060.788007.3857501388494145309.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220716193201.455728-1-konrad.dybcio@somainline.org>
References: <20220716193201.455728-1-konrad.dybcio@somainline.org>
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

On Sat, 16 Jul 2022 21:32:00 +0200, Konrad Dybcio wrote:
> Add the bindings for SM6375 RPMPDs.
> 
> 

Applied, thanks!

[1/2] dt-bindings: power: rpmpd: Add SM6375 power domains
      commit: 2d48e6ea3080ef7b2424dabfb500e29b030129d6
[2/2] soc: qcom: rpmpd: Add SM6375 support
      commit: df646a17f103c6f18ab85c5e3773763d18dc528b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
