Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367415E88BA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 08:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiIXG21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 02:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIXG2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 02:28:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C8111E5C1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 23:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 199EEB8013A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 06:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E408BC433C1;
        Sat, 24 Sep 2022 06:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664000901;
        bh=13hcAswE3/w5gxNu2/Ksn2qrnXkSsfzErgmHm7xxrQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SGdBa86rzljLx7cjzepoilpeBg3XmKvRNAw28AALpCf6Qk/7FWeV3Nw9qlOBqHThk
         2Uii+Yu7WhDAoDKeVxYIObjTalaTstgk1Xdv26p8Y7NlSqimtN8paEyOuSbpDNGgpT
         veWfBuPHzR0m7KhFhjO8dTxVvyPdIRQ+cTFUQ6jQ/NEEV+8x1x83H7HFqst+Fi505/
         eaE0h824Xm2UaGMHjOXMvdaRTlafhEyvT6qotgokzmvekti0s0EsNUEG1xGbpMSrwJ
         zloX68w2JN2yOSm5+WQ597Ei+2SrgavhVTxQKmEYKINYo4QxLy0usY145FGO/rYMQn
         O/q7FzEa+tv6Q==
Date:   Sat, 24 Sep 2022 11:58:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jitao Shi <jitao.shi@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: Re: [PATCH 00/18] unify register access and macros
Message-ID: <Yy6jgYXSawkaAMxv@matsya>
References: <20220920090038.15133-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920090038.15133-1-chunfeng.yun@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-09-22, 17:00, Chunfeng Yun wrote:
> No need to define new macros to generate bits, mask and bitfield, use
> common ones instead, e.g. BIT, GENMASK and FIELD_PREP etc.
> Due to common register access helpers are defined for MediaTek's phy
> drivers, the similar helpers defined by ufs, hdmi and mipi phy drivers
> can be removed.

Applied, thanks

-- 
~Vinod
