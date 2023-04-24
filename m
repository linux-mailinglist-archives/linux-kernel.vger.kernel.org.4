Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021266EC8D6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjDXJ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDXJ1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:27:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F33C1B9;
        Mon, 24 Apr 2023 02:27:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16AD96114F;
        Mon, 24 Apr 2023 09:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC975C433EF;
        Mon, 24 Apr 2023 09:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682328424;
        bh=k5EFLxdU43Ba/q4bjpnDrDSYlmS54Dz/QG0RYl+piag=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K+AImau6XqqRSzDj6tj8YXT+3GQh0XEasJmRinq2+XQR2pHJfT86oeggxAWl9DAFk
         L9Qy84swN9NSpNprPRcUcg2EdJgbJRADPCaqVuP6rsSzQcIN6Kiuqn0zUwB/3VoaMi
         ell6I+QRjVbWgXN3dCAbGkJFQ9sP5WXfvOnrgJzgY5LvQWkO3OeqYEBL7Tik7pZia3
         csoc151V/u6olUIWTcgROrdEkiIdLL4LHBo+ySagt2Y49FkzId94WjOtn7hB4XXvPd
         GqPkNkSu/Q849CSaeXL848juykYbQBrToSHvcqQxzk7QeEtsM0wrvIj4QrYdoqoYiF
         UIETgdS6oTVBg==
Message-ID: <20f29b0b-b742-a3b6-921c-6946a9d7155a@kernel.org>
Date:   Mon, 24 Apr 2023 11:27:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] tools/tracing/rtla: Add .gitignore
Content-Language: en-US
To:     Rong Tao <rtoax@foxmail.com>
Cc:     rongtao@cestc.cn, Steven Rostedt <rostedt@goodmis.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:Real-time Linux Analysis (RTLA) tools" 
        <linux-trace-devel@vger.kernel.org>
References: <tencent_8042C05909979D2A1AAFA8A3028854065808@qq.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <tencent_8042C05909979D2A1AAFA8A3028854065808@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/23 14:12, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>

The patch makes sense (perf also has one), but we can improve the log.

Change the subsystem in the subject to rtla only, i.e.,

rtla: Add .gitignore file

> Ignore rtla binary.

Improve the log:

Add .gitignore file to ignore the rtla binary.
 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

Mind sending a v2?

Thanks
-- Daniel
