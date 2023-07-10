Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DD474CC01
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjGJFIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjGJFG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:06:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E160D2694;
        Sun,  9 Jul 2023 22:05:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43F8360E65;
        Mon, 10 Jul 2023 05:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26802C433C9;
        Mon, 10 Jul 2023 05:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965505;
        bh=pTWf8VbU7km1ta55h/GIT4neKxUxAppboCzEG4pL4rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fu7snaFk9uOhC4WmLyUHrYMbnC4vLpHYetRXoPlO+xx+MmltwT8CBvbmLe3LQ8NCL
         w6fhcFaiW2LzDpkUvGoKjr4SIqJk+0vzjJzOZFvqksmmEvPbhWSWkeT9f+YkpREzYi
         0pnTd0znvANdrCB8Rf50r+7wRoG9S6CTYKWfvJjZXeRd5iEJOAkRGdhO1qHTwUGkbt
         4W0G1J1rWa157O1PUdGsD3f6JTlEyduI+cBdg+sR2ayZHaipnhrPX+CW3JqMXo4M1+
         q+zqc6oZVAg+An/HPHHfmV+2qdR2bUzoQ2eZqlP8kzv6yoF7n6AUW1jtGttPpcNuY0
         FERMPYt4cHWGA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: cmd-db: Drop NUL bytes from debugfs output
Date:   Sun,  9 Jul 2023 22:07:43 -0700
Message-ID: <168896565964.1376307.7835601871848855075.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620213703.283583-1-quic_bjorande@quicinc.com>
References: <20230620213703.283583-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Jun 2023 14:37:03 -0700, Bjorn Andersson wrote:
> The debugfs dump of Command DB relies uses %*pEp to print the resource
> identifiers, with escaping of non-printable characters.
> But p (ESCAPE_NP) does not escape NUL characters, so for identifiers
> less than 8 bytes in length the output will retain these.
> 
> This does not cause an issue while looking at the dump in the terminal
> (no known complaints at least), but when programmatically consuming the
> debugfs output the extra characters are unwanted.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: cmd-db: Drop NUL bytes from debugfs output
      commit: d4600cbd5bcbaa2b296b5cf9a5c04408eedb4ef3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
