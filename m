Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E724664018F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiLBIHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiLBIHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:07:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761F5B26;
        Fri,  2 Dec 2022 00:07:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 011F461DD1;
        Fri,  2 Dec 2022 08:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4C3C433D6;
        Fri,  2 Dec 2022 08:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669968452;
        bh=1uhJa0usWhJzcL6S4WIUaqWRA60pTOMkeg94LevHE3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QnzAfRsuY+rCQ+cUYXP3AZBQSiil79WTGhdXBUIpkgsCdtXxddFCl+pgWPOryfLhO
         k9RyLfw6nRg+HFHKwy9it9eseCxdYBBuol2OyospDin/xHzsxrjkQe0ALI6HXDD9wj
         g/vd5DA37K1g4XWDfaB0ssHAyYkSnB9sjz6brCxU/pe6bv7w0SwzJEgU3rGcdhLh2I
         ofbIZRLlBKroUAO6uAUmowNCOB9x+eoFZHmkgejVMGnA3tiT+5oD2v6oy4HaJUKei4
         Y033vz3h8fzaHQSxrZ/Zf5FaNDCfV677BeD5IbfXRS6hIDodqzt2p6QmafuEimV1No
         FAhg52az7eHtQ==
Date:   Fri, 2 Dec 2022 08:07:26 +0000
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] leds: qcom,pm8058-led: Convert to DT schema
Message-ID: <Y4myPkrukylAUokB@google.com>
References: <20221201131505.42292-1-krzysztof.kozlowski@linaro.org>
 <6f5ef197-057f-400e-d4e0-649ed5becd38@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f5ef197-057f-400e-d4e0-649ed5becd38@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Dec 2022, Krzysztof Kozlowski wrote:

> On 01/12/2022 14:15, Krzysztof Kozlowski wrote:
> > Convert the Qualcomm PM8058 PMIC LED bindings to DT schema.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  .../devicetree/bindings/leds/leds-pm8058.txt  | 67 -------------------
> >  .../bindings/leds/qcom,pm8058-led.yaml        | 57 ++++++++++++++++
> >  .../devicetree/bindings/mfd/qcom-pm8xxx.yaml  |  4 ++
> >  3 files changed, 61 insertions(+), 67 deletions(-)
> 
> Note to myself:
> 
> Use subject prefixes matching the subsystem (git log --oneline -- ...).

=:-D

-- 
Lee Jones [李琼斯]
