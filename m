Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C505EFB35
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbiI2Qpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbiI2Qpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:45:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193FB1176F9;
        Thu, 29 Sep 2022 09:45:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62F9DB82366;
        Thu, 29 Sep 2022 16:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E831C43141;
        Thu, 29 Sep 2022 16:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664469939;
        bh=RU7BmP5Ql0DSymD3nPR+25XUkv4WRt4tITI9LnKOcNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G3VwGI9X1eVQlICptnrTyV/D7AUk1bGaMswPZrYPbsAVdt2DU4RUR4S6Lg0vCZQaF
         7Mpdesiik6SUJE//NEfOfYvtHsochHGDq4PZMpCHq8OM2wLXTGghJ9A6HKzPkreaWO
         Lu4tCI8Aw8JggGknYMt9gOm7BAX33AWWG4AK9miD6wASSinGMNuCcZV4/hrMrVtY1V
         5+bLev/dLpA10eUbh00+J1J3pnkxJB34ZHjweeoC+bf3Luwe6gVVeStIMy4gu5sz72
         oxIJI9iUf7nMkfWH9+Szj1bKBtYqSc+qXuEBXcqPXgAdnPKyzdT893zQdeekuj0DEN
         F0jN7f4UUJURQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     luca.weiss@fairphone.com, linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, quic_rjendra@quicinc.com,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH] clk: qcom: gcc-sm6350: Update the .pwrsts for usb gdscs
Date:   Thu, 29 Sep 2022 11:45:34 -0500
Message-Id: <166446992873.1979534.9316423661140953351.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220928132853.179425-1-luca.weiss@fairphone.com>
References: <20220928132853.179425-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2022 15:28:54 +0200, Luca Weiss wrote:
> The USB controllers on sm6350 do not retain the state when
> the system goes into low power state and the GDSCs are
> turned off.
> 
> This can be observed by the USB connection not coming back alive after
> putting the device into suspend, essentially breaking USB.
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: gcc-sm6350: Update the .pwrsts for usb gdscs
      commit: a01ef02093ac45cc4991dbf93134c3cb4c293c32

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
