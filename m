Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2AB73EB1A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 21:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjFZTRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 15:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFZTRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 15:17:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9863C126;
        Mon, 26 Jun 2023 12:17:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2950460EF2;
        Mon, 26 Jun 2023 19:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7AEC433C8;
        Mon, 26 Jun 2023 19:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687807038;
        bh=/jrzo23xohw0vOq31QrW3E4pCIODhVSB7kAOkjyOfmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tgYemC9vJpQtwzSkNiMYd1fQnLJYFRgfYHT1JoYvmIOlnRgfxmnejM3wKibq6jA4K
         XaAsnrn5qipc39ocMUjOFjqjTH0HQJiUezkwFVWwdFUQjKPXXPNkeWATV1r/YZpEnJ
         u+UA2Ylt3m8rOzNbdnHuF8WVAyvCx/roe8q2ig2qZ9/fhTDzAmdN7VVbGhK78Aj7DE
         Z6bnw/lrHfXzH5847YnktNdwLBt3zN0Axio0br1MvHXrdpxmLvTFITXhrDCcqJ+Knm
         CfoNxkKkfejSIItGmM/PqEVLbr6lQs3WeFXEhWAAWLdRVvZaatndOKjDE1ZiDe+a23
         yfNt6S+qSvLkQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] SC8280XP clock runtime pm
Date:   Mon, 26 Jun 2023 12:21:11 -0700
Message-ID: <168780207957.2579463.15875454816209034971.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619-topic-sc8280xp-clk-rpm-v1-0-1e5e1064cdb2@linaro.org>
References: <20230619-topic-sc8280xp-clk-rpm-v1-0-1e5e1064cdb2@linaro.org>
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


On Mon, 19 Jun 2023 18:13:16 +0200, Konrad Dybcio wrote:
> Keeping power domains always enabled hinders power efficiency. Add runtime
> PM to 8280 clock controllers to prevent that.
> 
> 

Applied, thanks!

[1/2] clk: qcom: gpucc-sc8280xp: Add runtime PM
      commit: 9bbcb892a7cd06c8156e6de211a8d7d45ee48086
[2/2] clk: qcom: gcc-sc8280xp: Add runtime PM
      commit: 2a541abd98370f9931c889c187eef7458720b57b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
