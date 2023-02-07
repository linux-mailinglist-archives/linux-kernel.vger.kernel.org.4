Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E446668E36B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 23:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjBGW2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 17:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjBGW2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 17:28:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80A0199F8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 14:28:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A1C8B81B30
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 22:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76DDC433EF;
        Tue,  7 Feb 2023 22:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675808910;
        bh=0pnhlHgUFS+duPYaJ+ghB1NoXh/J7+EhVyjb0D0gxOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VfWZG7Sg7ohHXC9+JTd8YMCwha+ceyYX0R3lnjfSkDm+AWuWFwtjIdpWfmkSPqw8j
         rEp4NLFkG6d3mYNZTcTzFg8fi7HoG6SkqRA1SqTkQ9qpgrRs5bED49eSUfUooBlvfC
         3J91PJWN/wkErtr2q5c4UuDfcvOw5Jkhc1abvvVPyZU+3yG+8zFqNCCpTQVBjbdHc2
         E7knlD0d23EKuZVL5PvcvjRZOavr+e5tpZixVQQPttL9GqhWNAxYSEFBRfgjiJwjPC
         YojAlxMEpPQI7ABAvgTy26rX+heSJgmF2BI8kMKMzZoWxZ0YDzWTi27zVPVx0eVLAZ
         2Q5Da4uQscl+w==
From:   SeongJae Park <sj@kernel.org>
To:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs: make kobj_type structures constant
Date:   Tue,  7 Feb 2023 22:28:27 +0000
Message-Id: <20230207222827.55192-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230207-kobj_type-damon-v1-1-9d4fea6a465b@weissschuh.net>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, 07 Feb 2023 19:21:15 +0000 "Thomas Weißschuh" <linux@weissschuh.net> wrote:

> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definitions to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
