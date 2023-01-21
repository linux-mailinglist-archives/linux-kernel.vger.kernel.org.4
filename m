Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E567A67685F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 20:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjAUTYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 14:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjAUTXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 14:23:45 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ED228D26;
        Sat, 21 Jan 2023 11:23:44 -0800 (PST)
Message-ID: <f2266be7-b0b8-8b10-8b0f-e8bae4196917@ansari.sh>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1674329023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vkejwVXi6/FCUirpcEx8CpAKTfT9V6ZNYQg0zp0VucE=;
        b=OwsNbhHNx9WIgZg10kN708xweLzQ221HgXIvPxC37f/1ryTR4pKy5PrAjJOQ3oCIcuOWiD
        FsDCvT7ny40siLOVBMbvk0H0J1DJkwJjdl1rYfKLu/gT2coLXsXvy37AA0wXXDfh6kLiYW
        dYcq6ysXl0/TJKvDyVKJNMIYYgl41mM=
Date:   Sat, 21 Jan 2023 19:23:41 +0000
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/3] Add XO clocks for MSM8226/MSM8974
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
References: <20230121175838.755636-1-rayyan@ansari.sh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Rayyan Ansari <rayyan@ansari.sh>
In-Reply-To: <20230121175838.755636-1-rayyan@ansari.sh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2023 17:58, Rayyan Ansari wrote:
> Changes since v2:
> - Base off linux-next
> - Add correct XO clock to MSM8974 as well
> 
> Rayyan Ansari (3):
>    clk: qcom: smd: Add XO RPM clocks for MSM8226/MSM8974
>    ARM: dts: qcom: msm8226: add clocks and clock-names to GCC node

I've just noticed that rpmcc.h has somehow been missed in this commit. I 
will send v4 to address this.

>    ARM: dts: qcom: msm8974: add correct XO clock source to GCC node
> 
>   arch/arm/boot/dts/qcom-msm8226.dtsi | 5 +++++
>   arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
>   drivers/clk/qcom/clk-smd-rpm.c      | 2 ++
>   3 files changed, 8 insertions(+), 1 deletion(-)
> 

-- 
Rayyan Ansari
https://ansari.sh

