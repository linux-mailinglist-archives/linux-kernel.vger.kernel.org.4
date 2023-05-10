Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF406FE484
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 21:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjEJTbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 15:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEJTbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 15:31:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAE465A0;
        Wed, 10 May 2023 12:31:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4404763EFB;
        Wed, 10 May 2023 19:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94776C433D2;
        Wed, 10 May 2023 19:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683747078;
        bh=sLc/tCNuyfPHA5XcyUpPv3W6N3rM7ijgibgCvR1Je4o=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pXqhfXUXBN3zMa4L/744yahSwwUxF3peMk/RyCUNMLdnaKEfKjbhPru08XabVTC7v
         Kpj5e6mOJiM1blE/6LDET0jWANrklI0jVPR8f+pQICdXsVInUaO5A8iALmkPAFIvvB
         EbBd8LfNX4iQw4e2tS/xPSt+pH82JweobUu1doUHCvwe0Dj1Xpbj5MjLKL7uWiaeYm
         eH8gKdt+wmhqdOv0WhM0ckOxM1tzq3Ri8g0oxd6f7ZyWatxJIyR1O68uKy/5v3ArNm
         Y5vGqCWqF7hSMPbaI2TGHRW3mxi+Bq2SgJhsVpR+5422UpD6qWDKthFMORsLfPjRTZ
         ozVtTs2w1iyOA==
Message-ID: <6bfb24ba4b944563f601035824c97f06.sboyd@kernel.org>
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
Date:   Wed, 10 May 2023 12:31:16 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
