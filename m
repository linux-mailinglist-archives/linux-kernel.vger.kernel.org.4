Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FDE68FEDE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjBIEbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjBIEay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:30:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C81392A8;
        Wed,  8 Feb 2023 20:30:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB372B8164F;
        Thu,  9 Feb 2023 04:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84CDC433D2;
        Thu,  9 Feb 2023 04:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916481;
        bh=b6x9nX8AHMNjnBjFNuhsM2MDIsAPB6OfZtaObaMtgA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z3esbmoyZz1FrFp/mxdTS1+ww3FCsmtiAbhUdooMuM6F+eELh9TZlZHOAY0ODureA
         S/KniWrcIBjaTMjz2j0Njg2ddnJ44TaGSNulRLqzuGbWPO5ob3a+bFMg8Z2wipaVFJ
         LJbDHQE0RQJdHZXR/slhIYXkii0pT6zm0XoZUu0guhbdjsVfEkTnqnA/BxqAYRP5Ze
         8ya898ALwe1sgN0d/o5gEWa1oDz9DfwCni/s0t4QRzJ6mGW28aeFLNQmU6cEoeWTY6
         voR4+W2WFuCvqmSHSimuVu996Xj9ObcShbsfA10F1EBnIAPw4y0my5kn9jlkB4ZFMp
         YWJR7LD0lTZ5w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     konrad.dybcio@linaro.org, agross@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: Add smp2p nodes
Date:   Wed,  8 Feb 2023 20:22:39 -0800
Message-Id: <167591660369.1230100.1964536070521962751.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230121200454.1423567-1-bhupesh.sharma@linaro.org>
References: <20230121200454.1423567-1-bhupesh.sharma@linaro.org>
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

On Sun, 22 Jan 2023 01:34:54 +0530, Bhupesh Sharma wrote:
> Add the adsp, cdsp and modem smp2p nodes to sm6115.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm6115: Add smp2p nodes
      commit: 77b1278ed0caa484f84b2c4a2d184a56ababfbcd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
