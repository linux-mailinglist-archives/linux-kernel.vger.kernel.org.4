Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C24E6FA356
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjEHJaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjEHJar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:30:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB858694;
        Mon,  8 May 2023 02:30:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0DD361CE6;
        Mon,  8 May 2023 09:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E41C433D2;
        Mon,  8 May 2023 09:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683538245;
        bh=+eYVnMlwoYZ6LFjPJ8noxaWaBZjBLxV6a3cd6KJhDvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d9gpGa5Yd53ziAwgOAXmo5UVXpZuqYAjgdPsVYF1eDRameQcM/t2bG+v6OB4FofcM
         j51t+wMWezQHCEPZikaRYsgJN7d0d2fftsA4SEQmO8IjQVbXIaVpfscL5t8U3sKvJ7
         zOz+ZKyBidGs4vp7Y/aF6nv84GfkMtNTWk64o8MkAp5e7yMS35ARBYbknte5krDr5z
         NQexFw1C6HWvhlotMHJghVcyDiOiAVK54/+PlU01AKmKID2vi7PpHiqYnL3emh9Hfz
         cXhL0Im1JTEaEIU/WaEnefh0KJ/kTIGAGFrIPpGi4Gw22DgXKGeHKVFkqp33vexSnI
         KpiUXSzG9f4MA==
Date:   Mon, 8 May 2023 15:00:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Shazad Hussain <quic_shazhuss@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmitry.baryshkov@linaro.org,
        athierry@redhat.com, robh@kernel.org, konrad.dybcio@linaro.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 0/6] arm64: qcom: sa8775p: add support for USB
Message-ID: <ZFjBQXCgvwWVvA30@matsya>
References: <20230428130824.23803-1-quic_shazhuss@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428130824.23803-1-quic_shazhuss@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-04-23, 18:38, Shazad Hussain wrote:
> Update relavent DT bindings for USB, add new config to the phy driver,
> add USB and PHY nodes to the .dtsi and enable them in the board .dts
> for the sa8775p-ride platform.

Applied 1-4, thanks

-- 
~Vinod
