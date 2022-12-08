Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29B9646863
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 06:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLHFGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 00:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLHFGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 00:06:22 -0500
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Dec 2022 21:06:20 PST
Received: from devico.uberspace.de (devico.uberspace.de [185.26.156.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F6E8DBE7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 21:06:19 -0800 (PST)
Received: (qmail 23370 invoked by uid 990); 8 Dec 2022 04:59:37 -0000
Authentication-Results: devico.uberspace.de;
        auth=pass (plain)
From:   Leonard Lausen <leonard@lausen.nl>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        catalin.marinas@arm.com, will@kernel.org
Cc:     robin.murphy@arm.com, amit.pundir@linaro.org, andersson@kernel.org,
        quic_sibis@quicinc.com, sumit.semwal@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH] Revert "arm64: dma: Drop cache invalidation from
 arch_dma_prep_coherent()"
In-Reply-To: <20221114110329.68413-1-manivannan.sadhasivam@linaro.org>
References: <20221114110329.68413-1-manivannan.sadhasivam@linaro.org>
Date:   Thu, 08 Dec 2022 04:59:16 +0000
Message-ID: <868rjijxsr.fsf@lausen.nl>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Bar: -
X-Rspamd-Report: BAYES_HAM(-1.364397) MIME_GOOD(-0.1)
X-Rspamd-Score: -1.464397
Received: from unknown (HELO unkown) (::1)
        by devico.uberspace.de (Haraka/2.8.28) with ESMTPSA; Thu, 08 Dec 2022 05:59:36 +0100
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
> This reverts commit c44094eee32f32f175aadc0efcac449d99b1bbf7.
>
> As reported by Amit [1], dropping cache invalidation from
> arch_dma_prep_coherent() triggers a crash on the Qualcomm SM8250 platform
> (most probably on other Qcom platforms too).

On sc7180 with c44094ee applied, it does not trigger crash but makes
Wifi dysfunctional by preventing initialization of ath10k_snoc.

qcom-q6v5-mss 4080000.remoteproc: PBL returned unexpected status -284098560

With the revert of c44094ee, wifi works fine again.

Thank you
Leonard
