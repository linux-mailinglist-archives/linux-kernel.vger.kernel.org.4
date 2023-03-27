Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802696CABFC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjC0Rl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC0Rlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:41:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3045170C;
        Mon, 27 Mar 2023 10:41:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FF9F61456;
        Mon, 27 Mar 2023 17:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2ED1C433EF;
        Mon, 27 Mar 2023 17:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679938913;
        bh=uuQuqqM9Ye/wRWSRDk0xYoQNtYIma2tReP69LAgb3RQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ld/oGyfycsjr6cflf5tmWhVkT5RnDxm+pB86yH/1dSkqh02gMYQWr0EGvd8QtxbFG
         kPptNr+KQDaOH6KWOAfDR4fUqPp+zbZt0cYBxL/y07n6DvDmMBHn75C7asbEfZcFT/
         UYQRyJKxNJhsvNvVs56dcf7BgT8qqI+dhwN3EBW+Z5ozjGDtmIIZCKMB2qJkC6YXsQ
         G8L0HM73u+1MIIc1UKj/PIpe+eYcE93yDiKogZJyuOuLdyWV+NDD3syAUqqd4U89YB
         ML6z0Ce5kUM4KFCll2f1axSaT51ihTRK9nizfu4DGg69YOZtkKIl0n5hIAox5VetvQ
         puz4B0srKW4fg==
Message-ID: <b347395dd736194ae9392f2f6ea450b0.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230327163249.1081824-1-quic_mohs@quicinc.com>
References: <20230327163249.1081824-1-quic_mohs@quicinc.com>
Subject: Re: [PATCH v1 0/4] Remove the qdsp6ss register from lpasscc
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, broonie@kernel.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        quic_visr@quicinc.com, robh+dt@kernel.org, swboyd@chromium.org
Date:   Mon, 27 Mar 2023 10:41:50 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mohammad Rafi Shaik (2023-03-27 09:32:45)
> This patch set is to remove the qdsp6ss register from lpasscc to
> resolve memory conflict's between lpascc and ADSP remoteproc driver.

Is this related to the other patch series[1] ("[PATCH v9 0/4] Add resets
for ADSP based audio clock controller driver")? Does it supersede those?

>=20
> Mohammad Rafi Shaik (4):
>   arm64: dts: qcom: sc7280: Modify lpasscc node name
>   dt-bindings: clock: qcom,sc7280-lpasscc: Remove qdsp6ss register
>     region
>   arm64: dts: qcom: sc7280: Remove qdsp6ss regmap region
>   clk: qcom: lpasscc-sc7280: Remove qdsp6ss clock registration

[1] https://lore.kernel.org/all/20230317141622.1926573-1-quic_mohs@quicinc.=
com/
