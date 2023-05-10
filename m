Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBC06FE487
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 21:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236240AbjEJTc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 15:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEJTcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 15:32:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCF66A58;
        Wed, 10 May 2023 12:32:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BEF063F48;
        Wed, 10 May 2023 19:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9AAC433D2;
        Wed, 10 May 2023 19:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683747142;
        bh=c/AlsGiGpoTHae8vhLhsc3UPCjpdKpr279Xb/LN1V5s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JlskFPAhVrij7C90ZF1JsoTand7G3QJdQ6fF+FMpvBug94+uMGMPVmWGSN/y/DH2r
         IaJPxjXl8if6QZppHq6n41lmqY14TQsa+XjKtLrjXGxmWqlt+y7HIZwABdMBwlKb5t
         py/p17QCQuSSL9mVb3IrMxUa2PhqyewLq1zStWDDdHgF3xtyJNR9QUXrOb3TmKE6Xh
         EoOXGKul7apNmn6W+RJWP8r3A3e8KepPQqrip5R9et6z7UL021jBtBU84YnlK5Nhtc
         TfANR2c/wgU8zG2GglL2lAhpjwAIWeNjSsaelYiooGxGLE+XE7WDpbcAQoahaO+oZd
         sUQGGMeaDhXEQ==
Message-ID: <f450c63a57fc5a9536d3c48df26244cf.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230501142932.13049-1-quic_tdas@quicinc.com>
References: <20230501142932.13049-1-quic_tdas@quicinc.com>
Subject: Re: [PATCH V2] clk: qcom: camcc-sc7180: Add parent dependency to all camera GDSCs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_skakitap@quicinc.com,
        quic_cponnapa@quicinc.com, Taniya Das <quic_tdas@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>
Date:   Wed, 10 May 2023 12:32:20 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2023-05-01 07:29:32)
> Camera titan top GDSC is a parent supply to all other camera GDSCs. Titan
> top GDSC is required to be enabled before enabling any other camera GDSCs
> and it should be disabled only after all other camera GDSCs are disabled.
> Ensure this behavior by marking titan top GDSC as parent of all other
> camera GDSCs.
>=20
> Fixes: 15d09e830bbc ("clk: qcom: camcc: Add camera clock controller drive=
r for SC7180")
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>

Is something broken right now? The commit text doesn't tell me if we
need to backport this to stable kernels or merge it as soon as possible.
What's the priority of this fix?
