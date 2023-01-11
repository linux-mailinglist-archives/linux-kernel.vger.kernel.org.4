Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869F266538B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbjAKFUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjAKFSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:18:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3328B13E02;
        Tue, 10 Jan 2023 21:10:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C157861A34;
        Wed, 11 Jan 2023 05:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA6BC433D2;
        Wed, 11 Jan 2023 05:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413799;
        bh=Fk+Hs3fAFkGyo6IJh9NpJNbdmUCBctRBnwpsFk8n5K4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b8ICVfIfcabrXTSMtgm1OlfkvteT+fA22Qp0yfl+CgfQjMulbOBJ3h+q5MmMXPI1L
         KE9lwMOkugFAd9Ay3TyTTXpVdq/s3yOifA0Uk2jxUDyhJb7OFeAJeeR50LiLCNvNbu
         Z4slI/lwBfa6sF1hu6ocxKOJQicP7aq+T0b2pvu611cTS3URMMhPLM68fkCZVTbrKd
         ekK2hLy7mwJFpKHeUX7mDk+NkOKBdHoXeQAeZriic3R83HIlzdcMqM5uFvA5B/vOaO
         b2rnJ2FBmaD/uNGbUwZuSpCXlXjaSGzvmGjWV5eefyU1nn9RZ9JSqAmt+3koQxr0Z1
         abpL0OjzRQHBg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Subject: Re: (subset) [PATCH v4 1/3] dt-bindings: reserved-memory: rmtfs: Make qcom,vmid an array
Date:   Tue, 10 Jan 2023 23:09:24 -0600
Message-Id: <167341377741.2246479.8259536119397257522.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230109130523.298971-1-konrad.dybcio@linaro.org>
References: <20230109130523.298971-1-konrad.dybcio@linaro.org>
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

On Mon, 9 Jan 2023 14:05:21 +0100, Konrad Dybcio wrote:
> Some SoCs mandate that the RMTFS is also assigned to the NAV VM, while
> others really don't want that. Since it has to be conditional, turn
> qcom,vmid into an u32 array so that we can handle the NAV case, as
> well as other similar ones if they pop up in the future.
> 
> 

Applied, thanks!

[1/3] dt-bindings: reserved-memory: rmtfs: Make qcom,vmid an array
      commit: da0d37e42f93f7bd6351e7ef67a52ea9a272c761
[2/3] soc: qcom: rmtfs: Optionally map RMTFS to more VMs
      commit: e656cd0bcf3d2ba2eceac82b44714bf355428ec4
[3/3] dt-bindings: firmware: qcom: scm: Separate VMIDs from header to bindings
      commit: 45ca30eb9dfe622b00ce352cf28ee141d243254b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
