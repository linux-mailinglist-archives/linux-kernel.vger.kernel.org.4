Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928375BA0EE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiIOSqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIOSqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:46:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D809A955;
        Thu, 15 Sep 2022 11:46:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 891BB625F5;
        Thu, 15 Sep 2022 18:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C07C4347C;
        Thu, 15 Sep 2022 18:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663267589;
        bh=4aQoWqQIlT7CgalHAG9G4oWuQNvk1txMTZ7ASFZJVZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kwfqm0b58S9XHaA6SXwpIQshMRQzgrbBbnZqdSOBNDw7dSBwkis/h4bHKrUmtIpMN
         Nje8LYcT1BeruQbVbUB4Rq0oGY37Rt7hMFzDzMaWngEvs7QW+uAU0sqiCqLXvo0dpS
         4cWXBxbK7GHF+Orgm60KwUmuXT/vtu79UcRmk4XywsZ2sm6UnpTik609XHVRk0zqRG
         zLk47HItonSTwNEYJez7yx2p4YRKwwCfO2rQdiiWgc9tL5NsOqARGD5NWV5A80Zt63
         IVYOYJfBuhyYHr+o9XCCcpWHr2WJfdFrHZysmvc50kFrCZuA2TouQhoellVlXARNqa
         TZBRRYpacb+Gg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     luca@z3ntu.xyz, linux-arm-msm@vger.kernel.org
Cc:     robh+dt@kernel.org, agross@kernel.org, phone-devel@vger.kernel.org,
        mathieu.poirier@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        mani@kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/5] dt-bindings: remoteproc: qcom: pas: Add MSM8226 adsp
Date:   Thu, 15 Sep 2022 13:46:26 -0500
Message-Id: <166326758064.847092.18364479017237684349.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220423155059.660387-1-luca@z3ntu.xyz>
References: <20220423155059.660387-1-luca@z3ntu.xyz>
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

On Sat, 23 Apr 2022 17:50:55 +0200, Luca Weiss wrote:
> Add the compatible for the adsp found in MSM8226.
> 
> 

Applied, thanks!

[3/5] ARM: dts: qcom: msm8226: Add ADSP node
      commit: 25ba74dd60022f2fa1630405d6eba7c37f45b13a
[4/5] ARM: dts: qcom: apq8026-asus-sparrow: Enable ADSP
      commit: 268c661c172d783540f34a132290e78342bae3c5
[5/5] ARM: dts: qcom: apq8026-lg-lenok: Enable ADSP
      commit: 5cbd20166f0ac7ae0272d25401b6ec5472482a19

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
