Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3D16AD61B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 05:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjCGERd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 23:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCGERO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 23:17:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFC957083;
        Mon,  6 Mar 2023 20:17:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 56E80CE1A9B;
        Tue,  7 Mar 2023 04:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13335C4339C;
        Tue,  7 Mar 2023 04:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678162629;
        bh=mgVdaHhefJP4rIOoui8FKWRblgZ1hKnLBJUMiBZ0re8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VHkHyO3f9aoL7u+UkrO4ZuRn5nxnIdw6nsmBJSt4n3T0C3dCuJPzKmW0tf5lWs6+n
         14NI/19+Wr4+CSdKzJ1iPIJRr7A5ZbRdOAncGzE4qhJIcNL8jVSDEC0FkXZAbN4pDN
         aCQimU6cA3awg64+grHqAlYMN/r/rt5HxzkPeHkBDHWJwxVQ1HbN2chqEFpfWXl9Rm
         IKxLvZvGV5uwA6OnezbvTU+ijr8RBCXEmUNOH8aMKVpfO+xAc5+zkfAepHIaHtDunl
         HngIgD/DtKdGXgFX1KeNroNXzblkvKVLvHPuzg9uMoRZ9VIcO4q2iPBJbhe5zk/mrU
         6+l9ujbSww3ig==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Steev Klimaszewski <steev@kali.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@linaro.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Add label property to vadc channel nodes
Date:   Mon,  6 Mar 2023 20:20:33 -0800
Message-Id: <167816282863.1458033.17181990811796338430.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230211052415.14581-1-manivannan.sadhasivam@linaro.org>
References: <20230211052415.14581-1-manivannan.sadhasivam@linaro.org>
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

On Sat, 11 Feb 2023 10:54:15 +0530, Manivannan Sadhasivam wrote:
> For uniquely identifying the vadc channels, label property has to be used.
> The initial commit adding vadc support assumed that the driver will use the
> unit address along with the node name to identify the channels. But this
> assumption is now broken by,
> commit 701c875aded8 ("iio: adc: qcom-spmi-adc5: Fix the channel name") that
> stripped unit address from channel names. This results in probe failure of
> the vadc driver:
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp: Add label property to vadc channel nodes
      commit: 8013295662f55696e5953ef14c31ba03721adf8f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
