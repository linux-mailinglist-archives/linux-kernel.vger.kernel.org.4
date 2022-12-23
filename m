Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4B1654E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiLWJbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiLWJbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:31:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8989337216;
        Fri, 23 Dec 2022 01:31:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80F85B81F7B;
        Fri, 23 Dec 2022 09:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1B6C433EF;
        Fri, 23 Dec 2022 09:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671787865;
        bh=xA1Tx7JkHcV8FOp/jol19NqCgZItuHMSfahylt7MBpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KXvNY8W9UJfHIpPUdhbgE5uE+7r/+oC/3ofod6sMT7hKY/GYPOKu1g+rBPaTOiFt7
         EEJLpKlwXYm3JIjYUBRy2GDfuCk1bcJUG/UUZBKuueZCGkbWjaiJXq0+dPwG6mpAWV
         G9TwODol66irgmG7oNYtM9mYi44D1W3MB86kerjbB1acFRbmGEA2lAay6ejRQxVeBx
         aGfoKktprtLjR8ZwaWUga5O8RAB+NVY1TLMTciZfMpcgnLRWztk6BBAUKHGYaFdpun
         /pkvWZ27ogCkddt+LigjRHU3jT4IaPxRmxzy4cOb8bp584PEj7yjqtpb6RShbdfNnm
         Uity8hvPhGoBg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p8ePF-0002hr-Hb; Fri, 23 Dec 2022 10:31:58 +0100
Date:   Fri, 23 Dec 2022 10:31:57 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        quic_shazhuss@quicinc.com, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: Re: [PATCH v3 1/7] arm64: dts: qcom: sc8280xp: rename qup2_uart17 to
 uart17
Message-ID: <Y6V1jfP6wBe8RCWi@hovoldconsulting.com>
References: <20221220192854.521647-1-bmasney@redhat.com>
 <20221220192854.521647-2-bmasney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220192854.521647-2-bmasney@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 02:28:48PM -0500, Brian Masney wrote:
> In preparation for adding the missing SPI and I2C nodes to
> sc8280xp.dtsi, it was decided to rename all of the existing qupX_
> uart, spi, and i2c nodes to drop the qupX_ prefix. Let's go ahead
> and rename qup2_uart17 to uart17. Note that some nodes are moved in the
> file by this patch to preserve the expected sort order in the file.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> Link: https://lore.kernel.org/lkml/20221212182314.1902632-1-bmasney@redhat.com/
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
