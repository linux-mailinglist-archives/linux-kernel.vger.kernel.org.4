Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871496C827B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjCXQhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjCXQhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:37:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8224B1B2DF;
        Fri, 24 Mar 2023 09:37:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9DAACCE26EC;
        Fri, 24 Mar 2023 16:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB6DC433EF;
        Fri, 24 Mar 2023 16:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679675843;
        bh=ZelXE9QN0odM67Dh4M8RR8fK17GurYWtxsvCvepE0fo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TfvB4eDGzQlzyzb1E8JroMzTrFbCO44RUd0KZPQM5VUTYCr/cW81i0Fa2mdk7HSWK
         XUNM7CwDpn+3wgTLumhCi7Rcl1m+85OTQdbyrCEETTunS3Hhmm12feRUqnzZyKjMsD
         4zqY1W1JOLbjPYojF9dyH8MOYjVpe5GF1VAzmABzS5skT1CsSb1CjbGattu2KDXqb0
         bNOzXbz+MWiXWQSY6470rdCGR/BtPB4WYRimUmS2micWRfSoS7CkMPLcvBfvsi6ZzR
         YjKfZXCYzc1jIuVyToeL7YZxWIj7sCY1MVLjSy/Tc9vRcVVi6Wir+G3DDB/5n3ymo4
         Ems/+YqU6cuXg==
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230324063357.1.Ifdf3625a3c5c9467bd87bfcdf726c884ad220a35@changeid>
References: <20230324063357.1.Ifdf3625a3c5c9467bd87bfcdf726c884ad220a35@changeid>
Subject: Re: [PATCH] regulator: qcom-rpmh: Revert "regulator: qcom-rpmh:
 Use PROBE_FORCE_SYNCHRONOUS"
Message-Id: <167967584071.2616913.12432168406057271810.b4-ty@kernel.org>
Date:   Fri, 24 Mar 2023 16:37:20 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 06:34:06 -0700, Douglas Anderson wrote:
> This reverts commit 58973046c1bf ("regulator: qcom-rpmh: Use
> PROBE_FORCE_SYNCHRONOUS"). Further digging into the problems that
> prompted the us to switch to synchronous probe showed that the root
> cause was a missing "rootwait" in the kernel command line
> arguments. Let's reinstate asynchronous probe.
> 
> 
> [...]

Applied to

   broonie/regulator.git for-next

Thanks!

[1/1] regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS"
      commit: ad44ac082fdff7ee57fe125432f7d9d7cb610a23

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

