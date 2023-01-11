Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A1366539A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbjAKFV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjAKFSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:18:21 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E53EE16;
        Tue, 10 Jan 2023 21:10:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F1A11CE1AB1;
        Wed, 11 Jan 2023 05:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BF5C433F1;
        Wed, 11 Jan 2023 05:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413811;
        bh=BRIn83OXfYE22qZPXnA4wyZ6NN470qFG94q4fiFtAxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K7H38nD11vPL8LU0BPi45odUwfM3CSCA5OhkkkavazChnBh/AOYnjjVnPUYIEDq8g
         9BS0ZIzXw+j8j7I3l1kCSRg67zCgFCl5kq6468B5R00m9G/Nhc+Lxq5UrUQQSlCNdt
         PoMeP20Zbw0/+9oMusQV7qrZgu7wSW/b0wuHJMlUlvkvdYzfKz9FpgyANje8DpY2wP
         ZwN1rUcyV6GK/YHnCczhOANIy0VCKaVu2c9Zz2waspXlrmDFe8s9MOVsoI8quuZArL
         S0hGdfsP3AkIrFq0CNT9Yu3Tg4EWA1b8GjV0xBPwNwDFwHJxlSWLu83oiOYoiM7/Zq
         NPPxIGV41tubg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     phone-devel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, martin.botka@somainline.org,
        jami.kettunen@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        angelogioacchino.delregno@somainline.org, konrad.dybcio@linaro.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845-tama: Add volume up and camera GPIO keys
Date:   Tue, 10 Jan 2023 23:09:36 -0600
Message-Id: <167341377740.2246479.8223453101016717706.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230109234133.365644-1-marijn.suijten@somainline.org>
References: <20230109234133.365644-1-marijn.suijten@somainline.org>
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

On Tue, 10 Jan 2023 00:41:32 +0100, Marijn Suijten wrote:
> Tama has four GPIO-wired keys: two for camera focus and shutter /
> snapshot, and two more for volume up and down.  As per the comment these
> used to not work because the necessary pin bias was missing, which is
> now set via pinctrl on pm8998_gpios.
> 
> The missing bias has also been added to the existing volume down button,
> which receives a node name and label cleanup at the same time to be more
> consistent with other DTS and the newly added buttons.  Its deprecated
> gpio-key,wakeup property has also been replaced with wakeup-source.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sdm845-tama: Add volume up and camera GPIO keys
      commit: 4ce03bb80faed41e04b7d6f089275d262f4cfc79

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
