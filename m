Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085C96B3834
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjCJIK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjCJIKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:10:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD3B61AB4;
        Fri, 10 Mar 2023 00:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mpITJ4Nl7x5vVIbFIcOw20XFdkPGouMW+7WyYlYEXIE=; b=iY+rchdoXBw/mcd+sv6Tdc/2vw
        l0y0tl65oL4OhOozZ02UQMIORVSI5OYsywa1qZm8dsB4MD7alS6B7zWn5n5IL4u487/aMaRIZbEKh
        bF9aQdEDZ93NOMpDixImOcQXI/1ONc5wQrNL0vEMIPqD1zV/4B5qlh0uJtEHcN8vNgVtjkocsKsAr
        tlYkKAwCP+16zo9Ps5VXsZA8EYa12jFiaiT/zaUdX5t8I+dmJ+17el+RWjfzyHlbUG86O5lAV7Vdi
        iX9q3xQVgYfuDIDXt3orN7EgVlqaTVCxEORtkNsXOw+jsAK+aNMA+ee7yFChty90+R23nOeVnXfq6
        z687JK2Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paXot-00DYSu-HZ; Fri, 10 Mar 2023 08:09:43 +0000
Date:   Fri, 10 Mar 2023 00:09:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     John Moon <quic_johmoo@quicinc.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        kernel-team@android.com, libabigail@sourceware.org,
        Jordan Crouse <jorcrous@amazon.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v2 0/2] Validating UAPI backwards compatibility
Message-ID: <ZArlx5wrw+ZQWUg4@infradead.org>
References: <20230301075402.4578-1-quic_johmoo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301075402.4578-1-quic_johmoo@quicinc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 11:54:00PM -0800, John Moon wrote:
> Our goal is to add tooling for vendor driver developers because the
> upstream model of expert maintainer code review can be difficult to
> replicate in-house. Tools may help developers catch simple UAPI
> incompatibilities that could be easily overlooked by in-house review.

Why would this matter in any way for the kernel?  If you tool is useful
for in-kernel usage it should be added to the tree and documented as
such, but ouf of tree crap simply does not matter.
