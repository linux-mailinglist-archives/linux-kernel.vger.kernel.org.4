Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3672C6D2815
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjCaSsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjCaSsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:48:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2D220DA1;
        Fri, 31 Mar 2023 11:48:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6313762B24;
        Fri, 31 Mar 2023 18:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECD4C433D2;
        Fri, 31 Mar 2023 18:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680288490;
        bh=zY4dS2/SLSVBzseaW2oxegDu0wyzcRO33cz9dHtnmTU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=sT5fRzFwmyg7WnZg0sQuu1DXdo/wkQXrR3mhL//2KY+iKMSqbw7F+75sgytsvx6SX
         wpjqvKLKHLzZV3V2hljSqV99DdLFmThJqLi1zdogNnkXVMgz+WcFPt+oIb19QoRps7
         F/satiyV4kRM3de7xLS8JGIRFeUOO30fFNdB0KeBr+eKMcjEOzqL6fkSx2DiQOal4/
         ZDOF+UwTHLVxzX138AT+43Jc8cLPne+4eJ94zc6CHOMUo6++RVOjZVr6eC4Wlf48fG
         oPR5ZYhS179K2xdurooeLs4fknV5x9VDgJSqiDkzhtZqTSuY69J4L9W0fADYf+y5um
         wkiS32QIWkjOg==
Message-ID: <dc11a5959578c7366e30fba96794cc23.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230331152805.3199968-1-quic_mohs@quicinc.com>
References: <20230331152805.3199968-1-quic_mohs@quicinc.com>
Subject: Re: [PATCH v10 0/3] Add resets for ADSP based audio clock controller driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, broonie@kernel.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        quic_visr@quicinc.com, robh+dt@kernel.org, swboyd@chromium.org
Date:   Fri, 31 Mar 2023 11:48:08 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mohammad Rafi Shaik (2023-03-31 08:28:02)
> Add resets and remove qdsp6ss clock controller for audioreach based platf=
orms.

Does this supersede the v1 patch series[1]?

>=20
> Changes since v9:
>     -- Drop "clk: qcom: lpassaudiocc-sc7280: Modify qcom_cc_probe" patch.
>     -- Update Fixes tag in Add the required gdsc's in lpass_cc_sc7280_des=
c patch.
>     -- Add the max_register value in Skip qdsp6ss clock registration patc=
h.

[1] https://lore.kernel.org/linux-clk/20230327163249.1081824-1-quic_mohs@qu=
icinc.com/
