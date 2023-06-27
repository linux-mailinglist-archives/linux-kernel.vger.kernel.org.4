Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A7F740253
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjF0RhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjF0RhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:37:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2418326BC;
        Tue, 27 Jun 2023 10:37:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83A5561187;
        Tue, 27 Jun 2023 17:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D3EC433C0;
        Tue, 27 Jun 2023 17:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687887431;
        bh=FL7KdQftpO5+h0m0SE4ZRuvEs5I4cL4AhQXWy+kzrIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Dm6R+2Y4+2ZgUJSAMjaAzBUDzy7QLUfNJ6BV/dvJR3i/PeWB1UOaeXxSTl35fmdK
         MjpHWC9J1dMR9Nt7bt04N3q6z/JYkzqrnwjvmWM1EEYrsGiCKnetXsw+xwL3aXKzob
         AE6y+7ebUrqXx2xnoHMmV8FCHJQS1HYgIIhSQMCM=
Date:   Tue, 27 Jun 2023 19:37:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yuxiao Zhang <yuxiaozh.zhang@gmail.com>
Cc:     keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        linux-hardening@vger.kernel.org,
        William Kennington <wak@google.com>,
        linux-kernel@vger.kernel.org, Yuxiao Zhang <yuxiaozhang@google.com>
Subject: Re: support pmsg record size larger than kmalloc limitation
Message-ID: <2023062749-choosy-lid-db16@gregkh>
References: <CAOOoKeQ=b4u1C_FZ-OFHSfVt5Z9xw1KtpJ4316zubt46Tny41Q@mail.gmail.com>
 <2023062715-eldercare-washed-3c29@gregkh>
 <CAOOoKeSxJzJEwX2aVsn_jcqK7gsgEVpB3VdhoKjJPCJgdNf9Mg@mail.gmail.com>
 <A82AEA54-16EC-4965-B024-D4D47C200D9D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A82AEA54-16EC-4965-B024-D4D47C200D9D@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 10:31:23AM -0700, Yuxiao Zhang wrote:
> Sorry about that, seems gmail doesn’t play well with tabs. Resending the patch:

You sent this in html format, still impossible to apply and the mailing
lists reject :(

