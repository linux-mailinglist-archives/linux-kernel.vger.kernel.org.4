Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0892A5F073C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiI3JJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiI3JJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:09:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D2E7E017;
        Fri, 30 Sep 2022 02:09:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A23C662296;
        Fri, 30 Sep 2022 09:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2F9C433C1;
        Fri, 30 Sep 2022 09:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664528956;
        bh=OnYGrj64rerY7HtjqW+q+BSaPhs3F6gB8HHE69Dxi/I=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=vIhDhM5+0q915H+CMvzpNdm4z3EQq/ehTHu1SrO1TAaMEoaDoKNfyWhZkmgO2MPgp
         QnYndmDZ2CHNitiEaFknjf5m1WJiv7nikDKYSbrW0VAKjcxT9stKW5jZSi/DTGqHUC
         OBRxmqgI07IcJ5Ytd0iQ/27hZscbDpKX8uey554Xc6hrn3GBX5C4xEThdnTYx+OrO2
         uI8tR7gV8gwojmio/fPjw56KrniKDHAgnxdjjREnROobmXGPNExpUammbsoJ2uiySo
         LwsnTK2s8TmgUjsO6dyjAsQMtbppu4O2ojWlxXO//HVvXOAwXKJj24BsJGvhy6QLbV
         4UEmbTmpjoMCA==
Date:   Fri, 30 Sep 2022 11:09:12 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Tero Kristo <tero.kristo@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: input: Add support for USI style events
In-Reply-To: <nycvar.YFH.7.76.2208251140420.19850@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.2209301109030.16823@cbobk.fhfr.pm>
References: <20220812103519.2142290-1-tero.kristo@linux.intel.com> <nycvar.YFH.7.76.2208251140420.19850@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022, Jiri Kosina wrote:

> > Add support for Universal Stylus Interface (USI) style events to the HID
> > input layers. The events are mapped as follows:
> > 
> > type	id	event
> > ----	--	-----
> > MSC(4)	6	Pen ID
> > MSC(4)	7	Pen Color
> > MSC(4)	8	Pen Line Style Ink
> > MSC(4)	9	Pen Line Style Pencil
> > MSC(4)	0xa	Pen Line Style Highlighter
> > MSC(4)	0xb	Pen Line Style Chisel Marker
> > MSC(4)	0xc	Pen Line Style Brush
> > MSC(4)	0xd	Pen No Preferred Line Style
> > ABS(3)	0x1c	Pen Line Width
> > 
> > All the listed MSC events are new, the ABS one is mapped to an existing
> > event.
> 
> Dmitry, could you please Ack the MSC_PEN_* additions?

Dmitry, friendly ping on this one.

Thanks,

-- 
Jiri Kosina
SUSE Labs

