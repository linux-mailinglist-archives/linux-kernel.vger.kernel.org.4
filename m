Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C4762F0E9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbiKRJTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241794AbiKRJT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:19:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C8D13F20;
        Fri, 18 Nov 2022 01:19:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EBEBB822DC;
        Fri, 18 Nov 2022 09:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84299C433C1;
        Fri, 18 Nov 2022 09:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668763163;
        bh=iRaJEbJLZoILd9LHKyMewBZAVelq+rNxVl7UK4aOIwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HwMkO7sabolcvoNCP3zcYsgba+R/9E3t4ht5gH6Yn5JzJ9Nfx73AGedjH2F7Yt23l
         ri8FUxYV6fflLiUAvPSn2yneJQBNiUpDAXNcaYEiLsZejWGU6lQKgr3BuKbCyKhYUt
         0lFv7P2cRRJxewbrHwPETJvXhjcf6u4DoC6yHaaOTsOx8bykj4UkEoh88nyeU9MrHP
         Pu96WwLgH66LP7BI8CrkHhcOW7iDiAiX9nk6oMJlR7Zt9J0lqzDUhLfu4SLtSjnzvb
         CWFh+E0UI02lLZeR79sAjD/fNNXbxna2Wpf0T2fMzoFsSAjTMeroTkhRy+llHkMPKB
         54cZ4X6CPGDGA==
Date:   Fri, 18 Nov 2022 17:19:19 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Mark Hasemeyer <markhas@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 2/3] dt-bindings: mfd: Add DT compatible string
 "google,cros_ec_uart"
Message-ID: <Y3dOF3IQ/S5NCnR+@google.com>
References: <20221117114818.v7.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
 <20221117114818.v7.2.I9e018ecb8bdf341648cb64417085978ff0d22a46@changeid>
 <Y3cboMlFTRzSJyQ8@google.com>
 <Y3dJYXCngi1p28HO@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3dJYXCngi1p28HO@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 08:59:13AM +0000, Lee Jones wrote:
> On Fri, 18 Nov 2022, Tzung-Bi Shih wrote:
> 
> > On Thu, Nov 17, 2022 at 11:48:47AM -0700, Mark Hasemeyer wrote:
> > > Add DT compatible string in
> > > Documentation/devicetree/bindings/mfd/cros_ec.txt
> > 
> > The patch doesn't apply.  Please rebase it.
> 
> Were you actually trying to apply the patch, or just testing?

Was trying to apply the patch to my local Linux tree (for-next) for
reading the series.
