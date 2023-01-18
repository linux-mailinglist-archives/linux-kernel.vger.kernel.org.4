Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2060672BBC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjARWul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjARWue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:50:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEBF4CE40;
        Wed, 18 Jan 2023 14:50:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EADE8B81F70;
        Wed, 18 Jan 2023 22:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E26DC433D2;
        Wed, 18 Jan 2023 22:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674082231;
        bh=GVjj5wv/W5r/JII8diz1Kv9XSvPiIbibbdcOM15O5xI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jc0YgQwM7BEg5Ex5QHeLykneFg18l9PKawsGooxUjc/bcg1KwK+os/Zct5hrMlUh0
         /G+u6sz1NU8lQHSBw63z7+JOWH4NI9oytdOWlXveppanadRXjVPe8ihzOnLFyrdMWp
         8axVKGLffxlF2S5F4JTS1gwBUfwUjHdWOG5Pq7eJhIOigL6G37RZH1TzTFYztzGjbJ
         I5Te+neg/Nk5H/U1ng0vJfuNIYaZIid6cbA4xrHbhjd5anN3eYsu4APr22454c4DaD
         0rBklk8C3IACsRXqhv2Oj+Q5UfxZcwmTQ5gDrSD83aydU4pi7O5k1ooKvJhTVInt4e
         I4bJHQv43T2aw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        bryan.odonoghue@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        djakov@kernel.org, agross@kernel.org
Cc:     shawn.guo@linaro.org, dmitry.baryshkov@linaro.org,
        devicetree@vger.kernel.org, fabien.parent@linaro.org,
        benl@squareup.com, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        leo.yan@linaro.org
Subject: Re: (subset) [PATCH v3 0/8] Add MSM8939 SoC support with two devices
Date:   Wed, 18 Jan 2023 16:50:21 -0600
Message-Id: <167408222413.2952004.17840128703188022875.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
References: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
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

On Tue, 17 Jan 2023 02:48:38 +0000, Bryan O'Donoghue wrote:
> V3:
> - Happily I don't currently depend on any other series to be merged.
>   Bjorn and Chanwoo picked up everything I need to unblock this series. ＼(^o^)／
> 
> - Moves xo_board to RPM/PMIC clock gated CXO, not including rpmcc: obvs - Konrad/Bjorn
> - qcom,msm-id = <239 0> - left as in V2 valid according to Sony references - bod
> - cpu-release-addr - as stated below we rely on lk2nd to take the second cluster
>   out of reset - bod
> - smem child node update - Konrad
> - Whitespace updates - Konrad
> - gpu no interconnect - Konrad - No bod
> - 19.2 MHz dropped from timer@b020000 - Konrad
> - Added vreg_dummy comment - Konrad
> - sdc_pins grouped - Konrad
> - startup-delay-us = <0> - left as is
> - bias - added no-bias - Konrad
> - :g/msmgpio/s//tlmm/g - Konrad
> - mdss/s//display-controller - Konrad
> - l11 set-load - Korad
> 
> [...]

Applied, thanks!

[4/8] clk: qcom: smd-rpm: msm8936: Add PMIC gated RPM_SMD_XO_*
      commit: d03de4179540e9cee6e3f664e1b65178f07bb612

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
