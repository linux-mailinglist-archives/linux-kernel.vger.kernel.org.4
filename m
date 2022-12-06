Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C171644B7D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiLFSWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiLFSU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:20:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210C03E091;
        Tue,  6 Dec 2022 10:20:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44B5C6185C;
        Tue,  6 Dec 2022 18:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4C0C433C1;
        Tue,  6 Dec 2022 18:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350813;
        bh=LOQbxQDoEzZETaZbnWX29F7ZDynLLisvRUD4Qw8dfo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dMsKU35tKlLZbyP7x2eRMyRz9ndPNbajp2AHlwdN1f4Gkl59z4Tq1j5GVXUJcay7S
         OFn4rbJsSpwgpoGFbJGJ5uvoewCyqc3/08c4uMVNPwUykR5ccd9FP9CDDO1VOixjh+
         5M+yMVOLOiVoYAas3GG+KWSzp/8uTcHNCfvUc//Lgo3snt62xCVanHDZFg06V8HdFA
         i16gjoPo+jGm/+GC+5tKm0T896lRYsOeD7jcBDHvvjlb2b2Eav1FE0cPqlMdWK5nyO
         d24cakxfqfzxLEsfv8nuDbfO0yF0G2NrG+zt4MpH2D9wU6Oi0Mtnc1X4inCzIKtbeE
         dTIP+z9KXZxkQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linmengbo0689@protonmail.com, linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, nikita@trvn.ru,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        konrad.dybcio@linaro.org, stephan@gerhold.net
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-wingtech-wt88047: Add flash LED
Date:   Tue,  6 Dec 2022 12:19:19 -0600
Message-Id: <167035076345.3155086.4844046479791564816.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221128051512.125148-1-linmengbo0689@protonmail.com>
References: <20221128051512.125148-1-linmengbo0689@protonmail.com>
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

On Mon, 28 Nov 2022 05:16:32 +0000, Lin, Meng-Bo wrote:
> WT88047 uses OCP 8110 Flash LED driver. Add it to the device tree.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8916-wingtech-wt88047: Add flash LED
      commit: 8b607c57655154ce4516d5d195bd174e6f0bede0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
