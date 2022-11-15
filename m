Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA6D62A0AF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238008AbiKORqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiKORqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:46:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B5F183AB;
        Tue, 15 Nov 2022 09:46:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29AD2B81A56;
        Tue, 15 Nov 2022 17:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC4EC43470;
        Tue, 15 Nov 2022 17:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668534398;
        bh=jepKBfn3cd+JmBZNyi1VbQRzrxGciAZqWvyOVEq3MUQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZOhvZLC/kYmoxQnw3gNBP/hhGdHigFQLn5Cj7RA+VfFcrP8cMCmaGgM6ZHJQXiKBH
         p2N4d7zX7zI6dbyfO6XXdaEeX0dkhg/lKY810iYPZMBlVTjpznQWEr3wYY992gunNX
         G+wHGlVLSS5horqjOGb8y3gvI7dORCelJQJShvJaJRdMzpfrJMwwG+x4kASpVK4kZN
         wVfchmy+AeUHrZuZBacq31EiBxXHeKwsXEkDml+TbWdMEHW0Q2JqXqSmIbONAPBHQD
         /vpUc20sfG8EjgTIhUTyLCiXArBeWp/bFHqHyPYDE1aUqAly9W8DrMuDg05o/liZs7
         3JJNV8Z66xQMg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: trim addresses to 8 digits
Date:   Tue, 15 Nov 2022 11:46:32 -0600
Message-Id: <166853438867.1276519.6571613417677991049.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221115105046.95254-1-krzysztof.kozlowski@linaro.org>
References: <20221115105046.95254-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 15 Nov 2022 11:50:46 +0100, Krzysztof Kozlowski wrote:
> Hex numbers in addresses and sizes should be rather eight digits, not
> nine.  Drop leading zeros.  No functional change (same DTB).
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: trim addresses to 8 digits
      commit: 22dbcfd6f4a9f7d4391f0aa66d3f46addea4bee9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
