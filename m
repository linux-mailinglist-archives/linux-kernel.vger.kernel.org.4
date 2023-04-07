Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7366DB1BC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjDGRic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjDGRia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:38:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7FDB45D;
        Fri,  7 Apr 2023 10:38:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55A54652AB;
        Fri,  7 Apr 2023 17:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB83C433EF;
        Fri,  7 Apr 2023 17:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680889108;
        bh=5i2sjxQYf0zwELjWzTDgKKiTMFUoohXEOL6uaROMG3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6OhYFsiQVVfZPmAZ5bdc+SMI8ysLrmSiWjJzFVP9znTza0FDgRP9QEnAtjedOGaD
         Djmcu7HoY62WPZVsOXC9jBZOpcCbef01GEVEagHJlOCYNDqw3MJjwesOD2/OyraqY+
         cWEBMo0sHBxtpiUxUZPrhZ2flNnh987sRGmffaL0l0/zs6j31x9jMCF+mJO3Bx5bBv
         6EzNOKFUWDDTEJPt3YvgkkPvJoJn0iBW6l5gTyNwrEchBJ8zoYBACEkFykNaW0soCA
         cn9+1ZUyd3n+sSu5Chi2MfztH0SXnNzyXBF8PJQM71L+orKpsdo0t1M0833dwEXDE8
         EfpYn4bidsvCg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: qcom: Add reviewer for Qualcomm Chromebooks
Date:   Fri,  7 Apr 2023 10:41:06 -0700
Message-Id: <168088927579.2561591.14968697147567854507.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330141051.1.If8eb4f30cb53a00a5bef1b7d3cc645c3536615ec@changeid>
References: <20230330141051.1.If8eb4f30cb53a00a5bef1b7d3cc645c3536615ec@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023 14:11:00 -0700, Douglas Anderson wrote:
> Developers on the ChromeOS team generally want to be notified to
> review changes that affect Chromebook device tree files. While we
> could individually add developers, the set of developers and the time
> each one has available to review patches will change over time. Let's
> try adding a group list as a reviewer and see if that's an effective
> way to manage things.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: qcom: Add reviewer for Qualcomm Chromebooks
      commit: cb5d1dd3a74a7c7c3ad31d5fa2cc00e86c209dcc

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
