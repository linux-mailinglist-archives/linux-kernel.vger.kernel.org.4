Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BF16AAD89
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 00:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCDXsO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 4 Mar 2023 18:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDXsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 18:48:13 -0500
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A05EB49
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 15:48:12 -0800 (PST)
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 4120D140557;
        Sat,  4 Mar 2023 23:48:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 417882000E;
        Sat,  4 Mar 2023 23:48:06 +0000 (UTC)
Message-ID: <ed3f46b20241a87f666a92441383e7fa55d9eadb.camel@perches.com>
Subject: Re: [PATCH] drm/amd/display: Simplify same effect if/else blocks
From:   Joe Perches <joe@perches.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Deepak R Varma <drv@mailo.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     Leo Li <sunpeng.li@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Date:   Sat, 04 Mar 2023 15:48:05 -0800
In-Reply-To: <4d670a5c-b680-ba76-a640-88b3d945c0b0@amd.com>
References: <Y8POxreeC3EvOXhC@ubun2204.myguest.virtualbox.org>
         <33ecbe8971bb9c90d72c67d43ca740abac160908.camel@perches.com>
         <Y82GHzOUHgEqTUq7@ubun2204.myguest.virtualbox.org>
         <Y/+z22xM7NNjX8VP@ubun2204.myguest.virtualbox.org>
         <f15b10a8-11f6-6c1f-c94e-71796aad9155@amd.com>
         <4d670a5c-b680-ba76-a640-88b3d945c0b0@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 417882000E
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Stat-Signature: q9xfrsjk38n5piktq6d4q37fccga1to1
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18QlYeO1+taMT/MFXb64RqiCoEVZ1/Sb8w=
X-HE-Tag: 1677973686-276631
X-HE-Meta: U2FsdGVkX19goUa4EftjyOuJipou1Ylsf6Z1FKTHQoXQEUdS0fJr4OAt8Vl+Sv2/VewZqmxFwEAnAlwEjOMI+A==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-03-03 at 15:35 -0500, Harry Wentland wrote:
> Actually I was wrong. Too many similar-looking snippets in this
> function made me look at the wrong thing. This change is fine and
> Reviewed-by: Harry Wentland <harry.wentland@amd.com.

So why was the change made in the first place?

Please explain commit 9114b55fabae.

