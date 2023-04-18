Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226176E68F2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjDRQGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjDRQGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:06:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373B4F7;
        Tue, 18 Apr 2023 09:06:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9C9363644;
        Tue, 18 Apr 2023 16:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97195C4339B;
        Tue, 18 Apr 2023 16:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681833978;
        bh=ePPAUY9dJOFw/kK4NHB+f5qypog9sXqimbRgdM/SBcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s+udSpDHoT4p04HgM1AmuYzYBjhYlepMKYnmZH/3AMkwo8tWPH6XFHZzk19LiaBBa
         21WYUi5QMqvdLbV0lzNAcVJ2kTu0Pi+lGC75tN5EVDgOpkM86/4Te/m7N5s/qAiUD/
         oHdp7Nqn0hbwb3Ua79oEb4BTnlJlYrjf3qg98pVZZ1IdFRIjV72Yi55afQaCkRiAFs
         Y0PRxpQT9Ymku65e1BWkZwEiJ77ePgQfDh2AgjbG6aEvHso6sv7/JctyhFaH0yNvzm
         3u0i5yBYOPaPu70XRcXHXoF5cZ8cbUFmr6xe5Ov/gYmkLWSE7PRTyEfW3JYtFfqdtI
         mXEMGaxWAUxxw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Andy Gross <agross@kernel.org>, Rob Herring <robh@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: remoteproc: Drop unneeded quotes
Date:   Tue, 18 Apr 2023 09:09:48 -0700
Message-Id: <168183418160.1484313.11791175608485998992.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327170114.4102315-1-robh@kernel.org>
References: <20230327170114.4102315-1-robh@kernel.org>
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

On Mon, 27 Mar 2023 12:01:13 -0500, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> 

Applied, thanks!

[1/1] dt-bindings: remoteproc: Drop unneeded quotes
      commit: 82f2734d99d7e6a2327ff4e2122dd0db425b598f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
