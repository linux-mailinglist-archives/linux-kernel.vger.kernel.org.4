Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FF070EE70
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239676AbjEXGsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239481AbjEXGrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:47:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C7E1BB;
        Tue, 23 May 2023 23:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d42AHTFlpUEOeGU5jPR9+1OGQMHqlZflKmgaMdb+Sas=; b=MwxCPps7AIYBrNm23ThRPeSFhC
        C5DcQDk8QDb0J10OGerS6pvVbC2XXSobScNXP3T0adiQL/ZTAYnQKwvhIgUNlHAf0O+pSVLvqihBX
        9pPenUhaV/I2af9WBMJ1Qtqh7hPk6P0UENM4y2Z3nKZ0EJXBD+j5LW26GwVC54b2H8Uzr3xkvhucT
        g2E494/FR4dLUjMH4EA3D6RgblH2jlKE/5rjuHhm1JkSqUxKILGJTMx39Og/kp6hTcsQf5zkueNP9
        N+Kc0CaC65olQL5nEcqbGZMJuA5xzcvhJOfFdVbomC6y3LKw5YoxCxqQ+cZkpsENELgyOBvzFnvfJ
        UOgXaVEw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1iGR-00CWbv-2z;
        Wed, 24 May 2023 06:46:27 +0000
Date:   Tue, 23 May 2023 23:46:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Subject: Re: [RFC PATCH 1/4] tee: Re-enable vmalloc page support for shared
 memory
Message-ID: <ZG2yw0xZ6XGGp9E5@infradead.org>
References: <20230523091350.292221-1-arnaud.pouliquen@foss.st.com>
 <20230523091350.292221-2-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523091350.292221-2-arnaud.pouliquen@foss.st.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 11:13:47AM +0200, Arnaud Pouliquen wrote:
> This patch revert commit c83900393aa1 ("tee: Remove vmalloc page support")

As per the discussion back then: don't just blindly do the same dumb
thing again and fix the interfae to actually pass in a page array,
or iov_iter or an actually useful container that fits.

