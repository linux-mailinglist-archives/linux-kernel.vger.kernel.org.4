Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1265EAC35
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbiIZQOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbiIZQOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:14:25 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE619DD9A;
        Mon, 26 Sep 2022 08:03:11 -0700 (PDT)
Received: from g550jk.localnet (2a02-8388-6582-fe80-0000-0000-0000-0006.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::6])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id BD3B8C78D3;
        Mon, 26 Sep 2022 15:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1664204560; bh=wkbN5vNDaAVsTudzKY17LVwL1TS+OEPbh2MTMpQy+WQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=moKPycwe66MhuIZxgFI5r80qndhWjE4ey8kfOEdOqhlOra/Kh95IZGRjP2Ww4Uvq9
         Yzod6abybHAxp69zVdQo4VVfuEkepIm7j3hvZpA+N9JFmhfCYBEt5G+jAFJBBfxY0M
         4g3ar7+hlZySbuLDkEnjLXF/uPrsDw51nbrZ+VgU=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8916: Align dsi phy-names with schema
Date:   Mon, 26 Sep 2022 17:02:39 +0200
Message-ID: <2253302.ElGaqSPkdT@g550jk>
In-Reply-To: <205a80be-de12-b610-eef2-e9e42179cf02@linaro.org>
References: <20220925172443.92900-1-luca@z3ntu.xyz> <20220925172443.92900-2-luca@z3ntu.xyz> <205a80be-de12-b610-eef2-e9e42179cf02@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Montag, 26. September 2022 10:53:03 CEST Krzysztof Kozlowski wrote:
> On 25/09/2022 19:24, Luca Weiss wrote:
> > Use dsi instead of dsi-phy as required by the binding.
> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> 
> Already sent:
> 
> https://lore.kernel.org/all/20220924090108.166934-4-dmitry.baryshkov@linaro.
> org/

This patch is phy-names property while the other patch is for node name, 
unless I'm missing something.

But as Dmitry pointed out, there's a patchset to completely remove the 
property which is also totally fine by me.

Regards
Luca

> 
> Best regards,
> Krzysztof




