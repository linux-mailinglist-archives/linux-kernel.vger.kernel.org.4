Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D74866E6D7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbjAQTTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjAQTKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:10:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8BE37B45;
        Tue, 17 Jan 2023 10:24:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F268B614FF;
        Tue, 17 Jan 2023 18:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16C8C43392;
        Tue, 17 Jan 2023 18:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673979878;
        bh=czVktOgXkRuPu1oJmS3ILu9xXbBNAe/CglXIsvA3QgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=obXSHhwE6Qn4rJ/t5OBxn7f4jK6MIlkeJWNslCjTRtG3QfwhI3R9mYLwx+CjVqXpI
         ad8atj+w6kAy7LFjS0XSoIUZyO/9sfWCTODyltcLm3wVhlEw52QSiMz3sNcRVKAT4s
         lkWZGIRJRwhjHigbxwvoOwII2X+JQ/C9q7G15V6+6xabB4vWkfIw3GMMHQYIVuXP4P
         T2SkpITOGcd/lom2W8HFhE3huux/p4PliA/Eb2sAHGW78YD1BPeLT/9Z7fEhmPWJA1
         OZHwg8K/t9GmEr4SeAHYLb4eeXtwZNivJ4c/xQftA/It4cMctRG5GhCPnBui35ji+w
         ABayQN1guNvHw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     johan+linaro@kernel.org
Cc:     catalin.marinas@arm.com, Manivannan Sadhasivam <mani@kernel.org>,
        abel.vesa@linaro.org, dnlplm@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        will@kernel.org
Subject: Re: [PATCH v2] arm64: defconfig: enable Qualcomm PCIe modem drivers
Date:   Tue, 17 Jan 2023 12:24:23 -0600
Message-Id: <167397986260.2832389.15206531052682176190.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230115174450.11041-1-johan+linaro@kernel.org>
References: <20230115174450.11041-1-johan+linaro@kernel.org>
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

On Sun, 15 Jan 2023 18:44:50 +0100, Johan Hovold wrote:
> Enable the MHI PCI controller driver and the MHI NET and WWAN drivers
> for Qualcomm based PCIe modems such as the ones found on the SC8280XP
> Compute Reference Design (CRD) and Lenovo Thinkpad X13s.
> 
> 

Applied, thanks!

[1/1] arm64: defconfig: enable Qualcomm PCIe modem drivers
      commit: 9d523ba46944bf2db4960c908fd2889665d0aa88

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
