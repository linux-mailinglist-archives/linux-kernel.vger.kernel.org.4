Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A704682623
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjAaIIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjAaIIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:08:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555863F296
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:08:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5B48B819D6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97A6C433D2;
        Tue, 31 Jan 2023 08:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675152524;
        bh=jKWBrt3PwN838DOuRlO4rmnnWiBxDiU6d5sbsZnF4Ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2exVN9rgXKV0VPPaACItUvi68DUVJeFWJiatxB+4X1ARlGxBmgDtzPja7x5zpnnH0
         ALE+gRPEAC1Y2bn2NFZC0b3gLR07bMxy7z7mUdtYq20+r1r7CXmuNIHLOaJZ/sgIvS
         RRlSIaUozy2tvODTuX6Kc7ZyHw83vmMQCP8TRpvM=
Date:   Tue, 31 Jan 2023 09:08:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: soc: remove layering violation for the
 soc_bus
Message-ID: <Y9jMiQPLaMjIvaq/@kroah.com>
References: <20230130171059.1784057-1-gregkh@linuxfoundation.org>
 <CAJZ5v0jjSoNchvdDacQjakscsSK6d535Ruqd=OR_nYz4nMNwVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jjSoNchvdDacQjakscsSK6d535Ruqd=OR_nYz4nMNwVQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 07:51:11PM +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 30, 2023 at 7:49 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > The soc_bus code pokes around in the internal bus structures assuming
> > that it "knows" if a field is not set that it has not been registered
> > yet.  That isn't a safe assumption, so just remove the layering
> > violation entirely and keep track if the bus has been registered or not
> > ourselves.
> >
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks for the quick review!
