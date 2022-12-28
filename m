Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A397B6585BA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 19:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbiL1STB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 13:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbiL1SSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 13:18:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B47817423;
        Wed, 28 Dec 2022 10:18:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB18461582;
        Wed, 28 Dec 2022 18:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302DCC433D2;
        Wed, 28 Dec 2022 18:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672251520;
        bh=o+/1jupD/MomdUxX2T76IB/QJVChdHctQWcYzha4Knw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=phcYOiX8Vf6q1BpIZy/u09BRBL0fi9zmDBP8eDu3tq9GV1/01/iqCCjfJjo4QTpiJ
         i9GNGxQXUJ4sFKi0u50gQ5Qkp/C53her9YdDGuGOAKTyCUAgtlWXRrmXDL66dIViIP
         1JJOqjs8zj8gbJECJFQkwc30ymIGPS0rLct8ks7gdsXzETrpFP+Z7DMLud5fjgWwyJ
         wvg3HlP6aFhgmLaQ2ctNx0r4FmrKmqmJ2Bv6XH74dbeXTxY0VKtz1BmVbdHWniiz4R
         wEZkqoGUz1xYT7HuKGHpfUNNZJG4xCzUQELVN0QKCdgEux9woGZU6j1Se22dnr2Xfv
         w0oeAXkpkMMZw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_gokukris@quicinc.com, mathieu.poirier@linaro.org,
        Bjorn Andersson <andersson@kernel.org>,
        konrad.dybcio@somainline.org, agross@kernel.org
Cc:     quic_tsoni@quicinc.com, quic_satyap@quicinc.com,
        quic_eberman@quicinc.com, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, quic_rjendra@quicinc.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v1 0/3] Handle coprocessor crash
Date:   Wed, 28 Dec 2022 12:18:29 -0600
Message-Id: <167225151228.950465.9671261925340567778.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1662995608.git.quic_gokukris@quicinc.com>
References: <cover.1662995608.git.quic_gokukris@quicinc.com>
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

On Tue, 13 Sep 2022 11:35:41 -0700, Gokul krishna Krishnakumar wrote:
> Make the following changes in case of coprocessor crash:
> 1. Send subdevice notifications before panic
> 2. Do not report crash if SSR is disabled
> 3. Avoid setting smem bit in case of crash
> 
> Gokul krishna Krishnakumar (3):
>   remoteproc: qcom: q6v5: Send subdevice notifications before panic
>   remoteproc: qcom: q6v5: Do not report crash if SSR is disabled
>   remoteproc: qcom: q6v5: Avoid setting smem bit in case of crash
>     shutdown
> 
> [...]

Applied, thanks!

[3/3] remoteproc: qcom: q6v5: Avoid setting smem bit in case of crash shutdown
      commit: 3cc889eb83f59b5a6a869a685da11f79ffbb4e4d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
