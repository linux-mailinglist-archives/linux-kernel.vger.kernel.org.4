Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A326F8473
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjEEOC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 10:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjEEOC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:02:56 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A93511B74
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 07:02:55 -0700 (PDT)
Received: from 8bytes.org (p5b006afb.dip0.t-ipconnect.de [91.0.106.251])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 433C42468FF;
        Fri,  5 May 2023 16:02:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1683295374;
        bh=Tkvn0TT1/p5mQrYzhfVH1AvgtScimuSQ1GpFVP+ruFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rBo3F8XeAw2w910wadAemnbY4gdJvJze0TJfI0aekScvDPjg9Wbrx0zNil03dFFJA
         OFsdy+1Li2va+G5vTPZ+Nv0EmvHtdFXAyrSh8lZryP/iiLbVSEkF5BgbnAzFn39Tko
         VGMuvo7yahVqq6iDPdOSAP34QKvhJRN78+odzu7L7dOdvIuHEkVXR7hH7adaUghDog
         QKHILAaG2qT7TMVXmG6W4WrL2+yLvKlOPr6LuH/5Uz/50oWDrJRI3yfCwnuU84xy40
         mgwqec4X/K8y/9H123I+PbljM1jL2J9FhdzlOJB0YYjPrmiRdOzqsRF47rRudOAzCh
         2EuAuUza2qW5w==
Date:   Fri, 5 May 2023 16:02:53 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [git pull] IOMMU Updates for Linux v6.4
Message-ID: <ZFUMja5MpRPWCRXw@8bytes.org>
References: <ZE5NR5Ml8I2/Ze0f@8bytes.org>
 <CAHk-=wiriLmq6OgLLF9seANqCJqjCrgUC384zcJUFtv3xJgVkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiriLmq6OgLLF9seANqCJqjCrgUC384zcJUFtv3xJgVkQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sun, Apr 30, 2023 at 01:07:45PM -0700, Linus Torvalds wrote:
> Anyway, I'm not super-happy with how this all turned out. The example
> merge seems to be wrong, and the Kconfig situation is confusing.

You are right, looks like I missed some context when doing my example
merge, sorry for that. I will take more care next time.

Regards,

	Joerg
