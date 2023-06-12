Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E584072D4F8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 01:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbjFLXcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 19:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjFLXcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 19:32:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8589710CC;
        Mon, 12 Jun 2023 16:32:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2DA961048;
        Mon, 12 Jun 2023 23:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D421C433D2;
        Mon, 12 Jun 2023 23:32:01 +0000 (UTC)
Date:   Mon, 12 Jun 2023 19:31:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Yonghong Song <yhs@meta.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Jackie Liu <liu.yun@linux.dev>
Subject: Re: [PATCHv2] ftrace: Show all functions with addresses in
 available_filter_functions_addrs
Message-ID: <20230612193159.2b3d81ff@gandalf.local.home>
In-Reply-To: <CAEf4Bza+n3sTUuuseZA19PQG2GN6bLezu_gdUqU6mnHfPA77xg@mail.gmail.com>
References: <20230611130029.1202298-1-jolsa@kernel.org>
        <53a11f31-256d-e7bc-eca5-597571076dc5@meta.com>
        <20230611225407.3e9b8ad2@gandalf.local.home>
        <20230611225754.01350a50@gandalf.local.home>
        <d5ffd64c-65b7-e28c-b8ee-0d2ff9dcd78b@meta.com>
        <20230612110222.50c254f3@gandalf.local.home>
        <ZId/UL/iujOdgel+@krava>
        <CAEf4Bza+n3sTUuuseZA19PQG2GN6bLezu_gdUqU6mnHfPA77xg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2023 16:28:49 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:


> If Steven would be ok with it, can we land this change through the
> bpf-next tree? Then we can have BPF selftest added in the same patch
> set that parses a new file and uses bpf_program__attach_kprobe_multi()
> to attach using explicit addresses.
> 
> This should make it clear to everyone how this is meant to be used and
> will be a good test that everything works end-to-end.
> 

This touches some of the code I'm working with, so I rather have it be in
my tree.

-- Steve
