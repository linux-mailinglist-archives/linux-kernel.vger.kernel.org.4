Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B1671F081
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjFARSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjFARSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:18:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86912F2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:18:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F07AF63EE2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 17:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DF8C433EF;
        Thu,  1 Jun 2023 17:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685639889;
        bh=rmHFArekaGiZKmQ4ziA9csHRSAucq2oWTt/lCe73L1U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iUk2l35RTUEH2L4IMsBA4fbLDaA5Lj610c0mdiM2klA9M/8oSzJxop86q+KXmO6Uw
         oV73orKsz+L76WpEzmtX6YdC6jvuAPcgzoLOqcL18mnXhspJzPhCZCzDv88U7jjxYi
         LSyK8TaFIb8Ilr2P2MhRoc74XeBYFvJlf5c2SLpkc9r4/sHBvyZ7efUT0YUn0WbbXL
         eDNAHuUMQHP6WRjnQ9QVV+Zy9Nso6ClbLwcZxdp2+8yzmbrCgrh4QOHdSyjYuG+aTN
         v3x56RSvEnyoQu1OgGJi5DzePWVR+c4rQJ49eiBg9W4Xg74BoqWXn0eWpC9P94zEOR
         cxadhV6GfK8Vg==
Date:   Thu, 1 Jun 2023 10:18:07 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        Rodrigo Vivi <rodrigo.vivi@kernel.org>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [Intel-gfx] [PATCH v8 0/7] drm/i915: use ref_tracker library
 for tracking wakerefs
Message-ID: <20230601101807.7e0363bf@kernel.org>
In-Reply-To: <b7811942-da09-7295-4774-46360715f147@intel.com>
References: <20230224-track_gt-v8-0-4b6517e61be6@intel.com>
        <55aa19b3-58d4-02ae-efd1-c3f3d0f21ce6@intel.com>
        <ZFVhx2PBdcwpNNl0@rdvivi-mobl4>
        <bb49bbd6-1ff2-8dba-11d1-6b6ab2ccd986@intel.com>
        <b7811942-da09-7295-4774-46360715f147@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2023 19:14:50 +0200 Andrzej Hajda wrote:
> Ping on the series, everything reviewed.
> Eric, Dave, Jakub, could you take patches 1-4 via net tree?

Sure thing, would you mind reposting them separately?
Easier for us to apply and it's been over a month since posting,
a fresh run of build bots won't hurt either.
