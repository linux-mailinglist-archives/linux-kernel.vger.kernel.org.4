Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2901E602CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiJRN1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiJRN1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:27:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D1A6C763
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:26:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C28B3B81F3A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35B5C433C1;
        Tue, 18 Oct 2022 13:26:40 +0000 (UTC)
Date:   Tue, 18 Oct 2022 09:26:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     sunliming <sunliming@kylinos.cn>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        kelulanainsley@gmail.com
Subject: Re: [PATCH 4/5] tracing: Delete timestamp_mode trace file
Message-ID: <20221018092641.0cdfd3be@gandalf.local.home>
In-Reply-To: <20221018120056.1321426-5-sunliming@kylinos.cn>
References: <20221018120056.1321426-1-sunliming@kylinos.cn>
        <20221018120056.1321426-5-sunliming@kylinos.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 20:00:55 +0800
sunliming <sunliming@kylinos.cn> wrote:

> The timestamp_mode trace file is not necessary duo to the removing of
> the absolute timestamp.

This is user space exposed API. Which means we do not just simply "remove
it". This file is the reason I kept the absolute timestamps around in the
first place. Because user space may want them.

How do you know that user space isn't using this? Is there something else
you are planning on adding that makes taking the risk we might break user
space worth while?

-- Steve
