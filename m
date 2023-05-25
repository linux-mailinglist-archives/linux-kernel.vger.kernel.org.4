Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D24471050E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240289AbjEYE6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbjEYE6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:58:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97F81BFD;
        Wed, 24 May 2023 21:52:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C4D663C35;
        Thu, 25 May 2023 04:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320B6C433EF;
        Thu, 25 May 2023 04:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990291;
        bh=yddTKAORWqVnvUlnylcLTjBTAd//zDPXpD6RLdXY/u8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hZxaIdNsBulUT4C6Kt5tRPOso38XyFMdNv+i9CxZ093pcW8TsTeoyCS0CDnww9BMx
         l1hhrnxKqPvyd42NCYnsw5GOsplYQJoQ8X23XAGncmXidfa2WolYIIYud+GrQW8KCS
         +31B6rgEPb292CfvqbXkcG41fwN0z2xt0yxpdbwKDiThpFih+kxVi3w1pngmSmgde1
         o/TWEM7SjQ7nM08rz/N1tvZYCWCiNiPvGKc+e1/lfcWPS3fCWcP7oBx9YBtWkKZOQ0
         DwF4OGFPg/sr+NMmL6y7DeyQhwtZwdDG7LHabjwWddN9Cv6i/Ah9apAqon3WCs3g+4
         nmIoqeLLrYe7Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] ARM: dts: qcom: msm8974: align WCNSS Bluetooth node name with bindings
Date:   Wed, 24 May 2023 21:54:11 -0700
Message-Id: <168499048184.3998961.8612234285851392939.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230421195437.31513-1-krzysztof.kozlowski@linaro.org>
References: <20230421195437.31513-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 21 Apr 2023 21:54:37 +0200, Krzysztof Kozlowski wrote:
> Bindings expect WCNSS Bluetooth child to be named "bluetooth":
> 
>   remoteproc@fb204000: smd-edge:wcnss: 'bt' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: msm8974: align WCNSS Bluetooth node name with bindings
      commit: cc6c63b88a63dbc73293281c08a745cc23f2346c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
