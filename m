Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EFF5FCC20
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiJLUhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiJLUhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:37:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924C1FF231
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:37:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C8C5CCE1D70
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 20:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3873C433C1;
        Wed, 12 Oct 2022 20:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665607027;
        bh=OAANAqtBWrLLKwkNLiw50JdkfDaNrebnLc4doZn6uu8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nZnJkaTdcqgiyicGiYR3orX5Ss19q5GoiryCni+/fNnGkCMhGQLXt7Xop9ZAy/LfM
         bJtS1G5HgRps2ELDPkDNWOWCAM7vFKa4PSIY5wRmzZiKbLVTOoVUgD0wNet59u4oV7
         3Mu67cvQawknl334XIB8A+2hy1Ngnj/+nmorcTNu5Cczh9BSaC0b2rtBRQW+cfybc0
         V5SYY208S6hBiLMaK2qHrtaTTIvrOgtDS6cMeKtlhMM2QL9UqzfYetd3YNTBz37n0h
         K9t62N+fsSoSLZjV3N5FEbK98ihDfCRJRX0oTxhLtHmCZP5w2h6/nrAS2cJKL3QtfP
         c1PwbMO+b8KWA==
Date:   Wed, 12 Oct 2022 15:37:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-parport@lists.infradead.org
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Tim Waugh <tim@cyberelk.net>,
        linux-parport-owner@lists.infradead.org,
        linux-kernel@vger.kernel.org, helpdesk@kernel.org
Subject: Re: Add linux-parport archives to lore.kernel.org?
Message-ID: <20221012203705.GA3117743@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012191201.GA3107702@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 02:12:03PM -0500, Bjorn Helgaas wrote:
> The linux-parport@lists.infradead.org mailing list is listed in
> MAINTAINERS.  There's not much current activity [1], but I suspect
> there's some useful history that we might want to preserve.
> 
> Should we add linux-parport to the lore.kernel.org archives?
> 
> https://korg.docs.kernel.org/lore.html says pipermail archives like
> infradead has are not ideal, but I don't have any archives at all, and
> I don't know how to get even pipermail archives out of infradead.

FWIW, here's a link to pipermail "archives" downloaded with:
  wget -r -np -l 1 -n d -A gz http://lists.infradead.org/pipermail/$LIST/
  tar cf $LIST.tar $LIST
  xz -9 $LIST.tar

https://drive.google.com/file/d/1rS8r7M0fs18k6ehdLp9cgwYMPZIhCRKI/view?usp=sharing
