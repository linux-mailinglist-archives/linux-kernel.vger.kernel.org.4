Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DE36DFFFF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjDLUgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjDLUgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:36:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A52430EB;
        Wed, 12 Apr 2023 13:36:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA7A26253E;
        Wed, 12 Apr 2023 20:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DD6C433D2;
        Wed, 12 Apr 2023 20:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681331806;
        bh=6+kQhpng0nN6oNxM8W0ozh1qx0TTG9sI2fAC3uykaQA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N+ilccIF+2JKkBMkhXT6bhJMOi1nFeyXHZ9AsiNDTNvXNDcq8tRaiVItvncPjyTnr
         jBEz/6Lu4JALOCGVUGYk1l90Zzz8LU2Z8OGYLuiGrb1e4b3dnSwgbQx4reQX3CdJs3
         pFl/gOz+N14EM1sv73QIHCC+8Yr1tyPCEV0bJN0YW26/0f3QISfcOrXrvLRQueevg9
         WNGQ+qV6TQzQObk7HSBREvCDtksRVzqt5cFcAEVBRoGaDckyATMagU46fgiEiIYPbv
         dGR9aViRJnQgaL/Wx7mxxv93n2MhIUjaVYyEavbS91af5Y1WYCC5muKvWIV34qPM1U
         yegzg/YHU63jg==
Date:   Wed, 12 Apr 2023 21:36:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     ChiaEn Wu <chiaen_wu@richtek.com>, lars@metafoo.de,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, peterwu.pub@gmail.com,
        cy_huang@richtek.com
Subject: Re: [PATCH v3] iio: adc: mt6370: Fix ibus and ibat scaling value of
 some specific vendor ID chips
Message-ID: <20230412213642.1a942f64@jic23-huawei>
In-Reply-To: <d2667a9d-20bf-bda2-9d69-4f5000db1633@baylibre.com>
References: <1681122862-1994-1-git-send-email-chiaen_wu@richtek.com>
        <d2667a9d-20bf-bda2-9d69-4f5000db1633@baylibre.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 13:31:06 +0200
Alexandre Mergnat <amergnat@baylibre.com> wrote:

> On 10/04/2023 12:34, ChiaEn Wu wrote:
> > The scale value of ibus and ibat on the datasheet is incorrect due to the
> > customer report after the experimentation with some specific vendor ID
> > chips.
> > 
> > Fixes: c1404d1b659f ("iio: adc: mt6370: Add MediaTek MT6370 support")
> > Signed-off-by: ChiaEn Wu<chiaen_wu@richtek.com>  
> 
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
> 

Applied to the fixes-togreg branch of iio.git and marked for stable.
As we are very late in this cycle I may well drag this into the
queue for the coming merge window as it will land upstream slightly
quicker that way. If not it will go upstream early in next cycle.
As it's been broken for a while I'm not going to rush this upstream.

Jonathan
