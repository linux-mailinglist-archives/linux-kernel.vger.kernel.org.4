Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB6865C424
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjACQoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjACQoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:44:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559AC10B7F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a0flCIyxWOCr+LTJTYsPEkamhBLOabU8sAG0uH6eo48=; b=OdWDa99J7GjSRY4P9cuooCRDN5
        LEoAeNlu+QvpMmwcMJhJ7mlBHEMf+amyT5UVJ1eudV+RuTk4LgFcxFWn4PvpGwge+ZvhrkJbAzRy5
        slCNBIZegjmuxHgQ0aZfaX4Ab1ZiD9nCIx7bl2aHWAuv/QgGiSvOqGZVqomdqP8FfP8bX/Judijol
        KGum+oMmVXBHdryKD/74S1xPL2unp7xprfyTz0jQWLaSG/L6ErsJuCuuXS/XfROTSvXNf03MXxttY
        iM5OSJbnnU5kKjqkwAos2104qcy3TKP676YtG9C9nrTzgNjQmitAbXpE/eWAwuksYM+TL7LF/+XXE
        M+Q2u1xQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pCkOV-0032u8-CE; Tue, 03 Jan 2023 16:44:07 +0000
Date:   Tue, 3 Jan 2023 08:44:07 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] test_firmware: use kernel-doc struct notation
Message-ID: <Y7RbV3mBCwTuH9IW@bombadil.infradead.org>
References: <20230102211554.25629-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102211554.25629-1-rdunlap@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 01:15:54PM -0800, Randy Dunlap wrote:
> Add "struct" to the kernel-doc notation to prevent a warning:
> 
> lib/test_firmware.c:98: warning: cannot understand function prototype: 'struct test_config '
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Russ Weight <russell.h.weight@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

 Luis
