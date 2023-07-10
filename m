Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2241A74CBB5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjGJFFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjGJFFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:05:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045581B1;
        Sun,  9 Jul 2023 22:04:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B34A860E8E;
        Mon, 10 Jul 2023 05:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644BAC433CC;
        Mon, 10 Jul 2023 05:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965479;
        bh=X4esJ+0T1kRXcXHGY+Y5o2s92qoq6iAH04TPpbZFcHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Srcl9c1AXNwysG/6DtCi5SpeQpN7CCuURBIHUnN044kZcTtdIBJjZAE7uJWDBxnma
         5gTHTPJCAL4t1E5Tdz6i4lz1tAN7yHJeK4AlaeN33plGE5xHXu980ZzIEN6qoRCVWW
         /jRsCReeGtc+aqy2rkcXsrGIdEGuJ5ek6FNhFTMYFC/q+qJ86fVZJ753snkK1YmxyN
         F9NLuJA02ajW6ztjcqfLexdstTFIfZuSis/ckJmAkwxeFVfYmNklJ8ESG2Gm/nN8qA
         FRItUwbGgJKv9CJkoKPTYIPTwlomC/Y7gMNd+mADcLDNtOccgXi7OXMzoBIpVnkJbW
         lOPFEdUnDlJOQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm6375: Set up L3 scaling
Date:   Sun,  9 Jul 2023 22:07:19 -0700
Message-ID: <168896565975.1376307.14392481753890762499.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230627-topic-6375_l3-v1-1-9cb03ef05150@linaro.org>
References: <20230627-topic-6375_l3-v1-1-9cb03ef05150@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Jun 2023 16:07:37 +0200, Konrad Dybcio wrote:
> Add the CPU OPP tables including core frequency and L3 bus frequency.
> The L3 throughput values were chosen by studying the frequencies
> available in HW LUT and picking the highest one that's less than the
> CPU frequency. They will be replaced with a dynamic, bwmon-style
> decision maker once support for MEMLAT is introduced upstream.
> 
> Available values from the HW LUT:
> 300000
> 556800
> 652800
> 768000
> 844800
> 921600
> 1171200
> 1382400
> 1497600
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm6375: Set up L3 scaling
      commit: fdc3cf9fc3b266af2b23c82c616b6b87d37c97e0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
