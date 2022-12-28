Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009986572D9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 05:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiL1Ejl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 23:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiL1Eh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 23:37:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E237DE0F7;
        Tue, 27 Dec 2022 20:37:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 564FBB81210;
        Wed, 28 Dec 2022 04:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118FEC433EF;
        Wed, 28 Dec 2022 04:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672202240;
        bh=NaXpUJvVkA5n474Mp4kxx6ee7AqAkBBwsxiGjDapjUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dYTGlgEQVstRlEtgA1TutuK2is1shHczJS9EXr9MJnBNv95SjCpdititIhjZfXIxW
         Zgs/GwPK6LSv4Kv9D+WGGDV7wQQ8RkAM5crKCvnYzeQZSOSWulJbqzqCnNEbGTi85n
         slV+orl5iTLdBK3E32ToTlOKMMIhV0bxfxZzDho6y9jwUweixhzvrLPunnko8AC+HN
         S9RNUkLLHKBeuw1nzVhEqB6f5ESlZtN7xtw0VgIpuRAuBRWyx2/Z+UeU1dgqlNK06C
         v0OVZBOMY5I2TtP8C2EDmvV5KZgqF2HubklBBjmEbi1bPedGUMwXU1xXW18HaFmQtW
         q99IRhNNULrEA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     konrad.dybcio@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Martin Botka <martin.botka@somainline.org>,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, jami.kettunen@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8150-kumano: Panel framebuffer is 2.5k instead of 4k
Date:   Tue, 27 Dec 2022 22:36:54 -0600
Message-Id: <167220221231.833009.15387650474127337257.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221209191733.1458031-1-marijn.suijten@somainline.org>
References: <20221209191733.1458031-1-marijn.suijten@somainline.org>
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

On Fri, 9 Dec 2022 20:17:33 +0100, Marijn Suijten wrote:
> The framebuffer configuration for kumano griffin, written in kumano dtsi
> (which is overwritten in bahamut dts for its smaller panel) has to use a
> 1096x2560 configuration as this is what the panel (and framebuffer area)
> has been initialized to.  Downstream userspace also has access to (and
> uses) this 2.5k mode by default, and only switches the panel to 4k when
> requested.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm8150-kumano: Panel framebuffer is 2.5k instead of 4k
      commit: be8de06dc397c45cb0f3fe04084089c3f06c419f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
