Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A799467BD85
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbjAYU6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235993AbjAYU6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:58:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976EE14495;
        Wed, 25 Jan 2023 12:58:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39F0E6162C;
        Wed, 25 Jan 2023 20:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF2CC4339B;
        Wed, 25 Jan 2023 20:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674680293;
        bh=FM0mzRE+5UDJn4OWAUXa4Ds0/l1i4bq6FY3oRh66wGI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=h2YjxE9+bsLf/Lr6eDWW8fqxOMsW4g/i1hLjis9npB98Ql3i6flf7l4Q6ctpnyGfF
         hgUuCruLjm3A0yCekTne+ITQlyIm+Dtw1iFzJyCRX+KZ68EMEiP/yHv67w+d5k/ovr
         Jc6DPVucwpwfRCyu5Ck1Ja+zMnxccZukiLRfKZKF8fBBGIIteBzyIIBv69mQqULTa2
         nnhVmtUdFzfEShzpEhT2NLfl4boRBvFP2rj6f7lyHRmBfhPmcHcV5U3OFTg/5FGS4p
         4rJUM2s6z/8UjBqLRvpgpOSeCgnB6j+5i7aaMwHD0rOdUE9tbHV8hjwP+gDGEu3FLf
         c0B7FK0WJKg3g==
Message-ID: <06d53a3fa48080d902476b71308e69bd.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230121192540.9177-2-rayyan@ansari.sh>
References: <20230121192540.9177-1-rayyan@ansari.sh> <20230121192540.9177-2-rayyan@ansari.sh>
Subject: Re: [PATCH v4 1/3] clk: qcom: smd: Add XO RPM clocks for MSM8226/MSM8974
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Rayyan Ansari <rayyan@ansari.sh>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
To:     Rayyan Ansari <rayyan@ansari.sh>, linux-arm-msm@vger.kernel.org
Date:   Wed, 25 Jan 2023 12:58:11 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rayyan Ansari (2023-01-21 11:25:38)
> Add the XO and XO_A clocks to the MSM8974 clock list, which is also
> used on MSM8226.

Why was this missing for so long? Does this break suspend? Why are you
adding it now?
