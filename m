Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAE87012D2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241037AbjELX56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240779AbjELX5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:57:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE9A86B5;
        Fri, 12 May 2023 16:57:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4396E658CC;
        Fri, 12 May 2023 23:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649FEC433EF;
        Fri, 12 May 2023 23:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683935817;
        bh=LDope8vqn+neA/rDW2moCG3E8yWqZ25lWX/JxB2rRzk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lDHj+azcmIO60UO9bdbkWgvYVD8N4mStTz/Qeuugs+cS/payHc9iXXKjJsu5kaAUn
         mBA5CeJz0amNXhHu7+UcuRJP3niL6ElC6wVotRBbiTlMjs6A9jZSenmorVLTot72KQ
         uHA3arEEP7m9jVUGVhvZ5DQj367hvgT/m9PSfkQg=
Date:   Fri, 12 May 2023 16:56:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-mm@kvack.org, Conor Dooley <conor.dooley@microchip.com>,
        Support Opensource <support.opensource@diasemi.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: repair pattern in DIALOG SEMICONDUCTOR
 DRIVERS
Message-Id: <20230512165656.885a774fe3f69f54fcc45cd0@linux-foundation.org>
In-Reply-To: <20230509074834.21521-1-lukas.bulwahn@gmail.com>
References: <20230509074834.21521-1-lukas.bulwahn@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 May 2023 09:48:34 +0200 Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit 441613662db7 ("dt-bindings: mfd: Convert da9063 to yaml") converts
> da9063.txt to dlg,da9063.yaml and adds a new file pattern in MAINTAINERS.
> Unfortunately, the file pattern matches da90*.yaml, but the yaml file is
> prefixed with dlg,da90.

I'm seeing a different hash:
361104b05684c ("dt-bindings: mfd: Convert da9063 to yaml")


