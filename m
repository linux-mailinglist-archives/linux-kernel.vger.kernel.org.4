Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5EC5EF915
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbiI2Pew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbiI2Pc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:32:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A637217A5DB;
        Thu, 29 Sep 2022 08:32:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3489C61952;
        Thu, 29 Sep 2022 15:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6FEC433C1;
        Thu, 29 Sep 2022 15:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664465521;
        bh=atja4xkXu+uR+lUBfnZv2ZFe2oiFXJBckvWkbvvGdiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bjknexfIwz9R9IwpMjTpPtg2HUEN2U4sf2JRVvV/cSckiyxHYUXlv0reJpi/Jn4L1
         HCR730m3yXNu5qYsZeia7arZw9+KQbizyoLds/mTE8fpXPIN4WebBrHaIVH+x9yanU
         Zev/t9Xrg7jbqqNMLig6dMiZJfuOX4NDVpmRmQ3TaSU67CIxTQo4FHfByhaSrFiDy2
         7MgsFoCVEjWk7teyzRjCrbibDV/dEl2hEokDaQCbUdEaaRTZdPybmvMs5EhEwzyv1w
         Z67/0wYv+2itqT2qM2D6ZwAogCjPjqqnwi4uWBX3aFG/OSJNWSPRWS3jBz/JyRFz0E
         ZDnKqMZLyFIEg==
Date:   Thu, 29 Sep 2022 21:01:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: phy-mtk-dp: make array driving_params static const
Message-ID: <YzW6bABCoDzTaIBD@matsya>
References: <20220929130147.97375-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929130147.97375-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-09-22, 14:01, Colin Ian King wrote:
> Don't populate the read-only array driving_params on the stack but instead
> make it static const. Also makes the object code a little smaller.

Applied, thanks

-- 
~Vinod
