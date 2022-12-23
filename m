Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B227E654E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbiLWJkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiLWJkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:40:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD3218E1C;
        Fri, 23 Dec 2022 01:40:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DFB961E83;
        Fri, 23 Dec 2022 09:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE1AC433D2;
        Fri, 23 Dec 2022 09:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671788405;
        bh=4JK9oox+u95W7wZ4bpYa9W5v95IWfHjY4N0TSiwVPpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N1y5yg7oq0LbpnN2zIZVkBfGcA9ycEAynwpxbSyj0aP7lwvMKbEBqPsMV1XSvJTZf
         6+1Mrfvd9FPkawotrCHseFgEZalfk8JXQ72aW5NXW5HsXElwa+Jk0aW0kAtIquJViC
         horqGhWeYOZkmWvaSTgW9llVsIMPKSMoUbFtslVzFkOUVLruI5qqfR4DfC9t4HLlHk
         YLcX0Mdjbj+5KpjyOtXpltQAYm3etzcm32CAoCDiJkV3bCrrKVnpiXQbVkceWS7T2W
         JYHOMrIZ7ZoNCprFcEDf02Akq+tXqpdU4ksIbhydIOgjEJBF/Gh36Lwb3RMKWxq/5d
         erQFBNnGzZ1+w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p8eXy-0002tn-MU; Fri, 23 Dec 2022 10:40:58 +0100
Date:   Fri, 23 Dec 2022 10:40:58 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        quic_shazhuss@quicinc.com, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: Re: [PATCH v3 3/7] arm64: dts: qcom: sc8280xp: rename qup0_i2c4 to
 i2c4
Message-ID: <Y6V3qgS2duetrRio@hovoldconsulting.com>
References: <20221220192854.521647-1-bmasney@redhat.com>
 <20221220192854.521647-4-bmasney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220192854.521647-4-bmasney@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 02:28:50PM -0500, Brian Masney wrote:
> In preparation for adding the missing SPI and I2C nodes to
> sc8280xp.dtsi, it was decided to rename all of the existing qupX_
> uart, spi, and i2c nodes to drop the qupX_ prefix. Let's go ahead
> and rename qup0_i2c4 to i2c4.
> 
> Note that some nodes are moved in the file by this patch to preserve
> the expected sort order in the file. Additionally, the properties
> within the pinctrl state node are sorted to match the expected order
> that's typically done in other DTs.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> Link: https://lore.kernel.org/lkml/20221212182314.1902632-1-bmasney@redhat.com/
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
