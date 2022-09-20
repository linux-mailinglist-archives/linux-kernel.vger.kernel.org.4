Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A21E5BE8D6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiITOZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbiITOZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:25:16 -0400
X-Greylist: delayed 463 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Sep 2022 07:25:03 PDT
Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA572E9DC;
        Tue, 20 Sep 2022 07:25:03 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4MX3XF3jCKzvjfn; Tue, 20 Sep 2022 16:17:17 +0200 (CEST)
Date:   Tue, 20 Sep 2022 16:17:17 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/10] tty: serial: clean up stop-tx part in
 altera_uart_tx_chars()
Message-ID: <20220920141716.kqvtrqfyaf5e3ijq@distanz.ch>
References: <20220920052049.20507-1-jslaby@suse.cz>
 <20220920052049.20507-3-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920052049.20507-3-jslaby@suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-20 at 07:20:42 +0200, Jiri Slaby <jslaby@suse.cz> wrote:
> The "stop TX" path in altera_uart_tx_chars() is open-coded, so:
> * use uart_circ_empty() to check if the buffer is empty, and
> * when true, call altera_uart_stop_tx().
> 
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Acked-by: Tobias Klauser <tklauser@distanz.ch>
