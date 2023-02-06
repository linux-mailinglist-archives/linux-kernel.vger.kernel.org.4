Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9888C68C96B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjBFW3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjBFW2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:28:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0D0CDE5;
        Mon,  6 Feb 2023 14:28:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A446B8163C;
        Mon,  6 Feb 2023 22:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A457C4339E;
        Mon,  6 Feb 2023 22:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675722509;
        bh=MxtWpIGYbKV6T/bwfOKSZ8oPySnGEbec2mMZKGxp2Ds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fY6Z2AJhg2vgbn8iYe16aeOfwjc/t1X2lQL9VFK/+EUcAlB4bKg5ErXh9MErW+X+0
         UL5bzsOdYfiBh2bmMAN/EC8dp3Y9n3M40sjyvwQsglxBYNKprCK/4TTfhGWNoupYal
         6Bcz4E4JUv7TmhTaorUNKH9b8Uo+FPfPEt7V7wnIYMqhjlbQN4uBGkCGF9b6B2M0BG
         eKZR5nIYScnXnIkQxNN1jCbe0MLuH5t3GX3yrQ7gHXtjxHcLQTqbmdgu7Hmpmv7bRO
         7Lxh6lua0V4oVzMUgpFRXnLqQqxK9g3U08dAdthhNZrKdBR47ef8p1+RVi5mJkgaEK
         ew0cg6bEy7E3g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v6] dt-bindings: soc: qcom,rpmh-rsc: Update to allow for generic nodes
Date:   Mon,  6 Feb 2023 14:30:36 -0800
Message-Id: <167572263441.3569822.6568105579577194337.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230112203653.23139-1-quic_molvera@quicinc.com>
References: <20230112203653.23139-1-quic_molvera@quicinc.com>
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

On Thu, 12 Jan 2023 12:36:53 -0800, Melody Olvera wrote:
> Update the bindings to allow for generic regulator nodes instead of
> device-specific node names.
> 
> 

Applied, thanks!

[1/1] dt-bindings: soc: qcom,rpmh-rsc: Update to allow for generic nodes
      commit: 22b0e764c1b41ee75d7ee76287746a65727aa78a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
