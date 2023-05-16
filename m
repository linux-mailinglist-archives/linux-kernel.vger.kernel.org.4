Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9BE705083
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjEPOYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjEPOYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:24:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E57510C3;
        Tue, 16 May 2023 07:23:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03AF662F0B;
        Tue, 16 May 2023 14:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6150C4339B;
        Tue, 16 May 2023 14:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684247038;
        bh=PcwVUUITKY/O/qO722wrvpNOAEQAzpJRIdCPk2unTOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bY82g5MTrH6hp5Q1RQNsstyUWpf8rwxYFh7Gfb/0CzSU7DhjhQWZTd5Qgv0Ac8Nyq
         Jxj8fUna8FXCg+4X3SqxKHiEcGTlcdYAajhPz14zL4fy8lcUQcbgwFuV/LAGnJOSFM
         mQDii3vwaavba6aD4YeoXaY/4mYgmeKsvBhoC/x3RxFmUgsQ0spr3ybL1QbQlGsq95
         UFr0U4DFupHAUnAmZevrd64lLEWTGoHymC843ZKvp43rB/zAK2TeSUMWlqPaEHDZe1
         2jVwsYLc5NPB4nNoJQAXBTHO6WHwJ/wpu/RKxevHx95eXk+xyEyWnGSeE7LTHemRfG
         CsMuhXRoucIkw==
Date:   Tue, 16 May 2023 19:53:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v10 0/4] Enable USB SS qmp phy for Qualcomm SM6115 SoC
Message-ID: <ZGOR+hvLMZLxl8fh@matsya>
References: <20230502053534.1240553-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502053534.1240553-1-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-05-23, 11:05, Bhupesh Sharma wrote:

> 
> This patchset adds the support for USB SS qmp phy for Qualcomm SM6115
> SoC. For the previous versions of this patch there were conversations
> on irc as to whether this was a 'qcom,usb-ssphy-qmp-usb3-or-dp' or a
> 'qcom,usb-ssphy-qmp-dp-combo' as per downstream code and hardware
> documentation.
> 
> But after a careful look at downstream dtsi (see [1]) it appears that
> this indeed is a 'qcom,usb-ssphy-qmp-usb3-or-dp' phy and not a
> 'dp-combo' phy.

Fails to apply for me, pls rebase

-- 
~Vinod
