Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4643B5FCC22
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJLUhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJLUhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:37:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A61102DFD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:37:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31F79B81BDB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 20:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89D9C433B5;
        Wed, 12 Oct 2022 20:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665607060;
        bh=7T8DnsM2jTkvuDCMOi69V6WS2i1G04kiGK/u/bEqPJY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mcaJWqsem/2sjBUt5BiSuolWeFAq1QZWumniJ7DQfAa2ly1Kuq/4MTRKYyPKGy1aS
         fpwOrhaTn/Z8yXsRgFhmPrDaLRD+md5Qhu5GNfHwGKXZvqXph3o1dM/Bv1uwn2nDY5
         uIxi7LXTshi2vvsmnuSdr3n4Gzqt7KGx5BmafuTdJdUGoGtokauU2jwhg7ASnReLQq
         DbvNRe2nNOrrchdYE0/Hw9NBp3zAkICp/0lgfPMAU+80Ql/LiQaplQKVQcBnsOx8UQ
         86W6yf94z4Fff1EaTTwpYRnVYQfTcAecx51U+ft9uDGrydK40gZ3HURgQGKcJyqyq9
         s7/F1ATKLIdOA==
Date:   Wed, 12 Oct 2022 15:37:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-rpi-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel-owner@lists.infradead.org,
        linux-kernel@vger.kernel.org, helpdesk@kernel.org
Subject: Re: Add linux-rpi-kernel archives to lore.kernel.org?
Message-ID: <20221012203738.GA3117842@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012191128.GA3108607@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 02:11:30PM -0500, Bjorn Helgaas wrote:
> https://korg.docs.kernel.org/lore.html says pipermail archives like
> infradead has are not ideal, but I don't have any archives at all, and
> I don't know how to get even pipermail archives out of infradead.

FWIW, here's a link to pipermail "archives" downloaded with:
  wget -r -np -l 1 -n d -A gz http://lists.infradead.org/pipermail/$LIST/
  tar cf $LIST.tar $LIST
  xz -9 $LIST.tar

https://drive.google.com/file/d/17-xaZ3kqA4jJi7d_PqW_rIOTzHR4EbLP/view?usp=sharing
