Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E2967205F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjARPAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjARPAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:00:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F5A5AB48;
        Wed, 18 Jan 2023 06:55:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44E4B6185C;
        Wed, 18 Jan 2023 14:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71347C433D2;
        Wed, 18 Jan 2023 14:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674053725;
        bh=wjglZMLOEjQw+vq02RhUK9jEtIO+B6Bqz4mUgDY3ieY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=O30xWI6z44KBeWjES0Q+xaK/kQvDQoRnFLDXLidPgskZam0Us1qX5SErhY2uqB7f0
         1Hq/zby63ptVXMEGOd/bslV1Me7c4YcdfPiUYexlgnd93zUXkeNnc4MBbeff8TiiSg
         Odl0oCDgki+7RHty31CatojngdO+l8wC3yMAiG7Gbj3Czvl6obwg3L1UNyOY438koG
         xLZk0hyqISVQ5rQ9lIrmjmLX35omEqK4lB1EGOecnD+2WOBXfvn3Jy5wpx4WxkSt4K
         j5n8xGkMw/Gx4bOdw9TyLYD5cKN3clag3O1I6b8a+wIoGHTDRgBG7q/No5ClfoYrO9
         +MvZWaDpllSiQ==
Date:   Wed, 18 Jan 2023 15:55:26 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Lee Jones <lee@kernel.org>
cc:     benjamin.tissoires@redhat.com, avid.rheinsberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: core: Provide new max_buffer_size attribute to
 over-ride the default
In-Reply-To: <Y8fTd0VJXqKkPIuo@google.com>
Message-ID: <nycvar.YFH.7.76.2301181554370.1734@cbobk.fhfr.pm>
References: <20230113150557.1308176-1-lee@kernel.org> <nycvar.YFH.7.76.2301181002550.1734@cbobk.fhfr.pm> <Y8fTd0VJXqKkPIuo@google.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023, Lee Jones wrote:

> > > Presently, when a report is processed, its size is compared solely 
> > > against the value specified by user-space.  
> > 
> > While I am generally fine with the idea, I don't understand this sentence. 
> > What exactly do you mean by 'specified by user-space'? It's defined as a 
> > compile-time constant.
> > 
> > > If the received report ends up being smaller than this, the
> > > remainder of the buffer is zeroed. 
> 
> Apologies for any ambiguity.
> 
> "its size" == "compile-time constant"
> 
> Would "its maximum size" read better?

I think that the confusion comes from the fact that the changelog is 
written solely with the UHID usercase on mind ... ? (which is dealt with 
in the independent followup patch).

Thanks,

-- 
Jiri Kosina
SUSE Labs

