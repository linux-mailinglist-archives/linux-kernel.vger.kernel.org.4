Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC374702265
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239253AbjEODcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239211AbjEODbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:31:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE831BF2;
        Sun, 14 May 2023 20:29:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 221F661751;
        Mon, 15 May 2023 03:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7F0C4339C;
        Mon, 15 May 2023 03:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684121367;
        bh=fJ3yYkQrPWi6o5AW2rObvWbtXqXuGfjrpLzkEe4t0K0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=F6JBDknoQrj7bkgK/AzPsF7UGj2F+8hFg2g84Oh+jCxN2JyhPR5pTostVUldbPTH/
         EYBMsz09cAc6D36wnql2pO3NvXd8/D/urV9K2sXLis95EoDu9r6KwlgN5CZVDb0V+f
         /OfM1Ay60a4QRAzpA7LMlvlG8BGWS7jx8d3+QGreKZL9LxLeClbfvZtRGEa1E5VG7K
         +0s3ESZDC+XQ7jcwFrtcz3Jc7SWuLL+gpEG9uolT7emF/CeOPjiRqzjp07WnFa3nxH
         Qg6fV30H/T7mH/NrmSCGmhkpTXbfIQ++IMGEoLmQZ0xkERFfV8uhblFAWcZHiq+wnn
         yG3m5WiDIyrWQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: drop redundant unsigned >=0 comparision
Date:   Sun, 14 May 2023 20:33:06 -0700
Message-Id: <168412158454.1260758.13500261207200813689.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230513112913.176009-1-krzysztof.kozlowski@linaro.org>
References: <20230513112913.176009-1-krzysztof.kozlowski@linaro.org>
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

On Sat, 13 May 2023 13:29:13 +0200, Krzysztof Kozlowski wrote:
> Unsigned int "minor" is always >= 0 as reported by Smatch:
> 
>   drivers/soc/qcom/rpmh-rsc.c:1076 rpmh_rsc_probe() warn: always true condition '(drv->ver.minor >= 0) => (0-u32max >= 0)'
> 
> 

Applied, thanks!

[1/1] soc: qcom: rpmh-rsc: drop redundant unsigned >=0 comparision
      commit: 3395d36e6805786c26d13188735bc796b9d7a7c9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
