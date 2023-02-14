Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96770696B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjBNR20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjBNR2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:28:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931711724;
        Tue, 14 Feb 2023 09:28:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3780E617C9;
        Tue, 14 Feb 2023 17:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE52AC4339B;
        Tue, 14 Feb 2023 17:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676395694;
        bh=zKjlEd5LXtP7osVRyYIIf4E0FaZu9JjAP6fZGjn6fQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m80QhsH7Yu+XveX+yu1YKrI+NeDkD/TbnKPWnxSRKJdCFx7sJ73T9H9q7ZspfSYRo
         rU6d0bLAvJdAG1RfMsJ1aXPdNubHKJ7y+KFbyOAx7PB0zrBLGvKi1YyEy4kGYbeeKa
         iVR4MbseocB+JKz+wEsb9aSRc+rDgmolWygUA/s7FWuoxDdKwij8yr3Nwd7DJp9DPe
         YBsgqowTZZ4uErYUVCkpwZdXXoG74pB0+BSbRG7t2JIoqp69lPkN7L4NWU/I9iiny2
         oaZXehZnvOCOxYV/XCnbGPSGajiIbcb6qKpdcWshxFpbEs2izzBd6YXMaNqkq0lFkG
         w0mfU2sxnkPyg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, bhupesh.linux@gmail.com,
        mani@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org
Subject: Re: (subset) [PATCH 1/2] remoteproc: qcom: pas: Add sm6115 remoteprocs
Date:   Tue, 14 Feb 2023 09:30:13 -0800
Message-Id: <167639581473.996065.17789960687528392732.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128053504.2099620-1-bhupesh.sharma@linaro.org>
References: <20230128053504.2099620-1-bhupesh.sharma@linaro.org>
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

On Sat, 28 Jan 2023 11:05:03 +0530, Bhupesh Sharma wrote:
> Among the subsystems in the Qualcomm sm6115 platform we find
> audio, compute and modem DSPs.
> 
> Add support for controlling these using the peripheral
> authentication service (PAS) remoteproc driver.
> 
> 
> [...]

Applied, thanks!

[1/2] remoteproc: qcom: pas: Add sm6115 remoteprocs
      commit: 3c7306589dddbcc0ac53ec6b2c3a14875879e20c
[2/2] dt-bindings: remoteproc: qcom: Add sm6115 pas yaml file
      commit: 838c558bb8bc3a9a4de840fd25c6ad0ebc4d1ed7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
