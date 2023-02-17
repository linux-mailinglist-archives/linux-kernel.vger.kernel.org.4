Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DBD69B596
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 23:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBQWge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 17:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBQWgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 17:36:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1FC2D75;
        Fri, 17 Feb 2023 14:36:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01C98B82DD1;
        Fri, 17 Feb 2023 22:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8F2C433D2;
        Fri, 17 Feb 2023 22:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676673389;
        bh=k4OUgOV2DAcRiYZmTlzFyyRMmedSCsjG5YKy4EefJEY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Q1u3GP76ZvSpHurnV2VBUmuKgUIceLicA9zGshbGui4fhZx1os0a4cAhCDZ+/gdEi
         lI5iL1pYMNUbq9fPDuOMaaz/Uv38BBs706T6unHD0x8pRo0k6ndaJQsyFfPEQgMFYF
         RHtgpyCwdK8eQwnrt13RF6MubY/TbYhCUyFsda0ynm2dxlDoHiBcgZc11RZqm9nd5i
         Pc04Me5vY+QmjK14igoegXop6ngiy+05q19sbvpAne57Igmd9A00KRAhTP2wXAxcUq
         I8/8UXuhrnH/spO8Wfj+JXzlPOShKsAd3+LsMBQVspNmUGvIrQugLrqblsd+rWSqsr
         mAEEgM6lWG1vQ==
Message-ID: <7666a6dad5c698483c30356d1278025a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230217080720.5206-1-quic_kathirav@quicinc.com>
References: <20230217080720.5206-1-quic_kathirav@quicinc.com>
Subject: Re: [PATCH V3] clk: qcom: ipq5332: mark GPLL4 as critical temporarily
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_varada@quicinc.com, quic_srichara@quicinc.com,
        Kathiravan T <quic_kathirav@quicinc.com>
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com
Date:   Fri, 17 Feb 2023 14:36:27 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kathiravan T (2023-02-17 00:07:20)
> Clock framework disables the GPLL4 source since there are no active users
> for this source currently. Some of the clocks initialized by the
> bootloaders uses the GPLL4 as the source. Due to this, when the GPLL4 is
> disabled by the clock framework, system is going for the reboot.
>=20
> To avoid this, mark the GPLL4 as CRITICAL so that clock framework

s/CRITICAL/ignore unused/

> doesn't disable it. Once the users of this source is enabled, we can get
> rid of this flag.
>=20
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
