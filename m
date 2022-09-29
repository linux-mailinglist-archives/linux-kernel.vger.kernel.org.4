Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738665EED53
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 07:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiI2Fmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 01:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiI2Fmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 01:42:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6A012B4AF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 22:42:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BA7AB82207
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 05:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C275C433C1;
        Thu, 29 Sep 2022 05:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664430168;
        bh=XRQ0ZT6by2IEfqjlnDT8C81loJRJw1R9oKY3xLPIZ0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gN28UEngYEo3QIOIgL9EcNFHR13jpHw3BoMyuzK0a0Qek275Zab/D+l0zlb63ayVK
         yUrNU1ux7aivkA4JdvZC+jsi7iuv0ThTPfYmtCggmM79N228kBauZmMnnOrd+SHC55
         ug2NuMv1TEUx6j1sYaUWDHDdLG8Qz0sRkwtCbSKoZkIEyCH1ksVJKELFqdZtIJbtep
         Kj3+8DLCvYL9dQUkeL1hT3p0o8mDSm/uDciykeEwExw2MQOIOMDEed0iKxQMUItArA
         CLZ9OOVpa9q7e41N5eozQ4wPztKXNHC1apbIb5GhINPM6aWdDZ/WnVtFRSifOEIHp8
         dGPqmZOua+QMQ==
Date:   Thu, 29 Sep 2022 11:12:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Eddie Hung <eddie.hung@mediatek.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH next v2] phy: mediatek: fix build warning of FIELD_PREP()
Message-ID: <YzUwUwgDZaRejf6Y@matsya>
References: <20220928070746.5393-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928070746.5393-1-chunfeng.yun@mediatek.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-09-22, 15:07, Chunfeng Yun wrote:
> Change the inline function mtk_phy_update_field() into a macro to
> avoid check warning of FIELD_PREP() with compiler parameter
> -Wtautological-constant-out-of-range-compare
> 
> the warning is caused by mask check:
> "BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \"

Applied, thanks

-- 
~Vinod
