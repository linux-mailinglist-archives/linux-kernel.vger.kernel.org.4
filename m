Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D1A644B8A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiLFSW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiLFSV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:21:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D2E4045C;
        Tue,  6 Dec 2022 10:20:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A08C261825;
        Tue,  6 Dec 2022 18:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6835EC433D7;
        Tue,  6 Dec 2022 18:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350822;
        bh=+mGSgVmUAksNTw4eSG25KiTUdQfcAYqt40jQqsQTlQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YQHRVO13aEiayiKziGi1DLKbTaGnT8zb25DL5jxwpJdKiSSgGTXyoOmykZAOiARdv
         M71LuPFg55DZ3JCEQHb0hrLKJR7a08CvAT7QFc20H4oOskkgHbwUuobpUjfEkpADE1
         BvcG3LraBk2dSocykBLLURWXIpWEv4wtHNQjai6Hwl96NIEkYZu0ndjWibI5ca42zm
         Uk7M5F6C7wak8iCgFiyCNIkFoCaxHmmDZqLgVv1nGrsE6ELclkXMpsVFpug6PS4ECp
         ZcVXMkBxOlG/ALBF6f8ZQi++KK3vyU5o7zjjRjqWBTdLQ4+YLxZ8jzZHnXv/9sUFdB
         4hRzQeiAXnyqw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_bjorande@quicinc.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Andy Gross <agross@kernel.org>,
        konrad.dybcio@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sa8295p-adp: Add RTC node
Date:   Tue,  6 Dec 2022 12:19:27 -0600
Message-Id: <167035076321.3155086.15693298952198425598.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221205174309.16733-1-quic_bjorande@quicinc.com>
References: <20221205174309.16733-1-quic_bjorande@quicinc.com>
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

On Mon, 5 Dec 2022 09:43:09 -0800, Bjorn Andersson wrote:
> The first PM8540 PMIC has an available RTC block, describe this in the
> SA8295P ADP. Mark it as wakeup-source to allow waking the system from
> sleep.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sa8295p-adp: Add RTC node
      commit: 30d70ec8f7fd0c5ecb7f27894dd2514b160257e2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
