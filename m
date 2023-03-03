Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554A46A94F6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjCCKNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjCCKNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:13:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD78E3B7;
        Fri,  3 Mar 2023 02:13:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C304D617AE;
        Fri,  3 Mar 2023 10:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACAFFC433EF;
        Fri,  3 Mar 2023 10:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677838384;
        bh=I3YTJmXVNHKlfct4pF/Gpd4n3hHW6jTk2WQfuDF+BRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dQ2axPFmfU3mfTJVy8xDTiAEga1QW6aLT3ZcfF9Hdx/oQzhYdXpWkDyZnDsQ+9tlo
         CeP42qCjJoi7MaLiwggDqe1bnQbUim1+yTDVEaZ9B0tXjYCyml7bKVOdN6uj0yqYhE
         C320RI+BlD85isN103aAwUL0fT3H/t6Aqj/fmQijOmTO/EuxL6nwyEREIhzbu7GP1k
         kcoANLKNexiN5w8T+YptWJdBkF+3J5HjjyJqUCKRwU000GNTtVPn63NUUSbXw9ATqB
         hM1PYXdyQ8bucksmiXdPBnGLoWYiYzRS2oqibtGfCKRUq7x+sI1CgRduBzNABv5s3G
         bXsyQ1eNZF5Ew==
Date:   Fri, 3 Mar 2023 10:12:55 +0000
From:   Lee Jones <lee@kernel.org>
To:     Poovendhan Selvaraj <quic_poovendh@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        jassisinghbrar@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        robimarko@gmail.com, dmitry.baryshkov@linaro.org,
        nfraprado@collabora.com, broonie@kernel.org,
        quic_gurus@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_devipriy@quicinc.com
Subject: Re: [PATCH V3 5/5] dt-bindings: mfd: Add the tcsr compatible for
 IPQ9574
Message-ID: <20230303101255.GN2303077@google.com>
References: <20230208053332.16537-1-quic_poovendh@quicinc.com>
 <20230208053332.16537-6-quic_poovendh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230208053332.16537-6-quic_poovendh@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Feb 2023, Poovendhan Selvaraj wrote:

> Add the tcsr compatible string for IPQ9574 SoC
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> ---
>  Changes in V3:
> 	- Updated the subject
> 	- Added the Acked by tag
> 
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
