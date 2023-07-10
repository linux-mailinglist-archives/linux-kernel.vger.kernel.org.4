Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4725C74DE45
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjGJTd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjGJTdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:33:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D64BC;
        Mon, 10 Jul 2023 12:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=KJl6xBiueEAkIKarvHIBEAsPNJcVrx9T6j5N5ztqHmI=; b=nAv4PnLMR9ljIg3pN8qz2+SZdQ
        GnmTnnxMRnlYcmbRvgD7WPnmwyeQ4fMQnm+EY8Y6E1cwAHCeDQTgFZnMBBUayjjVcqu8G4XOKbqY4
        qG9CSjIIsy7WAo4JDGM39MqIcah9cXtT7z+LFQqr5lXwqrUcXJDIp682dmFSR0+trTl45YLmSV4It
        OwnqWnkVje/HfFzgPdF9KKgtM/RNRpgMXde0XpXcU/k3VkvBUYrIvQ4EB4jxWAOMmYCgyxC7HilZF
        yNMeLg6Atw9GM0f/mr03zdv7JF/iQBoCJAzfmt/341pm/mEKlEHpDQ+NTwFVM5p5vZCE6vLz4q36F
        b5tRrv4Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qIwdA-00CZRB-2M;
        Mon, 10 Jul 2023 19:33:08 +0000
Date:   Mon, 10 Jul 2023 12:33:08 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dyndbg: add source filename to prefix
Message-ID: <ZKxc9BiZIS5GHmV9@bombadil.infradead.org>
References: <20230709-dyndbg-filename-v2-0-fd83beef0925@weissschuh.net>
 <20230709-dyndbg-filename-v2-3-fd83beef0925@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230709-dyndbg-filename-v2-3-fd83beef0925@weissschuh.net>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2023 at 11:18:00PM +0200, Thomas Weiﬂschuh wrote:
> Printing the line number without the file is of limited usefulness.
> 
> Knowing the filename also makes it also easier to relate the logged
> information to the controlfile.
> 
> Example:
> 
>     # modprobe test_dynamic_debug
>     # echo 'file test_dynamic_debug.c =pfsl' > /proc/dynamic_debug/control
>     # echo 1 > /sys/module/test_dynamic_debug/parameters/do_prints
>     # dmesg | tail -2
>     [   71.802212] do_cats:lib/test_dynamic_debug.c:103: test_dd: doing categories
>     [   71.802227] do_levels:lib/test_dynamic_debug.c:123: test_dd: doing levels
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> Acked-by: Jim Cromie <jim.cromie@gmail.com>
> Acked-by: Jason Baron <jbaron@akamai.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
