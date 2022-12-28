Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1316585BF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 19:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbiL1STL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 13:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiL1SSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 13:18:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDF217423;
        Wed, 28 Dec 2022 10:18:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36990B818BB;
        Wed, 28 Dec 2022 18:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622F6C433F2;
        Wed, 28 Dec 2022 18:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672251521;
        bh=vtXoCo7JRD0p4O6Y6CjpFVMauUVcJarC3EVRF4PFYrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YUAkqbuoOrlKdoSH//5JLK1VXWmr20I0EtYmau0Qt3U5tucNRftGnGFJsYpQCh7rs
         MgOD+NYi+nAFzysMt6RMlD3P9vulsG1sdm/Z3HrUO8hgVWsoL3C8PNTz95C0yfioFE
         QwyvMDhfDNWroqgUVFKOJopRvncSsHWJ9qncwFKFcGsPS7dR4cfh1j5Ay6Yx1HhJdo
         IiRG8uyBWeaF6z0wbVScCh5/peqDj3MPm693wLfZJejLD+CmaR4ijoj+3kURMUUSyR
         eKLoH2IU7B0J0ehXl8dyFgulCdzBtdAAeLG+qixRrPAgRcWfJduIewM4l4A1BRAYHf
         uatayNUFnJpVw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     mathieu.poirier@linaro.org, quic_mojha@quicinc.com,
        konrad.dybcio@linaro.org, agross@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: pas: Fix subdevice add order
Date:   Wed, 28 Dec 2022 12:18:30 -0600
Message-Id: <167225151236.950465.2699164221418511435.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1671024983-22634-1-git-send-email-quic_mojha@quicinc.com>
References: <1671024983-22634-1-git-send-email-quic_mojha@quicinc.com>
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

On Wed, 14 Dec 2022 19:06:23 +0530, Mukesh Ojha wrote:
> Currently, the notification like QCOM_SSR_BEFORE_SHUTDOWN is not exactly
> sent before starting shutdown activity on remote subsystem but it is
> getting sent after sysmon shutdown request to remote.
> 
> On getting QCOM_SSR_BEFORE_SHUTDOWN, some client want remote subsystem
> to be alive to communicate but as sysmon shutdown request is getting
> sent to remote before QCOM_SSR_BEFORE_SHUTDOWN notification sent to
> kernel client due to which remote is not in a condition to communicate
> with kernel clients.
> 
> [...]

Applied, thanks!

[1/1] remoteproc: qcom: pas: Fix subdevice add order
      commit: cf5865e72236c239317d6c5829ab170419b400a4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
