Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD41B6BC14A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjCOXd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjCOXdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:33:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A27189F31;
        Wed, 15 Mar 2023 16:32:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04416B81F9F;
        Wed, 15 Mar 2023 23:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62416C4339B;
        Wed, 15 Mar 2023 23:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923151;
        bh=Jrig1KgYyOQ00SlniAFCKbB8BfIG//VPX1y+cMk0x4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRrHK/w2yqKBuQjJpssdrOwj/I3W3qsKKbrc0hLU4SsRWpnArhu5Ktfw2hfUOjvBB
         e4Sipg5j01HegWVjhMLOChjCbzOgX7tR2mwfdpgGXk4ZIqpRCsM3CFyM2Q7YXu7gUB
         /RVVUvQlDus4ZoPr4QI30FwgeRpag8dRkLIXGKgXT59NsBy1ApljFTLbPXFKRng4Px
         sh46hv2MXF1CHC5/zBGNK5kgbsI61a86Lu5UM4LU/zQoRbwEwwMaHVWHXd5LHaf277
         5ktzQA6hOrCtKMWLUVAbgO7y10ND7qhWheYP+Bbg/aV1NPGmnhUArtp8myFGM93QdP
         6XnRoAUG/2yig==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] RPMPD cleanup + parent PD
Date:   Wed, 15 Mar 2023 16:35:02 -0700
Message-Id: <167892332568.4030021.2567192127165511481.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313-topic-rpmpd-v3-0-06a4f448ff90@linaro.org>
References: <20230313-topic-rpmpd-v3-0-06a4f448ff90@linaro.org>
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

On Mon, 13 Mar 2023 20:59:58 +0100, Konrad Dybcio wrote:
> v2 -> v3:
> - Correctly include the missing first patch (this is very embarassing)
> - Fix the _ao parent for SM6375_VDDGX
> - Use b4, hopefully everybody gets all the patches now..
> 
> v2: https://lore.kernel.org/lkml/16950676-fef9-a3a0-0855-e4e6637711dd@linaro.org/T/#m829f7bfcf911f5e16d9f83aefe810e5dedc7453d
> 
> [...]

Applied, thanks!

[01/10] soc: qcom: rpmpd: Remove SoC names from RPMPD definitions
        commit: f1eb5e6fc18c5e6f4ee7fd2985743f2fe7978951
[02/10] soc: qcom: rpmpd: Bring all definitions to the top
        commit: a5d0e2819fd013e3629d3fedcae877777214ed34
[03/10] soc: qcom: rpmpd: Unify Low Power Island definitions
        commit: d280f3d66d9a79b1bd50258ccb3fbb413216c1be
[04/10] soc: qcom: rpmpd: Remove vdd* from struct names
        commit: 1c940cc42aba5b27a259634f4aedb71e5f46dac1
[05/10] soc: qcom: rpmpd: Expand struct definition macros
        commit: 91c0bcef25f985fd974b6f1ba3d3d7383ac032d2
[06/10] soc: qcom: rpmpd: Improve the naming
        commit: 07df05025eb4cb65c1549d392f988aa5eeb9e758
[07/10] soc: qcom: rpmpd: Make bindings assignments consistent
        commit: d338fe40cf37c3f326b5cb743c6436369d452094
[08/10] soc: qcom: rpmpd: Add parent PD support
        commit: decd6e77e02eff517efe11dfc181ce1b5bef3405
[09/10] soc: qcom: rpmpd: Hook up VDDMX as parent of SM6375 VDDGX
        commit: ec90637c9946cc8e37afa4c1feb33fdb1fa15b68
[10/10] soc: qcom: rpmpd: Remove useless comments
        commit: e556c94e8c20bcfb6c910e93a0cfd2d0cce5adc8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
