Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE40265C5CC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238703AbjACSKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238696AbjACSKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:10:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BFE104
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:10:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDF29B81076
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 18:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B797C433F0;
        Tue,  3 Jan 2023 18:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672769444;
        bh=1Tb/Q58YoFnAlxi1Qfq2W6spwVyr8GP9ls2DL4ZrruI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UOJXrY1naLJFBL+IEhEboqguNvzSFWSqTTA3R1PB9lhMaXOrajGD3+oDTiSy4dWRf
         UENt5N/adcopccISd/axhwg4sDyw8TgMCZtmnx/zQygR+EsgURUctfBTyYaI3zyupc
         uN2PqY+vM+E5T7zGNoHcfJ7rzg+zFKR6oNRArmd6GVAb+IJqUPfdFoSSE+2sHnoFzu
         n2qmitpWwp/eviUURjRa6XbkzEUwMwT/C39fmJyk13kPDjRCINKDzyDrvFWKhF/282
         OyXYMTqsLGKY1zWTjtD/AZZerMHy+6FN7N7sMucY+gEIyJmQvHvTHmbL6o9X1/5ouz
         gTdp8Vnr+oj8w==
From:   SeongJae Park <sj@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        colin.i.king@gmail.com, dfustini@baylibre.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/spelling: add a few more typos
Date:   Tue,  3 Jan 2023 18:10:42 +0000
Message-Id: <20230103181042.129759-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ae5f6ddce8e52a3de2ad460aaa3f4a83ee0a866c.camel@perches.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Tue, 03 Jan 2023 10:07:22 -0800 Joe Perches <joe@perches.com> wrote:

> On Tue, 2023-01-03 at 17:59 +0000, SeongJae Park wrote:
> > Add a few more typos that found from real patches[1,2] to 'spelling'
> > file.
> 
> Most of these are fine but:
> 
> > diff --git a/scripts/spelling.txt b/scripts/spelling.txt
> []
> > @@ -411,6 +411,7 @@ contruction||construction
> >  contry||country
> >  conuntry||country
> >  convertion||conversion
> > +covert||convert
> 
> Covert is a correctly spelled english word that could be used
> appropriately for some security issues.

You're correct, thank you for nice comment.  Will drop this from the next spin.


Thanks,
SJ

[...]
