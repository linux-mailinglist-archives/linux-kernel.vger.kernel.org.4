Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2DC605236
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 23:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiJSVrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 17:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiJSVrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 17:47:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D79190461;
        Wed, 19 Oct 2022 14:47:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96E72B825F6;
        Wed, 19 Oct 2022 21:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360ADC433D6;
        Wed, 19 Oct 2022 21:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666216033;
        bh=2aXD5vrDRaBVh3BhQ2ePbMswz4yUwVdOZh4IViQZ+34=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=J/M69iWZC5lMDu/V51xBtX5mmmQdB3O8QpKcmA0O05y942ygU3VwNIQRmnhr5loHv
         Beu93CRJqEQYuhb9lNtZIuvI56TJiSR7kYNBddnceg8iHr/ecprSrl9yJplihw2tM3
         SzCYNk96GtarBQPNdKKHEkLUJ1CtRkqR8J7do4/lVv9D6cWaW5kX6pagADAt3Oxo7k
         gf5qdzlIKFarZuoP1JSljljPk0iO5Df8bB8rTC9R1xCK9wT1ML3Z+kQHx8HcYdiR9o
         oovZx/1L/RmbkcFhxWkPgmHnYQTAmLO4TTB8LJAgUDQVUJXX86JSqnbMp+usqHOjsF
         Ne569u/0FFQhw==
Date:   Wed, 19 Oct 2022 16:47:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the pci-current
 tree
Message-ID: <20221019214711.GA48619@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020012608.20a5f3dc@canb.auug.org.au>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 01:26:08AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   22286757d2f5 ("MAINTAINERS: Update Kishon's email address in PCI endpoint subsystem")
> 
> is missing a Signed-off-by from its committer.

Sorry, fixed.
