Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBC16B7030
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCMHjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjCMHjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:39:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96F838E87;
        Mon, 13 Mar 2023 00:39:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D339B80A27;
        Mon, 13 Mar 2023 07:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92577C433D2;
        Mon, 13 Mar 2023 07:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678693146;
        bh=xwcZh03jQeXTBM07Td7Z3LFT0jxxJ5p+vVYi7SPaWY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WFn6hXsn6mHiW7vK5lAoM1T7m0DARibhzsEAWiQT1JL99SbEFg25V8Phwu1t7NEKU
         POBLEWeg6TRjceDDfpy4fFPgDF4eC5+CLk5RjUapMNKkfx9spObNDp/tBBXaSdEuYS
         0qLqgP3NOFevAn7WzGpbk3jyHDm7Zk+xH1f1/X1+ycQdjsvVnnSivSIqMAR8QIcKuJ
         aMX/LL9ojgijmEdQDX2Pue1QWrIQaFn6qqa2zzeWUjjFcmmM/adjZK1mx/cSDnuMD7
         R3IXnknc0D9hiEwlMDRYcbuMkqsOQ7nandWAEMYhrud7S3sm2GDlNarYiRFEFtgPdA
         aR6YoclC4jvIA==
Date:   Mon, 13 Mar 2023 15:39:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Li Yang <leoyang.li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: layerscape: Fix GICv3 ITS node names
Message-ID: <20230313073900.GK143566@dragon>
References: <20230208183437.2283665-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208183437.2283665-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 12:34:38PM -0600, Rob Herring wrote:
> The GICv3 ITS is an MSI controller, therefore its node name should be
> 'msi-controller'.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thanks!
