Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998FB602279
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiJRDVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiJRDUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:20:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290FE8F270;
        Mon, 17 Oct 2022 20:17:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 114E9B81C6A;
        Tue, 18 Oct 2022 03:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490DBC433D6;
        Tue, 18 Oct 2022 03:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062924;
        bh=DT65j//oric+pMOzKCXqE1m3smntmRWIzSbeC8NUSN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b2OU0My195TKv2ixbANStwiK8hXPuX2+LUM0Z7KFU2WnHKbMcqk9ssx1Pdo0Smxzl
         EGsgvRxXE4vRvqkt+dkgdsXQLaQ+k+yCswfkgFohunmlHJWju6hSp/f3GIVNaPlK9R
         Vu0GSH2+l4QnPW5wsY4n2LHieBlV6YtJlFwcTzSEcKpnirdLm1dXqmnoGl4d9bQl02
         m1xX8/cI+UhGBTk+xCfscFeigVouv5TKbFVzkspr1kttNNeBRlQQQaAv9DhoAC+bhf
         gNIaL4nZhL4rVlU+Xd+Mb+2we/NOFJkA+I1PrYPd7Vqn+tkrQHt/JqdYT8MfLjw/m+
         n1GaKMC84Iemw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] soc: qcom: cmd-db: Mark device as having no PM support
Date:   Mon, 17 Oct 2022 22:15:18 -0500
Message-Id: <166606235861.3553294.1853267063018582956.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221015004934.3930651-1-swboyd@chromium.org>
References: <20221015004934.3930651-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Oct 2022 17:49:33 -0700, Stephen Boyd wrote:
> This driver purely exposes information from memory to the kernel. Let's
> mark it as not having any device PM functionality, so that during
> suspend we skip even trying to call a suspend function on this device.
> This clears up suspend logs more than anything else, but it also shaves
> a few cycles off suspend.
> 
> 
> [...]

Applied, thanks!

[1/2] soc: qcom: cmd-db: Mark device as having no PM support
      commit: 5f7e2cb56af6800a4158514cc27921141e67ae19
[2/2] soc: qcom: stats: Mark device as having no PM support
      commit: 367b9c70e9b25fe9ad5346b0f3544682d8b112b9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
