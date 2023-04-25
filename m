Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B03E6EE852
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 21:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbjDYTgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 15:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbjDYTf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:35:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7489A49C2;
        Tue, 25 Apr 2023 12:35:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D0EF629C7;
        Tue, 25 Apr 2023 19:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7A8C433D2;
        Tue, 25 Apr 2023 19:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682451356;
        bh=qRRKPs22ctbt+a/NCXHcEXDMpCztK9X/MkqkjsUVY2c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=MddFTWQHKTk55uGc9OxGOCPbvhMymy6CHrTmqBi2QQUBUEc7bectdJgRiVgaL0Yaa
         5s3H9hdIceibq77hdjqysmQrscdHu9kK/QGhWDD5q86tJlGU0FTXvnghygdacDHIWF
         mvCiRRQacg3Hha/EnWBFLc4bx07z0esFbvl/yx6lS36TpH8yEAfKpId3zw/DCAvrjx
         emuLeSolbOxZbrB026ICle4wTPbmKBEDFmoyVWP42ZvvA44EdHDdq4jB4N4KdvTZYn
         Zx4TCVuTFx0DUK1j5R01NlTJEbVTxvqp5TPmtOi2aJVWI4vNVznUJ8i/d76NSYcxzk
         80IsonmOmx6+w==
Message-ID: <c7802799ab91eb0a0862a934d3d35879.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e3bd41d8-f0c5-6756-13bf-bf29c786ab5c@linaro.org>
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org> <e3bd41d8-f0c5-6756-13bf-bf29c786ab5c@linaro.org>
Subject: Re: [PATCH RFT v2 00/14] SMD RPMCC sleep preparations
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 25 Apr 2023 12:35:54 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2023-04-20 08:57:53)
>=20
>=20
> > Konrad Dybcio (11):
> >       dt-bindings: clock: qcom,rpmcc: Add a way to enable unused clock =
cleanup
>=20
> >       clk: qcom: smd-rpm_ Make __DEFINE_CLK_SMD_RPM_BRANCH_PREFIX accep=
t flags
> >       clk: qcom: smd-rpm: Make DEFINE_CLK_SMD_RPM_BRANCH_A accept flags
> >       clk: qcom: smd-rpm: Make BI_TCXO_AO critical
> Stephen, parallel to all of the discussions, would you be willing to
> take patches 4-6 as they are? XO_A being critical is something that
> won't hurt without the rest.

Sure, can you resend just those in a series?
