Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181DE7401F9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjF0RSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjF0RSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:18:32 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E611FEB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:18:30 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id CAE6D8C3F3;
        Tue, 27 Jun 2023 19:18:27 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1687886308; bh=6gFDNhhGJv90UdgxcbzryDH6ZG6dLvIYFXDAuTPtvSU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bySKOQZltr9ohomUzM2aa5V74hK2GS3Z0zDb44uDmzzs/QvDRuAyvfkpp/sqmUsbo
         TYNOTc/GZ87znxp5/6S40uTgA1tFep572/XZFIr4a0dvnpFyyemllCPFmTL8ejWTBR
         jtihWMAS44zGXF3GRLhcBphwoEtpIHavdX+JxLcjBcAgrze60nJp9hzy2wm/xMLv2W
         f3DxfaFhc3IY3NIsJPaGj3Z1shXXSEaD9AOnCOuEnsKIDh9ZxDEfwP+mpg5g+evpr2
         SvnstvX48os/E5D1n8oEawxiBdrFV1sIno0QU0c2fjDy6lmqnnEG5s2xs8if27cr6c
         HuelAtwFx36+A==
Date:   Tue, 27 Jun 2023 19:18:26 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: unexport swiotlb_active v2
Message-ID: <20230627191826.41aba02e@meshulam.tesarici.cz>
In-Reply-To: <20230619091941.GA17034@lst.de>
References: <20230612142542.111581-1-hch@lst.de>
        <20230619091941.GA17034@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2023 11:19:41 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Any comments?  I'd really like to finish this off this merge window..

Let me second this request. My dynamic SWIOTLB patch series also has a
dependence on this.

Petr T
