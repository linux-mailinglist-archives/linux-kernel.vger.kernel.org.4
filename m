Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6BA70D1FF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjEWC74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbjEWC7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:59:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC46CA;
        Mon, 22 May 2023 19:59:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 567AA62E67;
        Tue, 23 May 2023 02:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084AEC433D2;
        Tue, 23 May 2023 02:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684810772;
        bh=P6H8AcSjrURkIq81HCTAWmCgUwhoZpkkTWjr2ztgJX4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=n+V408sw6rR7ZnftgLsd9IKDOUp/2lGf9A8XxjKeAuv5ENI5ZPNxTTP4iyb/YvhO/
         F1AL10tXnREMQ6TZGRdmzIEuJjoF5D9omAdFSItBg4jS6VGAu7TQu2SShYsAihRAeY
         6HGQPVwjsQZa/F901J8/+ia2urScUwBxbGj1jIBQn1grTOfGhuCfcouAu0SVMn47W1
         SnNfdRlRDrMWcg6+dAwdgI/u9sFtlClxGvDSYI9m1N/CG3NvCTfvUSCovzrivPBH3f
         cUag+KVvAUxCCODdun5KlHskWMapff0lCWOREMVPLbSsFs4HL6utDmZXlmThG0RFdh
         pn8efM2LyKgeg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org, Jianhua Lu <lujianhua000@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sm8250-xiaomi-elish-boe: fix panel compatible
Date:   Mon, 22 May 2023 20:03:20 -0700
Message-Id: <168481094821.1229550.14404869026123502429.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230408130809.52319-1-krzysztof.kozlowski@linaro.org>
References: <20230408130809.52319-1-krzysztof.kozlowski@linaro.org>
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

On Sat, 8 Apr 2023 15:08:08 +0200, Krzysztof Kozlowski wrote:
> The bindings expect "novatek,nt36523" fallback in the panel compatible:
> 
>   sm8250-xiaomi-elish-boe.dtb: panel@0: compatible: ['xiaomi,elish-boe-nt36523'] is too shor
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sm8250-xiaomi-elish-boe: fix panel compatible
      commit: 0c7433dd81b5e771ef222f340fef03501131761b
[2/2] arm64: dts: qcom: sm8250-xiaomi-elish-csot: fix panel compatible
      commit: fae7d907a75eaad4bfb17e7990e357938c5b1351

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
