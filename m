Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EAD68FAF1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 00:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjBHXMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 18:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBHXMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 18:12:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A32D18E;
        Wed,  8 Feb 2023 15:12:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2774B81FA2;
        Wed,  8 Feb 2023 23:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9807C433EF;
        Wed,  8 Feb 2023 23:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675897921;
        bh=gufkRKfxWieX6HKMKArJihwskH/QJRSmt/NO9zfWLT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBN8j/fttWOPC34Cxzc6MS1JwPv/SldB1DaPlkbchtqv3Lkya5gpnQ/qRjxiyco0M
         qEdmTzcSrJH0eVKpoRwks3hVFNliY8AuoGZG72PJnOEx2bglI6LGe4lK0eW6muftQG
         9osNQpAJUTqE3CmZVOZyT4rga+U2FHZJalbkx6pG2fpNxChcqsyG9WsKPWiHO0VmJH
         VyzYnuW5eerHDtkXf9hj9xL5hkMQNRcEgAbj+bSE5lLGH3scp8FRS5jM9KNJTTLVVQ
         qLVSDJ2dvwA89lE1zfz0k/GcM1bxkE7YVqasU3seN0SSl7YkzT9SD9sib0qMFZR7dY
         LE3dX4FzKlpOA==
Date:   Wed, 8 Feb 2023 15:14:12 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     devi priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
Subject: Re: [PATCH V3 4/7] pinctrl: qcom: Add IPQ9574 pinctrl driver
Message-ID: <20230208231412.yqp3rvokvmbb7ixi@ripper>
References: <20230130125528.11509-1-quic_devipriy@quicinc.com>
 <20230130125528.11509-5-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130125528.11509-5-quic_devipriy@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 06:25:25PM +0530, devi priya wrote:
> +static const struct msm_pingroup ipq9574_groups[] = {
> +	PINGROUP(0, sdc_data, qspi_data, qdss_traceclk_b, _, _, _, _, _, _),
> +	PINGROUP(1, sdc_data, qspi_data, qdss_tracectl_b, _, _, _, _, _, _),
> +	PINGROUP(2, sdc_data, qspi_data, qdss_tracedata_b, _, _, _, _, _, _),
> +	PINGROUP(3, sdc_data, qspi_data, qdss_tracedata_b, _, _, _, _, _, _),
> +	PINGROUP(4, sdc_cmd, qspi_cs, qdss_tracedata_b, _, _, _, _, _, _),
> +	PINGROUP(5, sdc_clk, qspi_clk, qdss_tracedata_b, _, _, _, _, _,
> +		 _),

Please avoid line wrapping these, it just makes it hard to read.

[..]
> +};
> +
> +/* Reserving GPIO59 for controlling the QFPROM LDO regulator */

This seems like a property of the board, please use gpio-reserved-ranges
in the DT node instead.

Thanks,
Bjorn
