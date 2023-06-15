Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D193B732010
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238460AbjFOScC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbjFOSbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:31:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48653C06
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 11:30:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12E36622FF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 18:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CF9C433C8;
        Thu, 15 Jun 2023 18:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686853820;
        bh=IWpeb4Kgm1UamkNtsT5+DO7vNDUGgUuD0Dyst6XKCz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iTmnYVDX+9wbjvHsbaVRPyrv7MPXOPRDHzBhk9XOtcxMnlW9qUfRnHR6k5Wt3ToGj
         i0n8EumMCCHjTpq7p2c0CT33nIZnNnjJvinpRpaZEGtYA2OWoE1iFypxj+ksGr2jnh
         YsIvrP6/vk9xb2bPZ+XHmNmZvDCpWdpPBL8vHgNtZ5TUOAYja2UfEE8VsTnx6Dyvpy
         oeuxHmKCgDLYCAPP3PYqtrtlUO8hEexjRAu6Z3FJIH345Jw7DhXeuyl/i0yfnINOY7
         EgDX8QB9/b5KlWReXOCgYvYIBohwpl4MWc8evhDJAhAbZQcDCzUZwYctnAdQaRWn/D
         NOzgh+NknLiJw==
Date:   Thu, 15 Jun 2023 12:30:17 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, leit@fb.com,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: Print capabilities changes just once
Message-ID: <ZItYuVb1vKk9qfX/@kbusch-mbp.dhcp.thefacebook.com>
References: <20230615094903.1341683-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615094903.1341683-1-leitao@debian.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 02:49:03AM -0700, Breno Leitao wrote:
> This current dev_info() could be very verbose and being printed very
> frequently depending on some userspace application sending some specific
> commands.
> 
> Just print this message once and skip it until the controller resets.
> Use a controller flag (NVME_CTRL_DIRTY_CAPABILITY) to track if the
> capability needs a reset.

Looks good. 

Reviewed-by: Keith Busch <kbusch@kernel.org>
