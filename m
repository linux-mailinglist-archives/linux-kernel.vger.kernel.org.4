Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3904B677DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjAWOXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjAWOXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:23:21 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149EA241E6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 06:23:17 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4P0slJ6RQJz9stZ;
        Mon, 23 Jan 2023 15:23:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=espindo.la; s=MBO0001;
        t=1674483788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DJZQPl+8YM9aYTXyc52ANO0tZ6cNxJJJ337qhtH4sgk=;
        b=zTTcJYCJAouY+K7/bgxnieZEnVJS5hT7j9VL0oGGJ9YqpViaLW14G447i7Bcymf2ZxIN5l
        A86D1NZsSb54nhMHMFrSU2Fl0kaXCEGU5BzwQyFYyU3UV7OkkP8o8eJOlpaAaoAO5O29zY
        e64gpA4cWXvswvGs+uU6Hn62HT/RrqM05mWuiKNr8laVU2Botp2ivoBPtI5Ny4nsm9Bwus
        iXCvvDgbpdYOIicMpvvb6TZX5gYK9/548QGrBYbweb0mIXquUGd0M9e7GqlA7mS30H6pJs
        w7/xFxlky26qy2ImhnA/Zy2nRf2Oujrs2zuC/FRGlJQKjx/zEepCyAft0Vlk3A==
From:   Rafael =?utf-8?Q?=C3=81vila?= de =?utf-8?Q?Esp=C3=ADndola?= 
        <rafael@espindo.la>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: amdgpu: suspend-to-idle on a 4350G desktop
In-Reply-To: <MN0PR12MB6101F62407FB383609B2FB30E2CA9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <87edrnu9mk.fsf@espindo.la>
 <MN0PR12MB6101F62407FB383609B2FB30E2CA9@MN0PR12MB6101.namprd12.prod.outlook.com>
Date:   Mon, 23 Jan 2023 13:23:05 -0100
Message-ID: <878rhttjna.fsf@espindo.la>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4P0slJ6RQJz9stZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Limonciello, Mario" <Mario.Limonciello@amd.com> writes:

> [AMD Official Use Only - General]
>
> Rafael,
>
> Can you please open a bug report here
> https://gitlab.freedesktop.org/drm/amd/-/issues

I reported the bug:
https://gitlab.freedesktop.org/drm/amd/-/issues/2364

Cheers,
Rafael
