Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1980C716CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjE3S62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjE3S60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:58:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4FF102
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 11:58:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F9FD60B5E
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 18:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537C5C433EF;
        Tue, 30 May 2023 18:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685473104;
        bh=Wcn8rTNMfHUm/2FhfeLj6sJFQcGyH6K3vwEAzxGCG1M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GNR0A/teOgfBoL20HGARL8/z8Grux+xbL11AyBOm6Vf8SyUEA4Wv6EeSYiSAECyBE
         M3Kde92E4Qp7raHOXychx2DcIyhPL+g46yHI3ZWVF+UoOo5ygziBPf+/wDvvmkY7Y+
         n1+GUvx4JDRv2NBjZUaXWE+sDVBGk9AkQxf0Zjap+CUoirJAjjbOe9gx1HKBgS3bA7
         OBzrz7kdcz3KJuFl35lsEi4z94SlGiZQmPiJqgNOPKapVAvlm/uwrJdkkIjZVgZaYB
         mIGULaIsmxDg7UYeEQftPmthKGo9erwS10y4KyqI6OWv5ocikVx8qpgwWB0Z+RMyTW
         pnTHpDb0xg97w==
Date:   Tue, 30 May 2023 13:58:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v6 6/6] drm/etnaviv: allow usperspace create cached
 coherent bo
Message-ID: <ZHZHTi4AzPLbcU3+@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530160643.2344551-7-suijingfeng@loongson.cn>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/usperspace/userspace/ (in subject)

On Wed, May 31, 2023 at 12:06:43AM +0800, Sui Jingfeng wrote:
> cached system RAM is coherent on loongson CPUs, and the GPU and DC allways
> snoop the CPU's cache. write-combine caching property is not suitiable for
> us.

s/allways/always/
s/suitiable/suitable/
