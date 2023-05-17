Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3037B705EE0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 06:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjEQEjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 00:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjEQEi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 00:38:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FFAED;
        Tue, 16 May 2023 21:38:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 300DA641B6;
        Wed, 17 May 2023 04:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E15C433D2;
        Wed, 17 May 2023 04:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684298293;
        bh=w1ksh5SW51N7P3fxKWJSi/zCpCMqnT7dGkZo8SzmGt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s6l6PoHRe0twkKrF6TdPe/SocecPF0YoIAXzkMqlYJCsEhbY/TMJDnRj8DSNhg1Ru
         uI8+c/nZyGbkkp2q5UxvqbCV8QTf1v6hg/I4acstgmNoNpAkm4Q8ENnsjm6jZ0nJRF
         r/8MU8sq8kw+WQoXwMh8MFsoayAmrWzml0Lo+j0E=
Date:   Wed, 17 May 2023 06:38:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jon Pan-Doh <pandoh@google.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nadav Amit <namit@vmware.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sudheer Dantuluri <dantuluris@google.com>,
        Gary Zibrat <gzibrat@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Fix domain flush size when syncing iotlb
Message-ID: <2023051703-unpaired-phonebook-58e9@gregkh>
References: <20230426203256.237116-1-pandoh@google.com>
 <CAMC_AXXgBoRZOaDpCex+g_YeOdPQpKD3moQ8VMsqVEm2nqSrjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMC_AXXgBoRZOaDpCex+g_YeOdPQpKD3moQ8VMsqVEm2nqSrjg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 01:59:16PM -0700, Jon Pan-Doh wrote:
> Hi Joerg,
> 
> [Cc'ing stable@vger.kernel.org per Nadav's suggestion]

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
