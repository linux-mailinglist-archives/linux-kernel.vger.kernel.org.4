Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9244D65893D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 04:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbiL2Dp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 22:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbiL2Dpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 22:45:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9304CBCE;
        Wed, 28 Dec 2022 19:45:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 563D1B81919;
        Thu, 29 Dec 2022 03:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D27C433D2;
        Thu, 29 Dec 2022 03:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672285543;
        bh=9VyqVOPLYNAauiCh0jZNa43f/bOKcdJMq44I7kXU9I4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nBddxy2U9sUC1mMBdygi2b1iM/EIqwpaf02vFZ2Uzxl8KVspmk9UmmzufibvRc7D6
         cT1S/jT4oFWkrnm99vf7f/jv25aYVS93CDzgQyMs3WB9Y0pjBJ2VBXjNEyfQ+Hf+Yt
         7QlYWHyTfpnxCpWrPQvCDVS/c8hCE/SGZY0/5ed8sFWU9fC/q0cr1tAmz7cESc8Qsg
         YeTlqeLypRL43X2o28W1BJeAohX5s4mam+PXzxkQJZzD3lDGAtwZEnEiH6hbtyT/mR
         D3k5vU7L3E+Shn61UhOtuPlIJP9AmzPkInqL7KdsZesvWN2JvJ4UCzvyMZnarc6qex
         ZBVOVP52uN6/g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     rayyan@ansari.sh, linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@somainline.org, agross@kernel.org
Subject: Re: [PATCH 0/3] ARM: dts: qcom: pm8226: style fixes and new nodes
Date:   Wed, 28 Dec 2022 21:45:39 -0600
Message-Id: <167228553503.1017132.8709562208620324843.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221223193403.781355-1-rayyan@ansari.sh>
References: <20221223193403.781355-1-rayyan@ansari.sh>
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

On Fri, 23 Dec 2022 19:34:00 +0000, Rayyan Ansari wrote:
> The following patches sort the nodes and includes in PM8226's
> device tree file, and add new nodes for PON (with the resin sub-node)
> and IADC.
> 
> Rayyan Ansari (3):
>   ARM: dts: qcom: pm8226: sort includes alphabetically and nodes by
>     address
>   ARM: dts: qcom: pm8226: add PON device node along with resin sub-node
>   ARM: dts: qcom: pm8226: add IADC node
> 
> [...]

Applied, thanks!

[1/3] ARM: dts: qcom: pm8226: sort includes alphabetically and nodes by address
      commit: bc6ecf993b10238b4747261f5b495ecd46a72833
[2/3] ARM: dts: qcom: pm8226: add PON device node along with resin sub-node
      commit: 79ca56c11e9004ba1b012822a68eb4d57826a721
[3/3] ARM: dts: qcom: pm8226: add IADC node
      commit: 07eccde43b030bf8129fea1a81c00946c9edf1fe

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
