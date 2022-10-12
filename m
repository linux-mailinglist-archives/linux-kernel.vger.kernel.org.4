Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B9D5FCC23
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJLUig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJLUic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:38:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81788FF23C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:38:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CC35615D8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 20:38:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D06FC43470;
        Wed, 12 Oct 2022 20:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665607110;
        bh=DG8g20nqjVyIF42QWundT2xxlwghAmgeI8y8I8RlbPU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=npr9gve0Iz4P1YMNtkCy7pwTVid2LPYOyB+Gu+u2hQ9D9Z0LSWmXpKjPUx1DBKb80
         MIExovAq0QqmHLalNyiiwlsQxgfltzFrdFqLPNowHA3ldM7KCY5bwTijKurQ/PVf6i
         +JOYw1Z9XGJkprre4E0lUYiAjInf3SaF/8D6fUbQBJvFF333jJbojIn5El8OuAJ1Nh
         lU4l5bKB6M0RbinZ9n85Bt4TFYsWpQOcIoLbwCgYpDNNjdEvaLYlBDwd6UELouHOaw
         06j8ZbQI1dLEdgqit30pC0cl42+OT8gyCZ89FwF8g1+k2Tahh5KLTioElO8Q/3aRbY
         820U7PJQz6lxQ==
Date:   Wed, 12 Oct 2022 15:38:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-um@lists.infradead.org
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um-owner@lists.infradead.org, linux-kernel@vger.kernel.org,
        helpdesk@kernel.org
Subject: Re: Add linux-um archives to lore.kernel.org?
Message-ID: <20221012203828.GA3117920@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012191142.GA3109265@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 02:11:44PM -0500, Bjorn Helgaas wrote:
> https://korg.docs.kernel.org/lore.html says pipermail archives like
> infradead has are not ideal, but I don't have any archives at all, and
> I don't know how to get even pipermail archives out of infradead.

FWIW, here's a link to pipermail "archives" downloaded with:
  wget -r -np -l 1 -n d -A gz http://lists.infradead.org/pipermail/$LIST/
  tar cf $LIST.tar $LIST
  xz -9 $LIST.tar

https://drive.google.com/file/d/1zS5kricACvwhoCvmZcMSvNRHp-9PHGjd/view?usp=sharing
