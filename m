Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1555BDCE3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiITGHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiITGHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:07:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5055D117;
        Mon, 19 Sep 2022 23:06:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37854B824AE;
        Tue, 20 Sep 2022 06:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E7EC433B5;
        Tue, 20 Sep 2022 06:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663654013;
        bh=BQkXB+/vfTibc1u9AzBS7kbJyHVa3MoNygpirOCMwh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RLKAitcSJJ3Loce7lwGfQi+XlNqc3Ni8/E2G6Qg5KjZZ17v3XxjAzpUnl+ZsvXrY+
         +3vqhA1Oy+beEx5MgcYZkrB3iiP1GVLWqkrmiKtJJu1iPdEaUmdhzMmSdVLu7i/UOp
         6odFoI8NPDqFYlTe7zLCm2DckqdBX0irR12sM83lsb6/zc5IFxv2AlYrdC593nwCca
         9AOD1lwYHCfs3P4jHwM5eaM5Gqj6mgsfUZVwjQHKoWp7kls3BvJB/+mhrVxmrWiiSr
         f+6123a61H2NJVTfJha2wR2QTLTV+rgzdA2Z0CkWIBlvFuBSSCQE56uLAMnfy7NFat
         GojzHG7eAXqCw==
Date:   Tue, 20 Sep 2022 11:36:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/8] dt-bindings: phy: qcom,qmp-ufs: Fix SM6115
 clocks, regs
Message-ID: <YylYeSuX/99jcllf@matsya>
References: <20220919180618.1840194-1-iskren.chernev@gmail.com>
 <20220919180618.1840194-6-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919180618.1840194-6-iskren.chernev@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-09-22, 21:06, Iskren Chernev wrote:
> The Sm6115 UFS PHY has 2 clocks and 3 regs.

Applied, thanks

-- 
~Vinod
