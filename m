Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D8967BFE0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 23:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbjAYWZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 17:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAYWZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:25:14 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98637CA3B;
        Wed, 25 Jan 2023 14:25:12 -0800 (PST)
Message-ID: <4c531c68-b74f-2f90-e8f6-98a4b0316cd4@ansari.sh>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1674685510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R90IOuy0iSwNHOL4lLloLfwx6viTyQ4Kc8W05QGyzLw=;
        b=Vsw+7KxhRetIF7RueAZ7dDX0RaGBV5oqgELHFnoEpgMrjfBDtYgxuAMT6m+8juBnpZM/G4
        i70kvo1i59Y5PLxcmk59vTpITQC4m4xyBgg8s5mDhNFdy168UBuR1VVBl9fGnl6z7HlQpO
        Me9s+ihX0XTO1HmHQsUZh+43WYYiPmM=
Date:   Wed, 25 Jan 2023 22:25:08 +0000
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/3] clk: qcom: smd: Add XO RPM clocks for
 MSM8226/MSM8974
To:     Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20230121192540.9177-1-rayyan@ansari.sh>
 <20230121192540.9177-2-rayyan@ansari.sh>
 <06d53a3fa48080d902476b71308e69bd.sboyd@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Rayyan Ansari <rayyan@ansari.sh>
In-Reply-To: <06d53a3fa48080d902476b71308e69bd.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 20:58, Stephen Boyd wrote:
> Quoting Rayyan Ansari (2023-01-21 11:25:38)
>> Add the XO and XO_A clocks to the MSM8974 clock list, which is also
>> used on MSM8226.
> 
> Why was this missing for so long? Does this break suspend? Why are you
> adding it now?

I am adding it because of a recommendation from a maintainer on an older 
patch version.
See 
https://lore.kernel.org/linux-arm-msm/20230119023337.h6a7f56lizhv4tcy@builder.lan/#t
