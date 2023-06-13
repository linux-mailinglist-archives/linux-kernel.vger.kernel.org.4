Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EEB72EF57
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241014AbjFMW21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240276AbjFMW1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:27:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA881FEB;
        Tue, 13 Jun 2023 15:27:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAA5363B99;
        Tue, 13 Jun 2023 22:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8467C61189;
        Tue, 13 Jun 2023 22:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695250;
        bh=UfFq18SdE+0Yu8PGuObPISCOzDlEbYeLkDtsbj7uzTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QQ1kPAxJurXn2qa0GiBAX4JjoPK//TYnrFCmaX0qJmhrdQ+2NgS0KWZsFcY9RsL8V
         mfjVSsIrPwCgqo3kyMXpXRgfiPY2/2uM7hRwwd89cmJA9+JbdJQySmHdMfpQqM+kH7
         wNRE0pT4zlTPoqyfwfjEKuiMyuhubSwBTGx+bwp0438CkjtFiZZAinf9EIJg3NIiDB
         9YnE5YtG/XD7+Yv8Gmwr/axLFiRDunwHwNYvqddz9vVlDZv29x9NLTc1c62UKUvhXE
         hyallG/3MU9VBVENmr59QsDAbZmHEorOgXYMF9SDMLBCkxBatH/t4iq6kdnVBYgr4t
         bLIEa0QgZANuA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: mdt_loader: Fix split image detection
Date:   Tue, 13 Jun 2023 15:30:26 -0700
Message-Id: <168669542893.1315701.7917575988256964761.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612215804.1883458-1-quic_bjorande@quicinc.com>
References: <20230612215804.1883458-1-quic_bjorande@quicinc.com>
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

On Mon, 12 Jun 2023 14:58:04 -0700, Bjorn Andersson wrote:
> The enhanced detection introduced in commit '210d12c8197a ("soc: qcom:
> mdt_loader: Enhance split binary detection")' requires that all segments
> lies within the file on disk.
> 
> But the Qualcomm firmware files consistently has a BSS-like segment at
> the end, with a p_offset aligned to the next 4k boundary. As the p_size
> is 0 and there's nothing to load, the image is not padded to cover this
> (empty) segment.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: mdt_loader: Fix split image detection
      commit: 0d25da8e7e1e35bdbb521d586be1954bdedd1cca

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
