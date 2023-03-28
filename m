Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DE36CCE4A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjC1Xzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC1Xzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:55:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A4B358E;
        Tue, 28 Mar 2023 16:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rtJmnD9ytlTTdxPaOkCDznxdiLFcYeJDIfpjb5h5E/E=; b=zu9PDgwdRqrV2YoOo9laHyuQMC
        5RYGvcIyWES9m3fhC1Ow5BYGsZb2lOLtv2LQqMoPPYTciDMGBcRFEtk913+KDKh8bd9qAVNBLdx3i
        is/AWmmaJR6+r4ByX09e3wLmeuaGAxdYaoaOU6tKNIHVmrBxhLriv77vRrkfkvHAAfOGY6DuADvtI
        PJyXkkyupRtp/JNS7mu+w4U3yvoElQ1W+pNRMKIYqaknEdjsD6XU8bcqYYZGo+SZ5RS+WxPlXDKZg
        84zohIj+vJ3DTzKYUcJJ4n08/rES79mSrFo7pOHBD7UDwkW56/pqC2I9TQPcISh5AP4JwU4FtNd9P
        KYxEjarg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phJ9E-00G9Sx-2y;
        Tue, 28 Mar 2023 23:54:40 +0000
Date:   Tue, 28 Mar 2023 16:54:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mingyi Cong <congmingyi@gmail.com>
Cc:     linkinjeon@kernel.org, senozhatsky@chromium.org, sfrench@samba.org,
        tom@talpey.com, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: Re: [PATCH v3] fs: add the tuncate check of exfat
Message-ID: <ZCN+QKokEYfGWzq6@infradead.org>
References: <CAKYAXd8GzB_onCcs=2aZs0MGTy_7oGhECEdr+rcdVS+Jf2C5xQ@mail.gmail.com>
 <20230328131334.5572-1-congmingyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328131334.5572-1-congmingyi@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NAK again.  You must not hardcode file syste magic numbers in
consumers of vfs API.  Not the existing one, and absolutelt not
a new one.  I told you a few times what to do but you keep ignoring it.
