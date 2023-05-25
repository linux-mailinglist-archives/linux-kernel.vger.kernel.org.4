Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F81D71053B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 07:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240185AbjEYFRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 01:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240004AbjEYFQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 01:16:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B993C21;
        Wed, 24 May 2023 22:03:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A571642C0;
        Thu, 25 May 2023 04:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A56EC4339B;
        Thu, 25 May 2023 04:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990300;
        bh=ycn3DV7+eOp/cPpjQQmSMRmMh8OHrtULiaAVj3rnCJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jnbN12MD+cXxN6kzmH/Rtt4fyTqRseqw4jsMOIjKki24bI7ATxqjhTaVz97+H7Ff+
         bYViHY23E8R1g5vqebteEqGzo1A2fY4CdL1QLfroYU5m7ZbS0+0YQEWw0GwC5W3530
         WhVXuUzwxco8Wvtjo25CiMjcxkSTWW/ihXevhCAU6LnabzjG1iNWdR+4yy6j+5TEnQ
         v3u9AJUP/EVGTAFbj0RPKL0va+n/bhmpNdfCp7zriLDNlRpfjHsA+d3QjP5LVobM7W
         25xnLI6a3sZGiApg3mQpOWRK92PPY/uaApubvGXD+NyOYucjom3XrLz8CcZNJNFBZ0
         8KsP1Z19HuiPQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm6350: Move wifi node to correct place
Date:   Wed, 24 May 2023 21:54:20 -0700
Message-Id: <168499048185.3998961.5560910405642492988.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516-sm6350-order-v1-1-5c3b7c4cd761@fairphone.com>
References: <20230516-sm6350-order-v1-1-5c3b7c4cd761@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 08:56:14 +0200, Luca Weiss wrote:
> Somehow wifi was placed further up in the file than where it should be.
> Move it down so the nodes are sorted by reg again.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm6350: Move wifi node to correct place
      commit: fbd47f83c5a94f6e3772b4087c97292601857e68

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
