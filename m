Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F4968AD5F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 00:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjBDXN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 18:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjBDXNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 18:13:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16664CA0A
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 15:13:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0157F60ABA
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 23:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF640C433D2;
        Sat,  4 Feb 2023 23:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1675552403;
        bh=pBdB8hoQrwGnSH3X2xAtmORaPtQ7MV2YibXgEgK131A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=adEsh79gNWOLUWfY+NTZmh/cmBptRH9/Fe5WwYJ/YByQB76RUoS3ecf/yTsZbgsSg
         +qwWGVA20W6zVX4TzfyMyp4W7W75XEn6VUZ+rI58PbwEX9oSR6+ltITNNSoiv5Ftwp
         Wpmjgh7FcNb6AKe2oFUDSWPJBfnObvYvECTabhWo=
Date:   Sat, 4 Feb 2023 15:13:22 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, urezki@gmail.com,
        lstoakes@gmail.com, willy@infradead.org, hch@infradead.org,
        error27@gmail.com
Subject: Re: [PATCH v4 0/7] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-Id: <20230204151322.7b3d10ea11c3f4ca0a93db23@linux-foundation.org>
In-Reply-To: <Y93bGLwIROQB3Yfs@MiWiFi-R3L-srv>
References: <20230201091339.61761-1-bhe@redhat.com>
        <87357o7yeh.fsf@oracle.com>
        <Y93bGLwIROQB3Yfs@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Feb 2023 12:12:08 +0800 Baoquan He <bhe@redhat.com> wrote:

> > So this definitely still resolves the originally reported issue. Feel
> > free to add, if you want:
> > 
> > Tested-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> 
> I noticed Andrew had picked this v4 into his mm tree, maybe Andrew can
> help add this Tested-by tag.

I dropped this series and am now unable to locate a fix which addressed
the issue which Stephen hit.

Please send a v5?
