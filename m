Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB00868FF75
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjBIElK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjBIEk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:40:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A186A13DFD;
        Wed,  8 Feb 2023 20:37:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0074BB81FFF;
        Thu,  9 Feb 2023 04:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA812C433A8;
        Thu,  9 Feb 2023 04:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916501;
        bh=XBpGPZeL8XTfy9VO7r09l+ADYGLyAn3GkbuBH5MBYDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GhGqSBdXpd1rVykcZRLmBPUvbTGtge3Ou4zWXn6gsseF3IBTFVVqmmzkhNX6iIyjC
         eoQHcB+DPlvQmjlcqIeTNiiSUfnCHIFm9koKax3iikICnUasZeB6VkFla0jC6dJOwk
         jkJi/x8OhQ7EXEf0zGo97P5DX4Eh499UGoh138fZMEiDf5QQjel5Q9UMIwcWHomCDn
         uNwJF8y1H6LuSRn4O8g9NoNFFEL0+/ox4c4VzpCG9xBFiishhEsDaJT7mzZUxwn5Rm
         SqqnsZsDNEVdShZYhdl1R9OpezZnFNt8ujikRE+Czkk//Y06O50ayZVb1M/9ABcIFp
         pbu4KDjCLRMUA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rtc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v2 00/22] rtc: pm8xxx: add support for setting time using nvmem
Date:   Wed,  8 Feb 2023 20:22:57 -0800
Message-Id: <167591660371.1230100.17894948728225084854.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202155448.6715-1-johan+linaro@kernel.org>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Feb 2023 16:54:26 +0100, Johan Hovold wrote:
> This series adds support for setting the RTC time on Qualcomm platforms
> where the PMIC RTC time registers are read-only by instead storing an
> offset in some other non-volatile memory. This is used to enable the RTC
> in the SC8280XP Compute Reference Design (CRD) and Lenovo Thinkpad X13s
> laptop.
> 
> The RTCs in many Qualcomm devices are effectively broken due to the time
> registers being read-only. Instead some other non-volatile memory can be
> used to store and offset which a driver can take into account. On
> machines like the X13s, the UEFI firmware (and Windows) use a UEFI
> variable for storing such an offset, but not all Qualcomm systems use
> UEFI.
> 
> [...]

Applied, thanks!

[18/22] arm64: defconfig: enable Qualcomm SDAM nvmem driver
        commit: 480ba14b9a95641647a6561d5b246de661589514

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
