Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0BF6716BD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjARI7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjARI6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:58:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A9D5FD76;
        Wed, 18 Jan 2023 00:14:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90875B81BA3;
        Wed, 18 Jan 2023 08:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36169C433EF;
        Wed, 18 Jan 2023 08:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674029661;
        bh=8D9nmC7N4QZK4djbEGofw2hmIQwwUhoPJgAYCdbVOE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qcuLxoCwml0jHIWjn2IRUWc/ebuzIGcZG6cKlz9MnVeM885zAyim3Yl0pN+Nt7iKi
         rTdHC6hf9RQYpdju3Vfw8xgmk8+hWqWYCShcpdT3k4zVYK4cdTlzFg30tWYh1b7sT+
         z+7tOUwOwZakbPZTnNMW7uVENEgnflUvF4JNHdWw6g9ALVwnUxVcUWqKLf4VmAU/p0
         ZK1NzeKKi2tVhRwNKsoxygiOzSvZmK1mGmhhdyQKMpG0jTU3bbkRAYCRpZ3vs5s1bz
         CEfLqPDlb52exL+EozFvyQ23ZiweznSKfI73s1M63Jfvro36wEqlOYCIrXaVXJ5hSq
         44SNYL8ehsREg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pI3an-0000cb-AM; Wed, 18 Jan 2023 09:14:45 +0100
Date:   Wed, 18 Jan 2023 09:14:45 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/6] phy: qualcomm: Add UFS support for SM8550
Message-ID: <Y8eqdcLthEaYq/Pp@hovoldconsulting.com>
References: <20230117224148.1914627-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117224148.1914627-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 12:41:42AM +0200, Abel Vesa wrote:
> The v4 of this patchset is:
> https://lore.kernel.org/all/20230117142015.509675-1-abel.vesa@linaro.org/
> 
> Changes since v4:
>  * Renamed QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE[24] to
>    QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE[24] in patch #4
>  * Added Dmitry's R-b tag to patches 2, 3, 5 and 6

In the future, please include the full changelog here even if you
provide a link to the previous version. No need to make it harder than
it has to be for reviewers.

Johan
