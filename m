Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65E16DB416
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjDGTVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDGTU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:20:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BC69ECB;
        Fri,  7 Apr 2023 12:20:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA2FB64FE4;
        Fri,  7 Apr 2023 19:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77085C433EF;
        Fri,  7 Apr 2023 19:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680895256;
        bh=o/BYc7lsGEIfg8PVEDczTvoQ59vb+pJbPRjRVH8AMlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e1fBKh/V8HoCzNNrFjTaNmOLCmOJ5OOctb10UVujSCsxroPTlZDYoNZNNVCgaWGIR
         7KjMCU0Dw7rzH3U5E/lkBWPoHoxqM60omBJSDpCyRTFKoOGCpWxySB9r2xgzvMBNwt
         cdRrppzG9CRLHJI9URF4gGDkjSmeJZ/T7a/dTWiFUNqdLHKD8JWj7XJfUGwbJAMo9I
         EWQfbFBlfhvW0+iwVhz6dakoSsUq30DvyBLINpkCpW8P8ogwT4V/naDodHGinEieO2
         p21lC32vd0y5hNlbO/STIhEwhgA2gi592RPI7tvI7rTNhqxlztFR4zwu28oQ5rbPZS
         gbAba3Dlddn4w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH 0/3] MSM8953 remoteprocs dt bringup
Date:   Fri,  7 Apr 2023 12:23:45 -0700
Message-Id: <168089531815.2739604.843373781255054535.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230407165345.42800-1-a39.skl@gmail.com>
References: <20230407165345.42800-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Apr 2023 18:53:41 +0200, Adam Skladowski wrote:
> This patch series introduce nodes required for bringing remoteproc cores.
> 
> Adam Skladowski (3):
>   arm64: dts: MSM8953: Add wcnss nodes
>   arm64: dts: MSM8953: Add mpss nodes
>   arm64: dts: MSM8953: Add lpass nodes
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: MSM8953: Add wcnss nodes
      commit: b12428640ebeea3ee7e7ae817e1bd345612537df
[2/3] arm64: dts: MSM8953: Add mpss nodes
      commit: 2bbada24e8a6c9eaf5caf015688dba0dcc3925d7
[3/3] arm64: dts: MSM8953: Add lpass nodes
      commit: e58d100fa24309291ec500f9d161ff1ade20cabd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
