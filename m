Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680A9628216
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbiKNOKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbiKNOKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:10:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4097A27FFA;
        Mon, 14 Nov 2022 06:10:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D251EB80EC1;
        Mon, 14 Nov 2022 14:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8349C433D7;
        Mon, 14 Nov 2022 14:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668435009;
        bh=A0ZwOggcbbyNc4CyAe2Gofgj9hJDkNUjxhYuuJas9X8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Ux0Hm9AYdG/6xj5nJqH3tGtK10oRmZkWuQVi+wFJTnRaHf1gaSo/5e6D4VVnIV3gQ
         SKSkr9z6g/PdreCsQeV9imnyxEZX043YI8GybwXIuZjI0gbF9LtMeitJiqa7WieOGN
         azqYvUqgHOA08iP4AajNiOXWn/uZ+LyBRlVVa704GNd46uxpUBrbxC7InedbihIuf2
         iMf6nGolm2WyOENv6C2RYZ8Wgxm96GTc/VPLugpgwhW5Fhx3GHqThB6940cgHs7FCd
         uQSiCZpqtu9Yg/qgGHV/SOZM5Xz6bTlLo520qqxT7FQdgYpxM5JSzAurS8WoCAv01S
         8RQlgGPBHWcdw==
Date:   Mon, 14 Nov 2022 15:10:07 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Alexander Zhang <alex@alexyzhang.dev>
cc:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        benjamin.tissoires@redhat.com, openglfreak@googlemail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] HID: uclogic: Add HID_QUIRK_HIDINPUT_FORCE quirk
In-Reply-To: <e1daf0a9-b699-affd-0d14-e46981733096@alexyzhang.dev>
Message-ID: <nycvar.YFH.7.76.2211141509340.6045@cbobk.fhfr.pm>
References: <20221110174056.393697-1-jose.exposito89@gmail.com> <e1daf0a9-b699-affd-0d14-e46981733096@alexyzhang.dev>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022, Alexander Zhang wrote:

> Hi José,
> 
> On 11/10/22 9:40 AM, José Expósito wrote:
> > Hi everyone,
> > 
> > About 3 months ago, Torge Matthies sent a patch fixing an issue with
> > his XP-Pen Star G640 [1].
> > 
> > His patch changes the IS_INPUT_APPLICATION() macro to accept
> > HID_DG_DIGITIZER. However, it looks like it is not being merged because
> > of the possible side effects that changing that macro could generate.
> > 
> > This patch aims to fix the same issue but using a more conservative
> > approach hoping that the bug can be fixed.
> > 
> > Torge, Alexander, could you test it and confirm that it fixes your
> > issues, please?
> 
> I tested the patch on commit 4bbf3422df78 and it fixes the issue.

I will add

	Tested-by: Alexander Zhang <alex@alexyzhang.dev>

to the commit; please speak up if you disagree.

Thanks,

-- 
Jiri Kosina
SUSE Labs

