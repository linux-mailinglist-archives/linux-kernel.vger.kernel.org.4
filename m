Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4981602249
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiJRDML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiJRDJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:09:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167559AFB5;
        Mon, 17 Oct 2022 20:07:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A4D2B81C64;
        Tue, 18 Oct 2022 03:07:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C8DC4314D;
        Tue, 18 Oct 2022 03:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062442;
        bh=e3Z8K9On2kRqSjJgNDlm+7dcG6ro3jpsnRUfPgEJB6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VD2iQ8eg9f5XhJ20ZGYtwJHvyAUsMVKq6TKIs/mSoyecZpj7bJfoak1ozlQH1HKcJ
         Z7ye1vQzU45gyHnLVUZ9kh7vTgTwwDgODFH87IhxSBerpNq32mb5403gG+6iwCm+F3
         BaiByPEQV5/D6nkvLSm1vxH5+XDfI1uKGv/M8OxaVp9S+N0BMNeq9vjQuDF77jtdKY
         IaBdyNynmRyM/xVDkqvscVxCza8qs/T/qo9GHAOj8dIFBZIRYXnr/AM+4XLZ6lE9y7
         tkkgCq9jfnJaf15Pr0xNI6ABhEltHzB2rJFkU4GkJttNS6OfEytpDDLjorF+6fgjRB
         ODghlbFQk2Keg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     luca@z3ntu.xyz, linux-arm-msm@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        agross@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH] ARM: dts: qcom: msm8974: Remove bogus *-cells from smd-edge
Date:   Mon, 17 Oct 2022 22:05:54 -0500
Message-Id: <166606235858.3553294.17686851847191539446.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220925173203.96117-1-luca@z3ntu.xyz>
References: <20220925173203.96117-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sep 2022 19:32:03 +0200, Luca Weiss wrote:
> The bindings check complains that #address-cells and #size-cells
> shouldn't be in the smd-edge node. Remove it.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: msm8974: Remove bogus *-cells from smd-edge
      commit: 1e27c4cd1741892b9984d571e4ad1476eb0c9b00

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
