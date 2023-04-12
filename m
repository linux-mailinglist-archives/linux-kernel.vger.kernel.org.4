Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1C16DFAF5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjDLQOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLQOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:14:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7834A65A0;
        Wed, 12 Apr 2023 09:14:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEBD4636B5;
        Wed, 12 Apr 2023 16:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AF3C433D2;
        Wed, 12 Apr 2023 16:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681316044;
        bh=jlMPZtR7QkByIWr6DdPTXBY3MC8bYnsCBxrHJELeWXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eOTZRz92E0GfcXaHD3fHLybBscQUuNucU5MrgW7x5MwwiSRe04SvrfWyrwEkF+mWO
         LQgZko8I4Nam8rPp2G3XJa7Eqj2dvB6bqk3/lqc0SBas3jUnXOsx8eIuDdJTPcM5E1
         0mXdrBS58zjzcwE9omnODDK6boakHy79TI0VHV3FStTUWF2jjR0K5At7y3Vz0x+p/5
         uMLZKQ3VEmRMzq28eo9/tahLII6hVleVdnOAHeIoaUZd2o9mzByXbFnKei8qLq5ys/
         1MQsAOQGz2uXCmOvYOOosQc4+pgaS7b8/mExX/RPiYdwPitHnaGDw125xE5ZAVkp7v
         E/3isjh6xi6YA==
Date:   Wed, 12 Apr 2023 21:44:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 2/5] dt-bindings: phy: qmp-ufs: describe the UFS PHY
 for sa8775p
Message-ID: <ZDbYyL5S82xx2EiH@matsya>
References: <20230411130446.401440-1-brgl@bgdev.pl>
 <20230411130446.401440-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411130446.401440-3-brgl@bgdev.pl>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-04-23, 15:04, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a new compatible for the QMP UFS PHY found on sa8775p platforms and
> update the clocks property to accommodate three clocks.

Applied, thanks

-- 
~Vinod
