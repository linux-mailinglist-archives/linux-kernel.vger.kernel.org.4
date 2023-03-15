Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958FD6BBDDB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 21:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjCOUUT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Mar 2023 16:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCOUUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 16:20:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED9B32CED;
        Wed, 15 Mar 2023 13:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E76B161E60;
        Wed, 15 Mar 2023 20:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25296C433EF;
        Wed, 15 Mar 2023 20:20:14 +0000 (UTC)
Date:   Wed, 15 Mar 2023 16:20:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Matthew Auld <matthew.william.auld@gmail.com>,
        Christian =?UTF-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        intel-gfx@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        linux-media@vger.kernel.org
Subject: Re: [Intel-gfx] [BUG 6.3-rc1] Bad lock in ttm_bo_delayed_delete()
Message-ID: <20230315162011.351d0f71@gandalf.local.home>
In-Reply-To: <2b7fe203-82f5-2726-cd64-01c7421560d3@amd.com>
References: <20230307212223.7e49384a@gandalf.local.home>
        <20230307212615.7a099103@gandalf.local.home>
        <b919b550-6da8-f9f0-a0eb-0fd8af513817@amd.com>
        <20230308074333.49546088@gandalf.local.home>
        <980021d5-09f7-9fc3-2726-44884a57822f@gmail.com>
        <CAM0jSHPf5u4=GGWm6x-zVkLA_LScAxq371ny2NoozuNjHfQefQ@mail.gmail.com>
        <2b7fe203-82f5-2726-cd64-01c7421560d3@amd.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 20:51:49 +0100
Christian König <christian.koenig@amd.com> wrote:

> Steven please try the attached patch.

I applied it, but as it's not always reproducible, I'll have to give it
several runs before I give you my "tested-by" tag.

-- Steve
