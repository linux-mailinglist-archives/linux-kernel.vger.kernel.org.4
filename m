Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AD36F48B1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbjEBQyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbjEBQys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:54:48 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89143268F;
        Tue,  2 May 2023 09:54:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 16C4131A;
        Tue,  2 May 2023 16:54:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 16C4131A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1683046470; bh=18zSXR3CgMMgMvGwsfV4DF/jTisqSwmkNE64YkGLoLQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=U3FLVD+pBY/o5T9Qrc+EoRTuqUSRxPSb3D/OI/qa5vLJU3DN3UGmxiUUtyPKqq9g+
         lYOAHzyvV2F3iuBtOyRfpNWfR2ju6WB/lhRhC5aa0y3S1KOo5rYwBWtP4FuWH/A0Ms
         GsPeUeMHzxfjwik+z83CHdwVIm3N6shA8jAFYMy0L98t/RSnQXXWzd9bJq53epTUXR
         vdKL/TCkS1xR3sfbpTMmegtF8bo/Oi29HTRPV2Zk8Hi6CZyAd8uxuNr4ah54Nm9yw8
         op0UEvACmN9YwcbSYuV3O8DJl6Z+op3mfZNMrLFt0oapneBuQHS5i5groemp1Q4ejF
         IphRJq0oJMkqg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>,
        Deming Wang <wangdeming@inspur.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shibata@linuxfoundation.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] docs/ja_JP/SubmittingPatches: fix typo of Reviewd
In-Reply-To: <64790637-279a-a1ca-292b-f9f1fac69f14@gmail.com>
References: <20230502010157.1655-1-wangdeming@inspur.com>
 <64790637-279a-a1ca-292b-f9f1fac69f14@gmail.com>
Date:   Tue, 02 May 2023 10:54:29 -0600
Message-ID: <87zg6m7jy2.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> Anyway, Jon might just pick this one with his edit of changelog.
>
> So (again),
>
> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

I've done exactly that, thanks.

jon
