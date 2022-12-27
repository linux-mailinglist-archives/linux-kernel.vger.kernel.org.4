Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1533656D82
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 18:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiL0RmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 12:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiL0RmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 12:42:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F998FC9;
        Tue, 27 Dec 2022 09:42:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AE15611D3;
        Tue, 27 Dec 2022 17:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C1FC433F1;
        Tue, 27 Dec 2022 17:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672162940;
        bh=RShwuHHpsBtt7mCC2Et+ETDHzvgpHJ7vtYGpZZ8EnLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mtMTcI+9hvDKIEmqvtx4Q4vKZXm+qL07qdge+YyDL+rDaIqIlddiiMprcGXK9JuKz
         UjBJ+PVRyYDior8shbqRkz5xJceudLN4ujkoy1ZoK3b//L+CJrIY6Y4KRd7C7gOAB3
         qNO3A/FbX7Peef/65oiLB/z3O0xpZvcN1u2oVUxPzi2tMqzCG/gVLN/ZkC1hhtFo7h
         ajAxXOcpjWJNcTo4y/OgXDEVUAbqbJ1wyDPzTIUqL0EDtkKMQ1BB4rSNn30/u0fMDY
         Qivw4bo+77tUYK7OBe47zWzvSv+4OzBokQ3r3PWBzRKLNNzXF5rPwlMAyL/iRnKL0I
         Y7nRj5jkFLgww==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sireeshkodali1@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v6 0/5] remoteproc: qcom: Add support for pronto-v3
Date:   Tue, 27 Dec 2022 11:42:16 -0600
Message-Id: <167216232801.738877.15895916910585144737.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221001031345.31293-1-sireeshkodali1@gmail.com>
References: <20221001031345.31293-1-sireeshkodali1@gmail.com>
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

On Sat, 1 Oct 2022 08:43:39 +0530, Sireesh Kodali wrote:
> This patch series adds support for the pronto-v3 remoteproc found on the
> MSM8953 platform. It also converts the documentation for wcnss to YAML.
> 
> Changes since v5:
>  * Fixed memory corruption in driver patch
>  * Slightly improved driver patch's commit message
> 
> [...]

Applied, thanks!

[1/5] remoteproc: qcom: qcom_wcnss: Add support for pronto-v3
      commit: 4c707cf5c7ddd43c6d574281a5591f71ed8d310c
[2/5] dt-bindings: remoteproc: qcom: Convert wcnss documentation to YAML
      commit: 9a660c7fd69ae9fff3f941140db25339937f8eee
[3/5] dt-bindings: remoteproc: qcom: wcnss: Add qcom,pronto compatible
      commit: 409db7b777c81ef249688cddba882d16dbb064e0
[4/5] dt-bindings: remoteproc: qcom: wcnss: Add compatible for pronto v3
      commit: a890eebe42ad2c0cfe44a34a4f9e7d1a735a55d8
[5/5] dt-bindings: remoteproc: wcnss-pil: Make supplies optionally required
      commit: a4421a22bfd966852349e5c38278e9a6eaefb456

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
