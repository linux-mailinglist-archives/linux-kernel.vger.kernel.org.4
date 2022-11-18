Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBCF62F051
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241725AbiKRI72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241703AbiKRI7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:59:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E197FC0B;
        Fri, 18 Nov 2022 00:59:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FE7E623A5;
        Fri, 18 Nov 2022 08:59:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF58C433C1;
        Fri, 18 Nov 2022 08:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668761959;
        bh=WzUAd8yRzWARHvRUpEFlJzb/3r+JeBM3q4HnpI1Omfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JxOu+a3PYskaCEGWas7w3dpvfl2zR3VnSHTQ6fQjLTe+sUTM1UYRazUbbvxNxsbj2
         83yGWwZucT33i+W4FwqlCmsMIiKWkJHA9vCaTfwoJZ/JH6x1UcOWcHoqKusGQEE9MG
         f19dSiKFv+9jqDqqHRUkfMIiO9WbHSCxImzp8KTUK8RIMvzhR0w50btgC1eFIrBlTh
         4AR8nkokpJZUf/oaTK8BMDxPyQoDgiMvK2AXKmp9QO2W7v21Xrc+QBocNibu0+8aFk
         eOYYvMvVfOBUfbABrroqPGOpYhdCVyUxP9wdVTwtkW/z82EAuRdqDpJEUvQLqJwUtu
         7VriLmWa6xv8Q==
Date:   Fri, 18 Nov 2022 08:59:13 +0000
From:   Lee Jones <lee@kernel.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
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
Message-ID: <Y3dJYXCngi1p28HO@google.com>
References: <20221117114818.v7.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
 <20221117114818.v7.2.I9e018ecb8bdf341648cb64417085978ff0d22a46@changeid>
 <Y3cboMlFTRzSJyQ8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3cboMlFTRzSJyQ8@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022, Tzung-Bi Shih wrote:

> On Thu, Nov 17, 2022 at 11:48:47AM -0700, Mark Hasemeyer wrote:
> > Add DT compatible string in
> > Documentation/devicetree/bindings/mfd/cros_ec.txt
> 
> The patch doesn't apply.  Please rebase it.

Were you actually trying to apply the patch, or just testing?

-- 
Lee Jones [李琼斯]
