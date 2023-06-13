Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA8572F0B1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240145AbjFMXsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjFMXrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:47:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C551FCF;
        Tue, 13 Jun 2023 16:46:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F41DC63C81;
        Tue, 13 Jun 2023 23:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C226C433CB;
        Tue, 13 Jun 2023 23:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686699956;
        bh=RPO1qjIIqnUDwMgPufqXgv3QAhqpUBEUclU6+rE87J0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b5xoaKpp6JbkzsOHClhbb+MLnBILE2h06oOiEl7XV1Ushhh1ZXDKzgsx/FFeZSPhz
         1iHKcAp/UhNHa61wm95VYtbSI6Vb+E7jYwQOjMTf9Qze4PBqmfTwQgKVXcitoMpJeo
         +g0z/0b1oJSrpI7DNxA/L70GkVWv3aeKWmUTz+m4dHItSmiLwrG1GFe7t2qHVKGgOu
         Nt5LOyH/q/Hxy1lLPKyykmRVltrlprDvMPvdKZOjZ3FjmgYdFRMFltrn5tVCBo6WuP
         cShFvUTk7U+Sd6HALg7PA7Xrcc/oj3fA9cEAgDpjcGdCdXPEOpJF1Phv6Q6fUEh9as
         9HjRQTMWxd2vQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, conor+dt@kernel.org,
        agross@kernel.org, robh+dt@kernel.org,
        Robert Marko <robimarko@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org
Cc:     ansuelsmth@gmail.com
Subject: Re: [PATCH] arm64: dts: qcom: ipq8074: add critical thermal trips
Date:   Tue, 13 Jun 2023 16:48:58 -0700
Message-Id: <168670013501.1400697.17683754939462878932.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607184448.2512179-1-robimarko@gmail.com>
References: <20230607184448.2512179-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2023 20:44:48 +0200, Robert Marko wrote:
> According to bindings, thermal zones must have associated trips as well.
> Since we currently dont have CPUFreq support and thus no passive cooling
> lets start by defining critical trips to protect the devices against
> severe overheating.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: ipq8074: add critical thermal trips
      commit: 56d3067cb694ba60d654e7f5ef231b6fabc4697f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
