Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD8D6BC195
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjCOXh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbjCOXhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:37:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3832A76AC;
        Wed, 15 Mar 2023 16:35:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3776FB81FAD;
        Wed, 15 Mar 2023 23:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB78C43443;
        Wed, 15 Mar 2023 23:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923176;
        bh=EbRrw49NitE7LOxv+q9uhmdSyh1k8xyQhVVyAh7Ip00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ecWgw4qky3NfLh5+ywf4Eym9iaUC/q83yI6royAbOwS37LdmznfBk+Cpkk74NF9w9
         +XZO26WDBLPAz7bFjgfqSXoZAjJwIo46Dh0qzB3KuPRZzFjoDKBjklJNGbowa6BFYb
         WW/BF/jB4RRpPDPjrvhcx6ZzmHel1+utAMKGQMOJ0o5jOuBQMEG3t3npUFScBg+he2
         x97bpMkYiUUZDmZx3Hl6glV/W0yabssS853KQ/q8qnj+Sx4CdchETKSD9rW7oU4juC
         /8keJudyn6//voQ1nt0JpkwH9ohyvUOTJCwwmM8/suYbhwH3uJMpheMMJgFfG3c1SC
         efQ3HWGM90P7Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: Use of_property_present() for testing DT property presence
Date:   Wed, 15 Mar 2023 16:35:27 -0700
Message-Id: <167892332563.4030021.7924548893649204338.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310144724.1545153-1-robh@kernel.org>
References: <20230310144724.1545153-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 08:47:24 -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: Use of_property_present() for testing DT property presence
      commit: 4a1b9f4eb122f3e36fdfe62dce96091d3e45132f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
