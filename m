Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29827615175
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 19:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiKASWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 14:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiKASWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:22:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00E31D651;
        Tue,  1 Nov 2022 11:22:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33571B81ED4;
        Tue,  1 Nov 2022 18:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB5EC433D6;
        Tue,  1 Nov 2022 18:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667326948;
        bh=SkLGoh/G/Ccu4mzFQCDMKNE7bnqED9RMClnbP9JkKAE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=e6umm3EcdpjO5su8IciWWj0YCHxfH4qJBA+fWd7C83QMdIzrma0mqgDjj3U5TaIgm
         xNJeKJ0oQoT/oHsSFn+11HnV3i2ZuRdcefR5Agwkk01QvP07I/NvKl/uw/rIkhYEnJ
         +o85WgCIGjg5FD4w0yeC1hGJ0l1jyn1KiVXKbvimleqCKMfsiB1bXZUeek0EKtro0Q
         pCzdRa5lEpidHktlHwahYM23BuumORt2ULLQ157damvOLMm+HE4TWdWIoZn+jeVonO
         4NzoVzxTJIGVCWcVUmt3vOGYxD3eprG8fPL/g+jygD/+nkXoRvWVmuC6CyIgMLTOV+
         JjBMoxkkSMqPw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221101173355.339573-1-manivannan.sadhasivam@linaro.org>
References: <20221101173355.339573-1-manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH] clk: qcom: gcc-sm8250: Use retention mode for USB GDSCs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     konrad.dybcio@somainline.org, mturquette@baylibre.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Date:   Tue, 01 Nov 2022 11:22:26 -0700
User-Agent: alot/0.10
Message-Id: <20221101182228.CBB5EC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2022-11-01 10:33:55)
> USB controllers on SM8250 doesn't work after coming back from suspend.
> This can be fixed by keeping the USB GDSCs in retention mode so that
> hardware can keep them ON and put into rentention mode once the parent
> domain goes to a low power state.
>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Any fixes tag?
