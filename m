Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BE671044C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbjEYEva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238062AbjEYEvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:51:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92975D8;
        Wed, 24 May 2023 21:51:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A2CF6429D;
        Thu, 25 May 2023 04:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8D5C433AA;
        Thu, 25 May 2023 04:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990263;
        bh=QySNBppZBR32n+suCi8IKAQ0qYwDs4H5dHzbPJW7OgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qt7zmVUMjl8VxSJOo+yJnpgZSqemZNB1gDa/0H6XbSukvekRCXbVPEfX8Q2BFMbCc
         ybRsOF0LNKhh4jHDlWSetdvKPbKxtZ8RD4/fEt2fRYraY7ezPb/C/Ae622Me0UHi8D
         rgokPAMYcH/xUG5tMY/zXFMVONEGG7wK9YGilsKQVugRRVYoALWMQ/X4vSW2JHqDpf
         +XtnTmYGxeoOEeOVhhJjTtQFvzeOLoGjrD8PzcBBNPk2oe1fIid6ZCMPyN0zffD+2f
         Bb0cU38gOBMxX1RzYerxREAVyhFgELVfjIozxez9bUQhJ/Bnvrx0ytK28MNl15fECG
         cwh4l+LJji1Ug==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: ramp_controller: Fix an error handling path in qcom_ramp_controller_probe()
Date:   Wed, 24 May 2023 21:53:43 -0700
Message-Id: <168499048181.3998961.4622923649419057574.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <84727a79d0261b4112411aec23b553504015c02c.1681684138.git.christophe.jaillet@wanadoo.fr>
References: <84727a79d0261b4112411aec23b553504015c02c.1681684138.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023 00:29:35 +0200, Christophe JAILLET wrote:
> 'qrc' is known to be non-NULL at this point.
> Checking for 'qrc->desc' was expected instead, so use it.
> 
> 

Applied, thanks!

[1/1] soc: qcom: ramp_controller: Fix an error handling path in qcom_ramp_controller_probe()
      commit: b3d0dcc8e359cf5d57fb6308bc9750af5da574b3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
