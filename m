Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21635ED3A1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 05:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiI1DtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 23:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiI1DtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 23:49:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904E513D860;
        Tue, 27 Sep 2022 20:49:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E598661D0B;
        Wed, 28 Sep 2022 03:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FB2C433D6;
        Wed, 28 Sep 2022 03:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664336946;
        bh=bOTPOJATD5WKsL9C6BuxhlFd00liXW0Fz81Jl7bSBrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qy8jd1z39RS9n8akgfrp2gd7lFLb1RpCSRHq74lVlNpMMOfg5t9hWncqzrkZ1N6xu
         I+8JYo/GJ+tQk/13ppKPkyo2QxKLeK/FLvChgP2o0R8jRUXFbmDcZaITc2BBT4DCOj
         pmWGAki3kkaNvkNwB6JkpSxChWaqogKLjLn7ocvIJL/WLgNCA+3W9ZjVyXUu9BRGT9
         RqGa0JnA6EDsUJiJjMLNs61ps9ZAVlhMSylFlNxmQvoLRhmik6HvgxAHtf8VJ+RRyS
         UseDw/1SNmDebv5FvUUrpVrZ5enKr3OTqbobeiRZZf4pnygUI1oUMVV1sDqMRJ6Sqx
         qGDBkALujZB4A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     sboyd@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, ahalaney@redhat.com, mturquette@baylibre.com,
        agross@kernel.org, konrad.dybcio@somainline.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clocks: qcom,gcc-sc8280xp: Fix typos
Date:   Tue, 27 Sep 2022 22:49:03 -0500
Message-Id: <166433694019.1852584.18109303594078450499.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220921153155.279182-1-ahalaney@redhat.com>
References: <20220921153155.279182-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2022 10:31:56 -0500, Andrew Halaney wrote:
> pipegmux and SuperSpeed are the proper spelling for those terms.
> 
> 

Applied, thanks!

[1/1] dt-bindings: clocks: qcom,gcc-sc8280xp: Fix typos
      commit: 6632a6adae86265ca79cefc0e48e4a672a1108df

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
