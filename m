Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876455B7786
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbiIMROl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbiIMROK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:14:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C808D64;
        Tue, 13 Sep 2022 09:02:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACAE3614B6;
        Tue, 13 Sep 2022 15:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4100FC43144;
        Tue, 13 Sep 2022 15:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663081489;
        bh=8qqBaf9lkZ3fnFmecd8O6vR5PoAXIkqkpMMMXZKPWWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HjlksUn8cbXihhcwTJe/I1YloSfLjbFSkXi0ZLo4gl8RSinlqp1Ncr7LtGDT28l9W
         2skCC3j+RxaAR4AtFB+KHMcVElxhm2lScwQhkZdHcRQGc89QklGCF3iFTWkSZ0qly4
         bxVHsnmKnASN4eQLvQ1wzkcXkBdUTZe33dbjPillFe5RhdR6nrpdIh2fypqVbMAAu/
         568f6ZeHYGx2zfbiBVh9OWgrqWlbQ1D+JRlPZchFd2RLJ/5JrZXvbymsjfnPAMGkxf
         bB2d5JA7HX4GHKKr9QKRMuJez5lzdvQLDlkAv6ovxbrVtJr+atfx+h2ppRQdgPZh7F
         qLVZGWOClskCg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     jinghung.chen3@hotmail.com, Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, robh@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alan-huang@quanta.corp-partner.google.com
Subject: Re: [PATCH v8 1/3] dt-bindings: arm: qcom: document sc7280 and villager board
Date:   Tue, 13 Sep 2022 10:04:41 -0500
Message-Id: <166308148203.625876.1219399215890632072.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <SG2PR03MB5006CE1EB9BFD95511133CA6CC949@SG2PR03MB5006.apcprd03.prod.outlook.com>
References: <20220726094549.263899-1-jinghung.chen3@hotmail.com> <SG2PR03MB5006CE1EB9BFD95511133CA6CC949@SG2PR03MB5006.apcprd03.prod.outlook.com>
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

On Tue, 26 Jul 2022 17:45:47 +0800, Jimmy Chen wrote:
> This adds a LTE skus for Chromebook Villager to the yaml.
> 
> 

Applied, thanks!

[1/3] dt-bindings: arm: qcom: document sc7280 and villager board
      commit: 593ad9132fd854f5916f68855204fb3b487cb408
[2/3] arm64: dts: qcom: sc7280: Add herobrine-villager-r1
      commit: 3accba70e2389a47f42ffb5e900d01b7960dea9e
[3/3] arm64: dts: qcom: Add LTE SKUs for sc7280-villager family
      commit: d42fae738f3ac58cb8ba1fcd48510a40b57a3155

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
